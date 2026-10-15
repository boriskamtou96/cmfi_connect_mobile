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
class TranslationsHi extends Translations with BaseTranslations<AppLocale, Translations> {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsHi({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  _meta = meta ?? TranslationMetadata(
		    locale: AppLocale.hi,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ),
		  super(cardinalResolver: cardinalResolver, ordinalResolver: ordinalResolver) {
		_meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <hi>.
	final TranslationMetadata<AppLocale, Translations> _meta;
	@override TranslationMetadata<AppLocale, Translations> get $meta => _meta;

	/// Access flat map
	@override dynamic operator[](String key) => _meta.getTranslation(key) ?? super[key];

	late final TranslationsHi _root = this; // ignore: unused_field

	@override 
	TranslationsHi $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsHi(meta: meta ?? this.$meta);

	// Translations
	@override late final _Translations$app$hi app = _Translations$app$hi._(_root);
	@override late final _Translations$common$hi common = _Translations$common$hi._(_root);
	@override late final _Translations$errors$hi errors = _Translations$errors$hi._(_root);
	@override late final _Translations$validation$hi validation = _Translations$validation$hi._(_root);
	@override late final _Translations$onboarding$hi onboarding = _Translations$onboarding$hi._(_root);
	@override late final _Translations$welcome$hi welcome = _Translations$welcome$hi._(_root);
	@override late final _Translations$auth$hi auth = _Translations$auth$hi._(_root);
	@override late final _Translations$countries$hi countries = _Translations$countries$hi._(_root);
	@override late final _Translations$nav$hi nav = _Translations$nav$hi._(_root);
	@override late final _Translations$home$hi home = _Translations$home$hi._(_root);
	@override late final _Translations$reports$hi reports = _Translations$reports$hi._(_root);
	@override late final _Translations$reminder$hi reminder = _Translations$reminder$hi._(_root);
	@override late final _Translations$export$hi export = _Translations$export$hi._(_root);
	@override late final _Translations$items$hi items = _Translations$items$hi._(_root);
	@override late final _Translations$newItem$hi newItem = _Translations$newItem$hi._(_root);
	@override late final _Translations$more$hi more = _Translations$more$hi._(_root);
	@override late final _Translations$authorities$hi authorities = _Translations$authorities$hi._(_root);
	@override late final _Translations$members$hi members = _Translations$members$hi._(_root);
	@override late final _Translations$admin$hi admin = _Translations$admin$hi._(_root);
	@override late final _Translations$hymns$hi hymns = _Translations$hymns$hi._(_root);
	@override late final _Translations$comingSoon$hi comingSoon = _Translations$comingSoon$hi._(_root);
	@override late final _Translations$events$hi events = _Translations$events$hi._(_root);
	@override late final _Translations$notifications$hi notifications = _Translations$notifications$hi._(_root);
	@override late final _Translations$premium$hi premium = _Translations$premium$hi._(_root);
	@override late final _Translations$homeWidget$hi homeWidget = _Translations$homeWidget$hi._(_root);
	@override late final _Translations$ministry$hi ministry = _Translations$ministry$hi._(_root);
	@override late final _Translations$prayer$hi prayer = _Translations$prayer$hi._(_root);
	@override late final _Translations$sending$hi sending = _Translations$sending$hi._(_root);
	@override late final _Translations$streak$hi streak = _Translations$streak$hi._(_root);
	@override late final _Translations$shortcuts$hi shortcuts = _Translations$shortcuts$hi._(_root);
	@override late final _Translations$blocking$hi blocking = _Translations$blocking$hi._(_root);
	@override late final _Translations$verses$hi verses = _Translations$verses$hi._(_root);
	@override late final _Translations$bible$hi bible = _Translations$bible$hi._(_root);
	@override late final _Translations$profilePhoto$hi profilePhoto = _Translations$profilePhoto$hi._(_root);
	@override late final _Translations$disciples$hi disciples = _Translations$disciples$hi._(_root);
	@override late final _Translations$weekStory$hi weekStory = _Translations$weekStory$hi._(_root);
}

// Path: app
class _Translations$app$hi extends Translations$app$fr {
	_Translations$app$hi._(TranslationsHi root) : this._root = root, super.internal(root);

	final TranslationsHi _root; // ignore: unused_field

	// Translations
	@override String get name => 'CMFI Connect';
	@override String get tagline => 'साथ मिलकर बढ़ना, हर दिन।';
	@override String get languageName => 'हिन्दी';
}

// Path: common
class _Translations$common$hi extends Translations$common$fr {
	_Translations$common$hi._(TranslationsHi root) : this._root = root, super.internal(root);

	final TranslationsHi _root; // ignore: unused_field

	// Translations
	@override String get retry => 'फिर से कोशिश करो';
	@override String get cancel => 'रद्द करो';
	@override String get save => 'सेव करो';
	@override String get close => 'बंद करो';
	@override String get back => 'वापस';
	@override String get soon => 'जल्द ही';
	@override String get optional => '(वैकल्पिक)';
	@override String get and => 'और';
	@override String get loading => 'लोड हो रहा है…';
	@override String get done => 'हो गया';
	@override String get rangeStart => 'कब से';
	@override String get rangeEnd => 'कब तक';
}

// Path: errors
class _Translations$errors$hi extends Translations$errors$fr {
	_Translations$errors$hi._(TranslationsHi root) : this._root = root, super.internal(root);

	final TranslationsHi _root; // ignore: unused_field

	// Translations
	@override String get network => 'इंटरनेट कनेक्शन नहीं है। अपना नेटवर्क जाँचो और फिर से कोशिश करो।';
	@override String get unauthorized => 'तुम्हारा सेशन ख़त्म हो गया है। फिर से लॉग इन करो।';
	@override String get invalidCredentials => 'फ़ोन नंबर या पासवर्ड ग़लत है।';
	@override String get badRequest => 'कुछ जानकारी सही नहीं है।';
	@override String get conflict => 'यह पहले से मौजूद है।';
	@override String get notFound => 'यह नहीं मिला।';
	@override String get server => 'सर्वर में कोई समस्या आ गई। थोड़ी देर में फिर से कोशिश करो।';
	@override String get unknown => 'कुछ गड़बड़ हो गई। फिर से कोशिश करो।';
	@override String get forbidden => 'तुम्हें यह करने की अनुमति नहीं है।';
	@override String get eventFull => 'इस कार्यक्रम में अब कोई जगह नहीं बची है।';
	@override String get registrationClosed => 'इस कार्यक्रम का रजिस्ट्रेशन बंद हो गया है।';
	@override String get mediaTooLarge => 'यह तस्वीर बहुत बड़ी है (अधिकतम 8 MB)।';
	@override String get mediaUnsupported => 'JPEG या PNG तस्वीर चुनो।';
	@override String get notParticipant => 'अपनी घोषणाएँ गिनने के लिए पहले इस विषय से जुड़ो।';
	@override String get importunityClosed => 'यह विषय बंद हो गया है: अब इसमें घोषणाएँ नहीं गिनी जातीं।';
	@override String get usernameNotFound => 'किसी का यह यूज़रनेम नहीं है। स्पेलिंग जाँचो।';
	@override String get ownerCannotLeave => 'यह विषय तुमने बनाया है: इसे छोड़ने के बजाय हटा दो।';
	@override String get tooManyPeople => 'तुम्हारी सूचियाँ भर गई हैं (अधिकतम 500 लोग)।';
	@override String get avatarInvalid => 'यह फ़ोटो इस्तेमाल नहीं हो सकती। कोई दूसरी चुनें।';
	@override String get reportsNotShared => 'यह सदस्य अब अपनी रिपोर्ट साझा नहीं करता।';
}

// Path: validation
class _Translations$validation$hi extends Translations$validation$fr {
	_Translations$validation$hi._(TranslationsHi root) : this._root = root, super.internal(root);

	final TranslationsHi _root; // ignore: unused_field

	// Translations
	@override String get required => 'यह फ़ील्ड ज़रूरी है';
	@override String get passwordTooShort => 'कम से कम 6 कैरेक्टर';
	@override String get invalidPhone => 'फ़ोन नंबर सही नहीं है';
	@override String get invalidEmail => 'ईमेल पता सही नहीं है';
	@override String get invalidCode => 'सिर्फ़ अक्षर और अंक, बिना स्पेस के';
}

// Path: onboarding
class _Translations$onboarding$hi extends Translations$onboarding$fr {
	_Translations$onboarding$hi._(TranslationsHi root) : this._root = root, super.internal(root);

	final TranslationsHi _root; // ignore: unused_field

	// Translations
	@override String get skip => 'छोड़ो';
	@override String get next => 'आगे';
	@override String get start => 'शुरू करो';
	@override String step({required Object total, required Object current}) => '${total} में से स्क्रीन ${current}';
	@override late final _Translations$onboarding$reports$hi reports = _Translations$onboarding$reports$hi._(_root);
	@override late final _Translations$onboarding$worship$hi worship = _Translations$onboarding$worship$hi._(_root);
	@override late final _Translations$onboarding$community$hi community = _Translations$onboarding$community$hi._(_root);
	@override late final _Translations$onboarding$sample$hi sample = _Translations$onboarding$sample$hi._(_root);
}

// Path: welcome
class _Translations$welcome$hi extends Translations$welcome$fr {
	_Translations$welcome$hi._(TranslationsHi root) : this._root = root, super.internal(root);

	final TranslationsHi _root; // ignore: unused_field

	// Translations
	@override String get title => 'CMFI Connect में स्वागत है';
	@override String get text => 'एक मिनट में अपना अकाउंट बनाओ, ताकि अपनी दैनिक रिपोर्ट भर सको और अपने समुदाय की हर गतिविधि पर नज़र रख सको।';
	@override String get createAccount => 'अकाउंट बनाओ';
	@override String get haveAccount => 'मेरा अकाउंट पहले से है';
}

// Path: auth
class _Translations$auth$hi extends Translations$auth$fr {
	_Translations$auth$hi._(TranslationsHi root) : this._root = root, super.internal(root);

	final TranslationsHi _root; // ignore: unused_field

	// Translations
	@override String get phone => 'फ़ोन';
	@override String dialCode({required Object code}) => 'देश कोड: ${code}';
	@override String get password => 'पासवर्ड';
	@override String get showPassword => 'पासवर्ड दिखाओ';
	@override String get hidePassword => 'पासवर्ड छिपाओ';
	@override late final _Translations$auth$login$hi login = _Translations$auth$login$hi._(_root);
	@override late final _Translations$auth$register$hi register = _Translations$auth$register$hi._(_root);
	@override late final _Translations$auth$church$hi church = _Translations$auth$church$hi._(_root);
	@override late final _Translations$auth$forgot$hi forgot = _Translations$auth$forgot$hi._(_root);
}

// Path: countries
class _Translations$countries$hi extends Translations$countries$fr {
	_Translations$countries$hi._(TranslationsHi root) : this._root = root, super.internal(root);

	final TranslationsHi _root; // ignore: unused_field

	// Translations
	@override String get dialCodeTitle => 'देश कोड';
	@override String get title => 'तुम्हारा देश';
	@override String get search => 'देश या कोड खोजो';
	@override String get none => 'कोई देश नहीं मिला';
	@override String get change => 'देश बदलो';
}

// Path: nav
class _Translations$nav$hi extends Translations$nav$fr {
	_Translations$nav$hi._(TranslationsHi root) : this._root = root, super.internal(root);

	final TranslationsHi _root; // ignore: unused_field

	// Translations
	@override String get home => 'होम';
	@override String get reports => 'रिपोर्ट';
	@override String get hymns => 'भजन';
	@override String get prayer => 'प्रार्थना';
	@override String get bible => 'बाइबल';
}

// Path: home
class _Translations$home$hi extends Translations$home$fr {
	_Translations$home$hi._(TranslationsHi root) : this._root = root, super.internal(root);

	final TranslationsHi _root; // ignore: unused_field

	// Translations
	@override String greeting({required Object name}) => 'नमस्ते ${name}';
	@override String get greetingNoName => 'नमस्ते';
	@override String get profile => 'मेरी प्रोफ़ाइल';
	@override String progress({required Object total, required Object filled}) => '${total} में से ${filled}';
	@override String get progressLabel => 'आइटम भरे गए';
	@override String get goals => 'लक्ष्य';
	@override String get weekTitle => 'तुम्हारा हफ़्ता';
	@override String get community => 'अभी CMFI में';
	@override String get eventsTitle => 'कार्यक्रम';
	@override String get hymnsTitle => 'भजन';
	@override String get hymnsOpen => 'भजन संग्रह खोलो';
	@override String get continueMyReport => 'अपनी रिपोर्ट जारी रखो';
	@override String get startMyReport => 'अपनी रिपोर्ट शुरू करो';
	@override String get items => 'चीज़ें';
	@override String get goalsTitle => 'लक्ष्य';
	@override String get retreatsTitle => 'प्रार्थना-समय';
	@override String retreatsValue({required Object n}) => '4 में से ${n}';
	@override String get streakTitle => 'लगातार';
	@override String get resume => 'जहाँ छोड़ा था वहीं से';
	@override String hymnNumber({required Object number}) => 'भजन संख्या ${number}';
	@override String get seeAll => 'सब देखो';
	@override String get retreatsDone => 'आज के चारों प्रार्थना-समय हो गए';
	@override String days({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hi'))(n,
		one: '${n} दिन',
		other: '${n} दिन',
	);
}

// Path: reports
class _Translations$reports$hi extends Translations$reports$fr {
	_Translations$reports$hi._(TranslationsHi root) : this._root = root, super.internal(root);

	final TranslationsHi _root; // ignore: unused_field

	// Translations
	@override String get title => 'दैनिक रिपोर्ट';
	@override String get myItems => 'मेरे आइटम';
	@override late final _Translations$reports$tabs$hi tabs = _Translations$reports$tabs$hi._(_root);
	@override String get pickDay => 'दिन चुनो';
	@override String filled({required Object total, required Object filled}) => '${total} में से ${filled} भरे गए';
	@override String get statusSaved => 'सेव हो गया';
	@override String get statusModified => 'सेव नहीं हुआ';
	@override String get standard => 'मानक';
	@override String get personal => 'मेरे आइटम';
	@override String get createItem => 'आइटम बनाओ';
	@override String add({required Object label}) => '${label} जोड़ो';
	@override String get note => 'आज का नोट';
	@override String get noteHint => 'कोई वचन, धन्यवाद की कोई बात…';
	@override String get save => 'दिन सेव करो';
	@override String get saved => 'दिन सेव हो गया';
	@override late final _Translations$reports$measure$hi measure = _Translations$reports$measure$hi._(_root);
	@override String times({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hi'))(n,
		one: '${n} बार',
		other: '${n} बार',
	);
	@override late final _Translations$reports$sheet$hi sheet = _Translations$reports$sheet$hi._(_root);
	@override late final _Translations$reports$history$hi history = _Translations$reports$history$hi._(_root);
	@override late final _Translations$reports$summary$hi summary = _Translations$reports$summary$hi._(_root);
	@override String get noItems => 'अभी भरने के लिए कोई आइटम नहीं है।';
	@override String get statusPending => 'अभी भेजा नहीं गया';
	@override String get savedOffline => 'नेटवर्क नहीं है: यह दिन फ़ोन में सेव है और नेटवर्क मिलते ही भेज दिया जाएगा।';
	@override String pendingBanner({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hi'))(n,
		one: '${n} दिन भेजे जाने के लिए नेटवर्क का इंतज़ार कर रहा है',
		other: '${n} दिन भेजे जाने के लिए नेटवर्क का इंतज़ार कर रहे हैं',
	);
	@override String get export => 'मेरी रिपोर्ट एक्सपोर्ट करो';
	@override String goal({required Object value}) => 'लक्ष्य: ${value}';
	@override String get goalReached => 'लक्ष्य पूरा हुआ';
	@override String get dayGoals => 'दिन के लक्ष्य';
	@override String goalsReached({required Object total, required Object reached}) => 'पूरे हुए: ${total} में से ${reached}';
	@override late final _Translations$reports$standardItems$hi standardItems = _Translations$reports$standardItems$hi._(_root);
	@override late final _Translations$reports$units$hi units = _Translations$reports$units$hi._(_root);
}

// Path: reminder
class _Translations$reminder$hi extends Translations$reminder$fr {
	_Translations$reminder$hi._(TranslationsHi root) : this._root = root, super.internal(root);

	final TranslationsHi _root; // ignore: unused_field

	// Translations
	@override String get title => 'तुम्हारी आज की रिपोर्ट';
	@override String get body => 'दिन ख़त्म होने से पहले एक मिनट निकालकर अपना बाइबल पठन, अपनी प्रार्थना… दर्ज करो।';
	@override String get channel => 'रिपोर्ट रिमाइंडर';
	@override String get settings => 'शाम का रिमाइंडर';
	@override String get off => 'बंद';
	@override String get switchLabel => 'मुझे अपना दिन भरने की याद दिलाओ';
	@override String get switchHint => 'सिर्फ़ तब, जब दिन अभी तक भरा न गया हो।';
	@override String get time => 'रिमाइंडर का समय';
	@override String get offerTitle => 'हर शाम एक रिमाइंडर?';
	@override String get offerText => 'अगर तुम्हारा दिन अभी तक भरा नहीं गया है, तो ऐप तुम्हारे चुने हुए समय पर तुम्हें याद दिलाएगा। अगर पहले ही भर दिया है, तो कुछ नहीं।';
	@override String get offerAccept => 'रिमाइंडर चालू करो';
	@override String get offerLater => 'बाद में';
	@override String enabled({required Object time}) => 'रिमाइंडर ${time} पर चालू है';
	@override String get denied => 'CMFI Connect के नोटिफ़िकेशन बंद हैं। फ़ोन की सेटिंग में जाकर इन्हें अनुमति दो।';
}

// Path: export
class _Translations$export$hi extends Translations$export$fr {
	_Translations$export$hi._(TranslationsHi root) : this._root = root, super.internal(root);

	final TranslationsHi _root; // ignore: unused_field

	// Translations
	@override String get title => 'एक्सपोर्ट';
	@override String get period => 'अवधि';
	@override String get thisWeek => 'इस हफ़्ते';
	@override String get lastWeek => 'पिछले हफ़्ते';
	@override String get thisMonth => 'इस महीने';
	@override String get lastMonth => 'पिछले महीने';
	@override String get thisYear => 'इस साल';
	@override String get custom => 'दूसरी तारीख़ें';
	@override String get customPick => 'तारीख़ें चुनो';
	@override String get format => 'फ़ॉर्मेट';
	@override String get pdf => 'PDF';
	@override String get pdfHint => 'भेजने या प्रिंट करने के लिए एक दस्तावेज़';
	@override String get csv => 'स्प्रेडशीट';
	@override String get csvHint => 'Excel या Google Sheets के लिए एक CSV फ़ाइल';
	@override String get text => 'मैसेज';
	@override String get textHint => 'WhatsApp में पेस्ट करने के लिए एक सारांश';
	@override String get button => 'एक्सपोर्ट करो';
	@override String get shareButton => 'शेयर करो';
	@override String preview({required num filled, required Object total, required Object items}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hi'))(filled,
		one: '${total} में से ${filled} दिन भरा गया · ${items}',
		other: '${total} में से ${filled} दिन भरे गए · ${items}',
	);
	@override String previewItems({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hi'))(n,
		one: '${n} आइटम',
		other: '${n} आइटम',
	);
	@override String get empty => 'इस अवधि में कोई रिपोर्ट नहीं है।';
	@override String get tooLong => 'अधिकतम 366 दिन चुनो।';
	@override String get fileName => 'दैनिक-रिपोर्ट';
	@override String subject({required Object period}) => 'मेरी दैनिक रिपोर्ट, ${period}';
	@override late final _Translations$export$doc$hi doc = _Translations$export$doc$hi._(_root);
}

// Path: items
class _Translations$items$hi extends Translations$items$fr {
	_Translations$items$hi._(TranslationsHi root) : this._root = root, super.internal(root);

	final TranslationsHi _root; // ignore: unused_field

	// Translations
	@override String get title => 'मेरे आइटम';
	@override String get standardSection => 'मानक · सभी के लिए';
	@override String get personalSection => 'मेरे निजी आइटम';
	@override String get emptyPersonal => 'अभी तक तुम्हारा कोई निजी आइटम नहीं है।';
	@override String get archive => 'आर्काइव करो';
	@override String archiveTitle({required Object code}) => '${code} को आर्काइव करना है?';
	@override String get archiveText => 'यह अब तुम्हारी रिपोर्ट में नहीं दिखेगा। इसके आँकड़े तुम्हारे इतिहास में बने रहेंगे।';
	@override String archived({required Object code}) => '${code} आर्काइव हो गया';
	@override String get create => 'आइटम बनाओ';
	@override String get footnote => 'आर्काइव किया गया आइटम अब तुम्हारी रिपोर्ट में नहीं दिखता, लेकिन उसके आँकड़े तुम्हारे इतिहास में बने रहते हैं।';
	@override late final _Translations$items$measure$hi measure = _Translations$items$measure$hi._(_root);
	@override String get goalAdd => 'लक्ष्य जोड़ो';
	@override String goal({required Object value}) => 'लक्ष्य: हर दिन ${value}';
	@override String get goalTitle => 'रोज़ का लक्ष्य';
	@override String get goalHint => 'हर दिन के लिए तुम्हारा लक्ष्य। यह सिर्फ़ तुम्हारे फ़ोन में रहता है।';
	@override String get goalRemove => 'हटाओ';
	@override String get goalSaved => 'लक्ष्य सेव हो गया';
	@override String get goalRemoved => 'लक्ष्य हटा दिया गया';
}

// Path: newItem
class _Translations$newItem$hi extends Translations$newItem$fr {
	_Translations$newItem$hi._(TranslationsHi root) : this._root = root, super.internal(root);

	final TranslationsHi _root; // ignore: unused_field

	// Translations
	@override String get title => 'नया आइटम';
	@override String get code => 'कोड';
	@override String get label => 'नाम';
	@override String get help => 'अक्षर और अंक, अधिकतम 20। किसी मानक आइटम का कोड (LB, PS…) इस्तेमाल नहीं किया जा सकता।';
	@override String get measures => 'क्या मापना है';
	@override String get quantity => 'मात्रा';
	@override String get quantityHint => 'अध्याय, पेज, लोग…';
	@override String get unit => 'संख्या के बाद दिखने वाली इकाई';
	@override String get unitHint => 'लोग';
	@override String get duration => 'अवधि';
	@override String get durationHint => 'घंटों और मिनटों में';
	@override String get noMeasure => 'कम से कम एक माप चुनो: मात्रा, अवधि या दोनों।';
	@override String get preview => 'तुम्हारी रिपोर्ट में ऐसा दिखेगा';
	@override String get previewCode => 'CODE';
	@override String get previewLabel => 'आइटम का नाम';
	@override String get submit => 'आइटम बनाओ';
	@override String created({required Object code}) => '${code} बन गया।';
	@override String get codeTaken => 'यह कोड पहले से इस्तेमाल हो रहा है, किसी मानक आइटम में या तुम्हारे किसी आइटम में (आर्काइव किए गए आइटम भी)।';
	@override String get codeHint => 'EVG';
	@override String get labelHint => 'सुसमाचार प्रचार';
}

// Path: more
class _Translations$more$hi extends Translations$more$fr {
	_Translations$more$hi._(TranslationsHi root) : this._root = root, super.internal(root);

	final TranslationsHi _root; // ignore: unused_field

	// Translations
	@override String get title => 'और';
	@override String get editProfile => 'प्रोफ़ाइल बदलो';
	@override String get community => 'समुदाय';
	@override String get events => 'कार्यक्रम';
	@override String get reports => 'दैनिक रिपोर्ट';
	@override String get myItems => 'मेरे आइटम';
	@override String get app => 'ऐप';
	@override String get language => 'भाषा';
	@override String get appearance => 'रूप-रंग';
	@override String get themeSystem => 'अपने आप';
	@override String get themeSystemHint => '‘अपने आप’ चुनने पर ऐप तुम्हारे फ़ोन की लाइट या डार्क सेटिंग के हिसाब से चलेगा।';
	@override String get themeLight => 'लाइट';
	@override String get themeDark => 'डार्क';
	@override String get logout => 'लॉग आउट करो';
	@override String get account => 'खाता';
	@override String get languageTitle => 'ऐप की भाषा';
	@override String get completeProfile => 'अपना नाम जोड़ो';
	@override String get accompaniment => 'मार्गदर्शन';
	@override String get exportReport => 'मेरी रिपोर्ट एक्सपोर्ट करो';
	@override String get logoutPendingTitle => 'कुछ दिन अभी भेजे नहीं गए';
	@override String logoutPendingText({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hi'))(n,
		one: 'बिना नेटवर्क के सेव किया गया ${n} दिन अभी तक भेजा नहीं गया है। अगर अभी लॉग आउट किया, तो वह खो जाएगा।',
		other: 'बिना नेटवर्क के सेव किए गए ${n} दिन अभी तक भेजे नहीं गए हैं। अगर अभी लॉग आउट किया, तो वे खो जाएँगे।',
	);
	@override String get logoutAnyway => 'फिर भी लॉग आउट करो';
	@override String get admin => 'प्रबंधन';
	@override String get staff => 'टीम और भूमिकाएँ';
	@override String get manageEvents => 'कार्यक्रम';
	@override String get disciples => 'मेरे शिष्य';
}

// Path: authorities
class _Translations$authorities$hi extends Translations$authorities$fr {
	_Translations$authorities$hi._(TranslationsHi root) : this._root = root, super.internal(root);

	final TranslationsHi _root; // ignore: unused_field

	// Translations
	@override String get title => 'मेरे आत्मिक अगुवे';
	@override String get intro => 'वे लोग जो परमेश्वर के साथ तुम्हारे सफ़र में तुम्हारा साथ देते हैं: तुम्हारा चेला बनाने वाला और तुम्हारे दूसरे अगुवे।';
	@override String get discipleMaker => 'चेला बनाने वाला';
	@override String discipleMakerOf({required Object name}) => 'चेला बनाने वाला: ${name}';
	@override String get noDiscipleMaker => 'अभी तक कोई चेला बनाने वाला नहीं';
	@override String get others => 'दूसरे अगुवे';
	@override String get empty => 'तुमने अभी तक किसी को नहीं जोड़ा है।';
	@override String get add => 'अगुवा जोड़ो';
	@override String get remove => 'हटाओ';
	@override String removeTitle({required Object name}) => '${name} को हटाना है?';
	@override String removeText({required Object name}) => '${name} को तुम्हारे आत्मिक अगुवों की सूची से हटा दिया जाएगा।';
	@override String removed({required Object name}) => '${name} को तुम्हारे अगुवों की सूची से हटा दिया गया।';
	@override String count({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hi'))(n,
		zero: 'अभी तक कोई नहीं',
		one: '${n} व्यक्ति',
		other: '${n} लोग',
	);
	@override late final _Translations$authorities$form$hi form = _Translations$authorities$form$hi._(_root);
	@override String get statusPending => 'इंतज़ार में';
	@override String get statusDeclined => 'अस्वीकार';
	@override String pendingHelp({required Object name}) => '${name} के स्वीकार करने पर उनकी संपर्क जानकारी दिखेगी।';
	@override String get requests => 'मिले हुए अनुरोध';
	@override String get requestDiscipleMaker => 'तुमसे उनका चेला बनाने वाला बनने का अनुरोध';
	@override String get requestAuthority => 'तुमसे उनका मार्गदर्शन करने का अनुरोध';
	@override String get accept => 'स्वीकार करो';
	@override String get decline => 'अस्वीकार करो';
	@override String acceptedRequest({required Object name}) => 'अब ${name} तुम्हारे मार्गदर्शन में हैं।';
	@override String declinedRequest({required Object name}) => '${name} का अनुरोध अस्वीकार किया गया।';
	@override String requestsCount({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hi'))(n,
		one: '${n} अनुरोध देखना बाकी है',
		other: '${n} अनुरोध देखने बाकी हैं',
	);
	@override late final _Translations$authorities$sharing$hi sharing = _Translations$authorities$sharing$hi._(_root);
}

// Path: members
class _Translations$members$hi extends Translations$members$fr {
	_Translations$members$hi._(TranslationsHi root) : this._root = root, super.internal(root);

	final TranslationsHi _root; // ignore: unused_field

	// Translations
	@override String get username => 'यूज़रनेम';
	@override String get usernameHint => 'naam.surname';
	@override String get usernameHelp => 'दूसरे सदस्य तुम्हें इसी नाम से ढूँढेंगे।';
	@override String get usernameChecking => 'जाँच हो रही है…';
	@override String usernameFree({required Object username}) => '@${username} उपलब्ध है';
	@override String get usernameCurrent => 'यह तुम्हारा मौजूदा यूज़रनेम है';
	@override String get usernameTaken => 'यह यूज़रनेम पहले से लिया जा चुका है।';
	@override String get usernameInvalid => '3 से 30 कैरेक्टर: अक्षर, अंक, “.” और “_”, पर शुरुआत या अंत में कोई चिह्न नहीं।';
	@override String get usernameReserved => 'यह यूज़रनेम आरक्षित है।';
	@override String usernameSaved({required Object username}) => 'यूज़रनेम सेव हो गया: @${username}';
	@override late final _Translations$members$deleteAccount$hi deleteAccount = _Translations$members$deleteAccount$hi._(_root);
}

// Path: admin
class _Translations$admin$hi extends Translations$admin$fr {
	_Translations$admin$hi._(TranslationsHi root) : this._root = root, super.internal(root);

	final TranslationsHi _root; // ignore: unused_field

	// Translations
	@override String get title => 'टीम और भूमिकाएँ';
	@override String get intro => 'एडमिन वह सब संभालते हैं जो पूरा समुदाय साझा करता है। भूमिका सिर्फ़ सुपरएडमिन ही दे या वापस ले सकते हैं।';
	@override String get roleUser => 'सदस्य';
	@override String get roleAdmin => 'एडमिन';
	@override String get roleSuperadmin => 'सुपरएडमिन';
	@override String get giveRole => 'भूमिका दो';
	@override String get you => 'तुम';
	@override String roleFor({required Object username}) => '@${username} की भूमिका';
	@override String roleChanged({required Object username, required Object role}) => '@${username}: ${role}';
	@override String get memberUsername => 'सदस्य का यूज़रनेम';
	@override String get empty => 'अभी तक कोई एडमिन नहीं है।';
}

// Path: hymns
class _Translations$hymns$hi extends Translations$hymns$fr {
	_Translations$hymns$hi._(TranslationsHi root) : this._root = root, super.internal(root);

	final TranslationsHi _root; // ignore: unused_field

	// Translations
	@override String get searchHint => 'नंबर, शीर्षक या बोल';
	@override String get openNumber => 'नंबर पर जाओ';
	@override late final _Translations$hymns$tabs$hi tabs = _Translations$hymns$tabs$hi._(_root);
	@override String get chooseBook => 'भजन संग्रह चुनो';
	@override String count({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hi'))(n,
		one: '${n} भजन',
		other: '${n} भजन',
	);
	@override String number({required Object number}) => 'नं. ${number}';
	@override String get emptyFavorites => 'किसी भजन का स्टार टैप करो, वह यहाँ दिखेगा।';
	@override String get emptyRecent => 'हाल में खोले गए भजन यहाँ दिखेंगे।';
	@override String noResult({required Object query}) => '“${query}” से मेल खाता कोई भजन नहीं मिला।';
	@override String get otherBooks => 'दूसरे भजन संग्रहों में';
	@override String get upToDate => 'भजन संग्रह अप-टू-डेट हैं।';
	@override String get updated => 'भजन संग्रह अपडेट हो गए हैं।';
	@override String get chorus => 'कोरस';
	@override String chorusNumber({required Object label}) => 'कोरस ${label}';
	@override String verse({required Object label}) => 'पद ${label}';
	@override String times({required Object n}) => '×${n}';
	@override String get loadFailed => 'भजन संग्रह नहीं खुल पाए।';
	@override late final _Translations$hymns$reader$hi reader = _Translations$hymns$reader$hi._(_root);
	@override late final _Translations$hymns$projection$hi projection = _Translations$hymns$projection$hi._(_root);
	@override late final _Translations$hymns$pad$hi pad = _Translations$hymns$pad$hi._(_root);
}

// Path: comingSoon
class _Translations$comingSoon$hi extends Translations$comingSoon$fr {
	_Translations$comingSoon$hi._(TranslationsHi root) : this._root = root, super.internal(root);

	final TranslationsHi _root; // ignore: unused_field

	// Translations
	@override String get badge => 'जल्द आ रहा है';
	@override String get backHome => 'होम पर वापस जाओ';
}

// Path: events
class _Translations$events$hi extends Translations$events$fr {
	_Translations$events$hi._(TranslationsHi root) : this._root = root, super.internal(root);

	final TranslationsHi _root; // ignore: unused_field

	// Translations
	@override String get title => 'कार्यक्रम';
	@override String get featured => 'विशेष';
	@override String get upcoming => 'आने वाले';
	@override String get past => 'पिछले संस्करण';
	@override String get emptyTitle => 'कोई आने वाला कार्यक्रम नहीं';
	@override String get emptyText => 'पूरे समुदाय के सम्मेलन और सभाएँ अपनी समय-सारणी के साथ यहाँ दिखेंगी।';
	@override String get manage => 'कार्यक्रम प्रबंधित करो';
	@override String get next => 'अगला कार्यक्रम';
	@override String get seeAll => 'सभी कार्यक्रम';
	@override String get homeText => 'समुदाय की सभाएँ, उनकी समय-सारणी और ख़बरें।';
	@override String get today => 'आज';
	@override String get tomorrow => 'कल';
	@override String inDays({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hi'))(n,
		one: '${n} दिन में',
		other: '${n} दिन में',
	);
	@override String daysLeft({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hi'))(n,
		other: '${n} दिन बाकी',
	);
	@override String get onNow => 'अभी चल रहा है';
	@override String get over => 'समाप्त';
	@override String get cancelled => 'रद्द';
	@override String get draft => 'ड्राफ़्ट';
	@override String get registered => 'रजिस्टर्ड';
	@override String get stateOpen => 'रजिस्ट्रेशन खुला है';
	@override String get stateClosed => 'रजिस्ट्रेशन बंद है';
	@override String get stateFull => 'जगह भर गई';
	@override String registrations({required num n, required Object count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hi'))(n,
		zero: 'रजिस्टर करने वाले पहले व्यक्ति बनो',
		one: '${count} रजिस्ट्रेशन',
		other: '${count} रजिस्ट्रेशन',
	);
	@override String people({required num n, required Object count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hi'))(n,
		one: '${count} व्यक्ति',
		other: '${count} लोग',
	);
	@override String placesLeft({required num n, required Object count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hi'))(n,
		zero: 'कोई जगह नहीं बची',
		one: '${count} जगह बची है',
		other: '${count} जगहें बची हैं',
	);
	@override String oneDay({required Object start, required Object end}) => '${start} से ${end} तक';
	@override String severalDays({required Object startDay, required Object start, required Object endDay, required Object end}) => '${startDay} को ${start} बजे शुरू, ${endDay} को ${end} बजे समापन';
	@override String venueTime({required Object place}) => '${place} का समय';
	@override String get addToCalendar => 'कैलेंडर में जोड़ो';
	@override String get share => 'शेयर करो';
	@override String get directions => 'रास्ता देखो';
	@override String get viewPoster => 'पोस्टर देखो';
	@override late final _Translations$events$tabs$hi tabs = _Translations$events$tabs$hi._(_root);
	@override String get noProgram => 'समय-सारणी जल्द ही प्रकाशित होगी।';
	@override String get noNews => 'इस कार्यक्रम की अभी कोई ख़बर नहीं है।';
	@override String get pinned => 'पिन किया गया';
	@override String get now => 'इस समय';
	@override String hymn({required Object number}) => 'भजन ${number}';
	@override String get about => 'परिचय';
	@override String get fees => 'सहयोग राशि';
	@override String deadline({required Object date}) => 'रजिस्ट्रेशन ${date} तक';
	@override String get contact => 'संपर्क';
	@override String call({required Object name}) => '${name} को कॉल करो';
	@override String get otherEditions => 'दूसरे संस्करण';
	@override String get cancelledBanner => 'यह कार्यक्रम रद्द हो गया है।';
	@override String get calendarFailed => 'फ़ोन का कैलेंडर नहीं खुल पाया।';
	@override String get linkFailed => 'यह लिंक नहीं खुल पाया।';
	@override String shareText({required Object title, required Object dates, required Object place}) => '${title}\n${dates} · ${place}\nCMFI Connect ऐप में रजिस्टर करो।';
	@override String get full => 'इस कार्यक्रम में अब कोई जगह नहीं बची है।';
	@override String get closed => 'इस कार्यक्रम का रजिस्ट्रेशन बंद हो गया है।';
	@override late final _Translations$events$register$hi register = _Translations$events$register$hi._(_root);
	@override late final _Translations$events$reminder$hi reminder = _Translations$events$reminder$hi._(_root);
	@override late final _Translations$events$admin$hi admin = _Translations$events$admin$hi._(_root);
	@override String upcomingCount({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hi'))(n,
		one: '${n} आने वाला कार्यक्रम',
		other: '${n} आने वाले कार्यक्रम',
	);
	@override String slide({required Object current, required Object total}) => 'कार्यक्रम ${current} / ${total}';
}

// Path: notifications
class _Translations$notifications$hi extends Translations$notifications$fr {
	_Translations$notifications$hi._(TranslationsHi root) : this._root = root, super.internal(root);

	final TranslationsHi _root; // ignore: unused_field

	// Translations
	@override String get title => 'सूचनाएँ';
	@override String get channel => 'समुदाय की घोषणाएँ';
	@override String get empty => 'अभी कोई सूचना नहीं';
	@override String get emptyHint => 'समुदाय की घोषणाएँ यहाँ आएँगी।';
	@override String unreadLabel({required Object title}) => 'अपठित: ${title}';
	@override String documents({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hi'))(n,
		one: '${n} PDF दस्तावेज़',
		other: '${n} PDF दस्तावेज़',
	);
	@override String unread({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hi'))(n,
		one: '${n} अपठित',
		other: '${n} अपठित',
	);
	@override String image({required Object n}) => 'चित्र ${n}';
	@override String get document => 'PDF दस्तावेज़';
	@override String documentSize({required Object kb}) => '${kb} KB';
	@override String received({required Object title}) => 'नई सूचना: ${title}';
}

// Path: premium
class _Translations$premium$hi extends Translations$premium$fr {
	_Translations$premium$hi._(TranslationsHi root) : this._root = root, super.internal(root);

	final TranslationsHi _root; // ignore: unused_field

	// Translations
	@override String get name => 'CMFI Connect Premium';
	@override String get pill => 'Premium';
	@override String get subtitle => 'परमेश्वर के साथ अपनी चाल में आगे बढ़ो, और सेवकाई का साथ दो।';
	@override String get widgetTitle => 'होम स्क्रीन विजेट';
	@override String get widgetText => 'ऐप खोले बिना आज की रिपोर्ट और तुम्हारे लक्ष्य।';
	@override String get statsTitle => 'पूरे साल के तुम्हारे लक्ष्य';
	@override String get statsText => 'साल का सारांश और तुम्हारे लक्ष्यों की प्रगति, हफ़्ते दर हफ़्ते।';
	@override String get supportTitle => 'तुम सेवकाई का साथ देते हो';
	@override String get supportText => 'तुम्हारी सदस्यता पूरे समुदाय के लिए ऐप को चालू रखती है।';
	@override String get annual => 'सालाना';
	@override String get monthly => 'मासिक';
	@override String perYear({required Object price}) => '${price} / साल';
	@override String perMonth({required Object price}) => '${price} / महीना';
	@override String annualPerMonth({required Object price}) => 'यानी ${price} प्रति महीना';
	@override String get best => 'सबसे फ़ायदेमंद';
	@override String trialDays({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hi'))(n,
		one: '${n} दिन मुफ़्त आज़माओ',
		other: '${n} दिन मुफ़्त आज़माओ',
	);
	@override String trialMonths({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hi'))(n,
		one: '${n} महीना मुफ़्त आज़माओ',
		other: '${n} महीने मुफ़्त आज़माओ',
	);
	@override String get subscribe => 'सदस्यता लो';
	@override String get startTrial => 'मुफ़्त आज़माना शुरू करो';
	@override String get restore => 'ख़रीदारी वापस लाओ';
	@override String get restored => 'Premium इस फ़ोन पर वापस आ गया';
	@override String get nothingToRestore => 'इस खाते के लिए कोई Premium ख़रीदारी नहीं';
	@override String get thanks => 'धन्यवाद! Premium चालू है।';
	@override String get failed => 'ख़रीदारी पूरी नहीं हुई। थोड़ी देर में फिर कोशिश करो।';
	@override String get unavailable => 'अभी ऑफ़र उपलब्ध नहीं हैं।';
	@override String renews({required Object store}) => 'सदस्यता अपने आप नवीनीकृत होती है। तुम इसे कभी भी अपने ${store} खाते की सेटिंग में रद्द कर सकते हो।';
	@override String get terms => 'उपयोग की शर्तें';
	@override String get privacy => 'गोपनीयता';
	@override String get activeTitle => 'तुम्हारे पास Premium है';
	@override String get activeText => 'CMFI Connect का साथ देने के लिए धन्यवाद! विजेट और तुम्हारे सारांश का साल खुले हैं।';
	@override String get staffText => 'तुम CMFI Connect टीम का हिस्सा हो, इसलिए Premium तुम्हें मुफ़्त मिला है।';
	@override String get moreSubtitle => 'विजेट, पूरे साल के लक्ष्य';
	@override String get moreActive => 'चालू';
	@override String get unlock => 'Premium से खोलो';
	@override String trialThen({required Object trial, required Object price}) => '${trial}, फिर ${price}';
	@override String savePercent({required Object percent}) => '−${percent}';
	@override String get choose => 'अपना प्लान चुनो';
	@override String get cancelAnytime => 'कोई बंधन नहीं, कभी भी रद्द करो';
	@override String get restoreShort => 'बहाल करें';
	@override String get termsShort => 'शर्तें';
	@override String get semiannual => 'छमाही';
	@override String perSemester({required Object price}) => '${price} / 6 महीने';
}

// Path: homeWidget
class _Translations$homeWidget$hi extends Translations$homeWidget$fr {
	_Translations$homeWidget$hi._(TranslationsHi root) : this._root = root, super.internal(root);

	final TranslationsHi _root; // ignore: unused_field

	// Translations
	@override String get title => 'आज';
	@override String get done => 'हो गया';
	@override String get todo => 'भरना बाकी';
	@override String get open => 'भरो';
	@override String get locked => 'Premium से विजेट चालू करो';
	@override String get signedOut => 'ऐप में साइन इन करो';
}

// Path: ministry
class _Translations$ministry$hi extends Translations$ministry$fr {
	_Translations$ministry$hi._(TranslationsHi root) : this._root = root, super.internal(root);

	final TranslationsHi _root; // ignore: unused_field

	// Translations
	@override String get title => 'हमारी सेवकाई';
	@override String get tagline => 'पृथ्वी की छोर तक';
	@override String count({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hi'))(n,
		one: '${n} राष्ट्र',
		other: '${n} राष्ट्र',
	);
	@override String get fromYaounde => 'याउंडे से, सुसमाचार एक राष्ट्र से दूसरे राष्ट्र तक जाता है।';
	@override String get dragHint => 'उंगली से ग्लोब घुमाओ, किसी राष्ट्र को छुओ।';
	@override String globeLabel({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hi'))(n,
		one: 'ग्लोब: ${n} राष्ट्र जहाँ सेवकाई मौजूद है। नीचे की सूची उसे बताती है।',
		other: 'ग्लोब: ${n} राष्ट्र जहाँ सेवकाई मौजूद है। नीचे की सूची सबको बताती है।',
	);
	@override String get voyage => 'यात्रा';
	@override String get pause => 'रोको';
	@override String get previous => 'पिछला राष्ट्र';
	@override String get next => 'अगला राष्ट्र';
	@override String number({required Object n}) => 'राष्ट्र क्रमांक ${n}';
	@override String since({required Object year}) => '${year} से';
	@override String get pray => 'प्रार्थना';
	@override String prayTitle({required Object country}) => '${country} के लिए प्रार्थना';
	@override String prayThanks({required Object country}) => '${country} में परमेश्वर के काम के लिए धन्यवाद दो।';
	@override String prayAssemblies({required Object country}) => '${country} की कलीसियाओं और उनके अगुवों के लिए प्रार्थना करो।';
	@override String prayUnreached({required Object country}) => 'प्रार्थना करो कि ${country} में जिन्होंने अभी तक विश्वास नहीं किया, वे यीशु से मिलें।';
	@override String get purpose => 'हमारा उद्देश्य';
	@override String get nations => 'राष्ट्र';
	@override String get search => 'राष्ट्र खोजो';
	@override String get none => 'कोई राष्ट्र नहीं मिला';
	@override String homeText({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hi'))(n,
		one: '${n} राष्ट्र में मौजूद',
		other: '${n} राष्ट्रों में मौजूद',
	);
	@override String get nationsSubtitle => 'ग्लोब और एक राष्ट्र से दूसरे राष्ट्र की यात्रा';
	@override String get purposeSubtitle => 'हमारे तीन लक्ष्य';
	@override String get missionaries => 'हमारे मिशनरी';
	@override String get missionariesSubtitle => 'जिन्हें प्रभु राष्ट्रों में भेजता है';
	@override String get heroes => 'हमारे नायक';
	@override String get heroesSubtitle => 'जिनका विश्वास हमें प्रेरित करता है';
	@override String goalOf({required Object n, required Object total}) => 'हमारा लक्ष्य · ${n}/${total}';
	@override String get previousGoal => 'पिछला लक्ष्य';
	@override String get nextGoal => 'अगला लक्ष्य';
	@override Map<String, String> get media => {
		'books': 'पुस्तकें',
		'tracts': 'पर्चे',
		'magazines': 'पत्रिकाएँ',
		'cds': 'सीडी',
		'dvds': 'डीवीडी',
		'radio': 'रेडियो',
		'tv': 'टेलीविज़न',
		'internet': 'इंटरनेट',
	};
	@override late final _Translations$ministry$goals$hi goals = _Translations$ministry$goals$hi._(_root);
}

// Path: prayer
class _Translations$prayer$hi extends Translations$prayer$fr {
	_Translations$prayer$hi._(TranslationsHi root) : this._root = root, super.internal(root);

	final TranslationsHi _root; // ignore: unused_field

	// Translations
	@override Map<String, String> get moments => {
		'morning': 'सुबह',
		'noon': 'दोपहर',
		'evening': 'शाम',
		'night': 'रात',
	};
	@override Map<String, String> get retreatOf => {
		'morning': 'सुबह का प्रार्थना-समय',
		'noon': 'दोपहर का प्रार्थना-समय',
		'evening': 'शाम का प्रार्थना-समय',
		'night': 'रात का प्रार्थना-समय',
	};
	@override late final _Translations$prayer$hero$hi hero = _Translations$prayer$hero$hi._(_root);
	@override late final _Translations$prayer$today$hi today = _Translations$prayer$today$hi._(_root);
	@override late final _Translations$prayer$routine$hi routine = _Translations$prayer$routine$hi._(_root);
	@override String get together => 'साथ मिलकर प्रार्थना';
	@override late final _Translations$prayer$reminders$hi reminders = _Translations$prayer$reminders$hi._(_root);
	@override late final _Translations$prayer$retreat$hi retreat = _Translations$prayer$retreat$hi._(_root);
	@override late final _Translations$prayer$session$hi session = _Translations$prayer$session$hi._(_root);
	@override late final _Translations$prayer$done$hi done = _Translations$prayer$done$hi._(_root);
	@override late final _Translations$prayer$topics$hi topics = _Translations$prayer$topics$hi._(_root);
	@override late final _Translations$prayer$lists$hi lists = _Translations$prayer$lists$hi._(_root);
	@override late final _Translations$prayer$importunity$hi importunity = _Translations$prayer$importunity$hi._(_root);
}

// Path: sending
class _Translations$sending$hi extends Translations$sending$fr {
	_Translations$sending$hi._(TranslationsHi root) : this._root = root, super.internal(root);

	final TranslationsHi _root; // ignore: unused_field

	// Translations
	@override String get title => 'मेरे आत्मिक अगुवों को भेजना';
	@override String get moreOff => 'बंद';
	@override String get intro => 'चुने हुए समय पर CMFI Connect उस अवधि की तुम्हारी रिपोर्ट तैयार करता है। तुम्हें बस उसे अपने आत्मिक अगुवों को भेजना है।';
	@override String get enabled => 'इसे नियमित रूप से तैयार करो';
	@override String get rhythm => 'अंतराल';
	@override String get weekly => 'हर हफ़्ते';
	@override String get biweekly => 'हर 2 हफ़्ते';
	@override String get monthly => 'हर महीने';
	@override String get day => 'दिन';
	@override String get monthlyDay => 'हर महीने की 1 तारीख़ को, पिछले महीने के लिए';
	@override String get time => 'समय';
	@override String get recipients => 'प्राप्तकर्ता';
	@override String get noAuthorities => 'पहले अपने आत्मिक अगुवे जोड़ो।';
	@override String get addAuthorities => 'मेरे अगुवे जोड़ो';
	@override String get viaWhatsApp => 'WhatsApp से';
	@override String get viaEmail => 'ई-मेल से';
	@override String get viaBoth => 'WhatsApp या ई-मेल से';
	@override String get viaShare => 'शेयर करके';
	@override String next({required Object date}) => 'अगला: ${date}';
	@override String get prepareNow => 'अभी तैयार करो';
	@override String get history => 'पिछली बार भेजे गए';
	@override String get notificationTitle => 'तुम्हारी रिपोर्ट तैयार है';
	@override String get notificationBody => 'एक टैप में अपने अगुवों को भेजो।';
	@override String get channel => 'रिपोर्ट भेजना';
	@override String get readyTitle => 'तुम्हारी रिपोर्ट तैयार है';
	@override String get preview => 'संदेश का पूर्वावलोकन';
	@override String greeting({required Object name}) => 'नमस्ते ${name},';
	@override String get whatsApp => 'WhatsApp';
	@override String get email => 'ई-मेल';
	@override String get sharePdf => 'PDF शेयर करो';
	@override String get shareText => 'टेक्स्ट शेयर करो';
	@override String get sent => 'भेजा गया';
	@override String get shared => 'शेयर किया';
	@override String get noRecipients => 'सेटिंग्स में प्राप्तकर्ता चुनो, या PDF शेयर करो।';
	@override String get settings => 'सेटिंग्स';
	@override String get permissionDenied => 'सही समय पर याद दिलाने के लिए सूचनाएँ चालू करो।';
}

// Path: streak
class _Translations$streak$hi extends Translations$streak$fr {
	_Translations$streak$hi._(TranslationsHi root) : this._root = root, super.internal(root);

	final TranslationsHi _root; // ignore: unused_field

	// Translations
	@override String title({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hi'))(n,
		one: 'लगातार ${n} दिन!',
		other: 'लगातार ${n} दिन!',
	);
	@override String cardDays({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hi'))(n,
		one: 'दिन परमेश्वर के साथ',
		other: 'दिन परमेश्वर के साथ',
	);
	@override late final _Translations$streak$lines$hi lines = _Translations$streak$lines$hi._(_root);
	@override String get share => 'शेयर करो';
	@override String get close => 'आगे बढ़ो';
}

// Path: shortcuts
class _Translations$shortcuts$hi extends Translations$shortcuts$fr {
	_Translations$shortcuts$hi._(TranslationsHi root) : this._root = root, super.internal(root);

	final TranslationsHi _root; // ignore: unused_field

	// Translations
	@override String get today => 'अपनी रिपोर्ट भरो';
	@override String get hymns => 'भजन';
	@override String get retreat => 'अभी का प्रार्थना-समय';
}

// Path: blocking
class _Translations$blocking$hi extends Translations$blocking$fr {
	_Translations$blocking$hi._(TranslationsHi root) : this._root = root, super.internal(root);

	final TranslationsHi _root; // ignore: unused_field

	// Translations
	@override String get report => 'रिपोर्ट करो';
	@override String block({required Object name}) => '${name} को ब्लॉक करो';
	@override String blockTitle({required Object name}) => '${name} को ब्लॉक करो?';
	@override String blockText({required Object name}) => 'तुम्हें ${name} से अब कोई न्योता नहीं मिलेगा। यह न्योता हटा दिया जाएगा।';
	@override String get blockAction => 'ब्लॉक करो';
	@override String blocked({required Object name}) => '${name} अब तुम्हें न्योता नहीं दे पाएगा।';
	@override String get reportTitle => 'इस न्योते की रिपोर्ट करो';
	@override String get reportText => 'हमें बताओ क्या गलत है: समुदाय के अगुवे इसे देखेंगे।';
	@override late final _Translations$blocking$reasons$hi reasons = _Translations$blocking$reasons$hi._(_root);
	@override String get comment => 'टिप्पणी';
	@override String get commentHint => 'अगुवों को क्या जानना चाहिए';
	@override String get send => 'रिपोर्ट भेजो';
	@override String get reported => 'धन्यवाद, अगुवे इसे देखेंगे।';
	@override String get listTitle => 'ब्लॉक किए गए सदस्य';
	@override String get intro => 'उनके प्रार्थना के न्योते अब तुम तक नहीं पहुँचते।';
	@override String get empty => 'तुमने किसी को ब्लॉक नहीं किया है।';
	@override String get unblock => 'अनब्लॉक करो';
	@override String unblocked({required Object name}) => '${name} तुम्हें फिर से न्योता दे सकता है।';
}

// Path: verses
class _Translations$verses$hi extends Translations$verses$fr {
	_Translations$verses$hi._(TranslationsHi root) : this._root = root, super.internal(root);

	final TranslationsHi _root; // ignore: unused_field

	// Translations
	@override String get title => 'आज का वचन';
	@override String get share => 'वचन शेयर करो';
	@override String get shareImage => 'चित्र शेयर करो';
	@override String get shareText => 'टेक्स्ट शेयर करो';
}

// Path: bible
class _Translations$bible$hi extends Translations$bible$fr {
	_Translations$bible$hi._(TranslationsHi root) : this._root = root, super.internal(root);

	final TranslationsHi _root; // ignore: unused_field

	// Translations
	@override String get title => 'बाइबल';
	@override String get books => 'पुस्तकें';
	@override String get oldTestament => 'पुराना नियम';
	@override String get newTestament => 'नया नियम';
	@override String chapters({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hi'))(n,
		one: '${n} अध्याय',
		other: '${n} अध्याय',
	);
	@override String chapter({required Object n}) => 'अध्याय ${n}';
	@override String get version => 'अनुवाद';
	@override String get versions => 'बाइबल का अनुवाद';
	@override String get search => 'बाइबल में खोजें';
	@override String get searchHint => 'कोई शब्द, या “यूहन्ना 3:16”';
	@override String get searchTip => 'कोई शब्द खोजें (“प्रेम”) या सीधे किसी अंश पर जाएँ (“भजन संहिता 23”, “यूहन्ना 3:16”)।';
	@override String get searchNone => 'किसी भी पद में ये शब्द नहीं हैं।';
	@override String searchCount({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hi'))(n,
		one: '${n} पद',
		other: '${n} पद',
	);
	@override String searchLimit({required Object n}) => 'पहले ${n} पद';
	@override String get searchNeedsDownload => 'पूरी बाइबल में शब्द खोजने के लिए इसे डाउनलोड करें। आप अभी कोई अंश लिख सकते हैं: “यूहन्ना 3:16”।';
	@override String open({required Object reference}) => '${reference} खोलें';
	@override String get previous => 'पिछला अध्याय';
	@override String get next => 'अगला अध्याय';
	@override String get markRead => 'मैंने यह अध्याय पढ़ लिया';
	@override String get markedRead => 'आज पढ़ा गया';
	@override String get markReadHint => 'आपकी रिपोर्ट में “बाइबल पठन” में 1 अध्याय जोड़ता है।';
	@override String addedToReport({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hi'))(n,
		one: 'रिपोर्ट: आज ${n} अध्याय पढ़ा',
		other: 'रिपोर्ट: आज ${n} अध्याय पढ़े',
	);
	@override String get removedFromReport => 'आपकी रिपोर्ट से हटाया गया';
	@override String get noReadingItem => 'आपकी रिपोर्ट में “बाइबल पठन” नहीं है।';
	@override String get download => 'यह बाइबल डाउनलोड करें';
	@override String downloadHelp({required Object size}) => 'लगभग ${size} MB, बिना नेटवर्क के पढ़ने और खोजने के लिए।';
	@override String downloading({required Object percent}) => 'डाउनलोड हो रहा है… ${percent}%';
	@override String get downloaded => 'आपके फ़ोन पर';
	@override String downloadDone({required Object version}) => '${version} आपके फ़ोन पर है';
	@override String get removeDownload => 'फ़ोन से हटाएँ';
	@override String removeDownloadTitle({required Object version}) => '${version} को फ़ोन से हटाएँ?';
	@override String get removeDownloadText => 'जो अध्याय आप पढ़ चुके हैं, वे बिना नेटवर्क के उपलब्ध रहेंगे।';
	@override String get offline => 'यह अध्याय अभी आपके फ़ोन पर नहीं है। फिर से ऑनलाइन आएँ, या बिना नेटवर्क के पढ़ने के लिए यह बाइबल डाउनलोड करें।';
	@override String get notInVersion => 'यह अंश इस अनुवाद में नहीं है।';
	@override String get marks => 'मेरे पद';
	@override String get favorites => 'सहेजे गए';
	@override String get highlights => 'हाइलाइट किए गए';
	@override String get noFavorites => 'किसी पद को छुएँ, फिर बुकमार्क को, ताकि वह यहाँ मिले।';
	@override String get noHighlights => 'किसी पद को छुएँ, फिर कोई रंग चुनें, उसे हाइलाइट करने के लिए।';
	@override String get tapHint => 'किसी पद को हाइलाइट करने, सहेजने, कॉपी करने या साझा करने के लिए उसे छुएँ।';
	@override String highlight({required Object color}) => '${color} रंग से हाइलाइट करें';
	@override late final _Translations$bible$colors$hi colors = _Translations$bible$colors$hi._(_root);
	@override String get removeHighlight => 'रंग हटाएँ';
	@override String get addFavorite => 'मेरे पद में सहेजें';
	@override String get removeFavorite => 'मेरे पद से हटाएँ';
	@override String get favoriteAdded => 'मेरे पद में सहेजा गया';
	@override String get favoriteRemoved => 'मेरे पद से हटाया गया';
	@override String get copy => 'कॉपी करें';
	@override String get copied => 'कॉपी हो गया';
	@override String get share => 'साझा करें';
	@override String get closeSelection => 'चयन बंद करें';
	@override String get display => 'प्रदर्शन';
	@override String get jesusInRed => 'यीशु के वचन लाल रंग में';
	@override String get jesusInRedHelp => 'उन अनुवादों में जो उन्हें चिह्नित करते हैं';
	@override String get remove => 'हटाएँ';
	@override String get readInBible => 'बाइबल में पढ़ें';
	@override String get more => 'और विकल्प';
}

// Path: profilePhoto
class _Translations$profilePhoto$hi extends Translations$profilePhoto$fr {
	_Translations$profilePhoto$hi._(TranslationsHi root) : this._root = root, super.internal(root);

	final TranslationsHi _root; // ignore: unused_field

	// Translations
	@override String get title => 'प्रोफ़ाइल फ़ोटो';
	@override String get add => 'प्रोफ़ाइल फ़ोटो जोड़ें';
	@override String get change => 'प्रोफ़ाइल फ़ोटो बदलें';
	@override String get seenBy => 'जहाँ भी आपका नाम दिखता है, अन्य सदस्य इसे देखते हैं।';
	@override String get camera => 'फ़ोटो लें';
	@override String get gallery => 'गैलरी से चुनें';
	@override String get remove => 'फ़ोटो हटाएँ';
	@override String get cropTitle => 'अपनी फ़ोटो काटें';
	@override String get cropHint => 'उंगलियों से फ़ोटो को खिसकाएँ और बड़ा करें।';
	@override String get use => 'यह फ़ोटो इस्तेमाल करें';
	@override String get unreadable => 'यह तस्वीर नहीं खुल सकती। कोई दूसरी चुनें।';
	@override String get saved => 'आपकी प्रोफ़ाइल फ़ोटो सहेज ली गई है।';
	@override String get removed => 'आपकी प्रोफ़ाइल फ़ोटो हटा दी गई है।';
}

// Path: disciples
class _Translations$disciples$hi extends Translations$disciples$fr {
	_Translations$disciples$hi._(TranslationsHi root) : this._root = root, super.internal(root);

	final TranslationsHi _root; // ignore: unused_field

	// Translations
	@override String get title => 'मेरे शिष्य';
	@override String get empty => 'अभी कोई शिष्य नहीं';
	@override String get emptyText => 'जब कोई सदस्य तुम्हें अपना चेला बनाने वाला या आत्मिक अधिकारी चुनता है और तुम उसका अनुरोध स्वीकार करते हो, तो वह यहाँ दिखता है।';
	@override String count({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hi'))(n,
		other: '${n} शिष्य',
	);
	@override String get notShared => 'अपनी रिपोर्ट साझा नहीं करता';
	@override String get roleMaker => 'तुम उसके चेला बनाने वाले हो';
	@override String get roleAuthority => 'तुम उसके आत्मिक अधिकारियों में से एक हो';
	@override String dayGoals({required Object percent}) => 'लक्ष्य ${percent} %';
	@override String dayItems({required Object total, required Object filled, required Object percent}) => '${total} में से ${filled} आइटम · ${percent} %';
	@override String get older => 'पिछले 30 दिन देखो';
	@override String get noReports => 'इस अवधि में कोई रिपोर्ट नहीं।';
	@override String get searchHint => 'नाम या यूज़रनेम';
	@override String noMatch({required Object search}) => '“${search}” से कोई शिष्य मेल नहीं खाता।';
}

// Path: weekStory
class _Translations$weekStory$hi extends Translations$weekStory$fr {
	_Translations$weekStory$hi._(TranslationsHi root) : this._root = root, super.internal(root);

	final TranslationsHi _root; // ignore: unused_field

	// Translations
	@override String get title => 'परमेश्वर के साथ तुम्हारा हफ़्ता';
	@override String range({required Object from, required Object to}) => '${from} से ${to} तक';
	@override String get intro => 'इस हफ़्ते प्रभु के साथ जो जिया, उसे फिर से देखो।';
	@override String get tapHint => 'आगे जाने के लिए दाईं ओर, वापस आने के लिए बाईं ओर छुओ।';
	@override String get faithfulLead => 'तुम वफ़ादार रहे';
	@override String get emptyLead => 'एक नया हफ़्ता तुम्हारा इंतज़ार कर रहा है';
	@override String days({required num n, required Object total}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hi'))(n,
		one: '${total} में से\n${n} दिन',
		other: '${total} में से\n${n} दिन',
	);
	@override String streak({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hi'))(n,
		one: 'लगातार ${n} दिन',
		other: 'लगातार ${n} दिन',
	);
	@override String streakRecord({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hi'))(n,
		one: 'लगातार ${n} दिन: तुम्हारा रिकॉर्ड!',
		other: 'लगातार ${n} दिन: तुम्हारा रिकॉर्ड!',
	);
	@override String get emptyText => 'हर दिन अपनी रिपोर्ट भरो: तुम्हारा अगला हफ़्ता यहाँ लिखा जाएगा।';
	@override String get prayerLead => 'तुमने प्रार्थना की';
	@override String retreats({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hi'))(n,
		one: '${n} प्रार्थना-समय',
		other: '${n} प्रार्थना-समय',
	);
	@override String retreatsTime({required Object time}) => '15 मिनट के · प्रभु के साथ ${time}';
	@override String faithfulMoment({required num n, required Object moment}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hi'))(n,
		one: 'तुम्हारा सबसे वफ़ादार समय: ${moment} (${n} बार)',
		other: 'तुम्हारा सबसे वफ़ादार समय: ${moment} (${n} बार)',
	);
	@override String get noRetreat => 'इस हफ़्ते कोई प्रार्थना-समय नहीं';
	@override String get noRetreatText => 'दोपहर का प्रार्थना-समय तुम्हारा इंतज़ार कर रहा है: प्रभु के साथ 15 मिनट।';
	@override String get goalsLead => 'तुम्हारे लक्ष्य';
	@override String get goalsReached => 'औसतन पूरे हुए';
	@override String bestDay({required Object day, required Object percent}) => 'तुम्हारा सबसे अच्छा दिन: ${day} · ${percent}';
	@override String get summaryTitle => 'परमेश्वर के साथ मेरा हफ़्ता';
	@override String get statDays => 'दिन भरे गए';
	@override String statStreak({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hi'))(n,
		one: 'दिन लगातार',
		other: 'दिन लगातार',
	);
	@override String statRetreats({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hi'))(n,
		one: 'प्रार्थना-समय',
		other: 'प्रार्थना-समय',
	);
	@override String get statGoals => 'लक्ष्य';
	@override String get share => 'अपना हफ़्ता साझा करो';
	@override String get homeText => 'इस हफ़्ते की तुम्हारी वफ़ादारी, प्रार्थना और लक्ष्य।';
	@override String get open => 'मेरा हफ़्ता देखो';
	@override String get notificationTitle => 'परमेश्वर के साथ तुम्हारा हफ़्ता तैयार है';
	@override String get notificationBody => 'इस हफ़्ते की अपनी वफ़ादारी फिर से देखो और साझा करो।';
	@override String get channel => 'परमेश्वर के साथ तुम्हारा हफ़्ता';
	@override String get thisWeek => 'यह हफ़्ता';
	@override String get pastWeeks => 'पिछले हफ़्ते';
	@override String weekOf({required Object date}) => '${date} का हफ़्ता';
	@override String page({required Object total, required Object current}) => '${total} में से ${current}';
}

// Path: onboarding.reports
class _Translations$onboarding$reports$hi extends Translations$onboarding$reports$fr {
	_Translations$onboarding$reports$hi._(TranslationsHi root) : this._root = root, super.internal(root);

	final TranslationsHi _root; // ignore: unused_field

	// Translations
	@override String get title => 'परमेश्वर के साथ तुम्हारा सफ़र, दिन-ब-दिन';
	@override String get text => 'कुछ ही सेकंड में अपना बाइबल पठन, प्रार्थना, उपवास… दर्ज करो और हफ़्ते-दर-हफ़्ते अपनी प्रगति देखो।';
}

// Path: onboarding.worship
class _Translations$onboarding$worship$hi extends Translations$onboarding$worship$fr {
	_Translations$onboarding$worship$hi._(TranslationsHi root) : this._root = root, super.internal(root);

	final TranslationsHi _root; // ignore: unused_field

	// Translations
	@override String get title => 'जहाँ भी हो, गाओ और प्रार्थना करो';
	@override String get text => 'समुदाय के भजन यहाँ पाओ और हर दिन अपने भाई-बहनों के साथ प्रार्थना विषयों के लिए प्रार्थना करो।';
}

// Path: onboarding.community
class _Translations$onboarding$community$hi extends Translations$onboarding$community$fr {
	_Translations$onboarding$community$hi._(TranslationsHi root) : this._root = root, super.internal(root);

	final TranslationsHi _root; // ignore: unused_field

	// Translations
	@override String get title => 'अपने समुदाय से जुड़ाव बनाए रखो';
	@override String get text => 'तुम्हारी सभा के कार्यक्रम और घोषणाएँ, एक ही जगह पर, ताकि कुछ भी न छूटे।';
}

// Path: onboarding.sample
class _Translations$onboarding$sample$hi extends Translations$onboarding$sample$fr {
	_Translations$onboarding$sample$hi._(TranslationsHi root) : this._root = root, super.internal(root);

	final TranslationsHi _root; // ignore: unused_field

	// Translations
	@override String get today => 'आज';
	@override String get bibleReading => 'बाइबल पठन';
	@override String get prayerAlone => 'व्यक्तिगत प्रार्थना';
	@override String get meditation => 'मनन';
	@override String get groupPrayer => 'समूह प्रार्थना';
	@override String get thisWeek => 'इस हफ़्ते';
	@override String get weekScore => '5 में से 4 दिन';
	@override String get hymn => 'भजन';
	@override String get hymnNumber => 'नं. 12';
	@override String get fullScreen => 'फ़ुल स्क्रीन';
	@override String get prayerOfTheDay => 'आज का प्रार्थना विषय';
	@override String get prayerTopic => 'हमारे युवाओं की परीक्षाओं के लिए';
	@override String get praying => '12 लोग प्रार्थना कर रहे हैं';
	@override String get iPray => 'प्रार्थना में शामिल हूँ';
	@override String get vigil => 'रात्रि प्रार्थना सभा';
	@override String get vigilMeta => 'रात 8 बजे · स्थानीय सभा';
	@override String get join => 'मैं शामिल हूँ';
	@override String get retreat => 'युवा रिट्रीट';
	@override String get retreatMeta => 'पूरा दिन';
	@override String get announcement => 'घोषणा';
	@override String get announcementText => 'रविवार की आराधना सुबह 8:30 बजे शुरू होगी।';
	@override String get chapters => '10 अध्याय';
}

// Path: auth.login
class _Translations$auth$login$hi extends Translations$auth$login$fr {
	_Translations$auth$login$hi._(TranslationsHi root) : this._root = root, super.internal(root);

	final TranslationsHi _root; // ignore: unused_field

	// Translations
	@override String get title => 'फिर से स्वागत है';
	@override String get subtitle => 'आज की रिपोर्ट भरने के लिए लॉग इन करो।';
	@override String get submit => 'लॉग इन करो';
	@override String get noAccount => 'अभी तक अकाउंट नहीं है?';
	@override String get createAccount => 'अकाउंट बनाओ';
}

// Path: auth.register
class _Translations$auth$register$hi extends Translations$auth$register$fr {
	_Translations$auth$register$hi._(TranslationsHi root) : this._root = root, super.internal(root);

	final TranslationsHi _root; // ignore: unused_field

	// Translations
	@override String step({required Object current, required Object total}) => '${current} / ${total}';
	@override String get title => 'अपना अकाउंट बनाओ';
	@override String get subtitle => 'लॉग इन करने के लिए तुम्हारा फ़ोन नंबर इस्तेमाल होगा।';
	@override String get firstName => 'पहला नाम';
	@override String get lastName => 'सरनेम';
	@override String get passwordHelp => 'कम से कम 6 कैरेक्टर';
	@override String get email => 'ईमेल';
	@override String get submit => 'आगे बढ़ो';
	@override String get haveAccount => 'पहले से अकाउंट है?';
	@override String get login => 'लॉग इन करो';
	@override String get alreadyUsed => 'इस नंबर या ईमेल से पहले ही अकाउंट बना हुआ है। लॉग इन करो।';
	@override String get emailHint => 'tum@example.com';
}

// Path: auth.church
class _Translations$auth$church$hi extends Translations$auth$church$fr {
	_Translations$auth$church$hi._(TranslationsHi root) : this._root = root, super.internal(root);

	final TranslationsHi _root; // ignore: unused_field

	// Translations
	@override String get title => 'तुम्हारा चर्च';
	@override String get subtitle => 'इस जानकारी से तुम्हारे अगुवे तुम्हें आसानी से ढूँढ पाएँगे। इसे बाद में बदला जा सकता है।';
	@override String get editTitle => 'मेरी प्रोफ़ाइल';
	@override String get editSubtitle => 'अपना नाम, चर्च और सभा अपडेट करो।';
	@override String get country => 'देश';
	@override String get countryHint => 'अपना देश चुनो';
	@override String get city => 'शहर';
	@override String get cityHint => 'नई दिल्ली';
	@override String get church => 'चर्च';
	@override String get churchHint => 'तुम्हारे चर्च का नाम';
	@override String get assembly => 'सभा';
	@override String get assemblyHint => 'तुम्हारी सभा का नाम';
	@override String get info => 'शहर या सभा बदल ली है? अपनी प्रोफ़ाइल से सब कुछ अपडेट किया जा सकता है।';
	@override String get submit => 'पूरा करो';
	@override String get skip => 'यह चरण छोड़ो';
	@override String get saved => 'प्रोफ़ाइल सेव हो गई';
}

// Path: auth.forgot
class _Translations$auth$forgot$hi extends Translations$auth$forgot$fr {
	_Translations$auth$forgot$hi._(TranslationsHi root) : this._root = root, super.internal(root);

	final TranslationsHi _root; // ignore: unused_field

	// Translations
	@override String get link => 'पासवर्ड भूल गए?';
	@override String get title => 'पासवर्ड भूल गए';
	@override String get phoneText => 'अपना नंबर डालो: नया पासवर्ड चुनने के लिए हम SMS से एक कोड भेजेंगे।';
	@override String get sendCode => 'कोड पाओ';
	@override String get codeTitle => 'कोड डालो';
	@override String codeText({required Object phone}) => 'हमने ${phone} पर 6 अंकों का कोड भेजा है।';
	@override String get code => 'SMS से मिला कोड';
	@override String get codeInvalid => 'कोड 6 अंकों का है';
	@override String get verify => 'जाँचो';
	@override String get resend => 'कोड फिर से भेजो';
	@override String resendIn({required Object seconds}) => '${seconds} सेकंड में फिर भेजो';
	@override String get changeNumber => 'नंबर बदलो';
	@override String get passwordTitle => 'नया पासवर्ड';
	@override String get passwordText => 'अपने खाते के लिए नया पासवर्ड चुनो।';
	@override String get submit => 'सहेजो और साइन इन करो';
	@override String get done => 'पासवर्ड बदल गया। फिर से स्वागत है!';
	@override String get remembered => 'याद आ गया?';
	@override String get invalidCode => 'यह कोड सही नहीं है।';
	@override String get expired => 'कोड की अवधि खत्म हो गई। नया कोड माँगो।';
	@override String get tooManyRequests => 'बहुत ज़्यादा कोशिशें। थोड़ी देर बाद फिर कोशिश करो।';
	@override String get unavailable => 'अभी पासवर्ड रीसेट उपलब्ध नहीं है।';
	@override String get noAccount => 'इस नंबर से कोई खाता नहीं है।';
}

// Path: reports.tabs
class _Translations$reports$tabs$hi extends Translations$reports$tabs$fr {
	_Translations$reports$tabs$hi._(TranslationsHi root) : this._root = root, super.internal(root);

	final TranslationsHi _root; // ignore: unused_field

	// Translations
	@override String get today => 'आज';
	@override String get history => 'इतिहास';
	@override String get summary => 'सारांश';
}

// Path: reports.measure
class _Translations$reports$measure$hi extends Translations$reports$measure$fr {
	_Translations$reports$measure$hi._(TranslationsHi root) : this._root = root, super.internal(root);

	final TranslationsHi _root; // ignore: unused_field

	// Translations
	@override String quantity({required Object unit}) => '${unit}';
	@override String get duration => 'अवधि';
	@override String both({required Object unit}) => '${unit} और अवधि';
	@override String get quantityNoUnit => 'मात्रा';
	@override String get bothNoUnit => 'मात्रा और अवधि';
}

// Path: reports.sheet
class _Translations$reports$sheet$hi extends Translations$reports$sheet$fr {
	_Translations$reports$sheet$hi._(TranslationsHi root) : this._root = root, super.internal(root);

	final TranslationsHi _root; // ignore: unused_field

	// Translations
	@override String get quantity => 'मात्रा';
	@override String get duration => 'अवधि';
	@override String get minus1 => '− 1 मिनट';
	@override String get plus1 => '+ 1 मिनट';
	@override String get removeMinute => 'एक मिनट घटाओ';
	@override String get addMinute => 'एक मिनट जोड़ो';
	@override String get holdToRepeat => 'तेज़ी से बदलने के लिए दबाकर रखो';
	@override String get decrease => 'घटाओ';
	@override String get increase => 'बढ़ाओ';
	@override String get clear => 'मिटाओ';
	@override String get validate => 'ठीक है';
}

// Path: reports.history
class _Translations$reports$history$hi extends Translations$reports$history$fr {
	_Translations$reports$history$hi._(TranslationsHi root) : this._root = root, super.internal(root);

	final TranslationsHi _root; // ignore: unused_field

	// Translations
	@override String daysFilled({required Object total, required Object filled}) => '${total} में से ${filled} दिन भरे गए';
	@override String get legendFilled => 'भरा गया';
	@override String get legendMissing => 'कोई रिपोर्ट नहीं';
	@override String get none => 'कोई रिपोर्ट नहीं';
	@override String get fill => 'भरो';
	@override String get inProgress => 'जारी है';
	@override String get previousMonth => 'पिछला महीना';
	@override String get nextMonth => 'अगला महीना';
	@override String get today => 'आज';
}

// Path: reports.summary
class _Translations$reports$summary$hi extends Translations$reports$summary$fr {
	_Translations$reports$summary$hi._(TranslationsHi root) : this._root = root, super.internal(root);

	final TranslationsHi _root; // ignore: unused_field

	// Translations
	@override String get week => 'हफ़्ता';
	@override String get month => 'महीना';
	@override String get year => 'साल';
	@override String range({required Object from, required Object to}) => '${from} से ${to} तक';
	@override String get regularity => 'नियमितता';
	@override String get daysFilled => 'दिन भरे गए';
	@override String missingDays({required num n, required Object days}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hi'))(n,
		one: 'रिपोर्ट के बिना ${n} दिन: ${days} तारीख़',
		other: 'रिपोर्ट के बिना ${n} दिन: ${days} तारीख़',
	);
	@override String missingCount({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hi'))(n,
		one: 'रिपोर्ट के बिना ${n} दिन',
		other: 'रिपोर्ट के बिना ${n} दिन',
	);
	@override String get noMissing => 'एक भी दिन नहीं छूटा, शाबाश!';
	@override String perDay({required Object value}) => 'भरे गए हर दिन पर औसतन ${value}';
	@override String days({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hi'))(n,
		one: '${n} दिन',
		other: '${n} दिन',
	);
	@override String get notFilled => 'अभी तक नहीं भरे गए';
	@override String barsCaption({required Object max}) => 'प्रति दिन · सबसे ऊँचा बार: ${max}';
	@override String barsCaptionMonthly({required Object max}) => 'प्रति महीना · सबसे ऊँचा बार: ${max}';
	@override String get empty => 'इस अवधि में कोई रिपोर्ट नहीं है।';
	@override String goalDays({required num n, required Object total}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hi'))(n,
		one: '${total} में से ${n} दिन लक्ष्य पूरा हुआ',
		other: '${total} में से ${n} दिन लक्ष्य पूरा हुआ',
	);
	@override String get share => 'यह सारांश शेयर करो';
	@override String get goals => 'लक्ष्य';
	@override String get goalsAverage => 'तुम्हारे लक्ष्यों की औसत पूर्ति';
	@override String get goalsHint => 'हर दिन गिना जाता है, खाली भी। आज भरने के बाद गिना जाता है।';
	@override String get evolution => 'तुम्हारे लक्ष्यों की प्रगति';
	@override String get evolutionHint => 'हफ़्ते दर हफ़्ते, पिछले 12 हफ़्तों में।';
	@override String get premiumYear => 'साल और तुम्हारे लक्ष्यों की प्रगति Premium के साथ आते हैं।';
}

// Path: reports.standardItems
class _Translations$reports$standardItems$hi extends Translations$reports$standardItems$fr {
	_Translations$reports$standardItems$hi._(TranslationsHi root) : this._root = root, super.internal(root);

	final TranslationsHi _root; // ignore: unused_field

	// Translations
	@override String get lb => 'बाइबल पठन';
	@override String get ps => 'व्यक्तिगत प्रार्थना';
	@override String get rdqad => 'मनन';
	@override String get pg => 'समूह प्रार्थना';
	@override String get llc => 'मसीही साहित्य पठन';
	@override String get jc => 'पूर्ण उपवास';
	@override String get jp => 'आंशिक उपवास';
	@override String get dimes => 'दशमांश';
	@override String get off => 'भेंट';
}

// Path: reports.units
class _Translations$reports$units$hi extends Translations$reports$units$fr {
	_Translations$reports$units$hi._(TranslationsHi root) : this._root = root, super.internal(root);

	final TranslationsHi _root; // ignore: unused_field

	// Translations
	@override late final _Translations$reports$units$chapters$hi chapters = _Translations$reports$units$chapters$hi._(_root);
	@override late final _Translations$reports$units$times$hi times = _Translations$reports$units$times$hi._(_root);
	@override late final _Translations$reports$units$pages$hi pages = _Translations$reports$units$pages$hi._(_root);
	@override late final _Translations$reports$units$percent$hi percent = _Translations$reports$units$percent$hi._(_root);
}

// Path: export.doc
class _Translations$export$doc$hi extends Translations$export$doc$fr {
	_Translations$export$doc$hi._(TranslationsHi root) : this._root = root, super.internal(root);

	final TranslationsHi _root; // ignore: unused_field

	// Translations
	@override String get title => 'दैनिक रिपोर्ट';
	@override String get regularity => 'नियमितता';
	@override String daysFilled({required num filled, required Object total}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hi'))(filled,
		one: '${total} में से ${filled} दिन भरा गया',
		other: '${total} में से ${filled} दिन भरे गए',
	);
	@override String get totals => 'पूरी अवधि में';
	@override String get item => 'आइटम';
	@override String get total => 'कुल';
	@override String get days => 'दिन';
	@override String get average => 'औसत / भरा गया दिन';
	@override String get goal => 'लक्ष्य पूरा हुआ';
	@override String get detail => 'दिन-ब-दिन';
	@override String get date => 'तारीख़';
	@override String get values => 'भरा गया';
	@override String get note => 'नोट';
	@override String get noReport => 'कोई रिपोर्ट नहीं';
	@override String generated({required Object date}) => '${date} को CMFI Connect से बनाया गया';
	@override String page({required Object n, required Object total}) => 'पेज ${n} / ${total}';
	@override String get filledColumn => 'रिपोर्ट';
	@override String get yes => 'हाँ';
	@override String get no => 'नहीं';
	@override String get sentFrom => 'CMFI Connect से भेजा गया';
}

// Path: items.measure
class _Translations$items$measure$hi extends Translations$items$measure$fr {
	_Translations$items$measure$hi._(TranslationsHi root) : this._root = root, super.internal(root);

	final TranslationsHi _root; // ignore: unused_field

	// Translations
	@override String quantity({required Object unit}) => 'मात्रा · ${unit}';
	@override String get quantityNoUnit => 'मात्रा';
	@override String get duration => 'अवधि';
	@override String both({required Object unit}) => 'मात्रा (${unit}) और अवधि';
	@override String get bothNoUnit => 'मात्रा और अवधि';
}

// Path: authorities.form
class _Translations$authorities$form$hi extends Translations$authorities$form$fr {
	_Translations$authorities$form$hi._(TranslationsHi root) : this._root = root, super.internal(root);

	final TranslationsHi _root; // ignore: unused_field

	// Translations
	@override String get title => 'नया अगुवा';
	@override String get emailHint => 'naam@example.com';
	@override String get isDiscipleMaker => 'ये मेरे चेला बनाने वाले हैं';
	@override String get isDiscipleMakerHelp => 'जो व्यक्ति व्यक्तिगत रूप से तुम्हारा मार्गदर्शन करता है। ऐसा सिर्फ़ एक ही हो सकता है।';
	@override String discipleMakerTaken({required Object name}) => 'तुम्हारे चेला बनाने वाले के रूप में ${name} पहले से दर्ज हैं। किसी और को चुनने के लिए पहले उन्हें सूची से हटाओ।';
	@override String get submit => 'जोड़ो';
	@override String added({required Object name}) => '${name} अब तुम्हारे अगुवों में शामिल हैं।';
	@override String get searchLabel => 'उनका यूज़रनेम';
	@override String get searchHint => 'यूज़रनेम';
	@override String get search => 'खोजो';
	@override String get searchHelp => 'अगर वे CMFI Connect इस्तेमाल करते हैं, तो उन्हें उनके यूज़रनेम से खोजो। उन्हें तुम्हारा अनुरोध मिलेगा, और उनके स्वीकार करने के बाद उनकी संपर्क जानकारी दिखेगी।';
	@override String notFound({required Object username}) => 'किसी का यूज़रनेम @${username} नहीं है।';
	@override String get invite => 'उन्हें CMFI Connect से जुड़ने का न्योता दो';
	@override String get inviteText => 'नमस्ते! परमेश्वर के साथ अपने सफ़र को दर्ज करने के लिए मेरे पास CMFI Connect ऐप है, और मेरी इच्छा है कि आप इसमें मेरा साथ दें। ऐप इंस्टॉल करें, अपना अकाउंट बनाएँ, फिर मुझे अपना यूज़रनेम भेजें ताकि मैं आपको जोड़ सकूँ।';
	@override String inviteMine({required Object username}) => 'मेरा यूज़रनेम: @${username}';
	@override String get manual => 'उनके पास ऐप नहीं है? उनकी जानकारी ख़ुद भरो';
	@override String get backToSearch => 'यूज़रनेम से खोजो';
	@override String get request => 'अनुरोध भेजो';
	@override String requested({required Object name}) => '${name} को अनुरोध भेज दिया गया।';
	@override String get alreadyAdded => 'यह व्यक्ति पहले से तुम्हारे अगुवों में शामिल है।';
	@override String get makerExists => 'तुम्हारे पास पहले से एक चेला बनाने वाला है।';
	@override String get yourself => 'यह तुम्हारा अपना यूज़रनेम है।';
	@override String sharingHelp({required Object name}) => '${name} तुम्हारी रिपोर्ट देखेगा: भरे गए आइटम, तुम्हारी नियमितता और प्रतिशत, तुम्हारा नोट कभी नहीं। तुम इसे उसके कार्ड पर बंद कर सकते हो।';
}

// Path: authorities.sharing
class _Translations$authorities$sharing$hi extends Translations$authorities$sharing$fr {
	_Translations$authorities$sharing$hi._(TranslationsHi root) : this._root = root, super.internal(root);

	final TranslationsHi _root; // ignore: unused_field

	// Translations
	@override String get title => 'मेरी रिपोर्ट साझा करो';
	@override String help({required Object name}) => '${name} तुम्हारी रिपोर्ट देखता है: भरे गए आइटम, तुम्हारी नियमितता और प्रतिशत, तुम्हारा नोट कभी नहीं।';
	@override String on({required Object name}) => 'तुम्हारी रिपोर्ट ${name} के साथ साझा है।';
	@override String off({required Object name}) => '${name} अब तुम्हारी रिपोर्ट नहीं देखता।';
}

// Path: members.deleteAccount
class _Translations$members$deleteAccount$hi extends Translations$members$deleteAccount$fr {
	_Translations$members$deleteAccount$hi._(TranslationsHi root) : this._root = root, super.internal(root);

	final TranslationsHi _root; // ignore: unused_field

	// Translations
	@override String get button => 'मेरा खाता हटाओ';
	@override String get title => 'मेरा खाता हटाओ';
	@override String get intro => 'यह स्थायी है। तुम्हारा खाता और उससे जुड़ा सब कुछ मिटा दिया जाएगा:';
	@override String get itemProfile => 'तुम्हारी प्रोफ़ाइल, फ़ोटो, यूज़रनेम और पासवर्ड';
	@override String get itemReports => 'तुम्हारी सारी रिपोर्ट, आइटम और लक्ष्य';
	@override String get itemAuthorities => 'तुम्हारे आत्मिक अगुवे और मिले हुए अनुरोध';
	@override String get itemEvents => 'कार्यक्रमों के लिए तुम्हारे पंजीकरण';
	@override String get itemPrayer => 'तुम्हारी प्रार्थना सूचियाँ, प्रार्थना-समय और लगातार प्रार्थना के विषय';
	@override String get kept => 'एडमिन के रूप में प्रकाशित किए गए कार्यक्रम, ख़बरें, फ़ोटो और प्रार्थना विषय समुदाय के लिए रहेंगे, तुम्हारे नाम के बिना।';
	@override String get passwordHelp => 'यह पक्का करने के लिए कि यह तुम ही हो।';
	@override String get confirm => 'हमेशा के लिए हटाओ';
	@override String get done => 'तुम्हारा खाता हटा दिया गया है। परमेश्वर तुम्हें आशीष दे!';
	@override String get wrongPassword => 'पासवर्ड ग़लत है।';
	@override String get lastSuperadmin => 'तुम अकेले सुपरएडमिन हो: खाता हटाने से पहले यह भूमिका किसी और को दो।';
}

// Path: hymns.tabs
class _Translations$hymns$tabs$hi extends Translations$hymns$tabs$fr {
	_Translations$hymns$tabs$hi._(TranslationsHi root) : this._root = root, super.internal(root);

	final TranslationsHi _root; // ignore: unused_field

	// Translations
	@override String get all => 'सभी';
	@override String get favorites => 'पसंदीदा';
	@override String get recent => 'हाल के';
}

// Path: hymns.reader
class _Translations$hymns$reader$hi extends Translations$hymns$reader$fr {
	_Translations$hymns$reader$hi._(TranslationsHi root) : this._root = root, super.internal(root);

	final TranslationsHi _root; // ignore: unused_field

	// Translations
	@override String get smaller => 'टेक्स्ट छोटा करो';
	@override String get larger => 'टेक्स्ट बड़ा करो';
	@override String get display => 'डिस्प्ले';
	@override String get textSize => 'टेक्स्ट का आकार';
	@override String get typeface => 'फ़ॉन्ट';
	@override String get typefaceAuto => 'ऑटो';
	@override String get typefaceSans => 'आधुनिक';
	@override String get typefaceSerif => 'क्लासिक';
	@override String get typefaceAutoHelp => 'टेक्स्ट बड़ा होने पर क्लासिक';
	@override String get background => 'बैकग्राउंड';
	@override String get themeAuto => 'ऑटो';
	@override String get themeLight => 'लाइट';
	@override String get themeSepia => 'सेपिया';
	@override String get themeDark => 'डार्क';
	@override String get repeatChorus => 'हर पद के बाद कोरस दोहराओ';
	@override String get keepScreenOn => 'स्क्रीन चालू रखो';
	@override String get addFavorite => 'पसंदीदा में जोड़ो';
	@override String get removeFavorite => 'पसंदीदा से हटाओ';
	@override String get favoriteAdded => 'पसंदीदा में जोड़ा गया';
	@override String get favoriteRemoved => 'पसंदीदा से हटाया गया';
	@override String get more => 'और विकल्प';
	@override String get copy => 'बोल कॉपी करो';
	@override String get copied => 'बोल कॉपी हो गए';
	@override String get project => 'प्रोजेक्शन मोड';
	@override String get pinchHint => 'टेक्स्ट बड़ा या छोटा करने के लिए स्क्रीन पर दो उँगलियों से पिंच करो।';
	@override String get notFound => 'यह भजन अब इस संग्रह में नहीं है।';
	@override String get share => 'बोल शेयर करो';
}

// Path: hymns.projection
class _Translations$hymns$projection$hi extends Translations$hymns$projection$fr {
	_Translations$hymns$projection$hi._(TranslationsHi root) : this._root = root, super.internal(root);

	final TranslationsHi _root; // ignore: unused_field

	// Translations
	@override String get exit => 'प्रोजेक्शन मोड से बाहर निकलो';
	@override String get previous => 'पिछला पद';
	@override String get next => 'अगला पद';
	@override String position({required Object current, required Object total}) => '${current} / ${total}';
	@override String get hint => 'आगे जाने के लिए दाईं ओर, पीछे जाने के लिए बाईं ओर टैप करो।';
}

// Path: hymns.pad
class _Translations$hymns$pad$hi extends Translations$hymns$pad$fr {
	_Translations$hymns$pad$hi._(TranslationsHi root) : this._root = root, super.internal(root);

	final TranslationsHi _root; // ignore: unused_field

	// Translations
	@override String get title => 'भजन पर जाओ';
	@override String get open => 'खोलो';
	@override String get erase => 'मिटाओ';
	@override String notFound({required Object number}) => 'इस संग्रह में भजन नं. ${number} नहीं है';
	@override String get placeholder => 'नंबर टाइप करो';
}

// Path: events.tabs
class _Translations$events$tabs$hi extends Translations$events$tabs$fr {
	_Translations$events$tabs$hi._(TranslationsHi root) : this._root = root, super.internal(root);

	final TranslationsHi _root; // ignore: unused_field

	// Translations
	@override String get program => 'समय-सारणी';
	@override String get news => 'ख़बरें';
	@override String get info => 'जानकारी';
	@override String get photos => 'फ़ोटो';
}

// Path: events.register
class _Translations$events$register$hi extends Translations$events$register$fr {
	_Translations$events$register$hi._(TranslationsHi root) : this._root = root, super.internal(root);

	final TranslationsHi _root; // ignore: unused_field

	// Translations
	@override String get cta => 'मैं शामिल हूँ';
	@override String get title => 'मैं शामिल हूँ';
	@override String get people => 'कितने लोग आएँगे?';
	@override String get peopleHint => 'तुम्हें मिलाकर, तुम्हारे परिवार या समूह के साथ।';
	@override String get less => 'एक व्यक्ति कम';
	@override String get more => 'एक व्यक्ति ज़्यादा';
	@override String get lodging => 'मुझे ठहरने की जगह चाहिए';
	@override String get lodgingHint => 'आयोजक उसी हिसाब से ठहरने की व्यवस्था करेंगे।';
	@override String get departure => 'रवाना होने का शहर';
	@override String get departureHint => 'जैसे: डुआला';
	@override String get confirm => 'मेरा रजिस्ट्रेशन पक्का करो';
	@override String get update => 'अपडेट करो';
	@override String get cancel => 'मेरा रजिस्ट्रेशन रद्द करो';
	@override String get done => 'हो गया, तुम्हारा रजिस्ट्रेशन हो गया! हम तुम्हें एक दिन पहले याद दिलाएँगे।';
	@override String get updated => 'तुम्हारा रजिस्ट्रेशन अपडेट हो गया।';
	@override String get cancelled => 'तुम्हारा रजिस्ट्रेशन रद्द हो गया।';
	@override String get edit => 'बदलो';
	@override String get youAre => 'तुम्हारा रजिस्ट्रेशन हो गया है';
	@override String get cancelTitle => 'अपना रजिस्ट्रेशन रद्द करना है?';
	@override String get cancelText => 'तुम्हारी जगह किसी और को मिल जाएगी।';
	@override String get keep => 'मेरी जगह रहने दो';
	@override String get lodgingShort => 'आवास';
}

// Path: events.reminder
class _Translations$events$reminder$hi extends Translations$events$reminder$fr {
	_Translations$events$reminder$hi._(TranslationsHi root) : this._root = root, super.internal(root);

	final TranslationsHi _root; // ignore: unused_field

	// Translations
	@override String get channel => 'कार्यक्रम रिमाइंडर';
	@override String tomorrow({required Object title}) => 'कल: ${title}';
	@override String soon({required Object title}) => '1 घंटे में: ${title}';
}

// Path: events.admin
class _Translations$events$admin$hi extends Translations$events$admin$fr {
	_Translations$events$admin$hi._(TranslationsHi root) : this._root = root, super.internal(root);

	final TranslationsHi _root; // ignore: unused_field

	// Translations
	@override String get title => 'कार्यक्रम प्रबंधन';
	@override String get create => 'कार्यक्रम बनाओ';
	@override String get edit => 'कार्यक्रम बदलो';
	@override String get empty => 'अभी तक कोई कार्यक्रम नहीं है। पहला कार्यक्रम बनाओ!';
	@override String get poster => 'पोस्टर';
	@override String get posterAdd => 'पोस्टर चुनो';
	@override String get posterChange => 'पोस्टर बदलो';
	@override String get posterRemove => 'पोस्टर हटाओ';
	@override String get posterHint => 'पोर्ट्रेट 4:5 बेहतर रहेगा (1080 × 1350), JPEG या PNG।';
	@override String get uploading => 'तस्वीर भेजी जा रही है…';
	@override String get general => 'कार्यक्रम';
	@override String get titleField => 'शीर्षक';
	@override String get titleHint => 'जैसे: वार्षिक सम्मेलन 2026';
	@override String get titleRequired => 'कार्यक्रम का शीर्षक दो।';
	@override String get theme => 'विषय';
	@override String get themeHint => 'जैसे: आत्मा के अनुसार चलना';
	@override String get verse => 'विषय वचन';
	@override String get description => 'परिचय';
	@override String get when => 'तारीख़ें';
	@override String get starts => 'शुरुआत';
	@override String get ends => 'समापन';
	@override String get endsBeforeStart => 'समापन, शुरुआत के बाद होना चाहिए।';
	@override String timeZone({required Object zone}) => 'स्थान का समय (${zone})।';
	@override String get where => 'स्थान';
	@override String get venue => 'स्थान';
	@override String get venueHint => 'जैसे: म्वोल्ये सम्मेलन केंद्र';
	@override String get address => 'पता';
	@override String get city => 'शहर';
	@override String get country => 'देश';
	@override String get mapsUrl => 'Google Maps लिंक';
	@override String get registration => 'रजिस्ट्रेशन';
	@override String get registrationOpen => 'रजिस्ट्रेशन खुला है';
	@override String get deadline => 'अंतिम तारीख़';
	@override String get noDeadline => 'कोई अंतिम तारीख़ नहीं';
	@override String get capacity => 'जगहों की संख्या';
	@override String get capacityHint => 'ख़ाली: कोई सीमा नहीं';
	@override String get asksLodging => 'पूछो कि किसे ठहरने की जगह चाहिए';
	@override String get asksDeparture => 'रवाना होने का शहर पूछो';
	@override String get fees => 'सहयोग राशि';
	@override String get feesHint => 'जैसे: प्रवेश निःशुल्क। भोजन: 2,000 FCFA प्रति दिन।';
	@override String get contact => 'संपर्क';
	@override String get contactName => 'संपर्क व्यक्ति का नाम';
	@override String get contactPhone => 'संपर्क फ़ोन नंबर';
	@override String get visibility => 'दृश्यता';
	@override String get statusDraft => 'ड्राफ़्ट';
	@override String get statusDraftHint => 'सिर्फ़ एडमिन देख सकते हैं';
	@override String get statusPublished => 'प्रकाशित';
	@override String get statusPublishedHint => 'पूरा समुदाय देख सकता है';
	@override String get statusCancelled => 'रद्द';
	@override String get statusCancelledHint => 'रद्द के रूप में दिखेगा, रजिस्ट्रेशन नहीं होगा';
	@override String get saved => 'कार्यक्रम सेव हो गया।';
	@override String get menu => 'प्रबंधन';
	@override String get program => 'समय-सारणी';
	@override String get registrants => 'रजिस्टर्ड लोग';
	@override String get post => 'ख़बर प्रकाशित करो';
	@override String get photos => 'फ़ोटो जोड़ो';
	@override String get nextEdition => 'अगला संस्करण तैयार करो';
	@override String get delete => 'कार्यक्रम हटाओ';
	@override String get deleteTitle => 'यह कार्यक्रम हटाना है?';
	@override String get deleteText => 'इसके रजिस्ट्रेशन, ख़बरें और फ़ोटो भी हटा दिए जाएँगे।';
	@override String get deleteConfirm => 'हटाओ';
	@override String get deleted => 'कार्यक्रम हटा दिया गया।';
	@override String get nextEditionTitle => 'अगला संस्करण तैयार करना है?';
	@override String get nextEditionText => 'एक साल बाद का एक ड्राफ़्ट बनाया जाएगा, उसी स्थान और उसी समय-सारणी के साथ। प्रकाशित करने से पहले सब कुछ बदला जा सकता है।';
	@override String get nextEditionConfirm => 'तैयार करो';
	@override String get nextEditionDone => 'अगला संस्करण ड्राफ़्ट के रूप में तैयार है।';
	@override String get programEmpty => 'कार्यक्रम के सत्र जोड़ो: स्वागत, आराधना सभाएँ, शिक्षाएँ, रात्रि प्रार्थना…';
	@override String get addSession => 'सत्र जोड़ो';
	@override String get editSession => 'यह सत्र बदलो';
	@override String get sessionTitle => 'शीर्षक';
	@override String get sessionTitleHint => 'जैसे: उद्घाटन आराधना';
	@override String get speaker => 'वक्ता';
	@override String get place => 'हॉल';
	@override String get day => 'दिन';
	@override String get from => 'से';
	@override String get to => 'तक';
	@override String get hymns => 'भजन';
	@override String get hymnsHint => 'नंबर, जैसे: 12, 45';
	@override String get removeSession => 'हटाओ';
	@override String get saveProgram => 'समय-सारणी सेव करो';
	@override String get programSaved => 'समय-सारणी सेव हो गई।';
	@override String get registrantsEmpty => 'अभी तक किसी ने रजिस्टर नहीं किया है।';
	@override String get totalRegistrations => 'रजिस्ट्रेशन';
	@override String get totalPeople => 'लोग';
	@override String get totalLodging => 'आवास चाहिए';
	@override String get byCity => 'रवाना होने के शहर के अनुसार';
	@override String get list => 'सूची';
	@override String get exportCsv => 'सूची एक्सपोर्ट करो (CSV)';
	@override String get csvHeader => 'नाम,यूज़रनेम,फ़ोन,चर्च,सभा,लोग,आवास,रवाना होने का शहर,रजिस्ट्रेशन की तारीख़';
	@override String get yes => 'हाँ';
	@override String get no => 'नहीं';
	@override String get postBody => 'संदेश';
	@override String get postBodyHint => 'जैसे: रजिस्ट्रेशन शुरू हो गया है!';
	@override String get postImage => 'तस्वीर जोड़ो';
	@override String get postPinned => 'सबसे ऊपर पिन करो';
	@override String get postSend => 'प्रकाशित करो';
	@override String get postDone => 'ख़बर प्रकाशित हो गई।';
	@override String get postDelete => 'यह ख़बर हटाओ';
	@override String get postDeleted => 'ख़बर हटा दी गई।';
	@override String photosAdded({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hi'))(n,
		one: '${n} फ़ोटो जोड़ी गई।',
		other: '${n} फ़ोटो जोड़ी गईं।',
	);
	@override String photosSending({required Object done, required Object total}) => 'फ़ोटो भेजी जा रही हैं (${done}/${total})…';
	@override String get photoDelete => 'यह फ़ोटो हटाओ';
	@override String get photoDeleted => 'फ़ोटो हटा दी गई।';
	@override String get confirmDelete => 'हटाओ';
}

// Path: ministry.goals
class _Translations$ministry$goals$hi extends Translations$ministry$goals$fr {
	_Translations$ministry$goals$hi._(TranslationsHi root) : this._root = root, super.internal(root);

	final TranslationsHi _root; // ignore: unused_field

	// Translations
	@override late final _Translations$ministry$goals$crusade$hi crusade = _Translations$ministry$goals$crusade$hi._(_root);
	@override late final _Translations$ministry$goals$disciples$hi disciples = _Translations$ministry$goals$disciples$hi._(_root);
	@override late final _Translations$ministry$goals$revival$hi revival = _Translations$ministry$goals$revival$hi._(_root);
}

// Path: prayer.hero
class _Translations$prayer$hero$hi extends Translations$prayer$hero$fr {
	_Translations$prayer$hero$hi._(TranslationsHi root) : this._root = root, super.internal(root);

	final TranslationsHi _root; // ignore: unused_field

	// Translations
	@override String now({required Object retreat}) => '${retreat} · अभी';
	@override String get title => '15 मिनट\nप्रभु के साथ';
	@override Map<String, String> get preview => {
		'morning': 'धन्यवाद दो, अपना दिन, अपना काम, अपना परिवार समर्पित करो…',
		'noon': 'तुम्हारी सभा, तुम्हारे अगुवे, तुम्हारी सूची के 5 लोग, राष्ट्र…',
		'evening': 'तुम्हारा प्रार्थना-जीवन, तुम्हारी सेवकाई, तुम्हारे सहकर्मी…',
		'night': 'बीमार लोग, राष्ट्रों में सुसमाचार, रात की सुरक्षा…',
	};
	@override String get meta => '15 बिंदु · हर एक 1 मिनट';
	@override String get start => 'शुरू करो';
	@override String get allDone => 'आज के चारों प्रार्थना-समय पूरे हो गए। परमेश्वर उत्तर दे!';
	@override String doneNow({required Object retreat, required Object next}) => '${retreat} पूरा हुआ। अगला: ${next}';
}

// Path: prayer.today
class _Translations$prayer$today$hi extends Translations$prayer$today$fr {
	_Translations$prayer$today$hi._(TranslationsHi root) : this._root = root, super.internal(root);

	final TranslationsHi _root; // ignore: unused_field

	// Translations
	@override String get toPray => 'प्रार्थना बाकी';
	@override String week({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hi'))(n,
		zero: 'इस हफ़्ते कोई प्रार्थना-समय नहीं',
		one: 'इस हफ़्ते ${n} प्रार्थना-समय',
		other: 'इस हफ़्ते ${n} प्रार्थना-समय',
	);
}

// Path: prayer.routine
class _Translations$prayer$routine$hi extends Translations$prayer$routine$fr {
	_Translations$prayer$routine$hi._(TranslationsHi root) : this._root = root, super.internal(root);

	final TranslationsHi _root; // ignore: unused_field

	// Translations
	@override String get title => 'आज की तुम्हारी दिनचर्या';
	@override String count({required Object done}) => '4 में से ${done}';
	@override String days({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hi'))(n,
		one: '7 में से ${n} दिन',
		other: '7 में से ${n} दिन',
	);
	@override String week({required Object time}) => 'इस सप्ताह ${time}';
	@override String get done => 'हो गई · 15 मिनट';
	@override String get now => 'अभी · 15 मिनट';
	@override String get next => 'अगली · 15 मिनट';
	@override String reminder({required Object time}) => '${time} पर याद दिलाना';
	@override Map<String, String> get later => {
		'morning': 'सुबह · 15 मिनट',
		'noon': 'दोपहर · 15 मिनट',
		'evening': 'शाम · 15 मिनट',
		'night': 'रात · 15 मिनट',
	};
}

// Path: prayer.reminders
class _Translations$prayer$reminders$hi extends Translations$prayer$reminders$fr {
	_Translations$prayer$reminders$hi._(TranslationsHi root) : this._root = root, super.internal(root);

	final TranslationsHi _root; // ignore: unused_field

	// Translations
	@override String get title => 'प्रार्थना-समय के रिमाइंडर';
	@override String get intro => 'हर प्रार्थना-समय पर एक रिमाइंडर, सिर्फ़ तब जब वह अभी पूरा न हुआ हो।';
	@override String get off => 'बंद';
	@override String get channel => 'प्रार्थना-समय';
	@override String get body => 'प्रभु के साथ 15 मिनट।';
}

// Path: prayer.retreat
class _Translations$prayer$retreat$hi extends Translations$prayer$retreat$fr {
	_Translations$prayer$retreat$hi._(TranslationsHi root) : this._root = root, super.internal(root);

	final TranslationsHi _root; // ignore: unused_field

	// Translations
	@override String get title => '15 मिनट के प्रार्थना-समय';
	@override Map<String, String> get hours => {
		'morning': 'जागते ही',
		'noon': 'दोपहर 12 से 2 बजे के बीच',
		'evening': 'दोपहर ढलने पर',
		'night': 'सोने से पहले',
	};
	@override String reminderAt({required Object time}) => 'रिमाइंडर ${time} पर';
	@override String get intro => '15 बिंदु, हर एक के लिए एक मिनट। एक हल्की आवाज़ तुम्हें अगले बिंदु पर ले जाती है।';
	@override String get done => 'आज पूरा हुआ';
	@override String get start => 'शुरू करो · 15 मिनट';
	@override String get selfPaced => 'अपनी रफ़्तार से पढ़ो, बिना टाइमर के';
	@override late final _Translations$prayer$retreat$hints$hi hints = _Translations$prayer$retreat$hints$hi._(_root);
}

// Path: prayer.session
class _Translations$prayer$session$hi extends Translations$prayer$session$fr {
	_Translations$prayer$session$hi._(TranslationsHi root) : this._root = root, super.internal(root);

	final TranslationsHi _root; // ignore: unused_field

	// Translations
	@override String point({required Object n}) => '15 में से बिंदु ${n}';
	@override String get remaining => 'बाकी';
	@override String get paused => 'रुका हुआ';
	@override String inYourList({required Object list}) => 'तुम्हारी सूची में · ${list}';
	@override String get tomorrow => 'कल, अगले लोग।';
	@override String get footer => 'स्क्रीन चालू · हर मिनट एक हल्की आवाज़';
	@override String get previous => 'पिछला बिंदु';
	@override String get next => 'अगला बिंदु';
	@override String get pause => 'रोको';
	@override String get resume => 'फिर शुरू करो';
	@override String get soundOn => 'आवाज़ चालू';
	@override String get soundOff => 'आवाज़ बंद';
	@override String get finish => 'प्रार्थना-समय पूरा करो';
	@override String get quitTitle => 'प्रार्थना-समय रोकना है?';
	@override String get quitText => 'यह तुम्हारे दिन में नहीं गिना जाएगा।';
	@override String get quit => 'रोको';
	@override String get keepPraying => 'प्रार्थना जारी रखो';
}

// Path: prayer.done
class _Translations$prayer$done$hi extends Translations$prayer$done$fr {
	_Translations$prayer$done$hi._(TranslationsHi root) : this._root = root, super.internal(root);

	final TranslationsHi _root; // ignore: unused_field

	// Translations
	@override String title({required Object retreat}) => '${retreat} पूरा हुआ';
	@override String get text => 'प्रभु के साथ 15 मिनट।\nउसने तुम्हारी हर प्रार्थना सुनी है।';
	@override String get report => 'तुम्हारी रिपोर्ट में जोड़ दिया गया';
	@override String reportDetail({required Object added, required Object total}) => 'व्यक्तिगत प्रार्थना: +${added} मिनट · आज ${total} मिनट';
	@override String get undo => 'वापस लो';
	@override String get undone => 'प्रार्थना-समय तुम्हारे दिन से हटा दिया गया।';
	@override String get today => 'आज';
	@override String count({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hi'))(n,
		one: '4 में से ${n} प्रार्थना-समय',
		other: '4 में से ${n} प्रार्थना-समय',
	);
	@override String get verse => '“निरन्तर प्रार्थना में लगे रहो।”';
	@override String get reference => '1 थिस्सलुनीकियों 5:17';
	@override String get finish => 'पूरा करो';
	@override String get hymn => 'एक भजन गाओ';
}

// Path: prayer.topics
class _Translations$prayer$topics$hi extends Translations$prayer$topics$fr {
	_Translations$prayer$topics$hi._(TranslationsHi root) : this._root = root, super.internal(root);

	final TranslationsHi _root; // ignore: unused_field

	// Translations
	@override String get title => 'समुदाय के प्रार्थना विषय';
	@override String get all => 'सब देखो';
	@override String get empty => 'अभी कोई प्रार्थना विषय नहीं है। अगुवे अगले विषय यहीं प्रकाशित करेंगे।';
	@override Map<String, String> get categories => {
		'church': 'चर्च',
		'nations': 'राष्ट्र',
		'sick': 'बीमार',
		'event': 'कार्यक्रम',
		'fasting': 'उपवास',
		'other': 'विषय',
	};
	@override String until({required Object date}) => '${date} तक';
	@override String get archive => 'पिछले विषय';
	@override String get archiveEmpty => 'कोई पिछला विषय नहीं।';
	@override String get current => 'इस समय';
	@override String documentSize({required Object kb}) => '${kb} KB';
	@override String get download => 'PDF डाउनलोड करो';
	@override String get noDocument => 'PDF नहीं है';
	@override String get openDocument => 'PDF खोलो';
}

// Path: prayer.lists
class _Translations$prayer$lists$hi extends Translations$prayer$lists$fr {
	_Translations$prayer$lists$hi._(TranslationsHi root) : this._root = root, super.internal(root);

	final TranslationsHi _root; // ignore: unused_field

	// Translations
	@override String get title => 'मेरी प्रार्थना सूचियाँ';
	@override String get private => 'सिर्फ़ तुम्हारे लिए';
	@override Map<String, String> get names => {
		'unbelievers': 'अब तक विश्वास नहीं किया',
		'believers': 'विश्वासी',
		'backsliders': 'पीछे हटे हुए विश्वासी',
		'coworkers': 'सहकर्मी',
	};
	@override Map<String, String> get uses => {
		'unbelievers': 'दोपहर के प्रार्थना-समय में हर दिन इस सूची के 10 लोगों (5 + 5) के लिए बारी-बारी से प्रार्थना होती है।',
		'believers': 'दोपहर के प्रार्थना-समय में हर दिन इस सूची के 5 लोगों के लिए बारी-बारी से प्रार्थना होती है।',
		'backsliders': 'दोपहर के प्रार्थना-समय में हर दिन इस सूची के 5 लोगों के लिए बारी-बारी से प्रार्थना होती है।',
		'coworkers': 'शाम के प्रार्थना-समय में हर दिन तुम्हारे 10 सहकर्मियों (5 + 5) के लिए बारी-बारी से प्रार्थना होती है।',
	};
	@override String get privateNote => 'इसे सिर्फ़ तुम देख सकते हो।';
	@override String count({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hi'))(n,
		zero: 'कोई नहीं',
		one: '${n} व्यक्ति',
		other: '${n} लोग',
	);
	@override String get empty => 'अभी तक कोई नहीं। उन लोगों को जोड़ो जिनके लिए तुम प्रार्थना करते हो।';
	@override String get add => 'व्यक्ति जोड़ो';
	@override String get prayedToday => 'आज';
	@override String get next => 'जल्द ही';
	@override Map<String, String> get answeredTitle => {
		'unbelievers': 'प्रभु पर विश्वास किया',
		'believers': 'उत्तर मिली प्रार्थनाएँ',
		'backsliders': 'प्रभु के पास लौट आए',
		'coworkers': 'उत्तर मिली प्रार्थनाएँ',
	};
	@override late final _Translations$prayer$lists$answeredOn$hi answeredOn = _Translations$prayer$lists$answeredOn$hi._(_root);
	@override Map<String, String> get markAnswered => {
		'unbelievers': 'प्रभु पर विश्वास किया!',
		'believers': 'प्रार्थना का उत्तर मिला',
		'backsliders': 'प्रभु के पास लौट आए!',
		'coworkers': 'प्रार्थना का उत्तर मिला',
	};
	@override String get answeredToast => 'परमेश्वर की महिमा हो!';
	@override String get putBack => 'वापस सूची में डालो';
	@override String answeredBanner({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hi'))(n,
		one: 'इस महीने ${n} प्रार्थना का उत्तर मिला',
		other: 'इस महीने ${n} प्रार्थनाओं का उत्तर मिला',
	);
	@override String lastAnswered({required Object name, required Object what}) => '${name}: ${what}';
	@override late final _Translations$prayer$lists$sheet$hi sheet = _Translations$prayer$lists$sheet$hi._(_root);
	@override String get addShort => 'जोड़ो';
}

// Path: prayer.importunity
class _Translations$prayer$importunity$hi extends Translations$prayer$importunity$fr {
	_Translations$prayer$importunity$hi._(TranslationsHi root) : this._root = root, super.internal(root);

	final TranslationsHi _root; // ignore: unused_field

	// Translations
	@override String get title => 'लगातार प्रार्थना के विषय';
	@override String get newTopic => 'नया विषय';
	@override String get intro => 'एक विषय जिसे बिना थके प्रभु के सामने रखा जाता है, जब तक उत्तर न मिल जाए। घोषणाओं की एक संख्या तय करो और अपने भाई-बहनों को अपने साथ प्रार्थना करने का न्योता दो।';
	@override String invitedBy({required Object name}) => '${name} ने तुम्हें प्रार्थना का न्योता दिया है';
	@override String get join => 'मैं भी प्रार्थना में शामिल हूँ';
	@override String get decline => 'अभी नहीं';
	@override String get joined => 'अब तुम इस विषय की प्रार्थना में शामिल हो।';
	@override String progress({required Object goal, required Object total}) => '${goal} में से ${total}';
	@override String total({required num n, required Object count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hi'))(n,
		one: '${count} घोषणा',
		other: '${count} घोषणाएँ',
	);
	@override String get reached => 'लक्ष्य पूरा हुआ!';
	@override String get closed => 'बंद';
	@override String participants({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hi'))(n,
		one: '${n} व्यक्ति प्रार्थना में शामिल',
		other: '${n} लोग प्रार्थना में शामिल',
	);
	@override String mine({required Object n}) => 'तुम: ${n}';
	@override String get tapHint => 'हर घोषणा पर टैप करो';
	@override String get addMany => 'संख्या जोड़ो';
	@override String get addManyTitle => 'कितनी घोषणाएँ?';
	@override String get addManyLabel => 'घोषणाएँ';
	@override String get add => 'जोड़ो';
	@override String pending({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hi'))(n,
		one: '${n} घोषणा भेजी जानी बाकी है',
		other: '${n} घोषणाएँ भेजी जानी बाकी हैं',
	);
	@override String get invite => 'न्योता दो';
	@override String get members => 'प्रार्थना करने वाले';
	@override String waiting({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hi'))(n,
		one: '${n} न्योता जवाब के इंतज़ार में',
		other: '${n} न्योते जवाब के इंतज़ार में',
	);
	@override String get edit => 'बदलो';
	@override String get close => 'विषय बंद करो';
	@override String get reopen => 'विषय फिर से खोलो';
	@override String get delete => 'विषय हटाओ';
	@override String get deleteTitle => 'यह विषय हटाना है?';
	@override String get deleteText => 'यह उन सबके लिए हट जाएगा जो तुम्हारे साथ प्रार्थना करते हैं।';
	@override String get leave => 'यह विषय छोड़ो';
	@override String get leaveTitle => 'यह विषय छोड़ना है?';
	@override String get leaveText => 'तुम्हारी घोषणाएँ कुल संख्या में बनी रहेंगी।';
	@override late final _Translations$prayer$importunity$form$hi form = _Translations$prayer$importunity$form$hi._(_root);
	@override late final _Translations$prayer$importunity$inviteSheet$hi inviteSheet = _Translations$prayer$importunity$inviteSheet$hi._(_root);
	@override String get eyebrow => 'लगातार प्रार्थना का विषय';
	@override String get proclaim => 'घोषणा करो';
}

// Path: streak.lines
class _Translations$streak$lines$hi extends Translations$streak$lines$fr {
	_Translations$streak$lines$hi._(TranslationsHi root) : this._root = root, super.internal(root);

	final TranslationsHi _root; // ignore: unused_field

	// Translations
	@override String get week => 'पूरा एक हफ़्ता प्रभु के साथ, हर दिन। शाबाश, ऐसे ही चलते रहो!';
	@override String get month => 'एक महीने की वफ़ादारी! जो तुम हर दिन बोते हो, वह फल लाता है।';
	@override String get hundred => 'परमेश्वर के साथ सौ दिन! तुम्हारी लगन एक सुंदर गवाही है।';
	@override String get year => 'परमेश्वर के साथ पूरा एक साल! तुम्हारी वफ़ादारी के लिए उसकी महिमा हो।';
}

// Path: blocking.reasons
class _Translations$blocking$reasons$hi extends Translations$blocking$reasons$fr {
	_Translations$blocking$reasons$hi._(TranslationsHi root) : this._root = root, super.internal(root);

	final TranslationsHi _root; // ignore: unused_field

	// Translations
	@override String get spam => 'अनचाहा';
	@override String get offensive => 'चौंकाने वाली या आपत्तिजनक सामग्री';
	@override String get other => 'अन्य';
}

// Path: bible.colors
class _Translations$bible$colors$hi extends Translations$bible$colors$fr {
	_Translations$bible$colors$hi._(TranslationsHi root) : this._root = root, super.internal(root);

	final TranslationsHi _root; // ignore: unused_field

	// Translations
	@override String get yellow => 'पीले';
	@override String get green => 'हरे';
	@override String get blue => 'नीले';
	@override String get pink => 'गुलाबी';
}

// Path: reports.units.chapters
class _Translations$reports$units$chapters$hi extends Translations$reports$units$chapters$fr {
	_Translations$reports$units$chapters$hi._(TranslationsHi root) : this._root = root, super.internal(root);

	final TranslationsHi _root; // ignore: unused_field

	// Translations
	@override String get name => 'अध्यायों की संख्या';
	@override String get label => 'अध्याय';
	@override String get symbol => 'अध्याय';
	@override String count({required num n, required Object value}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hi'))(n,
		one: '${value} अध्याय',
		other: '${value} अध्याय',
	);
}

// Path: reports.units.times
class _Translations$reports$units$times$hi extends Translations$reports$units$times$fr {
	_Translations$reports$units$times$hi._(TranslationsHi root) : this._root = root, super.internal(root);

	final TranslationsHi _root; // ignore: unused_field

	// Translations
	@override String get name => 'कितनी बार';
	@override String get label => 'बार';
	@override String get symbol => 'बार';
	@override String count({required num n, required Object value}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hi'))(n,
		one: '${value} बार',
		other: '${value} बार',
	);
}

// Path: reports.units.pages
class _Translations$reports$units$pages$hi extends Translations$reports$units$pages$fr {
	_Translations$reports$units$pages$hi._(TranslationsHi root) : this._root = root, super.internal(root);

	final TranslationsHi _root; // ignore: unused_field

	// Translations
	@override String get name => 'पृष्ठों की संख्या';
	@override String get label => 'पृष्ठ';
	@override String get symbol => 'पृष्ठ';
	@override String count({required num n, required Object value}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hi'))(n,
		one: '${value} पृष्ठ',
		other: '${value} पृष्ठ',
	);
}

// Path: reports.units.percent
class _Translations$reports$units$percent$hi extends Translations$reports$units$percent$fr {
	_Translations$reports$units$percent$hi._(TranslationsHi root) : this._root = root, super.internal(root);

	final TranslationsHi _root; // ignore: unused_field

	// Translations
	@override String get name => 'प्रतिशत';
	@override String get label => 'प्रतिशत';
	@override String get symbol => '%';
	@override String count({required Object value}) => '${value}%';
}

// Path: ministry.goals.crusade
class _Translations$ministry$goals$crusade$hi extends Translations$ministry$goals$crusade$fr {
	_Translations$ministry$goals$crusade$hi._(TranslationsHi root) : this._root = root, super.internal(root);

	final TranslationsHi _root; // ignore: unused_field

	// Translations
	@override String get title => 'हर प्राणी तक सुसमाचार अभियान';
	@override String get text => 'हमारी पीढ़ी में जीने वाले हर व्यक्ति को सुसमाचार सुनाना, ताकि पवित्र आत्मा की सामर्थ्य में प्रचारित सुसमाचार 10 अरब लोगों तक पहुँचे — संचार के हर साधन (हमारी पुस्तकें, पर्चे, पत्रिकाएँ, सीडी, डीवीडी, रेडियो, टेलीविज़न और इंटरनेट) का उपयोग करते हुए, जितनी जल्दी हो सके।';
	@override String get reached => 'लोगों तक सुसमाचार';
}

// Path: ministry.goals.disciples
class _Translations$ministry$goals$disciples$hi extends Translations$ministry$goals$disciples$fr {
	_Translations$ministry$goals$disciples$hi._(TranslationsHi root) : this._root = root, super.internal(root);

	final TranslationsHi _root; // ignore: unused_field

	// Translations
	@override String get title => 'चेले बनाना';
	@override String get text => '250 राष्ट्रों में 1 अरब लोगों को यीशु मसीह को प्रभु और उद्धारकर्ता के रूप में जानने तक ले जाना, उन्हें चेले बनाना ताकि वे हर बात में उसकी आज्ञा मानें, और उन्हें वर्ष 2065 तक 2.5 करोड़ घरेलू कलीसियाओं में इकट्ठा होने के लिए संगठित करना।';
	@override String get people => 'चेले';
	@override String get nations => 'राष्ट्र';
	@override String get churches => 'घरेलू कलीसियाएँ';
	@override String by({required Object year}) => '${year} तक';
}

// Path: ministry.goals.revival
class _Translations$ministry$goals$revival$hi extends Translations$ministry$goals$revival$fr {
	_Translations$ministry$goals$revival$hi._(TranslationsHi root) : this._root = root, super.internal(root);

	final TranslationsHi _root; // ignore: unused_field

	// Translations
	@override String get title => 'विश्वव्यापी जागृति को शीघ्र लाना';
	@override String get text => 'उपवास और मध्यस्थ प्रार्थना के द्वारा परमेश्वर के साथ सहयोग करना, उस विश्वव्यापी जागृति के लिए जो आकाश को फाड़ देगी, पृथ्वी को हिला देगी और हमारी पीढ़ी में मसीह की महिमा करेगी, ताकि हमारे प्रभु यीशु मसीह का स्वर्ग से शीघ्र आगमन हो और वह अपनी तैयार की गई दुल्हन से मिले।';
	@override String get fasting => 'उपवास';
	@override String get intercession => 'मध्यस्थ प्रार्थना';
	@override String get pray => 'अभी प्रार्थना करो';
}

// Path: prayer.retreat.hints
class _Translations$prayer$retreat$hints$hi extends Translations$prayer$retreat$hints$fr {
	_Translations$prayer$retreat$hints$hi._(TranslationsHi root) : this._root = root, super.internal(root);

	final TranslationsHi _root; // ignore: unused_field

	// Translations
	@override String assembly({required Object name}) => 'तुम्हारी सभा: ${name}';
	@override String get assemblyMissing => 'अपनी प्रोफ़ाइल में अपनी सभा जोड़ो';
	@override String authorities({required Object names}) => 'तुम्हारे अगुवे: ${names}';
	@override String get authoritiesMissing => '‘और’ में अपने आत्मिक अगुवे जोड़ो';
	@override String list({required Object list}) => 'मेरी सूचियाँ · ${list}';
	@override String listEmpty({required Object list}) => 'तुम्हारी “${list}” सूची ख़ाली है: नाम जोड़ो';
	@override String nation({required Object name}) => 'आज: ${name}';
	@override String myCountry({required Object name}) => 'तुम्हारा देश: ${name}';
	@override String get hymn => 'भजन खोलो';
}

// Path: prayer.lists.answeredOn
class _Translations$prayer$lists$answeredOn$hi extends Translations$prayer$lists$answeredOn$fr {
	_Translations$prayer$lists$answeredOn$hi._(TranslationsHi root) : this._root = root, super.internal(root);

	final TranslationsHi _root; // ignore: unused_field

	// Translations
	@override String unbelievers({required Object date}) => '${date} को प्रभु पर विश्वास किया';
	@override String believers({required Object date}) => '${date} को उत्तर मिला';
	@override String backsliders({required Object date}) => '${date} को प्रभु के पास लौट आए';
	@override String coworkers({required Object date}) => '${date} को उत्तर मिला';
}

// Path: prayer.lists.sheet
class _Translations$prayer$lists$sheet$hi extends Translations$prayer$lists$sheet$fr {
	_Translations$prayer$lists$sheet$hi._(TranslationsHi root) : this._root = root, super.internal(root);

	final TranslationsHi _root; // ignore: unused_field

	// Translations
	@override String get addTitle => 'व्यक्ति जोड़ो';
	@override String get editTitle => 'बदलो';
	@override String get name => 'नाम';
	@override String get namePlaceholder => 'राहुल एम.';
	@override String get note => 'नोट';
	@override String get notePlaceholder => 'दफ़्तर का साथी, पड़ोसी, चचेरी बहन…';
	@override String get list => 'सूची';
	@override String get save => 'सेव करो';
	@override String get remove => 'सूची से हटाओ';
	@override String removeTitle({required Object name}) => '${name} को हटाना है?';
	@override String get removeText => 'अब तुम्हारे प्रार्थना-समय में इस व्यक्ति के लिए प्रार्थना नहीं होगी।';
}

// Path: prayer.importunity.form
class _Translations$prayer$importunity$form$hi extends Translations$prayer$importunity$form$fr {
	_Translations$prayer$importunity$form$hi._(TranslationsHi root) : this._root = root, super.internal(root);

	final TranslationsHi _root; // ignore: unused_field

	// Translations
	@override String get newTitle => 'लगातार प्रार्थना का नया विषय';
	@override String get editTitle => 'विषय बदलो';
	@override String get subject => 'विषय';
	@override String get subjectPlaceholder => 'हे प्रभु, राहुल का उद्धार कर';
	@override String get description => 'विवरण';
	@override String get descriptionPlaceholder => 'किसके लिए, क्यों…';
	@override String get goal => 'लक्ष्य';
	@override String get goalHint => 'घोषणाओं की वह संख्या जिस तक सबको मिलकर पहुँचना है। बिना लक्ष्य के गिनने के लिए ख़ाली छोड़ दो।';
	@override String get goalPlaceholder => '10,000';
	@override String get create => 'बनाओ';
	@override String get save => 'सेव करो';
}

// Path: prayer.importunity.inviteSheet
class _Translations$prayer$importunity$inviteSheet$hi extends Translations$prayer$importunity$inviteSheet$fr {
	_Translations$prayer$importunity$inviteSheet$hi._(TranslationsHi root) : this._root = root, super.internal(root);

	final TranslationsHi _root; // ignore: unused_field

	// Translations
	@override String get title => 'प्रार्थना का न्योता दो';
	@override String get family => 'मेरा आत्मिक परिवार';
	@override String familyText({required num n, required Object name}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hi'))(n,
		one: '${name} और उनके चेले: ${n} व्यक्ति',
		other: '${name} और उनके चेले: ${n} लोग',
	);
	@override String get familyMissing => 'अपने आत्मिक परिवार को न्योता देने के लिए ‘मेरे आत्मिक अगुवे’ में अपने चेला बनाने वाले को जोड़ो।';
	@override String get byUsername => 'यूज़रनेम से';
	@override String get usernameLabel => 'यूज़रनेम';
	@override String get addUsername => 'जोड़ो';
	@override String get send => 'न्योते भेजो';
	@override String sent({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hi'))(n,
		zero: 'उन्हें पहले ही न्योता दिया जा चुका था।',
		one: '${n} न्योता भेजा गया',
		other: '${n} न्योते भेजे गए',
	);
}

/// The flat map containing all translations for locale <hi>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsHi {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'app.name' => 'CMFI Connect',
			'app.tagline' => 'साथ मिलकर बढ़ना, हर दिन।',
			'app.languageName' => 'हिन्दी',
			'common.retry' => 'फिर से कोशिश करो',
			'common.cancel' => 'रद्द करो',
			'common.save' => 'सेव करो',
			'common.close' => 'बंद करो',
			'common.back' => 'वापस',
			'common.soon' => 'जल्द ही',
			'common.optional' => '(वैकल्पिक)',
			'common.and' => 'और',
			'common.loading' => 'लोड हो रहा है…',
			'common.done' => 'हो गया',
			'common.rangeStart' => 'कब से',
			'common.rangeEnd' => 'कब तक',
			'errors.network' => 'इंटरनेट कनेक्शन नहीं है। अपना नेटवर्क जाँचो और फिर से कोशिश करो।',
			'errors.unauthorized' => 'तुम्हारा सेशन ख़त्म हो गया है। फिर से लॉग इन करो।',
			'errors.invalidCredentials' => 'फ़ोन नंबर या पासवर्ड ग़लत है।',
			'errors.badRequest' => 'कुछ जानकारी सही नहीं है।',
			'errors.conflict' => 'यह पहले से मौजूद है।',
			'errors.notFound' => 'यह नहीं मिला।',
			'errors.server' => 'सर्वर में कोई समस्या आ गई। थोड़ी देर में फिर से कोशिश करो।',
			'errors.unknown' => 'कुछ गड़बड़ हो गई। फिर से कोशिश करो।',
			'errors.forbidden' => 'तुम्हें यह करने की अनुमति नहीं है।',
			'errors.eventFull' => 'इस कार्यक्रम में अब कोई जगह नहीं बची है।',
			'errors.registrationClosed' => 'इस कार्यक्रम का रजिस्ट्रेशन बंद हो गया है।',
			'errors.mediaTooLarge' => 'यह तस्वीर बहुत बड़ी है (अधिकतम 8 MB)।',
			'errors.mediaUnsupported' => 'JPEG या PNG तस्वीर चुनो।',
			'errors.notParticipant' => 'अपनी घोषणाएँ गिनने के लिए पहले इस विषय से जुड़ो।',
			'errors.importunityClosed' => 'यह विषय बंद हो गया है: अब इसमें घोषणाएँ नहीं गिनी जातीं।',
			'errors.usernameNotFound' => 'किसी का यह यूज़रनेम नहीं है। स्पेलिंग जाँचो।',
			'errors.ownerCannotLeave' => 'यह विषय तुमने बनाया है: इसे छोड़ने के बजाय हटा दो।',
			'errors.tooManyPeople' => 'तुम्हारी सूचियाँ भर गई हैं (अधिकतम 500 लोग)।',
			'errors.avatarInvalid' => 'यह फ़ोटो इस्तेमाल नहीं हो सकती। कोई दूसरी चुनें।',
			'errors.reportsNotShared' => 'यह सदस्य अब अपनी रिपोर्ट साझा नहीं करता।',
			'validation.required' => 'यह फ़ील्ड ज़रूरी है',
			'validation.passwordTooShort' => 'कम से कम 6 कैरेक्टर',
			'validation.invalidPhone' => 'फ़ोन नंबर सही नहीं है',
			'validation.invalidEmail' => 'ईमेल पता सही नहीं है',
			'validation.invalidCode' => 'सिर्फ़ अक्षर और अंक, बिना स्पेस के',
			'onboarding.skip' => 'छोड़ो',
			'onboarding.next' => 'आगे',
			'onboarding.start' => 'शुरू करो',
			'onboarding.step' => ({required Object total, required Object current}) => '${total} में से स्क्रीन ${current}',
			'onboarding.reports.title' => 'परमेश्वर के साथ तुम्हारा सफ़र, दिन-ब-दिन',
			'onboarding.reports.text' => 'कुछ ही सेकंड में अपना बाइबल पठन, प्रार्थना, उपवास… दर्ज करो और हफ़्ते-दर-हफ़्ते अपनी प्रगति देखो।',
			'onboarding.worship.title' => 'जहाँ भी हो, गाओ और प्रार्थना करो',
			'onboarding.worship.text' => 'समुदाय के भजन यहाँ पाओ और हर दिन अपने भाई-बहनों के साथ प्रार्थना विषयों के लिए प्रार्थना करो।',
			'onboarding.community.title' => 'अपने समुदाय से जुड़ाव बनाए रखो',
			'onboarding.community.text' => 'तुम्हारी सभा के कार्यक्रम और घोषणाएँ, एक ही जगह पर, ताकि कुछ भी न छूटे।',
			'onboarding.sample.today' => 'आज',
			'onboarding.sample.bibleReading' => 'बाइबल पठन',
			'onboarding.sample.prayerAlone' => 'व्यक्तिगत प्रार्थना',
			'onboarding.sample.meditation' => 'मनन',
			'onboarding.sample.groupPrayer' => 'समूह प्रार्थना',
			'onboarding.sample.thisWeek' => 'इस हफ़्ते',
			'onboarding.sample.weekScore' => '5 में से 4 दिन',
			'onboarding.sample.hymn' => 'भजन',
			'onboarding.sample.hymnNumber' => 'नं. 12',
			'onboarding.sample.fullScreen' => 'फ़ुल स्क्रीन',
			'onboarding.sample.prayerOfTheDay' => 'आज का प्रार्थना विषय',
			'onboarding.sample.prayerTopic' => 'हमारे युवाओं की परीक्षाओं के लिए',
			'onboarding.sample.praying' => '12 लोग प्रार्थना कर रहे हैं',
			'onboarding.sample.iPray' => 'प्रार्थना में शामिल हूँ',
			'onboarding.sample.vigil' => 'रात्रि प्रार्थना सभा',
			'onboarding.sample.vigilMeta' => 'रात 8 बजे · स्थानीय सभा',
			'onboarding.sample.join' => 'मैं शामिल हूँ',
			'onboarding.sample.retreat' => 'युवा रिट्रीट',
			'onboarding.sample.retreatMeta' => 'पूरा दिन',
			'onboarding.sample.announcement' => 'घोषणा',
			'onboarding.sample.announcementText' => 'रविवार की आराधना सुबह 8:30 बजे शुरू होगी।',
			'onboarding.sample.chapters' => '10 अध्याय',
			'welcome.title' => 'CMFI Connect में स्वागत है',
			'welcome.text' => 'एक मिनट में अपना अकाउंट बनाओ, ताकि अपनी दैनिक रिपोर्ट भर सको और अपने समुदाय की हर गतिविधि पर नज़र रख सको।',
			'welcome.createAccount' => 'अकाउंट बनाओ',
			'welcome.haveAccount' => 'मेरा अकाउंट पहले से है',
			'auth.phone' => 'फ़ोन',
			'auth.dialCode' => ({required Object code}) => 'देश कोड: ${code}',
			'auth.password' => 'पासवर्ड',
			'auth.showPassword' => 'पासवर्ड दिखाओ',
			'auth.hidePassword' => 'पासवर्ड छिपाओ',
			'auth.login.title' => 'फिर से स्वागत है',
			'auth.login.subtitle' => 'आज की रिपोर्ट भरने के लिए लॉग इन करो।',
			'auth.login.submit' => 'लॉग इन करो',
			'auth.login.noAccount' => 'अभी तक अकाउंट नहीं है?',
			'auth.login.createAccount' => 'अकाउंट बनाओ',
			'auth.register.step' => ({required Object current, required Object total}) => '${current} / ${total}',
			'auth.register.title' => 'अपना अकाउंट बनाओ',
			'auth.register.subtitle' => 'लॉग इन करने के लिए तुम्हारा फ़ोन नंबर इस्तेमाल होगा।',
			'auth.register.firstName' => 'पहला नाम',
			'auth.register.lastName' => 'सरनेम',
			'auth.register.passwordHelp' => 'कम से कम 6 कैरेक्टर',
			'auth.register.email' => 'ईमेल',
			'auth.register.submit' => 'आगे बढ़ो',
			'auth.register.haveAccount' => 'पहले से अकाउंट है?',
			'auth.register.login' => 'लॉग इन करो',
			'auth.register.alreadyUsed' => 'इस नंबर या ईमेल से पहले ही अकाउंट बना हुआ है। लॉग इन करो।',
			'auth.register.emailHint' => 'tum@example.com',
			'auth.church.title' => 'तुम्हारा चर्च',
			'auth.church.subtitle' => 'इस जानकारी से तुम्हारे अगुवे तुम्हें आसानी से ढूँढ पाएँगे। इसे बाद में बदला जा सकता है।',
			'auth.church.editTitle' => 'मेरी प्रोफ़ाइल',
			'auth.church.editSubtitle' => 'अपना नाम, चर्च और सभा अपडेट करो।',
			'auth.church.country' => 'देश',
			'auth.church.countryHint' => 'अपना देश चुनो',
			'auth.church.city' => 'शहर',
			'auth.church.cityHint' => 'नई दिल्ली',
			'auth.church.church' => 'चर्च',
			'auth.church.churchHint' => 'तुम्हारे चर्च का नाम',
			'auth.church.assembly' => 'सभा',
			'auth.church.assemblyHint' => 'तुम्हारी सभा का नाम',
			'auth.church.info' => 'शहर या सभा बदल ली है? अपनी प्रोफ़ाइल से सब कुछ अपडेट किया जा सकता है।',
			'auth.church.submit' => 'पूरा करो',
			'auth.church.skip' => 'यह चरण छोड़ो',
			'auth.church.saved' => 'प्रोफ़ाइल सेव हो गई',
			'auth.forgot.link' => 'पासवर्ड भूल गए?',
			'auth.forgot.title' => 'पासवर्ड भूल गए',
			'auth.forgot.phoneText' => 'अपना नंबर डालो: नया पासवर्ड चुनने के लिए हम SMS से एक कोड भेजेंगे।',
			'auth.forgot.sendCode' => 'कोड पाओ',
			'auth.forgot.codeTitle' => 'कोड डालो',
			'auth.forgot.codeText' => ({required Object phone}) => 'हमने ${phone} पर 6 अंकों का कोड भेजा है।',
			'auth.forgot.code' => 'SMS से मिला कोड',
			'auth.forgot.codeInvalid' => 'कोड 6 अंकों का है',
			'auth.forgot.verify' => 'जाँचो',
			'auth.forgot.resend' => 'कोड फिर से भेजो',
			'auth.forgot.resendIn' => ({required Object seconds}) => '${seconds} सेकंड में फिर भेजो',
			'auth.forgot.changeNumber' => 'नंबर बदलो',
			'auth.forgot.passwordTitle' => 'नया पासवर्ड',
			'auth.forgot.passwordText' => 'अपने खाते के लिए नया पासवर्ड चुनो।',
			'auth.forgot.submit' => 'सहेजो और साइन इन करो',
			'auth.forgot.done' => 'पासवर्ड बदल गया। फिर से स्वागत है!',
			'auth.forgot.remembered' => 'याद आ गया?',
			'auth.forgot.invalidCode' => 'यह कोड सही नहीं है।',
			'auth.forgot.expired' => 'कोड की अवधि खत्म हो गई। नया कोड माँगो।',
			'auth.forgot.tooManyRequests' => 'बहुत ज़्यादा कोशिशें। थोड़ी देर बाद फिर कोशिश करो।',
			'auth.forgot.unavailable' => 'अभी पासवर्ड रीसेट उपलब्ध नहीं है।',
			'auth.forgot.noAccount' => 'इस नंबर से कोई खाता नहीं है।',
			'countries.dialCodeTitle' => 'देश कोड',
			'countries.title' => 'तुम्हारा देश',
			'countries.search' => 'देश या कोड खोजो',
			'countries.none' => 'कोई देश नहीं मिला',
			'countries.change' => 'देश बदलो',
			'nav.home' => 'होम',
			'nav.reports' => 'रिपोर्ट',
			'nav.hymns' => 'भजन',
			'nav.prayer' => 'प्रार्थना',
			'nav.bible' => 'बाइबल',
			'home.greeting' => ({required Object name}) => 'नमस्ते ${name}',
			'home.greetingNoName' => 'नमस्ते',
			'home.profile' => 'मेरी प्रोफ़ाइल',
			'home.progress' => ({required Object total, required Object filled}) => '${total} में से ${filled}',
			'home.progressLabel' => 'आइटम भरे गए',
			'home.goals' => 'लक्ष्य',
			'home.weekTitle' => 'तुम्हारा हफ़्ता',
			'home.community' => 'अभी CMFI में',
			'home.eventsTitle' => 'कार्यक्रम',
			'home.hymnsTitle' => 'भजन',
			'home.hymnsOpen' => 'भजन संग्रह खोलो',
			'home.continueMyReport' => 'अपनी रिपोर्ट जारी रखो',
			'home.startMyReport' => 'अपनी रिपोर्ट शुरू करो',
			'home.items' => 'चीज़ें',
			'home.goalsTitle' => 'लक्ष्य',
			'home.retreatsTitle' => 'प्रार्थना-समय',
			'home.retreatsValue' => ({required Object n}) => '4 में से ${n}',
			'home.streakTitle' => 'लगातार',
			'home.resume' => 'जहाँ छोड़ा था वहीं से',
			'home.hymnNumber' => ({required Object number}) => 'भजन संख्या ${number}',
			'home.seeAll' => 'सब देखो',
			'home.retreatsDone' => 'आज के चारों प्रार्थना-समय हो गए',
			'home.days' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hi'))(n, one: '${n} दिन', other: '${n} दिन', ), 
			'reports.title' => 'दैनिक रिपोर्ट',
			'reports.myItems' => 'मेरे आइटम',
			'reports.tabs.today' => 'आज',
			'reports.tabs.history' => 'इतिहास',
			'reports.tabs.summary' => 'सारांश',
			'reports.pickDay' => 'दिन चुनो',
			'reports.filled' => ({required Object total, required Object filled}) => '${total} में से ${filled} भरे गए',
			'reports.statusSaved' => 'सेव हो गया',
			'reports.statusModified' => 'सेव नहीं हुआ',
			'reports.standard' => 'मानक',
			'reports.personal' => 'मेरे आइटम',
			'reports.createItem' => 'आइटम बनाओ',
			'reports.add' => ({required Object label}) => '${label} जोड़ो',
			'reports.note' => 'आज का नोट',
			'reports.noteHint' => 'कोई वचन, धन्यवाद की कोई बात…',
			'reports.save' => 'दिन सेव करो',
			'reports.saved' => 'दिन सेव हो गया',
			'reports.measure.quantity' => ({required Object unit}) => '${unit}',
			'reports.measure.duration' => 'अवधि',
			'reports.measure.both' => ({required Object unit}) => '${unit} और अवधि',
			'reports.measure.quantityNoUnit' => 'मात्रा',
			'reports.measure.bothNoUnit' => 'मात्रा और अवधि',
			'reports.times' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hi'))(n, one: '${n} बार', other: '${n} बार', ), 
			'reports.sheet.quantity' => 'मात्रा',
			'reports.sheet.duration' => 'अवधि',
			'reports.sheet.minus1' => '− 1 मिनट',
			'reports.sheet.plus1' => '+ 1 मिनट',
			'reports.sheet.removeMinute' => 'एक मिनट घटाओ',
			'reports.sheet.addMinute' => 'एक मिनट जोड़ो',
			'reports.sheet.holdToRepeat' => 'तेज़ी से बदलने के लिए दबाकर रखो',
			'reports.sheet.decrease' => 'घटाओ',
			'reports.sheet.increase' => 'बढ़ाओ',
			'reports.sheet.clear' => 'मिटाओ',
			'reports.sheet.validate' => 'ठीक है',
			'reports.history.daysFilled' => ({required Object total, required Object filled}) => '${total} में से ${filled} दिन भरे गए',
			'reports.history.legendFilled' => 'भरा गया',
			'reports.history.legendMissing' => 'कोई रिपोर्ट नहीं',
			'reports.history.none' => 'कोई रिपोर्ट नहीं',
			'reports.history.fill' => 'भरो',
			'reports.history.inProgress' => 'जारी है',
			'reports.history.previousMonth' => 'पिछला महीना',
			'reports.history.nextMonth' => 'अगला महीना',
			'reports.history.today' => 'आज',
			'reports.summary.week' => 'हफ़्ता',
			'reports.summary.month' => 'महीना',
			'reports.summary.year' => 'साल',
			'reports.summary.range' => ({required Object from, required Object to}) => '${from} से ${to} तक',
			'reports.summary.regularity' => 'नियमितता',
			'reports.summary.daysFilled' => 'दिन भरे गए',
			'reports.summary.missingDays' => ({required num n, required Object days}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hi'))(n, one: 'रिपोर्ट के बिना ${n} दिन: ${days} तारीख़', other: 'रिपोर्ट के बिना ${n} दिन: ${days} तारीख़', ), 
			'reports.summary.missingCount' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hi'))(n, one: 'रिपोर्ट के बिना ${n} दिन', other: 'रिपोर्ट के बिना ${n} दिन', ), 
			'reports.summary.noMissing' => 'एक भी दिन नहीं छूटा, शाबाश!',
			'reports.summary.perDay' => ({required Object value}) => 'भरे गए हर दिन पर औसतन ${value}',
			'reports.summary.days' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hi'))(n, one: '${n} दिन', other: '${n} दिन', ), 
			'reports.summary.notFilled' => 'अभी तक नहीं भरे गए',
			'reports.summary.barsCaption' => ({required Object max}) => 'प्रति दिन · सबसे ऊँचा बार: ${max}',
			'reports.summary.barsCaptionMonthly' => ({required Object max}) => 'प्रति महीना · सबसे ऊँचा बार: ${max}',
			'reports.summary.empty' => 'इस अवधि में कोई रिपोर्ट नहीं है।',
			'reports.summary.goalDays' => ({required num n, required Object total}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hi'))(n, one: '${total} में से ${n} दिन लक्ष्य पूरा हुआ', other: '${total} में से ${n} दिन लक्ष्य पूरा हुआ', ), 
			'reports.summary.share' => 'यह सारांश शेयर करो',
			'reports.summary.goals' => 'लक्ष्य',
			'reports.summary.goalsAverage' => 'तुम्हारे लक्ष्यों की औसत पूर्ति',
			'reports.summary.goalsHint' => 'हर दिन गिना जाता है, खाली भी। आज भरने के बाद गिना जाता है।',
			'reports.summary.evolution' => 'तुम्हारे लक्ष्यों की प्रगति',
			'reports.summary.evolutionHint' => 'हफ़्ते दर हफ़्ते, पिछले 12 हफ़्तों में।',
			'reports.summary.premiumYear' => 'साल और तुम्हारे लक्ष्यों की प्रगति Premium के साथ आते हैं।',
			'reports.noItems' => 'अभी भरने के लिए कोई आइटम नहीं है।',
			'reports.statusPending' => 'अभी भेजा नहीं गया',
			'reports.savedOffline' => 'नेटवर्क नहीं है: यह दिन फ़ोन में सेव है और नेटवर्क मिलते ही भेज दिया जाएगा।',
			'reports.pendingBanner' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hi'))(n, one: '${n} दिन भेजे जाने के लिए नेटवर्क का इंतज़ार कर रहा है', other: '${n} दिन भेजे जाने के लिए नेटवर्क का इंतज़ार कर रहे हैं', ), 
			'reports.export' => 'मेरी रिपोर्ट एक्सपोर्ट करो',
			'reports.goal' => ({required Object value}) => 'लक्ष्य: ${value}',
			'reports.goalReached' => 'लक्ष्य पूरा हुआ',
			'reports.dayGoals' => 'दिन के लक्ष्य',
			'reports.goalsReached' => ({required Object total, required Object reached}) => 'पूरे हुए: ${total} में से ${reached}',
			'reports.standardItems.lb' => 'बाइबल पठन',
			'reports.standardItems.ps' => 'व्यक्तिगत प्रार्थना',
			'reports.standardItems.rdqad' => 'मनन',
			'reports.standardItems.pg' => 'समूह प्रार्थना',
			'reports.standardItems.llc' => 'मसीही साहित्य पठन',
			'reports.standardItems.jc' => 'पूर्ण उपवास',
			'reports.standardItems.jp' => 'आंशिक उपवास',
			'reports.standardItems.dimes' => 'दशमांश',
			'reports.standardItems.off' => 'भेंट',
			'reports.units.chapters.name' => 'अध्यायों की संख्या',
			'reports.units.chapters.label' => 'अध्याय',
			'reports.units.chapters.symbol' => 'अध्याय',
			'reports.units.chapters.count' => ({required num n, required Object value}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hi'))(n, one: '${value} अध्याय', other: '${value} अध्याय', ), 
			'reports.units.times.name' => 'कितनी बार',
			'reports.units.times.label' => 'बार',
			'reports.units.times.symbol' => 'बार',
			'reports.units.times.count' => ({required num n, required Object value}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hi'))(n, one: '${value} बार', other: '${value} बार', ), 
			'reports.units.pages.name' => 'पृष्ठों की संख्या',
			'reports.units.pages.label' => 'पृष्ठ',
			'reports.units.pages.symbol' => 'पृष्ठ',
			'reports.units.pages.count' => ({required num n, required Object value}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hi'))(n, one: '${value} पृष्ठ', other: '${value} पृष्ठ', ), 
			'reports.units.percent.name' => 'प्रतिशत',
			'reports.units.percent.label' => 'प्रतिशत',
			'reports.units.percent.symbol' => '%',
			'reports.units.percent.count' => ({required Object value}) => '${value}%',
			'reminder.title' => 'तुम्हारी आज की रिपोर्ट',
			'reminder.body' => 'दिन ख़त्म होने से पहले एक मिनट निकालकर अपना बाइबल पठन, अपनी प्रार्थना… दर्ज करो।',
			'reminder.channel' => 'रिपोर्ट रिमाइंडर',
			'reminder.settings' => 'शाम का रिमाइंडर',
			'reminder.off' => 'बंद',
			'reminder.switchLabel' => 'मुझे अपना दिन भरने की याद दिलाओ',
			'reminder.switchHint' => 'सिर्फ़ तब, जब दिन अभी तक भरा न गया हो।',
			'reminder.time' => 'रिमाइंडर का समय',
			'reminder.offerTitle' => 'हर शाम एक रिमाइंडर?',
			'reminder.offerText' => 'अगर तुम्हारा दिन अभी तक भरा नहीं गया है, तो ऐप तुम्हारे चुने हुए समय पर तुम्हें याद दिलाएगा। अगर पहले ही भर दिया है, तो कुछ नहीं।',
			'reminder.offerAccept' => 'रिमाइंडर चालू करो',
			'reminder.offerLater' => 'बाद में',
			'reminder.enabled' => ({required Object time}) => 'रिमाइंडर ${time} पर चालू है',
			'reminder.denied' => 'CMFI Connect के नोटिफ़िकेशन बंद हैं। फ़ोन की सेटिंग में जाकर इन्हें अनुमति दो।',
			'export.title' => 'एक्सपोर्ट',
			'export.period' => 'अवधि',
			'export.thisWeek' => 'इस हफ़्ते',
			'export.lastWeek' => 'पिछले हफ़्ते',
			'export.thisMonth' => 'इस महीने',
			'export.lastMonth' => 'पिछले महीने',
			'export.thisYear' => 'इस साल',
			'export.custom' => 'दूसरी तारीख़ें',
			'export.customPick' => 'तारीख़ें चुनो',
			'export.format' => 'फ़ॉर्मेट',
			'export.pdf' => 'PDF',
			'export.pdfHint' => 'भेजने या प्रिंट करने के लिए एक दस्तावेज़',
			'export.csv' => 'स्प्रेडशीट',
			'export.csvHint' => 'Excel या Google Sheets के लिए एक CSV फ़ाइल',
			'export.text' => 'मैसेज',
			'export.textHint' => 'WhatsApp में पेस्ट करने के लिए एक सारांश',
			'export.button' => 'एक्सपोर्ट करो',
			'export.shareButton' => 'शेयर करो',
			'export.preview' => ({required num filled, required Object total, required Object items}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hi'))(filled, one: '${total} में से ${filled} दिन भरा गया · ${items}', other: '${total} में से ${filled} दिन भरे गए · ${items}', ), 
			'export.previewItems' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hi'))(n, one: '${n} आइटम', other: '${n} आइटम', ), 
			'export.empty' => 'इस अवधि में कोई रिपोर्ट नहीं है।',
			'export.tooLong' => 'अधिकतम 366 दिन चुनो।',
			'export.fileName' => 'दैनिक-रिपोर्ट',
			'export.subject' => ({required Object period}) => 'मेरी दैनिक रिपोर्ट, ${period}',
			'export.doc.title' => 'दैनिक रिपोर्ट',
			'export.doc.regularity' => 'नियमितता',
			'export.doc.daysFilled' => ({required num filled, required Object total}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hi'))(filled, one: '${total} में से ${filled} दिन भरा गया', other: '${total} में से ${filled} दिन भरे गए', ), 
			'export.doc.totals' => 'पूरी अवधि में',
			'export.doc.item' => 'आइटम',
			'export.doc.total' => 'कुल',
			'export.doc.days' => 'दिन',
			'export.doc.average' => 'औसत / भरा गया दिन',
			'export.doc.goal' => 'लक्ष्य पूरा हुआ',
			'export.doc.detail' => 'दिन-ब-दिन',
			'export.doc.date' => 'तारीख़',
			'export.doc.values' => 'भरा गया',
			'export.doc.note' => 'नोट',
			'export.doc.noReport' => 'कोई रिपोर्ट नहीं',
			'export.doc.generated' => ({required Object date}) => '${date} को CMFI Connect से बनाया गया',
			'export.doc.page' => ({required Object n, required Object total}) => 'पेज ${n} / ${total}',
			'export.doc.filledColumn' => 'रिपोर्ट',
			'export.doc.yes' => 'हाँ',
			'export.doc.no' => 'नहीं',
			'export.doc.sentFrom' => 'CMFI Connect से भेजा गया',
			'items.title' => 'मेरे आइटम',
			'items.standardSection' => 'मानक · सभी के लिए',
			'items.personalSection' => 'मेरे निजी आइटम',
			'items.emptyPersonal' => 'अभी तक तुम्हारा कोई निजी आइटम नहीं है।',
			'items.archive' => 'आर्काइव करो',
			'items.archiveTitle' => ({required Object code}) => '${code} को आर्काइव करना है?',
			'items.archiveText' => 'यह अब तुम्हारी रिपोर्ट में नहीं दिखेगा। इसके आँकड़े तुम्हारे इतिहास में बने रहेंगे।',
			'items.archived' => ({required Object code}) => '${code} आर्काइव हो गया',
			'items.create' => 'आइटम बनाओ',
			'items.footnote' => 'आर्काइव किया गया आइटम अब तुम्हारी रिपोर्ट में नहीं दिखता, लेकिन उसके आँकड़े तुम्हारे इतिहास में बने रहते हैं।',
			'items.measure.quantity' => ({required Object unit}) => 'मात्रा · ${unit}',
			'items.measure.quantityNoUnit' => 'मात्रा',
			'items.measure.duration' => 'अवधि',
			'items.measure.both' => ({required Object unit}) => 'मात्रा (${unit}) और अवधि',
			'items.measure.bothNoUnit' => 'मात्रा और अवधि',
			'items.goalAdd' => 'लक्ष्य जोड़ो',
			'items.goal' => ({required Object value}) => 'लक्ष्य: हर दिन ${value}',
			'items.goalTitle' => 'रोज़ का लक्ष्य',
			'items.goalHint' => 'हर दिन के लिए तुम्हारा लक्ष्य। यह सिर्फ़ तुम्हारे फ़ोन में रहता है।',
			'items.goalRemove' => 'हटाओ',
			'items.goalSaved' => 'लक्ष्य सेव हो गया',
			'items.goalRemoved' => 'लक्ष्य हटा दिया गया',
			'newItem.title' => 'नया आइटम',
			'newItem.code' => 'कोड',
			'newItem.label' => 'नाम',
			'newItem.help' => 'अक्षर और अंक, अधिकतम 20। किसी मानक आइटम का कोड (LB, PS…) इस्तेमाल नहीं किया जा सकता।',
			'newItem.measures' => 'क्या मापना है',
			'newItem.quantity' => 'मात्रा',
			'newItem.quantityHint' => 'अध्याय, पेज, लोग…',
			'newItem.unit' => 'संख्या के बाद दिखने वाली इकाई',
			'newItem.unitHint' => 'लोग',
			'newItem.duration' => 'अवधि',
			'newItem.durationHint' => 'घंटों और मिनटों में',
			'newItem.noMeasure' => 'कम से कम एक माप चुनो: मात्रा, अवधि या दोनों।',
			'newItem.preview' => 'तुम्हारी रिपोर्ट में ऐसा दिखेगा',
			'newItem.previewCode' => 'CODE',
			'newItem.previewLabel' => 'आइटम का नाम',
			'newItem.submit' => 'आइटम बनाओ',
			'newItem.created' => ({required Object code}) => '${code} बन गया।',
			'newItem.codeTaken' => 'यह कोड पहले से इस्तेमाल हो रहा है, किसी मानक आइटम में या तुम्हारे किसी आइटम में (आर्काइव किए गए आइटम भी)।',
			'newItem.codeHint' => 'EVG',
			'newItem.labelHint' => 'सुसमाचार प्रचार',
			'more.title' => 'और',
			'more.editProfile' => 'प्रोफ़ाइल बदलो',
			'more.community' => 'समुदाय',
			'more.events' => 'कार्यक्रम',
			'more.reports' => 'दैनिक रिपोर्ट',
			'more.myItems' => 'मेरे आइटम',
			'more.app' => 'ऐप',
			'more.language' => 'भाषा',
			'more.appearance' => 'रूप-रंग',
			'more.themeSystem' => 'अपने आप',
			'more.themeSystemHint' => '‘अपने आप’ चुनने पर ऐप तुम्हारे फ़ोन की लाइट या डार्क सेटिंग के हिसाब से चलेगा।',
			'more.themeLight' => 'लाइट',
			'more.themeDark' => 'डार्क',
			'more.logout' => 'लॉग आउट करो',
			'more.account' => 'खाता',
			'more.languageTitle' => 'ऐप की भाषा',
			'more.completeProfile' => 'अपना नाम जोड़ो',
			'more.accompaniment' => 'मार्गदर्शन',
			'more.exportReport' => 'मेरी रिपोर्ट एक्सपोर्ट करो',
			'more.logoutPendingTitle' => 'कुछ दिन अभी भेजे नहीं गए',
			'more.logoutPendingText' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hi'))(n, one: 'बिना नेटवर्क के सेव किया गया ${n} दिन अभी तक भेजा नहीं गया है। अगर अभी लॉग आउट किया, तो वह खो जाएगा।', other: 'बिना नेटवर्क के सेव किए गए ${n} दिन अभी तक भेजे नहीं गए हैं। अगर अभी लॉग आउट किया, तो वे खो जाएँगे।', ), 
			'more.logoutAnyway' => 'फिर भी लॉग आउट करो',
			'more.admin' => 'प्रबंधन',
			'more.staff' => 'टीम और भूमिकाएँ',
			'more.manageEvents' => 'कार्यक्रम',
			'more.disciples' => 'मेरे शिष्य',
			'authorities.title' => 'मेरे आत्मिक अगुवे',
			'authorities.intro' => 'वे लोग जो परमेश्वर के साथ तुम्हारे सफ़र में तुम्हारा साथ देते हैं: तुम्हारा चेला बनाने वाला और तुम्हारे दूसरे अगुवे।',
			'authorities.discipleMaker' => 'चेला बनाने वाला',
			'authorities.discipleMakerOf' => ({required Object name}) => 'चेला बनाने वाला: ${name}',
			'authorities.noDiscipleMaker' => 'अभी तक कोई चेला बनाने वाला नहीं',
			'authorities.others' => 'दूसरे अगुवे',
			'authorities.empty' => 'तुमने अभी तक किसी को नहीं जोड़ा है।',
			'authorities.add' => 'अगुवा जोड़ो',
			'authorities.remove' => 'हटाओ',
			'authorities.removeTitle' => ({required Object name}) => '${name} को हटाना है?',
			'authorities.removeText' => ({required Object name}) => '${name} को तुम्हारे आत्मिक अगुवों की सूची से हटा दिया जाएगा।',
			'authorities.removed' => ({required Object name}) => '${name} को तुम्हारे अगुवों की सूची से हटा दिया गया।',
			'authorities.count' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hi'))(n, zero: 'अभी तक कोई नहीं', one: '${n} व्यक्ति', other: '${n} लोग', ), 
			'authorities.form.title' => 'नया अगुवा',
			'authorities.form.emailHint' => 'naam@example.com',
			'authorities.form.isDiscipleMaker' => 'ये मेरे चेला बनाने वाले हैं',
			'authorities.form.isDiscipleMakerHelp' => 'जो व्यक्ति व्यक्तिगत रूप से तुम्हारा मार्गदर्शन करता है। ऐसा सिर्फ़ एक ही हो सकता है।',
			'authorities.form.discipleMakerTaken' => ({required Object name}) => 'तुम्हारे चेला बनाने वाले के रूप में ${name} पहले से दर्ज हैं। किसी और को चुनने के लिए पहले उन्हें सूची से हटाओ।',
			'authorities.form.submit' => 'जोड़ो',
			'authorities.form.added' => ({required Object name}) => '${name} अब तुम्हारे अगुवों में शामिल हैं।',
			'authorities.form.searchLabel' => 'उनका यूज़रनेम',
			'authorities.form.searchHint' => 'यूज़रनेम',
			'authorities.form.search' => 'खोजो',
			'authorities.form.searchHelp' => 'अगर वे CMFI Connect इस्तेमाल करते हैं, तो उन्हें उनके यूज़रनेम से खोजो। उन्हें तुम्हारा अनुरोध मिलेगा, और उनके स्वीकार करने के बाद उनकी संपर्क जानकारी दिखेगी।',
			'authorities.form.notFound' => ({required Object username}) => 'किसी का यूज़रनेम @${username} नहीं है।',
			'authorities.form.invite' => 'उन्हें CMFI Connect से जुड़ने का न्योता दो',
			'authorities.form.inviteText' => 'नमस्ते! परमेश्वर के साथ अपने सफ़र को दर्ज करने के लिए मेरे पास CMFI Connect ऐप है, और मेरी इच्छा है कि आप इसमें मेरा साथ दें। ऐप इंस्टॉल करें, अपना अकाउंट बनाएँ, फिर मुझे अपना यूज़रनेम भेजें ताकि मैं आपको जोड़ सकूँ।',
			'authorities.form.inviteMine' => ({required Object username}) => 'मेरा यूज़रनेम: @${username}',
			'authorities.form.manual' => 'उनके पास ऐप नहीं है? उनकी जानकारी ख़ुद भरो',
			'authorities.form.backToSearch' => 'यूज़रनेम से खोजो',
			'authorities.form.request' => 'अनुरोध भेजो',
			'authorities.form.requested' => ({required Object name}) => '${name} को अनुरोध भेज दिया गया।',
			'authorities.form.alreadyAdded' => 'यह व्यक्ति पहले से तुम्हारे अगुवों में शामिल है।',
			'authorities.form.makerExists' => 'तुम्हारे पास पहले से एक चेला बनाने वाला है।',
			'authorities.form.yourself' => 'यह तुम्हारा अपना यूज़रनेम है।',
			'authorities.form.sharingHelp' => ({required Object name}) => '${name} तुम्हारी रिपोर्ट देखेगा: भरे गए आइटम, तुम्हारी नियमितता और प्रतिशत, तुम्हारा नोट कभी नहीं। तुम इसे उसके कार्ड पर बंद कर सकते हो।',
			'authorities.statusPending' => 'इंतज़ार में',
			'authorities.statusDeclined' => 'अस्वीकार',
			'authorities.pendingHelp' => ({required Object name}) => '${name} के स्वीकार करने पर उनकी संपर्क जानकारी दिखेगी।',
			'authorities.requests' => 'मिले हुए अनुरोध',
			'authorities.requestDiscipleMaker' => 'तुमसे उनका चेला बनाने वाला बनने का अनुरोध',
			'authorities.requestAuthority' => 'तुमसे उनका मार्गदर्शन करने का अनुरोध',
			'authorities.accept' => 'स्वीकार करो',
			'authorities.decline' => 'अस्वीकार करो',
			'authorities.acceptedRequest' => ({required Object name}) => 'अब ${name} तुम्हारे मार्गदर्शन में हैं।',
			'authorities.declinedRequest' => ({required Object name}) => '${name} का अनुरोध अस्वीकार किया गया।',
			'authorities.requestsCount' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hi'))(n, one: '${n} अनुरोध देखना बाकी है', other: '${n} अनुरोध देखने बाकी हैं', ), 
			'authorities.sharing.title' => 'मेरी रिपोर्ट साझा करो',
			'authorities.sharing.help' => ({required Object name}) => '${name} तुम्हारी रिपोर्ट देखता है: भरे गए आइटम, तुम्हारी नियमितता और प्रतिशत, तुम्हारा नोट कभी नहीं।',
			'authorities.sharing.on' => ({required Object name}) => 'तुम्हारी रिपोर्ट ${name} के साथ साझा है।',
			'authorities.sharing.off' => ({required Object name}) => '${name} अब तुम्हारी रिपोर्ट नहीं देखता।',
			'members.username' => 'यूज़रनेम',
			'members.usernameHint' => 'naam.surname',
			'members.usernameHelp' => 'दूसरे सदस्य तुम्हें इसी नाम से ढूँढेंगे।',
			'members.usernameChecking' => 'जाँच हो रही है…',
			'members.usernameFree' => ({required Object username}) => '@${username} उपलब्ध है',
			'members.usernameCurrent' => 'यह तुम्हारा मौजूदा यूज़रनेम है',
			'members.usernameTaken' => 'यह यूज़रनेम पहले से लिया जा चुका है।',
			'members.usernameInvalid' => '3 से 30 कैरेक्टर: अक्षर, अंक, “.” और “_”, पर शुरुआत या अंत में कोई चिह्न नहीं।',
			'members.usernameReserved' => 'यह यूज़रनेम आरक्षित है।',
			'members.usernameSaved' => ({required Object username}) => 'यूज़रनेम सेव हो गया: @${username}',
			'members.deleteAccount.button' => 'मेरा खाता हटाओ',
			'members.deleteAccount.title' => 'मेरा खाता हटाओ',
			'members.deleteAccount.intro' => 'यह स्थायी है। तुम्हारा खाता और उससे जुड़ा सब कुछ मिटा दिया जाएगा:',
			'members.deleteAccount.itemProfile' => 'तुम्हारी प्रोफ़ाइल, फ़ोटो, यूज़रनेम और पासवर्ड',
			'members.deleteAccount.itemReports' => 'तुम्हारी सारी रिपोर्ट, आइटम और लक्ष्य',
			'members.deleteAccount.itemAuthorities' => 'तुम्हारे आत्मिक अगुवे और मिले हुए अनुरोध',
			'members.deleteAccount.itemEvents' => 'कार्यक्रमों के लिए तुम्हारे पंजीकरण',
			'members.deleteAccount.itemPrayer' => 'तुम्हारी प्रार्थना सूचियाँ, प्रार्थना-समय और लगातार प्रार्थना के विषय',
			'members.deleteAccount.kept' => 'एडमिन के रूप में प्रकाशित किए गए कार्यक्रम, ख़बरें, फ़ोटो और प्रार्थना विषय समुदाय के लिए रहेंगे, तुम्हारे नाम के बिना।',
			'members.deleteAccount.passwordHelp' => 'यह पक्का करने के लिए कि यह तुम ही हो।',
			'members.deleteAccount.confirm' => 'हमेशा के लिए हटाओ',
			'members.deleteAccount.done' => 'तुम्हारा खाता हटा दिया गया है। परमेश्वर तुम्हें आशीष दे!',
			'members.deleteAccount.wrongPassword' => 'पासवर्ड ग़लत है।',
			'members.deleteAccount.lastSuperadmin' => 'तुम अकेले सुपरएडमिन हो: खाता हटाने से पहले यह भूमिका किसी और को दो।',
			'admin.title' => 'टीम और भूमिकाएँ',
			'admin.intro' => 'एडमिन वह सब संभालते हैं जो पूरा समुदाय साझा करता है। भूमिका सिर्फ़ सुपरएडमिन ही दे या वापस ले सकते हैं।',
			'admin.roleUser' => 'सदस्य',
			'admin.roleAdmin' => 'एडमिन',
			'admin.roleSuperadmin' => 'सुपरएडमिन',
			'admin.giveRole' => 'भूमिका दो',
			'admin.you' => 'तुम',
			'admin.roleFor' => ({required Object username}) => '@${username} की भूमिका',
			'admin.roleChanged' => ({required Object username, required Object role}) => '@${username}: ${role}',
			'admin.memberUsername' => 'सदस्य का यूज़रनेम',
			'admin.empty' => 'अभी तक कोई एडमिन नहीं है।',
			'hymns.searchHint' => 'नंबर, शीर्षक या बोल',
			'hymns.openNumber' => 'नंबर पर जाओ',
			'hymns.tabs.all' => 'सभी',
			'hymns.tabs.favorites' => 'पसंदीदा',
			'hymns.tabs.recent' => 'हाल के',
			'hymns.chooseBook' => 'भजन संग्रह चुनो',
			'hymns.count' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hi'))(n, one: '${n} भजन', other: '${n} भजन', ), 
			'hymns.number' => ({required Object number}) => 'नं. ${number}',
			'hymns.emptyFavorites' => 'किसी भजन का स्टार टैप करो, वह यहाँ दिखेगा।',
			'hymns.emptyRecent' => 'हाल में खोले गए भजन यहाँ दिखेंगे।',
			'hymns.noResult' => ({required Object query}) => '“${query}” से मेल खाता कोई भजन नहीं मिला।',
			'hymns.otherBooks' => 'दूसरे भजन संग्रहों में',
			'hymns.upToDate' => 'भजन संग्रह अप-टू-डेट हैं।',
			'hymns.updated' => 'भजन संग्रह अपडेट हो गए हैं।',
			'hymns.chorus' => 'कोरस',
			'hymns.chorusNumber' => ({required Object label}) => 'कोरस ${label}',
			'hymns.verse' => ({required Object label}) => 'पद ${label}',
			'hymns.times' => ({required Object n}) => '×${n}',
			'hymns.loadFailed' => 'भजन संग्रह नहीं खुल पाए।',
			'hymns.reader.smaller' => 'टेक्स्ट छोटा करो',
			'hymns.reader.larger' => 'टेक्स्ट बड़ा करो',
			'hymns.reader.display' => 'डिस्प्ले',
			'hymns.reader.textSize' => 'टेक्स्ट का आकार',
			'hymns.reader.typeface' => 'फ़ॉन्ट',
			'hymns.reader.typefaceAuto' => 'ऑटो',
			'hymns.reader.typefaceSans' => 'आधुनिक',
			'hymns.reader.typefaceSerif' => 'क्लासिक',
			'hymns.reader.typefaceAutoHelp' => 'टेक्स्ट बड़ा होने पर क्लासिक',
			'hymns.reader.background' => 'बैकग्राउंड',
			'hymns.reader.themeAuto' => 'ऑटो',
			'hymns.reader.themeLight' => 'लाइट',
			_ => null,
		} ?? switch (path) {
			'hymns.reader.themeSepia' => 'सेपिया',
			'hymns.reader.themeDark' => 'डार्क',
			'hymns.reader.repeatChorus' => 'हर पद के बाद कोरस दोहराओ',
			'hymns.reader.keepScreenOn' => 'स्क्रीन चालू रखो',
			'hymns.reader.addFavorite' => 'पसंदीदा में जोड़ो',
			'hymns.reader.removeFavorite' => 'पसंदीदा से हटाओ',
			'hymns.reader.favoriteAdded' => 'पसंदीदा में जोड़ा गया',
			'hymns.reader.favoriteRemoved' => 'पसंदीदा से हटाया गया',
			'hymns.reader.more' => 'और विकल्प',
			'hymns.reader.copy' => 'बोल कॉपी करो',
			'hymns.reader.copied' => 'बोल कॉपी हो गए',
			'hymns.reader.project' => 'प्रोजेक्शन मोड',
			'hymns.reader.pinchHint' => 'टेक्स्ट बड़ा या छोटा करने के लिए स्क्रीन पर दो उँगलियों से पिंच करो।',
			'hymns.reader.notFound' => 'यह भजन अब इस संग्रह में नहीं है।',
			'hymns.reader.share' => 'बोल शेयर करो',
			'hymns.projection.exit' => 'प्रोजेक्शन मोड से बाहर निकलो',
			'hymns.projection.previous' => 'पिछला पद',
			'hymns.projection.next' => 'अगला पद',
			'hymns.projection.position' => ({required Object current, required Object total}) => '${current} / ${total}',
			'hymns.projection.hint' => 'आगे जाने के लिए दाईं ओर, पीछे जाने के लिए बाईं ओर टैप करो।',
			'hymns.pad.title' => 'भजन पर जाओ',
			'hymns.pad.open' => 'खोलो',
			'hymns.pad.erase' => 'मिटाओ',
			'hymns.pad.notFound' => ({required Object number}) => 'इस संग्रह में भजन नं. ${number} नहीं है',
			'hymns.pad.placeholder' => 'नंबर टाइप करो',
			'comingSoon.badge' => 'जल्द आ रहा है',
			'comingSoon.backHome' => 'होम पर वापस जाओ',
			'events.title' => 'कार्यक्रम',
			'events.featured' => 'विशेष',
			'events.upcoming' => 'आने वाले',
			'events.past' => 'पिछले संस्करण',
			'events.emptyTitle' => 'कोई आने वाला कार्यक्रम नहीं',
			'events.emptyText' => 'पूरे समुदाय के सम्मेलन और सभाएँ अपनी समय-सारणी के साथ यहाँ दिखेंगी।',
			'events.manage' => 'कार्यक्रम प्रबंधित करो',
			'events.next' => 'अगला कार्यक्रम',
			'events.seeAll' => 'सभी कार्यक्रम',
			'events.homeText' => 'समुदाय की सभाएँ, उनकी समय-सारणी और ख़बरें।',
			'events.today' => 'आज',
			'events.tomorrow' => 'कल',
			'events.inDays' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hi'))(n, one: '${n} दिन में', other: '${n} दिन में', ), 
			'events.daysLeft' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hi'))(n, other: '${n} दिन बाकी', ), 
			'events.onNow' => 'अभी चल रहा है',
			'events.over' => 'समाप्त',
			'events.cancelled' => 'रद्द',
			'events.draft' => 'ड्राफ़्ट',
			'events.registered' => 'रजिस्टर्ड',
			'events.stateOpen' => 'रजिस्ट्रेशन खुला है',
			'events.stateClosed' => 'रजिस्ट्रेशन बंद है',
			'events.stateFull' => 'जगह भर गई',
			'events.registrations' => ({required num n, required Object count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hi'))(n, zero: 'रजिस्टर करने वाले पहले व्यक्ति बनो', one: '${count} रजिस्ट्रेशन', other: '${count} रजिस्ट्रेशन', ), 
			'events.people' => ({required num n, required Object count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hi'))(n, one: '${count} व्यक्ति', other: '${count} लोग', ), 
			'events.placesLeft' => ({required num n, required Object count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hi'))(n, zero: 'कोई जगह नहीं बची', one: '${count} जगह बची है', other: '${count} जगहें बची हैं', ), 
			'events.oneDay' => ({required Object start, required Object end}) => '${start} से ${end} तक',
			'events.severalDays' => ({required Object startDay, required Object start, required Object endDay, required Object end}) => '${startDay} को ${start} बजे शुरू, ${endDay} को ${end} बजे समापन',
			'events.venueTime' => ({required Object place}) => '${place} का समय',
			'events.addToCalendar' => 'कैलेंडर में जोड़ो',
			'events.share' => 'शेयर करो',
			'events.directions' => 'रास्ता देखो',
			'events.viewPoster' => 'पोस्टर देखो',
			'events.tabs.program' => 'समय-सारणी',
			'events.tabs.news' => 'ख़बरें',
			'events.tabs.info' => 'जानकारी',
			'events.tabs.photos' => 'फ़ोटो',
			'events.noProgram' => 'समय-सारणी जल्द ही प्रकाशित होगी।',
			'events.noNews' => 'इस कार्यक्रम की अभी कोई ख़बर नहीं है।',
			'events.pinned' => 'पिन किया गया',
			'events.now' => 'इस समय',
			'events.hymn' => ({required Object number}) => 'भजन ${number}',
			'events.about' => 'परिचय',
			'events.fees' => 'सहयोग राशि',
			'events.deadline' => ({required Object date}) => 'रजिस्ट्रेशन ${date} तक',
			'events.contact' => 'संपर्क',
			'events.call' => ({required Object name}) => '${name} को कॉल करो',
			'events.otherEditions' => 'दूसरे संस्करण',
			'events.cancelledBanner' => 'यह कार्यक्रम रद्द हो गया है।',
			'events.calendarFailed' => 'फ़ोन का कैलेंडर नहीं खुल पाया।',
			'events.linkFailed' => 'यह लिंक नहीं खुल पाया।',
			'events.shareText' => ({required Object title, required Object dates, required Object place}) => '${title}\n${dates} · ${place}\nCMFI Connect ऐप में रजिस्टर करो।',
			'events.full' => 'इस कार्यक्रम में अब कोई जगह नहीं बची है।',
			'events.closed' => 'इस कार्यक्रम का रजिस्ट्रेशन बंद हो गया है।',
			'events.register.cta' => 'मैं शामिल हूँ',
			'events.register.title' => 'मैं शामिल हूँ',
			'events.register.people' => 'कितने लोग आएँगे?',
			'events.register.peopleHint' => 'तुम्हें मिलाकर, तुम्हारे परिवार या समूह के साथ।',
			'events.register.less' => 'एक व्यक्ति कम',
			'events.register.more' => 'एक व्यक्ति ज़्यादा',
			'events.register.lodging' => 'मुझे ठहरने की जगह चाहिए',
			'events.register.lodgingHint' => 'आयोजक उसी हिसाब से ठहरने की व्यवस्था करेंगे।',
			'events.register.departure' => 'रवाना होने का शहर',
			'events.register.departureHint' => 'जैसे: डुआला',
			'events.register.confirm' => 'मेरा रजिस्ट्रेशन पक्का करो',
			'events.register.update' => 'अपडेट करो',
			'events.register.cancel' => 'मेरा रजिस्ट्रेशन रद्द करो',
			'events.register.done' => 'हो गया, तुम्हारा रजिस्ट्रेशन हो गया! हम तुम्हें एक दिन पहले याद दिलाएँगे।',
			'events.register.updated' => 'तुम्हारा रजिस्ट्रेशन अपडेट हो गया।',
			'events.register.cancelled' => 'तुम्हारा रजिस्ट्रेशन रद्द हो गया।',
			'events.register.edit' => 'बदलो',
			'events.register.youAre' => 'तुम्हारा रजिस्ट्रेशन हो गया है',
			'events.register.cancelTitle' => 'अपना रजिस्ट्रेशन रद्द करना है?',
			'events.register.cancelText' => 'तुम्हारी जगह किसी और को मिल जाएगी।',
			'events.register.keep' => 'मेरी जगह रहने दो',
			'events.register.lodgingShort' => 'आवास',
			'events.reminder.channel' => 'कार्यक्रम रिमाइंडर',
			'events.reminder.tomorrow' => ({required Object title}) => 'कल: ${title}',
			'events.reminder.soon' => ({required Object title}) => '1 घंटे में: ${title}',
			'events.admin.title' => 'कार्यक्रम प्रबंधन',
			'events.admin.create' => 'कार्यक्रम बनाओ',
			'events.admin.edit' => 'कार्यक्रम बदलो',
			'events.admin.empty' => 'अभी तक कोई कार्यक्रम नहीं है। पहला कार्यक्रम बनाओ!',
			'events.admin.poster' => 'पोस्टर',
			'events.admin.posterAdd' => 'पोस्टर चुनो',
			'events.admin.posterChange' => 'पोस्टर बदलो',
			'events.admin.posterRemove' => 'पोस्टर हटाओ',
			'events.admin.posterHint' => 'पोर्ट्रेट 4:5 बेहतर रहेगा (1080 × 1350), JPEG या PNG।',
			'events.admin.uploading' => 'तस्वीर भेजी जा रही है…',
			'events.admin.general' => 'कार्यक्रम',
			'events.admin.titleField' => 'शीर्षक',
			'events.admin.titleHint' => 'जैसे: वार्षिक सम्मेलन 2026',
			'events.admin.titleRequired' => 'कार्यक्रम का शीर्षक दो।',
			'events.admin.theme' => 'विषय',
			'events.admin.themeHint' => 'जैसे: आत्मा के अनुसार चलना',
			'events.admin.verse' => 'विषय वचन',
			'events.admin.description' => 'परिचय',
			'events.admin.when' => 'तारीख़ें',
			'events.admin.starts' => 'शुरुआत',
			'events.admin.ends' => 'समापन',
			'events.admin.endsBeforeStart' => 'समापन, शुरुआत के बाद होना चाहिए।',
			'events.admin.timeZone' => ({required Object zone}) => 'स्थान का समय (${zone})।',
			'events.admin.where' => 'स्थान',
			'events.admin.venue' => 'स्थान',
			'events.admin.venueHint' => 'जैसे: म्वोल्ये सम्मेलन केंद्र',
			'events.admin.address' => 'पता',
			'events.admin.city' => 'शहर',
			'events.admin.country' => 'देश',
			'events.admin.mapsUrl' => 'Google Maps लिंक',
			'events.admin.registration' => 'रजिस्ट्रेशन',
			'events.admin.registrationOpen' => 'रजिस्ट्रेशन खुला है',
			'events.admin.deadline' => 'अंतिम तारीख़',
			'events.admin.noDeadline' => 'कोई अंतिम तारीख़ नहीं',
			'events.admin.capacity' => 'जगहों की संख्या',
			'events.admin.capacityHint' => 'ख़ाली: कोई सीमा नहीं',
			'events.admin.asksLodging' => 'पूछो कि किसे ठहरने की जगह चाहिए',
			'events.admin.asksDeparture' => 'रवाना होने का शहर पूछो',
			'events.admin.fees' => 'सहयोग राशि',
			'events.admin.feesHint' => 'जैसे: प्रवेश निःशुल्क। भोजन: 2,000 FCFA प्रति दिन।',
			'events.admin.contact' => 'संपर्क',
			'events.admin.contactName' => 'संपर्क व्यक्ति का नाम',
			'events.admin.contactPhone' => 'संपर्क फ़ोन नंबर',
			'events.admin.visibility' => 'दृश्यता',
			'events.admin.statusDraft' => 'ड्राफ़्ट',
			'events.admin.statusDraftHint' => 'सिर्फ़ एडमिन देख सकते हैं',
			'events.admin.statusPublished' => 'प्रकाशित',
			'events.admin.statusPublishedHint' => 'पूरा समुदाय देख सकता है',
			'events.admin.statusCancelled' => 'रद्द',
			'events.admin.statusCancelledHint' => 'रद्द के रूप में दिखेगा, रजिस्ट्रेशन नहीं होगा',
			'events.admin.saved' => 'कार्यक्रम सेव हो गया।',
			'events.admin.menu' => 'प्रबंधन',
			'events.admin.program' => 'समय-सारणी',
			'events.admin.registrants' => 'रजिस्टर्ड लोग',
			'events.admin.post' => 'ख़बर प्रकाशित करो',
			'events.admin.photos' => 'फ़ोटो जोड़ो',
			'events.admin.nextEdition' => 'अगला संस्करण तैयार करो',
			'events.admin.delete' => 'कार्यक्रम हटाओ',
			'events.admin.deleteTitle' => 'यह कार्यक्रम हटाना है?',
			'events.admin.deleteText' => 'इसके रजिस्ट्रेशन, ख़बरें और फ़ोटो भी हटा दिए जाएँगे।',
			'events.admin.deleteConfirm' => 'हटाओ',
			'events.admin.deleted' => 'कार्यक्रम हटा दिया गया।',
			'events.admin.nextEditionTitle' => 'अगला संस्करण तैयार करना है?',
			'events.admin.nextEditionText' => 'एक साल बाद का एक ड्राफ़्ट बनाया जाएगा, उसी स्थान और उसी समय-सारणी के साथ। प्रकाशित करने से पहले सब कुछ बदला जा सकता है।',
			'events.admin.nextEditionConfirm' => 'तैयार करो',
			'events.admin.nextEditionDone' => 'अगला संस्करण ड्राफ़्ट के रूप में तैयार है।',
			'events.admin.programEmpty' => 'कार्यक्रम के सत्र जोड़ो: स्वागत, आराधना सभाएँ, शिक्षाएँ, रात्रि प्रार्थना…',
			'events.admin.addSession' => 'सत्र जोड़ो',
			'events.admin.editSession' => 'यह सत्र बदलो',
			'events.admin.sessionTitle' => 'शीर्षक',
			'events.admin.sessionTitleHint' => 'जैसे: उद्घाटन आराधना',
			'events.admin.speaker' => 'वक्ता',
			'events.admin.place' => 'हॉल',
			'events.admin.day' => 'दिन',
			'events.admin.from' => 'से',
			'events.admin.to' => 'तक',
			'events.admin.hymns' => 'भजन',
			'events.admin.hymnsHint' => 'नंबर, जैसे: 12, 45',
			'events.admin.removeSession' => 'हटाओ',
			'events.admin.saveProgram' => 'समय-सारणी सेव करो',
			'events.admin.programSaved' => 'समय-सारणी सेव हो गई।',
			'events.admin.registrantsEmpty' => 'अभी तक किसी ने रजिस्टर नहीं किया है।',
			'events.admin.totalRegistrations' => 'रजिस्ट्रेशन',
			'events.admin.totalPeople' => 'लोग',
			'events.admin.totalLodging' => 'आवास चाहिए',
			'events.admin.byCity' => 'रवाना होने के शहर के अनुसार',
			'events.admin.list' => 'सूची',
			'events.admin.exportCsv' => 'सूची एक्सपोर्ट करो (CSV)',
			'events.admin.csvHeader' => 'नाम,यूज़रनेम,फ़ोन,चर्च,सभा,लोग,आवास,रवाना होने का शहर,रजिस्ट्रेशन की तारीख़',
			'events.admin.yes' => 'हाँ',
			'events.admin.no' => 'नहीं',
			'events.admin.postBody' => 'संदेश',
			'events.admin.postBodyHint' => 'जैसे: रजिस्ट्रेशन शुरू हो गया है!',
			'events.admin.postImage' => 'तस्वीर जोड़ो',
			'events.admin.postPinned' => 'सबसे ऊपर पिन करो',
			'events.admin.postSend' => 'प्रकाशित करो',
			'events.admin.postDone' => 'ख़बर प्रकाशित हो गई।',
			'events.admin.postDelete' => 'यह ख़बर हटाओ',
			'events.admin.postDeleted' => 'ख़बर हटा दी गई।',
			'events.admin.photosAdded' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hi'))(n, one: '${n} फ़ोटो जोड़ी गई।', other: '${n} फ़ोटो जोड़ी गईं।', ), 
			'events.admin.photosSending' => ({required Object done, required Object total}) => 'फ़ोटो भेजी जा रही हैं (${done}/${total})…',
			'events.admin.photoDelete' => 'यह फ़ोटो हटाओ',
			'events.admin.photoDeleted' => 'फ़ोटो हटा दी गई।',
			'events.admin.confirmDelete' => 'हटाओ',
			'events.upcomingCount' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hi'))(n, one: '${n} आने वाला कार्यक्रम', other: '${n} आने वाले कार्यक्रम', ), 
			'events.slide' => ({required Object current, required Object total}) => 'कार्यक्रम ${current} / ${total}',
			'notifications.title' => 'सूचनाएँ',
			'notifications.channel' => 'समुदाय की घोषणाएँ',
			'notifications.empty' => 'अभी कोई सूचना नहीं',
			'notifications.emptyHint' => 'समुदाय की घोषणाएँ यहाँ आएँगी।',
			'notifications.unreadLabel' => ({required Object title}) => 'अपठित: ${title}',
			'notifications.documents' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hi'))(n, one: '${n} PDF दस्तावेज़', other: '${n} PDF दस्तावेज़', ), 
			'notifications.unread' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hi'))(n, one: '${n} अपठित', other: '${n} अपठित', ), 
			'notifications.image' => ({required Object n}) => 'चित्र ${n}',
			'notifications.document' => 'PDF दस्तावेज़',
			'notifications.documentSize' => ({required Object kb}) => '${kb} KB',
			'notifications.received' => ({required Object title}) => 'नई सूचना: ${title}',
			'premium.name' => 'CMFI Connect Premium',
			'premium.pill' => 'Premium',
			'premium.subtitle' => 'परमेश्वर के साथ अपनी चाल में आगे बढ़ो, और सेवकाई का साथ दो।',
			'premium.widgetTitle' => 'होम स्क्रीन विजेट',
			'premium.widgetText' => 'ऐप खोले बिना आज की रिपोर्ट और तुम्हारे लक्ष्य।',
			'premium.statsTitle' => 'पूरे साल के तुम्हारे लक्ष्य',
			'premium.statsText' => 'साल का सारांश और तुम्हारे लक्ष्यों की प्रगति, हफ़्ते दर हफ़्ते।',
			'premium.supportTitle' => 'तुम सेवकाई का साथ देते हो',
			'premium.supportText' => 'तुम्हारी सदस्यता पूरे समुदाय के लिए ऐप को चालू रखती है।',
			'premium.annual' => 'सालाना',
			'premium.monthly' => 'मासिक',
			'premium.perYear' => ({required Object price}) => '${price} / साल',
			'premium.perMonth' => ({required Object price}) => '${price} / महीना',
			'premium.annualPerMonth' => ({required Object price}) => 'यानी ${price} प्रति महीना',
			'premium.best' => 'सबसे फ़ायदेमंद',
			'premium.trialDays' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hi'))(n, one: '${n} दिन मुफ़्त आज़माओ', other: '${n} दिन मुफ़्त आज़माओ', ), 
			'premium.trialMonths' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hi'))(n, one: '${n} महीना मुफ़्त आज़माओ', other: '${n} महीने मुफ़्त आज़माओ', ), 
			'premium.subscribe' => 'सदस्यता लो',
			'premium.startTrial' => 'मुफ़्त आज़माना शुरू करो',
			'premium.restore' => 'ख़रीदारी वापस लाओ',
			'premium.restored' => 'Premium इस फ़ोन पर वापस आ गया',
			'premium.nothingToRestore' => 'इस खाते के लिए कोई Premium ख़रीदारी नहीं',
			'premium.thanks' => 'धन्यवाद! Premium चालू है।',
			'premium.failed' => 'ख़रीदारी पूरी नहीं हुई। थोड़ी देर में फिर कोशिश करो।',
			'premium.unavailable' => 'अभी ऑफ़र उपलब्ध नहीं हैं।',
			'premium.renews' => ({required Object store}) => 'सदस्यता अपने आप नवीनीकृत होती है। तुम इसे कभी भी अपने ${store} खाते की सेटिंग में रद्द कर सकते हो।',
			'premium.terms' => 'उपयोग की शर्तें',
			'premium.privacy' => 'गोपनीयता',
			'premium.activeTitle' => 'तुम्हारे पास Premium है',
			'premium.activeText' => 'CMFI Connect का साथ देने के लिए धन्यवाद! विजेट और तुम्हारे सारांश का साल खुले हैं।',
			'premium.staffText' => 'तुम CMFI Connect टीम का हिस्सा हो, इसलिए Premium तुम्हें मुफ़्त मिला है।',
			'premium.moreSubtitle' => 'विजेट, पूरे साल के लक्ष्य',
			'premium.moreActive' => 'चालू',
			'premium.unlock' => 'Premium से खोलो',
			'premium.trialThen' => ({required Object trial, required Object price}) => '${trial}, फिर ${price}',
			'premium.savePercent' => ({required Object percent}) => '−${percent}',
			'premium.choose' => 'अपना प्लान चुनो',
			'premium.cancelAnytime' => 'कोई बंधन नहीं, कभी भी रद्द करो',
			'premium.restoreShort' => 'बहाल करें',
			'premium.termsShort' => 'शर्तें',
			'premium.semiannual' => 'छमाही',
			'premium.perSemester' => ({required Object price}) => '${price} / 6 महीने',
			'homeWidget.title' => 'आज',
			'homeWidget.done' => 'हो गया',
			'homeWidget.todo' => 'भरना बाकी',
			'homeWidget.open' => 'भरो',
			'homeWidget.locked' => 'Premium से विजेट चालू करो',
			'homeWidget.signedOut' => 'ऐप में साइन इन करो',
			'ministry.title' => 'हमारी सेवकाई',
			'ministry.tagline' => 'पृथ्वी की छोर तक',
			'ministry.count' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hi'))(n, one: '${n} राष्ट्र', other: '${n} राष्ट्र', ), 
			'ministry.fromYaounde' => 'याउंडे से, सुसमाचार एक राष्ट्र से दूसरे राष्ट्र तक जाता है।',
			'ministry.dragHint' => 'उंगली से ग्लोब घुमाओ, किसी राष्ट्र को छुओ।',
			'ministry.globeLabel' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hi'))(n, one: 'ग्लोब: ${n} राष्ट्र जहाँ सेवकाई मौजूद है। नीचे की सूची उसे बताती है।', other: 'ग्लोब: ${n} राष्ट्र जहाँ सेवकाई मौजूद है। नीचे की सूची सबको बताती है।', ), 
			'ministry.voyage' => 'यात्रा',
			'ministry.pause' => 'रोको',
			'ministry.previous' => 'पिछला राष्ट्र',
			'ministry.next' => 'अगला राष्ट्र',
			'ministry.number' => ({required Object n}) => 'राष्ट्र क्रमांक ${n}',
			'ministry.since' => ({required Object year}) => '${year} से',
			'ministry.pray' => 'प्रार्थना',
			'ministry.prayTitle' => ({required Object country}) => '${country} के लिए प्रार्थना',
			'ministry.prayThanks' => ({required Object country}) => '${country} में परमेश्वर के काम के लिए धन्यवाद दो।',
			'ministry.prayAssemblies' => ({required Object country}) => '${country} की कलीसियाओं और उनके अगुवों के लिए प्रार्थना करो।',
			'ministry.prayUnreached' => ({required Object country}) => 'प्रार्थना करो कि ${country} में जिन्होंने अभी तक विश्वास नहीं किया, वे यीशु से मिलें।',
			'ministry.purpose' => 'हमारा उद्देश्य',
			'ministry.nations' => 'राष्ट्र',
			'ministry.search' => 'राष्ट्र खोजो',
			'ministry.none' => 'कोई राष्ट्र नहीं मिला',
			'ministry.homeText' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hi'))(n, one: '${n} राष्ट्र में मौजूद', other: '${n} राष्ट्रों में मौजूद', ), 
			'ministry.nationsSubtitle' => 'ग्लोब और एक राष्ट्र से दूसरे राष्ट्र की यात्रा',
			'ministry.purposeSubtitle' => 'हमारे तीन लक्ष्य',
			'ministry.missionaries' => 'हमारे मिशनरी',
			'ministry.missionariesSubtitle' => 'जिन्हें प्रभु राष्ट्रों में भेजता है',
			'ministry.heroes' => 'हमारे नायक',
			'ministry.heroesSubtitle' => 'जिनका विश्वास हमें प्रेरित करता है',
			'ministry.goalOf' => ({required Object n, required Object total}) => 'हमारा लक्ष्य · ${n}/${total}',
			'ministry.previousGoal' => 'पिछला लक्ष्य',
			'ministry.nextGoal' => 'अगला लक्ष्य',
			'ministry.media.books' => 'पुस्तकें',
			'ministry.media.tracts' => 'पर्चे',
			'ministry.media.magazines' => 'पत्रिकाएँ',
			'ministry.media.cds' => 'सीडी',
			'ministry.media.dvds' => 'डीवीडी',
			'ministry.media.radio' => 'रेडियो',
			'ministry.media.tv' => 'टेलीविज़न',
			'ministry.media.internet' => 'इंटरनेट',
			'ministry.goals.crusade.title' => 'हर प्राणी तक सुसमाचार अभियान',
			'ministry.goals.crusade.text' => 'हमारी पीढ़ी में जीने वाले हर व्यक्ति को सुसमाचार सुनाना, ताकि पवित्र आत्मा की सामर्थ्य में प्रचारित सुसमाचार 10 अरब लोगों तक पहुँचे — संचार के हर साधन (हमारी पुस्तकें, पर्चे, पत्रिकाएँ, सीडी, डीवीडी, रेडियो, टेलीविज़न और इंटरनेट) का उपयोग करते हुए, जितनी जल्दी हो सके।',
			'ministry.goals.crusade.reached' => 'लोगों तक सुसमाचार',
			'ministry.goals.disciples.title' => 'चेले बनाना',
			'ministry.goals.disciples.text' => '250 राष्ट्रों में 1 अरब लोगों को यीशु मसीह को प्रभु और उद्धारकर्ता के रूप में जानने तक ले जाना, उन्हें चेले बनाना ताकि वे हर बात में उसकी आज्ञा मानें, और उन्हें वर्ष 2065 तक 2.5 करोड़ घरेलू कलीसियाओं में इकट्ठा होने के लिए संगठित करना।',
			'ministry.goals.disciples.people' => 'चेले',
			'ministry.goals.disciples.nations' => 'राष्ट्र',
			'ministry.goals.disciples.churches' => 'घरेलू कलीसियाएँ',
			'ministry.goals.disciples.by' => ({required Object year}) => '${year} तक',
			'ministry.goals.revival.title' => 'विश्वव्यापी जागृति को शीघ्र लाना',
			'ministry.goals.revival.text' => 'उपवास और मध्यस्थ प्रार्थना के द्वारा परमेश्वर के साथ सहयोग करना, उस विश्वव्यापी जागृति के लिए जो आकाश को फाड़ देगी, पृथ्वी को हिला देगी और हमारी पीढ़ी में मसीह की महिमा करेगी, ताकि हमारे प्रभु यीशु मसीह का स्वर्ग से शीघ्र आगमन हो और वह अपनी तैयार की गई दुल्हन से मिले।',
			'ministry.goals.revival.fasting' => 'उपवास',
			'ministry.goals.revival.intercession' => 'मध्यस्थ प्रार्थना',
			'ministry.goals.revival.pray' => 'अभी प्रार्थना करो',
			'prayer.moments.morning' => 'सुबह',
			'prayer.moments.noon' => 'दोपहर',
			'prayer.moments.evening' => 'शाम',
			'prayer.moments.night' => 'रात',
			'prayer.retreatOf.morning' => 'सुबह का प्रार्थना-समय',
			'prayer.retreatOf.noon' => 'दोपहर का प्रार्थना-समय',
			'prayer.retreatOf.evening' => 'शाम का प्रार्थना-समय',
			'prayer.retreatOf.night' => 'रात का प्रार्थना-समय',
			'prayer.hero.now' => ({required Object retreat}) => '${retreat} · अभी',
			'prayer.hero.title' => '15 मिनट\nप्रभु के साथ',
			'prayer.hero.preview.morning' => 'धन्यवाद दो, अपना दिन, अपना काम, अपना परिवार समर्पित करो…',
			'prayer.hero.preview.noon' => 'तुम्हारी सभा, तुम्हारे अगुवे, तुम्हारी सूची के 5 लोग, राष्ट्र…',
			'prayer.hero.preview.evening' => 'तुम्हारा प्रार्थना-जीवन, तुम्हारी सेवकाई, तुम्हारे सहकर्मी…',
			'prayer.hero.preview.night' => 'बीमार लोग, राष्ट्रों में सुसमाचार, रात की सुरक्षा…',
			'prayer.hero.meta' => '15 बिंदु · हर एक 1 मिनट',
			'prayer.hero.start' => 'शुरू करो',
			'prayer.hero.allDone' => 'आज के चारों प्रार्थना-समय पूरे हो गए। परमेश्वर उत्तर दे!',
			'prayer.hero.doneNow' => ({required Object retreat, required Object next}) => '${retreat} पूरा हुआ। अगला: ${next}',
			'prayer.today.toPray' => 'प्रार्थना बाकी',
			'prayer.today.week' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hi'))(n, zero: 'इस हफ़्ते कोई प्रार्थना-समय नहीं', one: 'इस हफ़्ते ${n} प्रार्थना-समय', other: 'इस हफ़्ते ${n} प्रार्थना-समय', ), 
			'prayer.routine.title' => 'आज की तुम्हारी दिनचर्या',
			'prayer.routine.count' => ({required Object done}) => '4 में से ${done}',
			'prayer.routine.days' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hi'))(n, one: '7 में से ${n} दिन', other: '7 में से ${n} दिन', ), 
			'prayer.routine.week' => ({required Object time}) => 'इस सप्ताह ${time}',
			'prayer.routine.done' => 'हो गई · 15 मिनट',
			'prayer.routine.now' => 'अभी · 15 मिनट',
			'prayer.routine.next' => 'अगली · 15 मिनट',
			'prayer.routine.reminder' => ({required Object time}) => '${time} पर याद दिलाना',
			'prayer.routine.later.morning' => 'सुबह · 15 मिनट',
			'prayer.routine.later.noon' => 'दोपहर · 15 मिनट',
			'prayer.routine.later.evening' => 'शाम · 15 मिनट',
			'prayer.routine.later.night' => 'रात · 15 मिनट',
			'prayer.together' => 'साथ मिलकर प्रार्थना',
			'prayer.reminders.title' => 'प्रार्थना-समय के रिमाइंडर',
			'prayer.reminders.intro' => 'हर प्रार्थना-समय पर एक रिमाइंडर, सिर्फ़ तब जब वह अभी पूरा न हुआ हो।',
			'prayer.reminders.off' => 'बंद',
			'prayer.reminders.channel' => 'प्रार्थना-समय',
			'prayer.reminders.body' => 'प्रभु के साथ 15 मिनट।',
			'prayer.retreat.title' => '15 मिनट के प्रार्थना-समय',
			'prayer.retreat.hours.morning' => 'जागते ही',
			'prayer.retreat.hours.noon' => 'दोपहर 12 से 2 बजे के बीच',
			'prayer.retreat.hours.evening' => 'दोपहर ढलने पर',
			'prayer.retreat.hours.night' => 'सोने से पहले',
			'prayer.retreat.reminderAt' => ({required Object time}) => 'रिमाइंडर ${time} पर',
			'prayer.retreat.intro' => '15 बिंदु, हर एक के लिए एक मिनट। एक हल्की आवाज़ तुम्हें अगले बिंदु पर ले जाती है।',
			'prayer.retreat.done' => 'आज पूरा हुआ',
			'prayer.retreat.start' => 'शुरू करो · 15 मिनट',
			'prayer.retreat.selfPaced' => 'अपनी रफ़्तार से पढ़ो, बिना टाइमर के',
			'prayer.retreat.hints.assembly' => ({required Object name}) => 'तुम्हारी सभा: ${name}',
			'prayer.retreat.hints.assemblyMissing' => 'अपनी प्रोफ़ाइल में अपनी सभा जोड़ो',
			'prayer.retreat.hints.authorities' => ({required Object names}) => 'तुम्हारे अगुवे: ${names}',
			'prayer.retreat.hints.authoritiesMissing' => '‘और’ में अपने आत्मिक अगुवे जोड़ो',
			'prayer.retreat.hints.list' => ({required Object list}) => 'मेरी सूचियाँ · ${list}',
			'prayer.retreat.hints.listEmpty' => ({required Object list}) => 'तुम्हारी “${list}” सूची ख़ाली है: नाम जोड़ो',
			'prayer.retreat.hints.nation' => ({required Object name}) => 'आज: ${name}',
			'prayer.retreat.hints.myCountry' => ({required Object name}) => 'तुम्हारा देश: ${name}',
			'prayer.retreat.hints.hymn' => 'भजन खोलो',
			'prayer.session.point' => ({required Object n}) => '15 में से बिंदु ${n}',
			'prayer.session.remaining' => 'बाकी',
			'prayer.session.paused' => 'रुका हुआ',
			'prayer.session.inYourList' => ({required Object list}) => 'तुम्हारी सूची में · ${list}',
			'prayer.session.tomorrow' => 'कल, अगले लोग।',
			'prayer.session.footer' => 'स्क्रीन चालू · हर मिनट एक हल्की आवाज़',
			'prayer.session.previous' => 'पिछला बिंदु',
			'prayer.session.next' => 'अगला बिंदु',
			'prayer.session.pause' => 'रोको',
			'prayer.session.resume' => 'फिर शुरू करो',
			'prayer.session.soundOn' => 'आवाज़ चालू',
			'prayer.session.soundOff' => 'आवाज़ बंद',
			'prayer.session.finish' => 'प्रार्थना-समय पूरा करो',
			'prayer.session.quitTitle' => 'प्रार्थना-समय रोकना है?',
			'prayer.session.quitText' => 'यह तुम्हारे दिन में नहीं गिना जाएगा।',
			'prayer.session.quit' => 'रोको',
			'prayer.session.keepPraying' => 'प्रार्थना जारी रखो',
			'prayer.done.title' => ({required Object retreat}) => '${retreat} पूरा हुआ',
			'prayer.done.text' => 'प्रभु के साथ 15 मिनट।\nउसने तुम्हारी हर प्रार्थना सुनी है।',
			'prayer.done.report' => 'तुम्हारी रिपोर्ट में जोड़ दिया गया',
			'prayer.done.reportDetail' => ({required Object added, required Object total}) => 'व्यक्तिगत प्रार्थना: +${added} मिनट · आज ${total} मिनट',
			'prayer.done.undo' => 'वापस लो',
			'prayer.done.undone' => 'प्रार्थना-समय तुम्हारे दिन से हटा दिया गया।',
			'prayer.done.today' => 'आज',
			'prayer.done.count' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hi'))(n, one: '4 में से ${n} प्रार्थना-समय', other: '4 में से ${n} प्रार्थना-समय', ), 
			'prayer.done.verse' => '“निरन्तर प्रार्थना में लगे रहो।”',
			'prayer.done.reference' => '1 थिस्सलुनीकियों 5:17',
			'prayer.done.finish' => 'पूरा करो',
			'prayer.done.hymn' => 'एक भजन गाओ',
			'prayer.topics.title' => 'समुदाय के प्रार्थना विषय',
			'prayer.topics.all' => 'सब देखो',
			'prayer.topics.empty' => 'अभी कोई प्रार्थना विषय नहीं है। अगुवे अगले विषय यहीं प्रकाशित करेंगे।',
			'prayer.topics.categories.church' => 'चर्च',
			'prayer.topics.categories.nations' => 'राष्ट्र',
			'prayer.topics.categories.sick' => 'बीमार',
			'prayer.topics.categories.event' => 'कार्यक्रम',
			'prayer.topics.categories.fasting' => 'उपवास',
			'prayer.topics.categories.other' => 'विषय',
			'prayer.topics.until' => ({required Object date}) => '${date} तक',
			'prayer.topics.archive' => 'पिछले विषय',
			'prayer.topics.archiveEmpty' => 'कोई पिछला विषय नहीं।',
			'prayer.topics.current' => 'इस समय',
			'prayer.topics.documentSize' => ({required Object kb}) => '${kb} KB',
			'prayer.topics.download' => 'PDF डाउनलोड करो',
			'prayer.topics.noDocument' => 'PDF नहीं है',
			'prayer.topics.openDocument' => 'PDF खोलो',
			'prayer.lists.title' => 'मेरी प्रार्थना सूचियाँ',
			'prayer.lists.private' => 'सिर्फ़ तुम्हारे लिए',
			'prayer.lists.names.unbelievers' => 'अब तक विश्वास नहीं किया',
			'prayer.lists.names.believers' => 'विश्वासी',
			'prayer.lists.names.backsliders' => 'पीछे हटे हुए विश्वासी',
			'prayer.lists.names.coworkers' => 'सहकर्मी',
			'prayer.lists.uses.unbelievers' => 'दोपहर के प्रार्थना-समय में हर दिन इस सूची के 10 लोगों (5 + 5) के लिए बारी-बारी से प्रार्थना होती है।',
			'prayer.lists.uses.believers' => 'दोपहर के प्रार्थना-समय में हर दिन इस सूची के 5 लोगों के लिए बारी-बारी से प्रार्थना होती है।',
			'prayer.lists.uses.backsliders' => 'दोपहर के प्रार्थना-समय में हर दिन इस सूची के 5 लोगों के लिए बारी-बारी से प्रार्थना होती है।',
			'prayer.lists.uses.coworkers' => 'शाम के प्रार्थना-समय में हर दिन तुम्हारे 10 सहकर्मियों (5 + 5) के लिए बारी-बारी से प्रार्थना होती है।',
			'prayer.lists.privateNote' => 'इसे सिर्फ़ तुम देख सकते हो।',
			'prayer.lists.count' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hi'))(n, zero: 'कोई नहीं', one: '${n} व्यक्ति', other: '${n} लोग', ), 
			'prayer.lists.empty' => 'अभी तक कोई नहीं। उन लोगों को जोड़ो जिनके लिए तुम प्रार्थना करते हो।',
			'prayer.lists.add' => 'व्यक्ति जोड़ो',
			'prayer.lists.prayedToday' => 'आज',
			'prayer.lists.next' => 'जल्द ही',
			'prayer.lists.answeredTitle.unbelievers' => 'प्रभु पर विश्वास किया',
			'prayer.lists.answeredTitle.believers' => 'उत्तर मिली प्रार्थनाएँ',
			'prayer.lists.answeredTitle.backsliders' => 'प्रभु के पास लौट आए',
			'prayer.lists.answeredTitle.coworkers' => 'उत्तर मिली प्रार्थनाएँ',
			'prayer.lists.answeredOn.unbelievers' => ({required Object date}) => '${date} को प्रभु पर विश्वास किया',
			'prayer.lists.answeredOn.believers' => ({required Object date}) => '${date} को उत्तर मिला',
			'prayer.lists.answeredOn.backsliders' => ({required Object date}) => '${date} को प्रभु के पास लौट आए',
			'prayer.lists.answeredOn.coworkers' => ({required Object date}) => '${date} को उत्तर मिला',
			'prayer.lists.markAnswered.unbelievers' => 'प्रभु पर विश्वास किया!',
			'prayer.lists.markAnswered.believers' => 'प्रार्थना का उत्तर मिला',
			'prayer.lists.markAnswered.backsliders' => 'प्रभु के पास लौट आए!',
			'prayer.lists.markAnswered.coworkers' => 'प्रार्थना का उत्तर मिला',
			'prayer.lists.answeredToast' => 'परमेश्वर की महिमा हो!',
			'prayer.lists.putBack' => 'वापस सूची में डालो',
			'prayer.lists.answeredBanner' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hi'))(n, one: 'इस महीने ${n} प्रार्थना का उत्तर मिला', other: 'इस महीने ${n} प्रार्थनाओं का उत्तर मिला', ), 
			'prayer.lists.lastAnswered' => ({required Object name, required Object what}) => '${name}: ${what}',
			'prayer.lists.sheet.addTitle' => 'व्यक्ति जोड़ो',
			'prayer.lists.sheet.editTitle' => 'बदलो',
			'prayer.lists.sheet.name' => 'नाम',
			'prayer.lists.sheet.namePlaceholder' => 'राहुल एम.',
			'prayer.lists.sheet.note' => 'नोट',
			'prayer.lists.sheet.notePlaceholder' => 'दफ़्तर का साथी, पड़ोसी, चचेरी बहन…',
			'prayer.lists.sheet.list' => 'सूची',
			'prayer.lists.sheet.save' => 'सेव करो',
			'prayer.lists.sheet.remove' => 'सूची से हटाओ',
			'prayer.lists.sheet.removeTitle' => ({required Object name}) => '${name} को हटाना है?',
			'prayer.lists.sheet.removeText' => 'अब तुम्हारे प्रार्थना-समय में इस व्यक्ति के लिए प्रार्थना नहीं होगी।',
			'prayer.lists.addShort' => 'जोड़ो',
			'prayer.importunity.title' => 'लगातार प्रार्थना के विषय',
			'prayer.importunity.newTopic' => 'नया विषय',
			'prayer.importunity.intro' => 'एक विषय जिसे बिना थके प्रभु के सामने रखा जाता है, जब तक उत्तर न मिल जाए। घोषणाओं की एक संख्या तय करो और अपने भाई-बहनों को अपने साथ प्रार्थना करने का न्योता दो।',
			'prayer.importunity.invitedBy' => ({required Object name}) => '${name} ने तुम्हें प्रार्थना का न्योता दिया है',
			'prayer.importunity.join' => 'मैं भी प्रार्थना में शामिल हूँ',
			'prayer.importunity.decline' => 'अभी नहीं',
			'prayer.importunity.joined' => 'अब तुम इस विषय की प्रार्थना में शामिल हो।',
			'prayer.importunity.progress' => ({required Object goal, required Object total}) => '${goal} में से ${total}',
			'prayer.importunity.total' => ({required num n, required Object count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hi'))(n, one: '${count} घोषणा', other: '${count} घोषणाएँ', ), 
			'prayer.importunity.reached' => 'लक्ष्य पूरा हुआ!',
			'prayer.importunity.closed' => 'बंद',
			'prayer.importunity.participants' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hi'))(n, one: '${n} व्यक्ति प्रार्थना में शामिल', other: '${n} लोग प्रार्थना में शामिल', ), 
			'prayer.importunity.mine' => ({required Object n}) => 'तुम: ${n}',
			'prayer.importunity.tapHint' => 'हर घोषणा पर टैप करो',
			'prayer.importunity.addMany' => 'संख्या जोड़ो',
			'prayer.importunity.addManyTitle' => 'कितनी घोषणाएँ?',
			'prayer.importunity.addManyLabel' => 'घोषणाएँ',
			'prayer.importunity.add' => 'जोड़ो',
			'prayer.importunity.pending' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hi'))(n, one: '${n} घोषणा भेजी जानी बाकी है', other: '${n} घोषणाएँ भेजी जानी बाकी हैं', ), 
			'prayer.importunity.invite' => 'न्योता दो',
			'prayer.importunity.members' => 'प्रार्थना करने वाले',
			'prayer.importunity.waiting' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hi'))(n, one: '${n} न्योता जवाब के इंतज़ार में', other: '${n} न्योते जवाब के इंतज़ार में', ), 
			'prayer.importunity.edit' => 'बदलो',
			'prayer.importunity.close' => 'विषय बंद करो',
			'prayer.importunity.reopen' => 'विषय फिर से खोलो',
			'prayer.importunity.delete' => 'विषय हटाओ',
			'prayer.importunity.deleteTitle' => 'यह विषय हटाना है?',
			'prayer.importunity.deleteText' => 'यह उन सबके लिए हट जाएगा जो तुम्हारे साथ प्रार्थना करते हैं।',
			'prayer.importunity.leave' => 'यह विषय छोड़ो',
			'prayer.importunity.leaveTitle' => 'यह विषय छोड़ना है?',
			'prayer.importunity.leaveText' => 'तुम्हारी घोषणाएँ कुल संख्या में बनी रहेंगी।',
			'prayer.importunity.form.newTitle' => 'लगातार प्रार्थना का नया विषय',
			'prayer.importunity.form.editTitle' => 'विषय बदलो',
			'prayer.importunity.form.subject' => 'विषय',
			'prayer.importunity.form.subjectPlaceholder' => 'हे प्रभु, राहुल का उद्धार कर',
			'prayer.importunity.form.description' => 'विवरण',
			'prayer.importunity.form.descriptionPlaceholder' => 'किसके लिए, क्यों…',
			'prayer.importunity.form.goal' => 'लक्ष्य',
			'prayer.importunity.form.goalHint' => 'घोषणाओं की वह संख्या जिस तक सबको मिलकर पहुँचना है। बिना लक्ष्य के गिनने के लिए ख़ाली छोड़ दो।',
			'prayer.importunity.form.goalPlaceholder' => '10,000',
			'prayer.importunity.form.create' => 'बनाओ',
			'prayer.importunity.form.save' => 'सेव करो',
			_ => null,
		} ?? switch (path) {
			'prayer.importunity.inviteSheet.title' => 'प्रार्थना का न्योता दो',
			'prayer.importunity.inviteSheet.family' => 'मेरा आत्मिक परिवार',
			'prayer.importunity.inviteSheet.familyText' => ({required num n, required Object name}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hi'))(n, one: '${name} और उनके चेले: ${n} व्यक्ति', other: '${name} और उनके चेले: ${n} लोग', ), 
			'prayer.importunity.inviteSheet.familyMissing' => 'अपने आत्मिक परिवार को न्योता देने के लिए ‘मेरे आत्मिक अगुवे’ में अपने चेला बनाने वाले को जोड़ो।',
			'prayer.importunity.inviteSheet.byUsername' => 'यूज़रनेम से',
			'prayer.importunity.inviteSheet.usernameLabel' => 'यूज़रनेम',
			'prayer.importunity.inviteSheet.addUsername' => 'जोड़ो',
			'prayer.importunity.inviteSheet.send' => 'न्योते भेजो',
			'prayer.importunity.inviteSheet.sent' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hi'))(n, zero: 'उन्हें पहले ही न्योता दिया जा चुका था।', one: '${n} न्योता भेजा गया', other: '${n} न्योते भेजे गए', ), 
			'prayer.importunity.eyebrow' => 'लगातार प्रार्थना का विषय',
			'prayer.importunity.proclaim' => 'घोषणा करो',
			'sending.title' => 'मेरे आत्मिक अगुवों को भेजना',
			'sending.moreOff' => 'बंद',
			'sending.intro' => 'चुने हुए समय पर CMFI Connect उस अवधि की तुम्हारी रिपोर्ट तैयार करता है। तुम्हें बस उसे अपने आत्मिक अगुवों को भेजना है।',
			'sending.enabled' => 'इसे नियमित रूप से तैयार करो',
			'sending.rhythm' => 'अंतराल',
			'sending.weekly' => 'हर हफ़्ते',
			'sending.biweekly' => 'हर 2 हफ़्ते',
			'sending.monthly' => 'हर महीने',
			'sending.day' => 'दिन',
			'sending.monthlyDay' => 'हर महीने की 1 तारीख़ को, पिछले महीने के लिए',
			'sending.time' => 'समय',
			'sending.recipients' => 'प्राप्तकर्ता',
			'sending.noAuthorities' => 'पहले अपने आत्मिक अगुवे जोड़ो।',
			'sending.addAuthorities' => 'मेरे अगुवे जोड़ो',
			'sending.viaWhatsApp' => 'WhatsApp से',
			'sending.viaEmail' => 'ई-मेल से',
			'sending.viaBoth' => 'WhatsApp या ई-मेल से',
			'sending.viaShare' => 'शेयर करके',
			'sending.next' => ({required Object date}) => 'अगला: ${date}',
			'sending.prepareNow' => 'अभी तैयार करो',
			'sending.history' => 'पिछली बार भेजे गए',
			'sending.notificationTitle' => 'तुम्हारी रिपोर्ट तैयार है',
			'sending.notificationBody' => 'एक टैप में अपने अगुवों को भेजो।',
			'sending.channel' => 'रिपोर्ट भेजना',
			'sending.readyTitle' => 'तुम्हारी रिपोर्ट तैयार है',
			'sending.preview' => 'संदेश का पूर्वावलोकन',
			'sending.greeting' => ({required Object name}) => 'नमस्ते ${name},',
			'sending.whatsApp' => 'WhatsApp',
			'sending.email' => 'ई-मेल',
			'sending.sharePdf' => 'PDF शेयर करो',
			'sending.shareText' => 'टेक्स्ट शेयर करो',
			'sending.sent' => 'भेजा गया',
			'sending.shared' => 'शेयर किया',
			'sending.noRecipients' => 'सेटिंग्स में प्राप्तकर्ता चुनो, या PDF शेयर करो।',
			'sending.settings' => 'सेटिंग्स',
			'sending.permissionDenied' => 'सही समय पर याद दिलाने के लिए सूचनाएँ चालू करो।',
			'streak.title' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hi'))(n, one: 'लगातार ${n} दिन!', other: 'लगातार ${n} दिन!', ), 
			'streak.cardDays' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hi'))(n, one: 'दिन परमेश्वर के साथ', other: 'दिन परमेश्वर के साथ', ), 
			'streak.lines.week' => 'पूरा एक हफ़्ता प्रभु के साथ, हर दिन। शाबाश, ऐसे ही चलते रहो!',
			'streak.lines.month' => 'एक महीने की वफ़ादारी! जो तुम हर दिन बोते हो, वह फल लाता है।',
			'streak.lines.hundred' => 'परमेश्वर के साथ सौ दिन! तुम्हारी लगन एक सुंदर गवाही है।',
			'streak.lines.year' => 'परमेश्वर के साथ पूरा एक साल! तुम्हारी वफ़ादारी के लिए उसकी महिमा हो।',
			'streak.share' => 'शेयर करो',
			'streak.close' => 'आगे बढ़ो',
			'shortcuts.today' => 'अपनी रिपोर्ट भरो',
			'shortcuts.hymns' => 'भजन',
			'shortcuts.retreat' => 'अभी का प्रार्थना-समय',
			'blocking.report' => 'रिपोर्ट करो',
			'blocking.block' => ({required Object name}) => '${name} को ब्लॉक करो',
			'blocking.blockTitle' => ({required Object name}) => '${name} को ब्लॉक करो?',
			'blocking.blockText' => ({required Object name}) => 'तुम्हें ${name} से अब कोई न्योता नहीं मिलेगा। यह न्योता हटा दिया जाएगा।',
			'blocking.blockAction' => 'ब्लॉक करो',
			'blocking.blocked' => ({required Object name}) => '${name} अब तुम्हें न्योता नहीं दे पाएगा।',
			'blocking.reportTitle' => 'इस न्योते की रिपोर्ट करो',
			'blocking.reportText' => 'हमें बताओ क्या गलत है: समुदाय के अगुवे इसे देखेंगे।',
			'blocking.reasons.spam' => 'अनचाहा',
			'blocking.reasons.offensive' => 'चौंकाने वाली या आपत्तिजनक सामग्री',
			'blocking.reasons.other' => 'अन्य',
			'blocking.comment' => 'टिप्पणी',
			'blocking.commentHint' => 'अगुवों को क्या जानना चाहिए',
			'blocking.send' => 'रिपोर्ट भेजो',
			'blocking.reported' => 'धन्यवाद, अगुवे इसे देखेंगे।',
			'blocking.listTitle' => 'ब्लॉक किए गए सदस्य',
			'blocking.intro' => 'उनके प्रार्थना के न्योते अब तुम तक नहीं पहुँचते।',
			'blocking.empty' => 'तुमने किसी को ब्लॉक नहीं किया है।',
			'blocking.unblock' => 'अनब्लॉक करो',
			'blocking.unblocked' => ({required Object name}) => '${name} तुम्हें फिर से न्योता दे सकता है।',
			'verses.title' => 'आज का वचन',
			'verses.share' => 'वचन शेयर करो',
			'verses.shareImage' => 'चित्र शेयर करो',
			'verses.shareText' => 'टेक्स्ट शेयर करो',
			'bible.title' => 'बाइबल',
			'bible.books' => 'पुस्तकें',
			'bible.oldTestament' => 'पुराना नियम',
			'bible.newTestament' => 'नया नियम',
			'bible.chapters' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hi'))(n, one: '${n} अध्याय', other: '${n} अध्याय', ), 
			'bible.chapter' => ({required Object n}) => 'अध्याय ${n}',
			'bible.version' => 'अनुवाद',
			'bible.versions' => 'बाइबल का अनुवाद',
			'bible.search' => 'बाइबल में खोजें',
			'bible.searchHint' => 'कोई शब्द, या “यूहन्ना 3:16”',
			'bible.searchTip' => 'कोई शब्द खोजें (“प्रेम”) या सीधे किसी अंश पर जाएँ (“भजन संहिता 23”, “यूहन्ना 3:16”)।',
			'bible.searchNone' => 'किसी भी पद में ये शब्द नहीं हैं।',
			'bible.searchCount' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hi'))(n, one: '${n} पद', other: '${n} पद', ), 
			'bible.searchLimit' => ({required Object n}) => 'पहले ${n} पद',
			'bible.searchNeedsDownload' => 'पूरी बाइबल में शब्द खोजने के लिए इसे डाउनलोड करें। आप अभी कोई अंश लिख सकते हैं: “यूहन्ना 3:16”।',
			'bible.open' => ({required Object reference}) => '${reference} खोलें',
			'bible.previous' => 'पिछला अध्याय',
			'bible.next' => 'अगला अध्याय',
			'bible.markRead' => 'मैंने यह अध्याय पढ़ लिया',
			'bible.markedRead' => 'आज पढ़ा गया',
			'bible.markReadHint' => 'आपकी रिपोर्ट में “बाइबल पठन” में 1 अध्याय जोड़ता है।',
			'bible.addedToReport' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hi'))(n, one: 'रिपोर्ट: आज ${n} अध्याय पढ़ा', other: 'रिपोर्ट: आज ${n} अध्याय पढ़े', ), 
			'bible.removedFromReport' => 'आपकी रिपोर्ट से हटाया गया',
			'bible.noReadingItem' => 'आपकी रिपोर्ट में “बाइबल पठन” नहीं है।',
			'bible.download' => 'यह बाइबल डाउनलोड करें',
			'bible.downloadHelp' => ({required Object size}) => 'लगभग ${size} MB, बिना नेटवर्क के पढ़ने और खोजने के लिए।',
			'bible.downloading' => ({required Object percent}) => 'डाउनलोड हो रहा है… ${percent}%',
			'bible.downloaded' => 'आपके फ़ोन पर',
			'bible.downloadDone' => ({required Object version}) => '${version} आपके फ़ोन पर है',
			'bible.removeDownload' => 'फ़ोन से हटाएँ',
			'bible.removeDownloadTitle' => ({required Object version}) => '${version} को फ़ोन से हटाएँ?',
			'bible.removeDownloadText' => 'जो अध्याय आप पढ़ चुके हैं, वे बिना नेटवर्क के उपलब्ध रहेंगे।',
			'bible.offline' => 'यह अध्याय अभी आपके फ़ोन पर नहीं है। फिर से ऑनलाइन आएँ, या बिना नेटवर्क के पढ़ने के लिए यह बाइबल डाउनलोड करें।',
			'bible.notInVersion' => 'यह अंश इस अनुवाद में नहीं है।',
			'bible.marks' => 'मेरे पद',
			'bible.favorites' => 'सहेजे गए',
			'bible.highlights' => 'हाइलाइट किए गए',
			'bible.noFavorites' => 'किसी पद को छुएँ, फिर बुकमार्क को, ताकि वह यहाँ मिले।',
			'bible.noHighlights' => 'किसी पद को छुएँ, फिर कोई रंग चुनें, उसे हाइलाइट करने के लिए।',
			'bible.tapHint' => 'किसी पद को हाइलाइट करने, सहेजने, कॉपी करने या साझा करने के लिए उसे छुएँ।',
			'bible.highlight' => ({required Object color}) => '${color} रंग से हाइलाइट करें',
			'bible.colors.yellow' => 'पीले',
			'bible.colors.green' => 'हरे',
			'bible.colors.blue' => 'नीले',
			'bible.colors.pink' => 'गुलाबी',
			'bible.removeHighlight' => 'रंग हटाएँ',
			'bible.addFavorite' => 'मेरे पद में सहेजें',
			'bible.removeFavorite' => 'मेरे पद से हटाएँ',
			'bible.favoriteAdded' => 'मेरे पद में सहेजा गया',
			'bible.favoriteRemoved' => 'मेरे पद से हटाया गया',
			'bible.copy' => 'कॉपी करें',
			'bible.copied' => 'कॉपी हो गया',
			'bible.share' => 'साझा करें',
			'bible.closeSelection' => 'चयन बंद करें',
			'bible.display' => 'प्रदर्शन',
			'bible.jesusInRed' => 'यीशु के वचन लाल रंग में',
			'bible.jesusInRedHelp' => 'उन अनुवादों में जो उन्हें चिह्नित करते हैं',
			'bible.remove' => 'हटाएँ',
			'bible.readInBible' => 'बाइबल में पढ़ें',
			'bible.more' => 'और विकल्प',
			'profilePhoto.title' => 'प्रोफ़ाइल फ़ोटो',
			'profilePhoto.add' => 'प्रोफ़ाइल फ़ोटो जोड़ें',
			'profilePhoto.change' => 'प्रोफ़ाइल फ़ोटो बदलें',
			'profilePhoto.seenBy' => 'जहाँ भी आपका नाम दिखता है, अन्य सदस्य इसे देखते हैं।',
			'profilePhoto.camera' => 'फ़ोटो लें',
			'profilePhoto.gallery' => 'गैलरी से चुनें',
			'profilePhoto.remove' => 'फ़ोटो हटाएँ',
			'profilePhoto.cropTitle' => 'अपनी फ़ोटो काटें',
			'profilePhoto.cropHint' => 'उंगलियों से फ़ोटो को खिसकाएँ और बड़ा करें।',
			'profilePhoto.use' => 'यह फ़ोटो इस्तेमाल करें',
			'profilePhoto.unreadable' => 'यह तस्वीर नहीं खुल सकती। कोई दूसरी चुनें।',
			'profilePhoto.saved' => 'आपकी प्रोफ़ाइल फ़ोटो सहेज ली गई है।',
			'profilePhoto.removed' => 'आपकी प्रोफ़ाइल फ़ोटो हटा दी गई है।',
			'disciples.title' => 'मेरे शिष्य',
			'disciples.empty' => 'अभी कोई शिष्य नहीं',
			'disciples.emptyText' => 'जब कोई सदस्य तुम्हें अपना चेला बनाने वाला या आत्मिक अधिकारी चुनता है और तुम उसका अनुरोध स्वीकार करते हो, तो वह यहाँ दिखता है।',
			'disciples.count' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hi'))(n, other: '${n} शिष्य', ), 
			'disciples.notShared' => 'अपनी रिपोर्ट साझा नहीं करता',
			'disciples.roleMaker' => 'तुम उसके चेला बनाने वाले हो',
			'disciples.roleAuthority' => 'तुम उसके आत्मिक अधिकारियों में से एक हो',
			'disciples.dayGoals' => ({required Object percent}) => 'लक्ष्य ${percent} %',
			'disciples.dayItems' => ({required Object total, required Object filled, required Object percent}) => '${total} में से ${filled} आइटम · ${percent} %',
			'disciples.older' => 'पिछले 30 दिन देखो',
			'disciples.noReports' => 'इस अवधि में कोई रिपोर्ट नहीं।',
			'disciples.searchHint' => 'नाम या यूज़रनेम',
			'disciples.noMatch' => ({required Object search}) => '“${search}” से कोई शिष्य मेल नहीं खाता।',
			'weekStory.title' => 'परमेश्वर के साथ तुम्हारा हफ़्ता',
			'weekStory.range' => ({required Object from, required Object to}) => '${from} से ${to} तक',
			'weekStory.intro' => 'इस हफ़्ते प्रभु के साथ जो जिया, उसे फिर से देखो।',
			'weekStory.tapHint' => 'आगे जाने के लिए दाईं ओर, वापस आने के लिए बाईं ओर छुओ।',
			'weekStory.faithfulLead' => 'तुम वफ़ादार रहे',
			'weekStory.emptyLead' => 'एक नया हफ़्ता तुम्हारा इंतज़ार कर रहा है',
			'weekStory.days' => ({required num n, required Object total}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hi'))(n, one: '${total} में से\n${n} दिन', other: '${total} में से\n${n} दिन', ), 
			'weekStory.streak' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hi'))(n, one: 'लगातार ${n} दिन', other: 'लगातार ${n} दिन', ), 
			'weekStory.streakRecord' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hi'))(n, one: 'लगातार ${n} दिन: तुम्हारा रिकॉर्ड!', other: 'लगातार ${n} दिन: तुम्हारा रिकॉर्ड!', ), 
			'weekStory.emptyText' => 'हर दिन अपनी रिपोर्ट भरो: तुम्हारा अगला हफ़्ता यहाँ लिखा जाएगा।',
			'weekStory.prayerLead' => 'तुमने प्रार्थना की',
			'weekStory.retreats' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hi'))(n, one: '${n} प्रार्थना-समय', other: '${n} प्रार्थना-समय', ), 
			'weekStory.retreatsTime' => ({required Object time}) => '15 मिनट के · प्रभु के साथ ${time}',
			'weekStory.faithfulMoment' => ({required num n, required Object moment}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hi'))(n, one: 'तुम्हारा सबसे वफ़ादार समय: ${moment} (${n} बार)', other: 'तुम्हारा सबसे वफ़ादार समय: ${moment} (${n} बार)', ), 
			'weekStory.noRetreat' => 'इस हफ़्ते कोई प्रार्थना-समय नहीं',
			'weekStory.noRetreatText' => 'दोपहर का प्रार्थना-समय तुम्हारा इंतज़ार कर रहा है: प्रभु के साथ 15 मिनट।',
			'weekStory.goalsLead' => 'तुम्हारे लक्ष्य',
			'weekStory.goalsReached' => 'औसतन पूरे हुए',
			'weekStory.bestDay' => ({required Object day, required Object percent}) => 'तुम्हारा सबसे अच्छा दिन: ${day} · ${percent}',
			'weekStory.summaryTitle' => 'परमेश्वर के साथ मेरा हफ़्ता',
			'weekStory.statDays' => 'दिन भरे गए',
			'weekStory.statStreak' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hi'))(n, one: 'दिन लगातार', other: 'दिन लगातार', ), 
			'weekStory.statRetreats' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('hi'))(n, one: 'प्रार्थना-समय', other: 'प्रार्थना-समय', ), 
			'weekStory.statGoals' => 'लक्ष्य',
			'weekStory.share' => 'अपना हफ़्ता साझा करो',
			'weekStory.homeText' => 'इस हफ़्ते की तुम्हारी वफ़ादारी, प्रार्थना और लक्ष्य।',
			'weekStory.open' => 'मेरा हफ़्ता देखो',
			'weekStory.notificationTitle' => 'परमेश्वर के साथ तुम्हारा हफ़्ता तैयार है',
			'weekStory.notificationBody' => 'इस हफ़्ते की अपनी वफ़ादारी फिर से देखो और साझा करो।',
			'weekStory.channel' => 'परमेश्वर के साथ तुम्हारा हफ़्ता',
			'weekStory.thisWeek' => 'यह हफ़्ता',
			'weekStory.pastWeeks' => 'पिछले हफ़्ते',
			'weekStory.weekOf' => ({required Object date}) => '${date} का हफ़्ता',
			'weekStory.page' => ({required Object total, required Object current}) => '${total} में से ${current}',
			_ => null,
		};
	}
}
