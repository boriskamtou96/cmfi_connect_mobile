import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/i18n/strings.g.dart';
import '../../../../core/network/app_exception_message.dart';
import '../../../../core/services/link_launcher.dart';
import '../../../../core/services/media_images.dart';
import '../../../../core/services/share_service.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_icons.dart';
import '../../../../core/theme/app_tones.dart';
import '../../../../core/utils/date_format.dart';
import '../../../../core/widgets/adaptive.dart';
import '../../../../core/widgets/app_toast.dart';
import '../../domain/prayer.dart';
import '../../infrastructure/prayer_api.dart';
import 'prayer_look.dart';

/// Opens [document] (the phone's PDF reader or the browser). false when no
/// app could open it.
Future<bool> openPrayerDocument(WidgetRef ref, PrayerDocument document) {
  final url = ref.read(mediaImagesProvider).resolve(document.url);
  return ref.read(linkLauncherProvider).open(Uri.parse(url));
}

/// A topic of the community: its name and its PDF. A tap opens the PDF; the
/// arrow downloads it and hands it to the phone (on iPhone, "Enregistrer
/// dans Fichiers"; on Android, the app chosen).
class PrayerTopicRow extends HookConsumerWidget {
  const PrayerTopicRow({required this.topic, super.key});

  final PrayerTopic topic;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final scheme = Theme.of(context).colorScheme;
    final tone = AppModule.prayer.tone(context);
    final document = topic.document;
    final busy = useState(false);

    Future<void> open() async {
      final toast = ref.read(toasterProvider).of(context);
      final messages = context.t;
      if (document != null && !await openPrayerDocument(ref, document)) {
        toast.error(messages.errors.unknown);
      }
    }

    Future<void> download(BuildContext anchor) async {
      if (document == null) {
        return;
      }
      final toast = ref.read(toasterProvider).of(context);
      final messages = context.t;
      final box = anchor.findRenderObject() as RenderBox?;
      busy.value = true;
      try {
        final bytes = await ref
            .read(prayerApiProvider)
            .document(ref.read(mediaImagesProvider).resolve(document.url));
        await ref
            .read(shareServiceProvider)
            .shareFile(
              bytes,
              name: _fileName(document, topic.title),
              mimeType: 'application/pdf',
              subject: topic.title,
              origin: box == null
                  ? null
                  : box.localToGlobal(Offset.zero) & box.size,
            );
      } on Object catch (error) {
        toast.error(userMessageFor(error, messages));
      } finally {
        if (context.mounted) {
          busy.value = false;
        }
      }
    }

    final facts = [
      if (document == null)
        t.prayer.topics.noDocument
      else if (document.sizeBytes > 0)
        t.prayer.topics.documentSize(kb: (document.sizeBytes / 1024).ceil())
      else
        'PDF',
      if (topic.endsOn case final end?)
        t.prayer.topics.until(date: context.formatDate(end, 'd MMM')),
    ].join(' · ');

    return InkWell(
      onTap: document == null ? null : open,
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(14, 12, 6, 12),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 52,
              decoration: BoxDecoration(
                color: tone.soft,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(AppIcons.pdf, color: tone.onSoft, size: 24),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Semantics(
                hint: document == null ? null : t.prayer.topics.openDocument,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      topic.title,
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
                      facts,
                      style: TextStyle(
                        fontSize: 13,
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (document != null)
              Builder(
                builder: (anchor) => IconButton(
                  tooltip: t.prayer.topics.download,
                  onPressed: busy.value ? null : () => download(anchor),
                  icon: busy.value
                      ? AppSpinner(size: 20, color: tone.onSoft)
                      : Icon(AppIcons.download, color: tone.onSoft),
                ),
              ),
          ],
        ),
      ),
    );
  }

  /// The name the file keeps on the phone: the one sent by the admins, else
  /// the title of the topic.
  static String _fileName(PrayerDocument document, String title) {
    final name = document.name.trim().isNotEmpty
        ? document.name.trim()
        : title.replaceAll(RegExp(r'[\\/:*?"<>|]+'), ' ').trim();
    return name.toLowerCase().endsWith('.pdf') ? name : '$name.pdf';
  }
}

/// [topics] one under the other in a card.
class PrayerTopicsCard extends StatelessWidget {
  const PrayerTopicsCard({required this.topics, super.key});

  final List<PrayerTopic> topics;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return PrayerCard(
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          for (final (i, topic) in topics.indexed) ...[
            if (i > 0)
              Divider(
                height: 1,
                indent: 14,
                endIndent: 14,
                color: scheme.outlineVariant,
              ),
            PrayerTopicRow(topic: topic),
          ],
        ],
      ),
    );
  }
}
