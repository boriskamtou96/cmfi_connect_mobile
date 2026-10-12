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
	@override late final _Translations$prayer$de prayer = _Translations$prayer$de._(_root);
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
	@override String get phoneHint => '6 90 00 00 01';
	@override String dialCode({required Object code}) => 'Ländervorwahl: ${code}';
	@override String get password => 'Passwort';
	@override String get showPassword => 'Passwort anzeigen';
	@override String get hidePassword => 'Passwort verbergen';
	@override late final _Translations$auth$login$de login = _Translations$auth$login$de._(_root);
	@override late final _Translations$auth$register$de register = _Translations$auth$register$de._(_root);
	@override late final _Translations$auth$church$de church = _Translations$auth$church$de._(_root);
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
	@override String get more => 'Mehr';
}

// Path: home
class _Translations$home$de extends Translations$home$fr {
	_Translations$home$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String greeting({required Object name}) => 'Hallo ${name}';
	@override String get greetingNoName => 'Hallo';
	@override String get profile => 'Mein Profil';
	@override String get todayTitle => 'Bericht von heute';
	@override String progress({required Object filled, required Object total}) => '${filled} von ${total}';
	@override String get progressLabel => 'Elemente ausgefüllt';
	@override String get continueReport => 'Weiter';
	@override String get startReport => 'Beginnen';
	@override String get weekTitle => 'Deine Woche';
	@override String weekScore({required num filled, required Object total}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(filled,
		one: '${filled} von ${total} Tagen',
		other: '${filled} von ${total} Tagen',
	);
	@override String get community => 'In deiner Gemeinschaft';
	@override String get prayerTitle => 'Gebetsanliegen';
	@override String get prayerText => 'Bald kannst du jeden Tag die Gebetsanliegen deiner Gemeinde im Gebet mittragen.';
	@override String get eventsTitle => 'Veranstaltungen';
	@override String get hymnsTitle => 'Lieder';
	@override String hymnsResume({required Object number}) => 'Weiter bei Nr. ${number}';
	@override String get hymnsOpen => 'Liederbuch öffnen';
	@override String streak({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
		one: '${n} Tag in Folge',
		other: '${n} Tage in Folge',
	);
	@override String get streakKeep => 'Fülle heute aus, um dranzubleiben';
	@override String get streakToday => 'Super, mach morgen weiter!';
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
	@override String get announcements => 'Ankündigungen';
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
	@override late final _Translations$prayer$reminders$de reminders = _Translations$prayer$reminders$de._(_root);
	@override late final _Translations$prayer$retreat$de retreat = _Translations$prayer$retreat$de._(_root);
	@override late final _Translations$prayer$session$de session = _Translations$prayer$session$de._(_root);
	@override late final _Translations$prayer$done$de done = _Translations$prayer$done$de._(_root);
	@override late final _Translations$prayer$topics$de topics = _Translations$prayer$topics$de._(_root);
	@override late final _Translations$prayer$lists$de lists = _Translations$prayer$lists$de._(_root);
	@override late final _Translations$prayer$importunity$de importunity = _Translations$prayer$importunity$de._(_root);
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
	@override String get countryHint => 'Kamerun';
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
}

// Path: members.deleteAccount
class _Translations$members$deleteAccount$de extends Translations$members$deleteAccount$fr {
	_Translations$members$deleteAccount$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get button => 'Mein Konto löschen';
	@override String get title => 'Mein Konto löschen';
	@override String get intro => 'Das ist endgültig. Dein Konto und alles, was dazugehört, wird gelöscht:';
	@override String get itemProfile => 'dein Profil, dein Benutzername und dein Passwort';
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
	@override String points({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
		one: '${n} Anliegen',
		other: '${n} Anliegen',
	);
	@override String until({required Object date}) => 'bis ${date}';
	@override String since({required Object date}) => 'seit dem ${date}';
	@override String people({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
		zero: 'Noch niemand',
		one: '${n} betet',
		other: '${n} beten',
	);
	@override String get withPdf => 'Mit PDF';
	@override String get isNew => 'Neu';
	@override String get screenTitle => 'Gebetsanliegen';
	@override String period({required Object from, required Object to}) => 'Vom ${from} bis ${to}';
	@override String peopleBanner({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
		zero: 'Noch betet niemand für diese Anliegen: Mach den Anfang!',
		one: '${n} Bruder oder Schwester betet für diese Anliegen',
		other: '${n} Brüder und Schwestern beten für diese Anliegen',
	);
	@override String prayedToday({required Object count, required Object prayed}) => '${count} · heute für ${prayed} gebetet';
	@override String get document => 'Originaldokument';
	@override String get prayAll => 'Ich habe für alle diese Anliegen gebetet';
	@override String get allPrayed => 'Heute für alle gebetet';
	@override String get archive => 'Frühere Anliegen';
	@override String get archiveEmpty => 'Keine früheren Anliegen.';
	@override String get current => 'Aktuell';
	@override String shareText({required Object title, required Object points}) => '${title}\n\n${points}\n\nLasst uns gemeinsam in der App CMFI Connect beten.';
	@override String documentSize({required Object kb}) => '${kb} KB';
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
			'auth.phoneHint' => '6 90 00 00 01',
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
			'auth.church.countryHint' => 'Kamerun',
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
			'nav.home' => 'Start',
			'nav.reports' => 'Bericht',
			'nav.hymns' => 'Lieder',
			'nav.prayer' => 'Gebet',
			'nav.more' => 'Mehr',
			'home.greeting' => ({required Object name}) => 'Hallo ${name}',
			'home.greetingNoName' => 'Hallo',
			'home.profile' => 'Mein Profil',
			'home.todayTitle' => 'Bericht von heute',
			'home.progress' => ({required Object filled, required Object total}) => '${filled} von ${total}',
			'home.progressLabel' => 'Elemente ausgefüllt',
			'home.continueReport' => 'Weiter',
			'home.startReport' => 'Beginnen',
			'home.weekTitle' => 'Deine Woche',
			'home.weekScore' => ({required num filled, required Object total}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(filled, one: '${filled} von ${total} Tagen', other: '${filled} von ${total} Tagen', ), 
			'home.community' => 'In deiner Gemeinschaft',
			'home.prayerTitle' => 'Gebetsanliegen',
			'home.prayerText' => 'Bald kannst du jeden Tag die Gebetsanliegen deiner Gemeinde im Gebet mittragen.',
			'home.eventsTitle' => 'Veranstaltungen',
			'home.hymnsTitle' => 'Lieder',
			'home.hymnsResume' => ({required Object number}) => 'Weiter bei Nr. ${number}',
			'home.hymnsOpen' => 'Liederbuch öffnen',
			'home.streak' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n, one: '${n} Tag in Folge', other: '${n} Tage in Folge', ), 
			'home.streakKeep' => 'Fülle heute aus, um dranzubleiben',
			'home.streakToday' => 'Super, mach morgen weiter!',
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
			'reports.noItems' => 'Im Moment gibt es nichts auszufüllen.',
			'reports.statusPending' => 'Noch nicht gesendet',
			'reports.savedOffline' => 'Kein Netz: Der Tag bleibt auf dem Handy gespeichert und wird gesendet, sobald es möglich ist.',
			'reports.pendingBanner' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n, one: '${n} Tag wartet auf Netz, um gesendet zu werden', other: '${n} Tage warten auf Netz, um gesendet zu werden', ), 
			'reports.export' => 'Meinen Bericht exportieren',
			'reports.goal' => ({required Object value}) => 'Ziel: ${value}',
			'reports.goalReached' => 'Ziel erreicht',
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
			'more.announcements' => 'Ankündigungen',
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
			'members.deleteAccount.itemProfile' => 'dein Profil, dein Benutzername und dein Passwort',
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
			_ => null,
		} ?? switch (path) {
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
			'prayer.topics.points' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n, one: '${n} Anliegen', other: '${n} Anliegen', ), 
			'prayer.topics.until' => ({required Object date}) => 'bis ${date}',
			'prayer.topics.since' => ({required Object date}) => 'seit dem ${date}',
			'prayer.topics.people' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n, zero: 'Noch niemand', one: '${n} betet', other: '${n} beten', ), 
			'prayer.topics.withPdf' => 'Mit PDF',
			'prayer.topics.isNew' => 'Neu',
			'prayer.topics.screenTitle' => 'Gebetsanliegen',
			'prayer.topics.period' => ({required Object from, required Object to}) => 'Vom ${from} bis ${to}',
			'prayer.topics.peopleBanner' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n, zero: 'Noch betet niemand für diese Anliegen: Mach den Anfang!', one: '${n} Bruder oder Schwester betet für diese Anliegen', other: '${n} Brüder und Schwestern beten für diese Anliegen', ), 
			'prayer.topics.prayedToday' => ({required Object count, required Object prayed}) => '${count} · heute für ${prayed} gebetet',
			'prayer.topics.document' => 'Originaldokument',
			'prayer.topics.prayAll' => 'Ich habe für alle diese Anliegen gebetet',
			'prayer.topics.allPrayed' => 'Heute für alle gebetet',
			'prayer.topics.archive' => 'Frühere Anliegen',
			'prayer.topics.archiveEmpty' => 'Keine früheren Anliegen.',
			'prayer.topics.current' => 'Aktuell',
			'prayer.topics.shareText' => ({required Object title, required Object points}) => '${title}\n\n${points}\n\nLasst uns gemeinsam in der App CMFI Connect beten.',
			'prayer.topics.documentSize' => ({required Object kb}) => '${kb} KB',
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
			_ => null,
		};
	}
}
