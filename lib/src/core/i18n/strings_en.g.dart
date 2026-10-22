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
class TranslationsEn extends Translations with BaseTranslations<AppLocale, Translations> {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsEn({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  _meta = meta ?? TranslationMetadata(
		    locale: AppLocale.en,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ),
		  super(cardinalResolver: cardinalResolver, ordinalResolver: ordinalResolver) {
		_meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <en>.
	final TranslationMetadata<AppLocale, Translations> _meta;
	@override TranslationMetadata<AppLocale, Translations> get $meta => _meta;

	/// Access flat map
	@override dynamic operator[](String key) => _meta.getTranslation(key) ?? super[key];

	late final TranslationsEn _root = this; // ignore: unused_field

	@override 
	TranslationsEn $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsEn(meta: meta ?? this.$meta);

	// Translations
	@override late final _Translations$app$en app = _Translations$app$en._(_root);
	@override late final _Translations$common$en common = _Translations$common$en._(_root);
	@override late final _Translations$errors$en errors = _Translations$errors$en._(_root);
	@override late final _Translations$validation$en validation = _Translations$validation$en._(_root);
	@override late final _Translations$welcome$en welcome = _Translations$welcome$en._(_root);
	@override late final _Translations$auth$en auth = _Translations$auth$en._(_root);
	@override late final _Translations$countries$en countries = _Translations$countries$en._(_root);
	@override late final _Translations$nav$en nav = _Translations$nav$en._(_root);
	@override late final _Translations$home$en home = _Translations$home$en._(_root);
	@override late final _Translations$reports$en reports = _Translations$reports$en._(_root);
	@override late final _Translations$reminder$en reminder = _Translations$reminder$en._(_root);
	@override late final _Translations$export$en export = _Translations$export$en._(_root);
	@override late final _Translations$items$en items = _Translations$items$en._(_root);
	@override late final _Translations$newItem$en newItem = _Translations$newItem$en._(_root);
	@override late final _Translations$more$en more = _Translations$more$en._(_root);
	@override late final _Translations$authorities$en authorities = _Translations$authorities$en._(_root);
	@override late final _Translations$members$en members = _Translations$members$en._(_root);
	@override late final _Translations$admin$en admin = _Translations$admin$en._(_root);
	@override late final _Translations$hymns$en hymns = _Translations$hymns$en._(_root);
	@override late final _Translations$comingSoon$en comingSoon = _Translations$comingSoon$en._(_root);
	@override late final _Translations$events$en events = _Translations$events$en._(_root);
	@override late final _Translations$notifications$en notifications = _Translations$notifications$en._(_root);
	@override late final _Translations$premium$en premium = _Translations$premium$en._(_root);
	@override late final _Translations$homeWidget$en homeWidget = _Translations$homeWidget$en._(_root);
	@override late final _Translations$ministry$en ministry = _Translations$ministry$en._(_root);
	@override late final _Translations$prayer$en prayer = _Translations$prayer$en._(_root);
	@override late final _Translations$sending$en sending = _Translations$sending$en._(_root);
	@override late final _Translations$streak$en streak = _Translations$streak$en._(_root);
	@override late final _Translations$shortcuts$en shortcuts = _Translations$shortcuts$en._(_root);
	@override late final _Translations$blocking$en blocking = _Translations$blocking$en._(_root);
	@override late final _Translations$verses$en verses = _Translations$verses$en._(_root);
	@override late final _Translations$bible$en bible = _Translations$bible$en._(_root);
	@override late final _Translations$profilePhoto$en profilePhoto = _Translations$profilePhoto$en._(_root);
	@override late final _Translations$disciples$en disciples = _Translations$disciples$en._(_root);
	@override late final _Translations$weekStory$en weekStory = _Translations$weekStory$en._(_root);
	@override late final _Translations$yearStory$en yearStory = _Translations$yearStory$en._(_root);
	@override late final _Translations$seekFirst$en seekFirst = _Translations$seekFirst$en._(_root);
	@override late final _Translations$documents$en documents = _Translations$documents$en._(_root);
	@override late final _Translations$biblePlan$en biblePlan = _Translations$biblePlan$en._(_root);
	@override late final _Translations$teachings$en teachings = _Translations$teachings$en._(_root);
	@override late final _Translations$memorize$en memorize = _Translations$memorize$en._(_root);
	@override late final _Translations$souls$en souls = _Translations$souls$en._(_root);
	@override late final _Translations$fasts$en fasts = _Translations$fasts$en._(_root);
	@override late final _Translations$received$en received = _Translations$received$en._(_root);
}

// Path: app
class _Translations$app$en extends Translations$app$fr {
	_Translations$app$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get name => 'CMFI Connect';
	@override String get tagline => 'Growing together, every day.';
	@override String get languageName => 'English';
}

// Path: common
class _Translations$common$en extends Translations$common$fr {
	_Translations$common$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get retry => 'Try again';
	@override String get cancel => 'Cancel';
	@override String get save => 'Save';
	@override String get close => 'Close';
	@override String get back => 'Back';
	@override String get soon => 'Soon';
	@override String get optional => '(optional)';
	@override String get and => 'and';
	@override String get loading => 'Loading…';
	@override String get done => 'Done';
	@override String get rangeStart => 'From';
	@override String get rangeEnd => 'To';
}

// Path: errors
class _Translations$errors$en extends Translations$errors$fr {
	_Translations$errors$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get network => 'No internet connection. Check your network and try again.';
	@override String get unauthorized => 'Your session has expired. Please sign in again.';
	@override String get invalidCredentials => 'Wrong phone number or password.';
	@override String get badRequest => 'Some information is not valid.';
	@override String get conflict => 'This item already exists.';
	@override String get notFound => 'Item not found.';
	@override String get server => 'The server ran into a problem. Try again in a moment.';
	@override String get unknown => 'Something went wrong. Try again.';
	@override String get forbidden => 'You\'re not allowed to do this.';
	@override String get eventFull => 'There is no seat left for this event.';
	@override String get registrationClosed => 'Registration for this event is closed.';
	@override String get mediaTooLarge => 'This image is too large (8 MB at most).';
	@override String get mediaUnsupported => 'Choose a JPEG or PNG image.';
	@override String get notParticipant => 'Join this topic first to count your proclamations.';
	@override String get importunityClosed => 'This topic is closed: it doesn\'t count proclamations any more.';
	@override String get usernameNotFound => 'Nobody has this username. Check the spelling.';
	@override String get ownerCannotLeave => 'You created this topic: delete it instead of leaving it.';
	@override String get tooManyPeople => 'Your lists are full (500 people at most).';
	@override String get avatarInvalid => 'This photo can\'t be used. Choose another one.';
	@override String get reportsNotShared => 'This member no longer shares their reports.';
}

// Path: validation
class _Translations$validation$en extends Translations$validation$fr {
	_Translations$validation$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get required => 'This field is required';
	@override String get passwordTooShort => 'At least 6 characters';
	@override String get invalidPhone => 'Invalid phone number';
	@override String get invalidEmail => 'Invalid email address';
	@override String get invalidCode => 'Letters and digits only, no spaces';
}

// Path: welcome
class _Translations$welcome$en extends Translations$welcome$fr {
	_Translations$welcome$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override late final _Translations$welcome$seek$en seek = _Translations$welcome$seek$en._(_root);
	@override late final _Translations$welcome$worship$en worship = _Translations$welcome$worship$en._(_root);
	@override late final _Translations$welcome$community$en community = _Translations$welcome$community$en._(_root);
	@override String step({required Object current, required Object total}) => 'Screen ${current} of ${total}';
	@override String streak({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: '${n} day with God',
		other: '${n} days with God',
	);
	@override late final _Translations$welcome$sample$en sample = _Translations$welcome$sample$en._(_root);
	@override String get createAccount => 'Create my account';
	@override String get haveAccount => 'I already have an account';
}

// Path: auth
class _Translations$auth$en extends Translations$auth$fr {
	_Translations$auth$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get phone => 'Phone';
	@override String dialCode({required Object code}) => 'Country code: ${code}';
	@override String get password => 'Password';
	@override String get showPassword => 'Show password';
	@override String get hidePassword => 'Hide password';
	@override late final _Translations$auth$login$en login = _Translations$auth$login$en._(_root);
	@override late final _Translations$auth$register$en register = _Translations$auth$register$en._(_root);
	@override late final _Translations$auth$church$en church = _Translations$auth$church$en._(_root);
	@override late final _Translations$auth$forgot$en forgot = _Translations$auth$forgot$en._(_root);
	@override late final _Translations$auth$biometric$en biometric = _Translations$auth$biometric$en._(_root);
}

// Path: countries
class _Translations$countries$en extends Translations$countries$fr {
	_Translations$countries$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get dialCodeTitle => 'Country code';
	@override String get title => 'Your country';
	@override String get search => 'Search a country or a code';
	@override String get none => 'No country matches';
	@override String get change => 'Change country';
}

// Path: nav
class _Translations$nav$en extends Translations$nav$fr {
	_Translations$nav$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get home => 'Home';
	@override String get reports => 'Report';
	@override String get hymns => 'Hymns';
	@override String get prayer => 'Prayer';
	@override String get bible => 'Bible';
}

// Path: home
class _Translations$home$en extends Translations$home$fr {
	_Translations$home$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String greeting({required Object name}) => 'Hello ${name}';
	@override String get greetingNoName => 'Hello';
	@override String get profile => 'My profile';
	@override String progress({required Object filled, required Object total}) => '${filled} of ${total}';
	@override String get progressLabel => 'items filled in';
	@override String get goals => 'goals';
	@override String get weekTitle => 'Your week';
	@override String get community => 'Currently at CMFI';
	@override String get eventsTitle => 'Events';
	@override String get hymnsTitle => 'Hymns';
	@override String get hymnsOpen => 'Open the hymn book';
	@override String get continueMyReport => 'Continue my report';
	@override String get startMyReport => 'Start my report';
	@override String get items => 'items';
	@override String get goalsTitle => 'Goals';
	@override String get retreatsTitle => 'Retreats';
	@override String retreatsValue({required Object n}) => '${n} of 4';
	@override String get streakTitle => 'Streak';
	@override String get resume => 'Pick up where you left off';
	@override String hymnNumber({required Object number}) => 'Hymn no. ${number}';
	@override String get seeAll => 'See all';
	@override String get retreatsDone => 'The 4 retreats of the day are done';
	@override String days({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: '${n} day',
		other: '${n} days',
	);
	@override String get hideNumbers => 'Hide my numbers';
	@override String get showNumbers => 'Show my numbers';
	@override String get numbersHidden => 'hidden';
	@override String daysShort({required Object n}) => '${n} d';
	@override String get prayTogether => 'Pray together';
	@override String invitedBy({required Object name}) => '${name} invites you to pray';
	@override String get soulsTitle => 'Souls to contact again';
	@override String get listenTitle => 'To listen';
	@override String soulsText({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: '${n} person today',
		other: '${n} people today',
	);
}

// Path: reports
class _Translations$reports$en extends Translations$reports$fr {
	_Translations$reports$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Daily report';
	@override String get myItems => 'My items';
	@override late final _Translations$reports$tabs$en tabs = _Translations$reports$tabs$en._(_root);
	@override String get pickDay => 'Pick the day';
	@override String filled({required Object filled, required Object total}) => '${filled} of ${total} filled in';
	@override String get statusSaved => 'Saved';
	@override String get statusModified => 'Not saved';
	@override String get standard => 'Standard';
	@override String get personal => 'My items';
	@override String get createItem => 'Create an item';
	@override String add({required Object label}) => 'Add ${label}';
	@override String get note => 'Note of the day';
	@override String get noteHint => 'A verse, something you\'re thankful for…';
	@override String get save => 'Save the day';
	@override String get saved => 'Day saved';
	@override late final _Translations$reports$measure$en measure = _Translations$reports$measure$en._(_root);
	@override String times({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: '${n} time',
		other: '${n} times',
	);
	@override late final _Translations$reports$sheet$en sheet = _Translations$reports$sheet$en._(_root);
	@override late final _Translations$reports$history$en history = _Translations$reports$history$en._(_root);
	@override late final _Translations$reports$summary$en summary = _Translations$reports$summary$en._(_root);
	@override String get noItems => 'Nothing to fill in yet.';
	@override String get statusPending => 'Not sent yet';
	@override String get savedOffline => 'No network: the day is kept on your phone and will be sent as soon as possible.';
	@override String pendingBanner({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: '${n} day is waiting for the network to be sent',
		other: '${n} days are waiting for the network to be sent',
	);
	@override String get export => 'Export my report';
	@override String goal({required Object value}) => 'Goal: ${value}';
	@override String get goalReached => 'Goal reached';
	@override String get dayGoals => 'Goals of the day';
	@override String goalsReached({required Object reached, required Object total}) => 'Reached: ${reached} of ${total}';
	@override late final _Translations$reports$standardItems$en standardItems = _Translations$reports$standardItems$en._(_root);
	@override late final _Translations$reports$units$en units = _Translations$reports$units$en._(_root);
	@override late final _Translations$reports$timer$en timer = _Translations$reports$timer$en._(_root);
}

// Path: reminder
class _Translations$reminder$en extends Translations$reminder$fr {
	_Translations$reminder$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Your daily report';
	@override String get body => 'Take a minute to note your reading, your prayer… before the day ends.';
	@override String get channel => 'Report reminder';
	@override String get settings => 'Evening reminder';
	@override String get off => 'Off';
	@override String get switchLabel => 'Remind me to fill in my day';
	@override String get switchHint => 'Only when the day isn\'t filled in yet.';
	@override String get time => 'Reminder time';
	@override String get offerTitle => 'A reminder every evening?';
	@override String get offerText => 'If your day isn\'t filled in yet, the app reminds you at the time you choose. Nothing if it\'s already done.';
	@override String get offerAccept => 'Turn on the reminder';
	@override String get offerLater => 'Later';
	@override String enabled({required Object time}) => 'Reminder set for ${time}';
	@override String get denied => 'Notifications are blocked for CMFI Connect. Allow them in the phone settings.';
}

// Path: export
class _Translations$export$en extends Translations$export$fr {
	_Translations$export$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Export';
	@override String get period => 'Period';
	@override String get thisWeek => 'This week';
	@override String get lastWeek => 'Last week';
	@override String get thisMonth => 'This month';
	@override String get lastMonth => 'Last month';
	@override String get thisYear => 'This year';
	@override String get custom => 'Other dates';
	@override String get customPick => 'Choose the dates';
	@override String get format => 'Format';
	@override String get pdf => 'PDF';
	@override String get pdfHint => 'A document to send or print';
	@override String get csv => 'Spreadsheet';
	@override String get csvHint => 'A CSV file for Excel or Google Sheets';
	@override String get text => 'Message';
	@override String get textHint => 'A summary to paste in WhatsApp';
	@override String get button => 'Export';
	@override String get shareButton => 'Share';
	@override String preview({required num filled, required Object total, required Object items}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(filled,
		one: '${filled} day filled out of ${total} · ${items}',
		other: '${filled} days filled out of ${total} · ${items}',
	);
	@override String previewItems({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: '${n} item',
		other: '${n} items',
	);
	@override String get empty => 'No report in this period.';
	@override String get tooLong => 'Choose 366 days at most.';
	@override String get fileName => 'daily-report';
	@override String subject({required Object period}) => 'My daily report, ${period}';
	@override late final _Translations$export$doc$en doc = _Translations$export$doc$en._(_root);
}

// Path: items
class _Translations$items$en extends Translations$items$fr {
	_Translations$items$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'My items';
	@override String get standardSection => 'Standard · for everyone';
	@override String get personalSection => 'My personal items';
	@override String get emptyPersonal => 'You don\'t have any personal item yet.';
	@override String get archive => 'Archive';
	@override String archiveTitle({required Object code}) => 'Archive ${code}?';
	@override String get archiveText => 'It won\'t be offered in your report anymore. Its figures stay in your history.';
	@override String archived({required Object code}) => '${code} archived';
	@override String get create => 'Create an item';
	@override String get footnote => 'An archived item is no longer offered in your report, but its figures stay in your history.';
	@override late final _Translations$items$measure$en measure = _Translations$items$measure$en._(_root);
	@override String get goalAdd => 'Add a goal';
	@override String goal({required Object value}) => 'Goal: ${value} a day';
	@override String get goalTitle => 'Daily goal';
	@override String get goalHint => 'What you aim for each day. It stays on your phone.';
	@override String get goalRemove => 'Remove';
	@override String get goalSaved => 'Goal saved';
	@override String get goalRemoved => 'Goal removed';
}

// Path: newItem
class _Translations$newItem$en extends Translations$newItem$fr {
	_Translations$newItem$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'New item';
	@override String get code => 'Code';
	@override String get label => 'Name';
	@override String get help => 'Letters and digits, 20 at most. The code of a standard item (LB, PS…) is not available.';
	@override String get measures => 'What you measure';
	@override String get quantity => 'A quantity';
	@override String get quantityHint => 'Chapters, pages, people…';
	@override String get unit => 'Unit shown after the number';
	@override String get unitHint => 'people';
	@override String get duration => 'A duration';
	@override String get durationHint => 'In hours and minutes';
	@override String get noMeasure => 'Pick at least one measure: a quantity, a duration or both.';
	@override String get preview => 'Preview in your report';
	@override String get previewCode => 'CODE';
	@override String get previewLabel => 'Item name';
	@override String get submit => 'Create the item';
	@override String created({required Object code}) => '${code} created.';
	@override String get codeTaken => 'This code is already used, by a standard item or by one of your items (even archived).';
	@override String get codeHint => 'EVG';
	@override String get labelHint => 'Evangelism';
}

// Path: more
class _Translations$more$en extends Translations$more$fr {
	_Translations$more$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'More';
	@override String get editProfile => 'Edit my profile';
	@override String get community => 'Community';
	@override String get events => 'Events';
	@override String get reports => 'Daily report';
	@override String get myItems => 'My items';
	@override String get app => 'App';
	@override String get language => 'Language';
	@override String get appearance => 'Appearance';
	@override String get themeSystem => 'Automatic';
	@override String get themeSystemHint => 'Automatic follows your phone\'s light or dark setting.';
	@override String get themeLight => 'Light';
	@override String get themeDark => 'Dark';
	@override String get logout => 'Sign out';
	@override String get account => 'Account';
	@override String get languageTitle => 'App language';
	@override String get completeProfile => 'Add your name';
	@override String get accompaniment => 'Mentoring';
	@override String get exportReport => 'Export my report';
	@override String get logoutPendingTitle => 'Days not sent yet';
	@override String logoutPendingText({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: '${n} day saved without network hasn\'t been sent yet. If you sign out now, it will be lost.',
		other: '${n} days saved without network haven\'t been sent yet. If you sign out now, they will be lost.',
	);
	@override String get logoutAnyway => 'Sign out';
	@override String get admin => 'Administration';
	@override String get staff => 'Team and roles';
	@override String get manageEvents => 'Events';
	@override String get disciples => 'My disciples';
	@override String version({required Object version}) => 'Version ${version}';
	@override String copyright({required Object year}) => '© ${year} Christian Missionary Fellowship International. All rights reserved.';
}

// Path: authorities
class _Translations$authorities$en extends Translations$authorities$fr {
	_Translations$authorities$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'My spiritual leaders';
	@override String get intro => 'The people who walk with you in your faith: your disciple maker and your other leaders.';
	@override String get discipleMaker => 'Disciple maker';
	@override String discipleMakerOf({required Object name}) => 'Disciple maker: ${name}';
	@override String get noDiscipleMaker => 'No disciple maker yet';
	@override String get others => 'Other leaders';
	@override String get empty => 'You haven\'t added anyone yet.';
	@override String get add => 'Add a leader';
	@override String get remove => 'Remove';
	@override String removeTitle({required Object name}) => 'Remove ${name}?';
	@override String removeText({required Object name}) => '${name} will no longer be in your list of spiritual leaders.';
	@override String removed({required Object name}) => '${name} is no longer in your list.';
	@override String count({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		zero: 'Nobody yet',
		one: '${n} person',
		other: '${n} people',
	);
	@override late final _Translations$authorities$form$en form = _Translations$authorities$form$en._(_root);
	@override String get statusPending => 'Pending';
	@override String get statusDeclined => 'Declined';
	@override String pendingHelp({required Object name}) => 'Their contact details will show once ${name} accepts.';
	@override String get requests => 'Requests';
	@override String get requestDiscipleMaker => 'asks you to be their disciple maker';
	@override String get requestAuthority => 'asks you to accompany them';
	@override String get accept => 'Accept';
	@override String get decline => 'Decline';
	@override String acceptedRequest({required Object name}) => 'You now accompany ${name}.';
	@override String declinedRequest({required Object name}) => 'Request from ${name} declined.';
	@override String requestsCount({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: '${n} request to see',
		other: '${n} requests to see',
	);
	@override late final _Translations$authorities$sharing$en sharing = _Translations$authorities$sharing$en._(_root);
}

// Path: members
class _Translations$members$en extends Translations$members$fr {
	_Translations$members$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get username => 'Username';
	@override String get usernameHint => 'firstname.lastname';
	@override String get usernameHelp => 'This is how other members will find you.';
	@override String get usernameChecking => 'Checking…';
	@override String usernameFree({required Object username}) => '@${username} is available';
	@override String get usernameCurrent => 'This is your current username';
	@override String get usernameTaken => 'This username is already taken.';
	@override String get usernameInvalid => '3 to 30 characters: letters, digits, "." and "_", not starting or ending with a sign.';
	@override String get usernameReserved => 'This username is reserved.';
	@override String usernameSaved({required Object username}) => 'Username saved: @${username}';
	@override late final _Translations$members$deleteAccount$en deleteAccount = _Translations$members$deleteAccount$en._(_root);
}

// Path: admin
class _Translations$admin$en extends Translations$admin$fr {
	_Translations$admin$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Team and roles';
	@override String get intro => 'Admins manage what the whole community shares. Only a superadmin gives or takes back a role.';
	@override String get roleUser => 'Member';
	@override String get roleAdmin => 'Admin';
	@override String get roleSuperadmin => 'Superadmin';
	@override String get giveRole => 'Give a role';
	@override String get you => 'you';
	@override String roleFor({required Object username}) => 'Role of @${username}';
	@override String roleChanged({required Object username, required Object role}) => '@${username}: ${role}';
	@override String get memberUsername => 'Member\'s username';
	@override String get empty => 'No admin yet.';
}

// Path: hymns
class _Translations$hymns$en extends Translations$hymns$fr {
	_Translations$hymns$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get searchHint => 'Number, title or words';
	@override String get openNumber => 'Go to a number';
	@override late final _Translations$hymns$tabs$en tabs = _Translations$hymns$tabs$en._(_root);
	@override String get chooseBook => 'Choose the hymn book';
	@override String count({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: '${n} hymn',
		other: '${n} hymns',
	);
	@override String number({required Object number}) => 'No. ${number}';
	@override String get emptyFavorites => 'Tap the star of a hymn to find it here.';
	@override String get emptyRecent => 'The hymns you open will show up here.';
	@override String noResult({required Object query}) => 'No hymn matches “${query}”.';
	@override String get otherBooks => 'In the other hymn books';
	@override String get upToDate => 'The hymn books are up to date.';
	@override String get updated => 'The hymn books have been updated.';
	@override String get chorus => 'Chorus';
	@override String chorusNumber({required Object label}) => 'Chorus ${label}';
	@override String verse({required Object label}) => 'Verse ${label}';
	@override String times({required Object n}) => '×${n}';
	@override String get loadFailed => 'The hymn books could not be opened.';
	@override late final _Translations$hymns$reader$en reader = _Translations$hymns$reader$en._(_root);
	@override late final _Translations$hymns$projection$en projection = _Translations$hymns$projection$en._(_root);
	@override late final _Translations$hymns$pad$en pad = _Translations$hymns$pad$en._(_root);
}

// Path: comingSoon
class _Translations$comingSoon$en extends Translations$comingSoon$fr {
	_Translations$comingSoon$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get badge => 'Coming soon';
	@override String get backHome => 'Back to home';
}

// Path: events
class _Translations$events$en extends Translations$events$fr {
	_Translations$events$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Events';
	@override String get featured => 'Featured';
	@override String get upcoming => 'Coming up';
	@override String get past => 'Past editions';
	@override String get emptyTitle => 'No upcoming event';
	@override String get emptyText => 'Conferences and gatherings of the whole community will show here, with their program.';
	@override String get manage => 'Manage events';
	@override String get next => 'Next event';
	@override String get seeAll => 'All events';
	@override String get homeText => 'The community\'s gatherings, their program and news.';
	@override String get today => 'Today';
	@override String get tomorrow => 'Tomorrow';
	@override String inDays({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: 'In ${n} day',
		other: 'In ${n} days',
	);
	@override String daysLeft({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: '${n} day',
		other: '${n} days',
	);
	@override String get onNow => 'On now';
	@override String get over => 'Over';
	@override String get cancelled => 'Cancelled';
	@override String get draft => 'Draft';
	@override String get registered => 'Registered';
	@override String get stateOpen => 'Registration open';
	@override String get stateClosed => 'Registration closed';
	@override String get stateFull => 'Full';
	@override String registrations({required num n, required Object count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		zero: 'Be the first to register',
		one: '${count} registered',
		other: '${count} registered',
	);
	@override String people({required num n, required Object count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: '${count} person',
		other: '${count} people',
	);
	@override String placesLeft({required num n, required Object count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		zero: 'no seat left',
		one: '${count} seat left',
		other: '${count} seats left',
	);
	@override String oneDay({required Object start, required Object end}) => 'From ${start} to ${end}';
	@override String severalDays({required Object startDay, required Object start, required Object endDay, required Object end}) => 'Opens on ${startDay} at ${start}, closes on ${endDay} at ${end}';
	@override String venueTime({required Object place}) => '${place} time';
	@override String get addToCalendar => 'Add to calendar';
	@override String get share => 'Share';
	@override String get directions => 'Directions';
	@override String get viewPoster => 'View the poster';
	@override late final _Translations$events$tabs$en tabs = _Translations$events$tabs$en._(_root);
	@override String get noProgram => 'The program will be published soon.';
	@override String get noNews => 'No news for this event yet.';
	@override String get pinned => 'Pinned';
	@override String get now => 'Happening now';
	@override String hymn({required Object number}) => 'Hymn ${number}';
	@override String get about => 'About';
	@override String get fees => 'Fees';
	@override String deadline({required Object date}) => 'Registration until ${date}';
	@override String get contact => 'Contact';
	@override String call({required Object name}) => 'Call ${name}';
	@override String get otherEditions => 'Other editions';
	@override String get cancelledBanner => 'This event is cancelled.';
	@override String get calendarFailed => 'Couldn\'t open the phone\'s calendar.';
	@override String get linkFailed => 'Couldn\'t open this link.';
	@override String shareText({required Object title, required Object dates, required Object place}) => '${title}\n${dates} · ${place}\nRegister in the CMFI Connect app.';
	@override String get full => 'There is no seat left for this event.';
	@override String get closed => 'Registration for this event is closed.';
	@override late final _Translations$events$register$en register = _Translations$events$register$en._(_root);
	@override late final _Translations$events$reminder$en reminder = _Translations$events$reminder$en._(_root);
	@override late final _Translations$events$admin$en admin = _Translations$events$admin$en._(_root);
	@override String upcomingCount({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: '${n} upcoming event',
		other: '${n} upcoming events',
	);
	@override String slide({required Object current, required Object total}) => 'Event ${current} of ${total}';
}

// Path: notifications
class _Translations$notifications$en extends Translations$notifications$fr {
	_Translations$notifications$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Notifications';
	@override String get channel => 'Community announcements';
	@override String get empty => 'No notifications yet';
	@override String get emptyHint => 'The community\'s announcements will arrive here.';
	@override String unreadLabel({required Object title}) => 'Unread: ${title}';
	@override String documents({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: '${n} PDF document',
		other: '${n} PDF documents',
	);
	@override String unread({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: '${n} unread',
		other: '${n} unread',
	);
	@override String image({required Object n}) => 'Image ${n}';
	@override String get document => 'PDF document';
	@override String documentSize({required Object kb}) => '${kb} KB';
}

// Path: premium
class _Translations$premium$en extends Translations$premium$fr {
	_Translations$premium$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get name => 'CMFI Connect Premium';
	@override String get pill => 'Premium';
	@override String get subtitle => 'Go further in your walk with God, and support the work.';
	@override String get widgetTitle => 'The home-screen widget';
	@override String get widgetText => 'Today\'s report and your goals, without opening the app.';
	@override String get statsTitle => 'Your goals over the year';
	@override String get statsText => 'The year summary and how your goals progress, week after week.';
	@override String get supportTitle => 'You support the work';
	@override String get supportText => 'Your subscription keeps the app going for the whole community.';
	@override String get annual => 'Yearly';
	@override String get lifetime => 'Lifetime';
	@override String get monthly => 'Monthly';
	@override String perYear({required Object price}) => '${price} / year';
	@override String once({required Object price}) => '${price} once';
	@override String perMonth({required Object price}) => '${price} / month';
	@override String annualPerMonth({required Object price}) => 'that\'s ${price} a month';
	@override String get best => 'Best value';
	@override String trialDays({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: '${n}-day free trial',
		other: '${n}-day free trial',
	);
	@override String trialMonths({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: '${n}-month free trial',
		other: '${n}-month free trial',
	);
	@override String get subscribe => 'Subscribe';
	@override String get startTrial => 'Start the free trial';
	@override String get restore => 'Restore purchases';
	@override String get restored => 'Premium is back on this phone';
	@override String get nothingToRestore => 'No Premium purchase for this account';
	@override String get thanks => 'Thank you! Premium is on.';
	@override String get failed => 'The purchase didn\'t go through. Try again in a moment.';
	@override String get unavailable => 'The offers aren\'t available right now.';
	@override String renews({required Object store}) => 'The subscription renews automatically. You can cancel it anytime in your ${store} account settings.';
	@override String get terms => 'Terms of use';
	@override String get privacy => 'Privacy';
	@override String get activeTitle => 'You have Premium';
	@override String get activeText => 'Thank you for supporting CMFI Connect! The widget and the year of your summary are open.';
	@override String get staffText => 'Premium is offered to you as a member of the CMFI Connect team.';
	@override String get moreSubtitle => 'Widget, goals over the year';
	@override String get moreActive => 'Active';
	@override String get unlock => 'Unlock with Premium';
	@override String trialThen({required Object trial, required Object price}) => '${trial}, then ${price}';
	@override String savePercent({required Object percent}) => '−${percent}';
	@override String get choose => 'Choose your plan';
	@override String get cancelAnytime => 'No commitment, cancel anytime';
	@override String get restoreShort => 'Restore';
	@override String get termsShort => 'Terms';
	@override String get semiannual => '6 months';
	@override String perSemester({required Object price}) => '${price} / 6 months';
	@override String get buyLifetime => 'Buy for life';
	@override String get lifetimeNote => 'Lifetime: a single payment, no subscription, nothing renews.';
	@override String get manage => 'Manage my subscription';
	@override String get manageFailed => 'Subscription management won\'t open. Try again later.';
	@override String get crown => 'Premium member';
}

// Path: homeWidget
class _Translations$homeWidget$en extends Translations$homeWidget$fr {
	_Translations$homeWidget$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Today';
	@override String get done => 'Done';
	@override String get todo => 'To fill in';
	@override String get open => 'Fill in';
	@override String get locked => 'Turn on the widget with Premium';
	@override String get signedOut => 'Sign in to the app';
}

// Path: ministry
class _Translations$ministry$en extends Translations$ministry$fr {
	_Translations$ministry$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Our ministry';
	@override String get tagline => 'To the ends of the earth';
	@override String count({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: '${n} nation',
		other: '${n} nations',
	);
	@override String get fromYaounde => 'From Yaoundé, the Gospel goes from nation to nation.';
	@override String get dragHint => 'Turn the globe with your finger, touch a nation.';
	@override String globeLabel({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: 'Globe: ${n} nation where the work is present. The list below gives it.',
		other: 'Globe: ${n} nations where the work is present. The list below gives them all.',
	);
	@override String get voyage => 'Journey';
	@override String get pause => 'Pause';
	@override String get previous => 'Previous nation';
	@override String get next => 'Next nation';
	@override String number({required Object n}) => 'Nation no. ${n}';
	@override String since({required Object year}) => 'Since ${year}';
	@override String get pray => 'Pray';
	@override String prayTitle({required Object country}) => 'Pray for ${country}';
	@override String prayThanks({required Object country}) => 'Give thanks for God\'s work in ${country}.';
	@override String prayAssemblies({required Object country}) => 'Pray for the assemblies of ${country} and their leaders.';
	@override String prayUnreached({required Object country}) => 'Pray that those who have not yet believed in ${country} meet Jesus.';
	@override String get purpose => 'Our purpose';
	@override String get nations => 'The nations';
	@override String get search => 'Search a nation';
	@override String get none => 'No nation matches';
	@override String homeText({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: 'Present in ${n} nation',
		other: 'Present in ${n} nations',
	);
	@override String get nationsSubtitle => 'The globe and the journey from nation to nation';
	@override String get purposeSubtitle => 'Our three goals';
	@override String get missionaries => 'Our missionaries';
	@override String get missionariesSubtitle => 'Those the Lord sends to the nations';
	@override String get heroes => 'Our heroes';
	@override String get heroesSubtitle => 'Those whose faith inspires us';
	@override String get founder => 'Our founder';
	@override String get founderSubtitle => 'Prof. Zacharias Tanee Fomum';
	@override String get leader => 'Our leader';
	@override String get leaderSubtitle => 'Theodore Andoseh';
	@override String get missionariesEmpty => 'Portraits of our missionaries are coming soon.';
	@override String get heroesEmpty => 'Portraits of our heroes are coming soon.';
	@override String get personGone => 'This portrait is no longer available.';
	@override String photoOf({required Object name}) => 'Photo of ${name}';
	@override String get keyDates => 'Key dates';
	@override String get life => 'His life';
	@override String get story => 'Their story';
	@override String goalOf({required Object n, required Object total}) => 'OUR GOAL · ${n}/${total}';
	@override String get previousGoal => 'Previous goal';
	@override String get nextGoal => 'Next goal';
	@override Map<String, String> get media => {
		'books': 'Books',
		'tracts': 'Tracts',
		'magazines': 'Magazines',
		'cds': 'CDs',
		'dvds': 'DVDs',
		'radio': 'Radio',
		'tv': 'Television',
		'internet': 'Internet',
	};
	@override late final _Translations$ministry$goals$en goals = _Translations$ministry$goals$en._(_root);
	@override late final _Translations$ministry$lives$en lives = _Translations$ministry$lives$en._(_root);
}

// Path: prayer
class _Translations$prayer$en extends Translations$prayer$fr {
	_Translations$prayer$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override Map<String, String> get moments => {
		'morning': 'Morning',
		'noon': 'Noon',
		'evening': 'Evening',
		'night': 'Night',
	};
	@override Map<String, String> get retreatOf => {
		'morning': 'Morning retreat',
		'noon': 'Noon retreat',
		'evening': 'Evening retreat',
		'night': 'Night retreat',
	};
	@override late final _Translations$prayer$hero$en hero = _Translations$prayer$hero$en._(_root);
	@override late final _Translations$prayer$today$en today = _Translations$prayer$today$en._(_root);
	@override late final _Translations$prayer$routine$en routine = _Translations$prayer$routine$en._(_root);
	@override String get together => 'Praying together';
	@override late final _Translations$prayer$reminders$en reminders = _Translations$prayer$reminders$en._(_root);
	@override late final _Translations$prayer$retreat$en retreat = _Translations$prayer$retreat$en._(_root);
	@override late final _Translations$prayer$session$en session = _Translations$prayer$session$en._(_root);
	@override late final _Translations$prayer$done$en done = _Translations$prayer$done$en._(_root);
	@override late final _Translations$prayer$topics$en topics = _Translations$prayer$topics$en._(_root);
	@override late final _Translations$prayer$lists$en lists = _Translations$prayer$lists$en._(_root);
	@override late final _Translations$prayer$importunity$en importunity = _Translations$prayer$importunity$en._(_root);
}

// Path: sending
class _Translations$sending$en extends Translations$sending$fr {
	_Translations$sending$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Send to my authorities';
	@override String get moreOff => 'Off';
	@override String get intro => 'At the chosen time, CMFI Connect prepares your report for the period. You just have to send it to your spiritual authorities.';
	@override String get enabled => 'Prepare it for me regularly';
	@override String get rhythm => 'Rhythm';
	@override String get weekly => 'Every week';
	@override String get biweekly => 'Every 2 weeks';
	@override String get monthly => 'Every month';
	@override String get day => 'Day';
	@override String get monthlyDay => 'On the 1st of each month, for the month just ended';
	@override String get time => 'Time';
	@override String get recipients => 'Recipients';
	@override String get noAuthorities => 'First add your spiritual authorities.';
	@override String get addAuthorities => 'Add my authorities';
	@override String get viaWhatsApp => 'By WhatsApp';
	@override String get viaEmail => 'By e-mail';
	@override String get viaBoth => 'By WhatsApp or e-mail';
	@override String get viaShare => 'By sharing';
	@override String next({required Object date}) => 'Next: ${date}';
	@override String get prepareNow => 'Prepare now';
	@override String get history => 'Last sent';
	@override String get notificationTitle => 'Your report is ready';
	@override String get notificationBody => 'Send it to your authorities in one tap.';
	@override String get channel => 'Report sending';
	@override String get readyTitle => 'Your report is ready';
	@override String get preview => 'Message preview';
	@override String greeting({required Object name}) => 'Hello ${name},';
	@override String get whatsApp => 'WhatsApp';
	@override String get email => 'E-mail';
	@override String get sharePdf => 'Share the PDF';
	@override String get shareText => 'Share the text';
	@override String get sent => 'Sent';
	@override String get shared => 'Shared';
	@override String get noRecipients => 'Choose your recipients in the settings, or share the PDF.';
	@override String get settings => 'Settings';
	@override String get permissionDenied => 'Allow notifications to be told at the right time.';
	@override String get inApp => 'Send in the app';
	@override String get viaApp => 'In the app';
	@override String inAppSent({required Object name}) => 'Sent to ${name} in the app';
	@override String inAppUnavailable({required Object name}) => '${name} can\'t receive it in the app for now.';
	@override String get inAppHistory => 'Sent in the app';
	@override String get replied => 'Answered';
	@override String get seen => 'Read';
	@override String get formerAuthority => 'Former leader';
	@override String theirReply({required Object text}) => '“${text}”';
}

// Path: streak
class _Translations$streak$en extends Translations$streak$fr {
	_Translations$streak$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String title({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: '${n} day in a row!',
		other: '${n} days in a row!',
	);
	@override String cardDays({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: 'day with God',
		other: 'days with God',
	);
	@override late final _Translations$streak$lines$en lines = _Translations$streak$lines$en._(_root);
	@override String get share => 'Share';
	@override String get close => 'Continue';
}

// Path: shortcuts
class _Translations$shortcuts$en extends Translations$shortcuts$fr {
	_Translations$shortcuts$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get today => 'Fill in my report';
	@override String get hymns => 'Hymns';
	@override String get retreat => 'Retreat of the moment';
}

// Path: blocking
class _Translations$blocking$en extends Translations$blocking$fr {
	_Translations$blocking$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get report => 'Report';
	@override String block({required Object name}) => 'Block ${name}';
	@override String blockTitle({required Object name}) => 'Block ${name}?';
	@override String blockText({required Object name}) => 'You won\'t receive invitations from ${name} anymore. This invitation is removed.';
	@override String get blockAction => 'Block';
	@override String blocked({required Object name}) => '${name} can no longer invite you.';
	@override String get reportTitle => 'Report this invitation';
	@override String get reportText => 'Tell us what\'s wrong: the leaders of the community will look into it.';
	@override late final _Translations$blocking$reasons$en reasons = _Translations$blocking$reasons$en._(_root);
	@override String get comment => 'Comment';
	@override String get commentHint => 'What the leaders should know';
	@override String get send => 'Send the report';
	@override String get reported => 'Thank you, the leaders will look into it.';
	@override String get listTitle => 'Blocked members';
	@override String get intro => 'Their invitations to pray no longer reach you.';
	@override String get empty => 'You haven\'t blocked anyone.';
	@override String get unblock => 'Unblock';
	@override String unblocked({required Object name}) => '${name} can invite you again.';
}

// Path: verses
class _Translations$verses$en extends Translations$verses$fr {
	_Translations$verses$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Verse of the day';
	@override String get share => 'Share the verse';
	@override String get shareImage => 'Share the image';
	@override String get shareText => 'Share the text';
}

// Path: bible
class _Translations$bible$en extends Translations$bible$fr {
	_Translations$bible$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Bible';
	@override String get books => 'Books';
	@override String get oldTestament => 'Old Testament';
	@override String get newTestament => 'New Testament';
	@override String chapters({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: '${n} chapter',
		other: '${n} chapters',
	);
	@override String chapter({required Object n}) => 'Chapter ${n}';
	@override String get version => 'Version';
	@override String get versions => 'Bible version';
	@override String get search => 'Search the Bible';
	@override String get searchHint => 'A word, or "John 3:16"';
	@override String get searchTip => 'Search for a word ("love") or go straight to a passage ("Psalm 23", "John 3:16").';
	@override String get searchNone => 'No verse contains these words.';
	@override String searchCount({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: '${n} verse',
		other: '${n} verses',
	);
	@override String searchLimit({required Object n}) => 'The first ${n} verses';
	@override String get searchNeedsDownload => 'To search for words in the whole Bible, download it. You can already type a passage: "John 3:16".';
	@override String open({required Object reference}) => 'Open ${reference}';
	@override String get previous => 'Previous chapter';
	@override String get next => 'Next chapter';
	@override String get markRead => 'I read this chapter';
	@override String get markedRead => 'Read today';
	@override String get markReadHint => 'Adds 1 chapter to "Bible reading" in your report.';
	@override String addedToReport({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: 'Report: ${n} chapter read today',
		other: 'Report: ${n} chapters read today',
	);
	@override String get removedFromReport => 'Removed from your report';
	@override String get noReadingItem => 'Your report has no "Bible reading" item.';
	@override String get download => 'Download this Bible';
	@override String downloadHelp({required Object size}) => 'About ${size} MB, to read and search without network.';
	@override String downloading({required Object percent}) => 'Downloading… ${percent}%';
	@override String get downloaded => 'On your phone';
	@override String downloadDone({required Object version}) => '${version} is on your phone';
	@override String get removeDownload => 'Remove from phone';
	@override String removeDownloadTitle({required Object version}) => 'Remove ${version} from your phone?';
	@override String get removeDownloadText => 'The chapters you have already read stay available offline.';
	@override String get offline => 'This chapter is not on your phone yet. Get back online, or download this Bible to read it without network.';
	@override String get notInVersion => 'This passage is not in this version.';
	@override String get marks => 'My verses';
	@override String get favorites => 'Saved';
	@override String get highlights => 'Highlighted';
	@override String get noFavorites => 'Tap a verse, then the bookmark, to find it here.';
	@override String get noHighlights => 'Tap a verse, then a color, to highlight it.';
	@override String get tapHint => 'Tap a verse to highlight, save, copy or share it.';
	@override String highlight({required Object color}) => 'Highlight in ${color}';
	@override late final _Translations$bible$colors$en colors = _Translations$bible$colors$en._(_root);
	@override String get removeHighlight => 'Remove the color';
	@override String get addFavorite => 'Save to My verses';
	@override String get removeFavorite => 'Remove from My verses';
	@override String get favoriteAdded => 'Saved to My verses';
	@override String get favoriteRemoved => 'Removed from My verses';
	@override String get copy => 'Copy';
	@override String get copied => 'Copied';
	@override String get share => 'Share';
	@override String get closeSelection => 'Close the selection';
	@override String get display => 'Display';
	@override String get jesusInRed => 'Words of Jesus in red';
	@override String get jesusInRedHelp => 'In the versions that mark them';
	@override String get remove => 'Remove';
	@override String get readInBible => 'Read in the Bible';
	@override String get concordance => 'Concordance';
	@override String concordanceOf({required Object word}) => 'Concordance of “${word}”';
	@override String get concordanceHint => 'A word of the Bible';
	@override String get concordanceTip => 'Type a word: the concordance shows every verse where it appears, book by book.';
	@override String get concordanceNeedsDownload => 'The concordance goes through the whole Bible: download it first.';
	@override String get concordanceNone => 'This word is not in this Bible.';
	@override String get exactWord => 'This word';
	@override String get startsWith => 'Starts with…';
	@override String occurrences({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: 'occurrence',
		other: 'occurrences',
	);
	@override String inVerses({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: 'in ${n} verse',
		other: 'in ${n} verses',
	);
	@override String get spread => 'Where this word appears';
	@override String get forms => 'Forms found';
	@override String bookCount({required Object book, required Object n}) => '${book}: ${n}';
	@override String get allBooks => 'All books';
	@override String get pickWord => 'Choose a word';
	@override String get pickWordHelp => 'The concordance shows every verse where it appears.';
	@override String get more => 'More options';
	@override String get crossReferences => 'Cross references';
	@override String crossReferencesOf({required Object passage}) => 'Cross references · ${passage}';
	@override String get noCrossReferences => 'No cross reference for this passage.';
	@override String get crossReferencesSource => 'Source: OpenBible.info (CC-BY)';
}

// Path: profilePhoto
class _Translations$profilePhoto$en extends Translations$profilePhoto$fr {
	_Translations$profilePhoto$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Profile photo';
	@override String get add => 'Add a profile photo';
	@override String get change => 'Change the profile photo';
	@override String get seenBy => 'Other members see it wherever your name appears.';
	@override String get camera => 'Take a photo';
	@override String get gallery => 'Choose from the gallery';
	@override String get remove => 'Remove the photo';
	@override String get cropTitle => 'Crop your photo';
	@override String get cropHint => 'Move and enlarge the photo with your fingers.';
	@override String get use => 'Use this photo';
	@override String get unreadable => 'This image can\'t be opened. Choose another one.';
	@override String get saved => 'Your profile photo is saved.';
	@override String get removed => 'Your profile photo is removed.';
}

// Path: disciples
class _Translations$disciples$en extends Translations$disciples$fr {
	_Translations$disciples$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'My disciples';
	@override String get empty => 'No disciple yet';
	@override String get emptyText => 'When a member chooses you as their disciple maker or as an authority and you accept the request, they appear here.';
	@override String count({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: '${n} disciple',
		other: '${n} disciples',
	);
	@override String get notShared => 'Doesn\'t share their reports';
	@override String get roleMaker => 'You\'re their disciple maker';
	@override String get roleAuthority => 'You\'re one of their authorities';
	@override String dayGoals({required Object percent}) => 'Goals ${percent} %';
	@override String dayItems({required Object filled, required Object total, required Object percent}) => '${filled} of ${total} items · ${percent} %';
	@override String get older => 'See the previous 30 days';
	@override String get noReports => 'No report over this period.';
	@override String get searchHint => 'Name or username';
	@override String noMatch({required Object search}) => 'No disciple matches “${search}”.';
}

// Path: weekStory
class _Translations$weekStory$en extends Translations$weekStory$fr {
	_Translations$weekStory$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Your week with God';
	@override String range({required Object from, required Object to}) => '${from} to ${to}';
	@override String get intro => 'Look back on what you lived with the Lord this week.';
	@override String get tapHint => 'Tap on the right to go on, on the left to go back.';
	@override String get faithfulLead => 'You were faithful';
	@override String get emptyLead => 'A new week is waiting for you';
	@override String days({required num n, required Object total}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: '${n} day\nout of ${total}',
		other: '${n} days\nout of ${total}',
	);
	@override String streak({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: '${n} day in a row',
		other: '${n} days in a row',
	);
	@override String streakRecord({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: '${n} day in a row: your record!',
		other: '${n} days in a row: your record!',
	);
	@override String get emptyText => 'Fill in your report every day: your next week will be written here.';
	@override String get prayerLead => 'You prayed';
	@override String retreats({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: '${n} retreat',
		other: '${n} retreats',
	);
	@override String retreatsTime({required Object time}) => 'of 15 minutes · ${time} with the Lord';
	@override String faithfulMoment({required num n, required Object moment}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: 'Your most faithful time: ${moment} (${n} time)',
		other: 'Your most faithful time: ${moment} (${n} times)',
	);
	@override String get noRetreat => 'No retreat this week';
	@override String get noRetreatText => 'The noon retreat is waiting for you: 15 minutes with the Lord.';
	@override String get goalsLead => 'Your goals';
	@override String get goalsReached => 'reached on average';
	@override String bestDay({required Object day, required Object percent}) => 'Your best day: ${day} · ${percent}';
	@override String get summaryTitle => 'My week with God';
	@override String get statDays => 'days filled in';
	@override String statStreak({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: 'day in a row',
		other: 'days in a row',
	);
	@override String statRetreats({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: 'retreat',
		other: 'retreats',
	);
	@override String get statGoals => 'of goals';
	@override String get share => 'Share my week';
	@override String get homeText => 'Your faithfulness, your prayer and your goals this week.';
	@override String get open => 'See my week';
	@override String get notificationTitle => 'Your week with God is ready';
	@override String get notificationBody => 'Look back on your faithfulness this week and share it.';
	@override String get channel => 'Your week with God';
	@override String get thisWeek => 'This week';
	@override String get pastWeeks => 'Past weeks';
	@override String weekOf({required Object date}) => 'Week of ${date}';
	@override String page({required Object current, required Object total}) => '${current} of ${total}';
}

// Path: yearStory
class _Translations$yearStory$en extends Translations$yearStory$fr {
	_Translations$yearStory$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Your year with God';
	@override String since({required Object date}) => 'Since ${date}';
	@override String get intro => 'Look back on all you lived with the Lord this year.';
	@override String get tapHint => 'Tap on the right to go on, on the left to go back.';
	@override String page({required Object current, required Object total}) => '${current} of ${total}';
	@override String get faithfulLead => 'You were faithful';
	@override String days({required num n, required Object total}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: '${n} day\nout of ${total}',
		other: '${n} days\nout of ${total}',
	);
	@override String bestStreak({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: 'Your longest streak: ${n} day',
		other: 'Your longest streak: ${n} days in a row',
	);
	@override String faithfulMonth({required num n, required Object month}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: 'Your most faithful month: ${month} (${n} day)',
		other: 'Your most faithful month: ${month} (${n} days)',
	);
	@override String get prayerLead => 'You prayed';
	@override String retreats({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: '${n} retreat',
		other: '${n} retreats',
	);
	@override String retreatsTime({required Object time}) => 'of 15 minutes · ${time} with the Lord';
	@override String prayerAlone({required Object time}) => '${time} of personal prayer';
	@override String get prayerAloneText => 'of personal prayer with the Lord';
	@override String faithfulMoment({required num n, required Object moment}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: 'Your most faithful time: ${moment} (${n} time)',
		other: 'Your most faithful time: ${moment} (${n} times)',
	);
	@override String get wordLead => 'You read the Word';
	@override String get memoryLead => 'You hid the Word in your heart';
	@override String chapters({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: '${n} chapter',
		other: '${n} chapters',
	);
	@override String bibleShare({required Object percent}) => '${percent} of the Bible';
	@override String get wholeBible => 'As much as the whole Bible!';
	@override String versesKnown({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: 'verse learnt by heart',
		other: 'verses learnt by heart',
	);
	@override String versesLearning({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: 'verse being memorized',
		other: 'verses being memorized',
	);
	@override String get fastLead => 'You fasted';
	@override String fastDays({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: '${n} day',
		other: '${n} days',
	);
	@override String get fastText => 'of fasting before the Lord';
	@override String fullFasts({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: 'day of full fast',
		other: 'days of full fast',
	);
	@override String partialFasts({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: 'day of partial fast',
		other: 'days of partial fast',
	);
	@override String get goalsLead => 'Your goals';
	@override String get goalsReached => 'reached on average';
	@override String bestMonth({required Object month, required Object percent}) => 'Your best month: ${month} · ${percent}';
	@override String get summaryTitle => 'My year with God';
	@override String get statDays => 'days filled in';
	@override String statStreak({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: 'day in a row, your record',
		other: 'days in a row, your record',
	);
	@override String statRetreats({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: 'retreat',
		other: 'retreats',
	);
	@override String get statPrayer => 'of personal prayer';
	@override String statChapters({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: 'chapter read',
		other: 'chapters read',
	);
	@override String statFasts({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: 'day of fasting',
		other: 'days of fasting',
	);
	@override String get statGoals => 'of goals';
	@override String get emptyText => 'Fill in your report every day: your year will be written here.';
	@override String get share => 'Share my year';
	@override String homeText({required Object year}) => 'Your faithfulness, your prayer, the Word: look back on all you lived with God in ${year}.';
	@override String get open => 'See my year';
	@override String get notificationTitle => 'Your year with God is ready';
	@override String notificationBody({required Object year}) => 'Look back on all you lived with the Lord in ${year}, and share it.';
	@override String get channel => 'Your year with God';
	@override String get moreTitle => 'My year with God';
	@override String moreSoFar({required Object year}) => '${year} so far';
	@override String moreDone({required Object year}) => 'All of ${year}';
}

// Path: seekFirst
class _Translations$seekFirst$en extends Translations$seekFirst$fr {
	_Translations$seekFirst$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Seek God first';
	@override String get verse => 'But seek first God’s Kingdom and his righteousness; and all these things will be given to you as well.';
	@override String get verseRef => 'Matthew 6:33';
	@override String get intro => 'Each day, the apps you choose stay closed until your daily report is saved. Start your day with God; the rest follows.';
	@override String get enable => 'Turn on';
	@override String get apps => 'Apps to keep closed';
	@override String get appsNone => 'No app chosen';
	@override String appCount({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: '${n} app',
		other: '${n} apps',
	);
	@override String categoryCount({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: '${n} category',
		other: '${n} categories',
	);
	@override String siteCount({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: '${n} site',
		other: '${n} sites',
	);
	@override String get start => 'Closed from';
	@override String get pauses => '5-minute breaks';
	@override String get pausesText => '3 a day, for an emergency';
	@override String pausesLeft({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		zero: 'No break left today',
		one: '${n} break left today',
		other: '${n} breaks left today',
	);
	@override String get todayOpen => 'Today your apps are open: you sought God first.';
	@override String get todayLocked => 'Your apps stay closed until today\'s report.';
	@override String todayBefore({required Object time}) => 'Your apps will close at ${time} if your report isn\'t saved yet.';
	@override String get fillReport => 'Fill in my report';
	@override String get denied => 'Without Screen Time access, CMFI Connect can\'t close apps. You can allow it in Settings › Screen Time.';
	@override String get noApps => 'Choose at least one app to keep closed.';
	@override String get unsupported => 'Coming soon to this phone.';
	@override String moreOn({required Object time}) => 'From ${time}, until your report';
	@override String get moreOff => 'Close apps until your report is done';
	@override String get privacy => 'CMFI Connect never sees the apps you choose: your iPhone keeps them to itself.';
	@override late final _Translations$seekFirst$shield$en shield = _Translations$seekFirst$shield$en._(_root);
	@override String get permissionsAndroid => 'To close your apps, CMFI Connect needs two permissions, to turn on in the settings that will open: "Usage access" (to know which app is open) and "Display over other apps" (to show the Seek God first screen). Nothing leaves your phone.';
	@override String get permissionsContinue => 'Continue';
	@override String get deniedAndroid => 'Without these two permissions, CMFI Connect can\'t close apps. You can turn them on in Settings › Apps › Special access.';
	@override String get privacyAndroid => 'The apps you choose stay on your phone: CMFI Connect never sends them.';
}

// Path: documents
class _Translations$documents$en extends Translations$documents$fr {
	_Translations$documents$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Our documents';
	@override String get subtitle => 'Teachings, rules, forms…';
	@override String get moreSubtitle => 'The library of the community';
	@override String get search => 'Search a document';
	@override String get all => 'All';
	@override String get empty => 'No document yet. The documents the community publishes will show here.';
	@override String get none => 'No document matches your search.';
	@override String sizeKb({required Object n}) => '${n} KB';
	@override String sizeMb({required Object n}) => '${n} MB';
	@override String get pdf => 'PDF';
	@override String get word => 'Word';
	@override String get open => 'Open the document';
	@override String get download => 'Download';
	@override String count({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: '${n} document',
		other: '${n} documents',
	);
	@override String get more => 'Show more';
}

// Path: biblePlan
class _Translations$biblePlan$en extends Translations$biblePlan$fr {
	_Translations$biblePlan$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Reading plan';
	@override String get duration => 'Length';
	@override String get months3 => '3 months';
	@override String get months6 => '6 months';
	@override String get year => '1 year';
	@override String get custom => 'Other';
	@override String unitMonths({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: 'month',
		other: 'months',
	);
	@override String get unitYear => 'year';
	@override String days({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: '${n} day',
		other: '${n} days',
	);
	@override String get scope => 'What you read';
	@override Map<String, String> get scopes => {
		'bible': 'The whole Bible',
		'newTestament': 'The New Testament',
		'oldTestament': 'The Old Testament',
		'psalmsProverbs': 'Psalms and Proverbs',
	};
	@override String chaptersShort({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: '${n} ch.',
		other: '${n} ch.',
	);
	@override String get oldTestament => 'Old Testament';
	@override String get newTestament => 'New Testament';
	@override String get order => 'Order';
	@override Map<String, String> get orders => {
		'canonical': 'Book by book',
		'parallel': 'OT + NT each day',
	};
	@override String get reminder => 'Daily reminder';
	@override String get reminderAt => 'Reminder time';
	@override String summary({required Object chapters, required Object days, required Object perDay}) => '${chapters} chapters in ${days} days, about ${perDay} a day';
	@override String chapterCount({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: '${n} chapter',
		other: '${n} chapters',
	);
	@override String inDays({required Object days}) => 'in ${days}';
	@override String perDayAbout({required Object perDay}) => 'about ${perDay} a day';
	@override String endsOn({required Object date}) => 'Ends on ${date}';
	@override String startsOn({required Object date}) => 'The plan starts on ${date}.';
	@override String get start => 'Start the plan';
	@override String dayOf({required Object day, required Object total}) => 'Day ${day} of ${total}';
	@override String get today => 'Today\'s reading';
	@override String get todayDone => 'Today\'s reading is done. Well done!';
	@override String get read => 'Read';
	@override String behind({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: '${n} day behind',
		other: '${n} days behind',
	);
	@override String get catchUp => 'Tap here to see the chapters to catch up.';
	@override String get catchUpShort => 'catch up';
	@override String chaptersRead({required Object read, required Object total}) => '${read} of ${total} chapters';
	@override String get late => 'Late';
	@override String get upcoming => 'Coming up';
	@override String dayNumber({required Object n}) => 'Day ${n}';
	@override String get finished => 'Plan finished! You read it all.';
	@override String get stop => 'Stop the plan';
	@override String get stopTitle => 'Stop this plan?';
	@override String get stopText => 'Your progress in this plan will be erased. The chapters counted in your reports stay there.';
	@override String get reminderTitle => 'Today\'s reading';
	@override String get reminderChannel => 'Reading plan';
	@override String get homeTitle => 'Today\'s reading';
	@override String check({required Object chapter}) => 'Mark ${chapter} as read';
	@override String uncheck({required Object chapter}) => '${chapter}: read';
}

// Path: teachings
class _Translations$teachings$en extends Translations$teachings$fr {
	_Translations$teachings$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Teachings';
	@override String get subtitle => 'Hear the Word wherever you are';
	@override String get search => 'Search a message, a speaker…';
	@override String get all => 'All';
	@override String get downloadedChip => 'Downloaded';
	@override String count({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: '${n} message',
		other: '${n} messages',
	);
	@override String get empty => 'No teachings yet.';
	@override String get none => 'No teaching matches.';
	@override String get noneDownloaded => 'No message downloaded. Tap a message\'s cloud to listen without network.';
	@override String get more => 'See more';
	@override String get offline => 'No network: here are the messages kept on your phone.';
	@override String get play => 'Listen';
	@override String get pause => 'Pause';
	@override String get heard => 'Heard';
	@override String get download => 'Download to listen offline';
	@override String get downloaded => 'Kept on your phone';
	@override String get removed => 'Removed from the phone';
	@override String get cancelDownload => 'Stop the download';
	@override String get removeDownload => 'Remove from the phone';
	@override String get back15 => 'Back 15 seconds';
	@override String get forward15 => 'Forward 15 seconds';
	@override String speed({required Object speed}) => 'Speed ${speed}';
	@override String recordedOn({required Object date}) => 'Message of ${date}';
	@override String get moreSubtitle => 'Sermons and teachings to listen to';
	@override String get closePlayer => 'Close the player';
}

// Path: memorize
class _Translations$memorize$en extends Translations$memorize$fr {
	_Translations$memorize$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Memorization';
	@override String get subtitle => 'Hide the Word in your heart';
	@override String get toReview => 'To review';
	@override String get learning => 'Learning';
	@override String get known => 'Known';
	@override String reviewCount({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: 'Review ${n} verse',
		other: 'Review ${n} verses',
	);
	@override String get nothingDue => 'Nothing to review today.';
	@override String nextOn({required Object date}) => 'Next review: ${date}.';
	@override String get tomorrow => 'tomorrow';
	@override String get reminder => 'Review reminder';
	@override String get reminderAt => 'Reminder time';
	@override String get myVerses => 'My verses';
	@override String get howToAdd => 'To add one: in the Bible, tap a verse, then the brain in the bar.';
	@override String get empty => 'No verse to memorize yet.';
	@override String get openBible => 'Open the Bible';
	@override String get late => 'Late';
	@override String get today => 'Today';
	@override String dueIn({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: 'In ${n} day',
		other: 'In ${n} days',
	);
	@override Map<String, String> get stages => {
		'fresh': 'New',
		'learning': 'Learning',
		'known': 'Known',
	};
	@override String stats({required Object stage, required Object lapses}) => '${stage} · forgotten ${lapses} times';
	@override String get reviewNow => 'Review now';
	@override String get remove => 'Remove';
	@override String get removeTitle => 'Remove this verse?';
	@override String get removeText => 'Its progress will be erased.';
	@override String get removed => 'Verse removed';
	@override String progress({required Object done, required Object total}) => '${done} / ${total}';
	@override String get show => 'Show the verse';
	@override Map<String, String> get hints => {
		'full': 'Text',
		'gaps': 'Gaps',
		'initials': 'Initials',
		'none': 'None',
	};
	@override String get recite => 'Recite the verse, then check.';
	@override Map<String, String> get grades => {
		'again': 'Again',
		'hard': 'Hard',
		'good': 'Good',
		'easy': 'Easy',
	};
	@override String get now => 'Right away';
	@override String later({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: '${n} day',
		other: '${n} days',
	);
	@override String get doneTitle => 'Reviews done!';
	@override String doneText({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: 'You reviewed ${n} verse. May the Word dwell in you!',
		other: 'You reviewed ${n} verses. May the Word dwell in you!',
	);
	@override String get back => 'Back';
	@override String get reminderTitle => 'Your verses to review';
	@override String reminderBody({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: '${n} verse is waiting for you today.',
		other: '${n} verses are waiting for you today.',
	);
	@override String get reminderChannel => 'Memorization';
	@override String get homeTitle => 'Verses to review';
	@override String homeText({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: '${n} verse waiting',
		other: '${n} verses waiting',
	);
	@override String get menu => 'Memorize verses';
	@override String get memorize => 'Memorize';
	@override String get added => 'Added to your verses to memorize';
	@override String get already => 'This passage is already in your verses';
}

// Path: souls
class _Translations$souls$en extends Translations$souls$fr {
	_Translations$souls$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Soul follow-up';
	@override String get subtitle => '"He who wins souls is wise." Proverbs 11:30';
	@override String get search => 'Search a person…';
	@override String get people => 'People';
	@override String get received => 'Received Jesus';
	@override String get toContact => 'To contact';
	@override String get all => 'All';
	@override Map<String, String> get stages => {
		'met': 'Met',
		'interested': 'Interested',
		'received': 'Received Jesus',
		'followUp': 'Being grounded',
		'church': 'Comes to church',
		'baptized': 'Baptized',
	};
	@override String get contactSection => 'To contact again';
	@override String get everyone => 'Everyone';
	@override String get contactToday => 'Contact today';
	@override String contactLate({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: '${n} day late',
		other: '${n} days late',
	);
	@override String contactOn({required Object date}) => 'Next contact on ${date}';
	@override String get empty => 'Note here the people you share the Gospel with: pray for them and follow them to church.';
	@override String get none => 'Nobody matches.';
	@override String get add => 'Add';
	@override String get addTitle => 'New person';
	@override String get editTitle => 'Edit';
	@override String get name => 'Name';
	@override String get nameRequired => 'Write their name.';
	@override String get phone => 'Phone';
	@override String get place => 'Where you met';
	@override String get metOn => 'Met on';
	@override String get stage => 'Where is this person?';
	@override String get firstNote => 'A note (optional)';
	@override String get noteHint => 'What was said, prayer requests…';
	@override String get save => 'Save';
	@override String get saved => 'Saved';
	@override String get call => 'Call';
	@override String get whatsApp => 'WhatsApp';
	@override String get sms => 'Text';
	@override String get edit => 'Edit';
	@override String get delete => 'Delete';
	@override String deleteTitle({required Object name}) => 'Delete ${name}?';
	@override String get deleteText => 'Their notes will be erased from your phone.';
	@override String get deleted => 'Deleted';
	@override String get nextContact => 'Next contact';
	@override String get plan => 'Plan a reminder';
	@override String get change => 'Change the date';
	@override String get clear => 'Remove the reminder';
	@override String get noContact => 'No reminder planned';
	@override String metAt({required Object date}) => 'Met on ${date}';
	@override String get notes => 'Notes';
	@override String get addNote => 'Add the note';
	@override String get noNotes => 'No notes yet.';
	@override String get deleteNote => 'Delete the note';
	@override String get export => 'Export (spreadsheet)';
	@override late final _Translations$souls$csv$en csv = _Translations$souls$csv$en._(_root);
	@override String lock({required Object method}) => 'Lock with ${method}';
	@override String get lockedTitle => 'Your soul follow-up is locked';
	@override String get unlock => 'Unlock';
	@override String get unlockReason => 'Open your soul follow-up';
	@override String get privacy => 'This information stays on your phone: it is never sent.';
	@override String get reminderTitle => 'Soul follow-up';
	@override String reminderBody({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: '${n} person to contact today.',
		other: '${n} people to contact today.',
	);
	@override String get reminderChannel => 'Soul follow-up';
	@override String get moreSubtitle => 'The people you share the Gospel with';
	@override String get prayToday => 'Today, pray for';
	@override String get prayerReminder => 'Remind me each morning';
	@override String get prayerReminderAt => 'Prayer reminder time';
	@override String get prayerTitle => 'Pray for a soul';
	@override String get prayerBody => 'Take a moment to pray for today\'s person.';
	@override String get prayerChannel => 'Prayer for souls';
}

// Path: fasts
class _Translations$fasts$en extends Translations$fasts$fr {
	_Translations$fasts$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'My fasts';
	@override String get intro => 'Set yourself apart for God: choose your fast and what you fast for. Each day kept counts in your report.';
	@override String get moreSubtitle => 'Full or partial fast, counted each day';
	@override String get kind => 'Your fast';
	@override Map<String, String> get kinds => {
		'full': 'Full fast',
		'partial': 'Partial fast',
	};
	@override Map<String, String> get kindTexts => {
		'full': 'Day and night, 24 hours a day, from now.',
		'partial': 'Each day until the time you choose, then you break the fast.',
	};
	@override String get length => 'Length';
	@override String days({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: '${n} day',
		other: '${n} days',
	);
	@override String get endEachDay => 'End of the fast each day';
	@override String get topics => 'I fast for';
	@override String get topicHint => 'A prayer request…';
	@override String get addTopic => 'Add the request';
	@override String get removeTopic => 'Remove the request';
	@override String get history => 'My last fasts';
	@override String kept({required Object kept, required Object days}) => '${kept}/${days} days';
	@override String get start => 'Start the fast';
	@override String until({required Object date}) => 'Until ${date}';
	@override String hoursLeft({required Object h, required Object m}) => '${h} h ${m}';
	@override String minutesLeft({required Object m}) => '${m} min';
	@override String dayOf({required Object day, required Object total}) => 'Day ${day} of ${total}';
	@override String dayEnds({required Object time}) => 'This day ends at ${time}';
	@override String get stop => 'Break the fast';
	@override String get stopTitle => 'Break your fast?';
	@override String get stopText => 'The days already kept stay counted. The day under way will not be.';
	@override String counted({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: '${n} day of fasting counted in your report',
		other: '${n} days of fasting counted in your report',
	);
	@override String reportNote({required Object item}) => 'Each day kept adds 1 to "${item}" in your report.';
	@override Map<String, String> get items => {
		'full': 'Full fast',
		'partial': 'Partial fast',
	};
	@override String dayTitle({required Object day}) => 'Day ${day} of fasting done';
	@override String get dayBody => 'It counts in your report. Take heart, keep going!';
	@override String get endTitle => 'Your fast is over';
	@override String get endBody => 'May the Lord answer your prayers.';
	@override String get channel => 'My fasts';
	@override String homeTitle({required Object day, required Object total}) => 'Fast · day ${day} of ${total}';
	@override String homeText({required Object time}) => 'This day ends at ${time}';
}

// Path: received
class _Translations$received$en extends Translations$received$fr {
	_Translations$received$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Reports received';
	@override String get subtitle => 'Sent by your disciples in the app';
	@override String unreadCount({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: '${n} new',
		other: '${n} new',
	);
	@override String get empty => 'No report received yet. When a disciple sends you theirs in the app, it arrives here.';
	@override String day({required Object date}) => 'On ${date}';
	@override String period({required Object from, required Object to}) => '${from} to ${to}';
	@override String get unread => 'New';
	@override String yourReply({required Object text}) => 'Your answer: “${text}”';
	@override String get open => 'View';
	@override String get encourage => 'Encourage';
	@override String get editReply => 'Edit';
	@override String encourageTitle({required Object name}) => 'A word for ${name}';
	@override List<String> get suggestions => [
		'Faithful indeed, keep going!',
		'I\'m praying for you.',
		'May God strengthen you!',
		'Well done for persevering.',
	];
	@override String get hint => 'Write your encouragement…';
	@override String get send => 'Send';
	@override String sent({required Object name}) => '${name} got your word';
}

// Path: welcome.seek
class _Translations$welcome$seek$en extends Translations$welcome$seek$fr {
	_Translations$welcome$seek$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get before => 'Seek ';
	@override String get marked => 'God';
	@override String get after => ' first, every day';
	@override String get text => 'Log your Bible reading, prayer and fasting in seconds… and watch your progress week after week.';
}

// Path: welcome.worship
class _Translations$welcome$worship$en extends Translations$welcome$worship$fr {
	_Translations$welcome$worship$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get before => 'Sing and ';
	@override String get marked => 'pray';
	@override String get after => ', wherever you are';
	@override String get text => 'Find the community\'s hymns and carry the prayer topics with your brothers and sisters every day.';
}

// Path: welcome.community
class _Translations$welcome$community$en extends Translations$welcome$community$fr {
	_Translations$welcome$community$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get before => 'Stay close to your ';
	@override String get marked => 'community';
	@override String get after => '';
	@override String get text => 'Your assembly\'s events and announcements, all in one place, so you never miss a thing.';
}

// Path: welcome.sample
class _Translations$welcome$sample$en extends Translations$welcome$sample$fr {
	_Translations$welcome$sample$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get bibleReading => 'Bible reading';
	@override String get chapters => '10 ch.';
	@override String get prayerAlone => 'Prayer alone';
	@override String get hymn => 'Hymn';
	@override String get hymnNumber => 'No. 12';
	@override String get prayerOfTheDay => 'Prayer topic of the day';
	@override String get prayerTopic => 'For our young people\'s exams';
	@override String get praying => '12 people are praying';
	@override String get iPray => 'I pray';
	@override String get retreat => 'Youth retreat';
	@override String get announcement => 'Announcement';
	@override String get announcementText => 'Sunday service starts at 8:30 am.';
}

// Path: auth.login
class _Translations$auth$login$en extends Translations$auth$login$fr {
	_Translations$auth$login$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Welcome back';
	@override String get subtitle => 'Sign in to pick up your walk with God and your community.';
	@override String get welcomeBack => 'Glad you\'re here!';
	@override String get submit => 'Sign in';
	@override String get noAccount => 'No account yet?';
	@override String get createAccount => 'Create an account';
}

// Path: auth.register
class _Translations$auth$register$en extends Translations$auth$register$fr {
	_Translations$auth$register$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String step({required Object current, required Object total}) => '${current} / ${total}';
	@override String get title => 'Create your account';
	@override String get subtitle => 'You will sign in with your phone number.';
	@override String get firstName => 'First name';
	@override String get lastName => 'Last name';
	@override String get passwordHelp => 'At least 6 characters';
	@override String get email => 'Email';
	@override String get submit => 'Continue';
	@override String get haveAccount => 'Already have an account?';
	@override String get login => 'Sign in';
	@override String get alreadyUsed => 'This phone number or email already has an account. Sign in instead.';
	@override String get emailHint => 'you@example.com';
}

// Path: auth.church
class _Translations$auth$church$en extends Translations$auth$church$fr {
	_Translations$auth$church$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Your church';
	@override String get subtitle => 'This helps your leaders find you. You can change it later.';
	@override String get editTitle => 'My profile';
	@override String get editSubtitle => 'Update your name, your church and your assembly.';
	@override String get country => 'Country';
	@override String get countryHint => 'Choose your country';
	@override String get city => 'City';
	@override String get cityHint => 'Yaoundé';
	@override String get church => 'Church';
	@override String get churchHint => 'Your church\'s name';
	@override String get assembly => 'Assembly';
	@override String get assemblyHint => 'Your assembly\'s name';
	@override String get info => 'Moved or changed assembly? You can update everything from your profile.';
	@override String get submit => 'Finish';
	@override String get skip => 'Skip this step';
	@override String get saved => 'Profile saved';
}

// Path: auth.forgot
class _Translations$auth$forgot$en extends Translations$auth$forgot$fr {
	_Translations$auth$forgot$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get link => 'Forgot your password?';
	@override String get title => 'Forgot password';
	@override String get phoneText => 'Enter your number: we\'ll text you a code to choose a new password.';
	@override String get sendCode => 'Get the code';
	@override String get codeTitle => 'Enter the code';
	@override String codeText({required Object phone}) => 'We sent a 6-digit code to ${phone}.';
	@override String get code => 'Code received by text';
	@override String get codeInvalid => 'The code has 6 digits';
	@override String get verify => 'Verify';
	@override String get resend => 'Send the code again';
	@override String resendIn({required Object seconds}) => 'Send again in ${seconds} s';
	@override String get changeNumber => 'Change number';
	@override String get passwordTitle => 'New password';
	@override String get passwordText => 'Choose a new password for your account.';
	@override String get submit => 'Save and sign in';
	@override String get done => 'Password changed. Welcome back!';
	@override String get remembered => 'Remember it?';
	@override String get invalidCode => 'That code isn\'t right.';
	@override String get expired => 'The code expired. Ask for a new one.';
	@override String get tooManyRequests => 'Too many attempts. Try again in a while.';
	@override String get unavailable => 'Resetting the password isn\'t available right now.';
	@override String get noAccount => 'No account uses this number.';
}

// Path: auth.biometric
class _Translations$auth$biometric$en extends Translations$auth$biometric$fr {
	_Translations$auth$biometric$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get faceId => 'Face ID';
	@override String get touchId => 'Touch ID';
	@override String get fingerprint => 'your fingerprint';
	@override String get face => 'your face';
	@override String signIn({required Object method}) => 'Sign in with ${method}';
	@override String askTitle({required Object method}) => 'Sign in with ${method}?';
	@override String get askText => 'Next time, no need to type your password: it stays in your phone\'s secure vault.';
	@override String get enable => 'Turn on';
	@override String get later => 'Later';
	@override String get reason => 'Sign in to CMFI Connect';
	@override String get enableReason => 'Turn on quick sign-in to CMFI Connect';
	@override String changed({required Object method}) => 'Your password has changed: sign in with your password, then turn ${method} on again.';
	@override String settings({required Object method}) => 'Sign in with ${method}';
	@override String get settingsText => 'Without typing your password';
	@override String get passwordTitle => 'Your password';
	@override String get passwordLabel => 'Password';
	@override String get confirm => 'Confirm';
	@override String enabled({required Object method}) => 'Sign-in with ${method} is on';
}

// Path: reports.tabs
class _Translations$reports$tabs$en extends Translations$reports$tabs$fr {
	_Translations$reports$tabs$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get today => 'Today';
	@override String get history => 'History';
	@override String get summary => 'Summary';
}

// Path: reports.measure
class _Translations$reports$measure$en extends Translations$reports$measure$fr {
	_Translations$reports$measure$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String quantity({required Object unit}) => '${unit}';
	@override String get duration => 'duration';
	@override String both({required Object unit}) => '${unit} and duration';
	@override String get quantityNoUnit => 'quantity';
	@override String get bothNoUnit => 'quantity and duration';
}

// Path: reports.sheet
class _Translations$reports$sheet$en extends Translations$reports$sheet$fr {
	_Translations$reports$sheet$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get quantity => 'Quantity';
	@override String get duration => 'Duration';
	@override String get minus1 => '− 1 min';
	@override String get plus1 => '+ 1 min';
	@override String get removeMinute => 'Remove one minute';
	@override String get addMinute => 'Add one minute';
	@override String get holdToRepeat => 'Hold to go faster';
	@override String get decrease => 'Decrease';
	@override String get increase => 'Increase';
	@override String get clear => 'Clear';
	@override String get validate => 'Done';
}

// Path: reports.history
class _Translations$reports$history$en extends Translations$reports$history$fr {
	_Translations$reports$history$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String daysFilled({required Object filled, required Object total}) => '${filled} days filled in out of ${total}';
	@override String get legendFilled => 'Filled in';
	@override String get legendMissing => 'No report';
	@override String get none => 'No report';
	@override String get fill => 'Fill in';
	@override String get inProgress => 'In progress';
	@override String get previousMonth => 'Previous month';
	@override String get nextMonth => 'Next month';
	@override String get today => 'today';
}

// Path: reports.summary
class _Translations$reports$summary$en extends Translations$reports$summary$fr {
	_Translations$reports$summary$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get week => 'Week';
	@override String get month => 'Month';
	@override String get year => 'Year';
	@override String range({required Object from, required Object to}) => 'From ${from} to ${to}';
	@override String get regularity => 'Regularity';
	@override String get daysFilled => 'days filled in';
	@override String missingDays({required num n, required Object days}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: '${n} day without a report: the ${days}',
		other: '${n} days without a report: the ${days}',
	);
	@override String missingCount({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: '${n} day without a report',
		other: '${n} days without a report',
	);
	@override String get noMissing => 'No day missed, well done!';
	@override String perDay({required Object value}) => '${value} per day filled in';
	@override String days({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: '${n} day',
		other: '${n} days',
	);
	@override String get notFilled => 'Not filled in yet';
	@override String barsCaption({required Object max}) => 'Per day · highest bar: ${max}';
	@override String barsCaptionMonthly({required Object max}) => 'Per month · highest bar: ${max}';
	@override String get empty => 'No report for this period.';
	@override String goalDays({required num n, required Object total}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: 'Goal reached on ${n} day out of ${total}',
		other: 'Goal reached on ${n} days out of ${total}',
	);
	@override String get share => 'Share this summary';
	@override String get goals => 'Goals';
	@override String get goalsAverage => 'Average completion of your goals';
	@override String get goalsHint => 'Every day counts, even an empty one. Today counts once filled in.';
	@override String get evolution => 'How your goals progress';
	@override String get evolutionHint => 'Week after week, over the last 12.';
	@override String get premiumYear => 'The year and the progress of your goals come with Premium.';
}

// Path: reports.standardItems
class _Translations$reports$standardItems$en extends Translations$reports$standardItems$fr {
	_Translations$reports$standardItems$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get lb => 'Bible reading';
	@override String get ps => 'Personal prayer';
	@override String get rdqad => 'Meditation';
	@override String get pg => 'Group prayer';
	@override String get llc => 'Christian literature reading';
	@override String get jc => 'Full fast';
	@override String get jp => 'Partial fast';
	@override String get dimes => 'Tithes';
	@override String get off => 'Offerings';
}

// Path: reports.units
class _Translations$reports$units$en extends Translations$reports$units$fr {
	_Translations$reports$units$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override late final _Translations$reports$units$chapters$en chapters = _Translations$reports$units$chapters$en._(_root);
	@override late final _Translations$reports$units$times$en times = _Translations$reports$units$times$en._(_root);
	@override late final _Translations$reports$units$pages$en pages = _Translations$reports$units$pages$en._(_root);
	@override late final _Translations$reports$units$percent$en percent = _Translations$reports$units$percent$en._(_root);
}

// Path: reports.timer
class _Translations$reports$timer$en extends Translations$reports$timer$fr {
	_Translations$reports$timer$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get start => 'Start the stopwatch';
	@override String get running => 'Stopwatch running';
	@override String get startEnd => 'Start – end';
	@override String get from => 'Start time';
	@override String get to => 'End time';
	@override String span({required Object from, required Object to}) => 'From ${from} to ${to}';
	@override String get pause => 'Pause';
	@override String get resume => 'Resume';
	@override String get finish => 'Finish';
	@override String get discard => 'Cancel the stopwatch';
	@override String get paused => 'Paused';
	@override String added({required Object time, required Object item}) => '${time} added to "${item}"';
	@override String get noItem => 'The stopwatch stopped, but this item is no longer in your report.';
	@override String get replaceTitle => 'Replace the stopwatch?';
	@override String replaceText({required Object item}) => 'A stopwatch is already running for "${item}". It will stop without being counted.';
	@override String get replace => 'Replace';
	@override String get channel => 'Running stopwatch';
	@override String get ongoingBody => 'Tap to pause or finish';
	@override String get pickButton => 'Start a stopwatch';
	@override String get pickTitle => 'What do you want to time?';
	@override String get pickHint => 'When you finish, the minutes are added to today\'s report by themselves.';
	@override String get pickEmpty => 'None of the items of your report is counted in time.';
	@override String todayMinutes({required Object time}) => '${time} today';
	@override String get notYet => 'Not yet today';
}

// Path: export.doc
class _Translations$export$doc$en extends Translations$export$doc$fr {
	_Translations$export$doc$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Daily report';
	@override String get regularity => 'Regularity';
	@override String daysFilled({required num filled, required Object total}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(filled,
		one: '${filled} day filled out of ${total}',
		other: '${filled} days filled out of ${total}',
	);
	@override String get totals => 'Over the period';
	@override String get item => 'Item';
	@override String get total => 'Total';
	@override String get days => 'Days';
	@override String get average => 'Average / day filled';
	@override String get goal => 'Goal reached';
	@override String get detail => 'Day by day';
	@override String get date => 'Date';
	@override String get values => 'Filled in';
	@override String get note => 'Note';
	@override String get noReport => 'No report';
	@override String generated({required Object date}) => 'Made on ${date} with CMFI Connect';
	@override String page({required Object n, required Object total}) => 'Page ${n} / ${total}';
	@override String get filledColumn => 'Report';
	@override String get yes => 'yes';
	@override String get no => 'no';
	@override String get sentFrom => 'Sent from CMFI Connect';
}

// Path: items.measure
class _Translations$items$measure$en extends Translations$items$measure$fr {
	_Translations$items$measure$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String quantity({required Object unit}) => 'Quantity · ${unit}';
	@override String get quantityNoUnit => 'Quantity';
	@override String get duration => 'Duration';
	@override String both({required Object unit}) => 'Quantity (${unit}) and duration';
	@override String get bothNoUnit => 'Quantity and duration';
}

// Path: authorities.form
class _Translations$authorities$form$en extends Translations$authorities$form$fr {
	_Translations$authorities$form$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'New leader';
	@override String get emailHint => 'name@example.com';
	@override String get isDiscipleMaker => 'This is my disciple maker';
	@override String get isDiscipleMakerHelp => 'The person who mentors you personally. You only have one.';
	@override String discipleMakerTaken({required Object name}) => '${name} is already your disciple maker. Remove them from the list to choose someone else.';
	@override String get submit => 'Add';
	@override String added({required Object name}) => '${name} is now one of your leaders.';
	@override String get searchLabel => 'Their username';
	@override String get searchHint => 'username';
	@override String get search => 'Search';
	@override String get searchHelp => 'If they use CMFI Connect, find them by their username. They will get your request, and their contact details will show once they accept.';
	@override String notFound({required Object username}) => 'Nobody has the username @${username}.';
	@override String get invite => 'Invite them to join CMFI Connect';
	@override String get inviteText => 'Hello! I use CMFI Connect to keep track of my walk with God, and I\'d like you to accompany me. Install the app, create your account, then send me your username so I can add you.';
	@override String inviteMine({required Object username}) => 'My username: @${username}';
	@override String get manual => 'Not on the app? Enter their details';
	@override String get backToSearch => 'Search by username instead';
	@override String get request => 'Send the request';
	@override String requested({required Object name}) => 'Request sent to ${name}.';
	@override String get alreadyAdded => 'This person is already one of your authorities.';
	@override String get makerExists => 'You already have a disciple maker.';
	@override String get yourself => 'This is your own username.';
	@override String sharingHelp({required Object name}) => '${name} will see your reports: the items filled in, your regularity and your percentages, never your note. You can stop it on their card.';
}

// Path: authorities.sharing
class _Translations$authorities$sharing$en extends Translations$authorities$sharing$fr {
	_Translations$authorities$sharing$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Share my reports';
	@override String help({required Object name}) => '${name} sees your reports: the items filled in, your regularity and your percentages, never your note.';
	@override String on({required Object name}) => 'Your reports are shared with ${name}.';
	@override String off({required Object name}) => '${name} no longer sees your reports.';
}

// Path: members.deleteAccount
class _Translations$members$deleteAccount$en extends Translations$members$deleteAccount$fr {
	_Translations$members$deleteAccount$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get button => 'Delete my account';
	@override String get title => 'Delete my account';
	@override String get intro => 'This is permanent. Your account and everything linked to it will be erased:';
	@override String get itemProfile => 'your profile, photo, username and password';
	@override String get itemReports => 'all your reports, items and goals';
	@override String get itemAuthorities => 'your spiritual authorities and the requests you received';
	@override String get itemEvents => 'your event registrations';
	@override String get itemPrayer => 'your prayer lists, retreats and importunity topics';
	@override String get kept => 'Events, news, photos and prayer topics you published as an admin stay for the community, without your name.';
	@override String get passwordHelp => 'To confirm it\'s really you.';
	@override String get confirm => 'Delete for good';
	@override String get done => 'Your account has been deleted. God bless you!';
	@override String get wrongPassword => 'Wrong password.';
	@override String get lastSuperadmin => 'You are the only superadmin: give this role to someone else before deleting your account.';
}

// Path: hymns.tabs
class _Translations$hymns$tabs$en extends Translations$hymns$tabs$fr {
	_Translations$hymns$tabs$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get all => 'All';
	@override String get favorites => 'Favorites';
	@override String get recent => 'Recent';
}

// Path: hymns.reader
class _Translations$hymns$reader$en extends Translations$hymns$reader$fr {
	_Translations$hymns$reader$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get smaller => 'Smaller text';
	@override String get larger => 'Larger text';
	@override String get display => 'Display';
	@override String get textSize => 'Text size';
	@override String get typeface => 'Font';
	@override String get typefaceAuto => 'Auto';
	@override String get typefaceSans => 'Modern';
	@override String get typefaceSerif => 'Classic';
	@override String get typefaceAutoHelp => 'Classic when the text is large';
	@override String get background => 'Background';
	@override String get themeAuto => 'Auto';
	@override String get themeLight => 'Light';
	@override String get themeSepia => 'Sepia';
	@override String get themeDark => 'Dark';
	@override String get repeatChorus => 'Repeat the chorus after each verse';
	@override String get keepScreenOn => 'Keep the screen on';
	@override String get addFavorite => 'Add to favorites';
	@override String get removeFavorite => 'Remove from favorites';
	@override String get favoriteAdded => 'Added to favorites';
	@override String get favoriteRemoved => 'Removed from favorites';
	@override String get more => 'More options';
	@override String get copy => 'Copy the words';
	@override String get copied => 'Words copied';
	@override String get project => 'Projection mode';
	@override String get pinchHint => 'Pinch the screen to make the text bigger or smaller.';
	@override String get notFound => 'This hymn is no longer in the book.';
	@override String get share => 'Share the lyrics';
}

// Path: hymns.projection
class _Translations$hymns$projection$en extends Translations$hymns$projection$fr {
	_Translations$hymns$projection$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get exit => 'Leave projection mode';
	@override String get previous => 'Previous stanza';
	@override String get next => 'Next stanza';
	@override String position({required Object current, required Object total}) => '${current} / ${total}';
	@override String get hint => 'Tap on the right to go on, on the left to go back.';
}

// Path: hymns.pad
class _Translations$hymns$pad$en extends Translations$hymns$pad$fr {
	_Translations$hymns$pad$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Go to hymn';
	@override String get open => 'Open';
	@override String get erase => 'Erase';
	@override String notFound({required Object number}) => 'No hymn No. ${number} in this book';
	@override String get placeholder => 'Type a number';
}

// Path: events.tabs
class _Translations$events$tabs$en extends Translations$events$tabs$fr {
	_Translations$events$tabs$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get program => 'Program';
	@override String get news => 'News';
	@override String get info => 'Info';
	@override String get photos => 'Photos';
}

// Path: events.register
class _Translations$events$register$en extends Translations$events$register$fr {
	_Translations$events$register$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get cta => 'I\'m coming';
	@override String get title => 'I\'m coming';
	@override String get people => 'How many of you?';
	@override String get peopleHint => 'You included, with your family or group.';
	@override String get less => 'One person less';
	@override String get more => 'One person more';
	@override String get lodging => 'I need accommodation';
	@override String get lodgingHint => 'The organizers plan the beds.';
	@override String get departure => 'Departure city';
	@override String get departureHint => 'E.g. Douala';
	@override String get confirm => 'Confirm my registration';
	@override String get update => 'Update';
	@override String get cancel => 'Cancel my registration';
	@override String get done => 'Done, you\'re registered! We\'ll remind you the day before.';
	@override String get updated => 'Your registration is up to date.';
	@override String get cancelled => 'Your registration is cancelled.';
	@override String get edit => 'Change';
	@override String get youAre => 'You\'re registered';
	@override String get cancelTitle => 'Cancel your registration?';
	@override String get cancelText => 'Your seat will go to someone else.';
	@override String get keep => 'Keep my seat';
	@override String get lodgingShort => 'accommodation';
}

// Path: events.reminder
class _Translations$events$reminder$en extends Translations$events$reminder$fr {
	_Translations$events$reminder$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get channel => 'Event reminders';
	@override String tomorrow({required Object title}) => 'Tomorrow: ${title}';
	@override String soon({required Object title}) => 'In 1 h: ${title}';
}

// Path: events.admin
class _Translations$events$admin$en extends Translations$events$admin$fr {
	_Translations$events$admin$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Manage events';
	@override String get create => 'Create an event';
	@override String get edit => 'Edit the event';
	@override String get empty => 'No event yet. Create the first one!';
	@override String get poster => 'Poster';
	@override String get posterAdd => 'Choose a poster';
	@override String get posterChange => 'Change the poster';
	@override String get posterRemove => 'Remove the poster';
	@override String get posterHint => 'Portrait 4:5 recommended (1080 × 1350), JPEG or PNG.';
	@override String get uploading => 'Sending the image…';
	@override String get general => 'The event';
	@override String get titleField => 'Title';
	@override String get titleHint => 'E.g. Annual conference 2026';
	@override String get titleRequired => 'Give the event a title.';
	@override String get theme => 'Theme';
	@override String get themeHint => 'E.g. Walking in the Spirit';
	@override String get verse => 'Theme verse';
	@override String get description => 'Presentation';
	@override String get when => 'Dates';
	@override String get starts => 'Start';
	@override String get ends => 'End';
	@override String get endsBeforeStart => 'The end must come after the start.';
	@override String timeZone({required Object zone}) => 'Times of the venue (${zone}).';
	@override String get where => 'Venue';
	@override String get venue => 'Venue';
	@override String get venueHint => 'E.g. Mvolyé conference center';
	@override String get address => 'Address';
	@override String get city => 'City';
	@override String get country => 'Country';
	@override String get mapsUrl => 'Google Maps link';
	@override String get registration => 'Registration';
	@override String get registrationOpen => 'Registration open';
	@override String get deadline => 'Deadline';
	@override String get noDeadline => 'No deadline';
	@override String get capacity => 'Seats';
	@override String get capacityHint => 'Empty: no limit';
	@override String get asksLodging => 'Ask who needs accommodation';
	@override String get asksDeparture => 'Ask the departure city';
	@override String get fees => 'Fees';
	@override String get feesHint => 'E.g. Free entry. Meals: 2,000 FCFA a day.';
	@override String get contact => 'Contact';
	@override String get contactName => 'Contact name';
	@override String get contactPhone => 'Contact phone';
	@override String get visibility => 'Visibility';
	@override String get statusDraft => 'Draft';
	@override String get statusDraftHint => 'Only the admins see it';
	@override String get statusPublished => 'Published';
	@override String get statusPublishedHint => 'The whole community sees it';
	@override String get statusCancelled => 'Cancelled';
	@override String get statusCancelledHint => 'Shown as cancelled, no registration';
	@override String get saved => 'Event saved.';
	@override String get menu => 'Manage';
	@override String get program => 'Program';
	@override String get registrants => 'Registered';
	@override String get post => 'Post news';
	@override String get photos => 'Add photos';
	@override String get nextEdition => 'Prepare the next edition';
	@override String get delete => 'Delete the event';
	@override String get deleteTitle => 'Delete this event?';
	@override String get deleteText => 'Its registrations, news and photos will be deleted too.';
	@override String get deleteConfirm => 'Delete';
	@override String get deleted => 'Event deleted.';
	@override String get nextEditionTitle => 'Prepare the next edition?';
	@override String get nextEditionText => 'A draft is created one year later, with the same venue and program. You can adjust everything before publishing it.';
	@override String get nextEditionConfirm => 'Prepare';
	@override String get nextEditionDone => 'The next edition is ready as a draft.';
	@override String get programEmpty => 'Add the moments of the event: welcome, services, teachings, prayer night…';
	@override String get addSession => 'Add a moment';
	@override String get editSession => 'Edit this moment';
	@override String get sessionTitle => 'Title';
	@override String get sessionTitleHint => 'E.g. Opening service';
	@override String get speaker => 'Speaker';
	@override String get place => 'Room';
	@override String get day => 'Day';
	@override String get from => 'From';
	@override String get to => 'To';
	@override String get hymns => 'Hymns';
	@override String get hymnsHint => 'Numbers, e.g. 12, 45';
	@override String get removeSession => 'Remove';
	@override String get saveProgram => 'Save the program';
	@override String get programSaved => 'Program saved.';
	@override String get registrantsEmpty => 'Nobody has registered yet.';
	@override String get totalRegistrations => 'Registrations';
	@override String get totalPeople => 'People';
	@override String get totalLodging => 'To house';
	@override String get byCity => 'By departure city';
	@override String get list => 'List';
	@override String get exportCsv => 'Export the list (CSV)';
	@override String get csvHeader => 'Name,Username,Phone,Church,Assembly,People,Accommodation,Departure city,Registered on';
	@override String get yes => 'yes';
	@override String get no => 'no';
	@override String get postBody => 'Message';
	@override String get postBodyHint => 'E.g. Registration is open!';
	@override String get postImage => 'Add an image';
	@override String get postPinned => 'Pin to the top';
	@override String get postSend => 'Post';
	@override String get postDone => 'News posted.';
	@override String get postDelete => 'Delete this news';
	@override String get postDeleted => 'News deleted.';
	@override String photosAdded({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: '${n} photo added.',
		other: '${n} photos added.',
	);
	@override String photosSending({required Object done, required Object total}) => 'Sending the photos (${done}/${total})…';
	@override String get photoDelete => 'Delete this photo';
	@override String get photoDeleted => 'Photo deleted.';
	@override String get confirmDelete => 'Delete';
}

// Path: ministry.goals
class _Translations$ministry$goals$en extends Translations$ministry$goals$fr {
	_Translations$ministry$goals$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override late final _Translations$ministry$goals$crusade$en crusade = _Translations$ministry$goals$crusade$en._(_root);
	@override late final _Translations$ministry$goals$disciples$en disciples = _Translations$ministry$goals$disciples$en._(_root);
	@override late final _Translations$ministry$goals$revival$en revival = _Translations$ministry$goals$revival$en._(_root);
}

// Path: ministry.lives
class _Translations$ministry$lives$en extends Translations$ministry$lives$fr {
	_Translations$ministry$lives$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override late final _Translations$ministry$lives$founder$en founder = _Translations$ministry$lives$founder$en._(_root);
	@override late final _Translations$ministry$lives$leader$en leader = _Translations$ministry$lives$leader$en._(_root);
}

// Path: prayer.hero
class _Translations$prayer$hero$en extends Translations$prayer$hero$fr {
	_Translations$prayer$hero$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String now({required Object retreat}) => '${retreat} · now';
	@override String get title => '15 minutes\nwith the Lord';
	@override Map<String, String> get preview => {
		'morning': 'Give thanks, consecrate your day, your work, your family…',
		'noon': 'Your assembly, your leaders, 5 people from your list, the nations…',
		'evening': 'Your prayer life, your ministry, your fellow workers…',
		'night': 'The sick, the Gospel among the nations, protection for the night…',
	};
	@override String get meta => '15 points · 1 min each';
	@override String get start => 'Start';
	@override String get allDone => 'All 4 retreats of the day are done. May God answer!';
	@override String doneNow({required Object retreat, required Object next}) => '${retreat} done. Next: ${next}';
}

// Path: prayer.today
class _Translations$prayer$today$en extends Translations$prayer$today$fr {
	_Translations$prayer$today$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get toPray => 'To pray';
	@override String week({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		zero: 'No retreat this week',
		one: '${n} retreat this week',
		other: '${n} retreats this week',
	);
}

// Path: prayer.routine
class _Translations$prayer$routine$en extends Translations$prayer$routine$fr {
	_Translations$prayer$routine$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Your daily routine';
	@override String count({required Object done}) => '${done} of 4';
	@override String days({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: '${n} day out of 7',
		other: '${n} days out of 7',
	);
	@override String week({required Object time}) => '${time} this week';
	@override String get done => 'Done · 15 min';
	@override String get now => 'Now · 15 min';
	@override String get next => 'Up next · 15 min';
	@override String reminder({required Object time}) => 'Reminder at ${time}';
	@override Map<String, String> get later => {
		'morning': 'In the morning · 15 min',
		'noon': 'At noon · 15 min',
		'evening': 'In the evening · 15 min',
		'night': 'At night · 15 min',
	};
}

// Path: prayer.reminders
class _Translations$prayer$reminders$en extends Translations$prayer$reminders$fr {
	_Translations$prayer$reminders$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Retreat reminders';
	@override String get intro => 'A reminder at the time of each retreat, only if it isn\'t done yet.';
	@override String get off => 'Off';
	@override String get channel => 'Prayer retreats';
	@override String get body => '15 minutes with the Lord.';
}

// Path: prayer.retreat
class _Translations$prayer$retreat$en extends Translations$prayer$retreat$fr {
	_Translations$prayer$retreat$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => '15-minute retreats';
	@override Map<String, String> get hours => {
		'morning': 'When you wake up',
		'noon': 'Between 12 and 2 pm',
		'evening': 'Late afternoon',
		'night': 'Before you sleep',
	};
	@override String reminderAt({required Object time}) => 'reminder at ${time}';
	@override String get intro => '15 points, one minute each. A soft sound moves you to the next one.';
	@override String get done => 'Done today';
	@override String get start => 'Start · 15 min';
	@override String get selfPaced => 'Read at my own pace, no timer';
	@override late final _Translations$prayer$retreat$hints$en hints = _Translations$prayer$retreat$hints$en._(_root);
}

// Path: prayer.session
class _Translations$prayer$session$en extends Translations$prayer$session$fr {
	_Translations$prayer$session$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String point({required Object n}) => 'Point ${n} of 15';
	@override String get remaining => 'left';
	@override String get paused => 'paused';
	@override String inYourList({required Object list}) => 'In your list · ${list}';
	@override String get tomorrow => 'Tomorrow, the next ones.';
	@override String get footer => 'Screen stays on · a soft sound every minute';
	@override String get previous => 'Previous point';
	@override String get next => 'Next point';
	@override String get pause => 'Pause';
	@override String get resume => 'Resume';
	@override String get soundOn => 'Sound on';
	@override String get soundOff => 'Sound off';
	@override String get finish => 'Finish the retreat';
	@override String get quitTitle => 'Stop the retreat?';
	@override String get quitText => 'It won\'t be counted in your day.';
	@override String get quit => 'Stop';
	@override String get keepPraying => 'Keep praying';
	@override String get voiceOff => 'Read aloud';
	@override String get voiceOn => 'Reading aloud';
}

// Path: prayer.done
class _Translations$prayer$done$en extends Translations$prayer$done$fr {
	_Translations$prayer$done$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String title({required Object retreat}) => '${retreat} finished';
	@override String get text => '15 minutes with the Lord.\nHe heard every one of your prayers.';
	@override String get report => 'Added to your report';
	@override String reportDetail({required Object added, required Object total}) => 'Prayer alone: +${added} min · ${total} min today';
	@override String get undo => 'Undo';
	@override String get undone => 'Retreat removed from your day.';
	@override String get today => 'Today';
	@override String count({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: '${n} retreat of 4',
		other: '${n} retreats of 4',
	);
	@override String get verse => '“Pray without ceasing.”';
	@override String get reference => '1 Thessalonians 5:17';
	@override String get finish => 'Finish';
	@override String get hymn => 'Sing a hymn';
}

// Path: prayer.topics
class _Translations$prayer$topics$en extends Translations$prayer$topics$fr {
	_Translations$prayer$topics$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Community topics';
	@override String get all => 'See all';
	@override String get empty => 'No topic at the moment. The leaders will publish the next ones here.';
	@override Map<String, String> get categories => {
		'church': 'Church',
		'nations': 'Nations',
		'sick': 'The sick',
		'event': 'Event',
		'fasting': 'Fasting',
		'other': 'Topic',
	};
	@override String until({required Object date}) => 'until ${date}';
	@override String documentSize({required Object kb}) => '${kb} KB';
	@override String get archive => 'Past topics';
	@override String get archiveEmpty => 'No past topic.';
	@override String get current => 'At the moment';
	@override String get download => 'Download the PDF';
	@override String get noDocument => 'No PDF';
	@override String get openDocument => 'Open the PDF';
}

// Path: prayer.lists
class _Translations$prayer$lists$en extends Translations$prayer$lists$fr {
	_Translations$prayer$lists$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'My prayer lists';
	@override String get private => 'Only for you';
	@override Map<String, String> get names => {
		'unbelievers': 'Not yet believed',
		'believers': 'Believers',
		'backsliders': 'Backsliders',
		'coworkers': 'Fellow workers',
	};
	@override Map<String, String> get uses => {
		'unbelievers': 'The noon retreat prays every day for 10 people of this list (5 + 5), in turn.',
		'believers': 'The noon retreat prays every day for 5 people of this list, in turn.',
		'backsliders': 'The noon retreat prays every day for 5 people of this list, in turn.',
		'coworkers': 'The evening retreat prays every day for 10 of your fellow workers (5 + 5), in turn.',
	};
	@override String get privateNote => 'Only you can see it.';
	@override String count({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		zero: 'Nobody',
		one: '${n} person',
		other: '${n} people',
	);
	@override String get empty => 'Nobody yet. Add the people you pray for.';
	@override String get add => 'Add a person';
	@override String get prayedToday => 'Today';
	@override String get next => 'Coming up';
	@override Map<String, String> get answeredTitle => {
		'unbelievers': 'Believed in the Lord',
		'believers': 'Answered prayers',
		'backsliders': 'Came back to the Lord',
		'coworkers': 'Answered prayers',
	};
	@override late final _Translations$prayer$lists$answeredOn$en answeredOn = _Translations$prayer$lists$answeredOn$en._(_root);
	@override Map<String, String> get markAnswered => {
		'unbelievers': 'Believed in the Lord!',
		'believers': 'Prayer answered',
		'backsliders': 'Came back to the Lord!',
		'coworkers': 'Prayer answered',
	};
	@override String get answeredToast => 'Glory to God!';
	@override String get putBack => 'Put back in the list';
	@override String answeredBanner({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: '${n} prayer answered this month',
		other: '${n} prayers answered this month',
	);
	@override String lastAnswered({required Object name, required Object what}) => '${name}: ${what}';
	@override late final _Translations$prayer$lists$sheet$en sheet = _Translations$prayer$lists$sheet$en._(_root);
	@override String get addShort => 'Add';
}

// Path: prayer.importunity
class _Translations$prayer$importunity$en extends Translations$prayer$importunity$fr {
	_Translations$prayer$importunity$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Importunity topics';
	@override String get newTopic => 'New topic';
	@override String get intro => 'A topic you bring before the Lord without growing weary, until the answer comes. Set a number of proclamations and invite your brothers and sisters to pray with you.';
	@override String invitedBy({required Object name}) => '${name} invites you to pray';
	@override String get join => 'I\'ll pray with you';
	@override String get decline => 'Not now';
	@override String get joined => 'You now pray for this topic.';
	@override String progress({required Object total, required Object goal}) => '${total} of ${goal}';
	@override String total({required num n, required Object count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: '${count} proclamation',
		other: '${count} proclamations',
	);
	@override String get reached => 'Goal reached!';
	@override String get closed => 'Closed';
	@override String participants({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: '${n} prays',
		other: '${n} pray',
	);
	@override String mine({required Object n}) => 'You: ${n}';
	@override String get tapHint => 'Tap at each proclamation';
	@override String get addMany => 'Add a number';
	@override String get addManyTitle => 'How many proclamations?';
	@override String get addManyLabel => 'Proclamations';
	@override String get add => 'Add';
	@override String pending({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: '${n} waiting to be sent',
		other: '${n} waiting to be sent',
	);
	@override String get invite => 'Invite';
	@override String get members => 'Praying';
	@override String waiting({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: '${n} invitation waiting',
		other: '${n} invitations waiting',
	);
	@override String get edit => 'Edit';
	@override String get close => 'Close the topic';
	@override String get reopen => 'Reopen the topic';
	@override String get delete => 'Delete the topic';
	@override String get deleteTitle => 'Delete this topic?';
	@override String get deleteText => 'It disappears for everyone praying with you.';
	@override String get leave => 'Leave this topic';
	@override String get leaveTitle => 'Leave this topic?';
	@override String get leaveText => 'Your proclamations stay in the total.';
	@override late final _Translations$prayer$importunity$form$en form = _Translations$prayer$importunity$form$en._(_root);
	@override late final _Translations$prayer$importunity$inviteSheet$en inviteSheet = _Translations$prayer$importunity$inviteSheet$en._(_root);
	@override String get eyebrow => 'Importunity topic';
	@override String get proclaim => 'Proclaim';
	@override String get timer => 'Time my prayer';
	@override String get timeLabel => 'Prayer time for this topic';
	@override String mineTime({required Object n, required Object time}) => 'You: ${n} · ${time} of prayer';
	@override String get timerNote => 'The time is added to "Personal prayer" in your report.';
}

// Path: streak.lines
class _Translations$streak$lines$en extends Translations$streak$lines$fr {
	_Translations$streak$lines$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get week => 'A whole week with the Lord, day after day. Well done, keep going!';
	@override String get month => 'A month of faithfulness! What you sow each day bears fruit.';
	@override String get hundred => 'A hundred days with God! Your perseverance is a beautiful testimony.';
	@override String get year => 'A whole year with God! Glory to Him for your faithfulness.';
}

// Path: blocking.reasons
class _Translations$blocking$reasons$en extends Translations$blocking$reasons$fr {
	_Translations$blocking$reasons$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get spam => 'Unwanted';
	@override String get offensive => 'Shocking or offensive content';
	@override String get other => 'Other';
}

// Path: bible.colors
class _Translations$bible$colors$en extends Translations$bible$colors$fr {
	_Translations$bible$colors$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get yellow => 'yellow';
	@override String get green => 'green';
	@override String get blue => 'blue';
	@override String get pink => 'pink';
}

// Path: seekFirst.shield
class _Translations$seekFirst$shield$en extends Translations$seekFirst$shield$fr {
	_Translations$seekFirst$shield$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Seek God first';
	@override String subtitle({required Object app}) => '${app} stays closed until today\'s report.';
	@override String get thisApp => 'This app';
	@override String get fill => 'Fill in my report';
	@override String pause({required Object n}) => '5-min break (${n}/3)';
	@override String get notificationTitle => 'Seek God first';
	@override String get notificationBody => 'Tap here to fill in your report.';
	@override String get serviceBody => 'Your apps close each day until your report.';
}

// Path: souls.csv
class _Translations$souls$csv$en extends Translations$souls$csv$fr {
	_Translations$souls$csv$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get name => 'Name';
	@override String get phone => 'Phone';
	@override String get place => 'Place';
	@override String get metOn => 'Met on';
	@override String get stage => 'Stage';
	@override String get next => 'Next contact';
	@override String get notes => 'Notes';
}

// Path: reports.units.chapters
class _Translations$reports$units$chapters$en extends Translations$reports$units$chapters$fr {
	_Translations$reports$units$chapters$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get name => 'Number of chapters';
	@override String get label => 'chapters';
	@override String get symbol => 'chapters';
	@override String count({required num n, required Object value}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: '${value} chapter',
		other: '${value} chapters',
	);
}

// Path: reports.units.times
class _Translations$reports$units$times$en extends Translations$reports$units$times$fr {
	_Translations$reports$units$times$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get name => 'Number of times';
	@override String get label => 'times';
	@override String get symbol => 'times';
	@override String count({required num n, required Object value}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: '${value} time',
		other: '${value} times',
	);
}

// Path: reports.units.pages
class _Translations$reports$units$pages$en extends Translations$reports$units$pages$fr {
	_Translations$reports$units$pages$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get name => 'Number of pages';
	@override String get label => 'pages';
	@override String get symbol => 'pages';
	@override String count({required num n, required Object value}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: '${value} page',
		other: '${value} pages',
	);
}

// Path: reports.units.percent
class _Translations$reports$units$percent$en extends Translations$reports$units$percent$fr {
	_Translations$reports$units$percent$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get name => 'Percentage';
	@override String get label => 'percentage';
	@override String get symbol => '%';
	@override String count({required Object value}) => '${value}%';
}

// Path: ministry.goals.crusade
class _Translations$ministry$goals$crusade$en extends Translations$ministry$goals$crusade$fr {
	_Translations$ministry$goals$crusade$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'The Every-Creature Gospel Crusade';
	@override String get text => 'To preach the gospel to everyone who will live in our generation, so that 10 billion people are reached with the gospel preached in the power of the Holy Spirit, using every means of communication (our books, tracts, magazines, CDs, DVDs, radio, television and the Internet) in the most urgent way possible.';
	@override String get reached => 'people reached with the gospel';
}

// Path: ministry.goals.disciples
class _Translations$ministry$goals$disciples$en extends Translations$ministry$goals$disciples$fr {
	_Translations$ministry$goals$disciples$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Making disciples';
	@override String get text => 'To bring 1 billion people in 250 nations to know Jesus Christ as Lord and Saviour, to make them disciples who obey him in all things, and to organize them to meet in 25 million house churches by the year 2065.';
	@override String get people => 'disciples';
	@override String get nations => 'nations';
	@override String get churches => 'house churches';
	@override String by({required Object year}) => 'by ${year}';
}

// Path: ministry.goals.revival
class _Translations$ministry$goals$revival$en extends Translations$ministry$goals$revival$fr {
	_Translations$ministry$goals$revival$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Hastening the global revival';
	@override String get text => 'To cooperate with God through fasting and intercession for the worldwide revival that will rend the heavens, shake the earth and glorify Christ in our generation, to hasten the imminent return of our Lord Jesus Christ from heaven to meet his Bride made ready.';
	@override String get fasting => 'Fasting';
	@override String get intercession => 'Intercession';
	@override String get pray => 'Pray now';
}

// Path: ministry.lives.founder
class _Translations$ministry$lives$founder$en extends Translations$ministry$lives$founder$fr {
	_Translations$ministry$lives$founder$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get name => 'Prof. Zacharias Tanee Fomum';
	@override String get line => '1945 – 2009 · Founder of CMFI';
	@override List<String> get facts => [
		'CMFI founded',
		'books written',
		'nations visited',
	];
	@override List<String> get dates => [
		'Born on 20 June in Cameroon, into a Presbyterian family.',
		'Gives his life to Jesus Christ on 13 June, through a tract.',
		'Surrenders himself wholly to the Lord on 1 October, in Sierra Leone.',
		'Filled with the Holy Spirit on 24 October, after seven days of prayer.',
		'Founds CMFI in Yaoundé on 12 May.',
		'Awarded a Doctor of Science by Durham University.',
		'Goes to be with the Lord on 14 March.',
	];
	@override List<String> get story => [
		'Zacharias Tanee Fomum was born on 20 June 1945 in Cameroon, into a Presbyterian family from Batibo, in the North-West. While still a schoolboy, he gave his life to Jesus Christ on 13 June 1956, through a tract entitled “Someone died for you”.',
		'As a student at Fourah Bay College in Sierra Leone, he surrendered himself without reserve to the Lord and to His service on 1 October 1966. On 24 October 1970, at the end of seven days of prayer and fasting, he was filled with the Holy Spirit. From then on, prayer was the centre of his life.',
		'With a doctorate in organic chemistry from Makerere University in Uganda, he taught at the University of Yaoundé, where he became a professor. He supervised about a hundred theses and dissertations, and in 2005 Durham University, in Great Britain, awarded him a Doctor of Science for his whole body of work.',
		'On 12 May 1975, in Yaoundé, he founded Christian Missionary Fellowship International: a movement to win souls, make disciples, plant churches and send out missionaries. He made more than 700 missionary journeys in Cameroon and more than 500 to over 70 nations, on six continents.',
		'He spent long hours alone with God every day, led many prayer crusades, sieges and walks, and fasted often. He wrote more than 150 books on prayer, fasting, holiness, discipleship and mission, read in many languages.',
		'With his wife, Prisca Zei Fomum, a minister to children, he had seven children, all involved in the work of the Gospel. Together they lived simply, so as to give the largest part of their income to the Gospel.',
		'He went to be with the Lord on 14 March 2009 and was buried in Yaoundé on 21 March. The work he founded goes on among the nations.',
	];
}

// Path: ministry.lives.leader
class _Translations$ministry$lives$leader$en extends Translations$ministry$lives$leader$fr {
	_Translations$ministry$lives$leader$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get name => 'Theodore Andoseh';
	@override String get line => 'Leader of CMFI since 2009';
	@override List<String> get facts => [
		'churches planted',
		'years in Nigeria',
		'leading CMFI',
	];
	@override List<String> get dates => [
		'Gives his life to Jesus Christ under the preaching of Prof. Fomum.',
		'Consecrated a bishop in Yaoundé.',
		'Sent as a missionary to Nigeria with his wife, Adela.',
		'Takes up the leadership of CMFI.',
		'Brings the messages of the 3rd World Convention to members from 93 nations.',
	];
	@override List<String> get story => [
		'Theodore Andoseh gave his life to Jesus Christ in 1978, listening to the preaching of Prof. Zacharias Tanee Fomum, who became his spiritual father and trained him as a disciple.',
		'He first served at his side: as a laboratory assistant at the University of Yaoundé, then as his personal assistant and private secretary. In those years he published the first revival tract, “God speaks to the man who wants to hear”, and started the first prayer chain in Yaoundé.',
		'As a national missionary, he planted more than fifty churches in Cameroon. He was consecrated a bishop in Yaoundé in 1989.',
		'In 1994 he left as a missionary to Nigeria with his wife, Adela. They served there for fourteen years.',
		'Since 2009, when Prof. Fomum went to be with the Lord, he has led CMFI among the nations. In December 2019, at Koume near Bertoua, he brought the messages of the third World Convention to members from 93 nations. He is also the author of several books on serving God and building up the Church.',
	];
}

// Path: prayer.retreat.hints
class _Translations$prayer$retreat$hints$en extends Translations$prayer$retreat$hints$fr {
	_Translations$prayer$retreat$hints$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String assembly({required Object name}) => 'Your assembly: ${name}';
	@override String get assemblyMissing => 'Add your assembly to your profile';
	@override String authorities({required Object names}) => 'Your authorities: ${names}';
	@override String get authoritiesMissing => 'Add your spiritual authorities in More';
	@override String list({required Object list}) => 'My lists · ${list}';
	@override String listEmpty({required Object list}) => 'Your "${list}" list is empty: add names';
	@override String nation({required Object name}) => 'Today: ${name}';
	@override String myCountry({required Object name}) => 'Your country: ${name}';
	@override String get hymn => 'Open the hymns';
}

// Path: prayer.lists.answeredOn
class _Translations$prayer$lists$answeredOn$en extends Translations$prayer$lists$answeredOn$fr {
	_Translations$prayer$lists$answeredOn$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String unbelievers({required Object date}) => 'Believed in the Lord on ${date}';
	@override String believers({required Object date}) => 'Answered on ${date}';
	@override String backsliders({required Object date}) => 'Came back on ${date}';
	@override String coworkers({required Object date}) => 'Answered on ${date}';
}

// Path: prayer.lists.sheet
class _Translations$prayer$lists$sheet$en extends Translations$prayer$lists$sheet$fr {
	_Translations$prayer$lists$sheet$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get addTitle => 'Add a person';
	@override String get editTitle => 'Edit';
	@override String get name => 'Name';
	@override String get namePlaceholder => 'Paul M.';
	@override String get note => 'Note';
	@override String get notePlaceholder => 'Colleague, neighbour, cousin…';
	@override String get list => 'List';
	@override String get save => 'Save';
	@override String get remove => 'Remove from the list';
	@override String removeTitle({required Object name}) => 'Remove ${name}?';
	@override String get removeText => 'You won\'t pray for this person in your retreats any more.';
}

// Path: prayer.importunity.form
class _Translations$prayer$importunity$form$en extends Translations$prayer$importunity$form$fr {
	_Translations$prayer$importunity$form$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get newTitle => 'New importunity topic';
	@override String get editTitle => 'Edit the topic';
	@override String get subject => 'Topic';
	@override String get subjectPlaceholder => 'Lord, save Paul';
	@override String get description => 'Details';
	@override String get descriptionPlaceholder => 'For whom, why…';
	@override String get goal => 'Goal';
	@override String get goalHint => 'The number of proclamations to reach together. Leave empty to count without a goal.';
	@override String get goalPlaceholder => '10,000';
	@override String get create => 'Create';
	@override String get save => 'Save';
}

// Path: prayer.importunity.inviteSheet
class _Translations$prayer$importunity$inviteSheet$en extends Translations$prayer$importunity$inviteSheet$fr {
	_Translations$prayer$importunity$inviteSheet$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Invite to pray';
	@override String get family => 'My spiritual family';
	@override String familyText({required num n, required Object name}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: '${name} and their disciples: ${n} person',
		other: '${name} and their disciples: ${n} people',
	);
	@override String get familyMissing => 'Link your disciple maker in My spiritual authorities to invite your spiritual family.';
	@override String get byUsername => 'By username';
	@override String get usernameLabel => 'Username';
	@override String get addUsername => 'Add';
	@override String get send => 'Send the invitations';
	@override String sent({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		zero: 'They were already invited.',
		one: '${n} invitation sent',
		other: '${n} invitations sent',
	);
}

/// The flat map containing all translations for locale <en>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsEn {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'app.name' => 'CMFI Connect',
			'app.tagline' => 'Growing together, every day.',
			'app.languageName' => 'English',
			'common.retry' => 'Try again',
			'common.cancel' => 'Cancel',
			'common.save' => 'Save',
			'common.close' => 'Close',
			'common.back' => 'Back',
			'common.soon' => 'Soon',
			'common.optional' => '(optional)',
			'common.and' => 'and',
			'common.loading' => 'Loading…',
			'common.done' => 'Done',
			'common.rangeStart' => 'From',
			'common.rangeEnd' => 'To',
			'errors.network' => 'No internet connection. Check your network and try again.',
			'errors.unauthorized' => 'Your session has expired. Please sign in again.',
			'errors.invalidCredentials' => 'Wrong phone number or password.',
			'errors.badRequest' => 'Some information is not valid.',
			'errors.conflict' => 'This item already exists.',
			'errors.notFound' => 'Item not found.',
			'errors.server' => 'The server ran into a problem. Try again in a moment.',
			'errors.unknown' => 'Something went wrong. Try again.',
			'errors.forbidden' => 'You\'re not allowed to do this.',
			'errors.eventFull' => 'There is no seat left for this event.',
			'errors.registrationClosed' => 'Registration for this event is closed.',
			'errors.mediaTooLarge' => 'This image is too large (8 MB at most).',
			'errors.mediaUnsupported' => 'Choose a JPEG or PNG image.',
			'errors.notParticipant' => 'Join this topic first to count your proclamations.',
			'errors.importunityClosed' => 'This topic is closed: it doesn\'t count proclamations any more.',
			'errors.usernameNotFound' => 'Nobody has this username. Check the spelling.',
			'errors.ownerCannotLeave' => 'You created this topic: delete it instead of leaving it.',
			'errors.tooManyPeople' => 'Your lists are full (500 people at most).',
			'errors.avatarInvalid' => 'This photo can\'t be used. Choose another one.',
			'errors.reportsNotShared' => 'This member no longer shares their reports.',
			'validation.required' => 'This field is required',
			'validation.passwordTooShort' => 'At least 6 characters',
			'validation.invalidPhone' => 'Invalid phone number',
			'validation.invalidEmail' => 'Invalid email address',
			'validation.invalidCode' => 'Letters and digits only, no spaces',
			'welcome.seek.before' => 'Seek ',
			'welcome.seek.marked' => 'God',
			'welcome.seek.after' => ' first, every day',
			'welcome.seek.text' => 'Log your Bible reading, prayer and fasting in seconds… and watch your progress week after week.',
			'welcome.worship.before' => 'Sing and ',
			'welcome.worship.marked' => 'pray',
			'welcome.worship.after' => ', wherever you are',
			'welcome.worship.text' => 'Find the community\'s hymns and carry the prayer topics with your brothers and sisters every day.',
			'welcome.community.before' => 'Stay close to your ',
			'welcome.community.marked' => 'community',
			'welcome.community.after' => '',
			'welcome.community.text' => 'Your assembly\'s events and announcements, all in one place, so you never miss a thing.',
			'welcome.step' => ({required Object current, required Object total}) => 'Screen ${current} of ${total}',
			'welcome.streak' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: '${n} day with God', other: '${n} days with God', ), 
			'welcome.sample.bibleReading' => 'Bible reading',
			'welcome.sample.chapters' => '10 ch.',
			'welcome.sample.prayerAlone' => 'Prayer alone',
			'welcome.sample.hymn' => 'Hymn',
			'welcome.sample.hymnNumber' => 'No. 12',
			'welcome.sample.prayerOfTheDay' => 'Prayer topic of the day',
			'welcome.sample.prayerTopic' => 'For our young people\'s exams',
			'welcome.sample.praying' => '12 people are praying',
			'welcome.sample.iPray' => 'I pray',
			'welcome.sample.retreat' => 'Youth retreat',
			'welcome.sample.announcement' => 'Announcement',
			'welcome.sample.announcementText' => 'Sunday service starts at 8:30 am.',
			'welcome.createAccount' => 'Create my account',
			'welcome.haveAccount' => 'I already have an account',
			'auth.phone' => 'Phone',
			'auth.dialCode' => ({required Object code}) => 'Country code: ${code}',
			'auth.password' => 'Password',
			'auth.showPassword' => 'Show password',
			'auth.hidePassword' => 'Hide password',
			'auth.login.title' => 'Welcome back',
			'auth.login.subtitle' => 'Sign in to pick up your walk with God and your community.',
			'auth.login.welcomeBack' => 'Glad you\'re here!',
			'auth.login.submit' => 'Sign in',
			'auth.login.noAccount' => 'No account yet?',
			'auth.login.createAccount' => 'Create an account',
			'auth.register.step' => ({required Object current, required Object total}) => '${current} / ${total}',
			'auth.register.title' => 'Create your account',
			'auth.register.subtitle' => 'You will sign in with your phone number.',
			'auth.register.firstName' => 'First name',
			'auth.register.lastName' => 'Last name',
			'auth.register.passwordHelp' => 'At least 6 characters',
			'auth.register.email' => 'Email',
			'auth.register.submit' => 'Continue',
			'auth.register.haveAccount' => 'Already have an account?',
			'auth.register.login' => 'Sign in',
			'auth.register.alreadyUsed' => 'This phone number or email already has an account. Sign in instead.',
			'auth.register.emailHint' => 'you@example.com',
			'auth.church.title' => 'Your church',
			'auth.church.subtitle' => 'This helps your leaders find you. You can change it later.',
			'auth.church.editTitle' => 'My profile',
			'auth.church.editSubtitle' => 'Update your name, your church and your assembly.',
			'auth.church.country' => 'Country',
			'auth.church.countryHint' => 'Choose your country',
			'auth.church.city' => 'City',
			'auth.church.cityHint' => 'Yaoundé',
			'auth.church.church' => 'Church',
			'auth.church.churchHint' => 'Your church\'s name',
			'auth.church.assembly' => 'Assembly',
			'auth.church.assemblyHint' => 'Your assembly\'s name',
			'auth.church.info' => 'Moved or changed assembly? You can update everything from your profile.',
			'auth.church.submit' => 'Finish',
			'auth.church.skip' => 'Skip this step',
			'auth.church.saved' => 'Profile saved',
			'auth.forgot.link' => 'Forgot your password?',
			'auth.forgot.title' => 'Forgot password',
			'auth.forgot.phoneText' => 'Enter your number: we\'ll text you a code to choose a new password.',
			'auth.forgot.sendCode' => 'Get the code',
			'auth.forgot.codeTitle' => 'Enter the code',
			'auth.forgot.codeText' => ({required Object phone}) => 'We sent a 6-digit code to ${phone}.',
			'auth.forgot.code' => 'Code received by text',
			'auth.forgot.codeInvalid' => 'The code has 6 digits',
			'auth.forgot.verify' => 'Verify',
			'auth.forgot.resend' => 'Send the code again',
			'auth.forgot.resendIn' => ({required Object seconds}) => 'Send again in ${seconds} s',
			'auth.forgot.changeNumber' => 'Change number',
			'auth.forgot.passwordTitle' => 'New password',
			'auth.forgot.passwordText' => 'Choose a new password for your account.',
			'auth.forgot.submit' => 'Save and sign in',
			'auth.forgot.done' => 'Password changed. Welcome back!',
			'auth.forgot.remembered' => 'Remember it?',
			'auth.forgot.invalidCode' => 'That code isn\'t right.',
			'auth.forgot.expired' => 'The code expired. Ask for a new one.',
			'auth.forgot.tooManyRequests' => 'Too many attempts. Try again in a while.',
			'auth.forgot.unavailable' => 'Resetting the password isn\'t available right now.',
			'auth.forgot.noAccount' => 'No account uses this number.',
			'auth.biometric.faceId' => 'Face ID',
			'auth.biometric.touchId' => 'Touch ID',
			'auth.biometric.fingerprint' => 'your fingerprint',
			'auth.biometric.face' => 'your face',
			'auth.biometric.signIn' => ({required Object method}) => 'Sign in with ${method}',
			'auth.biometric.askTitle' => ({required Object method}) => 'Sign in with ${method}?',
			'auth.biometric.askText' => 'Next time, no need to type your password: it stays in your phone\'s secure vault.',
			'auth.biometric.enable' => 'Turn on',
			'auth.biometric.later' => 'Later',
			'auth.biometric.reason' => 'Sign in to CMFI Connect',
			'auth.biometric.enableReason' => 'Turn on quick sign-in to CMFI Connect',
			'auth.biometric.changed' => ({required Object method}) => 'Your password has changed: sign in with your password, then turn ${method} on again.',
			'auth.biometric.settings' => ({required Object method}) => 'Sign in with ${method}',
			'auth.biometric.settingsText' => 'Without typing your password',
			'auth.biometric.passwordTitle' => 'Your password',
			'auth.biometric.passwordLabel' => 'Password',
			'auth.biometric.confirm' => 'Confirm',
			'auth.biometric.enabled' => ({required Object method}) => 'Sign-in with ${method} is on',
			'countries.dialCodeTitle' => 'Country code',
			'countries.title' => 'Your country',
			'countries.search' => 'Search a country or a code',
			'countries.none' => 'No country matches',
			'countries.change' => 'Change country',
			'nav.home' => 'Home',
			'nav.reports' => 'Report',
			'nav.hymns' => 'Hymns',
			'nav.prayer' => 'Prayer',
			'nav.bible' => 'Bible',
			'home.greeting' => ({required Object name}) => 'Hello ${name}',
			'home.greetingNoName' => 'Hello',
			'home.profile' => 'My profile',
			'home.progress' => ({required Object filled, required Object total}) => '${filled} of ${total}',
			'home.progressLabel' => 'items filled in',
			'home.goals' => 'goals',
			'home.weekTitle' => 'Your week',
			'home.community' => 'Currently at CMFI',
			'home.eventsTitle' => 'Events',
			'home.hymnsTitle' => 'Hymns',
			'home.hymnsOpen' => 'Open the hymn book',
			'home.continueMyReport' => 'Continue my report',
			'home.startMyReport' => 'Start my report',
			'home.items' => 'items',
			'home.goalsTitle' => 'Goals',
			'home.retreatsTitle' => 'Retreats',
			'home.retreatsValue' => ({required Object n}) => '${n} of 4',
			'home.streakTitle' => 'Streak',
			'home.resume' => 'Pick up where you left off',
			'home.hymnNumber' => ({required Object number}) => 'Hymn no. ${number}',
			'home.seeAll' => 'See all',
			'home.retreatsDone' => 'The 4 retreats of the day are done',
			'home.days' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: '${n} day', other: '${n} days', ), 
			'home.hideNumbers' => 'Hide my numbers',
			'home.showNumbers' => 'Show my numbers',
			'home.numbersHidden' => 'hidden',
			'home.daysShort' => ({required Object n}) => '${n} d',
			'home.prayTogether' => 'Pray together',
			'home.invitedBy' => ({required Object name}) => '${name} invites you to pray',
			'home.soulsTitle' => 'Souls to contact again',
			'home.listenTitle' => 'To listen',
			'home.soulsText' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: '${n} person today', other: '${n} people today', ), 
			'reports.title' => 'Daily report',
			'reports.myItems' => 'My items',
			'reports.tabs.today' => 'Today',
			'reports.tabs.history' => 'History',
			'reports.tabs.summary' => 'Summary',
			'reports.pickDay' => 'Pick the day',
			'reports.filled' => ({required Object filled, required Object total}) => '${filled} of ${total} filled in',
			'reports.statusSaved' => 'Saved',
			'reports.statusModified' => 'Not saved',
			'reports.standard' => 'Standard',
			'reports.personal' => 'My items',
			'reports.createItem' => 'Create an item',
			'reports.add' => ({required Object label}) => 'Add ${label}',
			'reports.note' => 'Note of the day',
			'reports.noteHint' => 'A verse, something you\'re thankful for…',
			'reports.save' => 'Save the day',
			'reports.saved' => 'Day saved',
			'reports.measure.quantity' => ({required Object unit}) => '${unit}',
			'reports.measure.duration' => 'duration',
			'reports.measure.both' => ({required Object unit}) => '${unit} and duration',
			'reports.measure.quantityNoUnit' => 'quantity',
			'reports.measure.bothNoUnit' => 'quantity and duration',
			'reports.times' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: '${n} time', other: '${n} times', ), 
			'reports.sheet.quantity' => 'Quantity',
			'reports.sheet.duration' => 'Duration',
			'reports.sheet.minus1' => '− 1 min',
			'reports.sheet.plus1' => '+ 1 min',
			'reports.sheet.removeMinute' => 'Remove one minute',
			'reports.sheet.addMinute' => 'Add one minute',
			'reports.sheet.holdToRepeat' => 'Hold to go faster',
			'reports.sheet.decrease' => 'Decrease',
			'reports.sheet.increase' => 'Increase',
			'reports.sheet.clear' => 'Clear',
			'reports.sheet.validate' => 'Done',
			'reports.history.daysFilled' => ({required Object filled, required Object total}) => '${filled} days filled in out of ${total}',
			'reports.history.legendFilled' => 'Filled in',
			'reports.history.legendMissing' => 'No report',
			'reports.history.none' => 'No report',
			'reports.history.fill' => 'Fill in',
			'reports.history.inProgress' => 'In progress',
			'reports.history.previousMonth' => 'Previous month',
			'reports.history.nextMonth' => 'Next month',
			'reports.history.today' => 'today',
			'reports.summary.week' => 'Week',
			'reports.summary.month' => 'Month',
			'reports.summary.year' => 'Year',
			'reports.summary.range' => ({required Object from, required Object to}) => 'From ${from} to ${to}',
			'reports.summary.regularity' => 'Regularity',
			'reports.summary.daysFilled' => 'days filled in',
			'reports.summary.missingDays' => ({required num n, required Object days}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: '${n} day without a report: the ${days}', other: '${n} days without a report: the ${days}', ), 
			'reports.summary.missingCount' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: '${n} day without a report', other: '${n} days without a report', ), 
			'reports.summary.noMissing' => 'No day missed, well done!',
			'reports.summary.perDay' => ({required Object value}) => '${value} per day filled in',
			'reports.summary.days' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: '${n} day', other: '${n} days', ), 
			'reports.summary.notFilled' => 'Not filled in yet',
			'reports.summary.barsCaption' => ({required Object max}) => 'Per day · highest bar: ${max}',
			'reports.summary.barsCaptionMonthly' => ({required Object max}) => 'Per month · highest bar: ${max}',
			'reports.summary.empty' => 'No report for this period.',
			'reports.summary.goalDays' => ({required num n, required Object total}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: 'Goal reached on ${n} day out of ${total}', other: 'Goal reached on ${n} days out of ${total}', ), 
			'reports.summary.share' => 'Share this summary',
			'reports.summary.goals' => 'Goals',
			'reports.summary.goalsAverage' => 'Average completion of your goals',
			'reports.summary.goalsHint' => 'Every day counts, even an empty one. Today counts once filled in.',
			'reports.summary.evolution' => 'How your goals progress',
			'reports.summary.evolutionHint' => 'Week after week, over the last 12.',
			'reports.summary.premiumYear' => 'The year and the progress of your goals come with Premium.',
			'reports.noItems' => 'Nothing to fill in yet.',
			'reports.statusPending' => 'Not sent yet',
			'reports.savedOffline' => 'No network: the day is kept on your phone and will be sent as soon as possible.',
			'reports.pendingBanner' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: '${n} day is waiting for the network to be sent', other: '${n} days are waiting for the network to be sent', ), 
			'reports.export' => 'Export my report',
			'reports.goal' => ({required Object value}) => 'Goal: ${value}',
			'reports.goalReached' => 'Goal reached',
			'reports.dayGoals' => 'Goals of the day',
			'reports.goalsReached' => ({required Object reached, required Object total}) => 'Reached: ${reached} of ${total}',
			'reports.standardItems.lb' => 'Bible reading',
			'reports.standardItems.ps' => 'Personal prayer',
			'reports.standardItems.rdqad' => 'Meditation',
			'reports.standardItems.pg' => 'Group prayer',
			'reports.standardItems.llc' => 'Christian literature reading',
			'reports.standardItems.jc' => 'Full fast',
			'reports.standardItems.jp' => 'Partial fast',
			'reports.standardItems.dimes' => 'Tithes',
			'reports.standardItems.off' => 'Offerings',
			'reports.units.chapters.name' => 'Number of chapters',
			'reports.units.chapters.label' => 'chapters',
			'reports.units.chapters.symbol' => 'chapters',
			'reports.units.chapters.count' => ({required num n, required Object value}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: '${value} chapter', other: '${value} chapters', ), 
			'reports.units.times.name' => 'Number of times',
			'reports.units.times.label' => 'times',
			'reports.units.times.symbol' => 'times',
			'reports.units.times.count' => ({required num n, required Object value}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: '${value} time', other: '${value} times', ), 
			'reports.units.pages.name' => 'Number of pages',
			'reports.units.pages.label' => 'pages',
			'reports.units.pages.symbol' => 'pages',
			'reports.units.pages.count' => ({required num n, required Object value}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: '${value} page', other: '${value} pages', ), 
			'reports.units.percent.name' => 'Percentage',
			'reports.units.percent.label' => 'percentage',
			'reports.units.percent.symbol' => '%',
			'reports.units.percent.count' => ({required Object value}) => '${value}%',
			'reports.timer.start' => 'Start the stopwatch',
			'reports.timer.running' => 'Stopwatch running',
			'reports.timer.startEnd' => 'Start – end',
			'reports.timer.from' => 'Start time',
			'reports.timer.to' => 'End time',
			'reports.timer.span' => ({required Object from, required Object to}) => 'From ${from} to ${to}',
			'reports.timer.pause' => 'Pause',
			'reports.timer.resume' => 'Resume',
			'reports.timer.finish' => 'Finish',
			'reports.timer.discard' => 'Cancel the stopwatch',
			'reports.timer.paused' => 'Paused',
			'reports.timer.added' => ({required Object time, required Object item}) => '${time} added to "${item}"',
			'reports.timer.noItem' => 'The stopwatch stopped, but this item is no longer in your report.',
			'reports.timer.replaceTitle' => 'Replace the stopwatch?',
			'reports.timer.replaceText' => ({required Object item}) => 'A stopwatch is already running for "${item}". It will stop without being counted.',
			'reports.timer.replace' => 'Replace',
			'reports.timer.channel' => 'Running stopwatch',
			'reports.timer.ongoingBody' => 'Tap to pause or finish',
			'reports.timer.pickButton' => 'Start a stopwatch',
			'reports.timer.pickTitle' => 'What do you want to time?',
			'reports.timer.pickHint' => 'When you finish, the minutes are added to today\'s report by themselves.',
			'reports.timer.pickEmpty' => 'None of the items of your report is counted in time.',
			'reports.timer.todayMinutes' => ({required Object time}) => '${time} today',
			'reports.timer.notYet' => 'Not yet today',
			'reminder.title' => 'Your daily report',
			'reminder.body' => 'Take a minute to note your reading, your prayer… before the day ends.',
			'reminder.channel' => 'Report reminder',
			'reminder.settings' => 'Evening reminder',
			'reminder.off' => 'Off',
			'reminder.switchLabel' => 'Remind me to fill in my day',
			'reminder.switchHint' => 'Only when the day isn\'t filled in yet.',
			'reminder.time' => 'Reminder time',
			'reminder.offerTitle' => 'A reminder every evening?',
			'reminder.offerText' => 'If your day isn\'t filled in yet, the app reminds you at the time you choose. Nothing if it\'s already done.',
			'reminder.offerAccept' => 'Turn on the reminder',
			'reminder.offerLater' => 'Later',
			'reminder.enabled' => ({required Object time}) => 'Reminder set for ${time}',
			'reminder.denied' => 'Notifications are blocked for CMFI Connect. Allow them in the phone settings.',
			'export.title' => 'Export',
			'export.period' => 'Period',
			'export.thisWeek' => 'This week',
			'export.lastWeek' => 'Last week',
			'export.thisMonth' => 'This month',
			'export.lastMonth' => 'Last month',
			'export.thisYear' => 'This year',
			'export.custom' => 'Other dates',
			'export.customPick' => 'Choose the dates',
			'export.format' => 'Format',
			'export.pdf' => 'PDF',
			'export.pdfHint' => 'A document to send or print',
			'export.csv' => 'Spreadsheet',
			'export.csvHint' => 'A CSV file for Excel or Google Sheets',
			'export.text' => 'Message',
			'export.textHint' => 'A summary to paste in WhatsApp',
			'export.button' => 'Export',
			'export.shareButton' => 'Share',
			'export.preview' => ({required num filled, required Object total, required Object items}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(filled, one: '${filled} day filled out of ${total} · ${items}', other: '${filled} days filled out of ${total} · ${items}', ), 
			'export.previewItems' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: '${n} item', other: '${n} items', ), 
			'export.empty' => 'No report in this period.',
			'export.tooLong' => 'Choose 366 days at most.',
			'export.fileName' => 'daily-report',
			'export.subject' => ({required Object period}) => 'My daily report, ${period}',
			'export.doc.title' => 'Daily report',
			'export.doc.regularity' => 'Regularity',
			'export.doc.daysFilled' => ({required num filled, required Object total}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(filled, one: '${filled} day filled out of ${total}', other: '${filled} days filled out of ${total}', ), 
			'export.doc.totals' => 'Over the period',
			'export.doc.item' => 'Item',
			'export.doc.total' => 'Total',
			'export.doc.days' => 'Days',
			'export.doc.average' => 'Average / day filled',
			'export.doc.goal' => 'Goal reached',
			'export.doc.detail' => 'Day by day',
			'export.doc.date' => 'Date',
			'export.doc.values' => 'Filled in',
			'export.doc.note' => 'Note',
			'export.doc.noReport' => 'No report',
			'export.doc.generated' => ({required Object date}) => 'Made on ${date} with CMFI Connect',
			'export.doc.page' => ({required Object n, required Object total}) => 'Page ${n} / ${total}',
			'export.doc.filledColumn' => 'Report',
			'export.doc.yes' => 'yes',
			'export.doc.no' => 'no',
			'export.doc.sentFrom' => 'Sent from CMFI Connect',
			'items.title' => 'My items',
			'items.standardSection' => 'Standard · for everyone',
			'items.personalSection' => 'My personal items',
			'items.emptyPersonal' => 'You don\'t have any personal item yet.',
			'items.archive' => 'Archive',
			'items.archiveTitle' => ({required Object code}) => 'Archive ${code}?',
			'items.archiveText' => 'It won\'t be offered in your report anymore. Its figures stay in your history.',
			'items.archived' => ({required Object code}) => '${code} archived',
			'items.create' => 'Create an item',
			'items.footnote' => 'An archived item is no longer offered in your report, but its figures stay in your history.',
			'items.measure.quantity' => ({required Object unit}) => 'Quantity · ${unit}',
			'items.measure.quantityNoUnit' => 'Quantity',
			'items.measure.duration' => 'Duration',
			'items.measure.both' => ({required Object unit}) => 'Quantity (${unit}) and duration',
			'items.measure.bothNoUnit' => 'Quantity and duration',
			'items.goalAdd' => 'Add a goal',
			'items.goal' => ({required Object value}) => 'Goal: ${value} a day',
			'items.goalTitle' => 'Daily goal',
			'items.goalHint' => 'What you aim for each day. It stays on your phone.',
			'items.goalRemove' => 'Remove',
			'items.goalSaved' => 'Goal saved',
			'items.goalRemoved' => 'Goal removed',
			'newItem.title' => 'New item',
			'newItem.code' => 'Code',
			'newItem.label' => 'Name',
			'newItem.help' => 'Letters and digits, 20 at most. The code of a standard item (LB, PS…) is not available.',
			'newItem.measures' => 'What you measure',
			'newItem.quantity' => 'A quantity',
			'newItem.quantityHint' => 'Chapters, pages, people…',
			'newItem.unit' => 'Unit shown after the number',
			'newItem.unitHint' => 'people',
			'newItem.duration' => 'A duration',
			'newItem.durationHint' => 'In hours and minutes',
			'newItem.noMeasure' => 'Pick at least one measure: a quantity, a duration or both.',
			'newItem.preview' => 'Preview in your report',
			'newItem.previewCode' => 'CODE',
			'newItem.previewLabel' => 'Item name',
			'newItem.submit' => 'Create the item',
			'newItem.created' => ({required Object code}) => '${code} created.',
			'newItem.codeTaken' => 'This code is already used, by a standard item or by one of your items (even archived).',
			'newItem.codeHint' => 'EVG',
			'newItem.labelHint' => 'Evangelism',
			'more.title' => 'More',
			'more.editProfile' => 'Edit my profile',
			'more.community' => 'Community',
			'more.events' => 'Events',
			'more.reports' => 'Daily report',
			'more.myItems' => 'My items',
			'more.app' => 'App',
			'more.language' => 'Language',
			'more.appearance' => 'Appearance',
			'more.themeSystem' => 'Automatic',
			'more.themeSystemHint' => 'Automatic follows your phone\'s light or dark setting.',
			'more.themeLight' => 'Light',
			'more.themeDark' => 'Dark',
			'more.logout' => 'Sign out',
			'more.account' => 'Account',
			'more.languageTitle' => 'App language',
			'more.completeProfile' => 'Add your name',
			'more.accompaniment' => 'Mentoring',
			'more.exportReport' => 'Export my report',
			'more.logoutPendingTitle' => 'Days not sent yet',
			'more.logoutPendingText' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: '${n} day saved without network hasn\'t been sent yet. If you sign out now, it will be lost.', other: '${n} days saved without network haven\'t been sent yet. If you sign out now, they will be lost.', ), 
			'more.logoutAnyway' => 'Sign out',
			'more.admin' => 'Administration',
			'more.staff' => 'Team and roles',
			'more.manageEvents' => 'Events',
			'more.disciples' => 'My disciples',
			'more.version' => ({required Object version}) => 'Version ${version}',
			'more.copyright' => ({required Object year}) => '© ${year} Christian Missionary Fellowship International. All rights reserved.',
			'authorities.title' => 'My spiritual leaders',
			'authorities.intro' => 'The people who walk with you in your faith: your disciple maker and your other leaders.',
			'authorities.discipleMaker' => 'Disciple maker',
			'authorities.discipleMakerOf' => ({required Object name}) => 'Disciple maker: ${name}',
			'authorities.noDiscipleMaker' => 'No disciple maker yet',
			'authorities.others' => 'Other leaders',
			'authorities.empty' => 'You haven\'t added anyone yet.',
			'authorities.add' => 'Add a leader',
			'authorities.remove' => 'Remove',
			'authorities.removeTitle' => ({required Object name}) => 'Remove ${name}?',
			'authorities.removeText' => ({required Object name}) => '${name} will no longer be in your list of spiritual leaders.',
			'authorities.removed' => ({required Object name}) => '${name} is no longer in your list.',
			'authorities.count' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, zero: 'Nobody yet', one: '${n} person', other: '${n} people', ), 
			'authorities.form.title' => 'New leader',
			'authorities.form.emailHint' => 'name@example.com',
			'authorities.form.isDiscipleMaker' => 'This is my disciple maker',
			'authorities.form.isDiscipleMakerHelp' => 'The person who mentors you personally. You only have one.',
			'authorities.form.discipleMakerTaken' => ({required Object name}) => '${name} is already your disciple maker. Remove them from the list to choose someone else.',
			'authorities.form.submit' => 'Add',
			'authorities.form.added' => ({required Object name}) => '${name} is now one of your leaders.',
			'authorities.form.searchLabel' => 'Their username',
			'authorities.form.searchHint' => 'username',
			'authorities.form.search' => 'Search',
			'authorities.form.searchHelp' => 'If they use CMFI Connect, find them by their username. They will get your request, and their contact details will show once they accept.',
			'authorities.form.notFound' => ({required Object username}) => 'Nobody has the username @${username}.',
			'authorities.form.invite' => 'Invite them to join CMFI Connect',
			'authorities.form.inviteText' => 'Hello! I use CMFI Connect to keep track of my walk with God, and I\'d like you to accompany me. Install the app, create your account, then send me your username so I can add you.',
			'authorities.form.inviteMine' => ({required Object username}) => 'My username: @${username}',
			'authorities.form.manual' => 'Not on the app? Enter their details',
			'authorities.form.backToSearch' => 'Search by username instead',
			'authorities.form.request' => 'Send the request',
			'authorities.form.requested' => ({required Object name}) => 'Request sent to ${name}.',
			'authorities.form.alreadyAdded' => 'This person is already one of your authorities.',
			'authorities.form.makerExists' => 'You already have a disciple maker.',
			'authorities.form.yourself' => 'This is your own username.',
			'authorities.form.sharingHelp' => ({required Object name}) => '${name} will see your reports: the items filled in, your regularity and your percentages, never your note. You can stop it on their card.',
			'authorities.statusPending' => 'Pending',
			'authorities.statusDeclined' => 'Declined',
			'authorities.pendingHelp' => ({required Object name}) => 'Their contact details will show once ${name} accepts.',
			'authorities.requests' => 'Requests',
			'authorities.requestDiscipleMaker' => 'asks you to be their disciple maker',
			'authorities.requestAuthority' => 'asks you to accompany them',
			'authorities.accept' => 'Accept',
			'authorities.decline' => 'Decline',
			'authorities.acceptedRequest' => ({required Object name}) => 'You now accompany ${name}.',
			'authorities.declinedRequest' => ({required Object name}) => 'Request from ${name} declined.',
			'authorities.requestsCount' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: '${n} request to see', other: '${n} requests to see', ), 
			'authorities.sharing.title' => 'Share my reports',
			'authorities.sharing.help' => ({required Object name}) => '${name} sees your reports: the items filled in, your regularity and your percentages, never your note.',
			'authorities.sharing.on' => ({required Object name}) => 'Your reports are shared with ${name}.',
			'authorities.sharing.off' => ({required Object name}) => '${name} no longer sees your reports.',
			'members.username' => 'Username',
			'members.usernameHint' => 'firstname.lastname',
			'members.usernameHelp' => 'This is how other members will find you.',
			'members.usernameChecking' => 'Checking…',
			'members.usernameFree' => ({required Object username}) => '@${username} is available',
			'members.usernameCurrent' => 'This is your current username',
			'members.usernameTaken' => 'This username is already taken.',
			'members.usernameInvalid' => '3 to 30 characters: letters, digits, "." and "_", not starting or ending with a sign.',
			'members.usernameReserved' => 'This username is reserved.',
			'members.usernameSaved' => ({required Object username}) => 'Username saved: @${username}',
			'members.deleteAccount.button' => 'Delete my account',
			'members.deleteAccount.title' => 'Delete my account',
			'members.deleteAccount.intro' => 'This is permanent. Your account and everything linked to it will be erased:',
			'members.deleteAccount.itemProfile' => 'your profile, photo, username and password',
			'members.deleteAccount.itemReports' => 'all your reports, items and goals',
			'members.deleteAccount.itemAuthorities' => 'your spiritual authorities and the requests you received',
			'members.deleteAccount.itemEvents' => 'your event registrations',
			'members.deleteAccount.itemPrayer' => 'your prayer lists, retreats and importunity topics',
			'members.deleteAccount.kept' => 'Events, news, photos and prayer topics you published as an admin stay for the community, without your name.',
			'members.deleteAccount.passwordHelp' => 'To confirm it\'s really you.',
			_ => null,
		} ?? switch (path) {
			'members.deleteAccount.confirm' => 'Delete for good',
			'members.deleteAccount.done' => 'Your account has been deleted. God bless you!',
			'members.deleteAccount.wrongPassword' => 'Wrong password.',
			'members.deleteAccount.lastSuperadmin' => 'You are the only superadmin: give this role to someone else before deleting your account.',
			'admin.title' => 'Team and roles',
			'admin.intro' => 'Admins manage what the whole community shares. Only a superadmin gives or takes back a role.',
			'admin.roleUser' => 'Member',
			'admin.roleAdmin' => 'Admin',
			'admin.roleSuperadmin' => 'Superadmin',
			'admin.giveRole' => 'Give a role',
			'admin.you' => 'you',
			'admin.roleFor' => ({required Object username}) => 'Role of @${username}',
			'admin.roleChanged' => ({required Object username, required Object role}) => '@${username}: ${role}',
			'admin.memberUsername' => 'Member\'s username',
			'admin.empty' => 'No admin yet.',
			'hymns.searchHint' => 'Number, title or words',
			'hymns.openNumber' => 'Go to a number',
			'hymns.tabs.all' => 'All',
			'hymns.tabs.favorites' => 'Favorites',
			'hymns.tabs.recent' => 'Recent',
			'hymns.chooseBook' => 'Choose the hymn book',
			'hymns.count' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: '${n} hymn', other: '${n} hymns', ), 
			'hymns.number' => ({required Object number}) => 'No. ${number}',
			'hymns.emptyFavorites' => 'Tap the star of a hymn to find it here.',
			'hymns.emptyRecent' => 'The hymns you open will show up here.',
			'hymns.noResult' => ({required Object query}) => 'No hymn matches “${query}”.',
			'hymns.otherBooks' => 'In the other hymn books',
			'hymns.upToDate' => 'The hymn books are up to date.',
			'hymns.updated' => 'The hymn books have been updated.',
			'hymns.chorus' => 'Chorus',
			'hymns.chorusNumber' => ({required Object label}) => 'Chorus ${label}',
			'hymns.verse' => ({required Object label}) => 'Verse ${label}',
			'hymns.times' => ({required Object n}) => '×${n}',
			'hymns.loadFailed' => 'The hymn books could not be opened.',
			'hymns.reader.smaller' => 'Smaller text',
			'hymns.reader.larger' => 'Larger text',
			'hymns.reader.display' => 'Display',
			'hymns.reader.textSize' => 'Text size',
			'hymns.reader.typeface' => 'Font',
			'hymns.reader.typefaceAuto' => 'Auto',
			'hymns.reader.typefaceSans' => 'Modern',
			'hymns.reader.typefaceSerif' => 'Classic',
			'hymns.reader.typefaceAutoHelp' => 'Classic when the text is large',
			'hymns.reader.background' => 'Background',
			'hymns.reader.themeAuto' => 'Auto',
			'hymns.reader.themeLight' => 'Light',
			'hymns.reader.themeSepia' => 'Sepia',
			'hymns.reader.themeDark' => 'Dark',
			'hymns.reader.repeatChorus' => 'Repeat the chorus after each verse',
			'hymns.reader.keepScreenOn' => 'Keep the screen on',
			'hymns.reader.addFavorite' => 'Add to favorites',
			'hymns.reader.removeFavorite' => 'Remove from favorites',
			'hymns.reader.favoriteAdded' => 'Added to favorites',
			'hymns.reader.favoriteRemoved' => 'Removed from favorites',
			'hymns.reader.more' => 'More options',
			'hymns.reader.copy' => 'Copy the words',
			'hymns.reader.copied' => 'Words copied',
			'hymns.reader.project' => 'Projection mode',
			'hymns.reader.pinchHint' => 'Pinch the screen to make the text bigger or smaller.',
			'hymns.reader.notFound' => 'This hymn is no longer in the book.',
			'hymns.reader.share' => 'Share the lyrics',
			'hymns.projection.exit' => 'Leave projection mode',
			'hymns.projection.previous' => 'Previous stanza',
			'hymns.projection.next' => 'Next stanza',
			'hymns.projection.position' => ({required Object current, required Object total}) => '${current} / ${total}',
			'hymns.projection.hint' => 'Tap on the right to go on, on the left to go back.',
			'hymns.pad.title' => 'Go to hymn',
			'hymns.pad.open' => 'Open',
			'hymns.pad.erase' => 'Erase',
			'hymns.pad.notFound' => ({required Object number}) => 'No hymn No. ${number} in this book',
			'hymns.pad.placeholder' => 'Type a number',
			'comingSoon.badge' => 'Coming soon',
			'comingSoon.backHome' => 'Back to home',
			'events.title' => 'Events',
			'events.featured' => 'Featured',
			'events.upcoming' => 'Coming up',
			'events.past' => 'Past editions',
			'events.emptyTitle' => 'No upcoming event',
			'events.emptyText' => 'Conferences and gatherings of the whole community will show here, with their program.',
			'events.manage' => 'Manage events',
			'events.next' => 'Next event',
			'events.seeAll' => 'All events',
			'events.homeText' => 'The community\'s gatherings, their program and news.',
			'events.today' => 'Today',
			'events.tomorrow' => 'Tomorrow',
			'events.inDays' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: 'In ${n} day', other: 'In ${n} days', ), 
			'events.daysLeft' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: '${n} day', other: '${n} days', ), 
			'events.onNow' => 'On now',
			'events.over' => 'Over',
			'events.cancelled' => 'Cancelled',
			'events.draft' => 'Draft',
			'events.registered' => 'Registered',
			'events.stateOpen' => 'Registration open',
			'events.stateClosed' => 'Registration closed',
			'events.stateFull' => 'Full',
			'events.registrations' => ({required num n, required Object count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, zero: 'Be the first to register', one: '${count} registered', other: '${count} registered', ), 
			'events.people' => ({required num n, required Object count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: '${count} person', other: '${count} people', ), 
			'events.placesLeft' => ({required num n, required Object count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, zero: 'no seat left', one: '${count} seat left', other: '${count} seats left', ), 
			'events.oneDay' => ({required Object start, required Object end}) => 'From ${start} to ${end}',
			'events.severalDays' => ({required Object startDay, required Object start, required Object endDay, required Object end}) => 'Opens on ${startDay} at ${start}, closes on ${endDay} at ${end}',
			'events.venueTime' => ({required Object place}) => '${place} time',
			'events.addToCalendar' => 'Add to calendar',
			'events.share' => 'Share',
			'events.directions' => 'Directions',
			'events.viewPoster' => 'View the poster',
			'events.tabs.program' => 'Program',
			'events.tabs.news' => 'News',
			'events.tabs.info' => 'Info',
			'events.tabs.photos' => 'Photos',
			'events.noProgram' => 'The program will be published soon.',
			'events.noNews' => 'No news for this event yet.',
			'events.pinned' => 'Pinned',
			'events.now' => 'Happening now',
			'events.hymn' => ({required Object number}) => 'Hymn ${number}',
			'events.about' => 'About',
			'events.fees' => 'Fees',
			'events.deadline' => ({required Object date}) => 'Registration until ${date}',
			'events.contact' => 'Contact',
			'events.call' => ({required Object name}) => 'Call ${name}',
			'events.otherEditions' => 'Other editions',
			'events.cancelledBanner' => 'This event is cancelled.',
			'events.calendarFailed' => 'Couldn\'t open the phone\'s calendar.',
			'events.linkFailed' => 'Couldn\'t open this link.',
			'events.shareText' => ({required Object title, required Object dates, required Object place}) => '${title}\n${dates} · ${place}\nRegister in the CMFI Connect app.',
			'events.full' => 'There is no seat left for this event.',
			'events.closed' => 'Registration for this event is closed.',
			'events.register.cta' => 'I\'m coming',
			'events.register.title' => 'I\'m coming',
			'events.register.people' => 'How many of you?',
			'events.register.peopleHint' => 'You included, with your family or group.',
			'events.register.less' => 'One person less',
			'events.register.more' => 'One person more',
			'events.register.lodging' => 'I need accommodation',
			'events.register.lodgingHint' => 'The organizers plan the beds.',
			'events.register.departure' => 'Departure city',
			'events.register.departureHint' => 'E.g. Douala',
			'events.register.confirm' => 'Confirm my registration',
			'events.register.update' => 'Update',
			'events.register.cancel' => 'Cancel my registration',
			'events.register.done' => 'Done, you\'re registered! We\'ll remind you the day before.',
			'events.register.updated' => 'Your registration is up to date.',
			'events.register.cancelled' => 'Your registration is cancelled.',
			'events.register.edit' => 'Change',
			'events.register.youAre' => 'You\'re registered',
			'events.register.cancelTitle' => 'Cancel your registration?',
			'events.register.cancelText' => 'Your seat will go to someone else.',
			'events.register.keep' => 'Keep my seat',
			'events.register.lodgingShort' => 'accommodation',
			'events.reminder.channel' => 'Event reminders',
			'events.reminder.tomorrow' => ({required Object title}) => 'Tomorrow: ${title}',
			'events.reminder.soon' => ({required Object title}) => 'In 1 h: ${title}',
			'events.admin.title' => 'Manage events',
			'events.admin.create' => 'Create an event',
			'events.admin.edit' => 'Edit the event',
			'events.admin.empty' => 'No event yet. Create the first one!',
			'events.admin.poster' => 'Poster',
			'events.admin.posterAdd' => 'Choose a poster',
			'events.admin.posterChange' => 'Change the poster',
			'events.admin.posterRemove' => 'Remove the poster',
			'events.admin.posterHint' => 'Portrait 4:5 recommended (1080 × 1350), JPEG or PNG.',
			'events.admin.uploading' => 'Sending the image…',
			'events.admin.general' => 'The event',
			'events.admin.titleField' => 'Title',
			'events.admin.titleHint' => 'E.g. Annual conference 2026',
			'events.admin.titleRequired' => 'Give the event a title.',
			'events.admin.theme' => 'Theme',
			'events.admin.themeHint' => 'E.g. Walking in the Spirit',
			'events.admin.verse' => 'Theme verse',
			'events.admin.description' => 'Presentation',
			'events.admin.when' => 'Dates',
			'events.admin.starts' => 'Start',
			'events.admin.ends' => 'End',
			'events.admin.endsBeforeStart' => 'The end must come after the start.',
			'events.admin.timeZone' => ({required Object zone}) => 'Times of the venue (${zone}).',
			'events.admin.where' => 'Venue',
			'events.admin.venue' => 'Venue',
			'events.admin.venueHint' => 'E.g. Mvolyé conference center',
			'events.admin.address' => 'Address',
			'events.admin.city' => 'City',
			'events.admin.country' => 'Country',
			'events.admin.mapsUrl' => 'Google Maps link',
			'events.admin.registration' => 'Registration',
			'events.admin.registrationOpen' => 'Registration open',
			'events.admin.deadline' => 'Deadline',
			'events.admin.noDeadline' => 'No deadline',
			'events.admin.capacity' => 'Seats',
			'events.admin.capacityHint' => 'Empty: no limit',
			'events.admin.asksLodging' => 'Ask who needs accommodation',
			'events.admin.asksDeparture' => 'Ask the departure city',
			'events.admin.fees' => 'Fees',
			'events.admin.feesHint' => 'E.g. Free entry. Meals: 2,000 FCFA a day.',
			'events.admin.contact' => 'Contact',
			'events.admin.contactName' => 'Contact name',
			'events.admin.contactPhone' => 'Contact phone',
			'events.admin.visibility' => 'Visibility',
			'events.admin.statusDraft' => 'Draft',
			'events.admin.statusDraftHint' => 'Only the admins see it',
			'events.admin.statusPublished' => 'Published',
			'events.admin.statusPublishedHint' => 'The whole community sees it',
			'events.admin.statusCancelled' => 'Cancelled',
			'events.admin.statusCancelledHint' => 'Shown as cancelled, no registration',
			'events.admin.saved' => 'Event saved.',
			'events.admin.menu' => 'Manage',
			'events.admin.program' => 'Program',
			'events.admin.registrants' => 'Registered',
			'events.admin.post' => 'Post news',
			'events.admin.photos' => 'Add photos',
			'events.admin.nextEdition' => 'Prepare the next edition',
			'events.admin.delete' => 'Delete the event',
			'events.admin.deleteTitle' => 'Delete this event?',
			'events.admin.deleteText' => 'Its registrations, news and photos will be deleted too.',
			'events.admin.deleteConfirm' => 'Delete',
			'events.admin.deleted' => 'Event deleted.',
			'events.admin.nextEditionTitle' => 'Prepare the next edition?',
			'events.admin.nextEditionText' => 'A draft is created one year later, with the same venue and program. You can adjust everything before publishing it.',
			'events.admin.nextEditionConfirm' => 'Prepare',
			'events.admin.nextEditionDone' => 'The next edition is ready as a draft.',
			'events.admin.programEmpty' => 'Add the moments of the event: welcome, services, teachings, prayer night…',
			'events.admin.addSession' => 'Add a moment',
			'events.admin.editSession' => 'Edit this moment',
			'events.admin.sessionTitle' => 'Title',
			'events.admin.sessionTitleHint' => 'E.g. Opening service',
			'events.admin.speaker' => 'Speaker',
			'events.admin.place' => 'Room',
			'events.admin.day' => 'Day',
			'events.admin.from' => 'From',
			'events.admin.to' => 'To',
			'events.admin.hymns' => 'Hymns',
			'events.admin.hymnsHint' => 'Numbers, e.g. 12, 45',
			'events.admin.removeSession' => 'Remove',
			'events.admin.saveProgram' => 'Save the program',
			'events.admin.programSaved' => 'Program saved.',
			'events.admin.registrantsEmpty' => 'Nobody has registered yet.',
			'events.admin.totalRegistrations' => 'Registrations',
			'events.admin.totalPeople' => 'People',
			'events.admin.totalLodging' => 'To house',
			'events.admin.byCity' => 'By departure city',
			'events.admin.list' => 'List',
			'events.admin.exportCsv' => 'Export the list (CSV)',
			'events.admin.csvHeader' => 'Name,Username,Phone,Church,Assembly,People,Accommodation,Departure city,Registered on',
			'events.admin.yes' => 'yes',
			'events.admin.no' => 'no',
			'events.admin.postBody' => 'Message',
			'events.admin.postBodyHint' => 'E.g. Registration is open!',
			'events.admin.postImage' => 'Add an image',
			'events.admin.postPinned' => 'Pin to the top',
			'events.admin.postSend' => 'Post',
			'events.admin.postDone' => 'News posted.',
			'events.admin.postDelete' => 'Delete this news',
			'events.admin.postDeleted' => 'News deleted.',
			'events.admin.photosAdded' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: '${n} photo added.', other: '${n} photos added.', ), 
			'events.admin.photosSending' => ({required Object done, required Object total}) => 'Sending the photos (${done}/${total})…',
			'events.admin.photoDelete' => 'Delete this photo',
			'events.admin.photoDeleted' => 'Photo deleted.',
			'events.admin.confirmDelete' => 'Delete',
			'events.upcomingCount' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: '${n} upcoming event', other: '${n} upcoming events', ), 
			'events.slide' => ({required Object current, required Object total}) => 'Event ${current} of ${total}',
			'notifications.title' => 'Notifications',
			'notifications.channel' => 'Community announcements',
			'notifications.empty' => 'No notifications yet',
			'notifications.emptyHint' => 'The community\'s announcements will arrive here.',
			'notifications.unreadLabel' => ({required Object title}) => 'Unread: ${title}',
			'notifications.documents' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: '${n} PDF document', other: '${n} PDF documents', ), 
			'notifications.unread' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: '${n} unread', other: '${n} unread', ), 
			'notifications.image' => ({required Object n}) => 'Image ${n}',
			'notifications.document' => 'PDF document',
			'notifications.documentSize' => ({required Object kb}) => '${kb} KB',
			'premium.name' => 'CMFI Connect Premium',
			'premium.pill' => 'Premium',
			'premium.subtitle' => 'Go further in your walk with God, and support the work.',
			'premium.widgetTitle' => 'The home-screen widget',
			'premium.widgetText' => 'Today\'s report and your goals, without opening the app.',
			'premium.statsTitle' => 'Your goals over the year',
			'premium.statsText' => 'The year summary and how your goals progress, week after week.',
			'premium.supportTitle' => 'You support the work',
			'premium.supportText' => 'Your subscription keeps the app going for the whole community.',
			'premium.annual' => 'Yearly',
			'premium.lifetime' => 'Lifetime',
			'premium.monthly' => 'Monthly',
			'premium.perYear' => ({required Object price}) => '${price} / year',
			'premium.once' => ({required Object price}) => '${price} once',
			'premium.perMonth' => ({required Object price}) => '${price} / month',
			'premium.annualPerMonth' => ({required Object price}) => 'that\'s ${price} a month',
			'premium.best' => 'Best value',
			'premium.trialDays' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: '${n}-day free trial', other: '${n}-day free trial', ), 
			'premium.trialMonths' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: '${n}-month free trial', other: '${n}-month free trial', ), 
			'premium.subscribe' => 'Subscribe',
			'premium.startTrial' => 'Start the free trial',
			'premium.restore' => 'Restore purchases',
			'premium.restored' => 'Premium is back on this phone',
			'premium.nothingToRestore' => 'No Premium purchase for this account',
			'premium.thanks' => 'Thank you! Premium is on.',
			'premium.failed' => 'The purchase didn\'t go through. Try again in a moment.',
			'premium.unavailable' => 'The offers aren\'t available right now.',
			'premium.renews' => ({required Object store}) => 'The subscription renews automatically. You can cancel it anytime in your ${store} account settings.',
			'premium.terms' => 'Terms of use',
			'premium.privacy' => 'Privacy',
			'premium.activeTitle' => 'You have Premium',
			'premium.activeText' => 'Thank you for supporting CMFI Connect! The widget and the year of your summary are open.',
			'premium.staffText' => 'Premium is offered to you as a member of the CMFI Connect team.',
			'premium.moreSubtitle' => 'Widget, goals over the year',
			'premium.moreActive' => 'Active',
			'premium.unlock' => 'Unlock with Premium',
			'premium.trialThen' => ({required Object trial, required Object price}) => '${trial}, then ${price}',
			'premium.savePercent' => ({required Object percent}) => '−${percent}',
			'premium.choose' => 'Choose your plan',
			'premium.cancelAnytime' => 'No commitment, cancel anytime',
			'premium.restoreShort' => 'Restore',
			'premium.termsShort' => 'Terms',
			'premium.semiannual' => '6 months',
			'premium.perSemester' => ({required Object price}) => '${price} / 6 months',
			'premium.buyLifetime' => 'Buy for life',
			'premium.lifetimeNote' => 'Lifetime: a single payment, no subscription, nothing renews.',
			'premium.manage' => 'Manage my subscription',
			'premium.manageFailed' => 'Subscription management won\'t open. Try again later.',
			'premium.crown' => 'Premium member',
			'homeWidget.title' => 'Today',
			'homeWidget.done' => 'Done',
			'homeWidget.todo' => 'To fill in',
			'homeWidget.open' => 'Fill in',
			'homeWidget.locked' => 'Turn on the widget with Premium',
			'homeWidget.signedOut' => 'Sign in to the app',
			'ministry.title' => 'Our ministry',
			'ministry.tagline' => 'To the ends of the earth',
			'ministry.count' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: '${n} nation', other: '${n} nations', ), 
			'ministry.fromYaounde' => 'From Yaoundé, the Gospel goes from nation to nation.',
			'ministry.dragHint' => 'Turn the globe with your finger, touch a nation.',
			'ministry.globeLabel' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: 'Globe: ${n} nation where the work is present. The list below gives it.', other: 'Globe: ${n} nations where the work is present. The list below gives them all.', ), 
			'ministry.voyage' => 'Journey',
			'ministry.pause' => 'Pause',
			'ministry.previous' => 'Previous nation',
			'ministry.next' => 'Next nation',
			'ministry.number' => ({required Object n}) => 'Nation no. ${n}',
			'ministry.since' => ({required Object year}) => 'Since ${year}',
			'ministry.pray' => 'Pray',
			'ministry.prayTitle' => ({required Object country}) => 'Pray for ${country}',
			'ministry.prayThanks' => ({required Object country}) => 'Give thanks for God\'s work in ${country}.',
			'ministry.prayAssemblies' => ({required Object country}) => 'Pray for the assemblies of ${country} and their leaders.',
			'ministry.prayUnreached' => ({required Object country}) => 'Pray that those who have not yet believed in ${country} meet Jesus.',
			'ministry.purpose' => 'Our purpose',
			'ministry.nations' => 'The nations',
			'ministry.search' => 'Search a nation',
			'ministry.none' => 'No nation matches',
			'ministry.homeText' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: 'Present in ${n} nation', other: 'Present in ${n} nations', ), 
			'ministry.nationsSubtitle' => 'The globe and the journey from nation to nation',
			'ministry.purposeSubtitle' => 'Our three goals',
			'ministry.missionaries' => 'Our missionaries',
			'ministry.missionariesSubtitle' => 'Those the Lord sends to the nations',
			'ministry.heroes' => 'Our heroes',
			'ministry.heroesSubtitle' => 'Those whose faith inspires us',
			'ministry.founder' => 'Our founder',
			'ministry.founderSubtitle' => 'Prof. Zacharias Tanee Fomum',
			'ministry.leader' => 'Our leader',
			'ministry.leaderSubtitle' => 'Theodore Andoseh',
			'ministry.missionariesEmpty' => 'Portraits of our missionaries are coming soon.',
			'ministry.heroesEmpty' => 'Portraits of our heroes are coming soon.',
			'ministry.personGone' => 'This portrait is no longer available.',
			'ministry.photoOf' => ({required Object name}) => 'Photo of ${name}',
			'ministry.keyDates' => 'Key dates',
			'ministry.life' => 'His life',
			'ministry.story' => 'Their story',
			'ministry.goalOf' => ({required Object n, required Object total}) => 'OUR GOAL · ${n}/${total}',
			'ministry.previousGoal' => 'Previous goal',
			'ministry.nextGoal' => 'Next goal',
			'ministry.media.books' => 'Books',
			'ministry.media.tracts' => 'Tracts',
			'ministry.media.magazines' => 'Magazines',
			'ministry.media.cds' => 'CDs',
			'ministry.media.dvds' => 'DVDs',
			'ministry.media.radio' => 'Radio',
			'ministry.media.tv' => 'Television',
			'ministry.media.internet' => 'Internet',
			'ministry.goals.crusade.title' => 'The Every-Creature Gospel Crusade',
			'ministry.goals.crusade.text' => 'To preach the gospel to everyone who will live in our generation, so that 10 billion people are reached with the gospel preached in the power of the Holy Spirit, using every means of communication (our books, tracts, magazines, CDs, DVDs, radio, television and the Internet) in the most urgent way possible.',
			'ministry.goals.crusade.reached' => 'people reached with the gospel',
			'ministry.goals.disciples.title' => 'Making disciples',
			'ministry.goals.disciples.text' => 'To bring 1 billion people in 250 nations to know Jesus Christ as Lord and Saviour, to make them disciples who obey him in all things, and to organize them to meet in 25 million house churches by the year 2065.',
			'ministry.goals.disciples.people' => 'disciples',
			'ministry.goals.disciples.nations' => 'nations',
			'ministry.goals.disciples.churches' => 'house churches',
			'ministry.goals.disciples.by' => ({required Object year}) => 'by ${year}',
			'ministry.goals.revival.title' => 'Hastening the global revival',
			'ministry.goals.revival.text' => 'To cooperate with God through fasting and intercession for the worldwide revival that will rend the heavens, shake the earth and glorify Christ in our generation, to hasten the imminent return of our Lord Jesus Christ from heaven to meet his Bride made ready.',
			'ministry.goals.revival.fasting' => 'Fasting',
			'ministry.goals.revival.intercession' => 'Intercession',
			'ministry.goals.revival.pray' => 'Pray now',
			'ministry.lives.founder.name' => 'Prof. Zacharias Tanee Fomum',
			'ministry.lives.founder.line' => '1945 – 2009 · Founder of CMFI',
			'ministry.lives.founder.facts.0' => 'CMFI founded',
			'ministry.lives.founder.facts.1' => 'books written',
			'ministry.lives.founder.facts.2' => 'nations visited',
			'ministry.lives.founder.dates.0' => 'Born on 20 June in Cameroon, into a Presbyterian family.',
			'ministry.lives.founder.dates.1' => 'Gives his life to Jesus Christ on 13 June, through a tract.',
			'ministry.lives.founder.dates.2' => 'Surrenders himself wholly to the Lord on 1 October, in Sierra Leone.',
			'ministry.lives.founder.dates.3' => 'Filled with the Holy Spirit on 24 October, after seven days of prayer.',
			'ministry.lives.founder.dates.4' => 'Founds CMFI in Yaoundé on 12 May.',
			'ministry.lives.founder.dates.5' => 'Awarded a Doctor of Science by Durham University.',
			'ministry.lives.founder.dates.6' => 'Goes to be with the Lord on 14 March.',
			'ministry.lives.founder.story.0' => 'Zacharias Tanee Fomum was born on 20 June 1945 in Cameroon, into a Presbyterian family from Batibo, in the North-West. While still a schoolboy, he gave his life to Jesus Christ on 13 June 1956, through a tract entitled “Someone died for you”.',
			'ministry.lives.founder.story.1' => 'As a student at Fourah Bay College in Sierra Leone, he surrendered himself without reserve to the Lord and to His service on 1 October 1966. On 24 October 1970, at the end of seven days of prayer and fasting, he was filled with the Holy Spirit. From then on, prayer was the centre of his life.',
			'ministry.lives.founder.story.2' => 'With a doctorate in organic chemistry from Makerere University in Uganda, he taught at the University of Yaoundé, where he became a professor. He supervised about a hundred theses and dissertations, and in 2005 Durham University, in Great Britain, awarded him a Doctor of Science for his whole body of work.',
			'ministry.lives.founder.story.3' => 'On 12 May 1975, in Yaoundé, he founded Christian Missionary Fellowship International: a movement to win souls, make disciples, plant churches and send out missionaries. He made more than 700 missionary journeys in Cameroon and more than 500 to over 70 nations, on six continents.',
			'ministry.lives.founder.story.4' => 'He spent long hours alone with God every day, led many prayer crusades, sieges and walks, and fasted often. He wrote more than 150 books on prayer, fasting, holiness, discipleship and mission, read in many languages.',
			'ministry.lives.founder.story.5' => 'With his wife, Prisca Zei Fomum, a minister to children, he had seven children, all involved in the work of the Gospel. Together they lived simply, so as to give the largest part of their income to the Gospel.',
			'ministry.lives.founder.story.6' => 'He went to be with the Lord on 14 March 2009 and was buried in Yaoundé on 21 March. The work he founded goes on among the nations.',
			'ministry.lives.leader.name' => 'Theodore Andoseh',
			'ministry.lives.leader.line' => 'Leader of CMFI since 2009',
			'ministry.lives.leader.facts.0' => 'churches planted',
			'ministry.lives.leader.facts.1' => 'years in Nigeria',
			'ministry.lives.leader.facts.2' => 'leading CMFI',
			'ministry.lives.leader.dates.0' => 'Gives his life to Jesus Christ under the preaching of Prof. Fomum.',
			'ministry.lives.leader.dates.1' => 'Consecrated a bishop in Yaoundé.',
			'ministry.lives.leader.dates.2' => 'Sent as a missionary to Nigeria with his wife, Adela.',
			'ministry.lives.leader.dates.3' => 'Takes up the leadership of CMFI.',
			'ministry.lives.leader.dates.4' => 'Brings the messages of the 3rd World Convention to members from 93 nations.',
			'ministry.lives.leader.story.0' => 'Theodore Andoseh gave his life to Jesus Christ in 1978, listening to the preaching of Prof. Zacharias Tanee Fomum, who became his spiritual father and trained him as a disciple.',
			'ministry.lives.leader.story.1' => 'He first served at his side: as a laboratory assistant at the University of Yaoundé, then as his personal assistant and private secretary. In those years he published the first revival tract, “God speaks to the man who wants to hear”, and started the first prayer chain in Yaoundé.',
			'ministry.lives.leader.story.2' => 'As a national missionary, he planted more than fifty churches in Cameroon. He was consecrated a bishop in Yaoundé in 1989.',
			'ministry.lives.leader.story.3' => 'In 1994 he left as a missionary to Nigeria with his wife, Adela. They served there for fourteen years.',
			'ministry.lives.leader.story.4' => 'Since 2009, when Prof. Fomum went to be with the Lord, he has led CMFI among the nations. In December 2019, at Koume near Bertoua, he brought the messages of the third World Convention to members from 93 nations. He is also the author of several books on serving God and building up the Church.',
			'prayer.moments.morning' => 'Morning',
			'prayer.moments.noon' => 'Noon',
			'prayer.moments.evening' => 'Evening',
			'prayer.moments.night' => 'Night',
			'prayer.retreatOf.morning' => 'Morning retreat',
			'prayer.retreatOf.noon' => 'Noon retreat',
			'prayer.retreatOf.evening' => 'Evening retreat',
			'prayer.retreatOf.night' => 'Night retreat',
			'prayer.hero.now' => ({required Object retreat}) => '${retreat} · now',
			'prayer.hero.title' => '15 minutes\nwith the Lord',
			'prayer.hero.preview.morning' => 'Give thanks, consecrate your day, your work, your family…',
			'prayer.hero.preview.noon' => 'Your assembly, your leaders, 5 people from your list, the nations…',
			'prayer.hero.preview.evening' => 'Your prayer life, your ministry, your fellow workers…',
			'prayer.hero.preview.night' => 'The sick, the Gospel among the nations, protection for the night…',
			'prayer.hero.meta' => '15 points · 1 min each',
			'prayer.hero.start' => 'Start',
			'prayer.hero.allDone' => 'All 4 retreats of the day are done. May God answer!',
			'prayer.hero.doneNow' => ({required Object retreat, required Object next}) => '${retreat} done. Next: ${next}',
			'prayer.today.toPray' => 'To pray',
			'prayer.today.week' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, zero: 'No retreat this week', one: '${n} retreat this week', other: '${n} retreats this week', ), 
			'prayer.routine.title' => 'Your daily routine',
			'prayer.routine.count' => ({required Object done}) => '${done} of 4',
			'prayer.routine.days' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: '${n} day out of 7', other: '${n} days out of 7', ), 
			'prayer.routine.week' => ({required Object time}) => '${time} this week',
			'prayer.routine.done' => 'Done · 15 min',
			'prayer.routine.now' => 'Now · 15 min',
			'prayer.routine.next' => 'Up next · 15 min',
			'prayer.routine.reminder' => ({required Object time}) => 'Reminder at ${time}',
			'prayer.routine.later.morning' => 'In the morning · 15 min',
			'prayer.routine.later.noon' => 'At noon · 15 min',
			'prayer.routine.later.evening' => 'In the evening · 15 min',
			'prayer.routine.later.night' => 'At night · 15 min',
			'prayer.together' => 'Praying together',
			'prayer.reminders.title' => 'Retreat reminders',
			'prayer.reminders.intro' => 'A reminder at the time of each retreat, only if it isn\'t done yet.',
			'prayer.reminders.off' => 'Off',
			'prayer.reminders.channel' => 'Prayer retreats',
			'prayer.reminders.body' => '15 minutes with the Lord.',
			'prayer.retreat.title' => '15-minute retreats',
			'prayer.retreat.hours.morning' => 'When you wake up',
			'prayer.retreat.hours.noon' => 'Between 12 and 2 pm',
			'prayer.retreat.hours.evening' => 'Late afternoon',
			'prayer.retreat.hours.night' => 'Before you sleep',
			'prayer.retreat.reminderAt' => ({required Object time}) => 'reminder at ${time}',
			'prayer.retreat.intro' => '15 points, one minute each. A soft sound moves you to the next one.',
			'prayer.retreat.done' => 'Done today',
			'prayer.retreat.start' => 'Start · 15 min',
			'prayer.retreat.selfPaced' => 'Read at my own pace, no timer',
			'prayer.retreat.hints.assembly' => ({required Object name}) => 'Your assembly: ${name}',
			'prayer.retreat.hints.assemblyMissing' => 'Add your assembly to your profile',
			'prayer.retreat.hints.authorities' => ({required Object names}) => 'Your authorities: ${names}',
			'prayer.retreat.hints.authoritiesMissing' => 'Add your spiritual authorities in More',
			'prayer.retreat.hints.list' => ({required Object list}) => 'My lists · ${list}',
			'prayer.retreat.hints.listEmpty' => ({required Object list}) => 'Your "${list}" list is empty: add names',
			'prayer.retreat.hints.nation' => ({required Object name}) => 'Today: ${name}',
			'prayer.retreat.hints.myCountry' => ({required Object name}) => 'Your country: ${name}',
			'prayer.retreat.hints.hymn' => 'Open the hymns',
			'prayer.session.point' => ({required Object n}) => 'Point ${n} of 15',
			'prayer.session.remaining' => 'left',
			'prayer.session.paused' => 'paused',
			'prayer.session.inYourList' => ({required Object list}) => 'In your list · ${list}',
			'prayer.session.tomorrow' => 'Tomorrow, the next ones.',
			'prayer.session.footer' => 'Screen stays on · a soft sound every minute',
			'prayer.session.previous' => 'Previous point',
			'prayer.session.next' => 'Next point',
			'prayer.session.pause' => 'Pause',
			'prayer.session.resume' => 'Resume',
			'prayer.session.soundOn' => 'Sound on',
			'prayer.session.soundOff' => 'Sound off',
			'prayer.session.finish' => 'Finish the retreat',
			'prayer.session.quitTitle' => 'Stop the retreat?',
			'prayer.session.quitText' => 'It won\'t be counted in your day.',
			'prayer.session.quit' => 'Stop',
			'prayer.session.keepPraying' => 'Keep praying',
			'prayer.session.voiceOff' => 'Read aloud',
			'prayer.session.voiceOn' => 'Reading aloud',
			'prayer.done.title' => ({required Object retreat}) => '${retreat} finished',
			'prayer.done.text' => '15 minutes with the Lord.\nHe heard every one of your prayers.',
			'prayer.done.report' => 'Added to your report',
			'prayer.done.reportDetail' => ({required Object added, required Object total}) => 'Prayer alone: +${added} min · ${total} min today',
			'prayer.done.undo' => 'Undo',
			'prayer.done.undone' => 'Retreat removed from your day.',
			'prayer.done.today' => 'Today',
			'prayer.done.count' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: '${n} retreat of 4', other: '${n} retreats of 4', ), 
			'prayer.done.verse' => '“Pray without ceasing.”',
			'prayer.done.reference' => '1 Thessalonians 5:17',
			'prayer.done.finish' => 'Finish',
			'prayer.done.hymn' => 'Sing a hymn',
			'prayer.topics.title' => 'Community topics',
			'prayer.topics.all' => 'See all',
			'prayer.topics.empty' => 'No topic at the moment. The leaders will publish the next ones here.',
			'prayer.topics.categories.church' => 'Church',
			_ => null,
		} ?? switch (path) {
			'prayer.topics.categories.nations' => 'Nations',
			'prayer.topics.categories.sick' => 'The sick',
			'prayer.topics.categories.event' => 'Event',
			'prayer.topics.categories.fasting' => 'Fasting',
			'prayer.topics.categories.other' => 'Topic',
			'prayer.topics.until' => ({required Object date}) => 'until ${date}',
			'prayer.topics.documentSize' => ({required Object kb}) => '${kb} KB',
			'prayer.topics.archive' => 'Past topics',
			'prayer.topics.archiveEmpty' => 'No past topic.',
			'prayer.topics.current' => 'At the moment',
			'prayer.topics.download' => 'Download the PDF',
			'prayer.topics.noDocument' => 'No PDF',
			'prayer.topics.openDocument' => 'Open the PDF',
			'prayer.lists.title' => 'My prayer lists',
			'prayer.lists.private' => 'Only for you',
			'prayer.lists.names.unbelievers' => 'Not yet believed',
			'prayer.lists.names.believers' => 'Believers',
			'prayer.lists.names.backsliders' => 'Backsliders',
			'prayer.lists.names.coworkers' => 'Fellow workers',
			'prayer.lists.uses.unbelievers' => 'The noon retreat prays every day for 10 people of this list (5 + 5), in turn.',
			'prayer.lists.uses.believers' => 'The noon retreat prays every day for 5 people of this list, in turn.',
			'prayer.lists.uses.backsliders' => 'The noon retreat prays every day for 5 people of this list, in turn.',
			'prayer.lists.uses.coworkers' => 'The evening retreat prays every day for 10 of your fellow workers (5 + 5), in turn.',
			'prayer.lists.privateNote' => 'Only you can see it.',
			'prayer.lists.count' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, zero: 'Nobody', one: '${n} person', other: '${n} people', ), 
			'prayer.lists.empty' => 'Nobody yet. Add the people you pray for.',
			'prayer.lists.add' => 'Add a person',
			'prayer.lists.prayedToday' => 'Today',
			'prayer.lists.next' => 'Coming up',
			'prayer.lists.answeredTitle.unbelievers' => 'Believed in the Lord',
			'prayer.lists.answeredTitle.believers' => 'Answered prayers',
			'prayer.lists.answeredTitle.backsliders' => 'Came back to the Lord',
			'prayer.lists.answeredTitle.coworkers' => 'Answered prayers',
			'prayer.lists.answeredOn.unbelievers' => ({required Object date}) => 'Believed in the Lord on ${date}',
			'prayer.lists.answeredOn.believers' => ({required Object date}) => 'Answered on ${date}',
			'prayer.lists.answeredOn.backsliders' => ({required Object date}) => 'Came back on ${date}',
			'prayer.lists.answeredOn.coworkers' => ({required Object date}) => 'Answered on ${date}',
			'prayer.lists.markAnswered.unbelievers' => 'Believed in the Lord!',
			'prayer.lists.markAnswered.believers' => 'Prayer answered',
			'prayer.lists.markAnswered.backsliders' => 'Came back to the Lord!',
			'prayer.lists.markAnswered.coworkers' => 'Prayer answered',
			'prayer.lists.answeredToast' => 'Glory to God!',
			'prayer.lists.putBack' => 'Put back in the list',
			'prayer.lists.answeredBanner' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: '${n} prayer answered this month', other: '${n} prayers answered this month', ), 
			'prayer.lists.lastAnswered' => ({required Object name, required Object what}) => '${name}: ${what}',
			'prayer.lists.sheet.addTitle' => 'Add a person',
			'prayer.lists.sheet.editTitle' => 'Edit',
			'prayer.lists.sheet.name' => 'Name',
			'prayer.lists.sheet.namePlaceholder' => 'Paul M.',
			'prayer.lists.sheet.note' => 'Note',
			'prayer.lists.sheet.notePlaceholder' => 'Colleague, neighbour, cousin…',
			'prayer.lists.sheet.list' => 'List',
			'prayer.lists.sheet.save' => 'Save',
			'prayer.lists.sheet.remove' => 'Remove from the list',
			'prayer.lists.sheet.removeTitle' => ({required Object name}) => 'Remove ${name}?',
			'prayer.lists.sheet.removeText' => 'You won\'t pray for this person in your retreats any more.',
			'prayer.lists.addShort' => 'Add',
			'prayer.importunity.title' => 'Importunity topics',
			'prayer.importunity.newTopic' => 'New topic',
			'prayer.importunity.intro' => 'A topic you bring before the Lord without growing weary, until the answer comes. Set a number of proclamations and invite your brothers and sisters to pray with you.',
			'prayer.importunity.invitedBy' => ({required Object name}) => '${name} invites you to pray',
			'prayer.importunity.join' => 'I\'ll pray with you',
			'prayer.importunity.decline' => 'Not now',
			'prayer.importunity.joined' => 'You now pray for this topic.',
			'prayer.importunity.progress' => ({required Object total, required Object goal}) => '${total} of ${goal}',
			'prayer.importunity.total' => ({required num n, required Object count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: '${count} proclamation', other: '${count} proclamations', ), 
			'prayer.importunity.reached' => 'Goal reached!',
			'prayer.importunity.closed' => 'Closed',
			'prayer.importunity.participants' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: '${n} prays', other: '${n} pray', ), 
			'prayer.importunity.mine' => ({required Object n}) => 'You: ${n}',
			'prayer.importunity.tapHint' => 'Tap at each proclamation',
			'prayer.importunity.addMany' => 'Add a number',
			'prayer.importunity.addManyTitle' => 'How many proclamations?',
			'prayer.importunity.addManyLabel' => 'Proclamations',
			'prayer.importunity.add' => 'Add',
			'prayer.importunity.pending' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: '${n} waiting to be sent', other: '${n} waiting to be sent', ), 
			'prayer.importunity.invite' => 'Invite',
			'prayer.importunity.members' => 'Praying',
			'prayer.importunity.waiting' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: '${n} invitation waiting', other: '${n} invitations waiting', ), 
			'prayer.importunity.edit' => 'Edit',
			'prayer.importunity.close' => 'Close the topic',
			'prayer.importunity.reopen' => 'Reopen the topic',
			'prayer.importunity.delete' => 'Delete the topic',
			'prayer.importunity.deleteTitle' => 'Delete this topic?',
			'prayer.importunity.deleteText' => 'It disappears for everyone praying with you.',
			'prayer.importunity.leave' => 'Leave this topic',
			'prayer.importunity.leaveTitle' => 'Leave this topic?',
			'prayer.importunity.leaveText' => 'Your proclamations stay in the total.',
			'prayer.importunity.form.newTitle' => 'New importunity topic',
			'prayer.importunity.form.editTitle' => 'Edit the topic',
			'prayer.importunity.form.subject' => 'Topic',
			'prayer.importunity.form.subjectPlaceholder' => 'Lord, save Paul',
			'prayer.importunity.form.description' => 'Details',
			'prayer.importunity.form.descriptionPlaceholder' => 'For whom, why…',
			'prayer.importunity.form.goal' => 'Goal',
			'prayer.importunity.form.goalHint' => 'The number of proclamations to reach together. Leave empty to count without a goal.',
			'prayer.importunity.form.goalPlaceholder' => '10,000',
			'prayer.importunity.form.create' => 'Create',
			'prayer.importunity.form.save' => 'Save',
			'prayer.importunity.inviteSheet.title' => 'Invite to pray',
			'prayer.importunity.inviteSheet.family' => 'My spiritual family',
			'prayer.importunity.inviteSheet.familyText' => ({required num n, required Object name}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: '${name} and their disciples: ${n} person', other: '${name} and their disciples: ${n} people', ), 
			'prayer.importunity.inviteSheet.familyMissing' => 'Link your disciple maker in My spiritual authorities to invite your spiritual family.',
			'prayer.importunity.inviteSheet.byUsername' => 'By username',
			'prayer.importunity.inviteSheet.usernameLabel' => 'Username',
			'prayer.importunity.inviteSheet.addUsername' => 'Add',
			'prayer.importunity.inviteSheet.send' => 'Send the invitations',
			'prayer.importunity.inviteSheet.sent' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, zero: 'They were already invited.', one: '${n} invitation sent', other: '${n} invitations sent', ), 
			'prayer.importunity.eyebrow' => 'Importunity topic',
			'prayer.importunity.proclaim' => 'Proclaim',
			'prayer.importunity.timer' => 'Time my prayer',
			'prayer.importunity.timeLabel' => 'Prayer time for this topic',
			'prayer.importunity.mineTime' => ({required Object n, required Object time}) => 'You: ${n} · ${time} of prayer',
			'prayer.importunity.timerNote' => 'The time is added to "Personal prayer" in your report.',
			'sending.title' => 'Send to my authorities',
			'sending.moreOff' => 'Off',
			'sending.intro' => 'At the chosen time, CMFI Connect prepares your report for the period. You just have to send it to your spiritual authorities.',
			'sending.enabled' => 'Prepare it for me regularly',
			'sending.rhythm' => 'Rhythm',
			'sending.weekly' => 'Every week',
			'sending.biweekly' => 'Every 2 weeks',
			'sending.monthly' => 'Every month',
			'sending.day' => 'Day',
			'sending.monthlyDay' => 'On the 1st of each month, for the month just ended',
			'sending.time' => 'Time',
			'sending.recipients' => 'Recipients',
			'sending.noAuthorities' => 'First add your spiritual authorities.',
			'sending.addAuthorities' => 'Add my authorities',
			'sending.viaWhatsApp' => 'By WhatsApp',
			'sending.viaEmail' => 'By e-mail',
			'sending.viaBoth' => 'By WhatsApp or e-mail',
			'sending.viaShare' => 'By sharing',
			'sending.next' => ({required Object date}) => 'Next: ${date}',
			'sending.prepareNow' => 'Prepare now',
			'sending.history' => 'Last sent',
			'sending.notificationTitle' => 'Your report is ready',
			'sending.notificationBody' => 'Send it to your authorities in one tap.',
			'sending.channel' => 'Report sending',
			'sending.readyTitle' => 'Your report is ready',
			'sending.preview' => 'Message preview',
			'sending.greeting' => ({required Object name}) => 'Hello ${name},',
			'sending.whatsApp' => 'WhatsApp',
			'sending.email' => 'E-mail',
			'sending.sharePdf' => 'Share the PDF',
			'sending.shareText' => 'Share the text',
			'sending.sent' => 'Sent',
			'sending.shared' => 'Shared',
			'sending.noRecipients' => 'Choose your recipients in the settings, or share the PDF.',
			'sending.settings' => 'Settings',
			'sending.permissionDenied' => 'Allow notifications to be told at the right time.',
			'sending.inApp' => 'Send in the app',
			'sending.viaApp' => 'In the app',
			'sending.inAppSent' => ({required Object name}) => 'Sent to ${name} in the app',
			'sending.inAppUnavailable' => ({required Object name}) => '${name} can\'t receive it in the app for now.',
			'sending.inAppHistory' => 'Sent in the app',
			'sending.replied' => 'Answered',
			'sending.seen' => 'Read',
			'sending.formerAuthority' => 'Former leader',
			'sending.theirReply' => ({required Object text}) => '“${text}”',
			'streak.title' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: '${n} day in a row!', other: '${n} days in a row!', ), 
			'streak.cardDays' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: 'day with God', other: 'days with God', ), 
			'streak.lines.week' => 'A whole week with the Lord, day after day. Well done, keep going!',
			'streak.lines.month' => 'A month of faithfulness! What you sow each day bears fruit.',
			'streak.lines.hundred' => 'A hundred days with God! Your perseverance is a beautiful testimony.',
			'streak.lines.year' => 'A whole year with God! Glory to Him for your faithfulness.',
			'streak.share' => 'Share',
			'streak.close' => 'Continue',
			'shortcuts.today' => 'Fill in my report',
			'shortcuts.hymns' => 'Hymns',
			'shortcuts.retreat' => 'Retreat of the moment',
			'blocking.report' => 'Report',
			'blocking.block' => ({required Object name}) => 'Block ${name}',
			'blocking.blockTitle' => ({required Object name}) => 'Block ${name}?',
			'blocking.blockText' => ({required Object name}) => 'You won\'t receive invitations from ${name} anymore. This invitation is removed.',
			'blocking.blockAction' => 'Block',
			'blocking.blocked' => ({required Object name}) => '${name} can no longer invite you.',
			'blocking.reportTitle' => 'Report this invitation',
			'blocking.reportText' => 'Tell us what\'s wrong: the leaders of the community will look into it.',
			'blocking.reasons.spam' => 'Unwanted',
			'blocking.reasons.offensive' => 'Shocking or offensive content',
			'blocking.reasons.other' => 'Other',
			'blocking.comment' => 'Comment',
			'blocking.commentHint' => 'What the leaders should know',
			'blocking.send' => 'Send the report',
			'blocking.reported' => 'Thank you, the leaders will look into it.',
			'blocking.listTitle' => 'Blocked members',
			'blocking.intro' => 'Their invitations to pray no longer reach you.',
			'blocking.empty' => 'You haven\'t blocked anyone.',
			'blocking.unblock' => 'Unblock',
			'blocking.unblocked' => ({required Object name}) => '${name} can invite you again.',
			'verses.title' => 'Verse of the day',
			'verses.share' => 'Share the verse',
			'verses.shareImage' => 'Share the image',
			'verses.shareText' => 'Share the text',
			'bible.title' => 'Bible',
			'bible.books' => 'Books',
			'bible.oldTestament' => 'Old Testament',
			'bible.newTestament' => 'New Testament',
			'bible.chapters' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: '${n} chapter', other: '${n} chapters', ), 
			'bible.chapter' => ({required Object n}) => 'Chapter ${n}',
			'bible.version' => 'Version',
			'bible.versions' => 'Bible version',
			'bible.search' => 'Search the Bible',
			'bible.searchHint' => 'A word, or "John 3:16"',
			'bible.searchTip' => 'Search for a word ("love") or go straight to a passage ("Psalm 23", "John 3:16").',
			'bible.searchNone' => 'No verse contains these words.',
			'bible.searchCount' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: '${n} verse', other: '${n} verses', ), 
			'bible.searchLimit' => ({required Object n}) => 'The first ${n} verses',
			'bible.searchNeedsDownload' => 'To search for words in the whole Bible, download it. You can already type a passage: "John 3:16".',
			'bible.open' => ({required Object reference}) => 'Open ${reference}',
			'bible.previous' => 'Previous chapter',
			'bible.next' => 'Next chapter',
			'bible.markRead' => 'I read this chapter',
			'bible.markedRead' => 'Read today',
			'bible.markReadHint' => 'Adds 1 chapter to "Bible reading" in your report.',
			'bible.addedToReport' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: 'Report: ${n} chapter read today', other: 'Report: ${n} chapters read today', ), 
			'bible.removedFromReport' => 'Removed from your report',
			'bible.noReadingItem' => 'Your report has no "Bible reading" item.',
			'bible.download' => 'Download this Bible',
			'bible.downloadHelp' => ({required Object size}) => 'About ${size} MB, to read and search without network.',
			'bible.downloading' => ({required Object percent}) => 'Downloading… ${percent}%',
			'bible.downloaded' => 'On your phone',
			'bible.downloadDone' => ({required Object version}) => '${version} is on your phone',
			'bible.removeDownload' => 'Remove from phone',
			'bible.removeDownloadTitle' => ({required Object version}) => 'Remove ${version} from your phone?',
			'bible.removeDownloadText' => 'The chapters you have already read stay available offline.',
			'bible.offline' => 'This chapter is not on your phone yet. Get back online, or download this Bible to read it without network.',
			'bible.notInVersion' => 'This passage is not in this version.',
			'bible.marks' => 'My verses',
			'bible.favorites' => 'Saved',
			'bible.highlights' => 'Highlighted',
			'bible.noFavorites' => 'Tap a verse, then the bookmark, to find it here.',
			'bible.noHighlights' => 'Tap a verse, then a color, to highlight it.',
			'bible.tapHint' => 'Tap a verse to highlight, save, copy or share it.',
			'bible.highlight' => ({required Object color}) => 'Highlight in ${color}',
			'bible.colors.yellow' => 'yellow',
			'bible.colors.green' => 'green',
			'bible.colors.blue' => 'blue',
			'bible.colors.pink' => 'pink',
			'bible.removeHighlight' => 'Remove the color',
			'bible.addFavorite' => 'Save to My verses',
			'bible.removeFavorite' => 'Remove from My verses',
			'bible.favoriteAdded' => 'Saved to My verses',
			'bible.favoriteRemoved' => 'Removed from My verses',
			'bible.copy' => 'Copy',
			'bible.copied' => 'Copied',
			'bible.share' => 'Share',
			'bible.closeSelection' => 'Close the selection',
			'bible.display' => 'Display',
			'bible.jesusInRed' => 'Words of Jesus in red',
			'bible.jesusInRedHelp' => 'In the versions that mark them',
			'bible.remove' => 'Remove',
			'bible.readInBible' => 'Read in the Bible',
			'bible.concordance' => 'Concordance',
			'bible.concordanceOf' => ({required Object word}) => 'Concordance of “${word}”',
			'bible.concordanceHint' => 'A word of the Bible',
			'bible.concordanceTip' => 'Type a word: the concordance shows every verse where it appears, book by book.',
			'bible.concordanceNeedsDownload' => 'The concordance goes through the whole Bible: download it first.',
			'bible.concordanceNone' => 'This word is not in this Bible.',
			'bible.exactWord' => 'This word',
			'bible.startsWith' => 'Starts with…',
			'bible.occurrences' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: 'occurrence', other: 'occurrences', ), 
			'bible.inVerses' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: 'in ${n} verse', other: 'in ${n} verses', ), 
			'bible.spread' => 'Where this word appears',
			'bible.forms' => 'Forms found',
			'bible.bookCount' => ({required Object book, required Object n}) => '${book}: ${n}',
			'bible.allBooks' => 'All books',
			'bible.pickWord' => 'Choose a word',
			'bible.pickWordHelp' => 'The concordance shows every verse where it appears.',
			'bible.more' => 'More options',
			'bible.crossReferences' => 'Cross references',
			'bible.crossReferencesOf' => ({required Object passage}) => 'Cross references · ${passage}',
			'bible.noCrossReferences' => 'No cross reference for this passage.',
			'bible.crossReferencesSource' => 'Source: OpenBible.info (CC-BY)',
			'profilePhoto.title' => 'Profile photo',
			'profilePhoto.add' => 'Add a profile photo',
			'profilePhoto.change' => 'Change the profile photo',
			'profilePhoto.seenBy' => 'Other members see it wherever your name appears.',
			'profilePhoto.camera' => 'Take a photo',
			'profilePhoto.gallery' => 'Choose from the gallery',
			'profilePhoto.remove' => 'Remove the photo',
			'profilePhoto.cropTitle' => 'Crop your photo',
			'profilePhoto.cropHint' => 'Move and enlarge the photo with your fingers.',
			'profilePhoto.use' => 'Use this photo',
			'profilePhoto.unreadable' => 'This image can\'t be opened. Choose another one.',
			'profilePhoto.saved' => 'Your profile photo is saved.',
			'profilePhoto.removed' => 'Your profile photo is removed.',
			'disciples.title' => 'My disciples',
			'disciples.empty' => 'No disciple yet',
			'disciples.emptyText' => 'When a member chooses you as their disciple maker or as an authority and you accept the request, they appear here.',
			'disciples.count' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: '${n} disciple', other: '${n} disciples', ), 
			'disciples.notShared' => 'Doesn\'t share their reports',
			'disciples.roleMaker' => 'You\'re their disciple maker',
			'disciples.roleAuthority' => 'You\'re one of their authorities',
			'disciples.dayGoals' => ({required Object percent}) => 'Goals ${percent} %',
			'disciples.dayItems' => ({required Object filled, required Object total, required Object percent}) => '${filled} of ${total} items · ${percent} %',
			'disciples.older' => 'See the previous 30 days',
			'disciples.noReports' => 'No report over this period.',
			'disciples.searchHint' => 'Name or username',
			'disciples.noMatch' => ({required Object search}) => 'No disciple matches “${search}”.',
			'weekStory.title' => 'Your week with God',
			'weekStory.range' => ({required Object from, required Object to}) => '${from} to ${to}',
			'weekStory.intro' => 'Look back on what you lived with the Lord this week.',
			'weekStory.tapHint' => 'Tap on the right to go on, on the left to go back.',
			'weekStory.faithfulLead' => 'You were faithful',
			'weekStory.emptyLead' => 'A new week is waiting for you',
			'weekStory.days' => ({required num n, required Object total}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: '${n} day\nout of ${total}', other: '${n} days\nout of ${total}', ), 
			'weekStory.streak' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: '${n} day in a row', other: '${n} days in a row', ), 
			'weekStory.streakRecord' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: '${n} day in a row: your record!', other: '${n} days in a row: your record!', ), 
			'weekStory.emptyText' => 'Fill in your report every day: your next week will be written here.',
			'weekStory.prayerLead' => 'You prayed',
			'weekStory.retreats' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: '${n} retreat', other: '${n} retreats', ), 
			'weekStory.retreatsTime' => ({required Object time}) => 'of 15 minutes · ${time} with the Lord',
			'weekStory.faithfulMoment' => ({required num n, required Object moment}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: 'Your most faithful time: ${moment} (${n} time)', other: 'Your most faithful time: ${moment} (${n} times)', ), 
			'weekStory.noRetreat' => 'No retreat this week',
			'weekStory.noRetreatText' => 'The noon retreat is waiting for you: 15 minutes with the Lord.',
			'weekStory.goalsLead' => 'Your goals',
			'weekStory.goalsReached' => 'reached on average',
			'weekStory.bestDay' => ({required Object day, required Object percent}) => 'Your best day: ${day} · ${percent}',
			'weekStory.summaryTitle' => 'My week with God',
			'weekStory.statDays' => 'days filled in',
			'weekStory.statStreak' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: 'day in a row', other: 'days in a row', ), 
			'weekStory.statRetreats' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: 'retreat', other: 'retreats', ), 
			'weekStory.statGoals' => 'of goals',
			'weekStory.share' => 'Share my week',
			'weekStory.homeText' => 'Your faithfulness, your prayer and your goals this week.',
			'weekStory.open' => 'See my week',
			'weekStory.notificationTitle' => 'Your week with God is ready',
			'weekStory.notificationBody' => 'Look back on your faithfulness this week and share it.',
			'weekStory.channel' => 'Your week with God',
			'weekStory.thisWeek' => 'This week',
			'weekStory.pastWeeks' => 'Past weeks',
			'weekStory.weekOf' => ({required Object date}) => 'Week of ${date}',
			'weekStory.page' => ({required Object current, required Object total}) => '${current} of ${total}',
			'yearStory.title' => 'Your year with God',
			'yearStory.since' => ({required Object date}) => 'Since ${date}',
			'yearStory.intro' => 'Look back on all you lived with the Lord this year.',
			'yearStory.tapHint' => 'Tap on the right to go on, on the left to go back.',
			'yearStory.page' => ({required Object current, required Object total}) => '${current} of ${total}',
			'yearStory.faithfulLead' => 'You were faithful',
			'yearStory.days' => ({required num n, required Object total}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: '${n} day\nout of ${total}', other: '${n} days\nout of ${total}', ), 
			'yearStory.bestStreak' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: 'Your longest streak: ${n} day', other: 'Your longest streak: ${n} days in a row', ), 
			'yearStory.faithfulMonth' => ({required num n, required Object month}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: 'Your most faithful month: ${month} (${n} day)', other: 'Your most faithful month: ${month} (${n} days)', ), 
			'yearStory.prayerLead' => 'You prayed',
			'yearStory.retreats' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: '${n} retreat', other: '${n} retreats', ), 
			'yearStory.retreatsTime' => ({required Object time}) => 'of 15 minutes · ${time} with the Lord',
			'yearStory.prayerAlone' => ({required Object time}) => '${time} of personal prayer',
			'yearStory.prayerAloneText' => 'of personal prayer with the Lord',
			'yearStory.faithfulMoment' => ({required num n, required Object moment}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: 'Your most faithful time: ${moment} (${n} time)', other: 'Your most faithful time: ${moment} (${n} times)', ), 
			'yearStory.wordLead' => 'You read the Word',
			'yearStory.memoryLead' => 'You hid the Word in your heart',
			'yearStory.chapters' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: '${n} chapter', other: '${n} chapters', ), 
			'yearStory.bibleShare' => ({required Object percent}) => '${percent} of the Bible',
			'yearStory.wholeBible' => 'As much as the whole Bible!',
			'yearStory.versesKnown' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: 'verse learnt by heart', other: 'verses learnt by heart', ), 
			'yearStory.versesLearning' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: 'verse being memorized', other: 'verses being memorized', ), 
			'yearStory.fastLead' => 'You fasted',
			'yearStory.fastDays' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: '${n} day', other: '${n} days', ), 
			'yearStory.fastText' => 'of fasting before the Lord',
			'yearStory.fullFasts' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: 'day of full fast', other: 'days of full fast', ), 
			'yearStory.partialFasts' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: 'day of partial fast', other: 'days of partial fast', ), 
			'yearStory.goalsLead' => 'Your goals',
			'yearStory.goalsReached' => 'reached on average',
			'yearStory.bestMonth' => ({required Object month, required Object percent}) => 'Your best month: ${month} · ${percent}',
			'yearStory.summaryTitle' => 'My year with God',
			'yearStory.statDays' => 'days filled in',
			'yearStory.statStreak' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: 'day in a row, your record', other: 'days in a row, your record', ), 
			'yearStory.statRetreats' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: 'retreat', other: 'retreats', ), 
			'yearStory.statPrayer' => 'of personal prayer',
			'yearStory.statChapters' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: 'chapter read', other: 'chapters read', ), 
			'yearStory.statFasts' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: 'day of fasting', other: 'days of fasting', ), 
			'yearStory.statGoals' => 'of goals',
			'yearStory.emptyText' => 'Fill in your report every day: your year will be written here.',
			'yearStory.share' => 'Share my year',
			'yearStory.homeText' => ({required Object year}) => 'Your faithfulness, your prayer, the Word: look back on all you lived with God in ${year}.',
			'yearStory.open' => 'See my year',
			'yearStory.notificationTitle' => 'Your year with God is ready',
			'yearStory.notificationBody' => ({required Object year}) => 'Look back on all you lived with the Lord in ${year}, and share it.',
			'yearStory.channel' => 'Your year with God',
			'yearStory.moreTitle' => 'My year with God',
			'yearStory.moreSoFar' => ({required Object year}) => '${year} so far',
			'yearStory.moreDone' => ({required Object year}) => 'All of ${year}',
			'seekFirst.title' => 'Seek God first',
			'seekFirst.verse' => 'But seek first God’s Kingdom and his righteousness; and all these things will be given to you as well.',
			'seekFirst.verseRef' => 'Matthew 6:33',
			'seekFirst.intro' => 'Each day, the apps you choose stay closed until your daily report is saved. Start your day with God; the rest follows.',
			'seekFirst.enable' => 'Turn on',
			'seekFirst.apps' => 'Apps to keep closed',
			'seekFirst.appsNone' => 'No app chosen',
			'seekFirst.appCount' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: '${n} app', other: '${n} apps', ), 
			'seekFirst.categoryCount' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: '${n} category', other: '${n} categories', ), 
			'seekFirst.siteCount' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: '${n} site', other: '${n} sites', ), 
			'seekFirst.start' => 'Closed from',
			'seekFirst.pauses' => '5-minute breaks',
			'seekFirst.pausesText' => '3 a day, for an emergency',
			'seekFirst.pausesLeft' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, zero: 'No break left today', one: '${n} break left today', other: '${n} breaks left today', ), 
			'seekFirst.todayOpen' => 'Today your apps are open: you sought God first.',
			'seekFirst.todayLocked' => 'Your apps stay closed until today\'s report.',
			'seekFirst.todayBefore' => ({required Object time}) => 'Your apps will close at ${time} if your report isn\'t saved yet.',
			'seekFirst.fillReport' => 'Fill in my report',
			'seekFirst.denied' => 'Without Screen Time access, CMFI Connect can\'t close apps. You can allow it in Settings › Screen Time.',
			'seekFirst.noApps' => 'Choose at least one app to keep closed.',
			'seekFirst.unsupported' => 'Coming soon to this phone.',
			'seekFirst.moreOn' => ({required Object time}) => 'From ${time}, until your report',
			'seekFirst.moreOff' => 'Close apps until your report is done',
			'seekFirst.privacy' => 'CMFI Connect never sees the apps you choose: your iPhone keeps them to itself.',
			'seekFirst.shield.title' => 'Seek God first',
			'seekFirst.shield.subtitle' => ({required Object app}) => '${app} stays closed until today\'s report.',
			'seekFirst.shield.thisApp' => 'This app',
			'seekFirst.shield.fill' => 'Fill in my report',
			'seekFirst.shield.pause' => ({required Object n}) => '5-min break (${n}/3)',
			'seekFirst.shield.notificationTitle' => 'Seek God first',
			'seekFirst.shield.notificationBody' => 'Tap here to fill in your report.',
			'seekFirst.shield.serviceBody' => 'Your apps close each day until your report.',
			'seekFirst.permissionsAndroid' => 'To close your apps, CMFI Connect needs two permissions, to turn on in the settings that will open: "Usage access" (to know which app is open) and "Display over other apps" (to show the Seek God first screen). Nothing leaves your phone.',
			'seekFirst.permissionsContinue' => 'Continue',
			'seekFirst.deniedAndroid' => 'Without these two permissions, CMFI Connect can\'t close apps. You can turn them on in Settings › Apps › Special access.',
			'seekFirst.privacyAndroid' => 'The apps you choose stay on your phone: CMFI Connect never sends them.',
			'documents.title' => 'Our documents',
			'documents.subtitle' => 'Teachings, rules, forms…',
			'documents.moreSubtitle' => 'The library of the community',
			'documents.search' => 'Search a document',
			'documents.all' => 'All',
			'documents.empty' => 'No document yet. The documents the community publishes will show here.',
			'documents.none' => 'No document matches your search.',
			'documents.sizeKb' => ({required Object n}) => '${n} KB',
			'documents.sizeMb' => ({required Object n}) => '${n} MB',
			'documents.pdf' => 'PDF',
			'documents.word' => 'Word',
			'documents.open' => 'Open the document',
			'documents.download' => 'Download',
			'documents.count' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: '${n} document', other: '${n} documents', ), 
			'documents.more' => 'Show more',
			'biblePlan.title' => 'Reading plan',
			'biblePlan.duration' => 'Length',
			'biblePlan.months3' => '3 months',
			'biblePlan.months6' => '6 months',
			'biblePlan.year' => '1 year',
			'biblePlan.custom' => 'Other',
			'biblePlan.unitMonths' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: 'month', other: 'months', ), 
			'biblePlan.unitYear' => 'year',
			'biblePlan.days' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: '${n} day', other: '${n} days', ), 
			'biblePlan.scope' => 'What you read',
			'biblePlan.scopes.bible' => 'The whole Bible',
			'biblePlan.scopes.newTestament' => 'The New Testament',
			'biblePlan.scopes.oldTestament' => 'The Old Testament',
			'biblePlan.scopes.psalmsProverbs' => 'Psalms and Proverbs',
			'biblePlan.chaptersShort' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: '${n} ch.', other: '${n} ch.', ), 
			'biblePlan.oldTestament' => 'Old Testament',
			'biblePlan.newTestament' => 'New Testament',
			'biblePlan.order' => 'Order',
			'biblePlan.orders.canonical' => 'Book by book',
			'biblePlan.orders.parallel' => 'OT + NT each day',
			'biblePlan.reminder' => 'Daily reminder',
			'biblePlan.reminderAt' => 'Reminder time',
			'biblePlan.summary' => ({required Object chapters, required Object days, required Object perDay}) => '${chapters} chapters in ${days} days, about ${perDay} a day',
			'biblePlan.chapterCount' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: '${n} chapter', other: '${n} chapters', ), 
			'biblePlan.inDays' => ({required Object days}) => 'in ${days}',
			'biblePlan.perDayAbout' => ({required Object perDay}) => 'about ${perDay} a day',
			'biblePlan.endsOn' => ({required Object date}) => 'Ends on ${date}',
			'biblePlan.startsOn' => ({required Object date}) => 'The plan starts on ${date}.',
			'biblePlan.start' => 'Start the plan',
			'biblePlan.dayOf' => ({required Object day, required Object total}) => 'Day ${day} of ${total}',
			'biblePlan.today' => 'Today\'s reading',
			'biblePlan.todayDone' => 'Today\'s reading is done. Well done!',
			'biblePlan.read' => 'Read',
			'biblePlan.behind' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: '${n} day behind', other: '${n} days behind', ), 
			'biblePlan.catchUp' => 'Tap here to see the chapters to catch up.',
			'biblePlan.catchUpShort' => 'catch up',
			'biblePlan.chaptersRead' => ({required Object read, required Object total}) => '${read} of ${total} chapters',
			'biblePlan.late' => 'Late',
			'biblePlan.upcoming' => 'Coming up',
			'biblePlan.dayNumber' => ({required Object n}) => 'Day ${n}',
			'biblePlan.finished' => 'Plan finished! You read it all.',
			'biblePlan.stop' => 'Stop the plan',
			'biblePlan.stopTitle' => 'Stop this plan?',
			'biblePlan.stopText' => 'Your progress in this plan will be erased. The chapters counted in your reports stay there.',
			'biblePlan.reminderTitle' => 'Today\'s reading',
			'biblePlan.reminderChannel' => 'Reading plan',
			'biblePlan.homeTitle' => 'Today\'s reading',
			'biblePlan.check' => ({required Object chapter}) => 'Mark ${chapter} as read',
			'biblePlan.uncheck' => ({required Object chapter}) => '${chapter}: read',
			'teachings.title' => 'Teachings',
			'teachings.subtitle' => 'Hear the Word wherever you are',
			'teachings.search' => 'Search a message, a speaker…',
			'teachings.all' => 'All',
			'teachings.downloadedChip' => 'Downloaded',
			'teachings.count' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: '${n} message', other: '${n} messages', ), 
			'teachings.empty' => 'No teachings yet.',
			'teachings.none' => 'No teaching matches.',
			'teachings.noneDownloaded' => 'No message downloaded. Tap a message\'s cloud to listen without network.',
			'teachings.more' => 'See more',
			'teachings.offline' => 'No network: here are the messages kept on your phone.',
			'teachings.play' => 'Listen',
			'teachings.pause' => 'Pause',
			'teachings.heard' => 'Heard',
			'teachings.download' => 'Download to listen offline',
			'teachings.downloaded' => 'Kept on your phone',
			'teachings.removed' => 'Removed from the phone',
			'teachings.cancelDownload' => 'Stop the download',
			'teachings.removeDownload' => 'Remove from the phone',
			'teachings.back15' => 'Back 15 seconds',
			'teachings.forward15' => 'Forward 15 seconds',
			'teachings.speed' => ({required Object speed}) => 'Speed ${speed}',
			'teachings.recordedOn' => ({required Object date}) => 'Message of ${date}',
			'teachings.moreSubtitle' => 'Sermons and teachings to listen to',
			'teachings.closePlayer' => 'Close the player',
			'memorize.title' => 'Memorization',
			'memorize.subtitle' => 'Hide the Word in your heart',
			'memorize.toReview' => 'To review',
			'memorize.learning' => 'Learning',
			'memorize.known' => 'Known',
			_ => null,
		} ?? switch (path) {
			'memorize.reviewCount' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: 'Review ${n} verse', other: 'Review ${n} verses', ), 
			'memorize.nothingDue' => 'Nothing to review today.',
			'memorize.nextOn' => ({required Object date}) => 'Next review: ${date}.',
			'memorize.tomorrow' => 'tomorrow',
			'memorize.reminder' => 'Review reminder',
			'memorize.reminderAt' => 'Reminder time',
			'memorize.myVerses' => 'My verses',
			'memorize.howToAdd' => 'To add one: in the Bible, tap a verse, then the brain in the bar.',
			'memorize.empty' => 'No verse to memorize yet.',
			'memorize.openBible' => 'Open the Bible',
			'memorize.late' => 'Late',
			'memorize.today' => 'Today',
			'memorize.dueIn' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: 'In ${n} day', other: 'In ${n} days', ), 
			'memorize.stages.fresh' => 'New',
			'memorize.stages.learning' => 'Learning',
			'memorize.stages.known' => 'Known',
			'memorize.stats' => ({required Object stage, required Object lapses}) => '${stage} · forgotten ${lapses} times',
			'memorize.reviewNow' => 'Review now',
			'memorize.remove' => 'Remove',
			'memorize.removeTitle' => 'Remove this verse?',
			'memorize.removeText' => 'Its progress will be erased.',
			'memorize.removed' => 'Verse removed',
			'memorize.progress' => ({required Object done, required Object total}) => '${done} / ${total}',
			'memorize.show' => 'Show the verse',
			'memorize.hints.full' => 'Text',
			'memorize.hints.gaps' => 'Gaps',
			'memorize.hints.initials' => 'Initials',
			'memorize.hints.none' => 'None',
			'memorize.recite' => 'Recite the verse, then check.',
			'memorize.grades.again' => 'Again',
			'memorize.grades.hard' => 'Hard',
			'memorize.grades.good' => 'Good',
			'memorize.grades.easy' => 'Easy',
			'memorize.now' => 'Right away',
			'memorize.later' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: '${n} day', other: '${n} days', ), 
			'memorize.doneTitle' => 'Reviews done!',
			'memorize.doneText' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: 'You reviewed ${n} verse. May the Word dwell in you!', other: 'You reviewed ${n} verses. May the Word dwell in you!', ), 
			'memorize.back' => 'Back',
			'memorize.reminderTitle' => 'Your verses to review',
			'memorize.reminderBody' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: '${n} verse is waiting for you today.', other: '${n} verses are waiting for you today.', ), 
			'memorize.reminderChannel' => 'Memorization',
			'memorize.homeTitle' => 'Verses to review',
			'memorize.homeText' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: '${n} verse waiting', other: '${n} verses waiting', ), 
			'memorize.menu' => 'Memorize verses',
			'memorize.memorize' => 'Memorize',
			'memorize.added' => 'Added to your verses to memorize',
			'memorize.already' => 'This passage is already in your verses',
			'souls.title' => 'Soul follow-up',
			'souls.subtitle' => '"He who wins souls is wise." Proverbs 11:30',
			'souls.search' => 'Search a person…',
			'souls.people' => 'People',
			'souls.received' => 'Received Jesus',
			'souls.toContact' => 'To contact',
			'souls.all' => 'All',
			'souls.stages.met' => 'Met',
			'souls.stages.interested' => 'Interested',
			'souls.stages.received' => 'Received Jesus',
			'souls.stages.followUp' => 'Being grounded',
			'souls.stages.church' => 'Comes to church',
			'souls.stages.baptized' => 'Baptized',
			'souls.contactSection' => 'To contact again',
			'souls.everyone' => 'Everyone',
			'souls.contactToday' => 'Contact today',
			'souls.contactLate' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: '${n} day late', other: '${n} days late', ), 
			'souls.contactOn' => ({required Object date}) => 'Next contact on ${date}',
			'souls.empty' => 'Note here the people you share the Gospel with: pray for them and follow them to church.',
			'souls.none' => 'Nobody matches.',
			'souls.add' => 'Add',
			'souls.addTitle' => 'New person',
			'souls.editTitle' => 'Edit',
			'souls.name' => 'Name',
			'souls.nameRequired' => 'Write their name.',
			'souls.phone' => 'Phone',
			'souls.place' => 'Where you met',
			'souls.metOn' => 'Met on',
			'souls.stage' => 'Where is this person?',
			'souls.firstNote' => 'A note (optional)',
			'souls.noteHint' => 'What was said, prayer requests…',
			'souls.save' => 'Save',
			'souls.saved' => 'Saved',
			'souls.call' => 'Call',
			'souls.whatsApp' => 'WhatsApp',
			'souls.sms' => 'Text',
			'souls.edit' => 'Edit',
			'souls.delete' => 'Delete',
			'souls.deleteTitle' => ({required Object name}) => 'Delete ${name}?',
			'souls.deleteText' => 'Their notes will be erased from your phone.',
			'souls.deleted' => 'Deleted',
			'souls.nextContact' => 'Next contact',
			'souls.plan' => 'Plan a reminder',
			'souls.change' => 'Change the date',
			'souls.clear' => 'Remove the reminder',
			'souls.noContact' => 'No reminder planned',
			'souls.metAt' => ({required Object date}) => 'Met on ${date}',
			'souls.notes' => 'Notes',
			'souls.addNote' => 'Add the note',
			'souls.noNotes' => 'No notes yet.',
			'souls.deleteNote' => 'Delete the note',
			'souls.export' => 'Export (spreadsheet)',
			'souls.csv.name' => 'Name',
			'souls.csv.phone' => 'Phone',
			'souls.csv.place' => 'Place',
			'souls.csv.metOn' => 'Met on',
			'souls.csv.stage' => 'Stage',
			'souls.csv.next' => 'Next contact',
			'souls.csv.notes' => 'Notes',
			'souls.lock' => ({required Object method}) => 'Lock with ${method}',
			'souls.lockedTitle' => 'Your soul follow-up is locked',
			'souls.unlock' => 'Unlock',
			'souls.unlockReason' => 'Open your soul follow-up',
			'souls.privacy' => 'This information stays on your phone: it is never sent.',
			'souls.reminderTitle' => 'Soul follow-up',
			'souls.reminderBody' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: '${n} person to contact today.', other: '${n} people to contact today.', ), 
			'souls.reminderChannel' => 'Soul follow-up',
			'souls.moreSubtitle' => 'The people you share the Gospel with',
			'souls.prayToday' => 'Today, pray for',
			'souls.prayerReminder' => 'Remind me each morning',
			'souls.prayerReminderAt' => 'Prayer reminder time',
			'souls.prayerTitle' => 'Pray for a soul',
			'souls.prayerBody' => 'Take a moment to pray for today\'s person.',
			'souls.prayerChannel' => 'Prayer for souls',
			'fasts.title' => 'My fasts',
			'fasts.intro' => 'Set yourself apart for God: choose your fast and what you fast for. Each day kept counts in your report.',
			'fasts.moreSubtitle' => 'Full or partial fast, counted each day',
			'fasts.kind' => 'Your fast',
			'fasts.kinds.full' => 'Full fast',
			'fasts.kinds.partial' => 'Partial fast',
			'fasts.kindTexts.full' => 'Day and night, 24 hours a day, from now.',
			'fasts.kindTexts.partial' => 'Each day until the time you choose, then you break the fast.',
			'fasts.length' => 'Length',
			'fasts.days' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: '${n} day', other: '${n} days', ), 
			'fasts.endEachDay' => 'End of the fast each day',
			'fasts.topics' => 'I fast for',
			'fasts.topicHint' => 'A prayer request…',
			'fasts.addTopic' => 'Add the request',
			'fasts.removeTopic' => 'Remove the request',
			'fasts.history' => 'My last fasts',
			'fasts.kept' => ({required Object kept, required Object days}) => '${kept}/${days} days',
			'fasts.start' => 'Start the fast',
			'fasts.until' => ({required Object date}) => 'Until ${date}',
			'fasts.hoursLeft' => ({required Object h, required Object m}) => '${h} h ${m}',
			'fasts.minutesLeft' => ({required Object m}) => '${m} min',
			'fasts.dayOf' => ({required Object day, required Object total}) => 'Day ${day} of ${total}',
			'fasts.dayEnds' => ({required Object time}) => 'This day ends at ${time}',
			'fasts.stop' => 'Break the fast',
			'fasts.stopTitle' => 'Break your fast?',
			'fasts.stopText' => 'The days already kept stay counted. The day under way will not be.',
			'fasts.counted' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: '${n} day of fasting counted in your report', other: '${n} days of fasting counted in your report', ), 
			'fasts.reportNote' => ({required Object item}) => 'Each day kept adds 1 to "${item}" in your report.',
			'fasts.items.full' => 'Full fast',
			'fasts.items.partial' => 'Partial fast',
			'fasts.dayTitle' => ({required Object day}) => 'Day ${day} of fasting done',
			'fasts.dayBody' => 'It counts in your report. Take heart, keep going!',
			'fasts.endTitle' => 'Your fast is over',
			'fasts.endBody' => 'May the Lord answer your prayers.',
			'fasts.channel' => 'My fasts',
			'fasts.homeTitle' => ({required Object day, required Object total}) => 'Fast · day ${day} of ${total}',
			'fasts.homeText' => ({required Object time}) => 'This day ends at ${time}',
			'received.title' => 'Reports received',
			'received.subtitle' => 'Sent by your disciples in the app',
			'received.unreadCount' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: '${n} new', other: '${n} new', ), 
			'received.empty' => 'No report received yet. When a disciple sends you theirs in the app, it arrives here.',
			'received.day' => ({required Object date}) => 'On ${date}',
			'received.period' => ({required Object from, required Object to}) => '${from} to ${to}',
			'received.unread' => 'New',
			'received.yourReply' => ({required Object text}) => 'Your answer: “${text}”',
			'received.open' => 'View',
			'received.encourage' => 'Encourage',
			'received.editReply' => 'Edit',
			'received.encourageTitle' => ({required Object name}) => 'A word for ${name}',
			'received.suggestions.0' => 'Faithful indeed, keep going!',
			'received.suggestions.1' => 'I\'m praying for you.',
			'received.suggestions.2' => 'May God strengthen you!',
			'received.suggestions.3' => 'Well done for persevering.',
			'received.hint' => 'Write your encouragement…',
			'received.send' => 'Send',
			'received.sent' => ({required Object name}) => '${name} got your word',
			_ => null,
		};
	}
}
