import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/i18n/strings.g.dart';
import '../../../core/services/home_widgets.dart';
import '../../../core/services/premium_store.dart';
import '../../../core/utils/date_extensions.dart';
import 'day_report_controller.dart';
import 'report_goals.dart';

part 'today_widget.g.dart';

/// The texts of the home-screen widget, in the app language.
Map<String, String> todayWidgetTexts({int filled = 0, int total = 0}) {
  final t = LocaleSettings.instance.currentTranslations;
  return {
    'title': t.homeWidget.title,
    'done': t.homeWidget.done,
    'todo': t.homeWidget.todo,
    'open': t.homeWidget.open,
    'locked': t.homeWidget.locked,
    'signed_out': t.homeWidget.signedOut,
    'goals': t.home.goals,
    'items':
        '${t.home.progress(filled: filled, total: total)} '
        '${t.home.progressLabel}',
  };
}

/// What the widget shows for today: saved or to fill in, and how far the
/// goals go. null while the day loads.
@riverpod
TodayWidgetData? todayWidget(Ref ref) {
  final day = today();
  final draft = ref.watch(dayReportControllerProvider(day)).value;
  if (draft == null) {
    return null;
  }
  final goals = ref.watch(goalsOfDayProvider(day));
  return TodayWidgetData(
    signedIn: true,
    premium: ref.watch(premiumProvider).value ?? false,
    day: day,
    done: draft.submitted || draft.pending,
    filled: draft.filledCount,
    total: draft.entries.length,
    goalPercent: goals == null ? null : (goals.progress * 100).round(),
    texts: todayWidgetTexts(
      filled: draft.filledCount,
      total: draft.entries.length,
    ),
  );
}
