import 'package:cmfi_connect/src/core/i18n/strings.g.dart';
import 'package:cmfi_connect/src/core/theme/app_colors.dart';
import 'package:cmfi_connect/src/core/theme/app_icons.dart';
import 'package:cmfi_connect/src/core/theme/app_theme.dart';
import 'package:cmfi_connect/src/core/widgets/adaptive.dart';
import 'package:cmfi_connect/src/core/widgets/adaptive_dialogs.dart';
import 'package:cmfi_connect/src/core/widgets/adaptive_menus.dart';
import 'package:cmfi_connect/src/core/widgets/adaptive_pickers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';

/// [child] alone on a French screen of the app, drawn for [platform].
Future<void> pumpOn(
  WidgetTester tester,
  TargetPlatform platform,
  Widget child,
) => tester.pumpWidget(
  TranslationProvider(
    child: MaterialApp(
      locale: const Locale('fr'),
      supportedLocales: AppLocaleUtils.supportedLocales,
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      theme: AppTheme.light().copyWith(platform: platform),
      home: Scaffold(body: Center(child: child)),
    ),
  ),
);

/// A button "Ouvrir" that runs [open] and keeps what it gives in [result].
Widget opener<T>(
  Future<T> Function(BuildContext context) open,
  ValueNotifier<T?> result,
) => Builder(
  builder: (context) => TextButton(
    onPressed: () async => result.value = await open(context),
    child: const Text('Ouvrir'),
  ),
);

Future<void> tapAndSettle(WidgetTester tester, Finder finder) async {
  await tester.tap(finder);
  await tester.pumpAndSettle();
}

/// Turns the iOS wheel to [value], as a finger would.
void turnWheel(WidgetTester tester, DateTime value) => tester
    .widget<CupertinoDatePicker>(find.byType(CupertinoDatePicker))
    .onDateTimeChanged(value);

