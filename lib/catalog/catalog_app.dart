import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../src/core/i18n/strings.g.dart';
import '../src/core/theme/app_theme.dart';
import '../src/core/widgets/dove_mascot.dart';
import 'knobs.dart';
import 'stories.dart';

/// What every story is seen in: light or dark, the language (Arabic right to
/// left), the size of the text.
class CatalogSettings extends ChangeNotifier {
  ThemeMode mode = ThemeMode.light;
  AppLocale locale = AppLocale.fr;
  double textScale = 1;

  void update(void Function(CatalogSettings settings) change) {
    change(this);
    LocaleSettings.setLocale(locale);
    notifyListeners();
  }
}

/// The widget catalog of CMFI Connect, a storybook made in the app: the
/// components by family, each with its knobs. Run it with
/// `flutter run --flavor dev -t lib/main_catalog.dart`.
class CatalogApp extends StatefulWidget {
  const CatalogApp({super.key, this.settings});

  /// Given by the tests; made here otherwise.
  final CatalogSettings? settings;

  @override
  State<CatalogApp> createState() => _CatalogAppState();
}

class _CatalogAppState extends State<CatalogApp> {
  late final settings = widget.settings ?? CatalogSettings();

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: settings,
      builder: (context, _) => TranslationProvider(
        child: MaterialApp(
          title: 'Catalogue CMFI Connect',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light(),
          darkTheme: AppTheme.dark(),
          themeMode: settings.mode,
          locale: settings.locale.flutterLocale,
          supportedLocales: AppLocaleUtils.supportedLocales,
          localizationsDelegates: GlobalMaterialLocalizations.delegates,
          builder: (context, child) => MediaQuery(
            data: MediaQuery.of(
              context,
            ).copyWith(textScaler: TextScaler.linear(settings.textScale)),
            child: child!,
          ),
          home: _StoryList(settings: settings),
        ),
      ),
    );
  }
}

class _StoryList extends StatelessWidget {
  const _StoryList({required this.settings});

  final CatalogSettings settings;

  @override
  Widget build(BuildContext context) {
    final groups = <String, List<Story>>{};
    for (final story in stories) {
      groups.putIfAbsent(story.group, () => []).add(story);
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Catalogue'),
        actions: [_SettingsButton(settings: settings)],
      ),
      body: ListView(
        children: [
          for (final MapEntry(key: group, value: items) in groups.entries) ...[
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 4),
              child: Text(
                group.toUpperCase(),
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ),
            for (final story in items)
              ListTile(
                title: Text(story.name),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (_) => StoryPage(story: story, settings: settings),
                  ),
                ),
              ),
          ],
        ],
      ),
    );
  }
}

/// A story: its preview, then the knobs it asked for.
class StoryPage extends StatefulWidget {
  const StoryPage({required this.story, required this.settings, super.key});

  final Story story;
  final CatalogSettings settings;

  @override
  State<StoryPage> createState() => _StoryPageState();
}

class _StoryPageState extends State<StoryPage> {
  final knobs = Knobs();

  @override
  void dispose() {
    knobs.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.story.name),
        actions: [_SettingsButton(settings: widget.settings)],
      ),
      body: ListenableBuilder(
        listenable: knobs,
        builder: (context, _) {
          // the story first: it asks for its knobs while it builds
          final preview = widget.story.build(context, knobs);
          return Column(
            children: [
              Expanded(
                flex: 3,
                child: ColoredBox(
                  color: Theme.of(context).colorScheme.surfaceContainerLow,
                  child: Center(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(24),
                      child: preview,
                    ),
                  ),
                ),
              ),
              const Divider(height: 1),
              Expanded(
                flex: 2,
                child: ListView(
                  children: [for (final knob in knobs.all) knob.control(knobs)],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

/// Light or dark, the language and the size of the text, for every story.
class _SettingsButton extends StatelessWidget {
  const _SettingsButton({required this.settings});

  final CatalogSettings settings;

  @override
  Widget build(BuildContext context) => IconButton(
    tooltip: 'Réglages',
    icon: const Icon(Icons.tune),
    onPressed: () => showModalBottomSheet<void>(
      context: context,
      builder: (_) => ListenableBuilder(
        listenable: settings,
        builder: (context, _) => ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(vertical: 12),
          children: [
            ListTile(
              title: const Text('Thème'),
              subtitle: SegmentedButton<ThemeMode>(
                segments: const [
                  ButtonSegment(value: ThemeMode.light, label: Text('Clair')),
                  ButtonSegment(value: ThemeMode.dark, label: Text('Sombre')),
                ],
                selected: {settings.mode},
                onSelectionChanged: (value) =>
                    settings.update((s) => s.mode = value.single),
              ),
            ),
            ListTile(
              title: const Text('Langue'),
              subtitle: Wrap(
                spacing: 6,
                children: [
                  for (final locale in AppLocale.values)
                    ChoiceChip(
                      label: Text(locale.languageCode),
                      selected: settings.locale == locale,
                      onSelected: (_) =>
                          settings.update((s) => s.locale = locale),
                    ),
                ],
              ),
            ),
            ListTile(
              title: Text(
                'Taille du texte : ${(settings.textScale * 100).round()} %',
              ),
              subtitle: Slider(
                value: settings.textScale,
                min: 0.8,
                max: 2,
                divisions: 12,
                onChanged: (value) =>
                    settings.update((s) => s.textScale = value),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

/// Zoé moves in the catalog as in the app.
void startCatalog() {
  WidgetsFlutterBinding.ensureInitialized();
  DoveMascot.lively = true;
  LocaleSettings.setLocale(AppLocale.fr);
}
