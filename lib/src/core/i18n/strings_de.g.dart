///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import
// dart format off

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:slang/generated.dart';
import 'strings.g.dart';

// Path: <root>
class TranslationsDe extends Translations with BaseTranslations<AppLocale, Translations> {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsDe({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  _meta = meta ?? TranslationMetadata(
		    locale: AppLocale.de,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ),
		  super(cardinalResolver: cardinalResolver, ordinalResolver: ordinalResolver) {
		_meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <de>.
	final TranslationMetadata<AppLocale, Translations> _meta;
	@override TranslationMetadata<AppLocale, Translations> get $meta => _meta;

	/// Access flat map
	@override dynamic operator[](String key) => _meta.getTranslation(key) ?? super[key];

	late final TranslationsDe _root = this; // ignore: unused_field

	@override 
	TranslationsDe $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsDe(meta: meta ?? this.$meta);

	// Translations
	@override late final _Translations$app$de app = _Translations$app$de._(_root);
	@override late final _Translations$common$de common = _Translations$common$de._(_root);
	@override late final _Translations$errors$de errors = _Translations$errors$de._(_root);
	@override late final _Translations$validation$de validation = _Translations$validation$de._(_root);
	@override late final _Translations$onboarding$de onboarding = _Translations$onboarding$de._(_root);
	@override late final _Translations$welcome$de welcome = _Translations$welcome$de._(_root);
	@override late final _Translations$auth$de auth = _Translations$auth$de._(_root);
	@override late final _Translations$countries$de countries = _Translations$countries$de._(_root);
	@override late final _Translations$nav$de nav = _Translations$nav$de._(_root);
	@override late final _Translations$home$de home = _Translations$home$de._(_root);
	@override late final _Translations$reports$de reports = _Translations$reports$de._(_root);
	@override late final _Translations$reminder$de reminder = _Translations$reminder$de._(_root);
	@override late final _Translations$export$de export = _Translations$export$de._(_root);
	@override late final _Translations$items$de items = _Translations$items$de._(_root);
	@override late final _Translations$newItem$de newItem = _Translations$newItem$de._(_root);
	@override late final _Translations$more$de more = _Translations$more$de._(_root);
	@override late final _Translations$authorities$de authorities = _Translations$authorities$de._(_root);
	@override late final _Translations$members$de members = _Translations$members$de._(_root);
	@override late final _Translations$admin$de admin = _Translations$admin$de._(_root);
	@override late final _Translations$hymns$de hymns = _Translations$hymns$de._(_root);
	@override late final _Translations$comingSoon$de comingSoon = _Translations$comingSoon$de._(_root);
	@override late final _Translations$events$de events = _Translations$events$de._(_root);
	@override late final _Translations$notifications$de notifications = _Translations$notifications$de._(_root);
	@override late final _Translations$premium$de premium = _Translations$premium$de._(_root);
	@override late final _Translations$homeWidget$de homeWidget = _Translations$homeWidget$de._(_root);
	@override late final _Translations$ministry$de ministry = _Translations$ministry$de._(_root);
	@override late final _Translations$prayer$de prayer = _Translations$prayer$de._(_root);
	@override late final _Translations$sending$de sending = _Translations$sending$de._(_root);
	@override late final _Translations$streak$de streak = _Translations$streak$de._(_root);
	@override late final _Translations$shortcuts$de shortcuts = _Translations$shortcuts$de._(_root);
	@override late final _Translations$blocking$de blocking = _Translations$blocking$de._(_root);
	@override late final _Translations$verses$de verses = _Translations$verses$de._(_root);
	@override late final _Translations$bible$de bible = _Translations$bible$de._(_root);
	@override late final _Translations$profilePhoto$de profilePhoto = _Translations$profilePhoto$de._(_root);
	@override late final _Translations$disciples$de disciples = _Translations$disciples$de._(_root);
	@override late final _Translations$weekStory$de weekStory = _Translations$weekStory$de._(_root);
	@override late final _Translations$seekFirst$de seekFirst = _Translations$seekFirst$de._(_root);
}

// Path: app
class _Translations$app$de extends Translations$app$fr {
	_Translations$app$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get name => 'CMFI Connect';
	@override String get tagline => 'Gemeinsam wachsen, jeden Tag.';
	@override String get languageName => 'Deutsch';
}

// Path: common
class _Translations$common$de extends Translations$common$fr {
	_Translations$common$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get retry => 'Erneut versuchen';
	@override String get cancel => 'Abbrechen';
	@override String get save => 'Speichern';
	@override String get close => 'Schließen';
	@override String get back => 'Zurück';
	@override String get soon => 'Bald';
	@override String get optional => '(optional)';
	@override String get and => 'und';
	@override String get loading => 'Wird geladen…';
	@override String get done => 'Fertig';
	@override String get rangeStart => 'Von';
	@override String get rangeEnd => 'Bis';
}

// Path: errors
class _Translations$errors$de extends Translations$errors$fr {
	_Translations$errors$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get network => 'Keine Internetverbindung. Prüfe dein Netzwerk und versuche es erneut.';
	@override String get unauthorized => 'Deine Sitzung ist abgelaufen. Melde dich erneut an.';
	@override String get invalidCredentials => 'Telefonnummer oder Passwort ist falsch.';
	@override String get badRequest => 'Einige Angaben sind ungültig.';
	@override String get conflict => 'Dieser Eintrag existiert bereits.';
	@override String get notFound => 'Eintrag nicht gefunden.';
	@override String get server => 'Auf dem Server ist ein Problem aufgetreten. Versuche es gleich noch einmal.';
	@override String get unknown => 'Ein Fehler ist aufgetreten. Versuche es erneut.';
	@override String get forbidden => 'Dazu bist du nicht berechtigt.';
	@override String get eventFull => 'Für diese Veranstaltung sind keine Plätze mehr frei.';
	@override String get registrationClosed => 'Die Anmeldung für diese Veranstaltung ist geschlossen.';
	@override String get mediaTooLarge => 'Dieses Bild ist zu groß (höchstens 8 MB).';
	@override String get mediaUnsupported => 'Wähle ein JPEG- oder PNG-Bild.';
	@override String get notParticipant => 'Schließ dich zuerst diesem Anliegen an, um deine Proklamationen zu zählen.';
	@override String get importunityClosed => 'Dieses Anliegen ist abgeschlossen: Es werden keine Proklamationen mehr gezählt.';
	@override String get usernameNotFound => 'Niemand hat diesen Benutzernamen. Prüfe die Schreibweise.';
	@override String get ownerCannotLeave => 'Du hast dieses Anliegen erstellt: Lösche es, statt es zu verlassen.';
	@override String get tooManyPeople => 'Deine Listen sind voll (höchstens 500 Personen).';
	@override String get avatarInvalid => 'Dieses Foto kann nicht verwendet werden. Wähle ein anderes.';
	@override String get reportsNotShared => 'Dieses Mitglied teilt seine Berichte nicht mehr.';
}

// Path: validation
class _Translations$validation$de extends Translations$validation$fr {
	_Translations$validation$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get required => 'Dieses Feld ist erforderlich';
	@override String get passwordTooShort => 'Mindestens 6 Zeichen';
	@override String get invalidPhone => 'Ungültige Telefonnummer';
	@override String get invalidEmail => 'Ungültige E-Mail-Adresse';
	@override String get invalidCode => 'Nur Buchstaben und Ziffern, ohne Leerzeichen';
}

// Path: onboarding
class _Translations$onboarding$de extends Translations$onboarding$fr {
	_Translations$onboarding$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get skip => 'Überspringen';
	@override String get next => 'Weiter';
	@override String get start => 'Los geht\'s';
	@override String step({required Object current, required Object total}) => 'Seite ${current} von ${total}';
	@override late final _Translations$onboarding$reports$de reports = _Translations$onboarding$reports$de._(_root);
	@override late final _Translations$onboarding$worship$de worship = _Translations$onboarding$worship$de._(_root);
	@override late final _Translations$onboarding$community$de community = _Translations$onboarding$community$de._(_root);
	@override late final _Translations$onboarding$sample$de sample = _Translations$onboarding$sample$de._(_root);
}

// Path: welcome
class _Translations$welcome$de extends Translations$welcome$fr {
	_Translations$welcome$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Willkommen bei CMFI Connect';
	@override String get text => 'Erstelle in einer Minute dein Konto, um deinen Tagesbericht auszufüllen und das Leben deiner Gemeinschaft mitzuverfolgen.';
	@override String get createAccount => 'Konto erstellen';
	@override String get haveAccount => 'Ich habe schon ein Konto';
}

// Path: auth
class _Translations$auth$de extends Translations$auth$fr {
	_Translations$auth$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get phone => 'Telefon';
	@override String dialCode({required Object code}) => 'Ländervorwahl: ${code}';
	@override String get password => 'Passwort';
	@override String get showPassword => 'Passwort anzeigen';
	@override String get hidePassword => 'Passwort verbergen';
	@override late final _Translations$auth$login$de login = _Translations$auth$login$de._(_root);
	@override late final _Translations$auth$register$de register = _Translations$auth$register$de._(_root);
	@override late final _Translations$auth$church$de church = _Translations$auth$church$de._(_root);
	@override late final _Translations$auth$forgot$de forgot = _Translations$auth$forgot$de._(_root);
	@override late final _Translations$auth$biometric$de biometric = _Translations$auth$biometric$de._(_root);
}

// Path: countries
class _Translations$countries$de extends Translations$countries$fr {
	_Translations$countries$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get dialCodeTitle => 'Ländervorwahl';
	@override String get title => 'Dein Land';
	@override String get search => 'Land oder Vorwahl suchen';
	@override String get none => 'Kein Land gefunden';
	@override String get change => 'Land ändern';
}

// Path: nav
class _Translations$nav$de extends Translations$nav$fr {
	_Translations$nav$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get home => 'Start';
	@override String get reports => 'Bericht';
	@override String get hymns => 'Lieder';
	@override String get prayer => 'Gebet';
	@override String get bible => 'Bibel';
}

// Path: home
class _Translations$home$de extends Translations$home$fr {
	_Translations$home$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String greeting({required Object name}) => 'Hallo ${name}';
	@override String get greetingNoName => 'Hallo';
	@override String get profile => 'Mein Profil';
	@override String progress({required Object filled, required Object total}) => '${filled} von ${total}';
	@override String get progressLabel => 'Elemente ausgefüllt';
	@override String get goals => 'Ziele';
	@override String get weekTitle => 'Deine Woche';
	@override String get community => 'Aktuell bei der CMFI';
	@override String get eventsTitle => 'Veranstaltungen';
	@override String get hymnsTitle => 'Lieder';
	@override String get hymnsOpen => 'Liederbuch öffnen';
	@override String get continueMyReport => 'Bericht fortsetzen';
	@override String get startMyReport => 'Bericht beginnen';
	@override String get items => 'Punkte';
	@override String get goalsTitle => 'Ziele';
	@override String get retreatsTitle => 'Gebetszeiten';
	@override String retreatsValue({required Object n}) => '${n} von 4';
	@override String get streakTitle => 'Serie';
	@override String get resume => 'Weitermachen';
	@override String hymnNumber({required Object number}) => 'Lied Nr. ${number}';
	@override String get seeAll => 'Alle ansehen';
	@override String get retreatsDone => 'Die 4 Gebetszeiten des Tages sind gemacht';
	@override String days({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
		one: '${n} Tag',
		other: '${n} Tage',
	);
	@override String get hideNumbers => 'Meine Zahlen ausblenden';
	@override String get showNumbers => 'Meine Zahlen anzeigen';
	@override String get numbersHidden => 'ausgeblendet';
}

// Path: reports
class _Translations$reports$de extends Translations$reports$fr {
	_Translations$reports$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Tagesbericht';
	@override String get myItems => 'Meine Elemente';
	@override late final _Translations$reports$tabs$de tabs = _Translations$reports$tabs$de._(_root);
	@override String get pickDay => 'Tag wählen';
	@override String filled({required Object filled, required Object total}) => '${filled} von ${total} ausgefüllt';
	@override String get statusSaved => 'Gespeichert';
	@override String get statusModified => 'Nicht gespeichert';
	@override String get standard => 'Standard';
	@override String get personal => 'Meine Elemente';
	@override String get createItem => 'Element erstellen';
	@override String add({required Object label}) => '${label} eintragen';
	@override String get note => 'Notiz des Tages';
	@override String get noteHint => 'Ein Vers, ein Grund zur Dankbarkeit …';
	@override String get save => 'Tag speichern';
	@override String get saved => 'Tag gespeichert';
	@override late final _Translations$reports$measure$de measure = _Translations$reports$measure$de._(_root);
	@override String times({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
		one: '${n}-mal',
		other: '${n}-mal',
	);
	@override late final _Translations$reports$sheet$de sheet = _Translations$reports$sheet$de._(_root);
	@override late final _Translations$reports$history$de history = _Translations$reports$history$de._(_root);
	@override late final _Translations$reports$summary$de summary = _Translations$reports$summary$de._(_root);
	@override String get noItems => 'Im Moment gibt es nichts auszufüllen.';
	@override String get statusPending => 'Noch nicht gesendet';
	@override String get savedOffline => 'Kein Netz: Der Tag bleibt auf dem Handy gespeichert und wird gesendet, sobald es möglich ist.';
	@override String pendingBanner({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
		one: '${n} Tag wartet auf Netz, um gesendet zu werden',
		other: '${n} Tage warten auf Netz, um gesendet zu werden',
	);
	@override String get export => 'Meinen Bericht exportieren';
	@override String goal({required Object value}) => 'Ziel: ${value}';
	@override String get goalReached => 'Ziel erreicht';
	@override String get dayGoals => 'Ziele des Tages';
	@override String goalsReached({required Object reached, required Object total}) => 'Erreicht: ${reached} von ${total}';
	@override late final _Translations$reports$standardItems$de standardItems = _Translations$reports$standardItems$de._(_root);
	@override late final _Translations$reports$units$de units = _Translations$reports$units$de._(_root);
}

// Path: reminder
class _Translations$reminder$de extends Translations$reminder$fr {
	_Translations$reminder$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Dein Tagesbericht';
	@override String get body => 'Nimm dir eine Minute, um deine Bibellese, dein Gebet … festzuhalten, bevor der Tag endet.';
	@override String get channel => 'Erinnerung an den Tagesbericht';
	@override String get settings => 'Erinnerung am Abend';
	@override String get off => 'Aus';
	@override String get switchLabel => 'Erinnere mich, meinen Tag auszufüllen';
	@override String get switchHint => 'Nur wenn der Tag noch nicht ausgefüllt ist.';
	@override String get time => 'Uhrzeit der Erinnerung';
	@override String get offerTitle => 'Jeden Abend eine Erinnerung?';
	@override String get offerText => 'Wenn dein Tag noch nicht ausgefüllt ist, erinnert dich die App zur gewählten Uhrzeit daran. Ist schon alles erledigt, kommt nichts.';
	@override String get offerAccept => 'Erinnerung aktivieren';
	@override String get offerLater => 'Später';
	@override String enabled({required Object time}) => 'Erinnerung um ${time} aktiviert';
	@override String get denied => 'Benachrichtigungen für CMFI Connect sind blockiert. Erlaube sie in den Einstellungen deines Handys.';
}

// Path: export
class _Translations$export$de extends Translations$export$fr {
	_Translations$export$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Exportieren';
	@override String get period => 'Zeitraum';
	@override String get thisWeek => 'Diese Woche';
	@override String get lastWeek => 'Letzte Woche';
	@override String get thisMonth => 'Dieser Monat';
	@override String get lastMonth => 'Letzter Monat';
	@override String get thisYear => 'Dieses Jahr';
	@override String get custom => 'Eigener Zeitraum';
	@override String get customPick => 'Zeitraum wählen';
	@override String get format => 'Format';
	@override String get pdf => 'PDF';
	@override String get pdfHint => 'Ein Dokument zum Versenden oder Drucken';
	@override String get csv => 'Tabelle';
	@override String get csvHint => 'Eine CSV-Datei für Excel oder Google Sheets';
	@override String get text => 'Nachricht';
	@override String get textHint => 'Eine Zusammenfassung zum Einfügen in WhatsApp';
	@override String get button => 'Exportieren';
	@override String get shareButton => 'Teilen';
	@override String preview({required num filled, required Object total, required Object items}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(filled,
		one: '${filled} von ${total} Tagen ausgefüllt · ${items}',
		other: '${filled} von ${total} Tagen ausgefüllt · ${items}',
	);
	@override String previewItems({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
		one: '${n} Element',
		other: '${n} Elemente',
	);
	@override String get empty => 'Kein Bericht in diesem Zeitraum.';
	@override String get tooLong => 'Wähle höchstens 366 Tage.';
	@override String get fileName => 'tagesbericht';
	@override String subject({required Object period}) => 'Mein Tagesbericht, ${period}';
	@override late final _Translations$export$doc$de doc = _Translations$export$doc$de._(_root);
}

// Path: items
class _Translations$items$de extends Translations$items$fr {
	_Translations$items$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Meine Elemente';
	@override String get standardSection => 'Standard · für alle';
	@override String get personalSection => 'Meine persönlichen Elemente';
	@override String get emptyPersonal => 'Du hast noch kein persönliches Element.';
	@override String get archive => 'Archivieren';
	@override String archiveTitle({required Object code}) => '${code} archivieren?';
	@override String get archiveText => 'Es wird in deinem Bericht nicht mehr angeboten. Seine Zahlen bleiben in deinem Verlauf erhalten.';
	@override String archived({required Object code}) => '${code} archiviert';
	@override String get create => 'Element erstellen';
	@override String get footnote => 'Ein archiviertes Element wird in deinem Bericht nicht mehr angeboten, aber seine Zahlen bleiben in deinem Verlauf erhalten.';
	@override late final _Translations$items$measure$de measure = _Translations$items$measure$de._(_root);
	@override String get goalAdd => 'Ziel hinzufügen';
	@override String goal({required Object value}) => 'Ziel: ${value} pro Tag';
	@override String get goalTitle => 'Tagesziel';
	@override String get goalHint => 'Was du dir für jeden Tag vornimmst. Es bleibt auf deinem Handy.';
	@override String get goalRemove => 'Entfernen';
	@override String get goalSaved => 'Ziel gespeichert';
	@override String get goalRemoved => 'Ziel entfernt';
}

// Path: newItem
class _Translations$newItem$de extends Translations$newItem$fr {
	_Translations$newItem$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Neues Element';
	@override String get code => 'Code';
	@override String get label => 'Name';
	@override String get help => 'Buchstaben und Ziffern, höchstens 20. Codes von Standardelementen (LB, PS …) sind nicht verfügbar.';
	@override String get measures => 'Was du misst';
	@override String get quantity => 'Eine Anzahl';
	@override String get quantityHint => 'Kapitel, Seiten, Personen …';
	@override String get unit => 'Einheit hinter der Zahl';
	@override String get unitHint => 'Personen';
	@override String get duration => 'Eine Dauer';
	@override String get durationHint => 'In Stunden und Minuten';
	@override String get noMeasure => 'Wähle mindestens eine Messgröße: eine Anzahl, eine Dauer oder beides.';
	@override String get preview => 'Vorschau in deinem Bericht';
	@override String get previewCode => 'CODE';
	@override String get previewLabel => 'Name des Elements';
	@override String get submit => 'Element erstellen';
	@override String created({required Object code}) => '${code} wurde erstellt.';
	@override String get codeTaken => 'Dieser Code wird schon verwendet, von einem Standardelement oder von einem deiner Elemente (auch archiviert).';
	@override String get codeHint => 'EVG';
	@override String get labelHint => 'Evangelisation';
}

// Path: more
class _Translations$more$de extends Translations$more$fr {
	_Translations$more$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Mehr';
	@override String get editProfile => 'Profil bearbeiten';
	@override String get community => 'Gemeinschaft';
	@override String get events => 'Veranstaltungen';
	@override String get reports => 'Tagesbericht';
	@override String get myItems => 'Meine Elemente';
	@override String get app => 'App';
	@override String get language => 'Sprache';
	@override String get appearance => 'Darstellung';
	@override String get themeSystem => 'Automatisch';
	@override String get themeSystemHint => 'Bei „Automatisch“ folgt die App dem hellen oder dunklen Modus deines Handys.';
	@override String get themeLight => 'Hell';
	@override String get themeDark => 'Dunkel';
	@override String get logout => 'Abmelden';
	@override String get account => 'Konto';
	@override String get languageTitle => 'Sprache der App';
	@override String get completeProfile => 'Füge deinen Namen hinzu';
	@override String get accompaniment => 'Begleitung';
	@override String get exportReport => 'Meinen Bericht exportieren';
	@override String get logoutPendingTitle => 'Noch nicht gesendete Tage';
	@override String logoutPendingText({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
		one: '${n} ohne Netz gespeicherter Tag wurde noch nicht gesendet. Wenn du dich jetzt abmeldest, geht er verloren.',
		other: '${n} ohne Netz gespeicherte Tage wurden noch nicht gesendet. Wenn du dich jetzt abmeldest, gehen sie verloren.',
	);
	@override String get logoutAnyway => 'Trotzdem abmelden';
	@override String get admin => 'Verwaltung';
	@override String get staff => 'Team und Rollen';
	@override String get manageEvents => 'Veranstaltungen';
	@override String get disciples => 'Meine Jünger';
	@override String version({required Object version}) => 'Version ${version}';
	@override String copyright({required Object year}) => '© ${year} Christian Missionary Fellowship International. Alle Rechte vorbehalten.';
}

// Path: authorities
class _Translations$authorities$de extends Translations$authorities$fr {
	_Translations$authorities$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Meine geistlichen Autoritäten';
	@override String get intro => 'Die Menschen, die dich auf deinem Weg mit Gott begleiten: dein Jüngermacher und deine anderen Verantwortlichen.';
	@override String get discipleMaker => 'Jüngermacher';
	@override String discipleMakerOf({required Object name}) => 'Jüngermacher: ${name}';
	@override String get noDiscipleMaker => 'Noch kein Jüngermacher';
	@override String get others => 'Weitere Autoritäten';
	@override String get empty => 'Du hast noch niemanden hinzugefügt.';
	@override String get add => 'Autorität hinzufügen';
	@override String get remove => 'Entfernen';
	@override String removeTitle({required Object name}) => '${name} entfernen?';
	@override String removeText({required Object name}) => '${name} gehört dann nicht mehr zu deinen geistlichen Autoritäten.';
	@override String removed({required Object name}) => '${name} gehört nicht mehr zu deinen Autoritäten.';
	@override String count({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
		zero: 'Noch niemand',
		one: '${n} Person',
		other: '${n} Personen',
	);
	@override late final _Translations$authorities$form$de form = _Translations$authorities$form$de._(_root);
	@override String get statusPending => 'Ausstehend';
	@override String get statusDeclined => 'Abgelehnt';
	@override String pendingHelp({required Object name}) => 'Die Kontaktdaten erscheinen, sobald ${name} angenommen hat.';
	@override String get requests => 'Erhaltene Anfragen';
	@override String get requestDiscipleMaker => 'möchte dich als Jüngermacher';
	@override String get requestAuthority => 'bittet dich um Begleitung';
	@override String get accept => 'Annehmen';
	@override String get decline => 'Ablehnen';
	@override String acceptedRequest({required Object name}) => 'Du begleitest jetzt ${name}.';
	@override String declinedRequest({required Object name}) => 'Anfrage von ${name} abgelehnt.';
	@override String requestsCount({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
		one: '${n} offene Anfrage',
		other: '${n} offene Anfragen',
	);
	@override late final _Translations$authorities$sharing$de sharing = _Translations$authorities$sharing$de._(_root);
}

// Path: members
class _Translations$members$de extends Translations$members$fr {
	_Translations$members$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get username => 'Benutzername';
	@override String get usernameHint => 'vorname.nachname';
	@override String get usernameHelp => 'So finden dich die anderen Mitglieder.';
	@override String get usernameChecking => 'Wird geprüft …';
	@override String usernameFree({required Object username}) => '@${username} ist verfügbar';
	@override String get usernameCurrent => 'Das ist dein aktueller Benutzername';
	@override String get usernameTaken => 'Dieser Benutzername ist bereits vergeben.';
	@override String get usernameInvalid => '3 bis 30 Zeichen: Buchstaben, Ziffern, „.“ und „_“; nicht mit einem Sonderzeichen beginnen oder enden.';
	@override String get usernameReserved => 'Dieser Benutzername ist reserviert.';
	@override String usernameSaved({required Object username}) => 'Benutzername gespeichert: @${username}';
	@override late final _Translations$members$deleteAccount$de deleteAccount = _Translations$members$deleteAccount$de._(_root);
}

// Path: admin
class _Translations$admin$de extends Translations$admin$fr {
	_Translations$admin$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Team und Rollen';
	@override String get intro => 'Admins verwalten, was die ganze Gemeinschaft teilt. Nur ein Superadmin kann Rollen vergeben oder entziehen.';
	@override String get roleUser => 'Mitglied';
	@override String get roleAdmin => 'Admin';
	@override String get roleSuperadmin => 'Superadmin';
	@override String get giveRole => 'Rolle vergeben';
	@override String get you => 'du';
	@override String roleFor({required Object username}) => 'Rolle von @${username}';
	@override String roleChanged({required Object username, required Object role}) => '@${username}: ${role}';
	@override String get memberUsername => 'Benutzername des Mitglieds';
	@override String get empty => 'Noch keine Admins.';
}

// Path: hymns
class _Translations$hymns$de extends Translations$hymns$fr {
	_Translations$hymns$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get searchHint => 'Nummer, Titel oder Text';
	@override String get openNumber => 'Zu Nummer springen';
	@override late final _Translations$hymns$tabs$de tabs = _Translations$hymns$tabs$de._(_root);
	@override String get chooseBook => 'Liederbuch wählen';
	@override String count({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
		one: '${n} Lied',
		other: '${n} Lieder',
	);
	@override String number({required Object number}) => 'Nr. ${number}';
	@override String get emptyFavorites => 'Tippe auf den Stern eines Liedes, um es hier wiederzufinden.';
	@override String get emptyRecent => 'Die Lieder, die du öffnest, erscheinen hier.';
	@override String noResult({required Object query}) => 'Kein Lied passt zu „${query}“.';
	@override String get otherBooks => 'In den anderen Liederbüchern';
	@override String get upToDate => 'Die Liederbücher sind auf dem neuesten Stand.';
	@override String get updated => 'Die Liederbücher wurden aktualisiert.';
	@override String get chorus => 'Refrain';
	@override String chorusNumber({required Object label}) => 'Refrain ${label}';
	@override String verse({required Object label}) => 'Strophe ${label}';
	@override String times({required Object n}) => '×${n}';
	@override String get loadFailed => 'Die Liederbücher konnten nicht geöffnet werden.';
	@override late final _Translations$hymns$reader$de reader = _Translations$hymns$reader$de._(_root);
	@override late final _Translations$hymns$projection$de projection = _Translations$hymns$projection$de._(_root);
	@override late final _Translations$hymns$pad$de pad = _Translations$hymns$pad$de._(_root);
}

// Path: comingSoon
class _Translations$comingSoon$de extends Translations$comingSoon$fr {
	_Translations$comingSoon$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get badge => 'Bald verfügbar';
	@override String get backHome => 'Zurück zum Start';
}

// Path: events
class _Translations$events$de extends Translations$events$fr {
	_Translations$events$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Veranstaltungen';
	@override String get featured => 'Im Fokus';
	@override String get upcoming => 'Demnächst';
	@override String get past => 'Frühere Ausgaben';
	@override String get emptyTitle => 'Keine anstehenden Veranstaltungen';
	@override String get emptyText => 'Konferenzen und Treffen der ganzen Gemeinschaft erscheinen hier, mit ihrem Programm.';
	@override String get manage => 'Veranstaltungen verwalten';
	@override String get next => 'Nächste Veranstaltung';
	@override String get seeAll => 'Alle Veranstaltungen';
	@override String get homeText => 'Die Treffen der Gemeinschaft, ihr Programm und ihre Neuigkeiten.';
	@override String get today => 'Heute';
	@override String get tomorrow => 'Morgen';
	@override String inDays({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
		one: 'In ${n} Tag',
		other: 'In ${n} Tagen',
	);
	@override String daysLeft({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
		other: 'Noch ${n} Tage',
	);
	@override String get onNow => 'Läuft gerade';
	@override String get over => 'Beendet';
	@override String get cancelled => 'Abgesagt';
	@override String get draft => 'Entwurf';
	@override String get registered => 'Angemeldet';
	@override String get stateOpen => 'Anmeldung offen';
	@override String get stateClosed => 'Anmeldung geschlossen';
	@override String get stateFull => 'Ausgebucht';
	@override String registrations({required num n, required Object count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
		zero: 'Noch niemand angemeldet: mach den Anfang!',
		one: '${count} angemeldet',
		other: '${count} angemeldet',
	);
	@override String people({required num n, required Object count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
		one: '${count} Person',
		other: '${count} Personen',
	);
	@override String placesLeft({required num n, required Object count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
		zero: 'keine Plätze mehr',
		one: '${count} Platz frei',
		other: '${count} Plätze frei',
	);
	@override String oneDay({required Object start, required Object end}) => 'Von ${start} bis ${end}';
	@override String severalDays({required Object startDay, required Object start, required Object endDay, required Object end}) => 'Beginn am ${startDay} um ${start}, Ende am ${endDay} um ${end}';
	@override String venueTime({required Object place}) => 'Ortszeit ${place}';
	@override String get addToCalendar => 'Zum Kalender hinzufügen';
	@override String get share => 'Teilen';
	@override String get directions => 'Route';
	@override String get viewPoster => 'Plakat ansehen';
	@override late final _Translations$events$tabs$de tabs = _Translations$events$tabs$de._(_root);
	@override String get noProgram => 'Das Programm wird bald veröffentlicht.';
	@override String get noNews => 'Noch keine Neuigkeiten zu dieser Veranstaltung.';
	@override String get pinned => 'Angeheftet';
	@override String get now => 'Gerade jetzt';
	@override String hymn({required Object number}) => 'Lied ${number}';
	@override String get about => 'Beschreibung';
	@override String get fees => 'Kosten';
	@override String deadline({required Object date}) => 'Anmeldung bis ${date}';
	@override String get contact => 'Kontakt';
	@override String call({required Object name}) => '${name} anrufen';
	@override String get otherEditions => 'Weitere Ausgaben';
	@override String get cancelledBanner => 'Diese Veranstaltung ist abgesagt.';
	@override String get calendarFailed => 'Der Kalender des Handys konnte nicht geöffnet werden.';
	@override String get linkFailed => 'Dieser Link konnte nicht geöffnet werden.';
	@override String shareText({required Object title, required Object dates, required Object place}) => '${title}\n${dates} · ${place}\nMelde dich in der App CMFI Connect an.';
	@override String get full => 'Für diese Veranstaltung sind keine Plätze mehr frei.';
	@override String get closed => 'Die Anmeldung für diese Veranstaltung ist geschlossen.';
	@override late final _Translations$events$register$de register = _Translations$events$register$de._(_root);
	@override late final _Translations$events$reminder$de reminder = _Translations$events$reminder$de._(_root);
	@override late final _Translations$events$admin$de admin = _Translations$events$admin$de._(_root);
	@override String upcomingCount({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
		one: '${n} bevorstehende Veranstaltung',
		other: '${n} bevorstehende Veranstaltungen',
	);
	@override String slide({required Object current, required Object total}) => 'Veranstaltung ${current} von ${total}';
}

// Path: notifications
class _Translations$notifications$de extends Translations$notifications$fr {
	_Translations$notifications$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Mitteilungen';
	@override String get channel => 'Ankündigungen der Gemeinschaft';
	@override String get empty => 'Noch keine Mitteilungen';
	@override String get emptyHint => 'Die Ankündigungen der Gemeinschaft erscheinen hier.';
	@override String unreadLabel({required Object title}) => 'Ungelesen: ${title}';
	@override String documents({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
		one: '${n} PDF-Dokument',
		other: '${n} PDF-Dokumente',
	);
	@override String unread({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
		one: '${n} ungelesen',
		other: '${n} ungelesen',
	);
	@override String image({required Object n}) => 'Bild ${n}';
	@override String get document => 'PDF-Dokument';
	@override String documentSize({required Object kb}) => '${kb} KB';
	@override String received({required Object title}) => 'Neue Mitteilung: ${title}';
}

// Path: premium
class _Translations$premium$de extends Translations$premium$fr {
	_Translations$premium$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get name => 'CMFI Connect Premium';
	@override String get pill => 'Premium';
	@override String get subtitle => 'Geh weiter auf deinem Weg mit Gott und unterstütze das Werk.';
	@override String get widgetTitle => 'Das Widget für den Startbildschirm';
	@override String get widgetText => 'Dein Tagesbericht und deine Ziele, ohne die App zu öffnen.';
	@override String get statsTitle => 'Deine Ziele über das Jahr';
	@override String get statsText => 'Die Jahresbilanz und die Entwicklung deiner Ziele, Woche für Woche.';
	@override String get supportTitle => 'Du unterstützt das Werk';
	@override String get supportText => 'Dein Abo hält die App für die ganze Gemeinschaft am Leben.';
	@override String get annual => 'Jährlich';
	@override String get lifetime => 'Lebenslang';
	@override String get monthly => 'Monatlich';
	@override String perYear({required Object price}) => '${price} / Jahr';
	@override String once({required Object price}) => '${price} einmalig';
	@override String perMonth({required Object price}) => '${price} / Monat';
	@override String annualPerMonth({required Object price}) => 'also ${price} pro Monat';
	@override String get best => 'Am günstigsten';
	@override String trialDays({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
		one: '${n} Tag gratis testen',
		other: '${n} Tage gratis testen',
	);
	@override String trialMonths({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
		one: '${n} Monat gratis testen',
		other: '${n} Monate gratis testen',
	);
	@override String get subscribe => 'Abonnieren';
	@override String get startTrial => 'Gratis testen';
	@override String get restore => 'Käufe wiederherstellen';
	@override String get restored => 'Premium ist wieder auf diesem Telefon';
	@override String get nothingToRestore => 'Kein Premium-Kauf für dieses Konto';
	@override String get thanks => 'Danke! Premium ist aktiv.';
	@override String get failed => 'Der Kauf hat nicht geklappt. Versuch es gleich noch einmal.';
	@override String get unavailable => 'Die Angebote sind gerade nicht verfügbar.';
	@override String renews({required Object store}) => 'Das Abo verlängert sich automatisch. Du kannst es jederzeit in den Einstellungen deines ${store}-Kontos kündigen.';
	@override String get terms => 'Nutzungsbedingungen';
	@override String get privacy => 'Datenschutz';
	@override String get activeTitle => 'Du hast Premium';
	@override String get activeText => 'Danke, dass du CMFI Connect unterstützt! Das Widget und das Jahr deiner Bilanz sind offen.';
	@override String get staffText => 'Premium ist für dich kostenlos, weil du zum Team von CMFI Connect gehörst.';
	@override String get moreSubtitle => 'Widget, Ziele über das Jahr';
	@override String get moreActive => 'Aktiv';
	@override String get unlock => 'Mit Premium freischalten';
	@override String trialThen({required Object trial, required Object price}) => '${trial}, danach ${price}';
	@override String savePercent({required Object percent}) => '−${percent}';
	@override String get choose => 'Wähle dein Angebot';
	@override String get cancelAnytime => 'Ohne Bindung, jederzeit kündbar';
	@override String get restoreShort => 'Wiederherstellen';
	@override String get termsShort => 'Bedingungen';
	@override String get semiannual => 'Halbjährlich';
	@override String perSemester({required Object price}) => '${price} / 6 Monate';
	@override String get buyLifetime => 'Lebenslang kaufen';
	@override String get lifetimeNote => 'Lebenslang: eine einzige Zahlung, kein Abo, keine Verlängerung.';
	@override String get manage => 'Mein Abo verwalten';
	@override String get manageFailed => 'Die Abo-Verwaltung öffnet sich nicht. Versuche es später noch einmal.';
}

// Path: homeWidget
class _Translations$homeWidget$de extends Translations$homeWidget$fr {
	_Translations$homeWidget$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Heute';
	@override String get done => 'Erledigt';
	@override String get todo => 'Auszufüllen';
	@override String get open => 'Ausfüllen';
	@override String get locked => 'Aktiviere das Widget mit Premium';
	@override String get signedOut => 'Melde dich in der App an';
}

// Path: ministry
class _Translations$ministry$de extends Translations$ministry$fr {
	_Translations$ministry$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Unser Dienst';
	@override String get tagline => 'Bis an die Enden der Erde';
	@override String count({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
		one: '${n} Nation',
		other: '${n} Nationen',
	);
	@override String get fromYaounde => 'Von Yaoundé aus geht das Evangelium von Nation zu Nation.';
	@override String get dragHint => 'Dreh den Globus mit dem Finger, tippe auf eine Nation.';
	@override String globeLabel({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
		one: 'Globus: ${n} Nation, in der das Werk vertreten ist. Die Liste unten nennt sie.',
		other: 'Globus: ${n} Nationen, in denen das Werk vertreten ist. Die Liste unten nennt sie alle.',
	);
	@override String get voyage => 'Reise';
	@override String get pause => 'Pause';
	@override String get previous => 'Vorherige Nation';
	@override String get next => 'Nächste Nation';
	@override String number({required Object n}) => 'Nation Nr. ${n}';
	@override String since({required Object year}) => 'Seit ${year}';
	@override String get pray => 'Beten';
	@override String prayTitle({required Object country}) => 'Beten für ${country}';
	@override String prayThanks({required Object country}) => 'Danke für Gottes Werk in ${country}.';
	@override String prayAssemblies({required Object country}) => 'Bete für die Gemeinden in ${country} und ihre Leiter.';
	@override String prayUnreached({required Object country}) => 'Bete, dass die, die in ${country} noch nicht glauben, Jesus begegnen.';
	@override String get purpose => 'Unser Ziel';
	@override String get nations => 'Die Nationen';
	@override String get search => 'Nation suchen';
	@override String get none => 'Keine Nation gefunden';
	@override String homeText({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
		one: 'In ${n} Nation vertreten',
		other: 'In ${n} Nationen vertreten',
	);
	@override String get nationsSubtitle => 'Der Globus und die Reise von Nation zu Nation';
	@override String get purposeSubtitle => 'Unsere drei Ziele';
	@override String get missionaries => 'Unsere Missionare';
	@override String get missionariesSubtitle => 'Die, die der Herr zu den Nationen sendet';
	@override String get heroes => 'Unsere Helden';
	@override String get heroesSubtitle => 'Die, deren Glaube uns inspiriert';
	@override String get founder => 'Unser Gründer';
	@override String get founderSubtitle => 'Prof. Zacharias Tanee Fomum';
	@override String get leader => 'Unser Leiter';
	@override String get leaderSubtitle => 'Theodore Andoseh';
	@override String get missionariesEmpty => 'Die Porträts unserer Missionare kommen bald.';
	@override String get heroesEmpty => 'Die Porträts unserer Helden kommen bald.';
	@override String get personGone => 'Dieses Porträt ist nicht mehr verfügbar.';
	@override String photoOf({required Object name}) => 'Foto von ${name}';
	@override String get keyDates => 'Wichtige Daten';
	@override String get life => 'Sein Leben';
	@override String get story => 'Lebensgeschichte';
	@override String goalOf({required Object n, required Object total}) => 'UNSER ZIEL · ${n}/${total}';
	@override String get previousGoal => 'Vorheriges Ziel';
	@override String get nextGoal => 'Nächstes Ziel';
	@override Map<String, String> get media => {
		'books': 'Bücher',
		'tracts': 'Traktate',
		'magazines': 'Zeitschriften',
		'cds': 'CDs',
		'dvds': 'DVDs',
		'radio': 'Radio',
		'tv': 'Fernsehen',
		'internet': 'Internet',
	};
	@override late final _Translations$ministry$goals$de goals = _Translations$ministry$goals$de._(_root);
	@override late final _Translations$ministry$lives$de lives = _Translations$ministry$lives$de._(_root);
}

// Path: prayer
class _Translations$prayer$de extends Translations$prayer$fr {
	_Translations$prayer$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override Map<String, String> get moments => {
		'morning': 'Morgen',
		'noon': 'Mittag',
		'evening': 'Abend',
		'night': 'Nacht',
	};
	@override Map<String, String> get retreatOf => {
		'morning': 'Gebetszeit am Morgen',
		'noon': 'Gebetszeit am Mittag',
		'evening': 'Gebetszeit am Abend',
		'night': 'Gebetszeit zur Nacht',
	};
	@override late final _Translations$prayer$hero$de hero = _Translations$prayer$hero$de._(_root);
	@override late final _Translations$prayer$today$de today = _Translations$prayer$today$de._(_root);
	@override late final _Translations$prayer$routine$de routine = _Translations$prayer$routine$de._(_root);
	@override String get together => 'Gemeinsam beten';
	@override late final _Translations$prayer$reminders$de reminders = _Translations$prayer$reminders$de._(_root);
	@override late final _Translations$prayer$retreat$de retreat = _Translations$prayer$retreat$de._(_root);
	@override late final _Translations$prayer$session$de session = _Translations$prayer$session$de._(_root);
	@override late final _Translations$prayer$done$de done = _Translations$prayer$done$de._(_root);
	@override late final _Translations$prayer$topics$de topics = _Translations$prayer$topics$de._(_root);
	@override late final _Translations$prayer$lists$de lists = _Translations$prayer$lists$de._(_root);
	@override late final _Translations$prayer$importunity$de importunity = _Translations$prayer$importunity$de._(_root);
}

// Path: sending
class _Translations$sending$de extends Translations$sending$fr {
	_Translations$sending$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'An meine Leiter senden';
	@override String get moreOff => 'Aus';
	@override String get intro => 'Zur gewählten Zeit bereitet CMFI Connect deinen Bericht für den Zeitraum vor. Du musst ihn nur noch an deine geistlichen Leiter senden.';
	@override String get enabled => 'Regelmäßig für mich vorbereiten';
	@override String get rhythm => 'Rhythmus';
	@override String get weekly => 'Jede Woche';
	@override String get biweekly => 'Alle 2 Wochen';
	@override String get monthly => 'Jeden Monat';
	@override String get day => 'Tag';
	@override String get monthlyDay => 'Am 1. jedes Monats, für den vergangenen Monat';
	@override String get time => 'Uhrzeit';
	@override String get recipients => 'Empfänger';
	@override String get noAuthorities => 'Füge zuerst deine geistlichen Leiter hinzu.';
	@override String get addAuthorities => 'Meine Leiter hinzufügen';
	@override String get viaWhatsApp => 'Per WhatsApp';
	@override String get viaEmail => 'Per E-Mail';
	@override String get viaBoth => 'Per WhatsApp oder E-Mail';
	@override String get viaShare => 'Über Teilen';
	@override String next({required Object date}) => 'Nächster: ${date}';
	@override String get prepareNow => 'Jetzt vorbereiten';
	@override String get history => 'Zuletzt gesendet';
	@override String get notificationTitle => 'Dein Bericht ist fertig';
	@override String get notificationBody => 'Sende ihn mit einem Tippen an deine Leiter.';
	@override String get channel => 'Berichtsversand';
	@override String get readyTitle => 'Dein Bericht ist fertig';
	@override String get preview => 'Vorschau der Nachricht';
	@override String greeting({required Object name}) => 'Hallo ${name},';
	@override String get whatsApp => 'WhatsApp';
	@override String get email => 'E-Mail';
	@override String get sharePdf => 'PDF teilen';
	@override String get shareText => 'Text teilen';
	@override String get sent => 'Gesendet';
	@override String get shared => 'Geteilt';
	@override String get noRecipients => 'Wähle deine Empfänger in den Einstellungen oder teile das PDF.';
	@override String get settings => 'Einstellungen';
	@override String get permissionDenied => 'Erlaube Benachrichtigungen, um rechtzeitig erinnert zu werden.';
}

// Path: streak
class _Translations$streak$de extends Translations$streak$fr {
	_Translations$streak$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String title({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
		one: '${n} Tag in Folge!',
		other: '${n} Tage in Folge!',
	);
	@override String cardDays({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
		one: 'Tag mit Gott',
		other: 'Tage mit Gott',
	);
	@override late final _Translations$streak$lines$de lines = _Translations$streak$lines$de._(_root);
	@override String get share => 'Teilen';
	@override String get close => 'Weiter';
}

// Path: shortcuts
class _Translations$shortcuts$de extends Translations$shortcuts$fr {
	_Translations$shortcuts$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get today => 'Meinen Bericht ausfüllen';
	@override String get hymns => 'Lieder';
	@override String get retreat => 'Aktuelle Gebetszeit';
}

// Path: blocking
class _Translations$blocking$de extends Translations$blocking$fr {
	_Translations$blocking$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get report => 'Melden';
	@override String block({required Object name}) => '${name} blockieren';
	@override String blockTitle({required Object name}) => '${name} blockieren?';
	@override String blockText({required Object name}) => 'Du erhältst keine Einladungen mehr von ${name}. Diese Einladung wird entfernt.';
	@override String get blockAction => 'Blockieren';
	@override String blocked({required Object name}) => '${name} kann dich nicht mehr einladen.';
	@override String get reportTitle => 'Diese Einladung melden';
	@override String get reportText => 'Sag uns, was nicht stimmt: Die Verantwortlichen der Gemeinschaft sehen es sich an.';
	@override late final _Translations$blocking$reasons$de reasons = _Translations$blocking$reasons$de._(_root);
	@override String get comment => 'Kommentar';
	@override String get commentHint => 'Was die Verantwortlichen wissen sollten';
	@override String get send => 'Meldung senden';
	@override String get reported => 'Danke, die Verantwortlichen sehen es sich an.';
	@override String get listTitle => 'Blockierte Mitglieder';
	@override String get intro => 'Ihre Gebetseinladungen erreichen dich nicht mehr.';
	@override String get empty => 'Du hast niemanden blockiert.';
	@override String get unblock => 'Freigeben';
	@override String unblocked({required Object name}) => '${name} kann dich wieder einladen.';
}

// Path: verses
class _Translations$verses$de extends Translations$verses$fr {
	_Translations$verses$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Vers des Tages';
	@override String get share => 'Vers teilen';
	@override String get shareImage => 'Bild teilen';
	@override String get shareText => 'Text teilen';
}

// Path: bible
class _Translations$bible$de extends Translations$bible$fr {
	_Translations$bible$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Bibel';
	@override String get books => 'Bücher';
	@override String get oldTestament => 'Altes Testament';
	@override String get newTestament => 'Neues Testament';
	@override String chapters({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
		one: '${n} Kapitel',
		other: '${n} Kapitel',
	);
	@override String chapter({required Object n}) => 'Kapitel ${n}';
	@override String get version => 'Übersetzung';
	@override String get versions => 'Bibelübersetzung';
	@override String get search => 'In der Bibel suchen';
	@override String get searchHint => 'Ein Wort oder „Johannes 3,16“';
	@override String get searchTip => 'Suche ein Wort („Liebe“) oder springe direkt zu einer Stelle („Psalm 23“, „Johannes 3,16“).';
	@override String get searchNone => 'Kein Vers enthält diese Wörter.';
	@override String searchCount({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
		one: '${n} Vers',
		other: '${n} Verse',
	);
	@override String searchLimit({required Object n}) => 'Die ersten ${n} Verse';
	@override String get searchNeedsDownload => 'Um Wörter in der ganzen Bibel zu suchen, lade sie herunter. Eine Stelle kannst du schon eingeben: „Johannes 3,16“.';
	@override String open({required Object reference}) => '${reference} öffnen';
	@override String get previous => 'Vorheriges Kapitel';
	@override String get next => 'Nächstes Kapitel';
	@override String get markRead => 'Ich habe dieses Kapitel gelesen';
	@override String get markedRead => 'Heute gelesen';
	@override String get markReadHint => 'Fügt deinem Bericht 1 Kapitel bei „Bibellesen“ hinzu.';
	@override String addedToReport({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
		one: 'Bericht: heute ${n} Kapitel gelesen',
		other: 'Bericht: heute ${n} Kapitel gelesen',
	);
	@override String get removedFromReport => 'Aus deinem Bericht entfernt';
	@override String get noReadingItem => 'Dein Bericht hat keinen Punkt „Bibellesen“.';
	@override String get download => 'Diese Bibel herunterladen';
	@override String downloadHelp({required Object size}) => 'Etwa ${size} MB, um ohne Netz zu lesen und zu suchen.';
	@override String downloading({required Object percent}) => 'Wird geladen… ${percent} %';
	@override String get downloaded => 'Auf deinem Handy';
	@override String downloadDone({required Object version}) => '${version} ist auf deinem Handy';
	@override String get removeDownload => 'Vom Handy entfernen';
	@override String removeDownloadTitle({required Object version}) => '${version} vom Handy entfernen?';
	@override String get removeDownloadText => 'Die Kapitel, die du schon gelesen hast, bleiben ohne Netz verfügbar.';
	@override String get offline => 'Dieses Kapitel ist noch nicht auf deinem Handy. Geh wieder online oder lade diese Bibel herunter, um sie ohne Netz zu lesen.';
	@override String get notInVersion => 'Diese Stelle gibt es in dieser Übersetzung nicht.';
	@override String get marks => 'Meine Verse';
	@override String get favorites => 'Gemerkt';
	@override String get highlights => 'Markiert';
	@override String get noFavorites => 'Tippe auf einen Vers und dann auf das Lesezeichen, um ihn hier wiederzufinden.';
	@override String get noHighlights => 'Tippe auf einen Vers und dann auf eine Farbe, um ihn zu markieren.';
	@override String get tapHint => 'Tippe auf einen Vers, um ihn zu markieren, zu merken, zu kopieren oder zu teilen.';
	@override String highlight({required Object color}) => '${color} markieren';
	@override late final _Translations$bible$colors$de colors = _Translations$bible$colors$de._(_root);
	@override String get removeHighlight => 'Farbe entfernen';
	@override String get addFavorite => 'Zu Meine Verse hinzufügen';
	@override String get removeFavorite => 'Aus Meine Verse entfernen';
	@override String get favoriteAdded => 'Zu Meine Verse hinzugefügt';
	@override String get favoriteRemoved => 'Aus Meine Verse entfernt';
	@override String get copy => 'Kopieren';
	@override String get copied => 'Kopiert';
	@override String get share => 'Teilen';
	@override String get closeSelection => 'Auswahl schließen';
	@override String get display => 'Anzeige';
	@override String get jesusInRed => 'Worte Jesu in Rot';
	@override String get jesusInRedHelp => 'In den Übersetzungen, die sie kennzeichnen';
	@override String get remove => 'Entfernen';
	@override String get readInBible => 'In der Bibel lesen';
	@override String get concordance => 'Konkordanz';
	@override String concordanceOf({required Object word}) => 'Konkordanz zu „${word}“';
	@override String get concordanceHint => 'Ein Wort der Bibel';
	@override String get concordanceTip => 'Gib ein Wort ein: Die Konkordanz zeigt jeden Vers, in dem es vorkommt, Buch für Buch.';
	@override String get concordanceNeedsDownload => 'Die Konkordanz durchsucht die ganze Bibel: Lade sie zuerst herunter.';
	@override String get concordanceNone => 'Dieses Wort steht nicht in dieser Bibel.';
	@override String get exactWord => 'Dieses Wort';
	@override String get startsWith => 'Beginnt mit…';
	@override String occurrences({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
		one: 'Vorkommen',
		other: 'Vorkommen',
	);
	@override String inVerses({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
		one: 'in ${n} Vers',
		other: 'in ${n} Versen',
	);
	@override String get spread => 'Wo dieses Wort vorkommt';
	@override String get forms => 'Gefundene Formen';
	@override String bookCount({required Object book, required Object n}) => '${book}: ${n}';
	@override String get allBooks => 'Alle Bücher';
	@override String get pickWord => 'Wähle ein Wort';
	@override String get pickWordHelp => 'Die Konkordanz zeigt jeden Vers, in dem es vorkommt.';
	@override String get more => 'Weitere Optionen';
}

// Path: profilePhoto
class _Translations$profilePhoto$de extends Translations$profilePhoto$fr {
	_Translations$profilePhoto$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Profilbild';
	@override String get add => 'Profilbild hinzufügen';
	@override String get change => 'Profilbild ändern';
	@override String get seenBy => 'Andere Mitglieder sehen es überall, wo dein Name erscheint.';
	@override String get camera => 'Foto aufnehmen';
	@override String get gallery => 'Aus der Galerie wählen';
	@override String get remove => 'Foto entfernen';
	@override String get cropTitle => 'Foto zuschneiden';
	@override String get cropHint => 'Verschiebe und vergrößere das Foto mit deinen Fingern.';
	@override String get use => 'Dieses Foto verwenden';
	@override String get unreadable => 'Dieses Bild lässt sich nicht öffnen. Wähle ein anderes.';
	@override String get saved => 'Dein Profilbild ist gespeichert.';
	@override String get removed => 'Dein Profilbild ist entfernt.';
}

// Path: disciples
class _Translations$disciples$de extends Translations$disciples$fr {
	_Translations$disciples$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Meine Jünger';
	@override String get empty => 'Noch keine Jünger';
	@override String get emptyText => 'Wenn ein Mitglied dich als Jüngermacher oder als Autorität wählt und du die Anfrage annimmst, erscheint es hier.';
	@override String count({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
		one: '${n} Jünger',
		other: '${n} Jünger',
	);
	@override String get notShared => 'Teilt seine Berichte nicht';
	@override String get roleMaker => 'Du bist sein Jüngermacher';
	@override String get roleAuthority => 'Du bist eine seiner Autoritäten';
	@override String dayGoals({required Object percent}) => 'Ziele ${percent} %';
	@override String dayItems({required Object filled, required Object total, required Object percent}) => '${filled} von ${total} Punkten · ${percent} %';
	@override String get older => 'Die 30 Tage davor ansehen';
	@override String get noReports => 'Kein Bericht in diesem Zeitraum.';
	@override String get searchHint => 'Name oder Benutzername';
	@override String noMatch({required Object search}) => 'Kein Jünger passt zu „${search}“.';
}

// Path: weekStory
class _Translations$weekStory$de extends Translations$weekStory$fr {
	_Translations$weekStory$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Deine Woche mit Gott';
	@override String range({required Object from, required Object to}) => '${from} bis ${to}';
	@override String get intro => 'Schau zurück auf das, was du diese Woche mit dem Herrn erlebt hast.';
	@override String get tapHint => 'Tippe rechts, um weiterzugehen, links, um zurückzugehen.';
	@override String get faithfulLead => 'Du warst treu';
	@override String get emptyLead => 'Eine neue Woche wartet auf dich';
	@override String days({required num n, required Object total}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
		one: '${n} Tag\nvon ${total}',
		other: '${n} Tage\nvon ${total}',
	);
	@override String streak({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
		one: '${n} Tag in Folge',
		other: '${n} Tage in Folge',
	);
	@override String streakRecord({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
		one: '${n} Tag in Folge: dein Rekord!',
		other: '${n} Tage in Folge: dein Rekord!',
	);
	@override String get emptyText => 'Fülle deinen Bericht jeden Tag aus: Deine nächste Woche wird hier geschrieben.';
	@override String get prayerLead => 'Du hast gebetet';
	@override String retreats({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
		one: '${n} Gebetszeit',
		other: '${n} Gebetszeiten',
	);
	@override String retreatsTime({required Object time}) => 'von 15 Minuten · ${time} mit dem Herrn';
	@override String faithfulMoment({required num n, required Object moment}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
		one: 'Deine treueste Zeit: ${moment} (${n}-mal)',
		other: 'Deine treueste Zeit: ${moment} (${n}-mal)',
	);
	@override String get noRetreat => 'Keine Gebetszeit diese Woche';
	@override String get noRetreatText => 'Die Gebetszeit am Mittag wartet auf dich: 15 Minuten mit dem Herrn.';
	@override String get goalsLead => 'Deine Ziele';
	@override String get goalsReached => 'im Durchschnitt erreicht';
	@override String bestDay({required Object day, required Object percent}) => 'Dein bester Tag: ${day} · ${percent}';
	@override String get summaryTitle => 'Meine Woche mit Gott';
	@override String get statDays => 'ausgefüllte Tage';
	@override String statStreak({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
		one: 'Tag in Folge',
		other: 'Tage in Folge',
	);
	@override String statRetreats({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
		one: 'Gebetszeit',
		other: 'Gebetszeiten',
	);
	@override String get statGoals => 'der Ziele';
	@override String get share => 'Meine Woche teilen';
	@override String get homeText => 'Deine Treue, dein Gebet und deine Ziele dieser Woche.';
	@override String get open => 'Meine Woche ansehen';
	@override String get notificationTitle => 'Deine Woche mit Gott ist bereit';
	@override String get notificationBody => 'Schau auf deine Treue dieser Woche zurück und teile sie.';
	@override String get channel => 'Deine Woche mit Gott';
	@override String get thisWeek => 'Diese Woche';
	@override String get pastWeeks => 'Vergangene Wochen';
	@override String weekOf({required Object date}) => 'Woche vom ${date}';
	@override String page({required Object current, required Object total}) => '${current} von ${total}';
}

// Path: seekFirst
class _Translations$seekFirst$de extends Translations$seekFirst$fr {
	_Translations$seekFirst$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Suche zuerst Gott';
	@override String get verse => 'Trachtet am ersten nach dem Reich Gottes und nach seiner Gerechtigkeit, so wird euch solches alles zufallen.';
	@override String get verseRef => 'Matthäus 6,33';
	@override String get intro => 'Jeden Tag bleiben die Apps, die du wählst, geschlossen, bis dein Bericht gespeichert ist. Beginne deinen Tag mit Gott, der Rest folgt.';
	@override String get enable => 'Einschalten';
	@override String get apps => 'Geschlossene Apps';
	@override String get appsNone => 'Keine App gewählt';
	@override String appCount({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
		one: '${n} App',
		other: '${n} Apps',
	);
	@override String categoryCount({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
		one: '${n} Kategorie',
		other: '${n} Kategorien',
	);
	@override String siteCount({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
		one: '${n} Website',
		other: '${n} Websites',
	);
	@override String get start => 'Geschlossen ab';
	@override String get pauses => '5-Minuten-Pausen';
	@override String get pausesText => '3 pro Tag, für einen Notfall';
	@override String pausesLeft({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
		zero: 'Heute keine Pause mehr',
		one: 'Heute noch ${n} Pause',
		other: 'Heute noch ${n} Pausen',
	);
	@override String get todayOpen => 'Heute sind deine Apps offen: Du hast zuerst Gott gesucht.';
	@override String get todayLocked => 'Deine Apps bleiben bis zu deinem heutigen Bericht geschlossen.';
	@override String todayBefore({required Object time}) => 'Deine Apps schließen sich um ${time}, wenn dein Bericht noch nicht gespeichert ist.';
	@override String get fillReport => 'Meinen Bericht ausfüllen';
	@override String get denied => 'Ohne Zugriff auf Bildschirmzeit kann CMFI Connect keine Apps schließen. Du kannst ihn unter Einstellungen › Bildschirmzeit erlauben.';
	@override String get noApps => 'Wähle mindestens eine App, die geschlossen bleiben soll.';
	@override String get unsupported => 'Bald auf diesem Telefon verfügbar.';
	@override String moreOn({required Object time}) => 'Ab ${time}, bis zu deinem Bericht';
	@override String get moreOff => 'Apps schließen, bis dein Bericht fertig ist';
	@override String get privacy => 'CMFI Connect sieht nie, welche Apps du wählst: Dein iPhone behält sie für sich.';
	@override late final _Translations$seekFirst$shield$de shield = _Translations$seekFirst$shield$de._(_root);
}

// Path: onboarding.reports
class _Translations$onboarding$reports$de extends Translations$onboarding$reports$fr {
	_Translations$onboarding$reports$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Dein Weg mit Gott, Tag für Tag';
	@override String get text => 'Notiere in Sekunden deine Bibellese, dein Gebet, dein Fasten … und verfolge deinen Fortschritt Woche für Woche.';
}

// Path: onboarding.worship
class _Translations$onboarding$worship$de extends Translations$onboarding$worship$fr {
	_Translations$onboarding$worship$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Singe und bete, wo immer du bist';
	@override String get text => 'Finde die Lieder der Gemeinschaft und bete jeden Tag mit deinen Brüdern und Schwestern für die Gebetsanliegen.';
}

// Path: onboarding.community
class _Translations$onboarding$community$de extends Translations$onboarding$community$fr {
	_Translations$onboarding$community$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Bleib mit deiner Gemeinschaft verbunden';
	@override String get text => 'Die Veranstaltungen und Ankündigungen deiner Gemeinde an einem Ort, damit du nichts verpasst.';
}

// Path: onboarding.sample
class _Translations$onboarding$sample$de extends Translations$onboarding$sample$fr {
	_Translations$onboarding$sample$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get today => 'Heute';
	@override String get bibleReading => 'Bibellese';
	@override String get prayerAlone => 'Persönliches Gebet';
	@override String get meditation => 'Meditation';
	@override String get groupPrayer => 'Gebet in der Gruppe';
	@override String get thisWeek => 'Diese Woche';
	@override String get weekScore => '4 von 5 Tagen';
	@override String get hymn => 'Lied';
	@override String get hymnNumber => 'Nr. 12';
	@override String get fullScreen => 'Vollbild';
	@override String get prayerOfTheDay => 'Gebetsanliegen des Tages';
	@override String get prayerTopic => 'Für die Prüfungen unserer Jugendlichen';
	@override String get praying => '12 Personen beten';
	@override String get iPray => 'Ich bete';
	@override String get vigil => 'Gebetsnacht';
	@override String get vigilMeta => '20 Uhr · Ortsgemeinde';
	@override String get join => 'Ich bin dabei';
	@override String get retreat => 'Jugendfreizeit';
	@override String get retreatMeta => 'Ganztägig';
	@override String get announcement => 'Ankündigung';
	@override String get announcementText => 'Der Gottesdienst am Sonntag beginnt um 8:30 Uhr.';
	@override String get chapters => '10 Kap.';
}

// Path: auth.login
class _Translations$auth$login$de extends Translations$auth$login$fr {
	_Translations$auth$login$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Willkommen zurück';
	@override String get subtitle => 'Melde dich an, um deinen heutigen Bericht auszufüllen.';
	@override String get submit => 'Anmelden';
	@override String get noAccount => 'Noch kein Konto?';
	@override String get createAccount => 'Konto erstellen';
}

// Path: auth.register
class _Translations$auth$register$de extends Translations$auth$register$fr {
	_Translations$auth$register$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String step({required Object current, required Object total}) => '${current} / ${total}';
	@override String get title => 'Erstelle dein Konto';
	@override String get subtitle => 'Mit deiner Telefonnummer meldest du dich an.';
	@override String get firstName => 'Vorname';
	@override String get lastName => 'Nachname';
	@override String get passwordHelp => 'Mindestens 6 Zeichen';
	@override String get email => 'E-Mail';
	@override String get submit => 'Weiter';
	@override String get haveAccount => 'Schon ein Konto?';
	@override String get login => 'Anmelden';
	@override String get alreadyUsed => 'Für diese Nummer oder E-Mail gibt es schon ein Konto. Melde dich an.';
	@override String get emailHint => 'du@beispiel.de';
}

// Path: auth.church
class _Translations$auth$church$de extends Translations$auth$church$fr {
	_Translations$auth$church$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Deine Kirche';
	@override String get subtitle => 'Mit diesen Angaben finden dich deine Verantwortlichen. Du kannst sie später ändern.';
	@override String get editTitle => 'Mein Profil';
	@override String get editSubtitle => 'Aktualisiere deinen Namen, deine Kirche und deine Gemeinde.';
	@override String get country => 'Land';
	@override String get countryHint => 'Wähle dein Land';
	@override String get city => 'Stadt';
	@override String get cityHint => 'Yaoundé';
	@override String get church => 'Kirche';
	@override String get churchHint => 'Name deiner Kirche';
	@override String get assembly => 'Gemeinde';
	@override String get assemblyHint => 'Name deiner Gemeinde';
	@override String get info => 'Umgezogen oder Gemeinde gewechselt? Du kannst alles in deinem Profil aktualisieren.';
	@override String get submit => 'Fertig';
	@override String get skip => 'Diesen Schritt überspringen';
	@override String get saved => 'Profil gespeichert';
}

// Path: auth.forgot
class _Translations$auth$forgot$de extends Translations$auth$forgot$fr {
	_Translations$auth$forgot$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get link => 'Passwort vergessen?';
	@override String get title => 'Passwort vergessen';
	@override String get phoneText => 'Gib deine Nummer ein: Wir senden dir per SMS einen Code, um ein neues Passwort zu wählen.';
	@override String get sendCode => 'Code erhalten';
	@override String get codeTitle => 'Code eingeben';
	@override String codeText({required Object phone}) => 'Wir haben einen 6-stelligen Code an ${phone} gesendet.';
	@override String get code => 'Per SMS erhaltener Code';
	@override String get codeInvalid => 'Der Code hat 6 Ziffern';
	@override String get verify => 'Überprüfen';
	@override String get resend => 'Code erneut senden';
	@override String resendIn({required Object seconds}) => 'Erneut senden in ${seconds} s';
	@override String get changeNumber => 'Nummer ändern';
	@override String get passwordTitle => 'Neues Passwort';
	@override String get passwordText => 'Wähle ein neues Passwort für dein Konto.';
	@override String get submit => 'Speichern und anmelden';
	@override String get done => 'Passwort geändert. Willkommen zurück!';
	@override String get remembered => 'Doch wieder eingefallen?';
	@override String get invalidCode => 'Dieser Code ist nicht richtig.';
	@override String get expired => 'Der Code ist abgelaufen. Fordere einen neuen an.';
	@override String get tooManyRequests => 'Zu viele Versuche. Versuche es später erneut.';
	@override String get unavailable => 'Das Zurücksetzen ist gerade nicht möglich.';
	@override String get noAccount => 'Kein Konto verwendet diese Nummer.';
}

// Path: auth.biometric
class _Translations$auth$biometric$de extends Translations$auth$biometric$fr {
	_Translations$auth$biometric$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get faceId => 'Face ID';
	@override String get touchId => 'Touch ID';
	@override String get fingerprint => 'deinem Fingerabdruck';
	@override String get face => 'deinem Gesicht';
	@override String signIn({required Object method}) => 'Mit ${method} anmelden';
	@override String askTitle({required Object method}) => 'Mit ${method} anmelden?';
	@override String get askText => 'Beim nächsten Mal musst du dein Passwort nicht eingeben: Es bleibt im sicheren Speicher deines Telefons.';
	@override String get enable => 'Einschalten';
	@override String get later => 'Später';
	@override String get reason => 'Bei CMFI Connect anmelden';
	@override String get enableReason => 'Schnelle Anmeldung bei CMFI Connect einschalten';
	@override String changed({required Object method}) => 'Dein Passwort hat sich geändert: Melde dich mit deinem Passwort an und schalte ${method} dann wieder ein.';
	@override String settings({required Object method}) => 'Anmeldung mit ${method}';
	@override String get settingsText => 'Ohne dein Passwort einzugeben';
	@override String get passwordTitle => 'Dein Passwort';
	@override String get passwordLabel => 'Passwort';
	@override String get confirm => 'Bestätigen';
	@override String enabled({required Object method}) => 'Anmeldung mit ${method} ist eingeschaltet';
}

// Path: reports.tabs
class _Translations$reports$tabs$de extends Translations$reports$tabs$fr {
	_Translations$reports$tabs$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get today => 'Heute';
	@override String get history => 'Verlauf';
	@override String get summary => 'Übersicht';
}

// Path: reports.measure
class _Translations$reports$measure$de extends Translations$reports$measure$fr {
	_Translations$reports$measure$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String quantity({required Object unit}) => '${unit}';
	@override String get duration => 'Dauer';
	@override String both({required Object unit}) => '${unit} und Dauer';
	@override String get quantityNoUnit => 'Anzahl';
	@override String get bothNoUnit => 'Anzahl und Dauer';
}

// Path: reports.sheet
class _Translations$reports$sheet$de extends Translations$reports$sheet$fr {
	_Translations$reports$sheet$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get quantity => 'Anzahl';
	@override String get duration => 'Dauer';
	@override String get minus1 => '− 1 Min.';
	@override String get plus1 => '+ 1 Min.';
	@override String get removeMinute => 'Eine Minute weniger';
	@override String get addMinute => 'Eine Minute mehr';
	@override String get holdToRepeat => 'Gedrückt halten, um schneller zu zählen';
	@override String get decrease => 'Verringern';
	@override String get increase => 'Erhöhen';
	@override String get clear => 'Löschen';
	@override String get validate => 'Fertig';
}

// Path: reports.history
class _Translations$reports$history$de extends Translations$reports$history$fr {
	_Translations$reports$history$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String daysFilled({required Object filled, required Object total}) => '${filled} von ${total} Tagen ausgefüllt';
	@override String get legendFilled => 'Ausgefüllt';
	@override String get legendMissing => 'Kein Bericht';
	@override String get none => 'Kein Bericht';
	@override String get fill => 'Ausfüllen';
	@override String get inProgress => 'Begonnen';
	@override String get previousMonth => 'Vorheriger Monat';
	@override String get nextMonth => 'Nächster Monat';
	@override String get today => 'heute';
}

// Path: reports.summary
class _Translations$reports$summary$de extends Translations$reports$summary$fr {
	_Translations$reports$summary$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get week => 'Woche';
	@override String get month => 'Monat';
	@override String get year => 'Jahr';
	@override String range({required Object from, required Object to}) => 'Vom ${from} bis ${to}';
	@override String get regularity => 'Regelmäßigkeit';
	@override String get daysFilled => 'Tage ausgefüllt';
	@override String missingDays({required num n, required Object days}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
		one: '${n} Tag ohne Bericht: am ${days}.',
		other: '${n} Tage ohne Bericht: am ${days}.',
	);
	@override String missingCount({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
		one: '${n} Tag ohne Bericht',
		other: '${n} Tage ohne Bericht',
	);
	@override String get noMissing => 'Kein Tag verpasst, super!';
	@override String perDay({required Object value}) => '${value} pro ausgefülltem Tag';
	@override String days({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
		one: '${n} Tag',
		other: '${n} Tage',
	);
	@override String get notFilled => 'Noch nicht ausgefüllt';
	@override String barsCaption({required Object max}) => 'Pro Tag · höchster Balken: ${max}';
	@override String barsCaptionMonthly({required Object max}) => 'Pro Monat · höchster Balken: ${max}';
	@override String get empty => 'Kein Bericht in diesem Zeitraum.';
	@override String goalDays({required num n, required Object total}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
		one: 'Ziel an ${n} von ${total} Tagen erreicht',
		other: 'Ziel an ${n} von ${total} Tagen erreicht',
	);
	@override String get share => 'Diese Übersicht teilen';
	@override String get goals => 'Ziele';
	@override String get goalsAverage => 'Durchschnittliche Erfüllung deiner Ziele';
	@override String get goalsHint => 'Jeder Tag zählt, auch ein leerer. Heute zählt, sobald er ausgefüllt ist.';
	@override String get evolution => 'Entwicklung deiner Ziele';
	@override String get evolutionHint => 'Woche für Woche, über die letzten 12.';
	@override String get premiumYear => 'Das Jahr und die Entwicklung deiner Ziele gibt es mit Premium.';
}

// Path: reports.standardItems
class _Translations$reports$standardItems$de extends Translations$reports$standardItems$fr {
	_Translations$reports$standardItems$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get lb => 'Bibellese';
	@override String get ps => 'Persönliches Gebet';
	@override String get rdqad => 'Meditation';
	@override String get pg => 'Gebet in der Gruppe';
	@override String get llc => 'Lektüre christlicher Literatur';
	@override String get jc => 'Vollfasten';
	@override String get jp => 'Teilfasten';
	@override String get dimes => 'Zehnt';
	@override String get off => 'Opfergaben';
}

// Path: reports.units
class _Translations$reports$units$de extends Translations$reports$units$fr {
	_Translations$reports$units$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override late final _Translations$reports$units$chapters$de chapters = _Translations$reports$units$chapters$de._(_root);
	@override late final _Translations$reports$units$times$de times = _Translations$reports$units$times$de._(_root);
	@override late final _Translations$reports$units$pages$de pages = _Translations$reports$units$pages$de._(_root);
	@override late final _Translations$reports$units$percent$de percent = _Translations$reports$units$percent$de._(_root);
}

// Path: export.doc
class _Translations$export$doc$de extends Translations$export$doc$fr {
	_Translations$export$doc$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Tagesbericht';
	@override String get regularity => 'Regelmäßigkeit';
	@override String daysFilled({required num filled, required Object total}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(filled,
		one: '${filled} von ${total} Tagen ausgefüllt',
		other: '${filled} von ${total} Tagen ausgefüllt',
	);
	@override String get totals => 'Im Zeitraum';
	@override String get item => 'Element';
	@override String get total => 'Gesamt';
	@override String get days => 'Tage';
	@override String get average => 'Durchschnitt / ausgefüllter Tag';
	@override String get goal => 'Ziel erreicht';
	@override String get detail => 'Tag für Tag';
	@override String get date => 'Datum';
	@override String get values => 'Ausgefüllt';
	@override String get note => 'Notiz';
	@override String get noReport => 'Kein Bericht';
	@override String generated({required Object date}) => 'Erstellt am ${date} mit CMFI Connect';
	@override String page({required Object n, required Object total}) => 'Seite ${n} / ${total}';
	@override String get filledColumn => 'Bericht';
	@override String get yes => 'ja';
	@override String get no => 'nein';
	@override String get sentFrom => 'Gesendet mit CMFI Connect';
}

// Path: items.measure
class _Translations$items$measure$de extends Translations$items$measure$fr {
	_Translations$items$measure$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String quantity({required Object unit}) => 'Anzahl · ${unit}';
	@override String get quantityNoUnit => 'Anzahl';
	@override String get duration => 'Dauer';
	@override String both({required Object unit}) => 'Anzahl (${unit}) und Dauer';
	@override String get bothNoUnit => 'Anzahl und Dauer';
}

// Path: authorities.form
class _Translations$authorities$form$de extends Translations$authorities$form$fr {
	_Translations$authorities$form$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Neue Autorität';
	@override String get emailHint => 'name@beispiel.de';
	@override String get isDiscipleMaker => 'Das ist mein Jüngermacher';
	@override String get isDiscipleMakerHelp => 'Die Person, die dich persönlich begleitet. Du hast nur einen.';
	@override String discipleMakerTaken({required Object name}) => '${name} ist bereits dein Jüngermacher. Entferne die Person aus der Liste, um jemand anderen zu wählen.';
	@override String get submit => 'Hinzufügen';
	@override String added({required Object name}) => '${name} gehört jetzt zu deinen Autoritäten.';
	@override String get searchLabel => 'Benutzername';
	@override String get searchHint => 'benutzername';
	@override String get search => 'Suchen';
	@override String get searchHelp => 'Wenn die Person CMFI Connect nutzt, suche sie über ihren Benutzernamen. Sie erhält deine Anfrage, und ihre Kontaktdaten erscheinen, sobald sie angenommen hat.';
	@override String notFound({required Object username}) => 'Niemand hat den Benutzernamen @${username}.';
	@override String get invite => 'Zu CMFI Connect einladen';
	@override String get inviteText => 'Hallo! Ich nutze CMFI Connect, um meinen Weg mit Gott festzuhalten, und ich möchte gern, dass du mich begleitest. Installiere die App, erstelle dein Konto und schick mir dann deinen Benutzernamen, damit ich dich hinzufügen kann.';
	@override String inviteMine({required Object username}) => 'Mein Benutzername: @${username}';
	@override String get manual => 'Nicht in der App? Kontaktdaten eingeben';
	@override String get backToSearch => 'Lieber nach Benutzername suchen';
	@override String get request => 'Anfrage senden';
	@override String requested({required Object name}) => 'Anfrage an ${name} gesendet.';
	@override String get alreadyAdded => 'Diese Person gehört bereits zu deinen Autoritäten.';
	@override String get makerExists => 'Du hast bereits einen Jüngermacher.';
	@override String get yourself => 'Das ist dein eigener Benutzername.';
	@override String sharingHelp({required Object name}) => '${name} wird deine Berichte sehen: die ausgefüllten Punkte, deine Regelmäßigkeit und deine Prozentsätze, nie deine Notiz. Du kannst das auf der Karte beenden.';
}

// Path: authorities.sharing
class _Translations$authorities$sharing$de extends Translations$authorities$sharing$fr {
	_Translations$authorities$sharing$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Meine Berichte teilen';
	@override String help({required Object name}) => '${name} sieht deine Berichte: die ausgefüllten Punkte, deine Regelmäßigkeit und deine Prozentsätze, nie deine Notiz.';
	@override String on({required Object name}) => 'Deine Berichte werden mit ${name} geteilt.';
	@override String off({required Object name}) => '${name} sieht deine Berichte nicht mehr.';
}

// Path: members.deleteAccount
class _Translations$members$deleteAccount$de extends Translations$members$deleteAccount$fr {
	_Translations$members$deleteAccount$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get button => 'Mein Konto löschen';
	@override String get title => 'Mein Konto löschen';
	@override String get intro => 'Das ist endgültig. Dein Konto und alles, was dazugehört, wird gelöscht:';
	@override String get itemProfile => 'dein Profil, dein Profilbild, dein Benutzername und dein Passwort';
	@override String get itemReports => 'alle deine Tagesberichte, Elemente und Ziele';
	@override String get itemAuthorities => 'deine geistlichen Autoritäten und die erhaltenen Anfragen';
	@override String get itemEvents => 'deine Anmeldungen zu Veranstaltungen';
	@override String get itemPrayer => 'deine Gebetslisten, Gebetszeiten und beharrlichen Anliegen';
	@override String get kept => 'Veranstaltungen, Neuigkeiten, Fotos und Gebetsanliegen, die du als Admin veröffentlicht hast, bleiben für die Gemeinschaft – ohne deinen Namen.';
	@override String get passwordHelp => 'Damit wir sicher sind, dass du es bist.';
	@override String get confirm => 'Endgültig löschen';
	@override String get done => 'Dein Konto wurde gelöscht. Gott segne dich!';
	@override String get wrongPassword => 'Falsches Passwort.';
	@override String get lastSuperadmin => 'Du bist der einzige Superadmin: Gib diese Rolle jemand anderem, bevor du dein Konto löschst.';
}

// Path: hymns.tabs
class _Translations$hymns$tabs$de extends Translations$hymns$tabs$fr {
	_Translations$hymns$tabs$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get all => 'Alle';
	@override String get favorites => 'Favoriten';
	@override String get recent => 'Zuletzt';
}

// Path: hymns.reader
class _Translations$hymns$reader$de extends Translations$hymns$reader$fr {
	_Translations$hymns$reader$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get smaller => 'Text verkleinern';
	@override String get larger => 'Text vergrößern';
	@override String get display => 'Anzeige';
	@override String get textSize => 'Textgröße';
	@override String get typeface => 'Schrift';
	@override String get typefaceAuto => 'Auto';
	@override String get typefaceSans => 'Modern';
	@override String get typefaceSerif => 'Klassisch';
	@override String get typefaceAutoHelp => 'Klassisch bei großem Text';
	@override String get background => 'Hintergrund';
	@override String get themeAuto => 'Auto';
	@override String get themeLight => 'Hell';
	@override String get themeSepia => 'Sepia';
	@override String get themeDark => 'Dunkel';
	@override String get repeatChorus => 'Refrain nach jeder Strophe wiederholen';
	@override String get keepScreenOn => 'Bildschirm eingeschaltet lassen';
	@override String get addFavorite => 'Zu Favoriten hinzufügen';
	@override String get removeFavorite => 'Aus Favoriten entfernen';
	@override String get favoriteAdded => 'Zu Favoriten hinzugefügt';
	@override String get favoriteRemoved => 'Aus Favoriten entfernt';
	@override String get more => 'Weitere Optionen';
	@override String get copy => 'Liedtext kopieren';
	@override String get copied => 'Liedtext kopiert';
	@override String get project => 'Präsentationsmodus';
	@override String get pinchHint => 'Zieh mit zwei Fingern auf oder zu, um die Textgröße zu ändern.';
	@override String get notFound => 'Dieses Lied gibt es im Liederbuch nicht mehr.';
	@override String get share => 'Liedtext teilen';
}

// Path: hymns.projection
class _Translations$hymns$projection$de extends Translations$hymns$projection$fr {
	_Translations$hymns$projection$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get exit => 'Präsentationsmodus beenden';
	@override String get previous => 'Vorherige Strophe';
	@override String get next => 'Nächste Strophe';
	@override String position({required Object current, required Object total}) => '${current} / ${total}';
	@override String get hint => 'Tippe rechts, um weiterzugehen, und links, um zurückzugehen.';
}

// Path: hymns.pad
class _Translations$hymns$pad$de extends Translations$hymns$pad$fr {
	_Translations$hymns$pad$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Zum Lied';
	@override String get open => 'Öffnen';
	@override String get erase => 'Löschen';
	@override String notFound({required Object number}) => 'Kein Lied Nr. ${number} in diesem Liederbuch';
	@override String get placeholder => 'Nummer eingeben';
}

// Path: events.tabs
class _Translations$events$tabs$de extends Translations$events$tabs$fr {
	_Translations$events$tabs$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get program => 'Programm';
	@override String get news => 'Neuigkeiten';
	@override String get info => 'Infos';
	@override String get photos => 'Fotos';
}

// Path: events.register
class _Translations$events$register$de extends Translations$events$register$fr {
	_Translations$events$register$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get cta => 'Ich bin dabei';
	@override String get title => 'Ich bin dabei';
	@override String get people => 'Wie viele seid ihr?';
	@override String get peopleHint => 'Dich mitgezählt, mit deiner Familie oder Gruppe.';
	@override String get less => 'Eine Person weniger';
	@override String get more => 'Eine Person mehr';
	@override String get lodging => 'Ich brauche eine Unterkunft';
	@override String get lodgingHint => 'Die Organisatoren planen die Plätze ein.';
	@override String get departure => 'Abfahrtsort';
	@override String get departureHint => 'z. B. Douala';
	@override String get confirm => 'Anmeldung bestätigen';
	@override String get update => 'Aktualisieren';
	@override String get cancel => 'Anmeldung stornieren';
	@override String get done => 'Alles klar, du bist angemeldet! Wir erinnern dich am Vortag daran.';
	@override String get updated => 'Deine Anmeldung ist aktualisiert.';
	@override String get cancelled => 'Deine Anmeldung wurde storniert.';
	@override String get edit => 'Ändern';
	@override String get youAre => 'Du bist angemeldet';
	@override String get cancelTitle => 'Anmeldung stornieren?';
	@override String get cancelText => 'Dein Platz wird für jemand anderen frei.';
	@override String get keep => 'Platz behalten';
	@override String get lodgingShort => 'Unterkunft';
}

// Path: events.reminder
class _Translations$events$reminder$de extends Translations$events$reminder$fr {
	_Translations$events$reminder$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get channel => 'Erinnerungen an Veranstaltungen';
	@override String tomorrow({required Object title}) => 'Morgen: ${title}';
	@override String soon({required Object title}) => 'In 1 Std.: ${title}';
}

// Path: events.admin
class _Translations$events$admin$de extends Translations$events$admin$fr {
	_Translations$events$admin$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Veranstaltungen verwalten';
	@override String get create => 'Veranstaltung erstellen';
	@override String get edit => 'Veranstaltung bearbeiten';
	@override String get empty => 'Noch keine Veranstaltungen. Erstelle die erste!';
	@override String get poster => 'Plakat';
	@override String get posterAdd => 'Plakat auswählen';
	@override String get posterChange => 'Plakat ändern';
	@override String get posterRemove => 'Plakat entfernen';
	@override String get posterHint => 'Hochformat 4:5 empfohlen (1080 × 1350), JPEG oder PNG.';
	@override String get uploading => 'Bild wird hochgeladen …';
	@override String get general => 'Die Veranstaltung';
	@override String get titleField => 'Titel';
	@override String get titleHint => 'z. B. Jahreskonferenz 2026';
	@override String get titleRequired => 'Gib der Veranstaltung einen Titel.';
	@override String get theme => 'Thema';
	@override String get themeHint => 'z. B. Im Geist wandeln';
	@override String get verse => 'Themenvers';
	@override String get description => 'Beschreibung';
	@override String get when => 'Termin';
	@override String get starts => 'Beginn';
	@override String get ends => 'Ende';
	@override String get endsBeforeStart => 'Das Ende muss nach dem Beginn liegen.';
	@override String timeZone({required Object zone}) => 'Uhrzeiten vor Ort (${zone}).';
	@override String get where => 'Ort';
	@override String get venue => 'Veranstaltungsort';
	@override String get venueHint => 'z. B. Konferenzzentrum Mvolyé';
	@override String get address => 'Adresse';
	@override String get city => 'Stadt';
	@override String get country => 'Land';
	@override String get mapsUrl => 'Google-Maps-Link';
	@override String get registration => 'Anmeldung';
	@override String get registrationOpen => 'Anmeldung offen';
	@override String get deadline => 'Anmeldeschluss';
	@override String get noDeadline => 'Kein Anmeldeschluss';
	@override String get capacity => 'Anzahl der Plätze';
	@override String get capacityHint => 'Leer: unbegrenzt';
	@override String get asksLodging => 'Fragen, wer eine Unterkunft braucht';
	@override String get asksDeparture => 'Nach dem Abfahrtsort fragen';
	@override String get fees => 'Kosten';
	@override String get feesHint => 'z. B. Eintritt frei. Mahlzeiten: 2.000 FCFA pro Tag.';
	@override String get contact => 'Kontakt';
	@override String get contactName => 'Name der Kontaktperson';
	@override String get contactPhone => 'Telefon der Kontaktperson';
	@override String get visibility => 'Sichtbarkeit';
	@override String get statusDraft => 'Entwurf';
	@override String get statusDraftHint => 'Nur für Admins sichtbar';
	@override String get statusPublished => 'Veröffentlicht';
	@override String get statusPublishedHint => 'Für die ganze Gemeinschaft sichtbar';
	@override String get statusCancelled => 'Abgesagt';
	@override String get statusCancelledHint => 'Als abgesagt angezeigt, ohne Anmeldung';
	@override String get saved => 'Veranstaltung gespeichert.';
	@override String get menu => 'Verwalten';
	@override String get program => 'Programm';
	@override String get registrants => 'Angemeldete';
	@override String get post => 'Neuigkeit veröffentlichen';
	@override String get photos => 'Fotos hinzufügen';
	@override String get nextEdition => 'Nächste Ausgabe vorbereiten';
	@override String get delete => 'Veranstaltung löschen';
	@override String get deleteTitle => 'Diese Veranstaltung löschen?';
	@override String get deleteText => 'Die Anmeldungen, Neuigkeiten und Fotos werden ebenfalls gelöscht.';
	@override String get deleteConfirm => 'Löschen';
	@override String get deleted => 'Veranstaltung gelöscht.';
	@override String get nextEditionTitle => 'Nächste Ausgabe vorbereiten?';
	@override String get nextEditionText => 'Ein Jahr später wird ein Entwurf angelegt, mit demselben Ort und demselben Programm. Du kannst alles anpassen, bevor du ihn veröffentlichst.';
	@override String get nextEditionConfirm => 'Vorbereiten';
	@override String get nextEditionDone => 'Die nächste Ausgabe liegt als Entwurf bereit.';
	@override String get programEmpty => 'Füge die Programmpunkte der Veranstaltung hinzu: Empfang, Gottesdienste, Lehre, Gebetsnacht …';
	@override String get addSession => 'Programmpunkt hinzufügen';
	@override String get editSession => 'Programmpunkt bearbeiten';
	@override String get sessionTitle => 'Titel';
	@override String get sessionTitleHint => 'z. B. Eröffnungsgottesdienst';
	@override String get speaker => 'Sprecher';
	@override String get place => 'Raum';
	@override String get day => 'Tag';
	@override String get from => 'Von';
	@override String get to => 'Bis';
	@override String get hymns => 'Lieder';
	@override String get hymnsHint => 'Nummern, z. B. 12, 45';
	@override String get removeSession => 'Entfernen';
	@override String get saveProgram => 'Programm speichern';
	@override String get programSaved => 'Programm gespeichert.';
	@override String get registrantsEmpty => 'Noch hat sich niemand angemeldet.';
	@override String get totalRegistrations => 'Anmeldungen';
	@override String get totalPeople => 'Personen';
	@override String get totalLodging => 'Mit Unterkunft';
	@override String get byCity => 'Nach Abfahrtsort';
	@override String get list => 'Liste';
	@override String get exportCsv => 'Liste exportieren (CSV)';
	@override String get csvHeader => 'Name;Benutzername;Telefon;Kirche;Gemeinde;Personen;Unterkunft;Abfahrtsort;Angemeldet am';
	@override String get yes => 'ja';
	@override String get no => 'nein';
	@override String get postBody => 'Nachricht';
	@override String get postBodyHint => 'z. B. Die Anmeldung ist geöffnet!';
	@override String get postImage => 'Bild hinzufügen';
	@override String get postPinned => 'Oben anheften';
	@override String get postSend => 'Veröffentlichen';
	@override String get postDone => 'Neuigkeit veröffentlicht.';
	@override String get postDelete => 'Diese Neuigkeit löschen';
	@override String get postDeleted => 'Neuigkeit gelöscht.';
	@override String photosAdded({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
		one: '${n} Foto hinzugefügt.',
		other: '${n} Fotos hinzugefügt.',
	);
	@override String photosSending({required Object done, required Object total}) => 'Fotos werden gesendet (${done}/${total}) …';
	@override String get photoDelete => 'Dieses Foto löschen';
	@override String get photoDeleted => 'Foto gelöscht.';
	@override String get confirmDelete => 'Löschen';
}

// Path: ministry.goals
class _Translations$ministry$goals$de extends Translations$ministry$goals$fr {
	_Translations$ministry$goals$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override late final _Translations$ministry$goals$crusade$de crusade = _Translations$ministry$goals$crusade$de._(_root);
	@override late final _Translations$ministry$goals$disciples$de disciples = _Translations$ministry$goals$disciples$de._(_root);
	@override late final _Translations$ministry$goals$revival$de revival = _Translations$ministry$goals$revival$de._(_root);
}

// Path: ministry.lives
class _Translations$ministry$lives$de extends Translations$ministry$lives$fr {
	_Translations$ministry$lives$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override late final _Translations$ministry$lives$founder$de founder = _Translations$ministry$lives$founder$de._(_root);
	@override late final _Translations$ministry$lives$leader$de leader = _Translations$ministry$lives$leader$de._(_root);
}

// Path: prayer.hero
class _Translations$prayer$hero$de extends Translations$prayer$hero$fr {
	_Translations$prayer$hero$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String now({required Object retreat}) => '${retreat} · jetzt';
	@override String get title => '15 Minuten\nmit dem Herrn';
	@override Map<String, String> get preview => {
		'morning': 'Sage Dank, weihe deinen Tag, deine Arbeit, deine Familie …',
		'noon': 'Deine Gemeinde, deine Leiter, 5 Menschen von deiner Liste, die Nationen …',
		'evening': 'Dein Gebetsleben, dein Dienst, deine Mitarbeiter …',
		'night': 'Die Kranken, das Evangelium unter den Nationen, Schutz für die Nacht …',
	};
	@override String get meta => '15 Punkte · je 1 Min.';
	@override String get start => 'Beginnen';
	@override String get allDone => 'Alle 4 Gebetszeiten des Tages sind erledigt. Möge Gott deine Gebete erhören!';
	@override String doneNow({required Object retreat, required Object next}) => '${retreat} erledigt. Nächste: ${next}';
}

// Path: prayer.today
class _Translations$prayer$today$de extends Translations$prayer$today$fr {
	_Translations$prayer$today$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get toPray => 'Noch zu beten';
	@override String week({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
		zero: 'Diese Woche noch keine Gebetszeit',
		one: '${n} Gebetszeit diese Woche',
		other: '${n} Gebetszeiten diese Woche',
	);
}

// Path: prayer.routine
class _Translations$prayer$routine$de extends Translations$prayer$routine$fr {
	_Translations$prayer$routine$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Deine tägliche Routine';
	@override String count({required Object done}) => '${done} von 4';
	@override String days({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
		one: '${n} Tag von 7',
		other: '${n} Tage von 7',
	);
	@override String week({required Object time}) => '${time} diese Woche';
	@override String get done => 'Erledigt · 15 Min.';
	@override String get now => 'Jetzt · 15 Min.';
	@override String get next => 'Als Nächstes · 15 Min.';
	@override String reminder({required Object time}) => 'Erinnerung um ${time}';
	@override Map<String, String> get later => {
		'morning': 'Am Morgen · 15 Min.',
		'noon': 'Am Mittag · 15 Min.',
		'evening': 'Am Abend · 15 Min.',
		'night': 'In der Nacht · 15 Min.',
	};
}

// Path: prayer.reminders
class _Translations$prayer$reminders$de extends Translations$prayer$reminders$fr {
	_Translations$prayer$reminders$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Erinnerungen an die Gebetszeiten';
	@override String get intro => 'Eine Erinnerung zu jeder Gebetszeit – nur wenn sie noch nicht erledigt ist.';
	@override String get off => 'Aus';
	@override String get channel => 'Gebetszeiten';
	@override String get body => '15 Minuten mit dem Herrn.';
}

// Path: prayer.retreat
class _Translations$prayer$retreat$de extends Translations$prayer$retreat$fr {
	_Translations$prayer$retreat$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Gebetszeiten von 15 Minuten';
	@override Map<String, String> get hours => {
		'morning': 'Beim Aufwachen',
		'noon': 'Zwischen 12 und 14 Uhr',
		'evening': 'Am späten Nachmittag',
		'night': 'Vor dem Schlafengehen',
	};
	@override String reminderAt({required Object time}) => 'Erinnerung um ${time}';
	@override String get intro => '15 Punkte, je eine Minute. Ein sanfter Ton führt dich zum nächsten.';
	@override String get done => 'Heute erledigt';
	@override String get start => 'Beginnen · 15 Min.';
	@override String get selfPaced => 'In meinem Tempo lesen, ohne Timer';
	@override late final _Translations$prayer$retreat$hints$de hints = _Translations$prayer$retreat$hints$de._(_root);
}

// Path: prayer.session
class _Translations$prayer$session$de extends Translations$prayer$session$fr {
	_Translations$prayer$session$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String point({required Object n}) => 'Punkt ${n} von 15';
	@override String get remaining => 'verbleibend';
	@override String get paused => 'pausiert';
	@override String inYourList({required Object list}) => 'Auf deiner Liste · ${list}';
	@override String get tomorrow => 'Morgen die nächsten.';
	@override String get footer => 'Bildschirm bleibt an · ein sanfter Ton jede Minute';
	@override String get previous => 'Vorheriger Punkt';
	@override String get next => 'Nächster Punkt';
	@override String get pause => 'Pause';
	@override String get resume => 'Fortsetzen';
	@override String get soundOn => 'Ton an';
	@override String get soundOff => 'Ton aus';
	@override String get finish => 'Gebetszeit beenden';
	@override String get quitTitle => 'Gebetszeit abbrechen?';
	@override String get quitText => 'Sie wird für deinen Tag nicht gezählt.';
	@override String get quit => 'Abbrechen';
	@override String get keepPraying => 'Weiterbeten';
}

// Path: prayer.done
class _Translations$prayer$done$de extends Translations$prayer$done$fr {
	_Translations$prayer$done$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String title({required Object retreat}) => '${retreat} beendet';
	@override String get text => '15 Minuten mit dem Herrn.\nEr hat jedes deiner Gebete gehört.';
	@override String get report => 'Zu deinem Bericht hinzugefügt';
	@override String reportDetail({required Object added, required Object total}) => 'Persönliches Gebet: +${added} Min. · heute ${total} Min.';
	@override String get undo => 'Rückgängig';
	@override String get undone => 'Gebetszeit aus deinem Tag entfernt.';
	@override String get today => 'Heute';
	@override String count({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
		one: '${n} von 4 Gebetszeiten',
		other: '${n} von 4 Gebetszeiten',
	);
	@override String get verse => '„Betet ohne Unterlass!“';
	@override String get reference => '1. Thessalonicher 5,17';
	@override String get finish => 'Fertig';
	@override String get hymn => 'Ein Lied singen';
}

// Path: prayer.topics
class _Translations$prayer$topics$de extends Translations$prayer$topics$fr {
	_Translations$prayer$topics$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Anliegen der Gemeinschaft';
	@override String get all => 'Alle ansehen';
	@override String get empty => 'Im Moment gibt es keine Anliegen. Die Verantwortlichen veröffentlichen die nächsten hier.';
	@override Map<String, String> get categories => {
		'church': 'Kirche',
		'nations': 'Nationen',
		'sick': 'Kranke',
		'event': 'Veranstaltung',
		'fasting': 'Fasten',
		'other': 'Anliegen',
	};
	@override String until({required Object date}) => 'bis ${date}';
	@override String get archive => 'Frühere Anliegen';
	@override String get archiveEmpty => 'Keine früheren Anliegen.';
	@override String get current => 'Aktuell';
	@override String documentSize({required Object kb}) => '${kb} KB';
	@override String get download => 'PDF herunterladen';
	@override String get noDocument => 'Kein PDF';
	@override String get openDocument => 'PDF öffnen';
}

// Path: prayer.lists
class _Translations$prayer$lists$de extends Translations$prayer$lists$fr {
	_Translations$prayer$lists$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Meine Gebetslisten';
	@override String get private => 'Nur für dich';
	@override Map<String, String> get names => {
		'unbelievers': 'Noch nicht gläubig',
		'believers': 'Gläubige',
		'backsliders': 'Abgefallene',
		'coworkers': 'Mitarbeiter',
	};
	@override Map<String, String> get uses => {
		'unbelievers': 'In der Gebetszeit am Mittag betest du jeden Tag der Reihe nach für 10 Menschen aus dieser Liste (5 + 5).',
		'believers': 'In der Gebetszeit am Mittag betest du jeden Tag der Reihe nach für 5 Menschen aus dieser Liste.',
		'backsliders': 'In der Gebetszeit am Mittag betest du jeden Tag der Reihe nach für 5 Menschen aus dieser Liste.',
		'coworkers': 'In der Gebetszeit am Abend betest du jeden Tag der Reihe nach für 10 deiner Mitarbeiter (5 + 5).',
	};
	@override String get privateNote => 'Nur du kannst sie sehen.';
	@override String count({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
		zero: 'Niemand',
		one: '${n} Person',
		other: '${n} Personen',
	);
	@override String get empty => 'Noch niemand. Füge die Menschen hinzu, für die du betest.';
	@override String get add => 'Person hinzufügen';
	@override String get prayedToday => 'Heute';
	@override String get next => 'Demnächst';
	@override Map<String, String> get answeredTitle => {
		'unbelievers': 'Zum Glauben an den Herrn gekommen',
		'believers': 'Erhörte Gebete',
		'backsliders': 'Zum Herrn zurückgekehrt',
		'coworkers': 'Erhörte Gebete',
	};
	@override late final _Translations$prayer$lists$answeredOn$de answeredOn = _Translations$prayer$lists$answeredOn$de._(_root);
	@override Map<String, String> get markAnswered => {
		'unbelievers': 'Ist zum Glauben an den Herrn gekommen!',
		'believers': 'Gebet erhört',
		'backsliders': 'Ist zum Herrn zurückgekehrt!',
		'coworkers': 'Gebet erhört',
	};
	@override String get answeredToast => 'Ehre sei Gott!';
	@override String get putBack => 'Zurück auf die Liste';
	@override String answeredBanner({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
		one: '${n} erhörtes Gebet diesen Monat',
		other: '${n} erhörte Gebete diesen Monat',
	);
	@override String lastAnswered({required Object name, required Object what}) => '${name}: ${what}';
	@override late final _Translations$prayer$lists$sheet$de sheet = _Translations$prayer$lists$sheet$de._(_root);
	@override String get addShort => 'Hinzufügen';
}

// Path: prayer.importunity
class _Translations$prayer$importunity$de extends Translations$prayer$importunity$fr {
	_Translations$prayer$importunity$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Beharrliche Anliegen';
	@override String get newTopic => 'Neues Anliegen';
	@override String get intro => 'Ein Anliegen, das man dem Herrn unermüdlich vorbringt, bis die Antwort kommt. Lege eine Anzahl an Proklamationen fest und lade deine Brüder und Schwestern ein, mit dir zu beten.';
	@override String invitedBy({required Object name}) => '${name} lädt dich zum Beten ein';
	@override String get join => 'Ich bete mit';
	@override String get decline => 'Nicht jetzt';
	@override String get joined => 'Du betest jetzt für dieses Anliegen.';
	@override String progress({required Object total, required Object goal}) => '${total} von ${goal}';
	@override String total({required num n, required Object count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
		one: '${count} Proklamation',
		other: '${count} Proklamationen',
	);
	@override String get reached => 'Ziel erreicht!';
	@override String get closed => 'Abgeschlossen';
	@override String participants({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
		one: '${n} betet',
		other: '${n} beten',
	);
	@override String mine({required Object n}) => 'Du: ${n}';
	@override String get tapHint => 'Tippe bei jeder Proklamation';
	@override String get addMany => 'Anzahl hinzufügen';
	@override String get addManyTitle => 'Wie viele Proklamationen?';
	@override String get addManyLabel => 'Proklamationen';
	@override String get add => 'Hinzufügen';
	@override String pending({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
		one: '${n} noch nicht gesendet',
		other: '${n} noch nicht gesendet',
	);
	@override String get invite => 'Einladen';
	@override String get members => 'Mitbetende';
	@override String waiting({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
		one: '${n} offene Einladung',
		other: '${n} offene Einladungen',
	);
	@override String get edit => 'Bearbeiten';
	@override String get close => 'Anliegen abschließen';
	@override String get reopen => 'Anliegen wieder öffnen';
	@override String get delete => 'Anliegen löschen';
	@override String get deleteTitle => 'Dieses Anliegen löschen?';
	@override String get deleteText => 'Es verschwindet für alle, die mit dir beten.';
	@override String get leave => 'Anliegen verlassen';
	@override String get leaveTitle => 'Dieses Anliegen verlassen?';
	@override String get leaveText => 'Deine Proklamationen bleiben in der Gesamtzahl.';
	@override late final _Translations$prayer$importunity$form$de form = _Translations$prayer$importunity$form$de._(_root);
	@override late final _Translations$prayer$importunity$inviteSheet$de inviteSheet = _Translations$prayer$importunity$inviteSheet$de._(_root);
	@override String get eyebrow => 'Anliegen der Beharrlichkeit';
	@override String get proclaim => 'Proklamieren';
}

// Path: streak.lines
class _Translations$streak$lines$de extends Translations$streak$lines$fr {
	_Translations$streak$lines$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get week => 'Eine ganze Woche mit dem Herrn, Tag für Tag. Bravo, mach weiter!';
	@override String get month => 'Ein Monat voller Treue! Was du jeden Tag säst, trägt Frucht.';
	@override String get hundred => 'Hundert Tage mit Gott! Deine Ausdauer ist ein schönes Zeugnis.';
	@override String get year => 'Ein ganzes Jahr mit Gott! Ehre sei Ihm für deine Treue.';
}

// Path: blocking.reasons
class _Translations$blocking$reasons$de extends Translations$blocking$reasons$fr {
	_Translations$blocking$reasons$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get spam => 'Unerwünscht';
	@override String get offensive => 'Schockierender oder anstößiger Inhalt';
	@override String get other => 'Sonstiges';
}

// Path: bible.colors
class _Translations$bible$colors$de extends Translations$bible$colors$fr {
	_Translations$bible$colors$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get yellow => 'Gelb';
	@override String get green => 'Grün';
	@override String get blue => 'Blau';
	@override String get pink => 'Rosa';
}

// Path: seekFirst.shield
class _Translations$seekFirst$shield$de extends Translations$seekFirst$shield$fr {
	_Translations$seekFirst$shield$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Suche zuerst Gott';
	@override String subtitle({required Object app}) => '${app} bleibt bis zu deinem heutigen Bericht geschlossen.';
	@override String get thisApp => 'Diese App';
	@override String get fill => 'Meinen Bericht ausfüllen';
	@override String pause({required Object n}) => '5 Min. Pause (${n}/3)';
	@override String get notificationTitle => 'Suche zuerst Gott';
	@override String get notificationBody => 'Tippe hier, um deinen Bericht auszufüllen.';
}

// Path: reports.units.chapters
class _Translations$reports$units$chapters$de extends Translations$reports$units$chapters$fr {
	_Translations$reports$units$chapters$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get name => 'Anzahl der Kapitel';
	@override String get label => 'Kapitel';
	@override String get symbol => 'Kapitel';
	@override String count({required num n, required Object value}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
		one: '${value} Kapitel',
		other: '${value} Kapitel',
	);
}

// Path: reports.units.times
class _Translations$reports$units$times$de extends Translations$reports$units$times$fr {
	_Translations$reports$units$times$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get name => 'Anzahl';
	@override String get label => 'Anzahl';
	@override String get symbol => 'Mal';
	@override String count({required num n, required Object value}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
		one: '${value}-mal',
		other: '${value}-mal',
	);
}

// Path: reports.units.pages
class _Translations$reports$units$pages$de extends Translations$reports$units$pages$fr {
	_Translations$reports$units$pages$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get name => 'Anzahl der Seiten';
	@override String get label => 'Seiten';
	@override String get symbol => 'Seiten';
	@override String count({required num n, required Object value}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
		one: '${value} Seite',
		other: '${value} Seiten',
	);
}

// Path: reports.units.percent
class _Translations$reports$units$percent$de extends Translations$reports$units$percent$fr {
	_Translations$reports$units$percent$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get name => 'Prozentsatz';
	@override String get label => 'Prozent';
	@override String get symbol => '%';
	@override String count({required Object value}) => '${value} %';
}

// Path: ministry.goals.crusade
class _Translations$ministry$goals$crusade$de extends Translations$ministry$goals$crusade$fr {
	_Translations$ministry$goals$crusade$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Der Evangeliumsfeldzug zu jeder Kreatur';
	@override String get text => 'Das Evangelium jedem Menschen zu predigen, der in unserer Generation leben wird, sodass 10 Milliarden Menschen mit dem in der Kraft des Heiligen Geistes gepredigten Evangelium erreicht werden – mit allen Kommunikationsmitteln (unseren Büchern, Traktaten, Zeitschriften, CDs, DVDs, unserem Radio, unserem Fernsehen und dem Internet) und so dringend wie möglich.';
	@override String get reached => 'Menschen, die das Evangelium hören';
}

// Path: ministry.goals.disciples
class _Translations$ministry$goals$disciples$de extends Translations$ministry$goals$disciples$fr {
	_Translations$ministry$goals$disciples$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Die Ausbildung von Jüngern';
	@override String get text => '1 Milliarde Menschen in 250 Nationen dahin zu führen, Jesus Christus als Herrn und Retter zu kennen, sie zu Jüngern zu machen, die ihm in allem gehorchen, und sie bis zum Jahr 2065 in 25 Millionen Hauskirchen zu sammeln.';
	@override String get people => 'Jünger';
	@override String get nations => 'Nationen';
	@override String get churches => 'Hauskirchen';
	@override String by({required Object year}) => 'bis ${year}';
}

// Path: ministry.goals.revival
class _Translations$ministry$goals$revival$de extends Translations$ministry$goals$revival$fr {
	_Translations$ministry$goals$revival$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Die weltweite Erweckung beschleunigen';
	@override String get text => 'Durch Fasten und Fürbitte mit Gott zusammenzuwirken für die weltweite Erweckung, die die Himmel zerreißen, die Erde erschüttern und Christus in unserer Generation verherrlichen wird, um die nahe Wiederkunft unseres Herrn Jesus Christus vom Himmel zu beschleunigen, zur Begegnung mit seiner bereiteten Braut.';
	@override String get fasting => 'Fasten';
	@override String get intercession => 'Fürbitte';
	@override String get pray => 'Jetzt beten';
}

// Path: ministry.lives.founder
class _Translations$ministry$lives$founder$de extends Translations$ministry$lives$founder$fr {
	_Translations$ministry$lives$founder$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get name => 'Prof. Zacharias Tanee Fomum';
	@override String get line => '1945 – 2009 · Gründer der CMFI';
	@override List<String> get facts => [
		'Gründung der CMFI',
		'geschriebene Bücher',
		'besuchte Nationen',
	];
	@override List<String> get dates => [
		'Geboren am 20. Juni in Kamerun, in einer presbyterianischen Familie.',
		'Übergibt am 13. Juni durch ein Traktat sein Leben Jesus Christus.',
		'Weiht sich am 1. Oktober in Sierra Leone ganz dem Herrn.',
		'Wird am 24. Oktober nach sieben Tagen Gebet mit dem Heiligen Geist erfüllt.',
		'Gründet am 12. Mai in Yaoundé die CMFI.',
		'Erhält von der Universität Durham den Doctor of Science.',
		'Geht am 14. März heim zum Herrn.',
	];
	@override List<String> get story => [
		'Zacharias Tanee Fomum wurde am 20. Juni 1945 in Kamerun geboren, in einer presbyterianischen Familie aus Batibo im Nordwesten des Landes. Noch als Schüler übergab er am 13. Juni 1956 sein Leben Jesus Christus, durch ein Traktat mit dem Titel „Jemand ist für dich gestorben“.',
		'Als Student am Fourah Bay College in Sierra Leone weihte er sich am 1. Oktober 1966 rückhaltlos dem Herrn und seinem Dienst. Am 24. Oktober 1970, nach sieben Tagen Gebet und Fasten, wurde er mit dem Heiligen Geist erfüllt. Von da an stand das Gebet im Mittelpunkt seines Lebens.',
		'Nach seiner Promotion in organischer Chemie an der Makerere-Universität in Uganda lehrte er an der Universität Yaoundé, wo er Professor wurde. Er betreute rund hundert Doktor- und Abschlussarbeiten, und 2005 verlieh ihm die Universität Durham in Großbritannien für sein gesamtes Werk den Doctor of Science.',
		'Am 12. Mai 1975 gründete er in Yaoundé die Christian Missionary Fellowship International: eine Bewegung, um Seelen zu gewinnen, Jünger zu machen, Gemeinden zu gründen und Missionare auszusenden. Er unternahm über 700 Missionsreisen in Kamerun und über 500 in mehr als 70 Nationen auf sechs Kontinenten.',
		'Er verbrachte täglich lange Stunden allein mit Gott, leitete viele Gebetskreuzzüge, Gebetsbelagerungen und Gebetsmärsche und fastete oft. Er schrieb über 150 Bücher über Gebet, Fasten, Heiligkeit, Jüngerschaft und Mission, die in vielen Sprachen gelesen werden.',
		'Mit seiner Frau Prisca Zei Fomum, die unter Kindern diente, hatte er sieben Kinder, die alle im Werk des Evangeliums stehen. Gemeinsam lebten sie einfach, um den größten Teil ihres Einkommens für das Evangelium zu geben.',
		'Am 14. März 2009 ging er heim zum Herrn und wurde am 21. März in Yaoundé beigesetzt. Das Werk, das er gegründet hat, geht unter den Nationen weiter.',
	];
}

// Path: ministry.lives.leader
class _Translations$ministry$lives$leader$de extends Translations$ministry$lives$leader$fr {
	_Translations$ministry$lives$leader$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get name => 'Theodore Andoseh';
	@override String get line => 'Leiter der CMFI seit 2009';
	@override List<String> get facts => [
		'gegründete Gemeinden',
		'Jahre in Nigeria',
		'an der Spitze der CMFI',
	];
	@override List<String> get dates => [
		'Übergibt sein Leben Jesus Christus unter der Predigt von Prof. Fomum.',
		'Wird in Yaoundé zum Bischof geweiht.',
		'Geht mit seiner Frau Adela als Missionar nach Nigeria.',
		'Übernimmt die Leitung der CMFI.',
		'Bringt die Botschaften der 3. Weltkonvention vor Mitgliedern aus 93 Nationen.',
	];
	@override List<String> get story => [
		'Theodore Andoseh übergab 1978 sein Leben Jesus Christus, als er Prof. Zacharias Tanee Fomum predigen hörte. Dieser wurde sein geistlicher Vater und bildete ihn als Jünger aus.',
		'Zuerst diente er an seiner Seite: als Laborassistent an der Universität Yaoundé, dann als sein persönlicher Assistent und Privatsekretär. In diesen Jahren veröffentlichte er das erste Erweckungstraktat, „Gott spricht zu dem Menschen, der hören will“, und rief die erste Gebetskette in Yaoundé ins Leben.',
		'Als nationaler Missionar gründete er über fünfzig Gemeinden in Kamerun. 1989 wurde er in Yaoundé zum Bischof geweiht.',
		'1994 ging er mit seiner Frau Adela als Missionar nach Nigeria. Dort dienten sie vierzehn Jahre lang.',
		'Seit 2009, als Prof. Fomum heim zum Herrn ging, leitet er die CMFI unter den Nationen. Im Dezember 2019 brachte er in Koume bei Bertoua die Botschaften der dritten Weltkonvention vor Mitgliedern aus 93 Nationen. Er ist außerdem Autor mehrerer Bücher über den Dienst für Gott und den Aufbau der Gemeinde.',
	];
}

// Path: prayer.retreat.hints
class _Translations$prayer$retreat$hints$de extends Translations$prayer$retreat$hints$fr {
	_Translations$prayer$retreat$hints$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String assembly({required Object name}) => 'Deine Gemeinde: ${name}';
	@override String get assemblyMissing => 'Füge deine Gemeinde in deinem Profil hinzu';
	@override String authorities({required Object names}) => 'Deine Autoritäten: ${names}';
	@override String get authoritiesMissing => 'Füge deine geistlichen Autoritäten unter „Mehr“ hinzu';
	@override String list({required Object list}) => 'Meine Listen · ${list}';
	@override String listEmpty({required Object list}) => 'Deine Liste „${list}“ ist leer: Füge Namen hinzu';
	@override String nation({required Object name}) => 'Heute: ${name}';
	@override String myCountry({required Object name}) => 'Dein Land: ${name}';
	@override String get hymn => 'Lieder öffnen';
}

// Path: prayer.lists.answeredOn
class _Translations$prayer$lists$answeredOn$de extends Translations$prayer$lists$answeredOn$fr {
	_Translations$prayer$lists$answeredOn$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String unbelievers({required Object date}) => 'Am ${date} zum Glauben an den Herrn gekommen';
	@override String believers({required Object date}) => 'Erhört am ${date}';
	@override String backsliders({required Object date}) => 'Am ${date} zurückgekehrt';
	@override String coworkers({required Object date}) => 'Erhört am ${date}';
}

// Path: prayer.lists.sheet
class _Translations$prayer$lists$sheet$de extends Translations$prayer$lists$sheet$fr {
	_Translations$prayer$lists$sheet$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get addTitle => 'Person hinzufügen';
	@override String get editTitle => 'Bearbeiten';
	@override String get name => 'Name';
	@override String get namePlaceholder => 'Paul M.';
	@override String get note => 'Notiz';
	@override String get notePlaceholder => 'Kollege, Nachbar, Cousine …';
	@override String get list => 'Liste';
	@override String get save => 'Speichern';
	@override String get remove => 'Von der Liste entfernen';
	@override String removeTitle({required Object name}) => '${name} entfernen?';
	@override String get removeText => 'Du betest in deinen Gebetszeiten nicht mehr für diese Person.';
}

// Path: prayer.importunity.form
class _Translations$prayer$importunity$form$de extends Translations$prayer$importunity$form$fr {
	_Translations$prayer$importunity$form$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get newTitle => 'Neues beharrliches Anliegen';
	@override String get editTitle => 'Anliegen bearbeiten';
	@override String get subject => 'Anliegen';
	@override String get subjectPlaceholder => 'Herr, rette Paul';
	@override String get description => 'Details';
	@override String get descriptionPlaceholder => 'Für wen, warum …';
	@override String get goal => 'Ziel';
	@override String get goalHint => 'Die Anzahl an Proklamationen, die ihr gemeinsam erreichen wollt. Lass das Feld leer, um ohne Ziel zu zählen.';
	@override String get goalPlaceholder => '10.000';
	@override String get create => 'Erstellen';
	@override String get save => 'Speichern';
}

// Path: prayer.importunity.inviteSheet
class _Translations$prayer$importunity$inviteSheet$de extends Translations$prayer$importunity$inviteSheet$fr {
	_Translations$prayer$importunity$inviteSheet$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Zum Beten einladen';
	@override String get family => 'Meine geistliche Familie';
	@override String familyText({required num n, required Object name}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
		one: '${name} und die Jünger: ${n} Person',
		other: '${name} und die Jünger: ${n} Personen',
	);
	@override String get familyMissing => 'Verknüpfe deinen Jüngermacher unter „Meine geistlichen Autoritäten“, um deine geistliche Familie einzuladen.';
	@override String get byUsername => 'Per Benutzername';
	@override String get usernameLabel => 'Benutzername';
	@override String get addUsername => 'Hinzufügen';
	@override String get send => 'Einladungen senden';
	@override String sent({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
		zero: 'Sie waren schon eingeladen.',
		one: '${n} Einladung gesendet',
		other: '${n} Einladungen gesendet',
	);
}

/// The flat map containing all translations for locale <de>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsDe {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'app.name' => 'CMFI Connect',
			'app.tagline' => 'Gemeinsam wachsen, jeden Tag.',
			'app.languageName' => 'Deutsch',
			'common.retry' => 'Erneut versuchen',
			'common.cancel' => 'Abbrechen',
			'common.save' => 'Speichern',
			'common.close' => 'Schließen',
			'common.back' => 'Zurück',
			'common.soon' => 'Bald',
			'common.optional' => '(optional)',
			'common.and' => 'und',
			'common.loading' => 'Wird geladen…',
			'common.done' => 'Fertig',
			'common.rangeStart' => 'Von',
			'common.rangeEnd' => 'Bis',
			'errors.network' => 'Keine Internetverbindung. Prüfe dein Netzwerk und versuche es erneut.',
			'errors.unauthorized' => 'Deine Sitzung ist abgelaufen. Melde dich erneut an.',
			'errors.invalidCredentials' => 'Telefonnummer oder Passwort ist falsch.',
			'errors.badRequest' => 'Einige Angaben sind ungültig.',
			'errors.conflict' => 'Dieser Eintrag existiert bereits.',
			'errors.notFound' => 'Eintrag nicht gefunden.',
			'errors.server' => 'Auf dem Server ist ein Problem aufgetreten. Versuche es gleich noch einmal.',
			'errors.unknown' => 'Ein Fehler ist aufgetreten. Versuche es erneut.',
			'errors.forbidden' => 'Dazu bist du nicht berechtigt.',
			'errors.eventFull' => 'Für diese Veranstaltung sind keine Plätze mehr frei.',
			'errors.registrationClosed' => 'Die Anmeldung für diese Veranstaltung ist geschlossen.',
			'errors.mediaTooLarge' => 'Dieses Bild ist zu groß (höchstens 8 MB).',
			'errors.mediaUnsupported' => 'Wähle ein JPEG- oder PNG-Bild.',
			'errors.notParticipant' => 'Schließ dich zuerst diesem Anliegen an, um deine Proklamationen zu zählen.',
			'errors.importunityClosed' => 'Dieses Anliegen ist abgeschlossen: Es werden keine Proklamationen mehr gezählt.',
			'errors.usernameNotFound' => 'Niemand hat diesen Benutzernamen. Prüfe die Schreibweise.',
			'errors.ownerCannotLeave' => 'Du hast dieses Anliegen erstellt: Lösche es, statt es zu verlassen.',
			'errors.tooManyPeople' => 'Deine Listen sind voll (höchstens 500 Personen).',
			'errors.avatarInvalid' => 'Dieses Foto kann nicht verwendet werden. Wähle ein anderes.',
			'errors.reportsNotShared' => 'Dieses Mitglied teilt seine Berichte nicht mehr.',
			'validation.required' => 'Dieses Feld ist erforderlich',
			'validation.passwordTooShort' => 'Mindestens 6 Zeichen',
			'validation.invalidPhone' => 'Ungültige Telefonnummer',
			'validation.invalidEmail' => 'Ungültige E-Mail-Adresse',
			'validation.invalidCode' => 'Nur Buchstaben und Ziffern, ohne Leerzeichen',
			'onboarding.skip' => 'Überspringen',
			'onboarding.next' => 'Weiter',
			'onboarding.start' => 'Los geht\'s',
			'onboarding.step' => ({required Object current, required Object total}) => 'Seite ${current} von ${total}',
			'onboarding.reports.title' => 'Dein Weg mit Gott, Tag für Tag',
			'onboarding.reports.text' => 'Notiere in Sekunden deine Bibellese, dein Gebet, dein Fasten … und verfolge deinen Fortschritt Woche für Woche.',
			'onboarding.worship.title' => 'Singe und bete, wo immer du bist',
			'onboarding.worship.text' => 'Finde die Lieder der Gemeinschaft und bete jeden Tag mit deinen Brüdern und Schwestern für die Gebetsanliegen.',
			'onboarding.community.title' => 'Bleib mit deiner Gemeinschaft verbunden',
			'onboarding.community.text' => 'Die Veranstaltungen und Ankündigungen deiner Gemeinde an einem Ort, damit du nichts verpasst.',
			'onboarding.sample.today' => 'Heute',
			'onboarding.sample.bibleReading' => 'Bibellese',
			'onboarding.sample.prayerAlone' => 'Persönliches Gebet',
			'onboarding.sample.meditation' => 'Meditation',
			'onboarding.sample.groupPrayer' => 'Gebet in der Gruppe',
			'onboarding.sample.thisWeek' => 'Diese Woche',
			'onboarding.sample.weekScore' => '4 von 5 Tagen',
			'onboarding.sample.hymn' => 'Lied',
			'onboarding.sample.hymnNumber' => 'Nr. 12',
			'onboarding.sample.fullScreen' => 'Vollbild',
			'onboarding.sample.prayerOfTheDay' => 'Gebetsanliegen des Tages',
			'onboarding.sample.prayerTopic' => 'Für die Prüfungen unserer Jugendlichen',
			'onboarding.sample.praying' => '12 Personen beten',
			'onboarding.sample.iPray' => 'Ich bete',
			'onboarding.sample.vigil' => 'Gebetsnacht',
			'onboarding.sample.vigilMeta' => '20 Uhr · Ortsgemeinde',
			'onboarding.sample.join' => 'Ich bin dabei',
			'onboarding.sample.retreat' => 'Jugendfreizeit',
			'onboarding.sample.retreatMeta' => 'Ganztägig',
			'onboarding.sample.announcement' => 'Ankündigung',
			'onboarding.sample.announcementText' => 'Der Gottesdienst am Sonntag beginnt um 8:30 Uhr.',
			'onboarding.sample.chapters' => '10 Kap.',
			'welcome.title' => 'Willkommen bei CMFI Connect',
			'welcome.text' => 'Erstelle in einer Minute dein Konto, um deinen Tagesbericht auszufüllen und das Leben deiner Gemeinschaft mitzuverfolgen.',
			'welcome.createAccount' => 'Konto erstellen',
			'welcome.haveAccount' => 'Ich habe schon ein Konto',
			'auth.phone' => 'Telefon',
			'auth.dialCode' => ({required Object code}) => 'Ländervorwahl: ${code}',
			'auth.password' => 'Passwort',
			'auth.showPassword' => 'Passwort anzeigen',
			'auth.hidePassword' => 'Passwort verbergen',
			'auth.login.title' => 'Willkommen zurück',
			'auth.login.subtitle' => 'Melde dich an, um deinen heutigen Bericht auszufüllen.',
			'auth.login.submit' => 'Anmelden',
			'auth.login.noAccount' => 'Noch kein Konto?',
			'auth.login.createAccount' => 'Konto erstellen',
			'auth.register.step' => ({required Object current, required Object total}) => '${current} / ${total}',
			'auth.register.title' => 'Erstelle dein Konto',
			'auth.register.subtitle' => 'Mit deiner Telefonnummer meldest du dich an.',
			'auth.register.firstName' => 'Vorname',
			'auth.register.lastName' => 'Nachname',
			'auth.register.passwordHelp' => 'Mindestens 6 Zeichen',
			'auth.register.email' => 'E-Mail',
			'auth.register.submit' => 'Weiter',
			'auth.register.haveAccount' => 'Schon ein Konto?',
			'auth.register.login' => 'Anmelden',
			'auth.register.alreadyUsed' => 'Für diese Nummer oder E-Mail gibt es schon ein Konto. Melde dich an.',
			'auth.register.emailHint' => 'du@beispiel.de',
			'auth.church.title' => 'Deine Kirche',
			'auth.church.subtitle' => 'Mit diesen Angaben finden dich deine Verantwortlichen. Du kannst sie später ändern.',
			'auth.church.editTitle' => 'Mein Profil',
			'auth.church.editSubtitle' => 'Aktualisiere deinen Namen, deine Kirche und deine Gemeinde.',
			'auth.church.country' => 'Land',
			'auth.church.countryHint' => 'Wähle dein Land',
			'auth.church.city' => 'Stadt',
			'auth.church.cityHint' => 'Yaoundé',
			'auth.church.church' => 'Kirche',
			'auth.church.churchHint' => 'Name deiner Kirche',
			'auth.church.assembly' => 'Gemeinde',
			'auth.church.assemblyHint' => 'Name deiner Gemeinde',
			'auth.church.info' => 'Umgezogen oder Gemeinde gewechselt? Du kannst alles in deinem Profil aktualisieren.',
			'auth.church.submit' => 'Fertig',
			'auth.church.skip' => 'Diesen Schritt überspringen',
			'auth.church.saved' => 'Profil gespeichert',
			'auth.forgot.link' => 'Passwort vergessen?',
			'auth.forgot.title' => 'Passwort vergessen',
			'auth.forgot.phoneText' => 'Gib deine Nummer ein: Wir senden dir per SMS einen Code, um ein neues Passwort zu wählen.',
			'auth.forgot.sendCode' => 'Code erhalten',
			'auth.forgot.codeTitle' => 'Code eingeben',
			'auth.forgot.codeText' => ({required Object phone}) => 'Wir haben einen 6-stelligen Code an ${phone} gesendet.',
			'auth.forgot.code' => 'Per SMS erhaltener Code',
			'auth.forgot.codeInvalid' => 'Der Code hat 6 Ziffern',
			'auth.forgot.verify' => 'Überprüfen',
			'auth.forgot.resend' => 'Code erneut senden',
			'auth.forgot.resendIn' => ({required Object seconds}) => 'Erneut senden in ${seconds} s',
			'auth.forgot.changeNumber' => 'Nummer ändern',
			'auth.forgot.passwordTitle' => 'Neues Passwort',
			'auth.forgot.passwordText' => 'Wähle ein neues Passwort für dein Konto.',
			'auth.forgot.submit' => 'Speichern und anmelden',
			'auth.forgot.done' => 'Passwort geändert. Willkommen zurück!',
			'auth.forgot.remembered' => 'Doch wieder eingefallen?',
			'auth.forgot.invalidCode' => 'Dieser Code ist nicht richtig.',
			'auth.forgot.expired' => 'Der Code ist abgelaufen. Fordere einen neuen an.',
			'auth.forgot.tooManyRequests' => 'Zu viele Versuche. Versuche es später erneut.',
			'auth.forgot.unavailable' => 'Das Zurücksetzen ist gerade nicht möglich.',
			'auth.forgot.noAccount' => 'Kein Konto verwendet diese Nummer.',
			'auth.biometric.faceId' => 'Face ID',
			'auth.biometric.touchId' => 'Touch ID',
			'auth.biometric.fingerprint' => 'deinem Fingerabdruck',
			'auth.biometric.face' => 'deinem Gesicht',
			'auth.biometric.signIn' => ({required Object method}) => 'Mit ${method} anmelden',
			'auth.biometric.askTitle' => ({required Object method}) => 'Mit ${method} anmelden?',
			'auth.biometric.askText' => 'Beim nächsten Mal musst du dein Passwort nicht eingeben: Es bleibt im sicheren Speicher deines Telefons.',
			'auth.biometric.enable' => 'Einschalten',
			'auth.biometric.later' => 'Später',
			'auth.biometric.reason' => 'Bei CMFI Connect anmelden',
			'auth.biometric.enableReason' => 'Schnelle Anmeldung bei CMFI Connect einschalten',
			'auth.biometric.changed' => ({required Object method}) => 'Dein Passwort hat sich geändert: Melde dich mit deinem Passwort an und schalte ${method} dann wieder ein.',
			'auth.biometric.settings' => ({required Object method}) => 'Anmeldung mit ${method}',
			'auth.biometric.settingsText' => 'Ohne dein Passwort einzugeben',
			'auth.biometric.passwordTitle' => 'Dein Passwort',
			'auth.biometric.passwordLabel' => 'Passwort',
			'auth.biometric.confirm' => 'Bestätigen',
			'auth.biometric.enabled' => ({required Object method}) => 'Anmeldung mit ${method} ist eingeschaltet',
			'countries.dialCodeTitle' => 'Ländervorwahl',
			'countries.title' => 'Dein Land',
			'countries.search' => 'Land oder Vorwahl suchen',
			'countries.none' => 'Kein Land gefunden',
			'countries.change' => 'Land ändern',
			'nav.home' => 'Start',
			'nav.reports' => 'Bericht',
			'nav.hymns' => 'Lieder',
			'nav.prayer' => 'Gebet',
			'nav.bible' => 'Bibel',
			'home.greeting' => ({required Object name}) => 'Hallo ${name}',
			'home.greetingNoName' => 'Hallo',
			'home.profile' => 'Mein Profil',
			'home.progress' => ({required Object filled, required Object total}) => '${filled} von ${total}',
			'home.progressLabel' => 'Elemente ausgefüllt',
			'home.goals' => 'Ziele',
			'home.weekTitle' => 'Deine Woche',
			'home.community' => 'Aktuell bei der CMFI',
			'home.eventsTitle' => 'Veranstaltungen',
			'home.hymnsTitle' => 'Lieder',
			'home.hymnsOpen' => 'Liederbuch öffnen',
			'home.continueMyReport' => 'Bericht fortsetzen',
			'home.startMyReport' => 'Bericht beginnen',
			'home.items' => 'Punkte',
			'home.goalsTitle' => 'Ziele',
			'home.retreatsTitle' => 'Gebetszeiten',
			'home.retreatsValue' => ({required Object n}) => '${n} von 4',
			'home.streakTitle' => 'Serie',
			'home.resume' => 'Weitermachen',
			'home.hymnNumber' => ({required Object number}) => 'Lied Nr. ${number}',
			'home.seeAll' => 'Alle ansehen',
			'home.retreatsDone' => 'Die 4 Gebetszeiten des Tages sind gemacht',
			'home.days' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n, one: '${n} Tag', other: '${n} Tage', ), 
			'home.hideNumbers' => 'Meine Zahlen ausblenden',
			'home.showNumbers' => 'Meine Zahlen anzeigen',
			'home.numbersHidden' => 'ausgeblendet',
			'reports.title' => 'Tagesbericht',
			'reports.myItems' => 'Meine Elemente',
			'reports.tabs.today' => 'Heute',
			'reports.tabs.history' => 'Verlauf',
			'reports.tabs.summary' => 'Übersicht',
			'reports.pickDay' => 'Tag wählen',
			'reports.filled' => ({required Object filled, required Object total}) => '${filled} von ${total} ausgefüllt',
			'reports.statusSaved' => 'Gespeichert',
			'reports.statusModified' => 'Nicht gespeichert',
			'reports.standard' => 'Standard',
			'reports.personal' => 'Meine Elemente',
			'reports.createItem' => 'Element erstellen',
			'reports.add' => ({required Object label}) => '${label} eintragen',
			'reports.note' => 'Notiz des Tages',
			'reports.noteHint' => 'Ein Vers, ein Grund zur Dankbarkeit …',
			'reports.save' => 'Tag speichern',
			'reports.saved' => 'Tag gespeichert',
			'reports.measure.quantity' => ({required Object unit}) => '${unit}',
			'reports.measure.duration' => 'Dauer',
			'reports.measure.both' => ({required Object unit}) => '${unit} und Dauer',
			'reports.measure.quantityNoUnit' => 'Anzahl',
			'reports.measure.bothNoUnit' => 'Anzahl und Dauer',
			'reports.times' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n, one: '${n}-mal', other: '${n}-mal', ), 
			'reports.sheet.quantity' => 'Anzahl',
			'reports.sheet.duration' => 'Dauer',
			'reports.sheet.minus1' => '− 1 Min.',
			'reports.sheet.plus1' => '+ 1 Min.',
			'reports.sheet.removeMinute' => 'Eine Minute weniger',
			'reports.sheet.addMinute' => 'Eine Minute mehr',
			'reports.sheet.holdToRepeat' => 'Gedrückt halten, um schneller zu zählen',
			'reports.sheet.decrease' => 'Verringern',
			'reports.sheet.increase' => 'Erhöhen',
			'reports.sheet.clear' => 'Löschen',
			'reports.sheet.validate' => 'Fertig',
			'reports.history.daysFilled' => ({required Object filled, required Object total}) => '${filled} von ${total} Tagen ausgefüllt',
			'reports.history.legendFilled' => 'Ausgefüllt',
			'reports.history.legendMissing' => 'Kein Bericht',
			'reports.history.none' => 'Kein Bericht',
			'reports.history.fill' => 'Ausfüllen',
			'reports.history.inProgress' => 'Begonnen',
			'reports.history.previousMonth' => 'Vorheriger Monat',
			'reports.history.nextMonth' => 'Nächster Monat',
			'reports.history.today' => 'heute',
			'reports.summary.week' => 'Woche',
			'reports.summary.month' => 'Monat',
			'reports.summary.year' => 'Jahr',
			'reports.summary.range' => ({required Object from, required Object to}) => 'Vom ${from} bis ${to}',
			'reports.summary.regularity' => 'Regelmäßigkeit',
			'reports.summary.daysFilled' => 'Tage ausgefüllt',
			'reports.summary.missingDays' => ({required num n, required Object days}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n, one: '${n} Tag ohne Bericht: am ${days}.', other: '${n} Tage ohne Bericht: am ${days}.', ), 
			'reports.summary.missingCount' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n, one: '${n} Tag ohne Bericht', other: '${n} Tage ohne Bericht', ), 
			'reports.summary.noMissing' => 'Kein Tag verpasst, super!',
			'reports.summary.perDay' => ({required Object value}) => '${value} pro ausgefülltem Tag',
			'reports.summary.days' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n, one: '${n} Tag', other: '${n} Tage', ), 
			'reports.summary.notFilled' => 'Noch nicht ausgefüllt',
			'reports.summary.barsCaption' => ({required Object max}) => 'Pro Tag · höchster Balken: ${max}',
			'reports.summary.barsCaptionMonthly' => ({required Object max}) => 'Pro Monat · höchster Balken: ${max}',
			'reports.summary.empty' => 'Kein Bericht in diesem Zeitraum.',
			'reports.summary.goalDays' => ({required num n, required Object total}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n, one: 'Ziel an ${n} von ${total} Tagen erreicht', other: 'Ziel an ${n} von ${total} Tagen erreicht', ), 
			'reports.summary.share' => 'Diese Übersicht teilen',
			'reports.summary.goals' => 'Ziele',
			'reports.summary.goalsAverage' => 'Durchschnittliche Erfüllung deiner Ziele',
			'reports.summary.goalsHint' => 'Jeder Tag zählt, auch ein leerer. Heute zählt, sobald er ausgefüllt ist.',
			'reports.summary.evolution' => 'Entwicklung deiner Ziele',
			'reports.summary.evolutionHint' => 'Woche für Woche, über die letzten 12.',
			'reports.summary.premiumYear' => 'Das Jahr und die Entwicklung deiner Ziele gibt es mit Premium.',
			'reports.noItems' => 'Im Moment gibt es nichts auszufüllen.',
			'reports.statusPending' => 'Noch nicht gesendet',
			'reports.savedOffline' => 'Kein Netz: Der Tag bleibt auf dem Handy gespeichert und wird gesendet, sobald es möglich ist.',
			'reports.pendingBanner' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n, one: '${n} Tag wartet auf Netz, um gesendet zu werden', other: '${n} Tage warten auf Netz, um gesendet zu werden', ), 
			'reports.export' => 'Meinen Bericht exportieren',
			'reports.goal' => ({required Object value}) => 'Ziel: ${value}',
			'reports.goalReached' => 'Ziel erreicht',
			'reports.dayGoals' => 'Ziele des Tages',
			'reports.goalsReached' => ({required Object reached, required Object total}) => 'Erreicht: ${reached} von ${total}',
			'reports.standardItems.lb' => 'Bibellese',
			'reports.standardItems.ps' => 'Persönliches Gebet',
			'reports.standardItems.rdqad' => 'Meditation',
			'reports.standardItems.pg' => 'Gebet in der Gruppe',
			'reports.standardItems.llc' => 'Lektüre christlicher Literatur',
			'reports.standardItems.jc' => 'Vollfasten',
			'reports.standardItems.jp' => 'Teilfasten',
			'reports.standardItems.dimes' => 'Zehnt',
			'reports.standardItems.off' => 'Opfergaben',
			'reports.units.chapters.name' => 'Anzahl der Kapitel',
			'reports.units.chapters.label' => 'Kapitel',
			'reports.units.chapters.symbol' => 'Kapitel',
			'reports.units.chapters.count' => ({required num n, required Object value}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n, one: '${value} Kapitel', other: '${value} Kapitel', ), 
			'reports.units.times.name' => 'Anzahl',
			'reports.units.times.label' => 'Anzahl',
			'reports.units.times.symbol' => 'Mal',
			'reports.units.times.count' => ({required num n, required Object value}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n, one: '${value}-mal', other: '${value}-mal', ), 
			'reports.units.pages.name' => 'Anzahl der Seiten',
			'reports.units.pages.label' => 'Seiten',
			'reports.units.pages.symbol' => 'Seiten',
			'reports.units.pages.count' => ({required num n, required Object value}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n, one: '${value} Seite', other: '${value} Seiten', ), 
			'reports.units.percent.name' => 'Prozentsatz',
			'reports.units.percent.label' => 'Prozent',
			'reports.units.percent.symbol' => '%',
			'reports.units.percent.count' => ({required Object value}) => '${value} %',
			'reminder.title' => 'Dein Tagesbericht',
			'reminder.body' => 'Nimm dir eine Minute, um deine Bibellese, dein Gebet … festzuhalten, bevor der Tag endet.',
			'reminder.channel' => 'Erinnerung an den Tagesbericht',
			'reminder.settings' => 'Erinnerung am Abend',
			'reminder.off' => 'Aus',
			'reminder.switchLabel' => 'Erinnere mich, meinen Tag auszufüllen',
			'reminder.switchHint' => 'Nur wenn der Tag noch nicht ausgefüllt ist.',
			'reminder.time' => 'Uhrzeit der Erinnerung',
			'reminder.offerTitle' => 'Jeden Abend eine Erinnerung?',
			'reminder.offerText' => 'Wenn dein Tag noch nicht ausgefüllt ist, erinnert dich die App zur gewählten Uhrzeit daran. Ist schon alles erledigt, kommt nichts.',
			'reminder.offerAccept' => 'Erinnerung aktivieren',
			'reminder.offerLater' => 'Später',
			'reminder.enabled' => ({required Object time}) => 'Erinnerung um ${time} aktiviert',
			'reminder.denied' => 'Benachrichtigungen für CMFI Connect sind blockiert. Erlaube sie in den Einstellungen deines Handys.',
			'export.title' => 'Exportieren',
			'export.period' => 'Zeitraum',
			'export.thisWeek' => 'Diese Woche',
			'export.lastWeek' => 'Letzte Woche',
			'export.thisMonth' => 'Dieser Monat',
			'export.lastMonth' => 'Letzter Monat',
			'export.thisYear' => 'Dieses Jahr',
			'export.custom' => 'Eigener Zeitraum',
			'export.customPick' => 'Zeitraum wählen',
			'export.format' => 'Format',
			'export.pdf' => 'PDF',
			'export.pdfHint' => 'Ein Dokument zum Versenden oder Drucken',
			'export.csv' => 'Tabelle',
			'export.csvHint' => 'Eine CSV-Datei für Excel oder Google Sheets',
			'export.text' => 'Nachricht',
			'export.textHint' => 'Eine Zusammenfassung zum Einfügen in WhatsApp',
			'export.button' => 'Exportieren',
			'export.shareButton' => 'Teilen',
			'export.preview' => ({required num filled, required Object total, required Object items}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(filled, one: '${filled} von ${total} Tagen ausgefüllt · ${items}', other: '${filled} von ${total} Tagen ausgefüllt · ${items}', ), 
			'export.previewItems' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n, one: '${n} Element', other: '${n} Elemente', ), 
			'export.empty' => 'Kein Bericht in diesem Zeitraum.',
			'export.tooLong' => 'Wähle höchstens 366 Tage.',
			'export.fileName' => 'tagesbericht',
			'export.subject' => ({required Object period}) => 'Mein Tagesbericht, ${period}',
			'export.doc.title' => 'Tagesbericht',
			'export.doc.regularity' => 'Regelmäßigkeit',
			'export.doc.daysFilled' => ({required num filled, required Object total}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(filled, one: '${filled} von ${total} Tagen ausgefüllt', other: '${filled} von ${total} Tagen ausgefüllt', ), 
			'export.doc.totals' => 'Im Zeitraum',
			'export.doc.item' => 'Element',
			'export.doc.total' => 'Gesamt',
			'export.doc.days' => 'Tage',
			'export.doc.average' => 'Durchschnitt / ausgefüllter Tag',
			'export.doc.goal' => 'Ziel erreicht',
			'export.doc.detail' => 'Tag für Tag',
			'export.doc.date' => 'Datum',
			'export.doc.values' => 'Ausgefüllt',
			'export.doc.note' => 'Notiz',
			'export.doc.noReport' => 'Kein Bericht',
			'export.doc.generated' => ({required Object date}) => 'Erstellt am ${date} mit CMFI Connect',
			'export.doc.page' => ({required Object n, required Object total}) => 'Seite ${n} / ${total}',
			'export.doc.filledColumn' => 'Bericht',
			'export.doc.yes' => 'ja',
			'export.doc.no' => 'nein',
			'export.doc.sentFrom' => 'Gesendet mit CMFI Connect',
			'items.title' => 'Meine Elemente',
			'items.standardSection' => 'Standard · für alle',
			'items.personalSection' => 'Meine persönlichen Elemente',
			'items.emptyPersonal' => 'Du hast noch kein persönliches Element.',
			'items.archive' => 'Archivieren',
			'items.archiveTitle' => ({required Object code}) => '${code} archivieren?',
			'items.archiveText' => 'Es wird in deinem Bericht nicht mehr angeboten. Seine Zahlen bleiben in deinem Verlauf erhalten.',
			'items.archived' => ({required Object code}) => '${code} archiviert',
			'items.create' => 'Element erstellen',
			'items.footnote' => 'Ein archiviertes Element wird in deinem Bericht nicht mehr angeboten, aber seine Zahlen bleiben in deinem Verlauf erhalten.',
			'items.measure.quantity' => ({required Object unit}) => 'Anzahl · ${unit}',
			'items.measure.quantityNoUnit' => 'Anzahl',
			'items.measure.duration' => 'Dauer',
			'items.measure.both' => ({required Object unit}) => 'Anzahl (${unit}) und Dauer',
			'items.measure.bothNoUnit' => 'Anzahl und Dauer',
			'items.goalAdd' => 'Ziel hinzufügen',
			'items.goal' => ({required Object value}) => 'Ziel: ${value} pro Tag',
			'items.goalTitle' => 'Tagesziel',
			'items.goalHint' => 'Was du dir für jeden Tag vornimmst. Es bleibt auf deinem Handy.',
			'items.goalRemove' => 'Entfernen',
			'items.goalSaved' => 'Ziel gespeichert',
			'items.goalRemoved' => 'Ziel entfernt',
			'newItem.title' => 'Neues Element',
			'newItem.code' => 'Code',
			'newItem.label' => 'Name',
			'newItem.help' => 'Buchstaben und Ziffern, höchstens 20. Codes von Standardelementen (LB, PS …) sind nicht verfügbar.',
			'newItem.measures' => 'Was du misst',
			'newItem.quantity' => 'Eine Anzahl',
			'newItem.quantityHint' => 'Kapitel, Seiten, Personen …',
			'newItem.unit' => 'Einheit hinter der Zahl',
			'newItem.unitHint' => 'Personen',
			'newItem.duration' => 'Eine Dauer',
			'newItem.durationHint' => 'In Stunden und Minuten',
			'newItem.noMeasure' => 'Wähle mindestens eine Messgröße: eine Anzahl, eine Dauer oder beides.',
			'newItem.preview' => 'Vorschau in deinem Bericht',
			'newItem.previewCode' => 'CODE',
			'newItem.previewLabel' => 'Name des Elements',
			'newItem.submit' => 'Element erstellen',
			'newItem.created' => ({required Object code}) => '${code} wurde erstellt.',
			'newItem.codeTaken' => 'Dieser Code wird schon verwendet, von einem Standardelement oder von einem deiner Elemente (auch archiviert).',
			'newItem.codeHint' => 'EVG',
			'newItem.labelHint' => 'Evangelisation',
			'more.title' => 'Mehr',
			'more.editProfile' => 'Profil bearbeiten',
			'more.community' => 'Gemeinschaft',
			'more.events' => 'Veranstaltungen',
			'more.reports' => 'Tagesbericht',
			'more.myItems' => 'Meine Elemente',
			'more.app' => 'App',
			'more.language' => 'Sprache',
			'more.appearance' => 'Darstellung',
			'more.themeSystem' => 'Automatisch',
			'more.themeSystemHint' => 'Bei „Automatisch“ folgt die App dem hellen oder dunklen Modus deines Handys.',
			'more.themeLight' => 'Hell',
			'more.themeDark' => 'Dunkel',
			'more.logout' => 'Abmelden',
			'more.account' => 'Konto',
			'more.languageTitle' => 'Sprache der App',
			'more.completeProfile' => 'Füge deinen Namen hinzu',
			'more.accompaniment' => 'Begleitung',
			'more.exportReport' => 'Meinen Bericht exportieren',
			'more.logoutPendingTitle' => 'Noch nicht gesendete Tage',
			'more.logoutPendingText' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n, one: '${n} ohne Netz gespeicherter Tag wurde noch nicht gesendet. Wenn du dich jetzt abmeldest, geht er verloren.', other: '${n} ohne Netz gespeicherte Tage wurden noch nicht gesendet. Wenn du dich jetzt abmeldest, gehen sie verloren.', ), 
			'more.logoutAnyway' => 'Trotzdem abmelden',
			'more.admin' => 'Verwaltung',
			'more.staff' => 'Team und Rollen',
			'more.manageEvents' => 'Veranstaltungen',
			'more.disciples' => 'Meine Jünger',
			'more.version' => ({required Object version}) => 'Version ${version}',
			'more.copyright' => ({required Object year}) => '© ${year} Christian Missionary Fellowship International. Alle Rechte vorbehalten.',
			'authorities.title' => 'Meine geistlichen Autoritäten',
			'authorities.intro' => 'Die Menschen, die dich auf deinem Weg mit Gott begleiten: dein Jüngermacher und deine anderen Verantwortlichen.',
			'authorities.discipleMaker' => 'Jüngermacher',
			'authorities.discipleMakerOf' => ({required Object name}) => 'Jüngermacher: ${name}',
			'authorities.noDiscipleMaker' => 'Noch kein Jüngermacher',
			'authorities.others' => 'Weitere Autoritäten',
			'authorities.empty' => 'Du hast noch niemanden hinzugefügt.',
			'authorities.add' => 'Autorität hinzufügen',
			'authorities.remove' => 'Entfernen',
			'authorities.removeTitle' => ({required Object name}) => '${name} entfernen?',
			'authorities.removeText' => ({required Object name}) => '${name} gehört dann nicht mehr zu deinen geistlichen Autoritäten.',
			'authorities.removed' => ({required Object name}) => '${name} gehört nicht mehr zu deinen Autoritäten.',
			'authorities.count' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n, zero: 'Noch niemand', one: '${n} Person', other: '${n} Personen', ), 
			'authorities.form.title' => 'Neue Autorität',
			'authorities.form.emailHint' => 'name@beispiel.de',
			'authorities.form.isDiscipleMaker' => 'Das ist mein Jüngermacher',
			'authorities.form.isDiscipleMakerHelp' => 'Die Person, die dich persönlich begleitet. Du hast nur einen.',
			'authorities.form.discipleMakerTaken' => ({required Object name}) => '${name} ist bereits dein Jüngermacher. Entferne die Person aus der Liste, um jemand anderen zu wählen.',
			'authorities.form.submit' => 'Hinzufügen',
			'authorities.form.added' => ({required Object name}) => '${name} gehört jetzt zu deinen Autoritäten.',
			'authorities.form.searchLabel' => 'Benutzername',
			'authorities.form.searchHint' => 'benutzername',
			'authorities.form.search' => 'Suchen',
			'authorities.form.searchHelp' => 'Wenn die Person CMFI Connect nutzt, suche sie über ihren Benutzernamen. Sie erhält deine Anfrage, und ihre Kontaktdaten erscheinen, sobald sie angenommen hat.',
			'authorities.form.notFound' => ({required Object username}) => 'Niemand hat den Benutzernamen @${username}.',
			'authorities.form.invite' => 'Zu CMFI Connect einladen',
			'authorities.form.inviteText' => 'Hallo! Ich nutze CMFI Connect, um meinen Weg mit Gott festzuhalten, und ich möchte gern, dass du mich begleitest. Installiere die App, erstelle dein Konto und schick mir dann deinen Benutzernamen, damit ich dich hinzufügen kann.',
			'authorities.form.inviteMine' => ({required Object username}) => 'Mein Benutzername: @${username}',
			'authorities.form.manual' => 'Nicht in der App? Kontaktdaten eingeben',
			'authorities.form.backToSearch' => 'Lieber nach Benutzername suchen',
			'authorities.form.request' => 'Anfrage senden',
			'authorities.form.requested' => ({required Object name}) => 'Anfrage an ${name} gesendet.',
			'authorities.form.alreadyAdded' => 'Diese Person gehört bereits zu deinen Autoritäten.',
			'authorities.form.makerExists' => 'Du hast bereits einen Jüngermacher.',
			'authorities.form.yourself' => 'Das ist dein eigener Benutzername.',
			'authorities.form.sharingHelp' => ({required Object name}) => '${name} wird deine Berichte sehen: die ausgefüllten Punkte, deine Regelmäßigkeit und deine Prozentsätze, nie deine Notiz. Du kannst das auf der Karte beenden.',
			'authorities.statusPending' => 'Ausstehend',
			'authorities.statusDeclined' => 'Abgelehnt',
			'authorities.pendingHelp' => ({required Object name}) => 'Die Kontaktdaten erscheinen, sobald ${name} angenommen hat.',
			'authorities.requests' => 'Erhaltene Anfragen',
			'authorities.requestDiscipleMaker' => 'möchte dich als Jüngermacher',
			'authorities.requestAuthority' => 'bittet dich um Begleitung',
			'authorities.accept' => 'Annehmen',
			'authorities.decline' => 'Ablehnen',
			'authorities.acceptedRequest' => ({required Object name}) => 'Du begleitest jetzt ${name}.',
			'authorities.declinedRequest' => ({required Object name}) => 'Anfrage von ${name} abgelehnt.',
			'authorities.requestsCount' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n, one: '${n} offene Anfrage', other: '${n} offene Anfragen', ), 
			'authorities.sharing.title' => 'Meine Berichte teilen',
			'authorities.sharing.help' => ({required Object name}) => '${name} sieht deine Berichte: die ausgefüllten Punkte, deine Regelmäßigkeit und deine Prozentsätze, nie deine Notiz.',
			'authorities.sharing.on' => ({required Object name}) => 'Deine Berichte werden mit ${name} geteilt.',
			'authorities.sharing.off' => ({required Object name}) => '${name} sieht deine Berichte nicht mehr.',
			'members.username' => 'Benutzername',
			'members.usernameHint' => 'vorname.nachname',
			'members.usernameHelp' => 'So finden dich die anderen Mitglieder.',
			'members.usernameChecking' => 'Wird geprüft …',
			'members.usernameFree' => ({required Object username}) => '@${username} ist verfügbar',
			'members.usernameCurrent' => 'Das ist dein aktueller Benutzername',
			'members.usernameTaken' => 'Dieser Benutzername ist bereits vergeben.',
			'members.usernameInvalid' => '3 bis 30 Zeichen: Buchstaben, Ziffern, „.“ und „_“; nicht mit einem Sonderzeichen beginnen oder enden.',
			'members.usernameReserved' => 'Dieser Benutzername ist reserviert.',
			'members.usernameSaved' => ({required Object username}) => 'Benutzername gespeichert: @${username}',
			'members.deleteAccount.button' => 'Mein Konto löschen',
			'members.deleteAccount.title' => 'Mein Konto löschen',
			'members.deleteAccount.intro' => 'Das ist endgültig. Dein Konto und alles, was dazugehört, wird gelöscht:',
			'members.deleteAccount.itemProfile' => 'dein Profil, dein Profilbild, dein Benutzername und dein Passwort',
			'members.deleteAccount.itemReports' => 'alle deine Tagesberichte, Elemente und Ziele',
			'members.deleteAccount.itemAuthorities' => 'deine geistlichen Autoritäten und die erhaltenen Anfragen',
			'members.deleteAccount.itemEvents' => 'deine Anmeldungen zu Veranstaltungen',
			'members.deleteAccount.itemPrayer' => 'deine Gebetslisten, Gebetszeiten und beharrlichen Anliegen',
			'members.deleteAccount.kept' => 'Veranstaltungen, Neuigkeiten, Fotos und Gebetsanliegen, die du als Admin veröffentlicht hast, bleiben für die Gemeinschaft – ohne deinen Namen.',
			'members.deleteAccount.passwordHelp' => 'Damit wir sicher sind, dass du es bist.',
			'members.deleteAccount.confirm' => 'Endgültig löschen',
			'members.deleteAccount.done' => 'Dein Konto wurde gelöscht. Gott segne dich!',
			'members.deleteAccount.wrongPassword' => 'Falsches Passwort.',
			'members.deleteAccount.lastSuperadmin' => 'Du bist der einzige Superadmin: Gib diese Rolle jemand anderem, bevor du dein Konto löschst.',
			'admin.title' => 'Team und Rollen',
			'admin.intro' => 'Admins verwalten, was die ganze Gemeinschaft teilt. Nur ein Superadmin kann Rollen vergeben oder entziehen.',
			'admin.roleUser' => 'Mitglied',
			'admin.roleAdmin' => 'Admin',
			'admin.roleSuperadmin' => 'Superadmin',
			'admin.giveRole' => 'Rolle vergeben',
			'admin.you' => 'du',
			'admin.roleFor' => ({required Object username}) => 'Rolle von @${username}',
			'admin.roleChanged' => ({required Object username, required Object role}) => '@${username}: ${role}',
			'admin.memberUsername' => 'Benutzername des Mitglieds',
			'admin.empty' => 'Noch keine Admins.',
			'hymns.searchHint' => 'Nummer, Titel oder Text',
			'hymns.openNumber' => 'Zu Nummer springen',
			'hymns.tabs.all' => 'Alle',
			'hymns.tabs.favorites' => 'Favoriten',
			'hymns.tabs.recent' => 'Zuletzt',
			'hymns.chooseBook' => 'Liederbuch wählen',
			'hymns.count' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n, one: '${n} Lied', other: '${n} Lieder', ), 
			'hymns.number' => ({required Object number}) => 'Nr. ${number}',
			_ => null,
		} ?? switch (path) {
			'hymns.emptyFavorites' => 'Tippe auf den Stern eines Liedes, um es hier wiederzufinden.',
			'hymns.emptyRecent' => 'Die Lieder, die du öffnest, erscheinen hier.',
			'hymns.noResult' => ({required Object query}) => 'Kein Lied passt zu „${query}“.',
			'hymns.otherBooks' => 'In den anderen Liederbüchern',
			'hymns.upToDate' => 'Die Liederbücher sind auf dem neuesten Stand.',
			'hymns.updated' => 'Die Liederbücher wurden aktualisiert.',
			'hymns.chorus' => 'Refrain',
			'hymns.chorusNumber' => ({required Object label}) => 'Refrain ${label}',
			'hymns.verse' => ({required Object label}) => 'Strophe ${label}',
			'hymns.times' => ({required Object n}) => '×${n}',
			'hymns.loadFailed' => 'Die Liederbücher konnten nicht geöffnet werden.',
			'hymns.reader.smaller' => 'Text verkleinern',
			'hymns.reader.larger' => 'Text vergrößern',
			'hymns.reader.display' => 'Anzeige',
			'hymns.reader.textSize' => 'Textgröße',
			'hymns.reader.typeface' => 'Schrift',
			'hymns.reader.typefaceAuto' => 'Auto',
			'hymns.reader.typefaceSans' => 'Modern',
			'hymns.reader.typefaceSerif' => 'Klassisch',
			'hymns.reader.typefaceAutoHelp' => 'Klassisch bei großem Text',
			'hymns.reader.background' => 'Hintergrund',
			'hymns.reader.themeAuto' => 'Auto',
			'hymns.reader.themeLight' => 'Hell',
			'hymns.reader.themeSepia' => 'Sepia',
			'hymns.reader.themeDark' => 'Dunkel',
			'hymns.reader.repeatChorus' => 'Refrain nach jeder Strophe wiederholen',
			'hymns.reader.keepScreenOn' => 'Bildschirm eingeschaltet lassen',
			'hymns.reader.addFavorite' => 'Zu Favoriten hinzufügen',
			'hymns.reader.removeFavorite' => 'Aus Favoriten entfernen',
			'hymns.reader.favoriteAdded' => 'Zu Favoriten hinzugefügt',
			'hymns.reader.favoriteRemoved' => 'Aus Favoriten entfernt',
			'hymns.reader.more' => 'Weitere Optionen',
			'hymns.reader.copy' => 'Liedtext kopieren',
			'hymns.reader.copied' => 'Liedtext kopiert',
			'hymns.reader.project' => 'Präsentationsmodus',
			'hymns.reader.pinchHint' => 'Zieh mit zwei Fingern auf oder zu, um die Textgröße zu ändern.',
			'hymns.reader.notFound' => 'Dieses Lied gibt es im Liederbuch nicht mehr.',
			'hymns.reader.share' => 'Liedtext teilen',
			'hymns.projection.exit' => 'Präsentationsmodus beenden',
			'hymns.projection.previous' => 'Vorherige Strophe',
			'hymns.projection.next' => 'Nächste Strophe',
			'hymns.projection.position' => ({required Object current, required Object total}) => '${current} / ${total}',
			'hymns.projection.hint' => 'Tippe rechts, um weiterzugehen, und links, um zurückzugehen.',
			'hymns.pad.title' => 'Zum Lied',
			'hymns.pad.open' => 'Öffnen',
			'hymns.pad.erase' => 'Löschen',
			'hymns.pad.notFound' => ({required Object number}) => 'Kein Lied Nr. ${number} in diesem Liederbuch',
			'hymns.pad.placeholder' => 'Nummer eingeben',
			'comingSoon.badge' => 'Bald verfügbar',
			'comingSoon.backHome' => 'Zurück zum Start',
			'events.title' => 'Veranstaltungen',
			'events.featured' => 'Im Fokus',
			'events.upcoming' => 'Demnächst',
			'events.past' => 'Frühere Ausgaben',
			'events.emptyTitle' => 'Keine anstehenden Veranstaltungen',
			'events.emptyText' => 'Konferenzen und Treffen der ganzen Gemeinschaft erscheinen hier, mit ihrem Programm.',
			'events.manage' => 'Veranstaltungen verwalten',
			'events.next' => 'Nächste Veranstaltung',
			'events.seeAll' => 'Alle Veranstaltungen',
			'events.homeText' => 'Die Treffen der Gemeinschaft, ihr Programm und ihre Neuigkeiten.',
			'events.today' => 'Heute',
			'events.tomorrow' => 'Morgen',
			'events.inDays' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n, one: 'In ${n} Tag', other: 'In ${n} Tagen', ), 
			'events.daysLeft' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n, other: 'Noch ${n} Tage', ), 
			'events.onNow' => 'Läuft gerade',
			'events.over' => 'Beendet',
			'events.cancelled' => 'Abgesagt',
			'events.draft' => 'Entwurf',
			'events.registered' => 'Angemeldet',
			'events.stateOpen' => 'Anmeldung offen',
			'events.stateClosed' => 'Anmeldung geschlossen',
			'events.stateFull' => 'Ausgebucht',
			'events.registrations' => ({required num n, required Object count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n, zero: 'Noch niemand angemeldet: mach den Anfang!', one: '${count} angemeldet', other: '${count} angemeldet', ), 
			'events.people' => ({required num n, required Object count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n, one: '${count} Person', other: '${count} Personen', ), 
			'events.placesLeft' => ({required num n, required Object count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n, zero: 'keine Plätze mehr', one: '${count} Platz frei', other: '${count} Plätze frei', ), 
			'events.oneDay' => ({required Object start, required Object end}) => 'Von ${start} bis ${end}',
			'events.severalDays' => ({required Object startDay, required Object start, required Object endDay, required Object end}) => 'Beginn am ${startDay} um ${start}, Ende am ${endDay} um ${end}',
			'events.venueTime' => ({required Object place}) => 'Ortszeit ${place}',
			'events.addToCalendar' => 'Zum Kalender hinzufügen',
			'events.share' => 'Teilen',
			'events.directions' => 'Route',
			'events.viewPoster' => 'Plakat ansehen',
			'events.tabs.program' => 'Programm',
			'events.tabs.news' => 'Neuigkeiten',
			'events.tabs.info' => 'Infos',
			'events.tabs.photos' => 'Fotos',
			'events.noProgram' => 'Das Programm wird bald veröffentlicht.',
			'events.noNews' => 'Noch keine Neuigkeiten zu dieser Veranstaltung.',
			'events.pinned' => 'Angeheftet',
			'events.now' => 'Gerade jetzt',
			'events.hymn' => ({required Object number}) => 'Lied ${number}',
			'events.about' => 'Beschreibung',
			'events.fees' => 'Kosten',
			'events.deadline' => ({required Object date}) => 'Anmeldung bis ${date}',
			'events.contact' => 'Kontakt',
			'events.call' => ({required Object name}) => '${name} anrufen',
			'events.otherEditions' => 'Weitere Ausgaben',
			'events.cancelledBanner' => 'Diese Veranstaltung ist abgesagt.',
			'events.calendarFailed' => 'Der Kalender des Handys konnte nicht geöffnet werden.',
			'events.linkFailed' => 'Dieser Link konnte nicht geöffnet werden.',
			'events.shareText' => ({required Object title, required Object dates, required Object place}) => '${title}\n${dates} · ${place}\nMelde dich in der App CMFI Connect an.',
			'events.full' => 'Für diese Veranstaltung sind keine Plätze mehr frei.',
			'events.closed' => 'Die Anmeldung für diese Veranstaltung ist geschlossen.',
			'events.register.cta' => 'Ich bin dabei',
			'events.register.title' => 'Ich bin dabei',
			'events.register.people' => 'Wie viele seid ihr?',
			'events.register.peopleHint' => 'Dich mitgezählt, mit deiner Familie oder Gruppe.',
			'events.register.less' => 'Eine Person weniger',
			'events.register.more' => 'Eine Person mehr',
			'events.register.lodging' => 'Ich brauche eine Unterkunft',
			'events.register.lodgingHint' => 'Die Organisatoren planen die Plätze ein.',
			'events.register.departure' => 'Abfahrtsort',
			'events.register.departureHint' => 'z. B. Douala',
			'events.register.confirm' => 'Anmeldung bestätigen',
			'events.register.update' => 'Aktualisieren',
			'events.register.cancel' => 'Anmeldung stornieren',
			'events.register.done' => 'Alles klar, du bist angemeldet! Wir erinnern dich am Vortag daran.',
			'events.register.updated' => 'Deine Anmeldung ist aktualisiert.',
			'events.register.cancelled' => 'Deine Anmeldung wurde storniert.',
			'events.register.edit' => 'Ändern',
			'events.register.youAre' => 'Du bist angemeldet',
			'events.register.cancelTitle' => 'Anmeldung stornieren?',
			'events.register.cancelText' => 'Dein Platz wird für jemand anderen frei.',
			'events.register.keep' => 'Platz behalten',
			'events.register.lodgingShort' => 'Unterkunft',
			'events.reminder.channel' => 'Erinnerungen an Veranstaltungen',
			'events.reminder.tomorrow' => ({required Object title}) => 'Morgen: ${title}',
			'events.reminder.soon' => ({required Object title}) => 'In 1 Std.: ${title}',
			'events.admin.title' => 'Veranstaltungen verwalten',
			'events.admin.create' => 'Veranstaltung erstellen',
			'events.admin.edit' => 'Veranstaltung bearbeiten',
			'events.admin.empty' => 'Noch keine Veranstaltungen. Erstelle die erste!',
			'events.admin.poster' => 'Plakat',
			'events.admin.posterAdd' => 'Plakat auswählen',
			'events.admin.posterChange' => 'Plakat ändern',
			'events.admin.posterRemove' => 'Plakat entfernen',
			'events.admin.posterHint' => 'Hochformat 4:5 empfohlen (1080 × 1350), JPEG oder PNG.',
			'events.admin.uploading' => 'Bild wird hochgeladen …',
			'events.admin.general' => 'Die Veranstaltung',
			'events.admin.titleField' => 'Titel',
			'events.admin.titleHint' => 'z. B. Jahreskonferenz 2026',
			'events.admin.titleRequired' => 'Gib der Veranstaltung einen Titel.',
			'events.admin.theme' => 'Thema',
			'events.admin.themeHint' => 'z. B. Im Geist wandeln',
			'events.admin.verse' => 'Themenvers',
			'events.admin.description' => 'Beschreibung',
			'events.admin.when' => 'Termin',
			'events.admin.starts' => 'Beginn',
			'events.admin.ends' => 'Ende',
			'events.admin.endsBeforeStart' => 'Das Ende muss nach dem Beginn liegen.',
			'events.admin.timeZone' => ({required Object zone}) => 'Uhrzeiten vor Ort (${zone}).',
			'events.admin.where' => 'Ort',
			'events.admin.venue' => 'Veranstaltungsort',
			'events.admin.venueHint' => 'z. B. Konferenzzentrum Mvolyé',
			'events.admin.address' => 'Adresse',
			'events.admin.city' => 'Stadt',
			'events.admin.country' => 'Land',
			'events.admin.mapsUrl' => 'Google-Maps-Link',
			'events.admin.registration' => 'Anmeldung',
			'events.admin.registrationOpen' => 'Anmeldung offen',
			'events.admin.deadline' => 'Anmeldeschluss',
			'events.admin.noDeadline' => 'Kein Anmeldeschluss',
			'events.admin.capacity' => 'Anzahl der Plätze',
			'events.admin.capacityHint' => 'Leer: unbegrenzt',
			'events.admin.asksLodging' => 'Fragen, wer eine Unterkunft braucht',
			'events.admin.asksDeparture' => 'Nach dem Abfahrtsort fragen',
			'events.admin.fees' => 'Kosten',
			'events.admin.feesHint' => 'z. B. Eintritt frei. Mahlzeiten: 2.000 FCFA pro Tag.',
			'events.admin.contact' => 'Kontakt',
			'events.admin.contactName' => 'Name der Kontaktperson',
			'events.admin.contactPhone' => 'Telefon der Kontaktperson',
			'events.admin.visibility' => 'Sichtbarkeit',
			'events.admin.statusDraft' => 'Entwurf',
			'events.admin.statusDraftHint' => 'Nur für Admins sichtbar',
			'events.admin.statusPublished' => 'Veröffentlicht',
			'events.admin.statusPublishedHint' => 'Für die ganze Gemeinschaft sichtbar',
			'events.admin.statusCancelled' => 'Abgesagt',
			'events.admin.statusCancelledHint' => 'Als abgesagt angezeigt, ohne Anmeldung',
			'events.admin.saved' => 'Veranstaltung gespeichert.',
			'events.admin.menu' => 'Verwalten',
			'events.admin.program' => 'Programm',
			'events.admin.registrants' => 'Angemeldete',
			'events.admin.post' => 'Neuigkeit veröffentlichen',
			'events.admin.photos' => 'Fotos hinzufügen',
			'events.admin.nextEdition' => 'Nächste Ausgabe vorbereiten',
			'events.admin.delete' => 'Veranstaltung löschen',
			'events.admin.deleteTitle' => 'Diese Veranstaltung löschen?',
			'events.admin.deleteText' => 'Die Anmeldungen, Neuigkeiten und Fotos werden ebenfalls gelöscht.',
			'events.admin.deleteConfirm' => 'Löschen',
			'events.admin.deleted' => 'Veranstaltung gelöscht.',
			'events.admin.nextEditionTitle' => 'Nächste Ausgabe vorbereiten?',
			'events.admin.nextEditionText' => 'Ein Jahr später wird ein Entwurf angelegt, mit demselben Ort und demselben Programm. Du kannst alles anpassen, bevor du ihn veröffentlichst.',
			'events.admin.nextEditionConfirm' => 'Vorbereiten',
			'events.admin.nextEditionDone' => 'Die nächste Ausgabe liegt als Entwurf bereit.',
			'events.admin.programEmpty' => 'Füge die Programmpunkte der Veranstaltung hinzu: Empfang, Gottesdienste, Lehre, Gebetsnacht …',
			'events.admin.addSession' => 'Programmpunkt hinzufügen',
			'events.admin.editSession' => 'Programmpunkt bearbeiten',
			'events.admin.sessionTitle' => 'Titel',
			'events.admin.sessionTitleHint' => 'z. B. Eröffnungsgottesdienst',
			'events.admin.speaker' => 'Sprecher',
			'events.admin.place' => 'Raum',
			'events.admin.day' => 'Tag',
			'events.admin.from' => 'Von',
			'events.admin.to' => 'Bis',
			'events.admin.hymns' => 'Lieder',
			'events.admin.hymnsHint' => 'Nummern, z. B. 12, 45',
			'events.admin.removeSession' => 'Entfernen',
			'events.admin.saveProgram' => 'Programm speichern',
			'events.admin.programSaved' => 'Programm gespeichert.',
			'events.admin.registrantsEmpty' => 'Noch hat sich niemand angemeldet.',
			'events.admin.totalRegistrations' => 'Anmeldungen',
			'events.admin.totalPeople' => 'Personen',
			'events.admin.totalLodging' => 'Mit Unterkunft',
			'events.admin.byCity' => 'Nach Abfahrtsort',
			'events.admin.list' => 'Liste',
			'events.admin.exportCsv' => 'Liste exportieren (CSV)',
			'events.admin.csvHeader' => 'Name;Benutzername;Telefon;Kirche;Gemeinde;Personen;Unterkunft;Abfahrtsort;Angemeldet am',
			'events.admin.yes' => 'ja',
			'events.admin.no' => 'nein',
			'events.admin.postBody' => 'Nachricht',
			'events.admin.postBodyHint' => 'z. B. Die Anmeldung ist geöffnet!',
			'events.admin.postImage' => 'Bild hinzufügen',
			'events.admin.postPinned' => 'Oben anheften',
			'events.admin.postSend' => 'Veröffentlichen',
			'events.admin.postDone' => 'Neuigkeit veröffentlicht.',
			'events.admin.postDelete' => 'Diese Neuigkeit löschen',
			'events.admin.postDeleted' => 'Neuigkeit gelöscht.',
			'events.admin.photosAdded' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n, one: '${n} Foto hinzugefügt.', other: '${n} Fotos hinzugefügt.', ), 
			'events.admin.photosSending' => ({required Object done, required Object total}) => 'Fotos werden gesendet (${done}/${total}) …',
			'events.admin.photoDelete' => 'Dieses Foto löschen',
			'events.admin.photoDeleted' => 'Foto gelöscht.',
			'events.admin.confirmDelete' => 'Löschen',
			'events.upcomingCount' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n, one: '${n} bevorstehende Veranstaltung', other: '${n} bevorstehende Veranstaltungen', ), 
			'events.slide' => ({required Object current, required Object total}) => 'Veranstaltung ${current} von ${total}',
			'notifications.title' => 'Mitteilungen',
			'notifications.channel' => 'Ankündigungen der Gemeinschaft',
			'notifications.empty' => 'Noch keine Mitteilungen',
			'notifications.emptyHint' => 'Die Ankündigungen der Gemeinschaft erscheinen hier.',
			'notifications.unreadLabel' => ({required Object title}) => 'Ungelesen: ${title}',
			'notifications.documents' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n, one: '${n} PDF-Dokument', other: '${n} PDF-Dokumente', ), 
			'notifications.unread' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n, one: '${n} ungelesen', other: '${n} ungelesen', ), 
			'notifications.image' => ({required Object n}) => 'Bild ${n}',
			'notifications.document' => 'PDF-Dokument',
			'notifications.documentSize' => ({required Object kb}) => '${kb} KB',
			'notifications.received' => ({required Object title}) => 'Neue Mitteilung: ${title}',
			'premium.name' => 'CMFI Connect Premium',
			'premium.pill' => 'Premium',
			'premium.subtitle' => 'Geh weiter auf deinem Weg mit Gott und unterstütze das Werk.',
			'premium.widgetTitle' => 'Das Widget für den Startbildschirm',
			'premium.widgetText' => 'Dein Tagesbericht und deine Ziele, ohne die App zu öffnen.',
			'premium.statsTitle' => 'Deine Ziele über das Jahr',
			'premium.statsText' => 'Die Jahresbilanz und die Entwicklung deiner Ziele, Woche für Woche.',
			'premium.supportTitle' => 'Du unterstützt das Werk',
			'premium.supportText' => 'Dein Abo hält die App für die ganze Gemeinschaft am Leben.',
			'premium.annual' => 'Jährlich',
			'premium.lifetime' => 'Lebenslang',
			'premium.monthly' => 'Monatlich',
			'premium.perYear' => ({required Object price}) => '${price} / Jahr',
			'premium.once' => ({required Object price}) => '${price} einmalig',
			'premium.perMonth' => ({required Object price}) => '${price} / Monat',
			'premium.annualPerMonth' => ({required Object price}) => 'also ${price} pro Monat',
			'premium.best' => 'Am günstigsten',
			'premium.trialDays' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n, one: '${n} Tag gratis testen', other: '${n} Tage gratis testen', ), 
			'premium.trialMonths' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n, one: '${n} Monat gratis testen', other: '${n} Monate gratis testen', ), 
			'premium.subscribe' => 'Abonnieren',
			'premium.startTrial' => 'Gratis testen',
			'premium.restore' => 'Käufe wiederherstellen',
			'premium.restored' => 'Premium ist wieder auf diesem Telefon',
			'premium.nothingToRestore' => 'Kein Premium-Kauf für dieses Konto',
			'premium.thanks' => 'Danke! Premium ist aktiv.',
			'premium.failed' => 'Der Kauf hat nicht geklappt. Versuch es gleich noch einmal.',
			'premium.unavailable' => 'Die Angebote sind gerade nicht verfügbar.',
			'premium.renews' => ({required Object store}) => 'Das Abo verlängert sich automatisch. Du kannst es jederzeit in den Einstellungen deines ${store}-Kontos kündigen.',
			'premium.terms' => 'Nutzungsbedingungen',
			'premium.privacy' => 'Datenschutz',
			'premium.activeTitle' => 'Du hast Premium',
			'premium.activeText' => 'Danke, dass du CMFI Connect unterstützt! Das Widget und das Jahr deiner Bilanz sind offen.',
			'premium.staffText' => 'Premium ist für dich kostenlos, weil du zum Team von CMFI Connect gehörst.',
			'premium.moreSubtitle' => 'Widget, Ziele über das Jahr',
			'premium.moreActive' => 'Aktiv',
			'premium.unlock' => 'Mit Premium freischalten',
			'premium.trialThen' => ({required Object trial, required Object price}) => '${trial}, danach ${price}',
			'premium.savePercent' => ({required Object percent}) => '−${percent}',
			'premium.choose' => 'Wähle dein Angebot',
			'premium.cancelAnytime' => 'Ohne Bindung, jederzeit kündbar',
			'premium.restoreShort' => 'Wiederherstellen',
			'premium.termsShort' => 'Bedingungen',
			'premium.semiannual' => 'Halbjährlich',
			'premium.perSemester' => ({required Object price}) => '${price} / 6 Monate',
			'premium.buyLifetime' => 'Lebenslang kaufen',
			'premium.lifetimeNote' => 'Lebenslang: eine einzige Zahlung, kein Abo, keine Verlängerung.',
			'premium.manage' => 'Mein Abo verwalten',
			'premium.manageFailed' => 'Die Abo-Verwaltung öffnet sich nicht. Versuche es später noch einmal.',
			'homeWidget.title' => 'Heute',
			'homeWidget.done' => 'Erledigt',
			'homeWidget.todo' => 'Auszufüllen',
			'homeWidget.open' => 'Ausfüllen',
			'homeWidget.locked' => 'Aktiviere das Widget mit Premium',
			'homeWidget.signedOut' => 'Melde dich in der App an',
			'ministry.title' => 'Unser Dienst',
			'ministry.tagline' => 'Bis an die Enden der Erde',
			'ministry.count' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n, one: '${n} Nation', other: '${n} Nationen', ), 
			'ministry.fromYaounde' => 'Von Yaoundé aus geht das Evangelium von Nation zu Nation.',
			'ministry.dragHint' => 'Dreh den Globus mit dem Finger, tippe auf eine Nation.',
			'ministry.globeLabel' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n, one: 'Globus: ${n} Nation, in der das Werk vertreten ist. Die Liste unten nennt sie.', other: 'Globus: ${n} Nationen, in denen das Werk vertreten ist. Die Liste unten nennt sie alle.', ), 
			'ministry.voyage' => 'Reise',
			'ministry.pause' => 'Pause',
			'ministry.previous' => 'Vorherige Nation',
			'ministry.next' => 'Nächste Nation',
			'ministry.number' => ({required Object n}) => 'Nation Nr. ${n}',
			'ministry.since' => ({required Object year}) => 'Seit ${year}',
			'ministry.pray' => 'Beten',
			'ministry.prayTitle' => ({required Object country}) => 'Beten für ${country}',
			'ministry.prayThanks' => ({required Object country}) => 'Danke für Gottes Werk in ${country}.',
			'ministry.prayAssemblies' => ({required Object country}) => 'Bete für die Gemeinden in ${country} und ihre Leiter.',
			'ministry.prayUnreached' => ({required Object country}) => 'Bete, dass die, die in ${country} noch nicht glauben, Jesus begegnen.',
			'ministry.purpose' => 'Unser Ziel',
			'ministry.nations' => 'Die Nationen',
			'ministry.search' => 'Nation suchen',
			'ministry.none' => 'Keine Nation gefunden',
			'ministry.homeText' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n, one: 'In ${n} Nation vertreten', other: 'In ${n} Nationen vertreten', ), 
			'ministry.nationsSubtitle' => 'Der Globus und die Reise von Nation zu Nation',
			'ministry.purposeSubtitle' => 'Unsere drei Ziele',
			'ministry.missionaries' => 'Unsere Missionare',
			'ministry.missionariesSubtitle' => 'Die, die der Herr zu den Nationen sendet',
			'ministry.heroes' => 'Unsere Helden',
			'ministry.heroesSubtitle' => 'Die, deren Glaube uns inspiriert',
			'ministry.founder' => 'Unser Gründer',
			'ministry.founderSubtitle' => 'Prof. Zacharias Tanee Fomum',
			'ministry.leader' => 'Unser Leiter',
			'ministry.leaderSubtitle' => 'Theodore Andoseh',
			'ministry.missionariesEmpty' => 'Die Porträts unserer Missionare kommen bald.',
			'ministry.heroesEmpty' => 'Die Porträts unserer Helden kommen bald.',
			'ministry.personGone' => 'Dieses Porträt ist nicht mehr verfügbar.',
			'ministry.photoOf' => ({required Object name}) => 'Foto von ${name}',
			'ministry.keyDates' => 'Wichtige Daten',
			'ministry.life' => 'Sein Leben',
			'ministry.story' => 'Lebensgeschichte',
			'ministry.goalOf' => ({required Object n, required Object total}) => 'UNSER ZIEL · ${n}/${total}',
			'ministry.previousGoal' => 'Vorheriges Ziel',
			'ministry.nextGoal' => 'Nächstes Ziel',
			'ministry.media.books' => 'Bücher',
			'ministry.media.tracts' => 'Traktate',
			'ministry.media.magazines' => 'Zeitschriften',
			'ministry.media.cds' => 'CDs',
			'ministry.media.dvds' => 'DVDs',
			'ministry.media.radio' => 'Radio',
			'ministry.media.tv' => 'Fernsehen',
			'ministry.media.internet' => 'Internet',
			'ministry.goals.crusade.title' => 'Der Evangeliumsfeldzug zu jeder Kreatur',
			'ministry.goals.crusade.text' => 'Das Evangelium jedem Menschen zu predigen, der in unserer Generation leben wird, sodass 10 Milliarden Menschen mit dem in der Kraft des Heiligen Geistes gepredigten Evangelium erreicht werden – mit allen Kommunikationsmitteln (unseren Büchern, Traktaten, Zeitschriften, CDs, DVDs, unserem Radio, unserem Fernsehen und dem Internet) und so dringend wie möglich.',
			'ministry.goals.crusade.reached' => 'Menschen, die das Evangelium hören',
			'ministry.goals.disciples.title' => 'Die Ausbildung von Jüngern',
			'ministry.goals.disciples.text' => '1 Milliarde Menschen in 250 Nationen dahin zu führen, Jesus Christus als Herrn und Retter zu kennen, sie zu Jüngern zu machen, die ihm in allem gehorchen, und sie bis zum Jahr 2065 in 25 Millionen Hauskirchen zu sammeln.',
			'ministry.goals.disciples.people' => 'Jünger',
			'ministry.goals.disciples.nations' => 'Nationen',
			'ministry.goals.disciples.churches' => 'Hauskirchen',
			'ministry.goals.disciples.by' => ({required Object year}) => 'bis ${year}',
			'ministry.goals.revival.title' => 'Die weltweite Erweckung beschleunigen',
			'ministry.goals.revival.text' => 'Durch Fasten und Fürbitte mit Gott zusammenzuwirken für die weltweite Erweckung, die die Himmel zerreißen, die Erde erschüttern und Christus in unserer Generation verherrlichen wird, um die nahe Wiederkunft unseres Herrn Jesus Christus vom Himmel zu beschleunigen, zur Begegnung mit seiner bereiteten Braut.',
			'ministry.goals.revival.fasting' => 'Fasten',
			'ministry.goals.revival.intercession' => 'Fürbitte',
			'ministry.goals.revival.pray' => 'Jetzt beten',
			'ministry.lives.founder.name' => 'Prof. Zacharias Tanee Fomum',
			'ministry.lives.founder.line' => '1945 – 2009 · Gründer der CMFI',
			'ministry.lives.founder.facts.0' => 'Gründung der CMFI',
			'ministry.lives.founder.facts.1' => 'geschriebene Bücher',
			'ministry.lives.founder.facts.2' => 'besuchte Nationen',
			'ministry.lives.founder.dates.0' => 'Geboren am 20. Juni in Kamerun, in einer presbyterianischen Familie.',
			'ministry.lives.founder.dates.1' => 'Übergibt am 13. Juni durch ein Traktat sein Leben Jesus Christus.',
			'ministry.lives.founder.dates.2' => 'Weiht sich am 1. Oktober in Sierra Leone ganz dem Herrn.',
			'ministry.lives.founder.dates.3' => 'Wird am 24. Oktober nach sieben Tagen Gebet mit dem Heiligen Geist erfüllt.',
			'ministry.lives.founder.dates.4' => 'Gründet am 12. Mai in Yaoundé die CMFI.',
			'ministry.lives.founder.dates.5' => 'Erhält von der Universität Durham den Doctor of Science.',
			'ministry.lives.founder.dates.6' => 'Geht am 14. März heim zum Herrn.',
			'ministry.lives.founder.story.0' => 'Zacharias Tanee Fomum wurde am 20. Juni 1945 in Kamerun geboren, in einer presbyterianischen Familie aus Batibo im Nordwesten des Landes. Noch als Schüler übergab er am 13. Juni 1956 sein Leben Jesus Christus, durch ein Traktat mit dem Titel „Jemand ist für dich gestorben“.',
			'ministry.lives.founder.story.1' => 'Als Student am Fourah Bay College in Sierra Leone weihte er sich am 1. Oktober 1966 rückhaltlos dem Herrn und seinem Dienst. Am 24. Oktober 1970, nach sieben Tagen Gebet und Fasten, wurde er mit dem Heiligen Geist erfüllt. Von da an stand das Gebet im Mittelpunkt seines Lebens.',
			'ministry.lives.founder.story.2' => 'Nach seiner Promotion in organischer Chemie an der Makerere-Universität in Uganda lehrte er an der Universität Yaoundé, wo er Professor wurde. Er betreute rund hundert Doktor- und Abschlussarbeiten, und 2005 verlieh ihm die Universität Durham in Großbritannien für sein gesamtes Werk den Doctor of Science.',
			'ministry.lives.founder.story.3' => 'Am 12. Mai 1975 gründete er in Yaoundé die Christian Missionary Fellowship International: eine Bewegung, um Seelen zu gewinnen, Jünger zu machen, Gemeinden zu gründen und Missionare auszusenden. Er unternahm über 700 Missionsreisen in Kamerun und über 500 in mehr als 70 Nationen auf sechs Kontinenten.',
			'ministry.lives.founder.story.4' => 'Er verbrachte täglich lange Stunden allein mit Gott, leitete viele Gebetskreuzzüge, Gebetsbelagerungen und Gebetsmärsche und fastete oft. Er schrieb über 150 Bücher über Gebet, Fasten, Heiligkeit, Jüngerschaft und Mission, die in vielen Sprachen gelesen werden.',
			'ministry.lives.founder.story.5' => 'Mit seiner Frau Prisca Zei Fomum, die unter Kindern diente, hatte er sieben Kinder, die alle im Werk des Evangeliums stehen. Gemeinsam lebten sie einfach, um den größten Teil ihres Einkommens für das Evangelium zu geben.',
			'ministry.lives.founder.story.6' => 'Am 14. März 2009 ging er heim zum Herrn und wurde am 21. März in Yaoundé beigesetzt. Das Werk, das er gegründet hat, geht unter den Nationen weiter.',
			'ministry.lives.leader.name' => 'Theodore Andoseh',
			'ministry.lives.leader.line' => 'Leiter der CMFI seit 2009',
			'ministry.lives.leader.facts.0' => 'gegründete Gemeinden',
			'ministry.lives.leader.facts.1' => 'Jahre in Nigeria',
			'ministry.lives.leader.facts.2' => 'an der Spitze der CMFI',
			'ministry.lives.leader.dates.0' => 'Übergibt sein Leben Jesus Christus unter der Predigt von Prof. Fomum.',
			'ministry.lives.leader.dates.1' => 'Wird in Yaoundé zum Bischof geweiht.',
			'ministry.lives.leader.dates.2' => 'Geht mit seiner Frau Adela als Missionar nach Nigeria.',
			'ministry.lives.leader.dates.3' => 'Übernimmt die Leitung der CMFI.',
			'ministry.lives.leader.dates.4' => 'Bringt die Botschaften der 3. Weltkonvention vor Mitgliedern aus 93 Nationen.',
			'ministry.lives.leader.story.0' => 'Theodore Andoseh übergab 1978 sein Leben Jesus Christus, als er Prof. Zacharias Tanee Fomum predigen hörte. Dieser wurde sein geistlicher Vater und bildete ihn als Jünger aus.',
			'ministry.lives.leader.story.1' => 'Zuerst diente er an seiner Seite: als Laborassistent an der Universität Yaoundé, dann als sein persönlicher Assistent und Privatsekretär. In diesen Jahren veröffentlichte er das erste Erweckungstraktat, „Gott spricht zu dem Menschen, der hören will“, und rief die erste Gebetskette in Yaoundé ins Leben.',
			'ministry.lives.leader.story.2' => 'Als nationaler Missionar gründete er über fünfzig Gemeinden in Kamerun. 1989 wurde er in Yaoundé zum Bischof geweiht.',
			'ministry.lives.leader.story.3' => '1994 ging er mit seiner Frau Adela als Missionar nach Nigeria. Dort dienten sie vierzehn Jahre lang.',
			'ministry.lives.leader.story.4' => 'Seit 2009, als Prof. Fomum heim zum Herrn ging, leitet er die CMFI unter den Nationen. Im Dezember 2019 brachte er in Koume bei Bertoua die Botschaften der dritten Weltkonvention vor Mitgliedern aus 93 Nationen. Er ist außerdem Autor mehrerer Bücher über den Dienst für Gott und den Aufbau der Gemeinde.',
			'prayer.moments.morning' => 'Morgen',
			'prayer.moments.noon' => 'Mittag',
			'prayer.moments.evening' => 'Abend',
			'prayer.moments.night' => 'Nacht',
			'prayer.retreatOf.morning' => 'Gebetszeit am Morgen',
			'prayer.retreatOf.noon' => 'Gebetszeit am Mittag',
			'prayer.retreatOf.evening' => 'Gebetszeit am Abend',
			'prayer.retreatOf.night' => 'Gebetszeit zur Nacht',
			'prayer.hero.now' => ({required Object retreat}) => '${retreat} · jetzt',
			'prayer.hero.title' => '15 Minuten\nmit dem Herrn',
			'prayer.hero.preview.morning' => 'Sage Dank, weihe deinen Tag, deine Arbeit, deine Familie …',
			'prayer.hero.preview.noon' => 'Deine Gemeinde, deine Leiter, 5 Menschen von deiner Liste, die Nationen …',
			'prayer.hero.preview.evening' => 'Dein Gebetsleben, dein Dienst, deine Mitarbeiter …',
			'prayer.hero.preview.night' => 'Die Kranken, das Evangelium unter den Nationen, Schutz für die Nacht …',
			'prayer.hero.meta' => '15 Punkte · je 1 Min.',
			'prayer.hero.start' => 'Beginnen',
			'prayer.hero.allDone' => 'Alle 4 Gebetszeiten des Tages sind erledigt. Möge Gott deine Gebete erhören!',
			'prayer.hero.doneNow' => ({required Object retreat, required Object next}) => '${retreat} erledigt. Nächste: ${next}',
			'prayer.today.toPray' => 'Noch zu beten',
			'prayer.today.week' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n, zero: 'Diese Woche noch keine Gebetszeit', one: '${n} Gebetszeit diese Woche', other: '${n} Gebetszeiten diese Woche', ), 
			'prayer.routine.title' => 'Deine tägliche Routine',
			'prayer.routine.count' => ({required Object done}) => '${done} von 4',
			'prayer.routine.days' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n, one: '${n} Tag von 7', other: '${n} Tage von 7', ), 
			'prayer.routine.week' => ({required Object time}) => '${time} diese Woche',
			'prayer.routine.done' => 'Erledigt · 15 Min.',
			'prayer.routine.now' => 'Jetzt · 15 Min.',
			'prayer.routine.next' => 'Als Nächstes · 15 Min.',
			'prayer.routine.reminder' => ({required Object time}) => 'Erinnerung um ${time}',
			'prayer.routine.later.morning' => 'Am Morgen · 15 Min.',
			'prayer.routine.later.noon' => 'Am Mittag · 15 Min.',
			'prayer.routine.later.evening' => 'Am Abend · 15 Min.',
			'prayer.routine.later.night' => 'In der Nacht · 15 Min.',
			'prayer.together' => 'Gemeinsam beten',
			'prayer.reminders.title' => 'Erinnerungen an die Gebetszeiten',
			'prayer.reminders.intro' => 'Eine Erinnerung zu jeder Gebetszeit – nur wenn sie noch nicht erledigt ist.',
			'prayer.reminders.off' => 'Aus',
			'prayer.reminders.channel' => 'Gebetszeiten',
			'prayer.reminders.body' => '15 Minuten mit dem Herrn.',
			'prayer.retreat.title' => 'Gebetszeiten von 15 Minuten',
			'prayer.retreat.hours.morning' => 'Beim Aufwachen',
			'prayer.retreat.hours.noon' => 'Zwischen 12 und 14 Uhr',
			'prayer.retreat.hours.evening' => 'Am späten Nachmittag',
			'prayer.retreat.hours.night' => 'Vor dem Schlafengehen',
			'prayer.retreat.reminderAt' => ({required Object time}) => 'Erinnerung um ${time}',
			'prayer.retreat.intro' => '15 Punkte, je eine Minute. Ein sanfter Ton führt dich zum nächsten.',
			'prayer.retreat.done' => 'Heute erledigt',
			'prayer.retreat.start' => 'Beginnen · 15 Min.',
			'prayer.retreat.selfPaced' => 'In meinem Tempo lesen, ohne Timer',
			'prayer.retreat.hints.assembly' => ({required Object name}) => 'Deine Gemeinde: ${name}',
			'prayer.retreat.hints.assemblyMissing' => 'Füge deine Gemeinde in deinem Profil hinzu',
			'prayer.retreat.hints.authorities' => ({required Object names}) => 'Deine Autoritäten: ${names}',
			'prayer.retreat.hints.authoritiesMissing' => 'Füge deine geistlichen Autoritäten unter „Mehr“ hinzu',
			'prayer.retreat.hints.list' => ({required Object list}) => 'Meine Listen · ${list}',
			'prayer.retreat.hints.listEmpty' => ({required Object list}) => 'Deine Liste „${list}“ ist leer: Füge Namen hinzu',
			'prayer.retreat.hints.nation' => ({required Object name}) => 'Heute: ${name}',
			'prayer.retreat.hints.myCountry' => ({required Object name}) => 'Dein Land: ${name}',
			'prayer.retreat.hints.hymn' => 'Lieder öffnen',
			'prayer.session.point' => ({required Object n}) => 'Punkt ${n} von 15',
			'prayer.session.remaining' => 'verbleibend',
			'prayer.session.paused' => 'pausiert',
			'prayer.session.inYourList' => ({required Object list}) => 'Auf deiner Liste · ${list}',
			'prayer.session.tomorrow' => 'Morgen die nächsten.',
			'prayer.session.footer' => 'Bildschirm bleibt an · ein sanfter Ton jede Minute',
			'prayer.session.previous' => 'Vorheriger Punkt',
			'prayer.session.next' => 'Nächster Punkt',
			'prayer.session.pause' => 'Pause',
			'prayer.session.resume' => 'Fortsetzen',
			'prayer.session.soundOn' => 'Ton an',
			'prayer.session.soundOff' => 'Ton aus',
			'prayer.session.finish' => 'Gebetszeit beenden',
			'prayer.session.quitTitle' => 'Gebetszeit abbrechen?',
			'prayer.session.quitText' => 'Sie wird für deinen Tag nicht gezählt.',
			'prayer.session.quit' => 'Abbrechen',
			'prayer.session.keepPraying' => 'Weiterbeten',
			'prayer.done.title' => ({required Object retreat}) => '${retreat} beendet',
			'prayer.done.text' => '15 Minuten mit dem Herrn.\nEr hat jedes deiner Gebete gehört.',
			'prayer.done.report' => 'Zu deinem Bericht hinzugefügt',
			'prayer.done.reportDetail' => ({required Object added, required Object total}) => 'Persönliches Gebet: +${added} Min. · heute ${total} Min.',
			'prayer.done.undo' => 'Rückgängig',
			'prayer.done.undone' => 'Gebetszeit aus deinem Tag entfernt.',
			'prayer.done.today' => 'Heute',
			'prayer.done.count' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n, one: '${n} von 4 Gebetszeiten', other: '${n} von 4 Gebetszeiten', ), 
			'prayer.done.verse' => '„Betet ohne Unterlass!“',
			'prayer.done.reference' => '1. Thessalonicher 5,17',
			'prayer.done.finish' => 'Fertig',
			'prayer.done.hymn' => 'Ein Lied singen',
			'prayer.topics.title' => 'Anliegen der Gemeinschaft',
			'prayer.topics.all' => 'Alle ansehen',
			'prayer.topics.empty' => 'Im Moment gibt es keine Anliegen. Die Verantwortlichen veröffentlichen die nächsten hier.',
			'prayer.topics.categories.church' => 'Kirche',
			'prayer.topics.categories.nations' => 'Nationen',
			'prayer.topics.categories.sick' => 'Kranke',
			'prayer.topics.categories.event' => 'Veranstaltung',
			'prayer.topics.categories.fasting' => 'Fasten',
			'prayer.topics.categories.other' => 'Anliegen',
			'prayer.topics.until' => ({required Object date}) => 'bis ${date}',
			'prayer.topics.archive' => 'Frühere Anliegen',
			'prayer.topics.archiveEmpty' => 'Keine früheren Anliegen.',
			'prayer.topics.current' => 'Aktuell',
			'prayer.topics.documentSize' => ({required Object kb}) => '${kb} KB',
			'prayer.topics.download' => 'PDF herunterladen',
			'prayer.topics.noDocument' => 'Kein PDF',
			'prayer.topics.openDocument' => 'PDF öffnen',
			'prayer.lists.title' => 'Meine Gebetslisten',
			'prayer.lists.private' => 'Nur für dich',
			'prayer.lists.names.unbelievers' => 'Noch nicht gläubig',
			'prayer.lists.names.believers' => 'Gläubige',
			'prayer.lists.names.backsliders' => 'Abgefallene',
			'prayer.lists.names.coworkers' => 'Mitarbeiter',
			'prayer.lists.uses.unbelievers' => 'In der Gebetszeit am Mittag betest du jeden Tag der Reihe nach für 10 Menschen aus dieser Liste (5 + 5).',
			'prayer.lists.uses.believers' => 'In der Gebetszeit am Mittag betest du jeden Tag der Reihe nach für 5 Menschen aus dieser Liste.',
			'prayer.lists.uses.backsliders' => 'In der Gebetszeit am Mittag betest du jeden Tag der Reihe nach für 5 Menschen aus dieser Liste.',
			'prayer.lists.uses.coworkers' => 'In der Gebetszeit am Abend betest du jeden Tag der Reihe nach für 10 deiner Mitarbeiter (5 + 5).',
			'prayer.lists.privateNote' => 'Nur du kannst sie sehen.',
			'prayer.lists.count' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n, zero: 'Niemand', one: '${n} Person', other: '${n} Personen', ), 
			_ => null,
		} ?? switch (path) {
			'prayer.lists.empty' => 'Noch niemand. Füge die Menschen hinzu, für die du betest.',
			'prayer.lists.add' => 'Person hinzufügen',
			'prayer.lists.prayedToday' => 'Heute',
			'prayer.lists.next' => 'Demnächst',
			'prayer.lists.answeredTitle.unbelievers' => 'Zum Glauben an den Herrn gekommen',
			'prayer.lists.answeredTitle.believers' => 'Erhörte Gebete',
			'prayer.lists.answeredTitle.backsliders' => 'Zum Herrn zurückgekehrt',
			'prayer.lists.answeredTitle.coworkers' => 'Erhörte Gebete',
			'prayer.lists.answeredOn.unbelievers' => ({required Object date}) => 'Am ${date} zum Glauben an den Herrn gekommen',
			'prayer.lists.answeredOn.believers' => ({required Object date}) => 'Erhört am ${date}',
			'prayer.lists.answeredOn.backsliders' => ({required Object date}) => 'Am ${date} zurückgekehrt',
			'prayer.lists.answeredOn.coworkers' => ({required Object date}) => 'Erhört am ${date}',
			'prayer.lists.markAnswered.unbelievers' => 'Ist zum Glauben an den Herrn gekommen!',
			'prayer.lists.markAnswered.believers' => 'Gebet erhört',
			'prayer.lists.markAnswered.backsliders' => 'Ist zum Herrn zurückgekehrt!',
			'prayer.lists.markAnswered.coworkers' => 'Gebet erhört',
			'prayer.lists.answeredToast' => 'Ehre sei Gott!',
			'prayer.lists.putBack' => 'Zurück auf die Liste',
			'prayer.lists.answeredBanner' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n, one: '${n} erhörtes Gebet diesen Monat', other: '${n} erhörte Gebete diesen Monat', ), 
			'prayer.lists.lastAnswered' => ({required Object name, required Object what}) => '${name}: ${what}',
			'prayer.lists.sheet.addTitle' => 'Person hinzufügen',
			'prayer.lists.sheet.editTitle' => 'Bearbeiten',
			'prayer.lists.sheet.name' => 'Name',
			'prayer.lists.sheet.namePlaceholder' => 'Paul M.',
			'prayer.lists.sheet.note' => 'Notiz',
			'prayer.lists.sheet.notePlaceholder' => 'Kollege, Nachbar, Cousine …',
			'prayer.lists.sheet.list' => 'Liste',
			'prayer.lists.sheet.save' => 'Speichern',
			'prayer.lists.sheet.remove' => 'Von der Liste entfernen',
			'prayer.lists.sheet.removeTitle' => ({required Object name}) => '${name} entfernen?',
			'prayer.lists.sheet.removeText' => 'Du betest in deinen Gebetszeiten nicht mehr für diese Person.',
			'prayer.lists.addShort' => 'Hinzufügen',
			'prayer.importunity.title' => 'Beharrliche Anliegen',
			'prayer.importunity.newTopic' => 'Neues Anliegen',
			'prayer.importunity.intro' => 'Ein Anliegen, das man dem Herrn unermüdlich vorbringt, bis die Antwort kommt. Lege eine Anzahl an Proklamationen fest und lade deine Brüder und Schwestern ein, mit dir zu beten.',
			'prayer.importunity.invitedBy' => ({required Object name}) => '${name} lädt dich zum Beten ein',
			'prayer.importunity.join' => 'Ich bete mit',
			'prayer.importunity.decline' => 'Nicht jetzt',
			'prayer.importunity.joined' => 'Du betest jetzt für dieses Anliegen.',
			'prayer.importunity.progress' => ({required Object total, required Object goal}) => '${total} von ${goal}',
			'prayer.importunity.total' => ({required num n, required Object count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n, one: '${count} Proklamation', other: '${count} Proklamationen', ), 
			'prayer.importunity.reached' => 'Ziel erreicht!',
			'prayer.importunity.closed' => 'Abgeschlossen',
			'prayer.importunity.participants' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n, one: '${n} betet', other: '${n} beten', ), 
			'prayer.importunity.mine' => ({required Object n}) => 'Du: ${n}',
			'prayer.importunity.tapHint' => 'Tippe bei jeder Proklamation',
			'prayer.importunity.addMany' => 'Anzahl hinzufügen',
			'prayer.importunity.addManyTitle' => 'Wie viele Proklamationen?',
			'prayer.importunity.addManyLabel' => 'Proklamationen',
			'prayer.importunity.add' => 'Hinzufügen',
			'prayer.importunity.pending' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n, one: '${n} noch nicht gesendet', other: '${n} noch nicht gesendet', ), 
			'prayer.importunity.invite' => 'Einladen',
			'prayer.importunity.members' => 'Mitbetende',
			'prayer.importunity.waiting' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n, one: '${n} offene Einladung', other: '${n} offene Einladungen', ), 
			'prayer.importunity.edit' => 'Bearbeiten',
			'prayer.importunity.close' => 'Anliegen abschließen',
			'prayer.importunity.reopen' => 'Anliegen wieder öffnen',
			'prayer.importunity.delete' => 'Anliegen löschen',
			'prayer.importunity.deleteTitle' => 'Dieses Anliegen löschen?',
			'prayer.importunity.deleteText' => 'Es verschwindet für alle, die mit dir beten.',
			'prayer.importunity.leave' => 'Anliegen verlassen',
			'prayer.importunity.leaveTitle' => 'Dieses Anliegen verlassen?',
			'prayer.importunity.leaveText' => 'Deine Proklamationen bleiben in der Gesamtzahl.',
			'prayer.importunity.form.newTitle' => 'Neues beharrliches Anliegen',
			'prayer.importunity.form.editTitle' => 'Anliegen bearbeiten',
			'prayer.importunity.form.subject' => 'Anliegen',
			'prayer.importunity.form.subjectPlaceholder' => 'Herr, rette Paul',
			'prayer.importunity.form.description' => 'Details',
			'prayer.importunity.form.descriptionPlaceholder' => 'Für wen, warum …',
			'prayer.importunity.form.goal' => 'Ziel',
			'prayer.importunity.form.goalHint' => 'Die Anzahl an Proklamationen, die ihr gemeinsam erreichen wollt. Lass das Feld leer, um ohne Ziel zu zählen.',
			'prayer.importunity.form.goalPlaceholder' => '10.000',
			'prayer.importunity.form.create' => 'Erstellen',
			'prayer.importunity.form.save' => 'Speichern',
			'prayer.importunity.inviteSheet.title' => 'Zum Beten einladen',
			'prayer.importunity.inviteSheet.family' => 'Meine geistliche Familie',
			'prayer.importunity.inviteSheet.familyText' => ({required num n, required Object name}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n, one: '${name} und die Jünger: ${n} Person', other: '${name} und die Jünger: ${n} Personen', ), 
			'prayer.importunity.inviteSheet.familyMissing' => 'Verknüpfe deinen Jüngermacher unter „Meine geistlichen Autoritäten“, um deine geistliche Familie einzuladen.',
			'prayer.importunity.inviteSheet.byUsername' => 'Per Benutzername',
			'prayer.importunity.inviteSheet.usernameLabel' => 'Benutzername',
			'prayer.importunity.inviteSheet.addUsername' => 'Hinzufügen',
			'prayer.importunity.inviteSheet.send' => 'Einladungen senden',
			'prayer.importunity.inviteSheet.sent' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n, zero: 'Sie waren schon eingeladen.', one: '${n} Einladung gesendet', other: '${n} Einladungen gesendet', ), 
			'prayer.importunity.eyebrow' => 'Anliegen der Beharrlichkeit',
			'prayer.importunity.proclaim' => 'Proklamieren',
			'sending.title' => 'An meine Leiter senden',
			'sending.moreOff' => 'Aus',
			'sending.intro' => 'Zur gewählten Zeit bereitet CMFI Connect deinen Bericht für den Zeitraum vor. Du musst ihn nur noch an deine geistlichen Leiter senden.',
			'sending.enabled' => 'Regelmäßig für mich vorbereiten',
			'sending.rhythm' => 'Rhythmus',
			'sending.weekly' => 'Jede Woche',
			'sending.biweekly' => 'Alle 2 Wochen',
			'sending.monthly' => 'Jeden Monat',
			'sending.day' => 'Tag',
			'sending.monthlyDay' => 'Am 1. jedes Monats, für den vergangenen Monat',
			'sending.time' => 'Uhrzeit',
			'sending.recipients' => 'Empfänger',
			'sending.noAuthorities' => 'Füge zuerst deine geistlichen Leiter hinzu.',
			'sending.addAuthorities' => 'Meine Leiter hinzufügen',
			'sending.viaWhatsApp' => 'Per WhatsApp',
			'sending.viaEmail' => 'Per E-Mail',
			'sending.viaBoth' => 'Per WhatsApp oder E-Mail',
			'sending.viaShare' => 'Über Teilen',
			'sending.next' => ({required Object date}) => 'Nächster: ${date}',
			'sending.prepareNow' => 'Jetzt vorbereiten',
			'sending.history' => 'Zuletzt gesendet',
			'sending.notificationTitle' => 'Dein Bericht ist fertig',
			'sending.notificationBody' => 'Sende ihn mit einem Tippen an deine Leiter.',
			'sending.channel' => 'Berichtsversand',
			'sending.readyTitle' => 'Dein Bericht ist fertig',
			'sending.preview' => 'Vorschau der Nachricht',
			'sending.greeting' => ({required Object name}) => 'Hallo ${name},',
			'sending.whatsApp' => 'WhatsApp',
			'sending.email' => 'E-Mail',
			'sending.sharePdf' => 'PDF teilen',
			'sending.shareText' => 'Text teilen',
			'sending.sent' => 'Gesendet',
			'sending.shared' => 'Geteilt',
			'sending.noRecipients' => 'Wähle deine Empfänger in den Einstellungen oder teile das PDF.',
			'sending.settings' => 'Einstellungen',
			'sending.permissionDenied' => 'Erlaube Benachrichtigungen, um rechtzeitig erinnert zu werden.',
			'streak.title' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n, one: '${n} Tag in Folge!', other: '${n} Tage in Folge!', ), 
			'streak.cardDays' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n, one: 'Tag mit Gott', other: 'Tage mit Gott', ), 
			'streak.lines.week' => 'Eine ganze Woche mit dem Herrn, Tag für Tag. Bravo, mach weiter!',
			'streak.lines.month' => 'Ein Monat voller Treue! Was du jeden Tag säst, trägt Frucht.',
			'streak.lines.hundred' => 'Hundert Tage mit Gott! Deine Ausdauer ist ein schönes Zeugnis.',
			'streak.lines.year' => 'Ein ganzes Jahr mit Gott! Ehre sei Ihm für deine Treue.',
			'streak.share' => 'Teilen',
			'streak.close' => 'Weiter',
			'shortcuts.today' => 'Meinen Bericht ausfüllen',
			'shortcuts.hymns' => 'Lieder',
			'shortcuts.retreat' => 'Aktuelle Gebetszeit',
			'blocking.report' => 'Melden',
			'blocking.block' => ({required Object name}) => '${name} blockieren',
			'blocking.blockTitle' => ({required Object name}) => '${name} blockieren?',
			'blocking.blockText' => ({required Object name}) => 'Du erhältst keine Einladungen mehr von ${name}. Diese Einladung wird entfernt.',
			'blocking.blockAction' => 'Blockieren',
			'blocking.blocked' => ({required Object name}) => '${name} kann dich nicht mehr einladen.',
			'blocking.reportTitle' => 'Diese Einladung melden',
			'blocking.reportText' => 'Sag uns, was nicht stimmt: Die Verantwortlichen der Gemeinschaft sehen es sich an.',
			'blocking.reasons.spam' => 'Unerwünscht',
			'blocking.reasons.offensive' => 'Schockierender oder anstößiger Inhalt',
			'blocking.reasons.other' => 'Sonstiges',
			'blocking.comment' => 'Kommentar',
			'blocking.commentHint' => 'Was die Verantwortlichen wissen sollten',
			'blocking.send' => 'Meldung senden',
			'blocking.reported' => 'Danke, die Verantwortlichen sehen es sich an.',
			'blocking.listTitle' => 'Blockierte Mitglieder',
			'blocking.intro' => 'Ihre Gebetseinladungen erreichen dich nicht mehr.',
			'blocking.empty' => 'Du hast niemanden blockiert.',
			'blocking.unblock' => 'Freigeben',
			'blocking.unblocked' => ({required Object name}) => '${name} kann dich wieder einladen.',
			'verses.title' => 'Vers des Tages',
			'verses.share' => 'Vers teilen',
			'verses.shareImage' => 'Bild teilen',
			'verses.shareText' => 'Text teilen',
			'bible.title' => 'Bibel',
			'bible.books' => 'Bücher',
			'bible.oldTestament' => 'Altes Testament',
			'bible.newTestament' => 'Neues Testament',
			'bible.chapters' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n, one: '${n} Kapitel', other: '${n} Kapitel', ), 
			'bible.chapter' => ({required Object n}) => 'Kapitel ${n}',
			'bible.version' => 'Übersetzung',
			'bible.versions' => 'Bibelübersetzung',
			'bible.search' => 'In der Bibel suchen',
			'bible.searchHint' => 'Ein Wort oder „Johannes 3,16“',
			'bible.searchTip' => 'Suche ein Wort („Liebe“) oder springe direkt zu einer Stelle („Psalm 23“, „Johannes 3,16“).',
			'bible.searchNone' => 'Kein Vers enthält diese Wörter.',
			'bible.searchCount' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n, one: '${n} Vers', other: '${n} Verse', ), 
			'bible.searchLimit' => ({required Object n}) => 'Die ersten ${n} Verse',
			'bible.searchNeedsDownload' => 'Um Wörter in der ganzen Bibel zu suchen, lade sie herunter. Eine Stelle kannst du schon eingeben: „Johannes 3,16“.',
			'bible.open' => ({required Object reference}) => '${reference} öffnen',
			'bible.previous' => 'Vorheriges Kapitel',
			'bible.next' => 'Nächstes Kapitel',
			'bible.markRead' => 'Ich habe dieses Kapitel gelesen',
			'bible.markedRead' => 'Heute gelesen',
			'bible.markReadHint' => 'Fügt deinem Bericht 1 Kapitel bei „Bibellesen“ hinzu.',
			'bible.addedToReport' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n, one: 'Bericht: heute ${n} Kapitel gelesen', other: 'Bericht: heute ${n} Kapitel gelesen', ), 
			'bible.removedFromReport' => 'Aus deinem Bericht entfernt',
			'bible.noReadingItem' => 'Dein Bericht hat keinen Punkt „Bibellesen“.',
			'bible.download' => 'Diese Bibel herunterladen',
			'bible.downloadHelp' => ({required Object size}) => 'Etwa ${size} MB, um ohne Netz zu lesen und zu suchen.',
			'bible.downloading' => ({required Object percent}) => 'Wird geladen… ${percent} %',
			'bible.downloaded' => 'Auf deinem Handy',
			'bible.downloadDone' => ({required Object version}) => '${version} ist auf deinem Handy',
			'bible.removeDownload' => 'Vom Handy entfernen',
			'bible.removeDownloadTitle' => ({required Object version}) => '${version} vom Handy entfernen?',
			'bible.removeDownloadText' => 'Die Kapitel, die du schon gelesen hast, bleiben ohne Netz verfügbar.',
			'bible.offline' => 'Dieses Kapitel ist noch nicht auf deinem Handy. Geh wieder online oder lade diese Bibel herunter, um sie ohne Netz zu lesen.',
			'bible.notInVersion' => 'Diese Stelle gibt es in dieser Übersetzung nicht.',
			'bible.marks' => 'Meine Verse',
			'bible.favorites' => 'Gemerkt',
			'bible.highlights' => 'Markiert',
			'bible.noFavorites' => 'Tippe auf einen Vers und dann auf das Lesezeichen, um ihn hier wiederzufinden.',
			'bible.noHighlights' => 'Tippe auf einen Vers und dann auf eine Farbe, um ihn zu markieren.',
			'bible.tapHint' => 'Tippe auf einen Vers, um ihn zu markieren, zu merken, zu kopieren oder zu teilen.',
			'bible.highlight' => ({required Object color}) => '${color} markieren',
			'bible.colors.yellow' => 'Gelb',
			'bible.colors.green' => 'Grün',
			'bible.colors.blue' => 'Blau',
			'bible.colors.pink' => 'Rosa',
			'bible.removeHighlight' => 'Farbe entfernen',
			'bible.addFavorite' => 'Zu Meine Verse hinzufügen',
			'bible.removeFavorite' => 'Aus Meine Verse entfernen',
			'bible.favoriteAdded' => 'Zu Meine Verse hinzugefügt',
			'bible.favoriteRemoved' => 'Aus Meine Verse entfernt',
			'bible.copy' => 'Kopieren',
			'bible.copied' => 'Kopiert',
			'bible.share' => 'Teilen',
			'bible.closeSelection' => 'Auswahl schließen',
			'bible.display' => 'Anzeige',
			'bible.jesusInRed' => 'Worte Jesu in Rot',
			'bible.jesusInRedHelp' => 'In den Übersetzungen, die sie kennzeichnen',
			'bible.remove' => 'Entfernen',
			'bible.readInBible' => 'In der Bibel lesen',
			'bible.concordance' => 'Konkordanz',
			'bible.concordanceOf' => ({required Object word}) => 'Konkordanz zu „${word}“',
			'bible.concordanceHint' => 'Ein Wort der Bibel',
			'bible.concordanceTip' => 'Gib ein Wort ein: Die Konkordanz zeigt jeden Vers, in dem es vorkommt, Buch für Buch.',
			'bible.concordanceNeedsDownload' => 'Die Konkordanz durchsucht die ganze Bibel: Lade sie zuerst herunter.',
			'bible.concordanceNone' => 'Dieses Wort steht nicht in dieser Bibel.',
			'bible.exactWord' => 'Dieses Wort',
			'bible.startsWith' => 'Beginnt mit…',
			'bible.occurrences' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n, one: 'Vorkommen', other: 'Vorkommen', ), 
			'bible.inVerses' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n, one: 'in ${n} Vers', other: 'in ${n} Versen', ), 
			'bible.spread' => 'Wo dieses Wort vorkommt',
			'bible.forms' => 'Gefundene Formen',
			'bible.bookCount' => ({required Object book, required Object n}) => '${book}: ${n}',
			'bible.allBooks' => 'Alle Bücher',
			'bible.pickWord' => 'Wähle ein Wort',
			'bible.pickWordHelp' => 'Die Konkordanz zeigt jeden Vers, in dem es vorkommt.',
			'bible.more' => 'Weitere Optionen',
			'profilePhoto.title' => 'Profilbild',
			'profilePhoto.add' => 'Profilbild hinzufügen',
			'profilePhoto.change' => 'Profilbild ändern',
			'profilePhoto.seenBy' => 'Andere Mitglieder sehen es überall, wo dein Name erscheint.',
			'profilePhoto.camera' => 'Foto aufnehmen',
			'profilePhoto.gallery' => 'Aus der Galerie wählen',
			'profilePhoto.remove' => 'Foto entfernen',
			'profilePhoto.cropTitle' => 'Foto zuschneiden',
			'profilePhoto.cropHint' => 'Verschiebe und vergrößere das Foto mit deinen Fingern.',
			'profilePhoto.use' => 'Dieses Foto verwenden',
			'profilePhoto.unreadable' => 'Dieses Bild lässt sich nicht öffnen. Wähle ein anderes.',
			'profilePhoto.saved' => 'Dein Profilbild ist gespeichert.',
			'profilePhoto.removed' => 'Dein Profilbild ist entfernt.',
			'disciples.title' => 'Meine Jünger',
			'disciples.empty' => 'Noch keine Jünger',
			'disciples.emptyText' => 'Wenn ein Mitglied dich als Jüngermacher oder als Autorität wählt und du die Anfrage annimmst, erscheint es hier.',
			'disciples.count' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n, one: '${n} Jünger', other: '${n} Jünger', ), 
			'disciples.notShared' => 'Teilt seine Berichte nicht',
			'disciples.roleMaker' => 'Du bist sein Jüngermacher',
			'disciples.roleAuthority' => 'Du bist eine seiner Autoritäten',
			'disciples.dayGoals' => ({required Object percent}) => 'Ziele ${percent} %',
			'disciples.dayItems' => ({required Object filled, required Object total, required Object percent}) => '${filled} von ${total} Punkten · ${percent} %',
			'disciples.older' => 'Die 30 Tage davor ansehen',
			'disciples.noReports' => 'Kein Bericht in diesem Zeitraum.',
			'disciples.searchHint' => 'Name oder Benutzername',
			'disciples.noMatch' => ({required Object search}) => 'Kein Jünger passt zu „${search}“.',
			'weekStory.title' => 'Deine Woche mit Gott',
			'weekStory.range' => ({required Object from, required Object to}) => '${from} bis ${to}',
			'weekStory.intro' => 'Schau zurück auf das, was du diese Woche mit dem Herrn erlebt hast.',
			'weekStory.tapHint' => 'Tippe rechts, um weiterzugehen, links, um zurückzugehen.',
			'weekStory.faithfulLead' => 'Du warst treu',
			'weekStory.emptyLead' => 'Eine neue Woche wartet auf dich',
			'weekStory.days' => ({required num n, required Object total}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n, one: '${n} Tag\nvon ${total}', other: '${n} Tage\nvon ${total}', ), 
			'weekStory.streak' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n, one: '${n} Tag in Folge', other: '${n} Tage in Folge', ), 
			'weekStory.streakRecord' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n, one: '${n} Tag in Folge: dein Rekord!', other: '${n} Tage in Folge: dein Rekord!', ), 
			'weekStory.emptyText' => 'Fülle deinen Bericht jeden Tag aus: Deine nächste Woche wird hier geschrieben.',
			'weekStory.prayerLead' => 'Du hast gebetet',
			'weekStory.retreats' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n, one: '${n} Gebetszeit', other: '${n} Gebetszeiten', ), 
			'weekStory.retreatsTime' => ({required Object time}) => 'von 15 Minuten · ${time} mit dem Herrn',
			'weekStory.faithfulMoment' => ({required num n, required Object moment}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n, one: 'Deine treueste Zeit: ${moment} (${n}-mal)', other: 'Deine treueste Zeit: ${moment} (${n}-mal)', ), 
			'weekStory.noRetreat' => 'Keine Gebetszeit diese Woche',
			'weekStory.noRetreatText' => 'Die Gebetszeit am Mittag wartet auf dich: 15 Minuten mit dem Herrn.',
			'weekStory.goalsLead' => 'Deine Ziele',
			'weekStory.goalsReached' => 'im Durchschnitt erreicht',
			'weekStory.bestDay' => ({required Object day, required Object percent}) => 'Dein bester Tag: ${day} · ${percent}',
			'weekStory.summaryTitle' => 'Meine Woche mit Gott',
			'weekStory.statDays' => 'ausgefüllte Tage',
			'weekStory.statStreak' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n, one: 'Tag in Folge', other: 'Tage in Folge', ), 
			'weekStory.statRetreats' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n, one: 'Gebetszeit', other: 'Gebetszeiten', ), 
			'weekStory.statGoals' => 'der Ziele',
			'weekStory.share' => 'Meine Woche teilen',
			'weekStory.homeText' => 'Deine Treue, dein Gebet und deine Ziele dieser Woche.',
			'weekStory.open' => 'Meine Woche ansehen',
			'weekStory.notificationTitle' => 'Deine Woche mit Gott ist bereit',
			'weekStory.notificationBody' => 'Schau auf deine Treue dieser Woche zurück und teile sie.',
			'weekStory.channel' => 'Deine Woche mit Gott',
			'weekStory.thisWeek' => 'Diese Woche',
			'weekStory.pastWeeks' => 'Vergangene Wochen',
			'weekStory.weekOf' => ({required Object date}) => 'Woche vom ${date}',
			'weekStory.page' => ({required Object current, required Object total}) => '${current} von ${total}',
			'seekFirst.title' => 'Suche zuerst Gott',
			'seekFirst.verse' => 'Trachtet am ersten nach dem Reich Gottes und nach seiner Gerechtigkeit, so wird euch solches alles zufallen.',
			'seekFirst.verseRef' => 'Matthäus 6,33',
			'seekFirst.intro' => 'Jeden Tag bleiben die Apps, die du wählst, geschlossen, bis dein Bericht gespeichert ist. Beginne deinen Tag mit Gott, der Rest folgt.',
			'seekFirst.enable' => 'Einschalten',
			'seekFirst.apps' => 'Geschlossene Apps',
			'seekFirst.appsNone' => 'Keine App gewählt',
			'seekFirst.appCount' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n, one: '${n} App', other: '${n} Apps', ), 
			'seekFirst.categoryCount' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n, one: '${n} Kategorie', other: '${n} Kategorien', ), 
			'seekFirst.siteCount' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n, one: '${n} Website', other: '${n} Websites', ), 
			'seekFirst.start' => 'Geschlossen ab',
			'seekFirst.pauses' => '5-Minuten-Pausen',
			'seekFirst.pausesText' => '3 pro Tag, für einen Notfall',
			'seekFirst.pausesLeft' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n, zero: 'Heute keine Pause mehr', one: 'Heute noch ${n} Pause', other: 'Heute noch ${n} Pausen', ), 
			'seekFirst.todayOpen' => 'Heute sind deine Apps offen: Du hast zuerst Gott gesucht.',
			'seekFirst.todayLocked' => 'Deine Apps bleiben bis zu deinem heutigen Bericht geschlossen.',
			'seekFirst.todayBefore' => ({required Object time}) => 'Deine Apps schließen sich um ${time}, wenn dein Bericht noch nicht gespeichert ist.',
			'seekFirst.fillReport' => 'Meinen Bericht ausfüllen',
			'seekFirst.denied' => 'Ohne Zugriff auf Bildschirmzeit kann CMFI Connect keine Apps schließen. Du kannst ihn unter Einstellungen › Bildschirmzeit erlauben.',
			'seekFirst.noApps' => 'Wähle mindestens eine App, die geschlossen bleiben soll.',
			'seekFirst.unsupported' => 'Bald auf diesem Telefon verfügbar.',
			'seekFirst.moreOn' => ({required Object time}) => 'Ab ${time}, bis zu deinem Bericht',
			'seekFirst.moreOff' => 'Apps schließen, bis dein Bericht fertig ist',
			'seekFirst.privacy' => 'CMFI Connect sieht nie, welche Apps du wählst: Dein iPhone behält sie für sich.',
			'seekFirst.shield.title' => 'Suche zuerst Gott',
			'seekFirst.shield.subtitle' => ({required Object app}) => '${app} bleibt bis zu deinem heutigen Bericht geschlossen.',
			'seekFirst.shield.thisApp' => 'Diese App',
			'seekFirst.shield.fill' => 'Meinen Bericht ausfüllen',
			'seekFirst.shield.pause' => ({required Object n}) => '5 Min. Pause (${n}/3)',
			'seekFirst.shield.notificationTitle' => 'Suche zuerst Gott',
			'seekFirst.shield.notificationBody' => 'Tippe hier, um deinen Bericht auszufüllen.',
			_ => null,
		};
	}
}