void main() {
  setUpAll(initializeDateFormatting);
  setUp(() => LocaleSettings.setLocale(AppLocale.fr));

  Future<bool> confirmBlock(BuildContext context) => showConfirmDialog(
    context,
    title: 'Bloquer Marc ?',
    text: 'Tu ne recevras plus ses invitations.',
    confirmLabel: 'Bloquer',
    destructive: true,
  );

  group('confirmation', () {
    testWidgets('an iOS alert on iPhone: Annuler in bold, the action red', (
      tester,
    ) async {
      final answer = ValueNotifier<bool?>(null);
      await pumpOn(tester, TargetPlatform.iOS, opener(confirmBlock, answer));

      await tapAndSettle(tester, find.text('Ouvrir'));
      expect(find.byType(CupertinoAlertDialog), findsOneWidget);
      expect(find.byType(AlertDialog), findsNothing);
      expect(find.text('Tu ne recevras plus ses invitations.'), findsOneWidget);
      final actions = tester
          .widgetList<CupertinoDialogAction>(find.byType(CupertinoDialogAction))
          .toList();
      expect(actions.first.isDefaultAction, isTrue);
      expect(actions.last.isDestructiveAction, isTrue);

      await tapAndSettle(tester, find.text('Bloquer'));
      expect(answer.value, isTrue);
      expect(find.byType(CupertinoAlertDialog), findsNothing);

      await tapAndSettle(tester, find.text('Ouvrir'));
      await tapAndSettle(tester, find.text('Annuler'));
      expect(answer.value, isFalse);
    });

    testWidgets('on iPhone, a safe action is the bold one', (tester) async {
      final answer = ValueNotifier<bool?>(null);
      await pumpOn(
        tester,
        TargetPlatform.iOS,
        opener(
          (context) => showConfirmDialog(
            context,
            title: "Préparer l'édition suivante ?",
            confirmLabel: 'Préparer',
          ),
          answer,
        ),
      );

      await tapAndSettle(tester, find.text('Ouvrir'));
      final actions = tester
          .widgetList<CupertinoDialogAction>(find.byType(CupertinoDialogAction))
          .toList();
      expect(actions.first.isDefaultAction, isFalse);
      expect(actions.last.isDefaultAction, isTrue);
      expect(actions.last.isDestructiveAction, isFalse);
    });

    testWidgets('a Material dialog on Android, the action filled in red', (
      tester,
    ) async {
      final answer = ValueNotifier<bool?>(null);
      await pumpOn(
        tester,
        TargetPlatform.android,
        opener(confirmBlock, answer),
      );

      await tapAndSettle(tester, find.text('Ouvrir'));
      expect(find.byType(AlertDialog), findsOneWidget);
      expect(find.byType(CupertinoAlertDialog), findsNothing);
      final action = find.widgetWithText(FilledButton, 'Bloquer');
      final context = tester.element(action);
      expect(
        tester.widget<FilledButton>(action).style?.backgroundColor?.resolve({}),
        Theme.of(context).colorScheme.error,
      );

      await tapAndSettle(tester, action);
      expect(answer.value, isTrue);

      await tapAndSettle(tester, find.text('Ouvrir'));
      await tapAndSettle(tester, find.text('Annuler'));
      expect(answer.value, isFalse);
    });

    testWidgets('a field in the alert on iPhone gives what is typed', (
      tester,
    ) async {
      final typed = ValueNotifier<String?>(null);
      await pumpOn(
        tester,
        TargetPlatform.iOS,
        opener(
          (context) => showInputDialog(
            context,
            title: 'Combien de proclamations ?',
            label: 'Nombre',
            confirmLabel: 'Ajouter',
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          ),
          typed,
        ),
      );

      await tapAndSettle(tester, find.text('Ouvrir'));
      expect(find.byType(CupertinoAlertDialog), findsOneWidget);
      await tester.enterText(find.byType(CupertinoTextField), '12');
      await tapAndSettle(tester, find.text('Ajouter'));
      expect(typed.value, '12');
    });
  });

  group('action sheets', () {
    final actions = [
      const AdaptiveAction(
        value: 'camera',
        icon: AppIcons.camera,
        label: 'Prendre une photo',
      ),
      const AdaptiveAction(
        value: 'remove',
        icon: AppIcons.delete,
        label: 'Retirer la photo',
        destructive: true,
      ),
    ];

    Future<String?> open(BuildContext context) => showActionSheet(
      context,
      title: 'Photo de profil',
      message: 'Visible par les autres membres',
      actions: actions,
    );

    testWidgets('an iOS action sheet on iPhone, with Annuler', (tester) async {
      final chosen = ValueNotifier<String?>(null);
      await pumpOn(tester, TargetPlatform.iOS, opener(open, chosen));

      await tapAndSettle(tester, find.text('Ouvrir'));
      expect(find.byType(CupertinoActionSheet), findsOneWidget);
      expect(find.text('Visible par les autres membres'), findsOneWidget);
      // words alone, as on iOS
      expect(find.byIcon(AppIcons.camera), findsNothing);
      final remove = tester.widget<CupertinoActionSheetAction>(
        find.ancestor(
          of: find.text('Retirer la photo'),
          matching: find.byType(CupertinoActionSheetAction),
        ),
      );
      expect(remove.isDestructiveAction, isTrue);

      await tapAndSettle(tester, find.text('Retirer la photo'));
      expect(chosen.value, 'remove');

      await tapAndSettle(tester, find.text('Ouvrir'));
      await tapAndSettle(tester, find.text('Annuler'));
      expect(chosen.value, isNull);
    });

    testWidgets('a bottom sheet of rows on Android', (tester) async {
      final chosen = ValueNotifier<String?>(null);
      await pumpOn(tester, TargetPlatform.android, opener(open, chosen));

      await tapAndSettle(tester, find.text('Ouvrir'));
      expect(find.byType(CupertinoActionSheet), findsNothing);
      expect(find.byType(BottomSheet), findsOneWidget);
      expect(find.byIcon(AppIcons.camera), findsOneWidget);

      await tapAndSettle(tester, find.text('Prendre une photo'));
      expect(chosen.value, 'camera');
    });
  });

  group('the ⋮ menu', () {
    Widget menu(ValueNotifier<String?> chosen) => AdaptiveMenuButton<String>(
      tooltip: "Plus d'options",
      onSelected: (value) => chosen.value = value,
      actions: const [
        AdaptiveAction(value: 'share', icon: AppIcons.share, label: 'Partager'),
        AdaptiveAction(value: 'copy', icon: AppIcons.copy, label: 'Copier'),
      ],
    );

    testWidgets('opens an action sheet on iPhone', (tester) async {
      final chosen = ValueNotifier<String?>(null);
      await pumpOn(tester, TargetPlatform.iOS, menu(chosen));

      await tapAndSettle(tester, find.byTooltip("Plus d'options"));
      expect(find.byType(CupertinoActionSheet), findsOneWidget);
      expect(find.byType(PopupMenuItem<String>), findsNothing);
      await tapAndSettle(tester, find.text('Copier'));
      expect(chosen.value, 'copy');

      // cancelled: nothing chosen
      chosen.value = null;
      await tapAndSettle(tester, find.byTooltip("Plus d'options"));
      await tapAndSettle(tester, find.text('Annuler'));
      expect(chosen.value, isNull);
    });

    testWidgets('opens a popup menu on Android', (tester) async {
      final chosen = ValueNotifier<String?>(null);
      await pumpOn(tester, TargetPlatform.android, menu(chosen));

      await tapAndSettle(tester, find.byTooltip("Plus d'options"));
      expect(find.byType(PopupMenuItem<String>), findsNWidgets(2));
      expect(find.byType(CupertinoActionSheet), findsNothing);
      await tapAndSettle(tester, find.text('Partager'));
      expect(chosen.value, 'share');
    });

    testWidgets('a pill opens it too; the current choice is checked', (
      tester,
    ) async {
      final chosen = ValueNotifier<String?>(null);
      await pumpOn(
        tester,
        TargetPlatform.iOS,
        AdaptiveMenuButton<String>(
          tooltip: 'Rôle de @paul',
          title: 'Rôle de @paul',
          onSelected: (value) => chosen.value = value,
          actions: const [
            AdaptiveAction(value: 'user', label: 'Membre'),
            AdaptiveAction(value: 'admin', label: 'Admin', selected: true),
          ],
          child: const Text('Admin'),
        ),
      );

      await tapAndSettle(tester, find.byTooltip('Rôle de @paul'));
      expect(find.byType(CupertinoActionSheet), findsOneWidget);
      expect(
        find.descendant(
          of: find.byType(CupertinoActionSheet),
          matching: find.byIcon(AppIcons.check),
        ),
        findsOneWidget,
      );
      await tapAndSettle(tester, find.text('Membre'));
      expect(chosen.value, 'user');
    });
  });

  group('pickers', () {
    testWidgets('a day on the iOS wheel, at midnight', (tester) async {
      final day = ValueNotifier<DateTime?>(null);
      await pumpOn(
        tester,
        TargetPlatform.iOS,
        opener(
          (context) => showAppDatePicker(
            context,
            initialDate: DateTime(2026, 10, 15),
            firstDate: DateTime(2020),
            lastDate: DateTime(2026, 10, 15),
            helpText: 'Choisir le jour',
          ),
          day,
        ),
      );

      await tapAndSettle(tester, find.text('Ouvrir'));
      final wheel = tester.widget<CupertinoDatePicker>(
        find.byType(CupertinoDatePicker),
      );
      expect(wheel.mode, CupertinoDatePickerMode.date);
      expect(wheel.maximumDate, DateTime(2026, 10, 15));
      expect(find.text('Choisir le jour'), findsOneWidget);

      turnWheel(tester, DateTime(2026, 3, 14, 10, 30));
      await tapAndSettle(tester, find.text('OK'));
      expect(day.value, DateTime(2026, 3, 14));

      await tapAndSettle(tester, find.text('Ouvrir'));
      turnWheel(tester, DateTime(2025, 1, 2));
      await tapAndSettle(tester, find.text('Annuler'));
      expect(day.value, isNull);
    });

    testWidgets('the Material calendar on Android', (tester) async {
      final day = ValueNotifier<DateTime?>(null);
      await pumpOn(
        tester,
        TargetPlatform.android,
        opener(
          (context) => showAppDatePicker(
            context,
            initialDate: DateTime(2026, 10, 15),
            firstDate: DateTime(2020),
            lastDate: DateTime(2026, 10, 15),
          ),
          day,
        ),
      );

      await tapAndSettle(tester, find.text('Ouvrir'));
      expect(find.byType(DatePickerDialog), findsOneWidget);
      expect(find.byType(CupertinoDatePicker), findsNothing);
      await tapAndSettle(tester, find.text('12'));
      await tapAndSettle(tester, find.text('OK'));
      expect(day.value, DateTime(2026, 10, 12));
    });

    testWidgets('a time on the iOS wheel, 24 hours in French', (tester) async {
      final time = ValueNotifier<TimeOfDay?>(null);
      await pumpOn(
        tester,
        TargetPlatform.iOS,
        opener(
          (context) => showAppTimePicker(
            context,
            initialTime: const TimeOfDay(hour: 20, minute: 0),
          ),
          time,
        ),
      );

      await tapAndSettle(tester, find.text('Ouvrir'));
      final wheel = tester.widget<CupertinoDatePicker>(
        find.byType(CupertinoDatePicker),
      );
      expect(wheel.mode, CupertinoDatePickerMode.time);
      expect(wheel.use24hFormat, isTrue);
      expect(wheel.initialDateTime.hour, 20);

      turnWheel(tester, DateTime(2000, 1, 1, 21, 15));
      await tapAndSettle(tester, find.text('OK'));
      expect(time.value, const TimeOfDay(hour: 21, minute: 15));
    });

    testWidgets('the Material clock on Android', (tester) async {
      final time = ValueNotifier<TimeOfDay?>(null);
      await pumpOn(
        tester,
        TargetPlatform.android,
        opener(
          (context) => showAppTimePicker(
            context,
            initialTime: const TimeOfDay(hour: 20, minute: 0),
          ),
          time,
        ),
      );

      await tapAndSettle(tester, find.text('Ouvrir'));
      expect(find.byType(TimePickerDialog), findsOneWidget);
      await tapAndSettle(tester, find.text('OK'));
      expect(time.value, const TimeOfDay(hour: 20, minute: 0));
    });

    testWidgets('a period on iPhone: "Du", then "Au", on one wheel', (
      tester,
    ) async {
      final period = ValueNotifier<DateTimeRange?>(null);
      await pumpOn(
        tester,
        TargetPlatform.iOS,
        opener(
          (context) => showAppDateRangePicker(
            context,
            firstDate: DateTime(2020),
            lastDate: DateTime(2026, 10, 15),
            initialDateRange: DateTimeRange(
              start: DateTime(2026, 10),
              end: DateTime(2026, 10, 15),
            ),
          ),
          period,
        ),
      );

      await tapAndSettle(tester, find.text('Ouvrir'));
      expect(find.text('Du'), findsOneWidget);
      expect(find.text('Au'), findsOneWidget);
      // "Du" first
      turnWheel(tester, DateTime(2026, 9, 1));
      await tester.pump();
      expect(find.text('mar. 1 sept. 2026'), findsOneWidget);

      await tapAndSettle(tester, find.text('Au'));
      expect(
        tester
            .widget<CupertinoDatePicker>(find.byType(CupertinoDatePicker))
            .initialDateTime,
        DateTime(2026, 10, 15),
      );
      turnWheel(tester, DateTime(2026, 9, 30));
      await tapAndSettle(tester, find.text('OK'));

      expect(
        period.value,
        DateTimeRange(start: DateTime(2026, 9), end: DateTime(2026, 9, 30)),
      );
    });

    testWidgets('an end before the start brings the start with it', (
      tester,
    ) async {
      final period = ValueNotifier<DateTimeRange?>(null);
      await pumpOn(
        tester,
        TargetPlatform.iOS,
        opener(
          (context) => showAppDateRangePicker(
            context,
            firstDate: DateTime(2020),
            lastDate: DateTime(2026, 10, 15),
            initialDateRange: DateTimeRange(
              start: DateTime(2026, 10),
              end: DateTime(2026, 10, 15),
            ),
          ),
          period,
        ),
      );

      await tapAndSettle(tester, find.text('Ouvrir'));
      await tapAndSettle(tester, find.text('Au'));
      turnWheel(tester, DateTime(2026, 8, 20));
      await tapAndSettle(tester, find.text('OK'));

      expect(
        period.value,
        DateTimeRange(start: DateTime(2026, 8, 20), end: DateTime(2026, 8, 20)),
      );
    });
  });

  group('controls', () {
    testWidgets('the spinner: iOS ticks on iPhone', (tester) async {
      await pumpOn(tester, TargetPlatform.iOS, const AppSpinner(size: 20));
      expect(find.byType(CupertinoActivityIndicator), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsNothing);
      expect(tester.getSize(find.byType(AppSpinner)), const Size.square(20));
    });

    testWidgets('the spinner: the Material ring on Android', (tester) async {
      await pumpOn(tester, TargetPlatform.android, const AppSpinner(size: 20));
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.byType(CupertinoActivityIndicator), findsNothing);
    });

    testWidgets("an iOS switch takes the app's blue, not Apple's green", (
      tester,
    ) async {
      await pumpOn(
        tester,
        TargetPlatform.iOS,
        Switch.adaptive(value: true, onChanged: (_) {}),
      );

      expect(find.byType(Switch), paints..rrect(color: AppColors.primary));
    });
  });
}
