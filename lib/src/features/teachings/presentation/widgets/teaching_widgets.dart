import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/i18n/strings.g.dart';
import '../../../../core/network/app_exception_message.dart';
import '../../../../core/services/media_images.dart';
import '../../../../core/services/premium_store.dart';
import '../../../../core/services/share_service.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_icons.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_tones.dart';
import '../../../../core/utils/date_format.dart';
import '../../../../core/widgets/adaptive.dart';
import '../../../../core/widgets/app_toast.dart';
import '../../../../routing/app_router.dart';
import '../../application/listening.dart';
import '../../application/now_playing.dart';
import '../../application/teaching_library.dart';
import '../../domain/play_queue.dart';
import '../../domain/teaching.dart';
import '../../infrastructure/teaching_files.dart';

/// The cover sent by the admins, else night blue with headphones in gold.
class TeachingCover extends ConsumerWidget {
  const TeachingCover({required this.teaching, required this.size, super.key});

  final Teaching teaching;
  final double size;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cover = teaching.cover;
    final radius = BorderRadius.circular(size > 100 ? AppRadius.xxl : 12);
    final placeholder = DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: radius,
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.primary, AppColors.primaryDeep],
        ),
      ),
      child: Center(
        child: Icon(
          AppIcons.teachingsTile,
          color: AppColors.goldLight,
          size: size * 0.45,
        ),
      ),
    );
    return SizedBox.square(
      dimension: size,
      child: cover == null
          ? placeholder
          : ClipRRect(
              borderRadius: radius,
              child: ColoredBox(
                color: Color(cover.argb ?? AppColors.primaryDeep.toARGB32()),
                child: Image(
                  image: ref.watch(mediaImagesProvider).of(cover.url),
                  fit: BoxFit.cover,
                  errorBuilder: (_, _, _) => placeholder,
                ),
              ),
            ),
    );
  }
}

/// "Pr Fomum · 15 août 1994 · 52:10".
String teachingFacts(BuildContext context, Teaching teaching) => [
  if (teaching.speaker.isNotEmpty) teaching.speaker,
  if (teaching.recordedDay case final day?)
    context.formatDate(day, 'd MMM yyyy'),
  if (teaching.duration case final duration?) formatClock(duration),
].join(' · ');

/// The list the rows under it belong to: a message played from one of them
/// is followed by the rest of that list.
class TeachingSequence extends InheritedWidget {
  const TeachingSequence({required this.list, required super.child, super.key});

  final TeachingList list;

  static TeachingList? maybeOf(BuildContext context) =>
      context.getInheritedWidgetOfExactType<TeachingSequence>()?.list;

  // read at the tap, never watched
  @override
  bool updateShouldNotify(TeachingSequence oldWidget) => false;
}

/// Opens the player on [teaching], playing; what follows it is [among],
/// else the list its row is in ([TeachingSequence]).
Future<void> openTeaching(
  BuildContext context,
  WidgetRef ref,
  Teaching teaching, {
  TeachingList? among,
}) async {
  final toast = ref.read(toasterProvider).of(context);
  final messages = context.t;
  final list = among ?? TeachingSequence.maybeOf(context);
  unawaited(context.router.push(const TeachingPlayerRoute()));
  try {
    await ref.read(listeningProvider.notifier).start(teaching, among: list);
  } on Object catch (error) {
    toast.error(userMessageFor(error, messages));
  }
}

/// "Jour 1_2 croisade de prière et de jeûne 2026", a title the admins left
/// as the file's name.
final _fileTitle = RegExp(
  r'^\s*jour\s*(\d+)\s*[_.\-]\s*(\d+)\b',
  caseSensitive: false,
);

/// The title to show: "Jour 1, message 2" for a file's name, the admins'
/// own titles ("La prière qui persévère") as they are.
String teachingTitle(BuildContext context, Teaching teaching) {
  final match = _fileTitle.firstMatch(teaching.title);
  if (match == null) {
    return teaching.title;
  }
  return context.t.teachings.dayMessage(
    day: int.parse(match[1]!),
    n: int.parse(match[2]!),
  );
}

