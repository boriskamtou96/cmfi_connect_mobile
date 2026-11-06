import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/i18n/strings.g.dart';
import '../../../../core/network/app_exception_message.dart';
import '../../../../core/services/link_launcher.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_icons.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_tones.dart';
import '../../../../core/widgets/adaptive_dialogs.dart';
import '../../../../core/widgets/app_toast.dart';
import '../../application/bible_library.dart';
import '../../application/bible_position.dart';
import '../../application/bible_settings.dart';
import '../../domain/bible_version.dart';

/// The versions, those of the app's language first; under them, the version
/// read can be downloaded (or removed) to read without network.
Future<void> showBibleVersions(BuildContext context) =>
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      showDragHandle: true,
      builder: (context) => DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.75,
        minChildSize: 0.4,
        builder: (context, scroll) => _VersionsSheet(scroll: scroll),
      ),
    );

class _VersionsSheet extends ConsumerWidget {
  const _VersionsSheet({required this.scroll});

  final ScrollController scroll;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final theme = Theme.of(context);
    final current = ref.watch(bibleVersionProvider);
    final language = LocaleSettings.currentLocale.languageCode;
    final languages = {
      language,
      for (final version in bibleVersions) version.language,
    };

    return ListView(
      controller: scroll,
      padding: const EdgeInsets.only(bottom: AppSpacing.xl),
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.xl,
            0,
            AppSpacing.xl,
            AppSpacing.md,
          ),
          child: Text(t.bible.versions, style: theme.textTheme.titleLarge),
        ),
        _DownloadCard(version: current),
        for (final code in languages)
          if (bibleVersions.where((version) => version.language == code)
              case final versions when versions.isNotEmpty) ...[
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(24, 18, 24, 4),
              child: Text(
                _languageName(code).toUpperCase(),
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.2,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ),
            for (final version in versions)
              _VersionRow(
                version: version,
                selected: version.id == current.id,
                onTap: () {
                  ref
                      .read(bibleSettingsControllerProvider.notifier)
                      .update(
                        (settings) => settings.copyWith(version: version.id),
                      );
                  Navigator.of(context).pop();
                },
              ),

            for (final bible in externalBibles)
              if (bible.language == code)
                _ExternalRow(
                  bible: bible,
                  onTap: () {
                    final place = ref.read(biblePositionProvider);
                    final url = bible.chapterUrl(place.book, place.chapter);
                    Navigator.of(context).pop();
                    ref.read(linkLauncherProvider).openInApp(url);
                  },
                ),
          ],
      ],
    );
  }
}

/// The name of a language in that language ("Deutsch").
String _languageName(String code) {
  for (final locale in AppLocale.values) {
    if (locale.languageCode == code) {
      return locale.buildSync().app.languageName;
    }
  }
  return code;
}

class _VersionRow extends ConsumerWidget {
  const _VersionRow({
    required this.version,
    required this.selected,
    required this.onTap,
  });

  final BibleVersion version;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final scheme = Theme.of(context).colorScheme;
    final tone = AppModule.bible.tone(context);
    final downloaded =
        ref.watch(bibleDownloadProvider(version.id)).value?.downloaded ?? false;

    return Semantics(
      selected: selected,
      child: ListTile(
        contentPadding: const EdgeInsetsDirectional.fromSTEB(24, 2, 16, 2),
        onTap: onTap,
        leading: Container(
          constraints: const BoxConstraints(minWidth: 52),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          decoration: BoxDecoration(
            color: selected ? tone.color : tone.soft,
            borderRadius: BorderRadius.circular(AppRadius.sm),
          ),
          child: Text(
            version.abbreviation,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w800,
              color: selected ? Colors.white : tone.onSoft,
            ),
          ),
        ),
        title: Text(
          version.name,
          style: TextStyle(
            fontWeight: selected ? FontWeight.w800 : FontWeight.w600,
          ),
        ),
        subtitle: downloaded
            ? Row(
                children: [
                  Icon(AppIcons.downloaded, size: 14, color: tone.onSoft),
                  const SizedBox(width: 4),
                  Text(
                    t.bible.downloaded,
                    style: TextStyle(fontSize: 12.5, color: tone.onSoft),
                  ),
                ],
              )
            : null,
        trailing: selected
            ? Icon(AppIcons.check, color: tone.onSoft)
            : Icon(
                AppIcons.chevronRight,
                size: 18,
                color: scheme.onSurfaceVariant,
              ),
      ),
    );
  }
}

/// A Bible under copyright: read on its site, at the chapter of the reader
/// (an arrow out instead of the check).
class _ExternalRow extends StatelessWidget {
  const _ExternalRow({required this.bible, required this.onTap});

