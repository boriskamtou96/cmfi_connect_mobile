import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/i18n/strings.g.dart';
import '../../../core/services/home_widgets.dart';
import '../../../core/storage/preferences.dart';
import '../../../core/utils/date_extensions.dart';
import 'verse_of_the_day.dart';

part 'verse_widget.g.dart';

/// How many days of verses the widget gets ahead: it keeps turning at
/// midnight that long without the app being opened.
const verseWidgetDays = 14;

/// The "Verset du jour" widget's verses, from today, in the app language.
/// Free and without account: App hands them to the phone at each launch.
@riverpod
Future<VerseWidgetData> verseWidget(Ref ref) async {
  // read again when the language of the app changes
  ref.watch(savedLanguageProvider);
  final locale = LocaleSettings.currentLocale;
  final calendar = await ref.watch(
    verseCalendarProvider(locale.languageCode).future,
  );
  final start = today();
  return VerseWidgetData(
    days: {
      for (var i = 0; i < verseWidgetDays; i++)
        if (calendar.of(DateTime(start.year, start.month, start.day + i))
            case final verse?)
          DateTime(start.year, start.month, start.day + i): (
            text: verse.text,
            reference: verse.reference,
          ),
    },
    source: calendar.source,
    title: locale.buildSync().verses.title,
    rightToLeft: locale.languageCode == 'ar',
  );
}
