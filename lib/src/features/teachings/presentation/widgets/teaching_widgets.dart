import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/i18n/strings.g.dart';
import '../../../../core/network/app_exception_message.dart';
import '../../../../core/services/media_images.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_icons.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/utils/date_format.dart';
import '../../../../core/widgets/adaptive.dart';
import '../../../../core/widgets/app_toast.dart';
import '../../../../routing/app_router.dart';
import '../../application/now_playing.dart';
import '../../application/teaching_library.dart';
import '../../domain/teaching.dart';

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

/// Opens the player on [teaching], playing.
Future<void> openTeaching(
  BuildContext context,
  WidgetRef ref,
  Teaching teaching,
) async {
  final toast = ref.read(toasterProvider).of(context);
  final messages = context.t;
  unawaited(context.router.push(const TeachingPlayerRoute()));
  try {
    await ref.read(nowPlayingProvider.notifier).listen(teaching);
  } on Object catch (error) {
    toast.error(userMessageFor(error, messages));
  }
}

/// A teaching: the cover, the title, the speaker, the day and the length,
/// how far it was heard; a tap plays it, the cloud keeps it on the phone.
class TeachingRow extends ConsumerWidget {
  const TeachingRow({required this.teaching, super.key});

  final Teaching teaching;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t.teachings;
    final scheme = Theme.of(context).colorScheme;
    final progress = ref.watch(teachingProgressProvider.notifier);
    ref.watch(teachingProgressProvider);
    final heard = progress.fraction(teaching.id);
    final finished = progress.finished(teaching.id);
    final current = ref.watch(
      nowPlayingProvider.select((now) => now.teaching?.id == teaching.id),
    );

    return InkWell(
      onTap: () => openTeaching(context, ref, teaching),
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(14, 12, 4, 12),
        child: Row(
          children: [
            Stack(
              children: [
                TeachingCover(teaching: teaching, size: 56),
                if (current)
                  PositionedDirectional(
                    end: 4,
                    bottom: 4,
                    child: Container(
                      padding: const EdgeInsets.all(3),
                      decoration: const BoxDecoration(
                        color: AppColors.gold,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        AppIcons.teachingsTile,
                        size: 12,
                        color: Colors.white,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Semantics(
                hint: t.play,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      teaching.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 15.5,
                        height: 1.25,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      teachingFacts(context, teaching),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12.5,
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                    if (finished)
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Text(
                          t.heard,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: AppColors.gold,
                          ),
                        ),
                      )
                    else if (heard > 0)
                      Padding(
                        padding: const EdgeInsets.only(top: 6, right: 24),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: LinearProgressIndicator(
                            value: heard,
                            minHeight: 4,
                            color: AppColors.gold,
                            backgroundColor: scheme.surfaceContainerHighest,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            DownloadButton(teaching: teaching),
          ],
        ),
      ),
    );
  }
}

/// Keeps [teaching] on the phone to listen without network; while it comes,
/// the share downloaded (a tap stops it); once kept, a tap removes it.
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
                            teaching.title,
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