  final ExternalBible bible;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final tone = AppModule.bible.tone(context);
    return ListTile(
      contentPadding: const EdgeInsetsDirectional.fromSTEB(24, 2, 16, 2),
      onTap: onTap,
      leading: Container(
        constraints: const BoxConstraints(minWidth: 52),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        decoration: BoxDecoration(
          border: Border.all(color: tone.soft, width: 1.5),
          borderRadius: BorderRadius.circular(AppRadius.sm),
        ),
        child: Text(
          bible.abbreviation,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w800,
            color: tone.onSoft,
          ),
        ),
      ),
      title: Text(
        bible.name,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
      subtitle: Text(context.t.bible.readOn(site: bible.site)),
      trailing: Icon(
        AppIcons.external,
        size: 18,
        color: scheme.onSurfaceVariant,
      ),
    );
  }
}

/// The version read, on a card: its name and whether it is on the phone,
/// "Télécharger cette Bible" (about 7 MB) or its progress, a bin to free the
/// space; the publisher's notice at the foot, apart.
class _DownloadCard extends ConsumerWidget {
  const _DownloadCard({required this.version});

  final BibleVersion version;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final scheme = Theme.of(context).colorScheme;
    final tone = AppModule.bible.tone(context);
    final state = ref.watch(bibleDownloadProvider(version.id)).value;
    final notifier = ref.read(bibleDownloadProvider(version.id).notifier);
    final progress = state?.progress;
    final downloaded = state?.downloaded ?? false;

    Future<void> download() async {
      final toast = ref.read(toasterProvider).of(context);
      try {
        await notifier.download();
        toast.success(t.bible.downloadDone(version: version.name));
      } on Object catch (error) {
        toast.error(userMessageFor(error, t));
      }
    }

    Future<void> remove() async {
      final confirmed = await showConfirmDialog(
        context,
        title: t.bible.removeDownloadTitle(version: version.name),
        text: t.bible.removeDownloadText,
        confirmLabel: t.bible.removeDownload,
        destructive: true,
      );
      if (confirmed) {
        await notifier.remove();
      }
    }

    final status = downloaded
        ? Row(
            children: [
              Icon(AppIcons.check, size: 15, color: tone.onSoft),
              const SizedBox(width: 4),
              Flexible(
                child: Text(
                  t.bible.downloaded,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: tone.onSoft,
                  ),
                ),
              ),
            ],
          )
        : Text(
            progress != null
                ? t.bible.downloading(percent: (progress * 100).round())
                : t.bible.downloadHelp(size: version.megabytes),
            style: TextStyle(
              fontSize: 13,
              height: 1.35,
              color: scheme.onSurfaceVariant,
            ),
          );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.lg),
        decoration: BoxDecoration(
          color: scheme.surfaceContainerLowest,
          border: Border.all(color: scheme.outlineVariant),
          borderRadius: BorderRadius.circular(AppRadius.xl),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Container(
                  width: 46,
                  height: 46,
                  decoration: BoxDecoration(
                    color: downloaded ? tone.color : tone.soft,
                    borderRadius: BorderRadius.circular(AppRadius.md),
                  ),
                  child: Icon(
                    downloaded ? AppIcons.downloaded : AppIcons.downloadOffline,
                    size: 24,
                    color: downloaded ? Colors.white : tone.onSoft,
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        version.name,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: scheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: 3),
                      status,
                    ],
                  ),
                ),
                if (downloaded)
                  IconButton(
                    tooltip: t.bible.removeDownload,
                    onPressed: remove,
                    color: scheme.onSurfaceVariant,
                    icon: const Icon(AppIcons.delete, size: 22),
                  ),
              ],
            ),
            if (progress != null)
              Padding(
                padding: const EdgeInsets.only(top: AppSpacing.md),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: progress,
                    minHeight: 6,
                    color: tone.color,
                    backgroundColor: tone.soft,
                  ),
                ),
              )
            else if (!downloaded)
              Padding(
                padding: const EdgeInsets.only(top: AppSpacing.md),
                child: FilledButton.icon(
                  onPressed: download,
                  style: FilledButton.styleFrom(
                    backgroundColor: tone.color,
                    foregroundColor: Colors.white,
                  ),
                  icon: const Icon(AppIcons.downloadOffline, size: 20),
                  label: Text(t.bible.download),
                ),
              ),
            if (version.attribution case final credit?) ...[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
                child: Divider(height: 1, color: scheme.outlineVariant),
              ),
              Text(
                credit,
                style: TextStyle(
                  fontSize: 11.5,
                  height: 1.45,
                  color: scheme.onSurfaceVariant,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