/// "17 min", "1 h 05": a length to read, not a clock.
String durationLabel(BuildContext context, Duration duration) {
  final t = context.t.teachings;
  final minutes = (duration.inSeconds / 60).ceil().clamp(1, 1 << 30);
  if (minutes < 60) {
    return t.minutes(n: minutes);
  }
  return t.hoursMinutes(
    h: minutes ~/ 60,
    m: (minutes % 60).toString().padLeft(2, '0'),
  );
}

/// A teaching as an episode: a line above (the edition and the day, or the
/// day and the speaker inside an edition), the title, a line of what it is
/// about, then ▶ and its length (what is left once begun, « Écouté » once
/// heard), the share and the cloud. A tap plays it.
class TeachingRow extends ConsumerWidget {
  const TeachingRow({
    required this.teaching,
    this.inEdition = false,
    super.key,
  });

  final Teaching teaching;

  /// Shown under its edition's card: the edition is not said again.
  final bool inEdition;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t.teachings;
    final scheme = Theme.of(context).colorScheme;
    final edition = teaching.edition;
    final day = teaching.recordedDay;
    final over = [
      if (!inEdition)
        if (edition != null && edition.title.isNotEmpty)
          edition.title
        else if (teaching.category.isNotEmpty)
          teaching.category,
      if (day != null) context.formatDate(day, 'EEE d MMM'),
      if (inEdition && teaching.speaker.isNotEmpty) teaching.speaker,
    ].join(' · ');
    final about = [
      if (!inEdition && teaching.speaker.isNotEmpty) teaching.speaker,
      if (teaching.description.isNotEmpty) teaching.description,
    ].join(' · ');

