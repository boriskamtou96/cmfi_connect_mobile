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
	@override late final _Translations$onboarding$en onboarding = _Translations$onboarding$en._(_root);
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
	@override late final _Translations$profilePhoto$en profilePhoto = _Translations$profilePhoto$en._(_root);
	@override late final _Translations$disciples$en disciples = _Translations$disciples$en._(_root);
	@override late final _Translations$weekStory$en weekStory = _Translations$weekStory$en._(_root);
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

// Path: onboarding
class _Translations$onboarding$en extends Translations$onboarding$fr {
	_Translations$onboarding$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get skip => 'Skip';
	@override String get next => 'Next';
	@override String get start => 'Get started';
	@override String step({required Object current, required Object total}) => 'Screen ${current} of ${total}';
	@override late final _Translations$onboarding$reports$en reports = _Translations$onboarding$reports$en._(_root);
	@override late final _Translations$onboarding$worship$en worship = _Translations$onboarding$worship$en._(_root);
	@override late final _Translations$onboarding$community$en community = _Translations$onboarding$community$en._(_root);
	@override late final _Translations$onboarding$sample$en sample = _Translations$onboarding$sample$en._(_root);
}

// Path: welcome
class _Translations$welcome$en extends Translations$welcome$fr {
	_Translations$welcome$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Welcome to CMFI Connect';
	@override String get text => 'Create your account in a minute to fill in your daily report and follow your community\'s life.';
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
	@override String get more => 'More';
}

// Path: home
class _Translations$home$en extends Translations$home$fr {
	_Translations$home$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String greeting({required Object name}) => 'Hello ${name}';
	@override String get greetingNoName => 'Hello';
	@override String get profile => 'My profile';
	@override String get todayTitle => 'Today\'s report';
	@override String progress({required Object filled, required Object total}) => '${filled} of ${total}';
	@override String get progressLabel => 'items filled in';
	@override String get goals => 'goals';
	@override String get continueReport => 'Continue';
	@override String get startReport => 'Start';
	@override String get weekTitle => 'Your week';
	@override String weekScore({required num filled, required Object total}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(filled,
		one: '${filled} day out of ${total}',
		other: '${filled} days out of ${total}',
	);
	@override String get community => 'Currently at CMFI';
	@override String get eventsTitle => 'Events';
	@override String get hymnsTitle => 'Hymns';
	@override String hymnsResume({required Object number}) => 'Go back to No. ${number}';
	@override String get hymnsOpen => 'Open the hymn book';
	@override String streak({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: '${n} day in a row',
		other: '${n} days in a row',
	);
	@override String get streakKeep => 'Fill in today to keep it going';
	@override String get streakToday => 'Well done, keep it up tomorrow!';
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
	@override String received({required Object title}) => 'New notification: ${title}';
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
	@override String get monthly => 'Monthly';
	@override String perYear({required Object price}) => '${price} / year';
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

// Path: onboarding.reports
class _Translations$onboarding$reports$en extends Translations$onboarding$reports$fr {
	_Translations$onboarding$reports$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Your walk with God, day after day';
	@override String get text => 'Log your Bible reading, prayer and fasting in seconds… and watch your progress week after week.';
}

// Path: onboarding.worship
class _Translations$onboarding$worship$en extends Translations$onboarding$worship$fr {
	_Translations$onboarding$worship$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Sing and pray, wherever you are';
	@override String get text => 'Find the community\'s hymns and carry the prayer topics with your brothers and sisters every day.';
}

// Path: onboarding.community
class _Translations$onboarding$community$en extends Translations$onboarding$community$fr {
	_Translations$onboarding$community$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Stay close to your community';
	@override String get text => 'Your assembly\'s events and announcements, all in one place, so you never miss a thing.';
}

// Path: onboarding.sample
class _Translations$onboarding$sample$en extends Translations$onboarding$sample$fr {
	_Translations$onboarding$sample$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get today => 'Today';
	@override String get bibleReading => 'Bible reading';
	@override String get prayerAlone => 'Prayer alone';
	@override String get meditation => 'Meditation';
	@override String get groupPrayer => 'Group prayer';
	@override String get thisWeek => 'This week';
	@override String get weekScore => '4 days out of 5';
	@override String get hymn => 'Hymn';
	@override String get hymnNumber => 'No. 12';
	@override String get fullScreen => 'Full screen';
	@override String get prayerOfTheDay => 'Prayer topic of the day';
	@override String get prayerTopic => 'For our young people\'s exams';
	@override String get praying => '12 people are praying';
	@override String get iPray => 'I pray';
	@override String get vigil => 'Prayer vigil';
	@override String get vigilMeta => '8 pm · Local assembly';
	@override String get join => 'I\'m going';
	@override String get retreat => 'Youth retreat';
	@override String get retreatMeta => 'All day';
	@override String get announcement => 'Announcement';
	@override String get announcementText => 'Sunday service starts at 8:30 am.';
	@override String get chapters => '10 ch.';
}

// Path: auth.login
class _Translations$auth$login$en extends Translations$auth$login$fr {
	_Translations$auth$login$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Welcome back';
	@override String get subtitle => 'Sign in to fill in today\'s report.';
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
	@override String points({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: '${n} point',
		other: '${n} points',
	);
	@override String until({required Object date}) => 'until ${date}';
	@override String since({required Object date}) => 'since ${date}';
	@override String people({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		zero: 'Nobody yet',
		one: '${n} prays',
		other: '${n} pray',
	);
	@override String get withPdf => 'With the PDF';
	@override String get isNew => 'New';
	@override String get screenTitle => 'Prayer topic';
	@override String period({required Object from, required Object to}) => 'From ${from} to ${to}';
	@override String peopleBanner({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		zero: 'Be the first to pray for these points.',
		one: '${n} brother or sister prays for these points',
		other: '${n} brothers and sisters pray for these points',
	);
	@override String prayedToday({required Object count, required Object prayed}) => '${count} · ${prayed} prayed today';
	@override String get document => 'Original document';
	@override String documentSize({required Object kb}) => '${kb} KB';
	@override String get prayAll => 'I prayed for all these points';
	@override String get allPrayed => 'All prayed today';
	@override String get archive => 'Past topics';
	@override String get archiveEmpty => 'No past topic.';
	@override String get current => 'At the moment';
	@override String shareText({required Object title, required Object points}) => '${title}\n\n${points}\n\nLet\'s pray together in the CMFI Connect app.';
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
			'onboarding.skip' => 'Skip',
			'onboarding.next' => 'Next',
			'onboarding.start' => 'Get started',
			'onboarding.step' => ({required Object current, required Object total}) => 'Screen ${current} of ${total}',
			'onboarding.reports.title' => 'Your walk with God, day after day',
			'onboarding.reports.text' => 'Log your Bible reading, prayer and fasting in seconds… and watch your progress week after week.',
			'onboarding.worship.title' => 'Sing and pray, wherever you are',
			'onboarding.worship.text' => 'Find the community\'s hymns and carry the prayer topics with your brothers and sisters every day.',
			'onboarding.community.title' => 'Stay close to your community',
			'onboarding.community.text' => 'Your assembly\'s events and announcements, all in one place, so you never miss a thing.',
			'onboarding.sample.today' => 'Today',
			'onboarding.sample.bibleReading' => 'Bible reading',
			'onboarding.sample.prayerAlone' => 'Prayer alone',
			'onboarding.sample.meditation' => 'Meditation',
			'onboarding.sample.groupPrayer' => 'Group prayer',
			'onboarding.sample.thisWeek' => 'This week',
			'onboarding.sample.weekScore' => '4 days out of 5',
			'onboarding.sample.hymn' => 'Hymn',
			'onboarding.sample.hymnNumber' => 'No. 12',
			'onboarding.sample.fullScreen' => 'Full screen',
			'onboarding.sample.prayerOfTheDay' => 'Prayer topic of the day',
			'onboarding.sample.prayerTopic' => 'For our young people\'s exams',
			'onboarding.sample.praying' => '12 people are praying',
			'onboarding.sample.iPray' => 'I pray',
			'onboarding.sample.vigil' => 'Prayer vigil',
			'onboarding.sample.vigilMeta' => '8 pm · Local assembly',
			'onboarding.sample.join' => 'I\'m going',
			'onboarding.sample.retreat' => 'Youth retreat',
			'onboarding.sample.retreatMeta' => 'All day',
			'onboarding.sample.announcement' => 'Announcement',
			'onboarding.sample.announcementText' => 'Sunday service starts at 8:30 am.',
			'onboarding.sample.chapters' => '10 ch.',
			'welcome.title' => 'Welcome to CMFI Connect',
			'welcome.text' => 'Create your account in a minute to fill in your daily report and follow your community\'s life.',
			'welcome.createAccount' => 'Create my account',
			'welcome.haveAccount' => 'I already have an account',
			'auth.phone' => 'Phone',
			'auth.dialCode' => ({required Object code}) => 'Country code: ${code}',
			'auth.password' => 'Password',
			'auth.showPassword' => 'Show password',
			'auth.hidePassword' => 'Hide password',
			'auth.login.title' => 'Welcome back',
			'auth.login.subtitle' => 'Sign in to fill in today\'s report.',
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
			'countries.dialCodeTitle' => 'Country code',
			'countries.title' => 'Your country',
			'countries.search' => 'Search a country or a code',
			'countries.none' => 'No country matches',
			'countries.change' => 'Change country',
			'nav.home' => 'Home',
			'nav.reports' => 'Report',
			'nav.hymns' => 'Hymns',
			'nav.prayer' => 'Prayer',
			'nav.more' => 'More',
			'home.greeting' => ({required Object name}) => 'Hello ${name}',
			'home.greetingNoName' => 'Hello',
			'home.profile' => 'My profile',
			'home.todayTitle' => 'Today\'s report',
			'home.progress' => ({required Object filled, required Object total}) => '${filled} of ${total}',
			'home.progressLabel' => 'items filled in',
			'home.goals' => 'goals',
			'home.continueReport' => 'Continue',
			'home.startReport' => 'Start',
			'home.weekTitle' => 'Your week',
			'home.weekScore' => ({required num filled, required Object total}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(filled, one: '${filled} day out of ${total}', other: '${filled} days out of ${total}', ), 
			'home.community' => 'Currently at CMFI',
			'home.eventsTitle' => 'Events',
			'home.hymnsTitle' => 'Hymns',
			'home.hymnsResume' => ({required Object number}) => 'Go back to No. ${number}',
			'home.hymnsOpen' => 'Open the hymn book',
			'home.streak' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: '${n} day in a row', other: '${n} days in a row', ), 
			'home.streakKeep' => 'Fill in today to keep it going',
			'home.streakToday' => 'Well done, keep it up tomorrow!',
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
			_ => null,
		} ?? switch (path) {
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
			'notifications.received' => ({required Object title}) => 'New notification: ${title}',
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
			'premium.monthly' => 'Monthly',
			'premium.perYear' => ({required Object price}) => '${price} / year',
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
			'prayer.topics.categories.nations' => 'Nations',
			'prayer.topics.categories.sick' => 'The sick',
			'prayer.topics.categories.event' => 'Event',
			'prayer.topics.categories.fasting' => 'Fasting',
			'prayer.topics.categories.other' => 'Topic',
			'prayer.topics.points' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: '${n} point', other: '${n} points', ), 
			'prayer.topics.until' => ({required Object date}) => 'until ${date}',
			'prayer.topics.since' => ({required Object date}) => 'since ${date}',
			'prayer.topics.people' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, zero: 'Nobody yet', one: '${n} prays', other: '${n} pray', ), 
			'prayer.topics.withPdf' => 'With the PDF',
			'prayer.topics.isNew' => 'New',
			'prayer.topics.screenTitle' => 'Prayer topic',
			'prayer.topics.period' => ({required Object from, required Object to}) => 'From ${from} to ${to}',
			'prayer.topics.peopleBanner' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, zero: 'Be the first to pray for these points.', one: '${n} brother or sister prays for these points', other: '${n} brothers and sisters pray for these points', ), 
			'prayer.topics.prayedToday' => ({required Object count, required Object prayed}) => '${count} · ${prayed} prayed today',
			'prayer.topics.document' => 'Original document',
			'prayer.topics.documentSize' => ({required Object kb}) => '${kb} KB',
			'prayer.topics.prayAll' => 'I prayed for all these points',
			'prayer.topics.allPrayed' => 'All prayed today',
			'prayer.topics.archive' => 'Past topics',
			'prayer.topics.archiveEmpty' => 'No past topic.',
			'prayer.topics.current' => 'At the moment',
			'prayer.topics.shareText' => ({required Object title, required Object points}) => '${title}\n\n${points}\n\nLet\'s pray together in the CMFI Connect app.',
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
			'sending.title' => 'Send to my authorities',
			'sending.moreOff' => 'Off',
			_ => null,
		} ?? switch (path) {
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
			_ => null,
		};
	}
}