    return InkWell(
      onTap: () => openTeaching(context, ref, teaching),
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(16, 14, 6, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (over.isNotEmpty)
              Padding(
                padding: const EdgeInsetsDirectional.only(end: 10),
                child: Text(
                  over.toUpperCase(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                    color: scheme.onSurfaceVariant,
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsetsDirectional.only(top: 3, end: 10),
              child: Semantics(
                hint: t.play,
                child: Text(
                  teachingTitle(context, teaching),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 15.5,
                    height: 1.25,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            if (about.isNotEmpty)
              Padding(
                padding: const EdgeInsetsDirectional.only(top: 3, end: 10),
                child: Text(
                  about,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 13,
                    color: scheme.onSurfaceVariant,
                  ),
                ),
              ),
            const SizedBox(height: 8),
            // the buttons tight, the row no taller than the pill
            IconButtonTheme(
              data: IconButtonThemeData(
                style: IconButton.styleFrom(
                  visualDensity: VisualDensity.compact,
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: _ListenPill(teaching: teaching),
                    ),
                  ),
                  ShareTeachingButton(teaching: teaching),
                  DownloadButton(teaching: teaching),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// The gold of a message begun, dark enough to read on its pale pill.
const _goldInk = Color(0xFF8A5A0B);

/// ▶ and the length; « Reste 12 min » and a gold bar once begun; « En
/// cours » while it plays; « Écouté » beside it once heard. A tap plays it
/// (or pauses the one playing).
class _ListenPill extends ConsumerWidget {
  const _ListenPill({required this.teaching});

  final Teaching teaching;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t.teachings;
    final progress = ref.watch(teachingProgressProvider.notifier);
    final listened = ref.watch(teachingProgressProvider)[teaching.id];
    final finished = progress.finished(teaching.id);
    final heard = progress.fraction(teaching.id);
    final now = ref.watch(
      nowPlayingProvider.select(
        (now) => now.teaching?.id == teaching.id
            ? (playing: now.playing, on: true)
            : (playing: false, on: false),
      ),
    );
    // heard to the end and stopped: « Écouté », no longer « En cours »
    final on = now.on && (now.playing || !finished);
    final begun = !finished && heard > 0 && !on;
    final length =
        teaching.duration ??
        (listened == null || listened.duration <= 0
            ? null
            : Duration(seconds: listened.duration));

    final String label;
    if (on) {
      label = t.nowPlaying;
    } else if (begun && length != null && listened != null) {
      label = t.left(
        time: durationLabel(
          context,
          length - Duration(seconds: listened.position),
        ),
      );
    } else if (length != null) {
      label = durationLabel(context, length);
    } else {
      label = t.play;
    }
    final background = begun ? AppColors.gold.withValues(alpha: 0.18) : null;
    final tone = AppModule.reports.tone(context);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: Material(
            color: background ?? tone.soft,
            shape: const StadiumBorder(),
            child: InkWell(
              customBorder: const StadiumBorder(),
              onTap: on
                  ? ref.read(nowPlayingProvider.notifier).toggle
                  : () => openTeaching(context, ref, teaching),
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(6, 5, 12, 5),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: begun ? AppColors.gold : tone.onSoft,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        now.playing ? AppIcons.pause : AppIcons.play,
                        size: 12,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 7),
                    Flexible(
                      child: Text(
                        label,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: begun ? _goldInk : tone.onSoft,
                          fontFeatures: const [FontFeature.tabularFigures()],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        if (begun) ...[
          const SizedBox(width: 10),
          SizedBox(
            width: 44,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: heard,
                minHeight: 4,
                color: AppColors.gold,
                backgroundColor: AppColors.gold.withValues(alpha: 0.25),
              ),
            ),
          ),
        ],
        if (finished && !on) ...[
          const SizedBox(width: 10),
          const Icon(AppIcons.check, size: 16, color: AppColors.gold),
          const SizedBox(width: 4),
          Flexible(
            child: Text(
              t.heard,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: AppColors.gold,
              ),
            ),
          ),
        ],
      ],
    );
  }
}

/// Keeps [teaching] on the phone to listen without network (Premium; without
/// it, a tap opens the Premium page); while it comes, the share downloaded (a
/// tap stops it); once kept, a tap removes it.
class DownloadButton extends ConsumerWidget {
  const DownloadButton({required this.teaching, this.color, super.key});

  final Teaching teaching;
  final Color? color;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t.teachings;
    final downloads = ref.watch(teachingDownloadsProvider).value;
    final progress = downloads?.progress[teaching.id];
    final kept = downloads?.has(teaching.id) ?? false;
    final notifier = ref.read(teachingDownloadsProvider.notifier);
    final premium = ref.watch(premiumProvider).value ?? false;

    Future<void> download() async {
      final toast = ref.read(toasterProvider).of(context);
      final messages = context.t;
      try {
        await notifier.download(teaching);
        toast.success(t.downloaded);
      } on Object catch (error) {
        if (!isCancel(error)) {
          toast.error(userMessageFor(error, messages));
        }
      }
    }

    Future<void> remove() async {
      final toast = ref.read(toasterProvider).of(context);
      await notifier.remove(teaching);
      toast.success(t.removed);
    }

    if (progress != null) {
      return IconButton(
        tooltip: t.cancelDownload,
        onPressed: () => notifier.cancel(teaching.id),
        icon: SizedBox.square(
          dimension: 22,
          child: CircularProgressIndicator(
            value: progress > 0 ? progress : null,
            strokeWidth: 2.5,
            color: color ?? AppColors.gold,
          ),
        ),
      );
    }
    // kept before: still listened to, and removable
    if (!kept && !premium) {
      return IconButton(
        tooltip: t.downloadPremium,
        onPressed: () => context.router.push(const PremiumRoute()),
        icon: Icon(AppIcons.downloadOffline, color: color),
      );
    }
    return IconButton(
      tooltip: kept ? t.removeDownload : t.download,
      onPressed: kept ? remove : download,
      icon: Icon(
        kept ? AppIcons.downloaded : AppIcons.downloadOffline,
        color: kept ? AppColors.gold : color,
      ),
    );
  }
}

/// Sends the audio of [teaching] (WhatsApp, mail, Files…): the file kept on
/// the phone, else downloaded first, the share shown around the arrow (a
/// tap stops it).
class ShareTeachingButton extends HookConsumerWidget {
  const ShareTeachingButton({required this.teaching, this.color, super.key});

  final Teaching teaching;
  final Color? color;

  /// "Marcher avec Dieu – Pr Z. T. Fomum.mp3", without the signs the files
  /// refuse.
  static String fileName(Teaching teaching) {
    final title = [
      teaching.title,
      if (teaching.speaker.isNotEmpty) teaching.speaker,
    ].join(' – ').replaceAll(RegExp(r'[\\/:*?"<>|\n\r]+'), ' ').trim();
    return '${title.isEmpty ? 'CMFI Connect' : title}.${teaching.audio.format.name}';
  }

  static String mimeType(Teaching teaching) => switch (teaching.audio.format) {
    AudioFormat.mp3 => 'audio/mpeg',
    AudioFormat.m4a => 'audio/mp4',
  };

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t.teachings;
    // null while idle, 0 to 1 while the file comes
    final progress = useState<double?>(null);
    final cancel = useRef<CancelToken?>(null);

    Future<void> share(BuildContext anchor) async {
      final toast = ref.read(toasterProvider).of(context);
      final messages = context.t;
      final box = anchor.findRenderObject() as RenderBox?;
      final origin = box == null
          ? null
          : box.localToGlobal(Offset.zero) & box.size;
      progress.value = 0;
      final token = cancel.value = CancelToken();
      try {
        final file = await ref
            .read(teachingFilesProvider)
            .forSharing(
              teaching,
              ref.read(mediaImagesProvider).resolve(teaching.audio.url),
              cancel: token,
              onProgress: (value) {
                if (context.mounted) {
                  progress.value = value;
                }
              },
            );
        if (context.mounted) {
          progress.value = null;
        }
        await ref
            .read(shareServiceProvider)
            .sharePath(
              file.path,
              name: fileName(teaching),
              mimeType: mimeType(teaching),
              subject: teaching.title,
              origin: origin,
            );
      } on Object catch (error) {
        if (!isCancel(error)) {
          toast.error(userMessageFor(error, messages));
        }
      } finally {
        cancel.value = null;
        if (context.mounted) {
          progress.value = null;
        }
      }
    }

    final value = progress.value;
    return Builder(
      builder: (anchor) => value != null
          ? IconButton(
              tooltip: t.cancelDownload,
              onPressed: () => cancel.value?.cancel(),
              icon: SizedBox.square(
                dimension: 22,
                child: CircularProgressIndicator(
                  value: value > 0 ? value : null,
                  strokeWidth: 2.5,
                  color: color ?? AppColors.gold,
                ),
              ),
            )
          : IconButton(
              tooltip: t.share,
              onPressed: () => share(anchor),
              icon: Icon(AppIcons.share, color: color),
            ),
    );
  }
}

/// The teaching heard now, at the foot of the list: a tap opens the player.
class MiniPlayer extends ConsumerWidget {
  const MiniPlayer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t.teachings;
    final now = ref.watch(nowPlayingProvider);
    final teaching = now.teaching;
    if (teaching == null) {
      return const SizedBox.shrink();
    }
    final duration = now.duration ?? teaching.duration;
    final fraction = duration == null || duration.inMilliseconds == 0
        ? 0.0
        : (now.position.inMilliseconds / duration.inMilliseconds).clamp(
            0.0,
            1.0,
          );

    return Material(
      color: AppColors.primaryDeep,
      child: SafeArea(
        top: false,
        child: InkWell(
          onTap: () => context.router.push(const TeachingPlayerRoute()),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              LinearProgressIndicator(
                value: fraction,
                minHeight: 2,
                color: AppColors.goldLight,
                backgroundColor: Colors.white12,
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(12, 8, 4, 8),
                child: Row(
                  children: [
                    TeachingCover(teaching: teaching, size: 44),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            teachingTitle(context, teaching),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          if (teaching.speaker.isNotEmpty)
                            Text(
                              teaching.speaker,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: AppColors.onPrimaryMuted,
                                fontSize: 12.5,
                              ),
                            ),
                        ],
                      ),
                    ),
                    if (now.loading && !now.playing)
                      const Padding(
                        padding: EdgeInsets.all(12),
                        child: AppSpinner(size: 22, color: Colors.white),
                      )
                    else
                      IconButton(
                        tooltip: now.playing ? t.pause : t.play,
                        onPressed: () =>
                            ref.read(nowPlayingProvider.notifier).toggle(),
                        icon: Icon(
                          now.playing ? AppIcons.pause : AppIcons.play,
                          color: Colors.white,
                        ),
                      ),
                    IconButton(
                      tooltip: t.closePlayer,
                      onPressed: () =>
                          ref.read(nowPlayingProvider.notifier).close(),
                      icon: const Icon(
                        AppIcons.close,
                        color: AppColors.onPrimaryMuted,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
