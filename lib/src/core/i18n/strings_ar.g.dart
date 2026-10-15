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
class TranslationsAr extends Translations with BaseTranslations<AppLocale, Translations> {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsAr({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  _meta = meta ?? TranslationMetadata(
		    locale: AppLocale.ar,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ),
		  super(cardinalResolver: cardinalResolver, ordinalResolver: ordinalResolver) {
		_meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <ar>.
	final TranslationMetadata<AppLocale, Translations> _meta;
	@override TranslationMetadata<AppLocale, Translations> get $meta => _meta;

	/// Access flat map
	@override dynamic operator[](String key) => _meta.getTranslation(key) ?? super[key];

	late final TranslationsAr _root = this; // ignore: unused_field

	@override 
	TranslationsAr $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsAr(meta: meta ?? this.$meta);

	// Translations
	@override late final _Translations$app$ar app = _Translations$app$ar._(_root);
	@override late final _Translations$common$ar common = _Translations$common$ar._(_root);
	@override late final _Translations$errors$ar errors = _Translations$errors$ar._(_root);
	@override late final _Translations$validation$ar validation = _Translations$validation$ar._(_root);
	@override late final _Translations$onboarding$ar onboarding = _Translations$onboarding$ar._(_root);
	@override late final _Translations$welcome$ar welcome = _Translations$welcome$ar._(_root);
	@override late final _Translations$auth$ar auth = _Translations$auth$ar._(_root);
	@override late final _Translations$countries$ar countries = _Translations$countries$ar._(_root);
	@override late final _Translations$nav$ar nav = _Translations$nav$ar._(_root);
	@override late final _Translations$home$ar home = _Translations$home$ar._(_root);
	@override late final _Translations$reports$ar reports = _Translations$reports$ar._(_root);
	@override late final _Translations$reminder$ar reminder = _Translations$reminder$ar._(_root);
	@override late final _Translations$export$ar export = _Translations$export$ar._(_root);
	@override late final _Translations$items$ar items = _Translations$items$ar._(_root);
	@override late final _Translations$newItem$ar newItem = _Translations$newItem$ar._(_root);
	@override late final _Translations$more$ar more = _Translations$more$ar._(_root);
	@override late final _Translations$authorities$ar authorities = _Translations$authorities$ar._(_root);
	@override late final _Translations$members$ar members = _Translations$members$ar._(_root);
	@override late final _Translations$admin$ar admin = _Translations$admin$ar._(_root);
	@override late final _Translations$hymns$ar hymns = _Translations$hymns$ar._(_root);
	@override late final _Translations$comingSoon$ar comingSoon = _Translations$comingSoon$ar._(_root);
	@override late final _Translations$events$ar events = _Translations$events$ar._(_root);
	@override late final _Translations$notifications$ar notifications = _Translations$notifications$ar._(_root);
	@override late final _Translations$premium$ar premium = _Translations$premium$ar._(_root);
	@override late final _Translations$homeWidget$ar homeWidget = _Translations$homeWidget$ar._(_root);
	@override late final _Translations$ministry$ar ministry = _Translations$ministry$ar._(_root);
	@override late final _Translations$prayer$ar prayer = _Translations$prayer$ar._(_root);
	@override late final _Translations$sending$ar sending = _Translations$sending$ar._(_root);
	@override late final _Translations$streak$ar streak = _Translations$streak$ar._(_root);
	@override late final _Translations$shortcuts$ar shortcuts = _Translations$shortcuts$ar._(_root);
	@override late final _Translations$blocking$ar blocking = _Translations$blocking$ar._(_root);
	@override late final _Translations$verses$ar verses = _Translations$verses$ar._(_root);
	@override late final _Translations$bible$ar bible = _Translations$bible$ar._(_root);
	@override late final _Translations$profilePhoto$ar profilePhoto = _Translations$profilePhoto$ar._(_root);
	@override late final _Translations$disciples$ar disciples = _Translations$disciples$ar._(_root);
	@override late final _Translations$weekStory$ar weekStory = _Translations$weekStory$ar._(_root);
}

// Path: app
class _Translations$app$ar extends Translations$app$fr {
	_Translations$app$ar._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get name => 'CMFI Connect';
	@override String get tagline => 'ننمو معًا، كل يوم.';
	@override String get languageName => 'العربية';
}

// Path: common
class _Translations$common$ar extends Translations$common$fr {
	_Translations$common$ar._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get retry => 'إعادة المحاولة';
	@override String get cancel => 'إلغاء';
	@override String get save => 'حفظ';
	@override String get close => 'إغلاق';
	@override String get back => 'رجوع';
	@override String get soon => 'قريبًا';
	@override String get optional => '(اختياري)';
	@override String get and => 'و';
	@override String get loading => 'جارٍ التحميل…';
	@override String get done => 'تم';
	@override String get rangeStart => 'من';
	@override String get rangeEnd => 'إلى';
}

// Path: errors
class _Translations$errors$ar extends Translations$errors$fr {
	_Translations$errors$ar._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get network => 'لا يوجد اتصال بالإنترنت. تحقّق من شبكتك وحاول مجددًا.';
	@override String get unauthorized => 'انتهت صلاحية جلستك. سجّل الدخول مجددًا.';
	@override String get invalidCredentials => 'رقم الهاتف أو كلمة المرور غير صحيحة.';
	@override String get badRequest => 'بعض المعلومات غير صالحة.';
	@override String get conflict => 'هذا العنصر موجود بالفعل.';
	@override String get notFound => 'العنصر غير موجود.';
	@override String get server => 'واجه الخادم مشكلة. حاول مجددًا بعد قليل.';
	@override String get unknown => 'حدث خطأ. حاول مجددًا.';
	@override String get forbidden => 'ليست لديك صلاحية للقيام بذلك.';
	@override String get eventFull => 'لم يعد هناك مكان متاح في هذه الفعالية.';
	@override String get registrationClosed => 'التسجيل في هذه الفعالية مغلق.';
	@override String get mediaTooLarge => 'حجم هذه الصورة كبير جدًا (8 ميغابايت كحدّ أقصى).';
	@override String get mediaUnsupported => 'اختر صورة بصيغة JPEG أو PNG.';
	@override String get notParticipant => 'انضمّ أولًا إلى هذا الطلب لتُحتسب إعلاناتك.';
	@override String get importunityClosed => 'هذا الطلب مُغلق: لم يعد يحتسب الإعلانات.';
	@override String get usernameNotFound => 'لا أحد يحمل اسم المستخدم هذا. تحقّق من كتابته.';
	@override String get ownerCannotLeave => 'أنت من أنشأ هذا الطلب: احذفه بدلًا من الانسحاب منه.';
	@override String get tooManyPeople => 'قوائمك ممتلئة (500 شخص كحدّ أقصى).';
	@override String get avatarInvalid => 'لا يمكن استخدام هذه الصورة. اختر صورة أخرى.';
	@override String get reportsNotShared => 'لم يعد هذا العضو يشارك تقاريره.';
}

// Path: validation
class _Translations$validation$ar extends Translations$validation$fr {
	_Translations$validation$ar._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get required => 'هذا الحقل مطلوب';
	@override String get passwordTooShort => '6 أحرف على الأقل';
	@override String get invalidPhone => 'رقم هاتف غير صالح';
	@override String get invalidEmail => 'عنوان بريد إلكتروني غير صالح';
	@override String get invalidCode => 'أحرف وأرقام فقط، دون مسافات';
}

// Path: onboarding
class _Translations$onboarding$ar extends Translations$onboarding$fr {
	_Translations$onboarding$ar._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get skip => 'تخطٍّ';
	@override String get next => 'التالي';
	@override String get start => 'ابدأ';
	@override String step({required Object current, required Object total}) => 'الشاشة ${current} من ${total}';
	@override late final _Translations$onboarding$reports$ar reports = _Translations$onboarding$reports$ar._(_root);
	@override late final _Translations$onboarding$worship$ar worship = _Translations$onboarding$worship$ar._(_root);
	@override late final _Translations$onboarding$community$ar community = _Translations$onboarding$community$ar._(_root);
	@override late final _Translations$onboarding$sample$ar sample = _Translations$onboarding$sample$ar._(_root);
}

// Path: welcome
class _Translations$welcome$ar extends Translations$welcome$fr {
	_Translations$welcome$ar._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'مرحبًا بك في CMFI Connect';
	@override String get text => 'أنشئ حسابك في دقيقة واحدة لتملأ تقريرك اليومي وتتابع حياة مجتمعك.';
	@override String get createAccount => 'إنشاء حسابي';
	@override String get haveAccount => 'لديّ حساب بالفعل';
}

// Path: auth
class _Translations$auth$ar extends Translations$auth$fr {
	_Translations$auth$ar._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get phone => 'الهاتف';
	@override String dialCode({required Object code}) => 'رمز الدولة: ${code}';
	@override String get password => 'كلمة المرور';
	@override String get showPassword => 'إظهار كلمة المرور';
	@override String get hidePassword => 'إخفاء كلمة المرور';
	@override late final _Translations$auth$login$ar login = _Translations$auth$login$ar._(_root);
	@override late final _Translations$auth$register$ar register = _Translations$auth$register$ar._(_root);
	@override late final _Translations$auth$church$ar church = _Translations$auth$church$ar._(_root);
	@override late final _Translations$auth$forgot$ar forgot = _Translations$auth$forgot$ar._(_root);
}

// Path: countries
class _Translations$countries$ar extends Translations$countries$fr {
	_Translations$countries$ar._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get dialCodeTitle => 'رمز الدولة';
	@override String get title => 'بلدك';
	@override String get search => 'ابحث عن دولة أو رمز';
	@override String get none => 'لا توجد دولة مطابقة';
	@override String get change => 'تغيير الدولة';
}

// Path: nav
class _Translations$nav$ar extends Translations$nav$fr {
	_Translations$nav$ar._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get home => 'الرئيسية';
	@override String get reports => 'التقرير';
	@override String get hymns => 'الترانيم';
	@override String get prayer => 'الصلاة';
	@override String get bible => 'الكتاب المقدس';
}

// Path: home
class _Translations$home$ar extends Translations$home$fr {
	_Translations$home$ar._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String greeting({required Object name}) => 'مرحبًا ${name}';
	@override String get greetingNoName => 'مرحبًا';
	@override String get profile => 'ملفي الشخصي';
	@override String get todayTitle => 'تقرير اليوم';
	@override String progress({required Object filled, required Object total}) => '${filled} من ${total}';
	@override String get progressLabel => 'عناصر معبّأة';
	@override String get goals => 'الأهداف';
	@override String get continueReport => 'متابعة';
	@override String get startReport => 'ابدأ';
	@override String get weekTitle => 'أسبوعك';
	@override String weekScore({required num filled, required Object total}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(filled,
		zero: '${filled} يوم من ${total}',
		one: 'يوم واحد من ${total}',
		two: 'يومان من ${total}',
		few: '${filled} أيام من ${total}',
		many: '${filled} يومًا من ${total}',
		other: '${filled} يوم من ${total}',
	);
	@override String get community => 'حاليًا في CMFI';
	@override String get eventsTitle => 'الفعاليات';
	@override String get hymnsTitle => 'الترانيم';
	@override String hymnsResume({required Object number}) => 'العودة إلى رقم ${number}';
	@override String get hymnsOpen => 'فتح كتاب الترانيم';
	@override String streak({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(n,
		zero: '${n} يوم على التوالي',
		one: 'يوم واحد على التوالي',
		two: 'يومان على التوالي',
		few: '${n} أيام على التوالي',
		many: '${n} يومًا على التوالي',
		other: '${n} يوم على التوالي',
	);
	@override String get streakKeep => 'املأ تقرير اليوم لتواصل';
	@override String get streakToday => 'أحسنت، تابع غدًا!';
}

// Path: reports
class _Translations$reports$ar extends Translations$reports$fr {
	_Translations$reports$ar._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'التقرير';
	@override String get myItems => 'عناصري';
	@override late final _Translations$reports$tabs$ar tabs = _Translations$reports$tabs$ar._(_root);
	@override String get pickDay => 'اختر اليوم';
	@override String filled({required Object filled, required Object total}) => 'تمت تعبئة ${filled} من ${total}';
	@override String get statusSaved => 'تم الحفظ';
	@override String get statusModified => 'غير محفوظ';
	@override String get standard => 'الأساسية';
	@override String get personal => 'عناصري';
	@override String get createItem => 'إنشاء عنصر';
	@override String add({required Object label}) => 'إضافة ${label}';
	@override String get note => 'ملاحظة اليوم';
	@override String get noteHint => 'آية، سبب للشكر…';
	@override String get save => 'حفظ اليوم';
	@override String get saved => 'تم حفظ اليوم';
	@override late final _Translations$reports$measure$ar measure = _Translations$reports$measure$ar._(_root);
	@override String times({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(n,
		zero: '${n} مرة',
		one: 'مرة واحدة',
		two: 'مرتان',
		few: '${n} مرات',
		many: '${n} مرة',
		other: '${n} مرة',
	);
	@override late final _Translations$reports$sheet$ar sheet = _Translations$reports$sheet$ar._(_root);
	@override late final _Translations$reports$history$ar history = _Translations$reports$history$ar._(_root);
	@override late final _Translations$reports$summary$ar summary = _Translations$reports$summary$ar._(_root);
	@override String get noItems => 'لا توجد عناصر لتعبئتها حاليًا.';
	@override String get statusPending => 'لم يُرسَل بعد';
	@override String get savedOffline => 'لا توجد شبكة: اليوم محفوظ على هاتفك وسيُرسَل في أقرب وقت ممكن.';
	@override String pendingBanner({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(n,
		zero: '${n} يوم بانتظار الشبكة لإرساله',
		one: 'يوم واحد بانتظار الشبكة لإرساله',
		two: 'يومان بانتظار الشبكة لإرسالهما',
		few: '${n} أيام بانتظار الشبكة لإرسالها',
		many: '${n} يومًا بانتظار الشبكة لإرسالها',
		other: '${n} يوم بانتظار الشبكة لإرسالها',
	);
	@override String get export => 'تصدير تقريري';
	@override String goal({required Object value}) => 'الهدف: ${value}';
	@override String get goalReached => 'تحقّق الهدف';
	@override String get dayGoals => 'أهداف اليوم';
	@override String goalsReached({required Object reached, required Object total}) => 'المحقَّقة: ${reached} من ${total}';
	@override late final _Translations$reports$standardItems$ar standardItems = _Translations$reports$standardItems$ar._(_root);
	@override late final _Translations$reports$units$ar units = _Translations$reports$units$ar._(_root);
}

// Path: reminder
class _Translations$reminder$ar extends Translations$reminder$fr {
	_Translations$reminder$ar._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'تقريرك لهذا اليوم';
	@override String get body => 'خصّص دقيقة لتسجّل قراءتك وصلاتك… قبل نهاية اليوم.';
	@override String get channel => 'تذكير التقرير';
	@override String get settings => 'تذكير المساء';
	@override String get off => 'معطّل';
	@override String get switchLabel => 'ذكّرني بملء يومي';
	@override String get switchHint => 'فقط إذا لم تملأ يومك بعد.';
	@override String get time => 'وقت التذكير';
	@override String get offerTitle => 'تذكير كل مساء؟';
	@override String get offerText => 'إذا لم تملأ يومك بعد، يذكّرك التطبيق في الوقت الذي تختاره. ولا شيء إن كنت قد ملأته.';
	@override String get offerAccept => 'تفعيل التذكير';
	@override String get offerLater => 'لاحقًا';
	@override String enabled({required Object time}) => 'تم ضبط التذكير على ${time}';
	@override String get denied => 'الإشعارات محظورة لتطبيق CMFI Connect. اسمح بها من إعدادات الهاتف.';
}

// Path: export
class _Translations$export$ar extends Translations$export$fr {
	_Translations$export$ar._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'تصدير';
	@override String get period => 'الفترة';
	@override String get thisWeek => 'هذا الأسبوع';
	@override String get lastWeek => 'الأسبوع الماضي';
	@override String get thisMonth => 'هذا الشهر';
	@override String get lastMonth => 'الشهر الماضي';
	@override String get thisYear => 'هذه السنة';
	@override String get custom => 'تواريخ أخرى';
	@override String get customPick => 'اختر التواريخ';
	@override String get format => 'الصيغة';
	@override String get pdf => 'PDF';
	@override String get pdfHint => 'مستند لإرساله أو طباعته';
	@override String get csv => 'جدول بيانات';
	@override String get csvHint => 'ملف CSV لبرنامج Excel أو Google Sheets';
	@override String get text => 'رسالة';
	@override String get textHint => 'ملخص تلصقه في WhatsApp';
	@override String get button => 'تصدير';
	@override String get shareButton => 'مشاركة';
	@override String preview({required num filled, required Object total, required Object items}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(filled,
		zero: 'تمت تعبئة ${filled} يوم من ${total} · ${items}',
		one: 'تمت تعبئة يوم واحد من ${total} · ${items}',
		two: 'تمت تعبئة يومين من ${total} · ${items}',
		few: 'تمت تعبئة ${filled} أيام من ${total} · ${items}',
		many: 'تمت تعبئة ${filled} يومًا من ${total} · ${items}',
		other: 'تمت تعبئة ${filled} يوم من ${total} · ${items}',
	);
	@override String previewItems({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(n,
		zero: '${n} عنصر',
		one: 'عنصر واحد',
		two: 'عنصران',
		few: '${n} عناصر',
		many: '${n} عنصرًا',
		other: '${n} عنصر',
	);
	@override String get empty => 'لا توجد تقارير في هذه الفترة.';
	@override String get tooLong => 'اختر 366 يومًا كحدّ أقصى.';
	@override String get fileName => 'تقرير';
	@override String subject({required Object period}) => 'تقريري، ${period}';
	@override late final _Translations$export$doc$ar doc = _Translations$export$doc$ar._(_root);
}

// Path: items
class _Translations$items$ar extends Translations$items$fr {
	_Translations$items$ar._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'عناصري';
	@override String get standardSection => 'الأساسية · للجميع';
	@override String get personalSection => 'عناصري الشخصية';
	@override String get emptyPersonal => 'ليس لديك أي عنصر شخصي بعد.';
	@override String get archive => 'أرشفة';
	@override String archiveTitle({required Object code}) => 'أرشفة ${code}؟';
	@override String get archiveText => 'لن يُعرض بعد الآن في تقريرك. تبقى أرقامه في سجلك.';
	@override String archived({required Object code}) => 'تمت أرشفة ${code}';
	@override String get create => 'إنشاء عنصر';
	@override String get footnote => 'العنصر المؤرشف لا يُعرض بعد الآن في تقريرك، لكن أرقامه تبقى في سجلك.';
	@override late final _Translations$items$measure$ar measure = _Translations$items$measure$ar._(_root);
	@override String get goalAdd => 'إضافة هدف';
	@override String goal({required Object value}) => 'الهدف: ${value} يوميًا';
	@override String get goalTitle => 'الهدف اليومي';
	@override String get goalHint => 'ما تسعى إليه كل يوم. يبقى على هاتفك.';
	@override String get goalRemove => 'إزالة';
	@override String get goalSaved => 'تم حفظ الهدف';
	@override String get goalRemoved => 'تمت إزالة الهدف';
}

// Path: newItem
class _Translations$newItem$ar extends Translations$newItem$fr {
	_Translations$newItem$ar._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'عنصر جديد';
	@override String get code => 'الرمز';
	@override String get label => 'الاسم';
	@override String get help => 'أحرف وأرقام، 20 كحدّ أقصى. رمز العنصر الأساسي (LB، PS…) غير متاح.';
	@override String get measures => 'ما تقيسه';
	@override String get quantity => 'كمية';
	@override String get quantityHint => 'إصحاحات، صفحات، أشخاص…';
	@override String get unit => 'الوحدة المعروضة بعد الرقم';
	@override String get unitHint => 'أشخاص';
	@override String get duration => 'مدة';
	@override String get durationHint => 'بالساعات والدقائق';
	@override String get noMeasure => 'اختر مقياسًا واحدًا على الأقل: كمية، أو مدة، أو كليهما.';
	@override String get preview => 'معاينة في تقريرك';
	@override String get previewCode => 'رمز';
	@override String get previewLabel => 'اسم العنصر';
	@override String get submit => 'إنشاء العنصر';
	@override String created({required Object code}) => 'تم إنشاء ${code}.';
	@override String get codeTaken => 'هذا الرمز مستخدم بالفعل، لعنصر أساسي أو لأحد عناصرك (حتى المؤرشفة).';
	@override String get codeHint => 'EVG';
	@override String get labelHint => 'التبشير';
}

// Path: more
class _Translations$more$ar extends Translations$more$fr {
	_Translations$more$ar._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'المزيد';
	@override String get editProfile => 'تعديل ملفي الشخصي';
	@override String get community => 'المجتمع';
	@override String get events => 'الفعاليات';
	@override String get reports => 'التقرير';
	@override String get myItems => 'عناصري';
	@override String get app => 'التطبيق';
	@override String get language => 'اللغة';
	@override String get appearance => 'المظهر';
	@override String get themeSystem => 'تلقائي';
	@override String get themeSystemHint => 'في الوضع التلقائي، يتبع التطبيق إعداد الهاتف الفاتح أو الداكن.';
	@override String get themeLight => 'فاتح';
	@override String get themeDark => 'داكن';
	@override String get logout => 'تسجيل الخروج';
	@override String get account => 'الحساب';
	@override String get languageTitle => 'لغة التطبيق';
	@override String get completeProfile => 'أضف اسمك';
	@override String get accompaniment => 'المرافقة الروحية';
	@override String get exportReport => 'تصدير تقريري';
	@override String get logoutPendingTitle => 'أيام لم تُرسَل بعد';
	@override String logoutPendingText({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(n,
		zero: '${n} يوم محفوظ دون شبكة لم يُرسَل بعد. إذا سجّلت الخروج الآن، فسيضيع.',
		one: 'يوم واحد محفوظ دون شبكة لم يُرسَل بعد. إذا سجّلت الخروج الآن، فسيضيع.',
		two: 'يومان محفوظان دون شبكة لم يُرسَلا بعد. إذا سجّلت الخروج الآن، فسيضيعان.',
		few: '${n} أيام محفوظة دون شبكة لم تُرسَل بعد. إذا سجّلت الخروج الآن، فستضيع.',
		many: '${n} يومًا محفوظًا دون شبكة لم تُرسَل بعد. إذا سجّلت الخروج الآن، فستضيع.',
		other: '${n} يوم محفوظ دون شبكة لم تُرسَل بعد. إذا سجّلت الخروج الآن، فستضيع.',
	);
	@override String get logoutAnyway => 'تسجيل الخروج';
	@override String get admin => 'الإدارة';
	@override String get staff => 'الفريق والأدوار';
	@override String get manageEvents => 'الفعاليات';
	@override String get disciples => 'تلاميذي';
}

// Path: authorities
class _Translations$authorities$ar extends Translations$authorities$fr {
	_Translations$authorities$ar._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'مرشديّ الروحيون';
	@override String get intro => 'الأشخاص الذين يرافقونك في مسيرتك مع الله: صانع التلاميذ الخاص بك وسائر مرشديك.';
	@override String get discipleMaker => 'صانع التلاميذ';
	@override String discipleMakerOf({required Object name}) => 'صانع التلاميذ: ${name}';
	@override String get noDiscipleMaker => 'لا يوجد صانع تلاميذ بعد';
	@override String get others => 'مرشدون آخرون';
	@override String get empty => 'لم تُضِف أحدًا بعد.';
	@override String get add => 'إضافة مرشد';
	@override String get remove => 'إزالة';
	@override String removeTitle({required Object name}) => 'إزالة ${name}؟';
	@override String removeText({required Object name}) => 'لن يكون ${name} بعد الآن ضمن مرشديك الروحيين.';
	@override String removed({required Object name}) => 'لم يعد ${name} ضمن مرشديك.';
	@override String count({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(n,
		zero: 'لا أحد حتى الآن',
		one: 'شخص واحد',
		two: 'شخصان',
		few: '${n} أشخاص',
		many: '${n} شخصًا',
		other: '${n} شخص',
	);
	@override late final _Translations$authorities$form$ar form = _Translations$authorities$form$ar._(_root);
	@override String get statusPending => 'قيد الانتظار';
	@override String get statusDeclined => 'مرفوض';
	@override String pendingHelp({required Object name}) => 'ستظهر بيانات الاتصال بعد أن يقبل ${name}.';
	@override String get requests => 'الطلبات الواردة';
	@override String get requestDiscipleMaker => 'يطلب منك أن تكون صانع التلاميذ الخاص به';
	@override String get requestAuthority => 'يطلب منك أن ترافقه';
	@override String get accept => 'قبول';
	@override String get decline => 'رفض';
	@override String acceptedRequest({required Object name}) => 'أنت ترافق ${name} الآن.';
	@override String declinedRequest({required Object name}) => 'تم رفض طلب ${name}.';
	@override String requestsCount({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(n,
		zero: '${n} طلب بانتظارك',
		one: 'طلب واحد بانتظارك',
		two: 'طلبان بانتظارك',
		few: '${n} طلبات بانتظارك',
		many: '${n} طلبًا بانتظارك',
		other: '${n} طلب بانتظارك',
	);
	@override late final _Translations$authorities$sharing$ar sharing = _Translations$authorities$sharing$ar._(_root);
}

// Path: members
class _Translations$members$ar extends Translations$members$fr {
	_Translations$members$ar._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get username => 'اسم المستخدم';
	@override String get usernameHint => 'firstname.lastname';
	@override String get usernameHelp => 'بهذا الاسم سيجدك الأعضاء الآخرون.';
	@override String get usernameChecking => 'جارٍ التحقق…';
	@override String usernameFree({required Object username}) => '@${username} متاح';
	@override String get usernameCurrent => 'هذا اسم المستخدم الحالي الخاص بك';
	@override String get usernameTaken => 'اسم المستخدم هذا مأخوذ بالفعل.';
	@override String get usernameInvalid => 'من 3 إلى 30 حرفًا: أحرف وأرقام و«.» و«_»، دون أن يبدأ أو ينتهي برمز.';
	@override String get usernameReserved => 'اسم المستخدم هذا محجوز.';
	@override String usernameSaved({required Object username}) => 'تم حفظ اسم المستخدم: @${username}';
	@override late final _Translations$members$deleteAccount$ar deleteAccount = _Translations$members$deleteAccount$ar._(_root);
}

// Path: admin
class _Translations$admin$ar extends Translations$admin$fr {
	_Translations$admin$ar._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'الفريق والأدوار';
	@override String get intro => 'يدير المشرفون ما يتشاركه المجتمع بأكمله. وحده المشرف العام يمنح دورًا أو يسحبه.';
	@override String get roleUser => 'عضو';
	@override String get roleAdmin => 'مشرف';
	@override String get roleSuperadmin => 'مشرف عام';
	@override String get giveRole => 'منح دور';
	@override String get you => 'أنت';
	@override String roleFor({required Object username}) => 'دور @${username}';
	@override String roleChanged({required Object username, required Object role}) => '@${username}: ${role}';
	@override String get memberUsername => 'اسم مستخدم العضو';
	@override String get empty => 'لا يوجد مشرفون حتى الآن.';
}

// Path: hymns
class _Translations$hymns$ar extends Translations$hymns$fr {
	_Translations$hymns$ar._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get searchHint => 'الرقم أو العنوان أو الكلمات';
	@override String get openNumber => 'الانتقال إلى رقم';
	@override late final _Translations$hymns$tabs$ar tabs = _Translations$hymns$tabs$ar._(_root);
	@override String get chooseBook => 'اختر كتاب الترانيم';
	@override String count({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(n,
		zero: '${n} ترنيمة',
		one: 'ترنيمة واحدة',
		two: 'ترنيمتان',
		few: '${n} ترانيم',
		many: '${n} ترنيمة',
		other: '${n} ترنيمة',
	);
	@override String number({required Object number}) => 'رقم ${number}';
	@override String get emptyFavorites => 'المس النجمة بجانب أي ترنيمة لتجدها هنا.';
	@override String get emptyRecent => 'ستظهر هنا الترانيم التي تفتحها.';
	@override String noResult({required Object query}) => 'لا توجد ترنيمة تطابق «${query}».';
	@override String get otherBooks => 'في كتب الترانيم الأخرى';
	@override String get upToDate => 'كتب الترانيم محدّثة.';
	@override String get updated => 'تم تحديث كتب الترانيم.';
	@override String get chorus => 'القرار';
	@override String chorusNumber({required Object label}) => 'القرار ${label}';
	@override String verse({required Object label}) => 'المقطع ${label}';
	@override String times({required Object n}) => '×${n}';
	@override String get loadFailed => 'تعذّر فتح كتب الترانيم.';
	@override late final _Translations$hymns$reader$ar reader = _Translations$hymns$reader$ar._(_root);
	@override late final _Translations$hymns$projection$ar projection = _Translations$hymns$projection$ar._(_root);
	@override late final _Translations$hymns$pad$ar pad = _Translations$hymns$pad$ar._(_root);
}

// Path: comingSoon
class _Translations$comingSoon$ar extends Translations$comingSoon$fr {
	_Translations$comingSoon$ar._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get badge => 'قريبًا';
	@override String get backHome => 'العودة إلى الرئيسية';
}

// Path: events
class _Translations$events$ar extends Translations$events$fr {
	_Translations$events$ar._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'الفعاليات';
	@override String get featured => 'مميّز';
	@override String get upcoming => 'القادمة';
	@override String get past => 'الدورات السابقة';
	@override String get emptyTitle => 'لا توجد فعاليات قادمة';
	@override String get emptyText => 'ستظهر هنا مؤتمرات المجتمع بأكمله ولقاءاته، مع برامجها.';
	@override String get manage => 'إدارة الفعاليات';
	@override String get next => 'الفعالية القادمة';
	@override String get seeAll => 'كل الفعاليات';
	@override String get homeText => 'لقاءات المجتمع وبرامجها وأخبارها.';
	@override String get today => 'اليوم';
	@override String get tomorrow => 'غدًا';
	@override String inDays({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(n,
		zero: 'اليوم',
		one: 'بعد يوم واحد',
		two: 'بعد يومين',
		few: 'بعد ${n} أيام',
		many: 'بعد ${n} يومًا',
		other: 'بعد ${n} يوم',
	);
	@override String daysLeft({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(n,
		zero: 'اليوم',
		one: 'يوم واحد',
		two: 'يومان',
		few: '${n} أيام',
		many: '${n} يومًا',
		other: '${n} يوم',
	);
	@override String get onNow => 'جارية الآن';
	@override String get over => 'انتهت';
	@override String get cancelled => 'ملغاة';
	@override String get draft => 'مسودة';
	@override String get registered => 'مسجَّل';
	@override String get stateOpen => 'التسجيل مفتوح';
	@override String get stateClosed => 'التسجيل مغلق';
	@override String get stateFull => 'مكتمل العدد';
	@override String registrations({required num n, required Object count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(n,
		zero: 'كن أول من يسجّل',
		one: 'مسجَّل واحد',
		two: 'مسجَّلان',
		few: '${count} مسجَّلين',
		many: '${count} مسجَّلًا',
		other: '${count} مسجَّل',
	);
	@override String people({required num n, required Object count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(n,
		zero: '${count} شخص',
		one: 'شخص واحد',
		two: 'شخصان',
		few: '${count} أشخاص',
		many: '${count} شخصًا',
		other: '${count} شخص',
	);
	@override String placesLeft({required num n, required Object count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(n,
		zero: 'لم يبقَ أي مكان',
		one: 'بقي مكان واحد',
		two: 'بقي مكانان',
		few: 'بقي ${count} أماكن',
		many: 'بقي ${count} مكانًا',
		other: 'بقي ${count} مكان',
	);
	@override String oneDay({required Object start, required Object end}) => 'من ${start} إلى ${end}';
	@override String severalDays({required Object startDay, required Object start, required Object endDay, required Object end}) => 'الافتتاح يوم ${startDay} الساعة ${start}، والختام يوم ${endDay} الساعة ${end}';
	@override String venueTime({required Object place}) => 'بتوقيت ${place}';
	@override String get addToCalendar => 'إضافة إلى التقويم';
	@override String get share => 'مشاركة';
	@override String get directions => 'الاتجاهات';
	@override String get viewPoster => 'عرض الملصق';
	@override late final _Translations$events$tabs$ar tabs = _Translations$events$tabs$ar._(_root);
	@override String get noProgram => 'سيُنشر البرنامج قريبًا.';
	@override String get noNews => 'لا توجد أخبار عن هذه الفعالية بعد.';
	@override String get pinned => 'مثبّت';
	@override String get now => 'يجري الآن';
	@override String hymn({required Object number}) => 'ترنيمة ${number}';
	@override String get about => 'نبذة';
	@override String get fees => 'رسوم المشاركة';
	@override String deadline({required Object date}) => 'التسجيل حتى ${date}';
	@override String get contact => 'للتواصل';
	@override String call({required Object name}) => 'اتصل بـ${name}';
	@override String get otherEditions => 'الدورات الأخرى';
	@override String get cancelledBanner => 'تم إلغاء هذه الفعالية.';
	@override String get calendarFailed => 'تعذّر فتح تقويم الهاتف.';
	@override String get linkFailed => 'تعذّر فتح هذا الرابط.';
	@override String shareText({required Object title, required Object dates, required Object place}) => '${title}\n${dates} · ${place}\nسجّل في تطبيق CMFI Connect.';
	@override String get full => 'لم يعد هناك مكان متاح في هذه الفعالية.';
	@override String get closed => 'التسجيل في هذه الفعالية مغلق.';
	@override late final _Translations$events$register$ar register = _Translations$events$register$ar._(_root);
	@override late final _Translations$events$reminder$ar reminder = _Translations$events$reminder$ar._(_root);
	@override late final _Translations$events$admin$ar admin = _Translations$events$admin$ar._(_root);
	@override String upcomingCount({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(n,
		zero: 'لا توجد فعاليات قادمة',
		one: 'فعالية قادمة واحدة',
		two: 'فعاليتان قادمتان',
		few: '${n} فعاليات قادمة',
		many: '${n} فعالية قادمة',
		other: '${n} فعالية قادمة',
	);
	@override String slide({required Object current, required Object total}) => 'الفعالية ${current} من ${total}';
}

// Path: notifications
class _Translations$notifications$ar extends Translations$notifications$fr {
	_Translations$notifications$ar._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'الإشعارات';
	@override String get channel => 'إعلانات الجماعة';
	@override String get empty => 'لا توجد إشعارات بعد';
	@override String get emptyHint => 'ستصل إعلانات الجماعة إلى هنا.';
	@override String unreadLabel({required Object title}) => 'غير مقروء: ${title}';
	@override String documents({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(n,
		zero: 'لا يوجد مستند PDF',
		one: 'مستند PDF واحد',
		two: 'مستندا PDF',
		few: '${n} مستندات PDF',
		many: '${n} مستندًا PDF',
		other: '${n} مستند PDF',
	);
	@override String unread({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(n,
		zero: 'لا شيء غير مقروء',
		one: 'إشعار واحد غير مقروء',
		two: 'إشعاران غير مقروءين',
		few: '${n} إشعارات غير مقروءة',
		many: '${n} إشعارًا غير مقروء',
		other: '${n} إشعار غير مقروء',
	);
	@override String image({required Object n}) => 'الصورة ${n}';
	@override String get document => 'مستند PDF';
	@override String documentSize({required Object kb}) => '${kb} ك.ب';
	@override String received({required Object title}) => 'إشعار جديد: ${title}';
}

// Path: premium
class _Translations$premium$ar extends Translations$premium$fr {
	_Translations$premium$ar._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get name => 'CMFI Connect Premium';
	@override String get pill => 'Premium';
	@override String get subtitle => 'تقدّم أكثر في مسيرتك مع الله، وادعم العمل.';
	@override String get widgetTitle => 'أداة الشاشة الرئيسية';
	@override String get widgetText => 'تقرير يومك وأهدافك، دون فتح التطبيق.';
	@override String get statsTitle => 'أهدافك على مدار السنة';
	@override String get statsText => 'حصيلة السنة وتطوّر أهدافك، أسبوعًا بعد أسبوع.';
	@override String get supportTitle => 'أنت تدعم العمل';
	@override String get supportText => 'اشتراكك يُبقي التطبيق حيًّا للجماعة كلها.';
	@override String get annual => 'سنوي';
	@override String get monthly => 'شهري';
	@override String perYear({required Object price}) => '${price} / سنة';
	@override String perMonth({required Object price}) => '${price} / شهر';
	@override String annualPerMonth({required Object price}) => 'أي ${price} شهريًا';
	@override String get best => 'الأوفر';
	@override String trialDays({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(n,
		zero: 'تجربة مجانية',
		one: 'يوم واحد تجربة مجانية',
		two: 'يومان تجربة مجانية',
		few: '${n} أيام تجربة مجانية',
		many: '${n} يومًا تجربة مجانية',
		other: '${n} يوم تجربة مجانية',
	);
	@override String trialMonths({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(n,
		zero: 'تجربة مجانية',
		one: 'شهر واحد تجربة مجانية',
		two: 'شهران تجربة مجانية',
		few: '${n} أشهر تجربة مجانية',
		many: '${n} شهرًا تجربة مجانية',
		other: '${n} شهر تجربة مجانية',
	);
	@override String get subscribe => 'اشترك';
	@override String get startTrial => 'ابدأ التجربة المجانية';
	@override String get restore => 'استعادة المشتريات';
	@override String get restored => 'عاد Premium إلى هذا الهاتف';
	@override String get nothingToRestore => 'لا يوجد شراء Premium لهذا الحساب';
	@override String get thanks => 'شكرًا! تم تفعيل Premium.';
	@override String get failed => 'لم تكتمل عملية الشراء. أعد المحاولة بعد قليل.';
	@override String get unavailable => 'العروض غير متاحة حاليًا.';
	@override String renews({required Object store}) => 'يتجدد الاشتراك تلقائيًا. يمكنك إلغاؤه متى شئت من إعدادات حسابك في ${store}.';
	@override String get terms => 'شروط الاستخدام';
	@override String get privacy => 'الخصوصية';
	@override String get activeTitle => 'لديك Premium';
	@override String get activeText => 'شكرًا لدعمك CMFI Connect! الأداة وسنة حصيلتك مفتوحتان.';
	@override String get staffText => 'Premium مقدَّم لك مجانًا لأنك من فريق CMFI Connect.';
	@override String get moreSubtitle => 'الأداة، الأهداف على مدار السنة';
	@override String get moreActive => 'مفعّل';
	@override String get unlock => 'افتح مع Premium';
	@override String trialThen({required Object trial, required Object price}) => '${trial}، ثم ${price}';
	@override String savePercent({required Object percent}) => '−${percent}';
	@override String get choose => 'اختر عرضك';
	@override String get cancelAnytime => 'بلا التزام، يمكن الإلغاء في أي وقت';
	@override String get restoreShort => 'استعادة';
	@override String get termsShort => 'الشروط';
	@override String get semiannual => 'نصف سنوي';
	@override String perSemester({required Object price}) => '${price} / 6 أشهر';
}

// Path: homeWidget
class _Translations$homeWidget$ar extends Translations$homeWidget$fr {
	_Translations$homeWidget$ar._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'اليوم';
	@override String get done => 'تم';
	@override String get todo => 'للتعبئة';
	@override String get open => 'عبّئ';
	@override String get locked => 'فعّل الأداة مع Premium';
	@override String get signedOut => 'سجّل الدخول في التطبيق';
}

// Path: ministry
class _Translations$ministry$ar extends Translations$ministry$fr {
	_Translations$ministry$ar._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'خدمتنا';
	@override String get tagline => 'إلى أقصى الأرض';
	@override String count({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(n,
		zero: 'لا توجد أمم',
		one: 'أمة واحدة',
		two: 'أمّتان',
		few: '${n} أمم',
		many: '${n} أمة',
		other: '${n} أمة',
	);
	@override String get fromYaounde => 'من ياوندي، ينتقل الإنجيل من أمة إلى أمة.';
	@override String get dragHint => 'أدر الكرة الأرضية بإصبعك، والمس أمة.';
	@override String globeLabel({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(n,
		zero: 'الكرة الأرضية: لا توجد أمم بعد.',
		one: 'الكرة الأرضية: أمة واحدة حيث العمل حاضر. القائمة أدناه تذكرها.',
		two: 'الكرة الأرضية: أمّتان حيث العمل حاضر. القائمة أدناه تذكرهما.',
		few: 'الكرة الأرضية: ${n} أمم حيث العمل حاضر. القائمة أدناه تذكرها كلها.',
		many: 'الكرة الأرضية: ${n} أمة حيث العمل حاضر. القائمة أدناه تذكرها كلها.',
		other: 'الكرة الأرضية: ${n} أمة حيث العمل حاضر. القائمة أدناه تذكرها كلها.',
	);
	@override String get voyage => 'رحلة';
	@override String get pause => 'إيقاف مؤقت';
	@override String get previous => 'الأمة السابقة';
	@override String get next => 'الأمة التالية';
	@override String number({required Object n}) => 'الأمة رقم ${n}';
	@override String since({required Object year}) => 'منذ ${year}';
	@override String get pray => 'صلِّ';
	@override String prayTitle({required Object country}) => 'صلِّ من أجل ${country}';
	@override String prayThanks({required Object country}) => 'اشكر الله على عمله في ${country}.';
	@override String prayAssemblies({required Object country}) => 'صلِّ من أجل جماعات ${country} ومسؤوليها.';
	@override String prayUnreached({required Object country}) => 'صلِّ لكي يلتقي بيسوع الذين لم يؤمنوا بعد في ${country}.';
	@override String get purpose => 'هدفنا';
	@override String get nations => 'الأمم';
	@override String get search => 'ابحث عن أمة';
	@override String get none => 'لا توجد أمة مطابقة';
	@override String homeText({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(n,
		zero: 'لا توجد أمم بعد',
		one: 'حاضرة في أمة واحدة',
		two: 'حاضرة في أمّتين',
		few: 'حاضرة في ${n} أمم',
		many: 'حاضرة في ${n} أمة',
		other: 'حاضرة في ${n} أمة',
	);
	@override String get nationsSubtitle => 'الكرة الأرضية والرحلة من أمة إلى أمة';
	@override String get purposeSubtitle => 'أهدافنا الثلاثة';
	@override String get missionaries => 'مرسلونا';
	@override String get missionariesSubtitle => 'الذين يرسلهم الرب إلى الأمم';
	@override String get heroes => 'أبطالنا';
	@override String get heroesSubtitle => 'الذين يلهمنا إيمانهم';
	@override String goalOf({required Object n, required Object total}) => 'هدفنا · ${n}/${total}';
	@override String get previousGoal => 'الهدف السابق';
	@override String get nextGoal => 'الهدف التالي';
	@override Map<String, String> get media => {
		'books': 'الكتب',
		'tracts': 'النبذات',
		'magazines': 'المجلات',
		'cds': 'الأقراص المدمجة',
		'dvds': 'أقراص الفيديو',
		'radio': 'الإذاعة',
		'tv': 'التلفزيون',
		'internet': 'الإنترنت',
	};
	@override late final _Translations$ministry$goals$ar goals = _Translations$ministry$goals$ar._(_root);
}

// Path: prayer
class _Translations$prayer$ar extends Translations$prayer$fr {
	_Translations$prayer$ar._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override Map<String, String> get moments => {
		'morning': 'الصباح',
		'noon': 'الظهر',
		'evening': 'المساء',
		'night': 'الليل',
	};
	@override Map<String, String> get retreatOf => {
		'morning': 'خلوة الصباح',
		'noon': 'خلوة الظهر',
		'evening': 'خلوة المساء',
		'night': 'خلوة الليل',
	};
	@override late final _Translations$prayer$hero$ar hero = _Translations$prayer$hero$ar._(_root);
	@override late final _Translations$prayer$today$ar today = _Translations$prayer$today$ar._(_root);
	@override late final _Translations$prayer$routine$ar routine = _Translations$prayer$routine$ar._(_root);
	@override String get together => 'نصلّي معًا';
	@override late final _Translations$prayer$reminders$ar reminders = _Translations$prayer$reminders$ar._(_root);
	@override late final _Translations$prayer$retreat$ar retreat = _Translations$prayer$retreat$ar._(_root);
	@override late final _Translations$prayer$session$ar session = _Translations$prayer$session$ar._(_root);
	@override late final _Translations$prayer$done$ar done = _Translations$prayer$done$ar._(_root);
	@override late final _Translations$prayer$topics$ar topics = _Translations$prayer$topics$ar._(_root);
	@override late final _Translations$prayer$lists$ar lists = _Translations$prayer$lists$ar._(_root);
	@override late final _Translations$prayer$importunity$ar importunity = _Translations$prayer$importunity$ar._(_root);
}

// Path: sending
class _Translations$sending$ar extends Translations$sending$fr {
	_Translations$sending$ar._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'الإرسال إلى مرشديّ';
	@override String get moreOff => 'متوقف';
	@override String get intro => 'في الوقت الذي تختاره، يُعِدّ CMFI Connect تقريرك عن الفترة. ما عليك إلا إرساله إلى مرشديك الروحيين.';
	@override String get enabled => 'جهّزه لي بانتظام';
	@override String get rhythm => 'الوتيرة';
	@override String get weekly => 'كل أسبوع';
	@override String get biweekly => 'كل أسبوعين';
	@override String get monthly => 'كل شهر';
	@override String get day => 'اليوم';
	@override String get monthlyDay => 'في أول كل شهر، عن الشهر الماضي';
	@override String get time => 'الساعة';
	@override String get recipients => 'المستلمون';
	@override String get noAuthorities => 'أضف مرشديك الروحيين أولًا.';
	@override String get addAuthorities => 'إضافة مرشديّ';
	@override String get viaWhatsApp => 'عبر واتساب';
	@override String get viaEmail => 'عبر البريد الإلكتروني';
	@override String get viaBoth => 'عبر واتساب أو البريد';
	@override String get viaShare => 'عبر المشاركة';
	@override String next({required Object date}) => 'التالي: ${date}';
	@override String get prepareNow => 'جهّزه الآن';
	@override String get history => 'آخر الإرسالات';
	@override String get notificationTitle => 'تقريرك جاهز';
	@override String get notificationBody => 'أرسله إلى مرشديك بلمسة واحدة.';
	@override String get channel => 'إرسال التقرير';
	@override String get readyTitle => 'تقريرك جاهز';
	@override String get preview => 'معاينة الرسالة';
	@override String greeting({required Object name}) => 'مرحبًا ${name}،';
	@override String get whatsApp => 'واتساب';
	@override String get email => 'البريد';
	@override String get sharePdf => 'مشاركة ملف PDF';
	@override String get shareText => 'مشاركة النص';
	@override String get sent => 'أُرسل';
	@override String get shared => 'مشاركة';
	@override String get noRecipients => 'اختر المستلمين في الإعدادات، أو شارك ملف PDF.';
	@override String get settings => 'الإعدادات';
	@override String get permissionDenied => 'اسمح بالإشعارات لتصلك في الوقت المناسب.';
}

// Path: streak
class _Translations$streak$ar extends Translations$streak$fr {
	_Translations$streak$ar._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String title({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(n,
		zero: '${n} يوم على التوالي!',
		one: 'يوم واحد على التوالي!',
		two: 'يومان على التوالي!',
		few: '${n} أيام على التوالي!',
		many: '${n} يومًا على التوالي!',
		other: '${n} يوم على التوالي!',
	);
	@override String cardDays({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(n,
		zero: 'يوم مع الله',
		one: 'يوم مع الله',
		two: 'يومان مع الله',
		few: 'أيام مع الله',
		many: 'يومًا مع الله',
		other: 'يوم مع الله',
	);
	@override late final _Translations$streak$lines$ar lines = _Translations$streak$lines$ar._(_root);
	@override String get share => 'مشاركة';
	@override String get close => 'متابعة';
}

// Path: shortcuts
class _Translations$shortcuts$ar extends Translations$shortcuts$fr {
	_Translations$shortcuts$ar._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get today => 'املأ تقريري';
	@override String get hymns => 'الترانيم';
	@override String get retreat => 'خلوة الآن';
}

// Path: blocking
class _Translations$blocking$ar extends Translations$blocking$fr {
	_Translations$blocking$ar._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get report => 'إبلاغ';
	@override String block({required Object name}) => 'حظر ${name}';
	@override String blockTitle({required Object name}) => 'حظر ${name}؟';
	@override String blockText({required Object name}) => 'لن تصلك دعوات من ${name} بعد الآن. وتُزال هذه الدعوة.';
	@override String get blockAction => 'حظر';
	@override String blocked({required Object name}) => 'لن يتمكن ${name} من دعوتك بعد الآن.';
	@override String get reportTitle => 'الإبلاغ عن هذه الدعوة';
	@override String get reportText => 'أخبرنا بما لا يناسب: سينظر مسؤولو الجماعة في الأمر.';
	@override late final _Translations$blocking$reasons$ar reasons = _Translations$blocking$reasons$ar._(_root);
	@override String get comment => 'تعليق';
	@override String get commentHint => 'ما ينبغي أن يعرفه المسؤولون';
	@override String get send => 'إرسال البلاغ';
	@override String get reported => 'شكرًا، سينظر المسؤولون في الأمر.';
	@override String get listTitle => 'الأعضاء المحظورون';
	@override String get intro => 'لم تعد دعواتهم إلى الصلاة تصلك.';
	@override String get empty => 'لم تحظر أحدًا.';
	@override String get unblock => 'إلغاء الحظر';
	@override String unblocked({required Object name}) => 'يمكن لـ${name} أن يدعوك من جديد.';
}

// Path: verses
class _Translations$verses$ar extends Translations$verses$fr {
	_Translations$verses$ar._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'آية اليوم';
	@override String get share => 'مشاركة الآية';
	@override String get shareImage => 'مشاركة الصورة';
	@override String get shareText => 'مشاركة النص';
}

// Path: bible
class _Translations$bible$ar extends Translations$bible$fr {
	_Translations$bible$ar._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'الكتاب المقدس';
	@override String get books => 'الأسفار';
	@override String get oldTestament => 'العهد القديم';
	@override String get newTestament => 'العهد الجديد';
	@override String chapters({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(n,
		zero: '${n} أصحاح',
		one: 'أصحاح واحد',
		two: 'أصحاحان',
		few: '${n} أصحاحات',
		many: '${n} أصحاحًا',
		other: '${n} أصحاح',
	);
	@override String chapter({required Object n}) => 'الأصحاح ${n}';
	@override String get version => 'الترجمة';
	@override String get versions => 'ترجمة الكتاب المقدس';
	@override String get search => 'البحث في الكتاب المقدس';
	@override String get searchHint => 'كلمة، أو «يوحنا 3:16»';
	@override String get searchTip => 'ابحث عن كلمة («محبة») أو انتقل مباشرة إلى مقطع («مزمور 23»، «يوحنا 3:16»).';
	@override String get searchNone => 'لا توجد آية تحتوي على هذه الكلمات.';
	@override String searchCount({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(n,
		zero: '${n} آية',
		one: 'آية واحدة',
		two: 'آيتان',
		few: '${n} آيات',
		many: '${n} آية',
		other: '${n} آية',
	);
	@override String searchLimit({required Object n}) => 'أول ${n} آية';
	@override String get searchNeedsDownload => 'للبحث عن كلمات في الكتاب المقدس كله، قم بتنزيله. يمكنك الآن كتابة مقطع: «يوحنا 3:16».';
	@override String open({required Object reference}) => 'فتح ${reference}';
	@override String get previous => 'الأصحاح السابق';
	@override String get next => 'الأصحاح التالي';
	@override String get markRead => 'قرأت هذا الأصحاح';
	@override String get markedRead => 'قُرئ اليوم';
	@override String get markReadHint => 'يضيف أصحاحًا واحدًا إلى «قراءة الكتاب المقدس» في تقريرك.';
	@override String addedToReport({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(n,
		zero: 'التقرير: ${n} أصحاح اليوم',
		one: 'التقرير: أصحاح واحد اليوم',
		two: 'التقرير: أصحاحان اليوم',
		few: 'التقرير: ${n} أصحاحات اليوم',
		many: 'التقرير: ${n} أصحاحًا اليوم',
		other: 'التقرير: ${n} أصحاح اليوم',
	);
	@override String get removedFromReport => 'أُزيل من تقريرك';
	@override String get noReadingItem => 'لا يحتوي تقريرك على عنصر «قراءة الكتاب المقدس».';
	@override String get download => 'تنزيل هذا الكتاب المقدس';
	@override String downloadHelp({required Object size}) => 'حوالي ${size} ميغابايت، للقراءة والبحث دون اتصال.';
	@override String downloading({required Object percent}) => 'جارٍ التنزيل… ${percent}٪';
	@override String get downloaded => 'على هاتفك';
	@override String downloadDone({required Object version}) => '${version} على هاتفك';
	@override String get removeDownload => 'إزالة من الهاتف';
	@override String removeDownloadTitle({required Object version}) => 'إزالة ${version} من الهاتف؟';
	@override String get removeDownloadText => 'الأصحاحات التي قرأتها تبقى متاحة دون اتصال.';
	@override String get offline => 'هذا الأصحاح ليس على هاتفك بعد. أعد الاتصال، أو نزّل هذا الكتاب المقدس لقراءته دون اتصال.';
	@override String get notInVersion => 'هذا المقطع غير موجود في هذه الترجمة.';
	@override String get marks => 'آياتي';
	@override String get favorites => 'المحفوظة';
	@override String get highlights => 'المظللة';
	@override String get noFavorites => 'المس آية ثم العلامة لتجدها هنا.';
	@override String get noHighlights => 'المس آية ثم لونًا لتظليلها.';
	@override String get tapHint => 'المس آية لتظليلها أو حفظها أو نسخها أو مشاركتها.';
	@override String highlight({required Object color}) => 'تظليل باللون ${color}';
	@override late final _Translations$bible$colors$ar colors = _Translations$bible$colors$ar._(_root);
	@override String get removeHighlight => 'إزالة اللون';
	@override String get addFavorite => 'حفظ في آياتي';
	@override String get removeFavorite => 'إزالة من آياتي';
	@override String get favoriteAdded => 'حُفظت في آياتي';
	@override String get favoriteRemoved => 'أُزيلت من آياتي';
	@override String get copy => 'نسخ';
	@override String get copied => 'تم النسخ';
	@override String get share => 'مشاركة';
	@override String get closeSelection => 'إغلاق التحديد';
	@override String get display => 'العرض';
	@override String get jesusInRed => 'كلمات يسوع بالأحمر';
	@override String get jesusInRedHelp => 'في الترجمات التي تميّزها';
	@override String get remove => 'إزالة';
	@override String get readInBible => 'اقرأ في الكتاب المقدس';
	@override String get more => 'خيارات أخرى';
}

// Path: profilePhoto
class _Translations$profilePhoto$ar extends Translations$profilePhoto$fr {
	_Translations$profilePhoto$ar._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'صورة الملف الشخصي';
	@override String get add => 'إضافة صورة للملف الشخصي';
	@override String get change => 'تغيير صورة الملف الشخصي';
	@override String get seenBy => 'يراها الأعضاء الآخرون حيثما يظهر اسمك.';
	@override String get camera => 'التقاط صورة';
	@override String get gallery => 'الاختيار من المعرض';
	@override String get remove => 'إزالة الصورة';
	@override String get cropTitle => 'اقتصاص صورتك';
	@override String get cropHint => 'حرّك الصورة وكبّرها بأصابعك.';
	@override String get use => 'استخدام هذه الصورة';
	@override String get unreadable => 'تعذّر فتح هذه الصورة. اختر صورة أخرى.';
	@override String get saved => 'تم حفظ صورة ملفك الشخصي.';
	@override String get removed => 'تمت إزالة صورة ملفك الشخصي.';
}

// Path: disciples
class _Translations$disciples$ar extends Translations$disciples$fr {
	_Translations$disciples$ar._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'تلاميذي';
	@override String get empty => 'لا تلاميذ بعد';
	@override String get emptyText => 'عندما يختارك عضو صانعَ تلاميذ له أو سلطةً روحية وتقبل طلبه، يظهر هنا.';
	@override String count({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(n,
		zero: 'لا تلاميذ',
		one: 'تلميذ واحد',
		two: 'تلميذان',
		few: '${n} تلاميذ',
		many: '${n} تلميذًا',
		other: '${n} تلميذ',
	);
	@override String get notShared => 'لا يشارك تقاريره';
	@override String get roleMaker => 'أنت صانع تلاميذه';
	@override String get roleAuthority => 'أنت إحدى سلطاته الروحية';
	@override String dayGoals({required Object percent}) => 'الأهداف ${percent} %';
	@override String dayItems({required Object filled, required Object total, required Object percent}) => '${filled} من ${total} عناصر · ${percent} %';
	@override String get older => 'عرض الأيام الثلاثين السابقة';
	@override String get noReports => 'لا تقرير في هذه الفترة.';
	@override String get searchHint => 'الاسم أو اسم المستخدم';
	@override String noMatch({required Object search}) => 'لا يوجد تلميذ يطابق «${search}».';
}

// Path: weekStory
class _Translations$weekStory$ar extends Translations$weekStory$fr {
	_Translations$weekStory$ar._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'أسبوعك مع الله';
	@override String range({required Object from, required Object to}) => 'من ${from} إلى ${to}';
	@override String get intro => 'استعد ما عشته مع الرب هذا الأسبوع.';
	@override String get tapHint => 'المس اليمين للمتابعة واليسار للرجوع.';
	@override String get faithfulLead => 'كنت أمينًا';
	@override String get emptyLead => 'أسبوع جديد ينتظرك';
	@override String days({required num n, required Object total}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(n,
		zero: '${n} يوم\nمن ${total}',
		one: 'يوم واحد\nمن ${total}',
		two: 'يومان\nمن ${total}',
		few: '${n} أيام\nمن ${total}',
		many: '${n} يومًا\nمن ${total}',
		other: '${n} يوم\nمن ${total}',
	);
	@override String streak({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(n,
		zero: '${n} يوم على التوالي',
		one: 'يوم واحد على التوالي',
		two: 'يومان على التوالي',
		few: '${n} أيام على التوالي',
		many: '${n} يومًا على التوالي',
		other: '${n} يوم على التوالي',
	);
	@override String streakRecord({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(n,
		zero: '${n} يوم على التوالي: رقمك القياسي!',
		one: 'يوم واحد على التوالي: رقمك القياسي!',
		two: 'يومان على التوالي: رقمك القياسي!',
		few: '${n} أيام على التوالي: رقمك القياسي!',
		many: '${n} يومًا على التوالي: رقمك القياسي!',
		other: '${n} يوم على التوالي: رقمك القياسي!',
	);
	@override String get emptyText => 'املأ تقريرك كل يوم: سيُكتب أسبوعك القادم هنا.';
	@override String get prayerLead => 'صلّيت';
	@override String retreats({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(n,
		zero: '${n} خلوة',
		one: 'خلوة واحدة',
		two: 'خلوتان',
		few: '${n} خلوات',
		many: '${n} خلوة',
		other: '${n} خلوة',
	);
	@override String retreatsTime({required Object time}) => 'من 15 دقيقة · ${time} مع الرب';
	@override String faithfulMoment({required num n, required Object moment}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(n,
		zero: 'وقتك الأكثر أمانة: ${moment} (${n} مرة)',
		one: 'وقتك الأكثر أمانة: ${moment} (مرة واحدة)',
		two: 'وقتك الأكثر أمانة: ${moment} (مرتان)',
		few: 'وقتك الأكثر أمانة: ${moment} (${n} مرات)',
		many: 'وقتك الأكثر أمانة: ${moment} (${n} مرة)',
		other: 'وقتك الأكثر أمانة: ${moment} (${n} مرة)',
	);
	@override String get noRetreat => 'لا خلوة هذا الأسبوع';
	@override String get noRetreatText => 'خلوة الظهر تنتظرك: 15 دقيقة مع الرب.';
	@override String get goalsLead => 'أهدافك';
	@override String get goalsReached => 'تحقّقت في المتوسط';
	@override String bestDay({required Object day, required Object percent}) => 'أفضل يوم لك: ${day} · ${percent}';
	@override String get summaryTitle => 'أسبوعي مع الله';
	@override String get statDays => 'أيام مملوءة';
	@override String statStreak({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(n,
		zero: 'يوم على التوالي',
		one: 'يوم على التوالي',
		two: 'يومان على التوالي',
		few: 'أيام على التوالي',
		many: 'يومًا على التوالي',
		other: 'يوم على التوالي',
	);
	@override String statRetreats({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(n,
		zero: 'خلوة',
		one: 'خلوة',
		two: 'خلوتان',
		few: 'خلوات',
		many: 'خلوة',
		other: 'خلوة',
	);
	@override String get statGoals => 'من الأهداف';
	@override String get share => 'مشاركة أسبوعي';
	@override String get homeText => 'أمانتك وصلاتك وأهدافك هذا الأسبوع.';
	@override String get open => 'عرض أسبوعي';
	@override String get notificationTitle => 'أسبوعك مع الله جاهز';
	@override String get notificationBody => 'استعد أمانتك هذا الأسبوع وشاركها.';
	@override String get channel => 'أسبوعك مع الله';
	@override String get thisWeek => 'هذا الأسبوع';
	@override String get pastWeeks => 'الأسابيع الماضية';
	@override String weekOf({required Object date}) => 'أسبوع ${date}';
	@override String page({required Object current, required Object total}) => '${current} من ${total}';
}

// Path: onboarding.reports
class _Translations$onboarding$reports$ar extends Translations$onboarding$reports$fr {
	_Translations$onboarding$reports$ar._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'مسيرتك مع الله، يومًا بعد يوم';
	@override String get text => 'سجّل في ثوانٍ قراءتك للكتاب المقدس، وصلاتك، وصومك… وتابع تقدّمك أسبوعًا بعد أسبوع.';
}

// Path: onboarding.worship
class _Translations$onboarding$worship$ar extends Translations$onboarding$worship$fr {
	_Translations$onboarding$worship$ar._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'رنّم وصلِّ أينما كنت';
	@override String get text => 'اعثر على ترانيم المجتمع، واحمل كل يوم طلبات الصلاة مع إخوتك وأخواتك.';
}

// Path: onboarding.community
class _Translations$onboarding$community$ar extends Translations$onboarding$community$fr {
	_Translations$onboarding$community$ar._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'ابقَ على صلة بمجتمعك';
	@override String get text => 'فعاليات جماعتك وإعلاناتها في مكان واحد، حتى لا يفوتك شيء.';
}

// Path: onboarding.sample
class _Translations$onboarding$sample$ar extends Translations$onboarding$sample$fr {
	_Translations$onboarding$sample$ar._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get today => 'اليوم';
	@override String get bibleReading => 'قراءة الكتاب المقدس';
	@override String get prayerAlone => 'الصلاة الفردية';
	@override String get meditation => 'التأمل';
	@override String get groupPrayer => 'الصلاة الجماعية';
	@override String get thisWeek => 'هذا الأسبوع';
	@override String get weekScore => '4 أيام من 5';
	@override String get hymn => 'ترنيمة';
	@override String get hymnNumber => 'رقم 12';
	@override String get fullScreen => 'ملء الشاشة';
	@override String get prayerOfTheDay => 'طلب الصلاة لهذا اليوم';
	@override String get prayerTopic => 'من أجل امتحانات شبابنا';
	@override String get praying => '12 شخصًا يصلّون';
	@override String get iPray => 'أصلّي';
	@override String get vigil => 'سهرة صلاة';
	@override String get vigilMeta => '20:00 · الجماعة المحلية';
	@override String get join => 'سأشارك';
	@override String get retreat => 'خلوة الشباب';
	@override String get retreatMeta => 'طوال اليوم';
	@override String get announcement => 'إعلان';
	@override String get announcementText => 'تبدأ عبادة الأحد في الساعة 8:30 صباحًا.';
	@override String get chapters => '10 إصحاحات';
}

// Path: auth.login
class _Translations$auth$login$ar extends Translations$auth$login$fr {
	_Translations$auth$login$ar._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'مرحبًا بعودتك';
	@override String get subtitle => 'سجّل الدخول لتملأ تقرير اليوم.';
	@override String get submit => 'تسجيل الدخول';
	@override String get noAccount => 'ليس لديك حساب بعد؟';
	@override String get createAccount => 'إنشاء حساب';
}

// Path: auth.register
class _Translations$auth$register$ar extends Translations$auth$register$fr {
	_Translations$auth$register$ar._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String step({required Object current, required Object total}) => '${current} / ${total}';
	@override String get title => 'أنشئ حسابك';
	@override String get subtitle => 'ستستخدم رقم هاتفك لتسجيل الدخول.';
	@override String get firstName => 'الاسم الأول';
	@override String get lastName => 'اسم العائلة';
	@override String get passwordHelp => '6 أحرف على الأقل';
	@override String get email => 'البريد الإلكتروني';
	@override String get submit => 'متابعة';
	@override String get haveAccount => 'لديك حساب بالفعل؟';
	@override String get login => 'تسجيل الدخول';
	@override String get alreadyUsed => 'هذا الرقم أو هذا البريد الإلكتروني مرتبط بحساب بالفعل. سجّل الدخول.';
	@override String get emailHint => 'name@example.com';
}

// Path: auth.church
class _Translations$auth$church$ar extends Translations$auth$church$fr {
	_Translations$auth$church$ar._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'كنيستك';
	@override String get subtitle => 'تساعد هذه المعلومات قادتك على الوصول إليك. يمكنك تعديلها لاحقًا.';
	@override String get editTitle => 'ملفي الشخصي';
	@override String get editSubtitle => 'حدّث اسمك وكنيستك وجماعتك.';
	@override String get country => 'البلد';
	@override String get countryHint => 'اختر بلدك';
	@override String get city => 'المدينة';
	@override String get cityHint => 'Yaoundé';
	@override String get church => 'الكنيسة';
	@override String get churchHint => 'اسم كنيستك';
	@override String get assembly => 'الجماعة';
	@override String get assemblyHint => 'اسم جماعتك';
	@override String get info => 'انتقلت إلى مكان آخر أو غيّرت جماعتك؟ يمكنك تحديث كل شيء من ملفك الشخصي.';
	@override String get submit => 'إنهاء';
	@override String get skip => 'تخطَّ هذه الخطوة';
	@override String get saved => 'تم حفظ الملف الشخصي';
}

// Path: auth.forgot
class _Translations$auth$forgot$ar extends Translations$auth$forgot$fr {
	_Translations$auth$forgot$ar._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get link => 'نسيت كلمة المرور؟';
	@override String get title => 'نسيت كلمة المرور';
	@override String get phoneText => 'أدخل رقمك: سنرسل لك رمزًا عبر رسالة قصيرة لاختيار كلمة مرور جديدة.';
	@override String get sendCode => 'استلام الرمز';
	@override String get codeTitle => 'أدخل الرمز';
	@override String codeText({required Object phone}) => 'أرسلنا رمزًا من 6 أرقام إلى ${phone}.';
	@override String get code => 'الرمز المستلم عبر الرسالة';
	@override String get codeInvalid => 'يتكون الرمز من 6 أرقام';
	@override String get verify => 'تحقق';
	@override String get resend => 'إعادة إرسال الرمز';
	@override String resendIn({required Object seconds}) => 'إعادة الإرسال بعد ${seconds} ث';
	@override String get changeNumber => 'تغيير الرقم';
	@override String get passwordTitle => 'كلمة مرور جديدة';
	@override String get passwordText => 'اختر كلمة مرور جديدة لحسابك.';
	@override String get submit => 'حفظ وتسجيل الدخول';
	@override String get done => 'تم تغيير كلمة المرور. مرحبًا بعودتك!';
	@override String get remembered => 'تذكّرتها؟';
	@override String get invalidCode => 'هذا الرمز غير صحيح.';
	@override String get expired => 'انتهت صلاحية الرمز. اطلب رمزًا جديدًا.';
	@override String get tooManyRequests => 'محاولات كثيرة. حاول مجددًا بعد قليل.';
	@override String get unavailable => 'إعادة التعيين غير متاحة حاليًا.';
	@override String get noAccount => 'لا يوجد حساب بهذا الرقم.';
}

// Path: reports.tabs
class _Translations$reports$tabs$ar extends Translations$reports$tabs$fr {
	_Translations$reports$tabs$ar._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get today => 'اليوم';
	@override String get history => 'السجل';
	@override String get summary => 'الملخص';
}

// Path: reports.measure
class _Translations$reports$measure$ar extends Translations$reports$measure$fr {
	_Translations$reports$measure$ar._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String quantity({required Object unit}) => '${unit}';
	@override String get duration => 'المدة';
	@override String both({required Object unit}) => '${unit} والمدة';
	@override String get quantityNoUnit => 'الكمية';
	@override String get bothNoUnit => 'الكمية والمدة';
}

// Path: reports.sheet
class _Translations$reports$sheet$ar extends Translations$reports$sheet$fr {
	_Translations$reports$sheet$ar._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get quantity => 'الكمية';
	@override String get duration => 'المدة';
	@override String get minus1 => '− 1 دقيقة';
	@override String get plus1 => '+ 1 دقيقة';
	@override String get removeMinute => 'إنقاص دقيقة';
	@override String get addMinute => 'إضافة دقيقة';
	@override String get holdToRepeat => 'اضغط مطوّلًا للإسراع';
	@override String get decrease => 'إنقاص';
	@override String get increase => 'زيادة';
	@override String get clear => 'مسح';
	@override String get validate => 'تأكيد';
}

// Path: reports.history
class _Translations$reports$history$ar extends Translations$reports$history$fr {
	_Translations$reports$history$ar._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String daysFilled({required Object filled, required Object total}) => 'الأيام المعبّأة: ${filled} من ${total}';
	@override String get legendFilled => 'معبّأ';
	@override String get legendMissing => 'لا يوجد تقرير';
	@override String get none => 'لا يوجد تقرير';
	@override String get fill => 'املأ';
	@override String get inProgress => 'جارٍ';
	@override String get previousMonth => 'الشهر السابق';
	@override String get nextMonth => 'الشهر التالي';
	@override String get today => 'اليوم';
}

// Path: reports.summary
class _Translations$reports$summary$ar extends Translations$reports$summary$fr {
	_Translations$reports$summary$ar._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get week => 'الأسبوع';
	@override String get month => 'الشهر';
	@override String get year => 'السنة';
	@override String range({required Object from, required Object to}) => 'من ${from} إلى ${to}';
	@override String get regularity => 'الانتظام';
	@override String get daysFilled => 'أيام معبّأة';
	@override String missingDays({required num n, required Object days}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(n,
		zero: '${n} يوم بلا تقرير: ${days}',
		one: 'يوم واحد بلا تقرير: يوم ${days}',
		two: 'يومان بلا تقرير: ${days}',
		few: '${n} أيام بلا تقرير: ${days}',
		many: '${n} يومًا بلا تقرير: ${days}',
		other: '${n} يوم بلا تقرير: ${days}',
	);
	@override String missingCount({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(n,
		zero: '${n} يوم بلا تقرير',
		one: 'يوم واحد بلا تقرير',
		two: 'يومان بلا تقرير',
		few: '${n} أيام بلا تقرير',
		many: '${n} يومًا بلا تقرير',
		other: '${n} يوم بلا تقرير',
	);
	@override String get noMissing => 'لم يفُتك أي يوم، أحسنت!';
	@override String perDay({required Object value}) => '${value} لكل يوم معبّأ';
	@override String days({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(n,
		zero: '${n} يوم',
		one: 'يوم واحد',
		two: 'يومان',
		few: '${n} أيام',
		many: '${n} يومًا',
		other: '${n} يوم',
	);
	@override String get notFilled => 'لم تُعبّأ بعد';
	@override String barsCaption({required Object max}) => 'لكل يوم · أعلى عمود: ${max}';
	@override String barsCaptionMonthly({required Object max}) => 'لكل شهر · أعلى عمود: ${max}';
	@override String get empty => 'لا توجد تقارير في هذه الفترة.';
	@override String goalDays({required num n, required Object total}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(n,
		zero: 'تحقّق الهدف في ${n} يوم من ${total}',
		one: 'تحقّق الهدف في يوم واحد من ${total}',
		two: 'تحقّق الهدف في يومين من ${total}',
		few: 'تحقّق الهدف في ${n} أيام من ${total}',
		many: 'تحقّق الهدف في ${n} يومًا من ${total}',
		other: 'تحقّق الهدف في ${n} يوم من ${total}',
	);
	@override String get share => 'مشاركة هذا الملخص';
	@override String get goals => 'الأهداف';
	@override String get goalsAverage => 'متوسط تحقيق أهدافك';
	@override String get goalsHint => 'كل يوم يُحتسب، حتى الفارغ. يُحتسب اليوم بعد تعبئته.';
	@override String get evolution => 'تطوّر أهدافك';
	@override String get evolutionHint => 'أسبوعًا بعد أسبوع، خلال آخر 12 أسبوعًا.';
	@override String get premiumYear => 'السنة وتطوّر أهدافك متاحان مع Premium.';
}

// Path: reports.standardItems
class _Translations$reports$standardItems$ar extends Translations$reports$standardItems$fr {
	_Translations$reports$standardItems$ar._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get lb => 'قراءة الكتاب المقدس';
	@override String get ps => 'الصلاة الفردية';
	@override String get rdqad => 'التأمل';
	@override String get pg => 'الصلاة الجماعية';
	@override String get llc => 'قراءة الأدب المسيحي';
	@override String get jc => 'الصوم الكامل';
	@override String get jp => 'الصوم الجزئي';
	@override String get dimes => 'العشور';
	@override String get off => 'التقدمات';
}

// Path: reports.units
class _Translations$reports$units$ar extends Translations$reports$units$fr {
	_Translations$reports$units$ar._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override late final _Translations$reports$units$chapters$ar chapters = _Translations$reports$units$chapters$ar._(_root);
	@override late final _Translations$reports$units$times$ar times = _Translations$reports$units$times$ar._(_root);
	@override late final _Translations$reports$units$pages$ar pages = _Translations$reports$units$pages$ar._(_root);
	@override late final _Translations$reports$units$percent$ar percent = _Translations$reports$units$percent$ar._(_root);
}

// Path: export.doc
class _Translations$export$doc$ar extends Translations$export$doc$fr {
	_Translations$export$doc$ar._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'التقرير';
	@override String get regularity => 'الانتظام';
	@override String daysFilled({required num filled, required Object total}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(filled,
		zero: 'تمت تعبئة ${filled} يوم من ${total}',
		one: 'تمت تعبئة يوم واحد من ${total}',
		two: 'تمت تعبئة يومين من ${total}',
		few: 'تمت تعبئة ${filled} أيام من ${total}',
		many: 'تمت تعبئة ${filled} يومًا من ${total}',
		other: 'تمت تعبئة ${filled} يوم من ${total}',
	);
	@override String get totals => 'خلال الفترة';
	@override String get item => 'العنصر';
	@override String get total => 'المجموع';
	@override String get days => 'الأيام';
	@override String get average => 'المعدل / يوم معبّأ';
	@override String get goal => 'تحقّق الهدف';
	@override String get detail => 'يومًا بيوم';
	@override String get date => 'التاريخ';
	@override String get values => 'المُدخَل';
	@override String get note => 'ملاحظة';
	@override String get noReport => 'لا يوجد تقرير';
	@override String generated({required Object date}) => 'أُنشئ في ${date} بواسطة CMFI Connect';
	@override String page({required Object n, required Object total}) => 'صفحة ${n} / ${total}';
	@override String get filledColumn => 'التقرير';
	@override String get yes => 'نعم';
	@override String get no => 'لا';
	@override String get sentFrom => 'أُرسل من CMFI Connect';
}

// Path: items.measure
class _Translations$items$measure$ar extends Translations$items$measure$fr {
	_Translations$items$measure$ar._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String quantity({required Object unit}) => 'الكمية · ${unit}';
	@override String get quantityNoUnit => 'الكمية';
	@override String get duration => 'المدة';
	@override String both({required Object unit}) => 'الكمية (${unit}) والمدة';
	@override String get bothNoUnit => 'الكمية والمدة';
}

// Path: authorities.form
class _Translations$authorities$form$ar extends Translations$authorities$form$fr {
	_Translations$authorities$form$ar._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'مرشد جديد';
	@override String get emailHint => 'name@example.com';
	@override String get isDiscipleMaker => 'هذا هو صانع التلاميذ الخاص بي';
	@override String get isDiscipleMakerHelp => 'الشخص الذي يرافقك شخصيًا. لديك واحد فقط.';
	@override String discipleMakerTaken({required Object name}) => '${name} هو بالفعل صانع التلاميذ الخاص بك. أزِله من القائمة لتختار شخصًا آخر.';
	@override String get submit => 'إضافة';
	@override String added({required Object name}) => 'أصبح ${name} الآن ضمن مرشديك.';
	@override String get searchLabel => 'اسم المستخدم';
	@override String get searchHint => 'اسم المستخدم';
	@override String get search => 'بحث';
	@override String get searchHelp => 'إذا كان الشخص يستخدم CMFI Connect، فابحث عنه باسم المستخدم. سيتلقّى طلبك، وستظهر بيانات الاتصال الخاصة به بعد أن يقبله.';
	@override String notFound({required Object username}) => 'لا أحد يحمل اسم المستخدم @${username}.';
	@override String get invite => 'ادعُه للانضمام إلى CMFI Connect';
	@override String get inviteText => 'مرحبًا! أستخدم CMFI Connect لتدوين مسيرتي مع الله، وأودّ أن ترافقني فيها. ثبّت التطبيق، وأنشئ حسابك، ثم أرسل لي اسم المستخدم الخاص بك لأضيفك.';
	@override String inviteMine({required Object username}) => 'اسم المستخدم الخاص بي: @${username}';
	@override String get manual => 'ليس لديه التطبيق؟ أدخل بياناته';
	@override String get backToSearch => 'البحث باسم المستخدم بدلًا من ذلك';
	@override String get request => 'إرسال الطلب';
	@override String requested({required Object name}) => 'تم إرسال الطلب إلى ${name}.';
	@override String get alreadyAdded => 'هذا الشخص ضمن مرشديك بالفعل.';
	@override String get makerExists => 'لديك صانع تلاميذ بالفعل.';
	@override String get yourself => 'هذا اسم المستخدم الخاص بك.';
	@override String sharingHelp({required Object name}) => 'سيرى ${name} تقاريرك: العناصر المملوءة وانتظامك ونسبك، ولن يرى أبدًا ملاحظتك. يمكنك إيقاف ذلك من بطاقته.';
}

// Path: authorities.sharing
class _Translations$authorities$sharing$ar extends Translations$authorities$sharing$fr {
	_Translations$authorities$sharing$ar._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'مشاركة تقاريري';
	@override String help({required Object name}) => 'يرى ${name} تقاريرك: العناصر المملوءة وانتظامك ونسبك، ولا يرى أبدًا ملاحظتك.';
	@override String on({required Object name}) => 'تقاريرك مُشارَكة مع ${name}.';
	@override String off({required Object name}) => 'لم يعد ${name} يرى تقاريرك.';
}

// Path: members.deleteAccount
class _Translations$members$deleteAccount$ar extends Translations$members$deleteAccount$fr {
	_Translations$members$deleteAccount$ar._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get button => 'حذف حسابي';
	@override String get title => 'حذف حسابي';
	@override String get intro => 'هذا نهائي. سيتم مسح حسابك وكل ما يرتبط به:';
	@override String get itemProfile => 'ملفك الشخصي وصورتك واسم المستخدم وكلمة المرور';
	@override String get itemReports => 'جميع تقاريرك وعناصرك وأهدافك';
	@override String get itemAuthorities => 'مرشدوك الروحيون والطلبات التي تلقيتها';
	@override String get itemEvents => 'تسجيلاتك في الفعاليات';
	@override String get itemPrayer => 'قوائم صلاتك وخلواتك وطلبات اللجاجة الخاصة بك';
	@override String get kept => 'تبقى الفعاليات والأخبار والصور وطلبات الصلاة التي نشرتها بصفتك مشرفًا للمجتمع، من دون اسمك.';
	@override String get passwordHelp => 'للتأكد من أنك أنت.';
	@override String get confirm => 'حذف نهائي';
	@override String get done => 'تم حذف حسابك. باركك الله!';
	@override String get wrongPassword => 'كلمة المرور غير صحيحة.';
	@override String get lastSuperadmin => 'أنت المشرف العام الوحيد: امنح هذا الدور لشخص آخر قبل حذف حسابك.';
}

// Path: hymns.tabs
class _Translations$hymns$tabs$ar extends Translations$hymns$tabs$fr {
	_Translations$hymns$tabs$ar._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get all => 'الكل';
	@override String get favorites => 'المفضلة';
	@override String get recent => 'الأخيرة';
}

// Path: hymns.reader
class _Translations$hymns$reader$ar extends Translations$hymns$reader$fr {
	_Translations$hymns$reader$ar._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get smaller => 'تصغير النص';
	@override String get larger => 'تكبير النص';
	@override String get display => 'العرض';
	@override String get textSize => 'حجم النص';
	@override String get typeface => 'الخط';
	@override String get typefaceAuto => 'تلقائي';
	@override String get typefaceSans => 'عصري';
	@override String get typefaceSerif => 'كلاسيكي';
	@override String get typefaceAutoHelp => 'كلاسيكي عندما يكون النص كبيرًا';
	@override String get background => 'الخلفية';
	@override String get themeAuto => 'تلقائي';
	@override String get themeLight => 'فاتح';
	@override String get themeSepia => 'سيبيا';
	@override String get themeDark => 'داكن';
	@override String get repeatChorus => 'تكرار القرار بعد كل مقطع';
	@override String get keepScreenOn => 'إبقاء الشاشة مضاءة';
	@override String get addFavorite => 'إضافة إلى المفضلة';
	@override String get removeFavorite => 'إزالة من المفضلة';
	@override String get favoriteAdded => 'تمت الإضافة إلى المفضلة';
	@override String get favoriteRemoved => 'تمت الإزالة من المفضلة';
	@override String get more => 'خيارات أخرى';
	@override String get copy => 'نسخ الكلمات';
	@override String get copied => 'تم نسخ الكلمات';
	@override String get project => 'وضع العرض';
	@override String get pinchHint => 'باعد إصبعيك أو قرّبهما على الشاشة لتكبير النص أو تصغيره.';
	@override String get notFound => 'لم تعد هذه الترنيمة موجودة في الكتاب.';
	@override String get share => 'مشاركة الكلمات';
}

// Path: hymns.projection
class _Translations$hymns$projection$ar extends Translations$hymns$projection$fr {
	_Translations$hymns$projection$ar._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get exit => 'الخروج من وضع العرض';
	@override String get previous => 'المقطع السابق';
	@override String get next => 'المقطع التالي';
	@override String position({required Object current, required Object total}) => '${current} / ${total}';
	@override String get hint => 'المس اليسار للتقدّم، واليمين للرجوع.';
}

// Path: hymns.pad
class _Translations$hymns$pad$ar extends Translations$hymns$pad$fr {
	_Translations$hymns$pad$ar._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'الانتقال إلى ترنيمة';
	@override String get open => 'فتح';
	@override String get erase => 'مسح';
	@override String notFound({required Object number}) => 'لا توجد ترنيمة رقم ${number} في هذا الكتاب';
	@override String get placeholder => 'اكتب رقمًا';
}

// Path: events.tabs
class _Translations$events$tabs$ar extends Translations$events$tabs$fr {
	_Translations$events$tabs$ar._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get program => 'البرنامج';
	@override String get news => 'الأخبار';
	@override String get info => 'معلومات';
	@override String get photos => 'الصور';
}

// Path: events.register
class _Translations$events$register$ar extends Translations$events$register$fr {
	_Translations$events$register$ar._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get cta => 'سأشارك';
	@override String get title => 'سأشارك';
	@override String get people => 'كم عددكم؟';
	@override String get peopleHint => 'بمن فيهم أنت، مع عائلتك أو مجموعتك.';
	@override String get less => 'شخص أقل';
	@override String get more => 'شخص إضافي';
	@override String get lodging => 'أحتاج إلى إقامة';
	@override String get lodgingHint => 'يجهّز المنظّمون الأماكن.';
	@override String get departure => 'مدينة الانطلاق';
	@override String get departureHint => 'مثال: Douala';
	@override String get confirm => 'تأكيد تسجيلي';
	@override String get update => 'تحديث';
	@override String get cancel => 'إلغاء تسجيلي';
	@override String get done => 'تم، أنت مسجَّل! سنذكّرك في اليوم السابق.';
	@override String get updated => 'تم تحديث تسجيلك.';
	@override String get cancelled => 'تم إلغاء تسجيلك.';
	@override String get edit => 'تعديل';
	@override String get youAre => 'أنت مسجَّل';
	@override String get cancelTitle => 'إلغاء تسجيلك؟';
	@override String get cancelText => 'سيصبح مكانك متاحًا لشخص آخر.';
	@override String get keep => 'الاحتفاظ بمكاني';
	@override String get lodgingShort => 'إقامة';
}

// Path: events.reminder
class _Translations$events$reminder$ar extends Translations$events$reminder$fr {
	_Translations$events$reminder$ar._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get channel => 'تذكيرات الفعاليات';
	@override String tomorrow({required Object title}) => 'غدًا: ${title}';
	@override String soon({required Object title}) => 'بعد ساعة: ${title}';
}

// Path: events.admin
class _Translations$events$admin$ar extends Translations$events$admin$fr {
	_Translations$events$admin$ar._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'إدارة الفعاليات';
	@override String get create => 'إنشاء فعالية';
	@override String get edit => 'تعديل الفعالية';
	@override String get empty => 'لا توجد فعاليات حتى الآن. أنشئ أول فعالية!';
	@override String get poster => 'الملصق';
	@override String get posterAdd => 'اختيار ملصق';
	@override String get posterChange => 'تغيير الملصق';
	@override String get posterRemove => 'إزالة الملصق';
	@override String get posterHint => 'يُنصح بصيغة عمودية 4:5 (1080 × 1350)، JPEG أو PNG.';
	@override String get uploading => 'جارٍ إرسال الصورة…';
	@override String get general => 'الفعالية';
	@override String get titleField => 'العنوان';
	@override String get titleHint => 'مثال: المؤتمر السنوي 2026';
	@override String get titleRequired => 'أعطِ الفعالية عنوانًا.';
	@override String get theme => 'الموضوع';
	@override String get themeHint => 'مثال: السلوك بالروح';
	@override String get verse => 'آية الموضوع';
	@override String get description => 'الوصف';
	@override String get when => 'التواريخ';
	@override String get starts => 'البداية';
	@override String get ends => 'النهاية';
	@override String get endsBeforeStart => 'يجب أن تكون النهاية بعد البداية.';
	@override String timeZone({required Object zone}) => 'بتوقيت المكان (${zone}).';
	@override String get where => 'المكان';
	@override String get venue => 'المكان';
	@override String get venueHint => 'مثال: مركز المؤتمرات في Mvolyé';
	@override String get address => 'عنوان المكان';
	@override String get city => 'المدينة';
	@override String get country => 'البلد';
	@override String get mapsUrl => 'رابط Google Maps';
	@override String get registration => 'التسجيل';
	@override String get registrationOpen => 'التسجيل مفتوح';
	@override String get deadline => 'آخر موعد';
	@override String get noDeadline => 'بلا موعد نهائي';
	@override String get capacity => 'عدد الأماكن';
	@override String get capacityHint => 'فارغ: بلا حدّ';
	@override String get asksLodging => 'السؤال عمّن يحتاج إلى إقامة';
	@override String get asksDeparture => 'السؤال عن مدينة الانطلاق';
	@override String get fees => 'رسوم المشاركة';
	@override String get feesHint => 'مثال: الدخول مجاني. الوجبات: 2000 FCFA يوميًا.';
	@override String get contact => 'جهة الاتصال';
	@override String get contactName => 'اسم جهة الاتصال';
	@override String get contactPhone => 'هاتف جهة الاتصال';
	@override String get visibility => 'الظهور';
	@override String get statusDraft => 'مسودة';
	@override String get statusDraftHint => 'تظهر للمشرفين فقط';
	@override String get statusPublished => 'منشورة';
	@override String get statusPublishedHint => 'تظهر للمجتمع بأكمله';
	@override String get statusCancelled => 'ملغاة';
	@override String get statusCancelledHint => 'تظهر على أنها ملغاة، دون تسجيل';
	@override String get saved => 'تم حفظ الفعالية.';
	@override String get menu => 'إدارة';
	@override String get program => 'البرنامج';
	@override String get registrants => 'المسجَّلون';
	@override String get post => 'نشر خبر';
	@override String get photos => 'إضافة صور';
	@override String get nextEdition => 'تحضير الدورة التالية';
	@override String get delete => 'حذف الفعالية';
	@override String get deleteTitle => 'حذف هذه الفعالية؟';
	@override String get deleteText => 'سيتم أيضًا حذف التسجيلات والأخبار والصور.';
	@override String get deleteConfirm => 'حذف';
	@override String get deleted => 'تم حذف الفعالية.';
	@override String get nextEditionTitle => 'تحضير الدورة التالية؟';
	@override String get nextEditionText => 'تُنشأ مسودة بعد سنة، بالمكان نفسه والبرنامج نفسه. يمكنك تعديل كل شيء قبل نشرها.';
	@override String get nextEditionConfirm => 'تحضير';
	@override String get nextEditionDone => 'الدورة التالية جاهزة كمسودة.';
	@override String get programEmpty => 'أضف فقرات الفعالية: الاستقبال، العبادة، التعاليم، سهرة الصلاة…';
	@override String get addSession => 'إضافة فقرة';
	@override String get editSession => 'تعديل هذه الفقرة';
	@override String get sessionTitle => 'العنوان';
	@override String get sessionTitleHint => 'مثال: عبادة الافتتاح';
	@override String get speaker => 'المتحدّث';
	@override String get place => 'القاعة';
	@override String get day => 'اليوم';
	@override String get from => 'من';
	@override String get to => 'إلى';
	@override String get hymns => 'الترانيم';
	@override String get hymnsHint => 'الأرقام، مثال: 12، 45';
	@override String get removeSession => 'إزالة';
	@override String get saveProgram => 'حفظ البرنامج';
	@override String get programSaved => 'تم حفظ البرنامج.';
	@override String get registrantsEmpty => 'لم يسجّل أحد بعد.';
	@override String get totalRegistrations => 'التسجيلات';
	@override String get totalPeople => 'الأشخاص';
	@override String get totalLodging => 'بحاجة إلى إقامة';
	@override String get byCity => 'حسب مدينة الانطلاق';
	@override String get list => 'القائمة';
	@override String get exportCsv => 'تصدير القائمة (CSV)';
	@override String get csvHeader => 'الاسم,اسم المستخدم,الهاتف,الكنيسة,الجماعة,الأشخاص,الإقامة,مدينة الانطلاق,تاريخ التسجيل';
	@override String get yes => 'نعم';
	@override String get no => 'لا';
	@override String get postBody => 'الرسالة';
	@override String get postBodyHint => 'مثال: التسجيل مفتوح!';
	@override String get postImage => 'إضافة صورة';
	@override String get postPinned => 'تثبيت في الأعلى';
	@override String get postSend => 'نشر';
	@override String get postDone => 'تم نشر الخبر.';
	@override String get postDelete => 'حذف هذا الخبر';
	@override String get postDeleted => 'تم حذف الخبر.';
	@override String photosAdded({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(n,
		zero: 'تمت إضافة ${n} صورة.',
		one: 'تمت إضافة صورة واحدة.',
		two: 'تمت إضافة صورتين.',
		few: 'تمت إضافة ${n} صور.',
		many: 'تمت إضافة ${n} صورة.',
		other: 'تمت إضافة ${n} صورة.',
	);
	@override String photosSending({required Object done, required Object total}) => 'جارٍ إرسال الصور (${done}/${total})…';
	@override String get photoDelete => 'حذف هذه الصورة';
	@override String get photoDeleted => 'تم حذف الصورة.';
	@override String get confirmDelete => 'حذف';
}

// Path: ministry.goals
class _Translations$ministry$goals$ar extends Translations$ministry$goals$fr {
	_Translations$ministry$goals$ar._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override late final _Translations$ministry$goals$crusade$ar crusade = _Translations$ministry$goals$crusade$ar._(_root);
	@override late final _Translations$ministry$goals$disciples$ar disciples = _Translations$ministry$goals$disciples$ar._(_root);
	@override late final _Translations$ministry$goals$revival$ar revival = _Translations$ministry$goals$revival$ar._(_root);
}

// Path: prayer.hero
class _Translations$prayer$hero$ar extends Translations$prayer$hero$fr {
	_Translations$prayer$hero$ar._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String now({required Object retreat}) => '${retreat} · الآن';
	@override String get title => '15 دقيقة\nمع الرب';
	@override Map<String, String> get preview => {
		'morning': 'قدِّم الشكر، وكرِّس يومك وعملك وعائلتك…',
		'noon': 'جماعتك، وقادتك، و5 أشخاص من قائمتك، والأمم…',
		'evening': 'حياة الصلاة لديك، وخدمتك، والعاملون معك في الخدمة…',
		'night': 'المرضى، والإنجيل في الأمم، والحماية أثناء الليل…',
	};
	@override String get meta => '15 نقطة · دقيقة لكل نقطة';
	@override String get start => 'ابدأ';
	@override String get allDone => 'تمّت خلوات اليوم الأربع. ليستجب الله!';
	@override String doneNow({required Object retreat, required Object next}) => 'تمّت ${retreat}. التالية: ${next}';
}

// Path: prayer.today
class _Translations$prayer$today$ar extends Translations$prayer$today$fr {
	_Translations$prayer$today$ar._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get toPray => 'بانتظارك';
	@override String week({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(n,
		zero: 'لا خلوات هذا الأسبوع',
		one: 'خلوة واحدة هذا الأسبوع',
		two: 'خلوتان هذا الأسبوع',
		few: '${n} خلوات هذا الأسبوع',
		many: '${n} خلوة هذا الأسبوع',
		other: '${n} خلوة هذا الأسبوع',
	);
}

// Path: prayer.routine
class _Translations$prayer$routine$ar extends Translations$prayer$routine$fr {
	_Translations$prayer$routine$ar._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'روتينك اليومي';
	@override String count({required Object done}) => '${done} من 4';
	@override String days({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(n,
		zero: '${n} يوم من 7',
		one: 'يوم واحد من 7',
		two: 'يومان من 7',
		few: '${n} أيام من 7',
		many: '${n} يومًا من 7',
		other: '${n} يوم من 7',
	);
	@override String week({required Object time}) => '${time} هذا الأسبوع';
	@override String get done => 'تمّت · 15 دقيقة';
	@override String get now => 'الآن · 15 دقيقة';
	@override String get next => 'التالية · 15 دقيقة';
	@override String reminder({required Object time}) => 'تذكير في ${time}';
	@override Map<String, String> get later => {
		'morning': 'في الصباح · 15 دقيقة',
		'noon': 'عند الظهر · 15 دقيقة',
		'evening': 'في المساء · 15 دقيقة',
		'night': 'في الليل · 15 دقيقة',
	};
}

// Path: prayer.reminders
class _Translations$prayer$reminders$ar extends Translations$prayer$reminders$fr {
	_Translations$prayer$reminders$ar._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'تذكيرات الخلوات';
	@override String get intro => 'تذكير في موعد كل خلوة، فقط إذا لم تُتمَّها بعد.';
	@override String get off => 'معطّل';
	@override String get channel => 'خلوات الصلاة';
	@override String get body => '15 دقيقة مع الرب.';
}

// Path: prayer.retreat
class _Translations$prayer$retreat$ar extends Translations$prayer$retreat$fr {
	_Translations$prayer$retreat$ar._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'خلوات من 15 دقيقة';
	@override Map<String, String> get hours => {
		'morning': 'عند الاستيقاظ',
		'noon': 'بين 12:00 و14:00',
		'evening': 'في آخر العصر',
		'night': 'قبل النوم',
	};
	@override String reminderAt({required Object time}) => 'تذكير الساعة ${time}';
	@override String get intro => '15 نقطة، دقيقة لكل نقطة. صوت هادئ ينقلك إلى النقطة التالية.';
	@override String get done => 'تمّت اليوم';
	@override String get start => 'ابدأ · 15 دقيقة';
	@override String get selfPaced => 'القراءة على راحتي، دون مؤقّت';
	@override late final _Translations$prayer$retreat$hints$ar hints = _Translations$prayer$retreat$hints$ar._(_root);
}

// Path: prayer.session
class _Translations$prayer$session$ar extends Translations$prayer$session$fr {
	_Translations$prayer$session$ar._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String point({required Object n}) => 'النقطة ${n} من 15';
	@override String get remaining => 'متبقية';
	@override String get paused => 'متوقّف مؤقتًا';
	@override String inYourList({required Object list}) => 'في قائمتك · ${list}';
	@override String get tomorrow => 'وغدًا، الأشخاص التالون.';
	@override String get footer => 'الشاشة مضاءة · صوت هادئ كل دقيقة';
	@override String get previous => 'النقطة السابقة';
	@override String get next => 'النقطة التالية';
	@override String get pause => 'إيقاف مؤقت';
	@override String get resume => 'استئناف';
	@override String get soundOn => 'الصوت مفعّل';
	@override String get soundOff => 'الصوت مكتوم';
	@override String get finish => 'إنهاء الخلوة';
	@override String get quitTitle => 'إيقاف الخلوة؟';
	@override String get quitText => 'لن تُحتسب في يومك.';
	@override String get quit => 'إيقاف';
	@override String get keepPraying => 'متابعة الصلاة';
}

// Path: prayer.done
class _Translations$prayer$done$ar extends Translations$prayer$done$fr {
	_Translations$prayer$done$ar._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String title({required Object retreat}) => 'اكتملت ${retreat}';
	@override String get text => '15 دقيقة مع الرب.\nلقد سمع كل صلاة من صلواتك.';
	@override String get report => 'تمت الإضافة إلى تقريرك';
	@override String reportDetail({required Object added, required Object total}) => 'الصلاة الفردية: +${added} دقيقة · ${total} دقيقة اليوم';
	@override String get undo => 'تراجع';
	@override String get undone => 'أُزيلت الخلوة من يومك.';
	@override String get today => 'اليوم';
	@override String count({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(n,
		zero: '${n} خلوة من 4',
		one: 'خلوة واحدة من 4',
		two: 'خلوتان من 4',
		few: '${n} خلوات من 4',
		many: '${n} خلوة من 4',
		other: '${n} خلوة من 4',
	);
	@override String get verse => '«صلّوا بلا انقطاع.»';
	@override String get reference => 'تسالونيكي الأولى 5: 17';
	@override String get finish => 'إنهاء';
	@override String get hymn => 'رنّم ترنيمة';
}

// Path: prayer.topics
class _Translations$prayer$topics$ar extends Translations$prayer$topics$fr {
	_Translations$prayer$topics$ar._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'طلبات صلاة المجتمع';
	@override String get all => 'عرض الكل';
	@override String get empty => 'لا توجد طلبات صلاة حاليًا. سينشر القادة الطلبات القادمة هنا.';
	@override Map<String, String> get categories => {
		'church': 'الكنيسة',
		'nations': 'الأمم',
		'sick': 'المرضى',
		'event': 'فعالية',
		'fasting': 'صوم',
		'other': 'طلب',
	};
	@override String until({required Object date}) => 'حتى ${date}';
	@override String get archive => 'الطلبات السابقة';
	@override String get archiveEmpty => 'لا توجد طلبات سابقة.';
	@override String get current => 'حاليًا';
	@override String documentSize({required Object kb}) => '${kb} ك.ب';
	@override String get download => 'تنزيل ملف PDF';
	@override String get noDocument => 'لا يوجد ملف PDF';
	@override String get openDocument => 'فتح ملف PDF';
}

// Path: prayer.lists
class _Translations$prayer$lists$ar extends Translations$prayer$lists$fr {
	_Translations$prayer$lists$ar._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'قوائم صلاتي';
	@override String get private => 'لك وحدك';
	@override Map<String, String> get names => {
		'unbelievers': 'لم يؤمنوا بعد',
		'believers': 'المؤمنون',
		'backsliders': 'المرتدّون',
		'coworkers': 'العاملون معك',
	};
	@override Map<String, String> get uses => {
		'unbelievers': 'تصلّي خلوة الظهر كل يوم من أجل 10 أشخاص من هذه القائمة (5 + 5)، بالتناوب.',
		'believers': 'تصلّي خلوة الظهر كل يوم من أجل 5 أشخاص من هذه القائمة، بالتناوب.',
		'backsliders': 'تصلّي خلوة الظهر كل يوم من أجل 5 أشخاص من هذه القائمة، بالتناوب.',
		'coworkers': 'تصلّي خلوة المساء كل يوم من أجل 10 من العاملين معك في الخدمة (5 + 5)، بالتناوب.',
	};
	@override String get privateNote => 'لا يراها أحد غيرك.';
	@override String count({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(n,
		zero: 'لا أحد',
		one: 'شخص واحد',
		two: 'شخصان',
		few: '${n} أشخاص',
		many: '${n} شخصًا',
		other: '${n} شخص',
	);
	@override String get empty => 'لا أحد حتى الآن. أضف الذين تصلّي من أجلهم.';
	@override String get add => 'إضافة شخص';
	@override String get prayedToday => 'اليوم';
	@override String get next => 'قريبًا';
	@override Map<String, String> get answeredTitle => {
		'unbelievers': 'آمنوا بالرب',
		'believers': 'صلوات مستجابة',
		'backsliders': 'رجعوا إلى الرب',
		'coworkers': 'صلوات مستجابة',
	};
	@override late final _Translations$prayer$lists$answeredOn$ar answeredOn = _Translations$prayer$lists$answeredOn$ar._(_root);
	@override Map<String, String> get markAnswered => {
		'unbelievers': 'آمن بالرب!',
		'believers': 'استُجيبت الصلاة',
		'backsliders': 'رجع إلى الرب!',
		'coworkers': 'استُجيبت الصلاة',
	};
	@override String get answeredToast => 'المجد لله!';
	@override String get putBack => 'إعادة إلى القائمة';
	@override String answeredBanner({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(n,
		zero: '${n} صلاة مستجابة هذا الشهر',
		one: 'صلاة واحدة مستجابة هذا الشهر',
		two: 'صلاتان مستجابتان هذا الشهر',
		few: '${n} صلوات مستجابة هذا الشهر',
		many: '${n} صلاة مستجابة هذا الشهر',
		other: '${n} صلاة مستجابة هذا الشهر',
	);
	@override String lastAnswered({required Object name, required Object what}) => '${name}: ${what}';
	@override late final _Translations$prayer$lists$sheet$ar sheet = _Translations$prayer$lists$sheet$ar._(_root);
	@override String get addShort => 'إضافة';
}

// Path: prayer.importunity
class _Translations$prayer$importunity$ar extends Translations$prayer$importunity$fr {
	_Translations$prayer$importunity$ar._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'طلبات اللجاجة';
	@override String get newTopic => 'طلب جديد';
	@override String get intro => 'طلب نرفعه إلى الرب بلا كلل حتى تأتي الاستجابة. حدّد عددًا من الإعلانات، وادعُ إخوتك وأخواتك ليصلّوا معك.';
	@override String invitedBy({required Object name}) => '${name} يدعوك إلى الصلاة';
	@override String get join => 'أصلّي معكم';
	@override String get decline => 'ليس الآن';
	@override String get joined => 'أنت الآن تصلّي من أجل هذا الطلب.';
	@override String progress({required Object total, required Object goal}) => '${total} من ${goal}';
	@override String total({required num n, required Object count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(n,
		zero: '${count} إعلان',
		one: 'إعلان واحد',
		two: 'إعلانان',
		few: '${count} إعلانات',
		many: '${count} إعلانًا',
		other: '${count} إعلان',
	);
	@override String get reached => 'تحقّق الهدف!';
	@override String get closed => 'مُغلق';
	@override String participants({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(n,
		zero: 'لا أحد يصلّي بعد',
		one: 'شخص واحد يصلّي',
		two: 'شخصان يصلّيان',
		few: '${n} أشخاص يصلّون',
		many: '${n} شخصًا يصلّون',
		other: '${n} شخص يصلّون',
	);
	@override String mine({required Object n}) => 'أنت: ${n}';
	@override String get tapHint => 'المس الشاشة مع كل إعلان';
	@override String get addMany => 'إضافة عدد';
	@override String get addManyTitle => 'كم عدد الإعلانات؟';
	@override String get addManyLabel => 'الإعلانات';
	@override String get add => 'إضافة';
	@override String pending({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(n,
		zero: '${n} إعلان بانتظار الإرسال',
		one: 'إعلان واحد بانتظار الإرسال',
		two: 'إعلانان بانتظار الإرسال',
		few: '${n} إعلانات بانتظار الإرسال',
		many: '${n} إعلانًا بانتظار الإرسال',
		other: '${n} إعلان بانتظار الإرسال',
	);
	@override String get invite => 'دعوة';
	@override String get members => 'المصلّون';
	@override String waiting({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(n,
		zero: '${n} دعوة بانتظار الرد',
		one: 'دعوة واحدة بانتظار الرد',
		two: 'دعوتان بانتظار الرد',
		few: '${n} دعوات بانتظار الرد',
		many: '${n} دعوة بانتظار الرد',
		other: '${n} دعوة بانتظار الرد',
	);
	@override String get edit => 'تعديل';
	@override String get close => 'إغلاق الطلب';
	@override String get reopen => 'إعادة فتح الطلب';
	@override String get delete => 'حذف الطلب';
	@override String get deleteTitle => 'حذف هذا الطلب؟';
	@override String get deleteText => 'سيختفي لدى كل من يصلّون معك.';
	@override String get leave => 'الانسحاب من هذا الطلب';
	@override String get leaveTitle => 'الانسحاب من هذا الطلب؟';
	@override String get leaveText => 'تبقى إعلاناتك ضمن المجموع.';
	@override late final _Translations$prayer$importunity$form$ar form = _Translations$prayer$importunity$form$ar._(_root);
	@override late final _Translations$prayer$importunity$inviteSheet$ar inviteSheet = _Translations$prayer$importunity$inviteSheet$ar._(_root);
	@override String get eyebrow => 'موضوع لجاجة';
	@override String get proclaim => 'أُعلن';
}

// Path: streak.lines
class _Translations$streak$lines$ar extends Translations$streak$lines$fr {
	_Translations$streak$lines$ar._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get week => 'أسبوع كامل مع الرب، يومًا بعد يوم. أحسنت، تابع!';
	@override String get month => 'شهر من الأمانة! ما تزرعه كل يوم يأتي بثمر.';
	@override String get hundred => 'مئة يوم مع الله! مثابرتك شهادة جميلة.';
	@override String get year => 'سنة كاملة مع الله! المجد له على أمانتك.';
}

// Path: blocking.reasons
class _Translations$blocking$reasons$ar extends Translations$blocking$reasons$fr {
	_Translations$blocking$reasons$ar._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get spam => 'غير مرغوب فيه';
	@override String get offensive => 'محتوى صادم أو مسيء';
	@override String get other => 'سبب آخر';
}

// Path: bible.colors
class _Translations$bible$colors$ar extends Translations$bible$colors$fr {
	_Translations$bible$colors$ar._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get yellow => 'الأصفر';
	@override String get green => 'الأخضر';
	@override String get blue => 'الأزرق';
	@override String get pink => 'الوردي';
}

// Path: reports.units.chapters
class _Translations$reports$units$chapters$ar extends Translations$reports$units$chapters$fr {
	_Translations$reports$units$chapters$ar._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get name => 'عدد الفصول';
	@override String get label => 'عدد الفصول';
	@override String get symbol => 'فصول';
	@override String count({required num n, required Object value}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(n,
		zero: '${value} فصل',
		one: 'فصل واحد',
		two: 'فصلان',
		few: '${value} فصول',
		many: '${value} فصلًا',
		other: '${value} فصل',
	);
}

// Path: reports.units.times
class _Translations$reports$units$times$ar extends Translations$reports$units$times$fr {
	_Translations$reports$units$times$ar._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get name => 'عدد المرات';
	@override String get label => 'عدد المرات';
	@override String get symbol => 'مرات';
	@override String count({required num n, required Object value}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(n,
		zero: '${value} مرة',
		one: 'مرة واحدة',
		two: 'مرتان',
		few: '${value} مرات',
		many: '${value} مرة',
		other: '${value} مرة',
	);
}

// Path: reports.units.pages
class _Translations$reports$units$pages$ar extends Translations$reports$units$pages$fr {
	_Translations$reports$units$pages$ar._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get name => 'عدد الصفحات';
	@override String get label => 'عدد الصفحات';
	@override String get symbol => 'صفحات';
	@override String count({required num n, required Object value}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(n,
		zero: '${value} صفحة',
		one: 'صفحة واحدة',
		two: 'صفحتان',
		few: '${value} صفحات',
		many: '${value} صفحةً',
		other: '${value} صفحة',
	);
}

// Path: reports.units.percent
class _Translations$reports$units$percent$ar extends Translations$reports$units$percent$fr {
	_Translations$reports$units$percent$ar._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get name => 'النسبة المئوية';
	@override String get label => 'النسبة المئوية';
	@override String get symbol => '%';
	@override String count({required Object value}) => '${value}%';
}

// Path: ministry.goals.crusade
class _Translations$ministry$goals$crusade$ar extends Translations$ministry$goals$crusade$fr {
	_Translations$ministry$goals$crusade$ar._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'حملة الإنجيل لكل خليقة';
	@override String get text => 'أن نكرز بالإنجيل لكل من سيعيش في جيلنا، حتى يصل الإنجيل المكروز به بقوة الروح القدس إلى 10 مليارات شخص، مستخدمين كل وسائل الاتصال (كتبنا ونبذاتنا ومجلاتنا وأقراصنا المدمجة وأقراص الفيديو والإذاعة والتلفزيون والإنترنت) بأقصى سرعة ممكنة.';
	@override String get reached => 'شخص يصلهم الإنجيل';
}

// Path: ministry.goals.disciples
class _Translations$ministry$goals$disciples$ar extends Translations$ministry$goals$disciples$fr {
	_Translations$ministry$goals$disciples$ar._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'تلمذة التلاميذ';
	@override String get text => 'أن نقود مليار شخص في 250 أمة إلى معرفة يسوع المسيح ربًا ومخلّصًا، وأن يصيروا تلاميذ يطيعونه في كل شيء، ومنظَّمين للاجتماع في 25 مليون كنيسة بيتية بحلول عام 2065.';
	@override String get people => 'تلميذ';
	@override String get nations => 'أمة';
	@override String get churches => 'كنيسة بيتية';
	@override String by({required Object year}) => 'بحلول ${year}';
}

// Path: ministry.goals.revival
class _Translations$ministry$goals$revival$ar extends Translations$ministry$goals$revival$fr {
	_Translations$ministry$goals$revival$ar._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'التعجيل بالنهضة العالمية';
	@override String get text => 'أن نعمل مع الله بالصوم والتشفع من أجل النهضة العالمية التي ستشق السماوات وتزلزل الأرض وتمجد المسيح في جيلنا، لنعجّل بالعودة الوشيكة لربنا يسوع المسيح من السماء للقاء عروسه المُهيَّأة.';
	@override String get fasting => 'الصوم';
	@override String get intercession => 'التشفع';
	@override String get pray => 'صلِّ الآن';
}

// Path: prayer.retreat.hints
class _Translations$prayer$retreat$hints$ar extends Translations$prayer$retreat$hints$fr {
	_Translations$prayer$retreat$hints$ar._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String assembly({required Object name}) => 'جماعتك: ${name}';
	@override String get assemblyMissing => 'أضف جماعتك في ملفك الشخصي';
	@override String authorities({required Object names}) => 'مرشدوك: ${names}';
	@override String get authoritiesMissing => 'أضف مرشديك الروحيين من «المزيد»';
	@override String list({required Object list}) => 'قوائمي · ${list}';
	@override String listEmpty({required Object list}) => 'قائمتك «${list}» فارغة: أضف أسماء';
	@override String nation({required Object name}) => 'اليوم: ${name}';
	@override String myCountry({required Object name}) => 'بلدك: ${name}';
	@override String get hymn => 'فتح الترانيم';
}

// Path: prayer.lists.answeredOn
class _Translations$prayer$lists$answeredOn$ar extends Translations$prayer$lists$answeredOn$fr {
	_Translations$prayer$lists$answeredOn$ar._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String unbelievers({required Object date}) => 'آمن بالرب في ${date}';
	@override String believers({required Object date}) => 'استُجيبت الصلاة في ${date}';
	@override String backsliders({required Object date}) => 'رجع إلى الرب في ${date}';
	@override String coworkers({required Object date}) => 'استُجيبت الصلاة في ${date}';
}

// Path: prayer.lists.sheet
class _Translations$prayer$lists$sheet$ar extends Translations$prayer$lists$sheet$fr {
	_Translations$prayer$lists$sheet$ar._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get addTitle => 'إضافة شخص';
	@override String get editTitle => 'تعديل';
	@override String get name => 'الاسم';
	@override String get namePlaceholder => 'بولس م.';
	@override String get note => 'ملاحظة';
	@override String get notePlaceholder => 'زميل، جار، ابنة عم…';
	@override String get list => 'القائمة';
	@override String get save => 'حفظ';
	@override String get remove => 'إزالة من القائمة';
	@override String removeTitle({required Object name}) => 'إزالة ${name}؟';
	@override String get removeText => 'لن تصلّي بعد الآن من أجل هذا الشخص في خلواتك.';
}

// Path: prayer.importunity.form
class _Translations$prayer$importunity$form$ar extends Translations$prayer$importunity$form$fr {
	_Translations$prayer$importunity$form$ar._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get newTitle => 'طلب لجاجة جديد';
	@override String get editTitle => 'تعديل الطلب';
	@override String get subject => 'الطلب';
	@override String get subjectPlaceholder => 'يا رب، خلِّص بولس';
	@override String get description => 'التفاصيل';
	@override String get descriptionPlaceholder => 'لأجل مَن، ولماذا…';
	@override String get goal => 'الهدف';
	@override String get goalHint => 'عدد الإعلانات الذي تريدون بلوغه معًا. اتركه فارغًا للعدّ دون هدف.';
	@override String get goalPlaceholder => '10000';
	@override String get create => 'إنشاء';
	@override String get save => 'حفظ';
}

// Path: prayer.importunity.inviteSheet
class _Translations$prayer$importunity$inviteSheet$ar extends Translations$prayer$importunity$inviteSheet$fr {
	_Translations$prayer$importunity$inviteSheet$ar._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'الدعوة إلى الصلاة';
	@override String get family => 'عائلتي الروحية';
	@override String familyText({required num n, required Object name}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(n,
		zero: '${name} وتلاميذه: لا أحد',
		one: '${name} وتلاميذه: شخص واحد',
		two: '${name} وتلاميذه: شخصان',
		few: '${name} وتلاميذه: ${n} أشخاص',
		many: '${name} وتلاميذه: ${n} شخصًا',
		other: '${name} وتلاميذه: ${n} شخص',
	);
	@override String get familyMissing => 'اربط صانع التلاميذ الخاص بك في «مرشديّ الروحيون» لتدعو عائلتك الروحية.';
	@override String get byUsername => 'باسم المستخدم';
	@override String get usernameLabel => 'اسم المستخدم';
	@override String get addUsername => 'إضافة';
	@override String get send => 'إرسال الدعوات';
	@override String sent({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(n,
		zero: 'كانوا مدعوّين بالفعل.',
		one: 'تم إرسال دعوة واحدة',
		two: 'تم إرسال دعوتين',
		few: 'تم إرسال ${n} دعوات',
		many: 'تم إرسال ${n} دعوة',
		other: 'تم إرسال ${n} دعوة',
	);
}

/// The flat map containing all translations for locale <ar>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsAr {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'app.name' => 'CMFI Connect',
			'app.tagline' => 'ننمو معًا، كل يوم.',
			'app.languageName' => 'العربية',
			'common.retry' => 'إعادة المحاولة',
			'common.cancel' => 'إلغاء',
			'common.save' => 'حفظ',
			'common.close' => 'إغلاق',
			'common.back' => 'رجوع',
			'common.soon' => 'قريبًا',
			'common.optional' => '(اختياري)',
			'common.and' => 'و',
			'common.loading' => 'جارٍ التحميل…',
			'common.done' => 'تم',
			'common.rangeStart' => 'من',
			'common.rangeEnd' => 'إلى',
			'errors.network' => 'لا يوجد اتصال بالإنترنت. تحقّق من شبكتك وحاول مجددًا.',
			'errors.unauthorized' => 'انتهت صلاحية جلستك. سجّل الدخول مجددًا.',
			'errors.invalidCredentials' => 'رقم الهاتف أو كلمة المرور غير صحيحة.',
			'errors.badRequest' => 'بعض المعلومات غير صالحة.',
			'errors.conflict' => 'هذا العنصر موجود بالفعل.',
			'errors.notFound' => 'العنصر غير موجود.',
			'errors.server' => 'واجه الخادم مشكلة. حاول مجددًا بعد قليل.',
			'errors.unknown' => 'حدث خطأ. حاول مجددًا.',
			'errors.forbidden' => 'ليست لديك صلاحية للقيام بذلك.',
			'errors.eventFull' => 'لم يعد هناك مكان متاح في هذه الفعالية.',
			'errors.registrationClosed' => 'التسجيل في هذه الفعالية مغلق.',
			'errors.mediaTooLarge' => 'حجم هذه الصورة كبير جدًا (8 ميغابايت كحدّ أقصى).',
			'errors.mediaUnsupported' => 'اختر صورة بصيغة JPEG أو PNG.',
			'errors.notParticipant' => 'انضمّ أولًا إلى هذا الطلب لتُحتسب إعلاناتك.',
			'errors.importunityClosed' => 'هذا الطلب مُغلق: لم يعد يحتسب الإعلانات.',
			'errors.usernameNotFound' => 'لا أحد يحمل اسم المستخدم هذا. تحقّق من كتابته.',
			'errors.ownerCannotLeave' => 'أنت من أنشأ هذا الطلب: احذفه بدلًا من الانسحاب منه.',
			'errors.tooManyPeople' => 'قوائمك ممتلئة (500 شخص كحدّ أقصى).',
			'errors.avatarInvalid' => 'لا يمكن استخدام هذه الصورة. اختر صورة أخرى.',
			'errors.reportsNotShared' => 'لم يعد هذا العضو يشارك تقاريره.',
			'validation.required' => 'هذا الحقل مطلوب',
			'validation.passwordTooShort' => '6 أحرف على الأقل',
			'validation.invalidPhone' => 'رقم هاتف غير صالح',
			'validation.invalidEmail' => 'عنوان بريد إلكتروني غير صالح',
			'validation.invalidCode' => 'أحرف وأرقام فقط، دون مسافات',
			'onboarding.skip' => 'تخطٍّ',
			'onboarding.next' => 'التالي',
			'onboarding.start' => 'ابدأ',
			'onboarding.step' => ({required Object current, required Object total}) => 'الشاشة ${current} من ${total}',
			'onboarding.reports.title' => 'مسيرتك مع الله، يومًا بعد يوم',
			'onboarding.reports.text' => 'سجّل في ثوانٍ قراءتك للكتاب المقدس، وصلاتك، وصومك… وتابع تقدّمك أسبوعًا بعد أسبوع.',
			'onboarding.worship.title' => 'رنّم وصلِّ أينما كنت',
			'onboarding.worship.text' => 'اعثر على ترانيم المجتمع، واحمل كل يوم طلبات الصلاة مع إخوتك وأخواتك.',
			'onboarding.community.title' => 'ابقَ على صلة بمجتمعك',
			'onboarding.community.text' => 'فعاليات جماعتك وإعلاناتها في مكان واحد، حتى لا يفوتك شيء.',
			'onboarding.sample.today' => 'اليوم',
			'onboarding.sample.bibleReading' => 'قراءة الكتاب المقدس',
			'onboarding.sample.prayerAlone' => 'الصلاة الفردية',
			'onboarding.sample.meditation' => 'التأمل',
			'onboarding.sample.groupPrayer' => 'الصلاة الجماعية',
			'onboarding.sample.thisWeek' => 'هذا الأسبوع',
			'onboarding.sample.weekScore' => '4 أيام من 5',
			'onboarding.sample.hymn' => 'ترنيمة',
			'onboarding.sample.hymnNumber' => 'رقم 12',
			'onboarding.sample.fullScreen' => 'ملء الشاشة',
			'onboarding.sample.prayerOfTheDay' => 'طلب الصلاة لهذا اليوم',
			'onboarding.sample.prayerTopic' => 'من أجل امتحانات شبابنا',
			'onboarding.sample.praying' => '12 شخصًا يصلّون',
			'onboarding.sample.iPray' => 'أصلّي',
			'onboarding.sample.vigil' => 'سهرة صلاة',
			'onboarding.sample.vigilMeta' => '20:00 · الجماعة المحلية',
			'onboarding.sample.join' => 'سأشارك',
			'onboarding.sample.retreat' => 'خلوة الشباب',
			'onboarding.sample.retreatMeta' => 'طوال اليوم',
			'onboarding.sample.announcement' => 'إعلان',
			'onboarding.sample.announcementText' => 'تبدأ عبادة الأحد في الساعة 8:30 صباحًا.',
			'onboarding.sample.chapters' => '10 إصحاحات',
			'welcome.title' => 'مرحبًا بك في CMFI Connect',
			'welcome.text' => 'أنشئ حسابك في دقيقة واحدة لتملأ تقريرك اليومي وتتابع حياة مجتمعك.',
			'welcome.createAccount' => 'إنشاء حسابي',
			'welcome.haveAccount' => 'لديّ حساب بالفعل',
			'auth.phone' => 'الهاتف',
			'auth.dialCode' => ({required Object code}) => 'رمز الدولة: ${code}',
			'auth.password' => 'كلمة المرور',
			'auth.showPassword' => 'إظهار كلمة المرور',
			'auth.hidePassword' => 'إخفاء كلمة المرور',
			'auth.login.title' => 'مرحبًا بعودتك',
			'auth.login.subtitle' => 'سجّل الدخول لتملأ تقرير اليوم.',
			'auth.login.submit' => 'تسجيل الدخول',
			'auth.login.noAccount' => 'ليس لديك حساب بعد؟',
			'auth.login.createAccount' => 'إنشاء حساب',
			'auth.register.step' => ({required Object current, required Object total}) => '${current} / ${total}',
			'auth.register.title' => 'أنشئ حسابك',
			'auth.register.subtitle' => 'ستستخدم رقم هاتفك لتسجيل الدخول.',
			'auth.register.firstName' => 'الاسم الأول',
			'auth.register.lastName' => 'اسم العائلة',
			'auth.register.passwordHelp' => '6 أحرف على الأقل',
			'auth.register.email' => 'البريد الإلكتروني',
			'auth.register.submit' => 'متابعة',
			'auth.register.haveAccount' => 'لديك حساب بالفعل؟',
			'auth.register.login' => 'تسجيل الدخول',
			'auth.register.alreadyUsed' => 'هذا الرقم أو هذا البريد الإلكتروني مرتبط بحساب بالفعل. سجّل الدخول.',
			'auth.register.emailHint' => 'name@example.com',
			'auth.church.title' => 'كنيستك',
			'auth.church.subtitle' => 'تساعد هذه المعلومات قادتك على الوصول إليك. يمكنك تعديلها لاحقًا.',
			'auth.church.editTitle' => 'ملفي الشخصي',
			'auth.church.editSubtitle' => 'حدّث اسمك وكنيستك وجماعتك.',
			'auth.church.country' => 'البلد',
			'auth.church.countryHint' => 'اختر بلدك',
			'auth.church.city' => 'المدينة',
			'auth.church.cityHint' => 'Yaoundé',
			'auth.church.church' => 'الكنيسة',
			'auth.church.churchHint' => 'اسم كنيستك',
			'auth.church.assembly' => 'الجماعة',
			'auth.church.assemblyHint' => 'اسم جماعتك',
			'auth.church.info' => 'انتقلت إلى مكان آخر أو غيّرت جماعتك؟ يمكنك تحديث كل شيء من ملفك الشخصي.',
			'auth.church.submit' => 'إنهاء',
			'auth.church.skip' => 'تخطَّ هذه الخطوة',
			'auth.church.saved' => 'تم حفظ الملف الشخصي',
			'auth.forgot.link' => 'نسيت كلمة المرور؟',
			'auth.forgot.title' => 'نسيت كلمة المرور',
			'auth.forgot.phoneText' => 'أدخل رقمك: سنرسل لك رمزًا عبر رسالة قصيرة لاختيار كلمة مرور جديدة.',
			'auth.forgot.sendCode' => 'استلام الرمز',
			'auth.forgot.codeTitle' => 'أدخل الرمز',
			'auth.forgot.codeText' => ({required Object phone}) => 'أرسلنا رمزًا من 6 أرقام إلى ${phone}.',
			'auth.forgot.code' => 'الرمز المستلم عبر الرسالة',
			'auth.forgot.codeInvalid' => 'يتكون الرمز من 6 أرقام',
			'auth.forgot.verify' => 'تحقق',
			'auth.forgot.resend' => 'إعادة إرسال الرمز',
			'auth.forgot.resendIn' => ({required Object seconds}) => 'إعادة الإرسال بعد ${seconds} ث',
			'auth.forgot.changeNumber' => 'تغيير الرقم',
			'auth.forgot.passwordTitle' => 'كلمة مرور جديدة',
			'auth.forgot.passwordText' => 'اختر كلمة مرور جديدة لحسابك.',
			'auth.forgot.submit' => 'حفظ وتسجيل الدخول',
			'auth.forgot.done' => 'تم تغيير كلمة المرور. مرحبًا بعودتك!',
			'auth.forgot.remembered' => 'تذكّرتها؟',
			'auth.forgot.invalidCode' => 'هذا الرمز غير صحيح.',
			'auth.forgot.expired' => 'انتهت صلاحية الرمز. اطلب رمزًا جديدًا.',
			'auth.forgot.tooManyRequests' => 'محاولات كثيرة. حاول مجددًا بعد قليل.',
			'auth.forgot.unavailable' => 'إعادة التعيين غير متاحة حاليًا.',
			'auth.forgot.noAccount' => 'لا يوجد حساب بهذا الرقم.',
			'countries.dialCodeTitle' => 'رمز الدولة',
			'countries.title' => 'بلدك',
			'countries.search' => 'ابحث عن دولة أو رمز',
			'countries.none' => 'لا توجد دولة مطابقة',
			'countries.change' => 'تغيير الدولة',
			'nav.home' => 'الرئيسية',
			'nav.reports' => 'التقرير',
			'nav.hymns' => 'الترانيم',
			'nav.prayer' => 'الصلاة',
			'nav.bible' => 'الكتاب المقدس',
			'home.greeting' => ({required Object name}) => 'مرحبًا ${name}',
			'home.greetingNoName' => 'مرحبًا',
			'home.profile' => 'ملفي الشخصي',
			'home.todayTitle' => 'تقرير اليوم',
			'home.progress' => ({required Object filled, required Object total}) => '${filled} من ${total}',
			'home.progressLabel' => 'عناصر معبّأة',
			'home.goals' => 'الأهداف',
			'home.continueReport' => 'متابعة',
			'home.startReport' => 'ابدأ',
			'home.weekTitle' => 'أسبوعك',
			'home.weekScore' => ({required num filled, required Object total}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(filled, zero: '${filled} يوم من ${total}', one: 'يوم واحد من ${total}', two: 'يومان من ${total}', few: '${filled} أيام من ${total}', many: '${filled} يومًا من ${total}', other: '${filled} يوم من ${total}', ), 
			'home.community' => 'حاليًا في CMFI',
			'home.eventsTitle' => 'الفعاليات',
			'home.hymnsTitle' => 'الترانيم',
			'home.hymnsResume' => ({required Object number}) => 'العودة إلى رقم ${number}',
			'home.hymnsOpen' => 'فتح كتاب الترانيم',
			'home.streak' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(n, zero: '${n} يوم على التوالي', one: 'يوم واحد على التوالي', two: 'يومان على التوالي', few: '${n} أيام على التوالي', many: '${n} يومًا على التوالي', other: '${n} يوم على التوالي', ), 
			'home.streakKeep' => 'املأ تقرير اليوم لتواصل',
			'home.streakToday' => 'أحسنت، تابع غدًا!',
			'reports.title' => 'التقرير',
			'reports.myItems' => 'عناصري',
			'reports.tabs.today' => 'اليوم',
			'reports.tabs.history' => 'السجل',
			'reports.tabs.summary' => 'الملخص',
			'reports.pickDay' => 'اختر اليوم',
			'reports.filled' => ({required Object filled, required Object total}) => 'تمت تعبئة ${filled} من ${total}',
			'reports.statusSaved' => 'تم الحفظ',
			'reports.statusModified' => 'غير محفوظ',
			'reports.standard' => 'الأساسية',
			'reports.personal' => 'عناصري',
			'reports.createItem' => 'إنشاء عنصر',
			'reports.add' => ({required Object label}) => 'إضافة ${label}',
			'reports.note' => 'ملاحظة اليوم',
			'reports.noteHint' => 'آية، سبب للشكر…',
			'reports.save' => 'حفظ اليوم',
			'reports.saved' => 'تم حفظ اليوم',
			'reports.measure.quantity' => ({required Object unit}) => '${unit}',
			'reports.measure.duration' => 'المدة',
			'reports.measure.both' => ({required Object unit}) => '${unit} والمدة',
			'reports.measure.quantityNoUnit' => 'الكمية',
			'reports.measure.bothNoUnit' => 'الكمية والمدة',
			'reports.times' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(n, zero: '${n} مرة', one: 'مرة واحدة', two: 'مرتان', few: '${n} مرات', many: '${n} مرة', other: '${n} مرة', ), 
			'reports.sheet.quantity' => 'الكمية',
			'reports.sheet.duration' => 'المدة',
			'reports.sheet.minus1' => '− 1 دقيقة',
			'reports.sheet.plus1' => '+ 1 دقيقة',
			'reports.sheet.removeMinute' => 'إنقاص دقيقة',
			'reports.sheet.addMinute' => 'إضافة دقيقة',
			'reports.sheet.holdToRepeat' => 'اضغط مطوّلًا للإسراع',
			'reports.sheet.decrease' => 'إنقاص',
			'reports.sheet.increase' => 'زيادة',
			'reports.sheet.clear' => 'مسح',
			'reports.sheet.validate' => 'تأكيد',
			'reports.history.daysFilled' => ({required Object filled, required Object total}) => 'الأيام المعبّأة: ${filled} من ${total}',
			'reports.history.legendFilled' => 'معبّأ',
			'reports.history.legendMissing' => 'لا يوجد تقرير',
			'reports.history.none' => 'لا يوجد تقرير',
			'reports.history.fill' => 'املأ',
			'reports.history.inProgress' => 'جارٍ',
			'reports.history.previousMonth' => 'الشهر السابق',
			'reports.history.nextMonth' => 'الشهر التالي',
			'reports.history.today' => 'اليوم',
			'reports.summary.week' => 'الأسبوع',
			'reports.summary.month' => 'الشهر',
			'reports.summary.year' => 'السنة',
			'reports.summary.range' => ({required Object from, required Object to}) => 'من ${from} إلى ${to}',
			'reports.summary.regularity' => 'الانتظام',
			'reports.summary.daysFilled' => 'أيام معبّأة',
			'reports.summary.missingDays' => ({required num n, required Object days}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(n, zero: '${n} يوم بلا تقرير: ${days}', one: 'يوم واحد بلا تقرير: يوم ${days}', two: 'يومان بلا تقرير: ${days}', few: '${n} أيام بلا تقرير: ${days}', many: '${n} يومًا بلا تقرير: ${days}', other: '${n} يوم بلا تقرير: ${days}', ), 
			'reports.summary.missingCount' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(n, zero: '${n} يوم بلا تقرير', one: 'يوم واحد بلا تقرير', two: 'يومان بلا تقرير', few: '${n} أيام بلا تقرير', many: '${n} يومًا بلا تقرير', other: '${n} يوم بلا تقرير', ), 
			'reports.summary.noMissing' => 'لم يفُتك أي يوم، أحسنت!',
			'reports.summary.perDay' => ({required Object value}) => '${value} لكل يوم معبّأ',
			'reports.summary.days' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(n, zero: '${n} يوم', one: 'يوم واحد', two: 'يومان', few: '${n} أيام', many: '${n} يومًا', other: '${n} يوم', ), 
			'reports.summary.notFilled' => 'لم تُعبّأ بعد',
			'reports.summary.barsCaption' => ({required Object max}) => 'لكل يوم · أعلى عمود: ${max}',
			'reports.summary.barsCaptionMonthly' => ({required Object max}) => 'لكل شهر · أعلى عمود: ${max}',
			'reports.summary.empty' => 'لا توجد تقارير في هذه الفترة.',
			'reports.summary.goalDays' => ({required num n, required Object total}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(n, zero: 'تحقّق الهدف في ${n} يوم من ${total}', one: 'تحقّق الهدف في يوم واحد من ${total}', two: 'تحقّق الهدف في يومين من ${total}', few: 'تحقّق الهدف في ${n} أيام من ${total}', many: 'تحقّق الهدف في ${n} يومًا من ${total}', other: 'تحقّق الهدف في ${n} يوم من ${total}', ), 
			'reports.summary.share' => 'مشاركة هذا الملخص',
			'reports.summary.goals' => 'الأهداف',
			'reports.summary.goalsAverage' => 'متوسط تحقيق أهدافك',
			'reports.summary.goalsHint' => 'كل يوم يُحتسب، حتى الفارغ. يُحتسب اليوم بعد تعبئته.',
			'reports.summary.evolution' => 'تطوّر أهدافك',
			'reports.summary.evolutionHint' => 'أسبوعًا بعد أسبوع، خلال آخر 12 أسبوعًا.',
			'reports.summary.premiumYear' => 'السنة وتطوّر أهدافك متاحان مع Premium.',
			'reports.noItems' => 'لا توجد عناصر لتعبئتها حاليًا.',
			'reports.statusPending' => 'لم يُرسَل بعد',
			'reports.savedOffline' => 'لا توجد شبكة: اليوم محفوظ على هاتفك وسيُرسَل في أقرب وقت ممكن.',
			'reports.pendingBanner' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(n, zero: '${n} يوم بانتظار الشبكة لإرساله', one: 'يوم واحد بانتظار الشبكة لإرساله', two: 'يومان بانتظار الشبكة لإرسالهما', few: '${n} أيام بانتظار الشبكة لإرسالها', many: '${n} يومًا بانتظار الشبكة لإرسالها', other: '${n} يوم بانتظار الشبكة لإرسالها', ), 
			'reports.export' => 'تصدير تقريري',
			'reports.goal' => ({required Object value}) => 'الهدف: ${value}',
			'reports.goalReached' => 'تحقّق الهدف',
			'reports.dayGoals' => 'أهداف اليوم',
			'reports.goalsReached' => ({required Object reached, required Object total}) => 'المحقَّقة: ${reached} من ${total}',
			'reports.standardItems.lb' => 'قراءة الكتاب المقدس',
			'reports.standardItems.ps' => 'الصلاة الفردية',
			'reports.standardItems.rdqad' => 'التأمل',
			'reports.standardItems.pg' => 'الصلاة الجماعية',
			'reports.standardItems.llc' => 'قراءة الأدب المسيحي',
			'reports.standardItems.jc' => 'الصوم الكامل',
			'reports.standardItems.jp' => 'الصوم الجزئي',
			'reports.standardItems.dimes' => 'العشور',
			'reports.standardItems.off' => 'التقدمات',
			'reports.units.chapters.name' => 'عدد الفصول',
			'reports.units.chapters.label' => 'عدد الفصول',
			'reports.units.chapters.symbol' => 'فصول',
			'reports.units.chapters.count' => ({required num n, required Object value}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(n, zero: '${value} فصل', one: 'فصل واحد', two: 'فصلان', few: '${value} فصول', many: '${value} فصلًا', other: '${value} فصل', ), 
			'reports.units.times.name' => 'عدد المرات',
			'reports.units.times.label' => 'عدد المرات',
			'reports.units.times.symbol' => 'مرات',
			'reports.units.times.count' => ({required num n, required Object value}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(n, zero: '${value} مرة', one: 'مرة واحدة', two: 'مرتان', few: '${value} مرات', many: '${value} مرة', other: '${value} مرة', ), 
			'reports.units.pages.name' => 'عدد الصفحات',
			'reports.units.pages.label' => 'عدد الصفحات',
			'reports.units.pages.symbol' => 'صفحات',
			'reports.units.pages.count' => ({required num n, required Object value}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(n, zero: '${value} صفحة', one: 'صفحة واحدة', two: 'صفحتان', few: '${value} صفحات', many: '${value} صفحةً', other: '${value} صفحة', ), 
			'reports.units.percent.name' => 'النسبة المئوية',
			'reports.units.percent.label' => 'النسبة المئوية',
			'reports.units.percent.symbol' => '%',
			'reports.units.percent.count' => ({required Object value}) => '${value}%',
			'reminder.title' => 'تقريرك لهذا اليوم',
			'reminder.body' => 'خصّص دقيقة لتسجّل قراءتك وصلاتك… قبل نهاية اليوم.',
			'reminder.channel' => 'تذكير التقرير',
			'reminder.settings' => 'تذكير المساء',
			'reminder.off' => 'معطّل',
			'reminder.switchLabel' => 'ذكّرني بملء يومي',
			'reminder.switchHint' => 'فقط إذا لم تملأ يومك بعد.',
			'reminder.time' => 'وقت التذكير',
			'reminder.offerTitle' => 'تذكير كل مساء؟',
			'reminder.offerText' => 'إذا لم تملأ يومك بعد، يذكّرك التطبيق في الوقت الذي تختاره. ولا شيء إن كنت قد ملأته.',
			'reminder.offerAccept' => 'تفعيل التذكير',
			'reminder.offerLater' => 'لاحقًا',
			'reminder.enabled' => ({required Object time}) => 'تم ضبط التذكير على ${time}',
			'reminder.denied' => 'الإشعارات محظورة لتطبيق CMFI Connect. اسمح بها من إعدادات الهاتف.',
			'export.title' => 'تصدير',
			'export.period' => 'الفترة',
			'export.thisWeek' => 'هذا الأسبوع',
			'export.lastWeek' => 'الأسبوع الماضي',
			'export.thisMonth' => 'هذا الشهر',
			'export.lastMonth' => 'الشهر الماضي',
			'export.thisYear' => 'هذه السنة',
			'export.custom' => 'تواريخ أخرى',
			'export.customPick' => 'اختر التواريخ',
			'export.format' => 'الصيغة',
			'export.pdf' => 'PDF',
			'export.pdfHint' => 'مستند لإرساله أو طباعته',
			'export.csv' => 'جدول بيانات',
			'export.csvHint' => 'ملف CSV لبرنامج Excel أو Google Sheets',
			'export.text' => 'رسالة',
			'export.textHint' => 'ملخص تلصقه في WhatsApp',
			'export.button' => 'تصدير',
			'export.shareButton' => 'مشاركة',
			'export.preview' => ({required num filled, required Object total, required Object items}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(filled, zero: 'تمت تعبئة ${filled} يوم من ${total} · ${items}', one: 'تمت تعبئة يوم واحد من ${total} · ${items}', two: 'تمت تعبئة يومين من ${total} · ${items}', few: 'تمت تعبئة ${filled} أيام من ${total} · ${items}', many: 'تمت تعبئة ${filled} يومًا من ${total} · ${items}', other: 'تمت تعبئة ${filled} يوم من ${total} · ${items}', ), 
			'export.previewItems' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(n, zero: '${n} عنصر', one: 'عنصر واحد', two: 'عنصران', few: '${n} عناصر', many: '${n} عنصرًا', other: '${n} عنصر', ), 
			'export.empty' => 'لا توجد تقارير في هذه الفترة.',
			'export.tooLong' => 'اختر 366 يومًا كحدّ أقصى.',
			'export.fileName' => 'تقرير',
			'export.subject' => ({required Object period}) => 'تقريري، ${period}',
			'export.doc.title' => 'التقرير',
			'export.doc.regularity' => 'الانتظام',
			'export.doc.daysFilled' => ({required num filled, required Object total}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(filled, zero: 'تمت تعبئة ${filled} يوم من ${total}', one: 'تمت تعبئة يوم واحد من ${total}', two: 'تمت تعبئة يومين من ${total}', few: 'تمت تعبئة ${filled} أيام من ${total}', many: 'تمت تعبئة ${filled} يومًا من ${total}', other: 'تمت تعبئة ${filled} يوم من ${total}', ), 
			'export.doc.totals' => 'خلال الفترة',
			'export.doc.item' => 'العنصر',
			'export.doc.total' => 'المجموع',
			'export.doc.days' => 'الأيام',
			'export.doc.average' => 'المعدل / يوم معبّأ',
			'export.doc.goal' => 'تحقّق الهدف',
			'export.doc.detail' => 'يومًا بيوم',
			'export.doc.date' => 'التاريخ',
			'export.doc.values' => 'المُدخَل',
			'export.doc.note' => 'ملاحظة',
			'export.doc.noReport' => 'لا يوجد تقرير',
			'export.doc.generated' => ({required Object date}) => 'أُنشئ في ${date} بواسطة CMFI Connect',
			'export.doc.page' => ({required Object n, required Object total}) => 'صفحة ${n} / ${total}',
			'export.doc.filledColumn' => 'التقرير',
			'export.doc.yes' => 'نعم',
			'export.doc.no' => 'لا',
			'export.doc.sentFrom' => 'أُرسل من CMFI Connect',
			'items.title' => 'عناصري',
			'items.standardSection' => 'الأساسية · للجميع',
			'items.personalSection' => 'عناصري الشخصية',
			'items.emptyPersonal' => 'ليس لديك أي عنصر شخصي بعد.',
			'items.archive' => 'أرشفة',
			'items.archiveTitle' => ({required Object code}) => 'أرشفة ${code}؟',
			'items.archiveText' => 'لن يُعرض بعد الآن في تقريرك. تبقى أرقامه في سجلك.',
			'items.archived' => ({required Object code}) => 'تمت أرشفة ${code}',
			'items.create' => 'إنشاء عنصر',
			'items.footnote' => 'العنصر المؤرشف لا يُعرض بعد الآن في تقريرك، لكن أرقامه تبقى في سجلك.',
			'items.measure.quantity' => ({required Object unit}) => 'الكمية · ${unit}',
			'items.measure.quantityNoUnit' => 'الكمية',
			'items.measure.duration' => 'المدة',
			'items.measure.both' => ({required Object unit}) => 'الكمية (${unit}) والمدة',
			'items.measure.bothNoUnit' => 'الكمية والمدة',
			'items.goalAdd' => 'إضافة هدف',
			'items.goal' => ({required Object value}) => 'الهدف: ${value} يوميًا',
			'items.goalTitle' => 'الهدف اليومي',
			'items.goalHint' => 'ما تسعى إليه كل يوم. يبقى على هاتفك.',
			'items.goalRemove' => 'إزالة',
			'items.goalSaved' => 'تم حفظ الهدف',
			'items.goalRemoved' => 'تمت إزالة الهدف',
			'newItem.title' => 'عنصر جديد',
			'newItem.code' => 'الرمز',
			'newItem.label' => 'الاسم',
			'newItem.help' => 'أحرف وأرقام، 20 كحدّ أقصى. رمز العنصر الأساسي (LB، PS…) غير متاح.',
			'newItem.measures' => 'ما تقيسه',
			'newItem.quantity' => 'كمية',
			'newItem.quantityHint' => 'إصحاحات، صفحات، أشخاص…',
			'newItem.unit' => 'الوحدة المعروضة بعد الرقم',
			'newItem.unitHint' => 'أشخاص',
			'newItem.duration' => 'مدة',
			'newItem.durationHint' => 'بالساعات والدقائق',
			'newItem.noMeasure' => 'اختر مقياسًا واحدًا على الأقل: كمية، أو مدة، أو كليهما.',
			'newItem.preview' => 'معاينة في تقريرك',
			'newItem.previewCode' => 'رمز',
			'newItem.previewLabel' => 'اسم العنصر',
			'newItem.submit' => 'إنشاء العنصر',
			'newItem.created' => ({required Object code}) => 'تم إنشاء ${code}.',
			'newItem.codeTaken' => 'هذا الرمز مستخدم بالفعل، لعنصر أساسي أو لأحد عناصرك (حتى المؤرشفة).',
			'newItem.codeHint' => 'EVG',
			'newItem.labelHint' => 'التبشير',
			'more.title' => 'المزيد',
			'more.editProfile' => 'تعديل ملفي الشخصي',
			'more.community' => 'المجتمع',
			'more.events' => 'الفعاليات',
			'more.reports' => 'التقرير',
			'more.myItems' => 'عناصري',
			'more.app' => 'التطبيق',
			'more.language' => 'اللغة',
			'more.appearance' => 'المظهر',
			'more.themeSystem' => 'تلقائي',
			'more.themeSystemHint' => 'في الوضع التلقائي، يتبع التطبيق إعداد الهاتف الفاتح أو الداكن.',
			'more.themeLight' => 'فاتح',
			'more.themeDark' => 'داكن',
			'more.logout' => 'تسجيل الخروج',
			'more.account' => 'الحساب',
			'more.languageTitle' => 'لغة التطبيق',
			'more.completeProfile' => 'أضف اسمك',
			'more.accompaniment' => 'المرافقة الروحية',
			'more.exportReport' => 'تصدير تقريري',
			'more.logoutPendingTitle' => 'أيام لم تُرسَل بعد',
			'more.logoutPendingText' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(n, zero: '${n} يوم محفوظ دون شبكة لم يُرسَل بعد. إذا سجّلت الخروج الآن، فسيضيع.', one: 'يوم واحد محفوظ دون شبكة لم يُرسَل بعد. إذا سجّلت الخروج الآن، فسيضيع.', two: 'يومان محفوظان دون شبكة لم يُرسَلا بعد. إذا سجّلت الخروج الآن، فسيضيعان.', few: '${n} أيام محفوظة دون شبكة لم تُرسَل بعد. إذا سجّلت الخروج الآن، فستضيع.', many: '${n} يومًا محفوظًا دون شبكة لم تُرسَل بعد. إذا سجّلت الخروج الآن، فستضيع.', other: '${n} يوم محفوظ دون شبكة لم تُرسَل بعد. إذا سجّلت الخروج الآن، فستضيع.', ), 
			'more.logoutAnyway' => 'تسجيل الخروج',
			'more.admin' => 'الإدارة',
			'more.staff' => 'الفريق والأدوار',
			'more.manageEvents' => 'الفعاليات',
			'more.disciples' => 'تلاميذي',
			'authorities.title' => 'مرشديّ الروحيون',
			'authorities.intro' => 'الأشخاص الذين يرافقونك في مسيرتك مع الله: صانع التلاميذ الخاص بك وسائر مرشديك.',
			'authorities.discipleMaker' => 'صانع التلاميذ',
			'authorities.discipleMakerOf' => ({required Object name}) => 'صانع التلاميذ: ${name}',
			'authorities.noDiscipleMaker' => 'لا يوجد صانع تلاميذ بعد',
			'authorities.others' => 'مرشدون آخرون',
			'authorities.empty' => 'لم تُضِف أحدًا بعد.',
			'authorities.add' => 'إضافة مرشد',
			'authorities.remove' => 'إزالة',
			'authorities.removeTitle' => ({required Object name}) => 'إزالة ${name}؟',
			'authorities.removeText' => ({required Object name}) => 'لن يكون ${name} بعد الآن ضمن مرشديك الروحيين.',
			'authorities.removed' => ({required Object name}) => 'لم يعد ${name} ضمن مرشديك.',
			'authorities.count' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(n, zero: 'لا أحد حتى الآن', one: 'شخص واحد', two: 'شخصان', few: '${n} أشخاص', many: '${n} شخصًا', other: '${n} شخص', ), 
			'authorities.form.title' => 'مرشد جديد',
			'authorities.form.emailHint' => 'name@example.com',
			'authorities.form.isDiscipleMaker' => 'هذا هو صانع التلاميذ الخاص بي',
			'authorities.form.isDiscipleMakerHelp' => 'الشخص الذي يرافقك شخصيًا. لديك واحد فقط.',
			'authorities.form.discipleMakerTaken' => ({required Object name}) => '${name} هو بالفعل صانع التلاميذ الخاص بك. أزِله من القائمة لتختار شخصًا آخر.',
			'authorities.form.submit' => 'إضافة',
			'authorities.form.added' => ({required Object name}) => 'أصبح ${name} الآن ضمن مرشديك.',
			'authorities.form.searchLabel' => 'اسم المستخدم',
			'authorities.form.searchHint' => 'اسم المستخدم',
			'authorities.form.search' => 'بحث',
			'authorities.form.searchHelp' => 'إذا كان الشخص يستخدم CMFI Connect، فابحث عنه باسم المستخدم. سيتلقّى طلبك، وستظهر بيانات الاتصال الخاصة به بعد أن يقبله.',
			'authorities.form.notFound' => ({required Object username}) => 'لا أحد يحمل اسم المستخدم @${username}.',
			'authorities.form.invite' => 'ادعُه للانضمام إلى CMFI Connect',
			'authorities.form.inviteText' => 'مرحبًا! أستخدم CMFI Connect لتدوين مسيرتي مع الله، وأودّ أن ترافقني فيها. ثبّت التطبيق، وأنشئ حسابك، ثم أرسل لي اسم المستخدم الخاص بك لأضيفك.',
			'authorities.form.inviteMine' => ({required Object username}) => 'اسم المستخدم الخاص بي: @${username}',
			'authorities.form.manual' => 'ليس لديه التطبيق؟ أدخل بياناته',
			'authorities.form.backToSearch' => 'البحث باسم المستخدم بدلًا من ذلك',
			'authorities.form.request' => 'إرسال الطلب',
			'authorities.form.requested' => ({required Object name}) => 'تم إرسال الطلب إلى ${name}.',
			'authorities.form.alreadyAdded' => 'هذا الشخص ضمن مرشديك بالفعل.',
			'authorities.form.makerExists' => 'لديك صانع تلاميذ بالفعل.',
			'authorities.form.yourself' => 'هذا اسم المستخدم الخاص بك.',
			'authorities.form.sharingHelp' => ({required Object name}) => 'سيرى ${name} تقاريرك: العناصر المملوءة وانتظامك ونسبك، ولن يرى أبدًا ملاحظتك. يمكنك إيقاف ذلك من بطاقته.',
			'authorities.statusPending' => 'قيد الانتظار',
			'authorities.statusDeclined' => 'مرفوض',
			'authorities.pendingHelp' => ({required Object name}) => 'ستظهر بيانات الاتصال بعد أن يقبل ${name}.',
			'authorities.requests' => 'الطلبات الواردة',
			'authorities.requestDiscipleMaker' => 'يطلب منك أن تكون صانع التلاميذ الخاص به',
			'authorities.requestAuthority' => 'يطلب منك أن ترافقه',
			'authorities.accept' => 'قبول',
			'authorities.decline' => 'رفض',
			'authorities.acceptedRequest' => ({required Object name}) => 'أنت ترافق ${name} الآن.',
			'authorities.declinedRequest' => ({required Object name}) => 'تم رفض طلب ${name}.',
			'authorities.requestsCount' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(n, zero: '${n} طلب بانتظارك', one: 'طلب واحد بانتظارك', two: 'طلبان بانتظارك', few: '${n} طلبات بانتظارك', many: '${n} طلبًا بانتظارك', other: '${n} طلب بانتظارك', ), 
			'authorities.sharing.title' => 'مشاركة تقاريري',
			'authorities.sharing.help' => ({required Object name}) => 'يرى ${name} تقاريرك: العناصر المملوءة وانتظامك ونسبك، ولا يرى أبدًا ملاحظتك.',
			'authorities.sharing.on' => ({required Object name}) => 'تقاريرك مُشارَكة مع ${name}.',
			'authorities.sharing.off' => ({required Object name}) => 'لم يعد ${name} يرى تقاريرك.',
			'members.username' => 'اسم المستخدم',
			'members.usernameHint' => 'firstname.lastname',
			'members.usernameHelp' => 'بهذا الاسم سيجدك الأعضاء الآخرون.',
			'members.usernameChecking' => 'جارٍ التحقق…',
			'members.usernameFree' => ({required Object username}) => '@${username} متاح',
			'members.usernameCurrent' => 'هذا اسم المستخدم الحالي الخاص بك',
			'members.usernameTaken' => 'اسم المستخدم هذا مأخوذ بالفعل.',
			'members.usernameInvalid' => 'من 3 إلى 30 حرفًا: أحرف وأرقام و«.» و«_»، دون أن يبدأ أو ينتهي برمز.',
			'members.usernameReserved' => 'اسم المستخدم هذا محجوز.',
			'members.usernameSaved' => ({required Object username}) => 'تم حفظ اسم المستخدم: @${username}',
			'members.deleteAccount.button' => 'حذف حسابي',
			'members.deleteAccount.title' => 'حذف حسابي',
			'members.deleteAccount.intro' => 'هذا نهائي. سيتم مسح حسابك وكل ما يرتبط به:',
			'members.deleteAccount.itemProfile' => 'ملفك الشخصي وصورتك واسم المستخدم وكلمة المرور',
			'members.deleteAccount.itemReports' => 'جميع تقاريرك وعناصرك وأهدافك',
			'members.deleteAccount.itemAuthorities' => 'مرشدوك الروحيون والطلبات التي تلقيتها',
			'members.deleteAccount.itemEvents' => 'تسجيلاتك في الفعاليات',
			'members.deleteAccount.itemPrayer' => 'قوائم صلاتك وخلواتك وطلبات اللجاجة الخاصة بك',
			'members.deleteAccount.kept' => 'تبقى الفعاليات والأخبار والصور وطلبات الصلاة التي نشرتها بصفتك مشرفًا للمجتمع، من دون اسمك.',
			'members.deleteAccount.passwordHelp' => 'للتأكد من أنك أنت.',
			'members.deleteAccount.confirm' => 'حذف نهائي',
			'members.deleteAccount.done' => 'تم حذف حسابك. باركك الله!',
			'members.deleteAccount.wrongPassword' => 'كلمة المرور غير صحيحة.',
			'members.deleteAccount.lastSuperadmin' => 'أنت المشرف العام الوحيد: امنح هذا الدور لشخص آخر قبل حذف حسابك.',
			'admin.title' => 'الفريق والأدوار',
			'admin.intro' => 'يدير المشرفون ما يتشاركه المجتمع بأكمله. وحده المشرف العام يمنح دورًا أو يسحبه.',
			'admin.roleUser' => 'عضو',
			'admin.roleAdmin' => 'مشرف',
			'admin.roleSuperadmin' => 'مشرف عام',
			'admin.giveRole' => 'منح دور',
			'admin.you' => 'أنت',
			'admin.roleFor' => ({required Object username}) => 'دور @${username}',
			'admin.roleChanged' => ({required Object username, required Object role}) => '@${username}: ${role}',
			'admin.memberUsername' => 'اسم مستخدم العضو',
			'admin.empty' => 'لا يوجد مشرفون حتى الآن.',
			'hymns.searchHint' => 'الرقم أو العنوان أو الكلمات',
			'hymns.openNumber' => 'الانتقال إلى رقم',
			'hymns.tabs.all' => 'الكل',
			'hymns.tabs.favorites' => 'المفضلة',
			'hymns.tabs.recent' => 'الأخيرة',
			'hymns.chooseBook' => 'اختر كتاب الترانيم',
			'hymns.count' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(n, zero: '${n} ترنيمة', one: 'ترنيمة واحدة', two: 'ترنيمتان', few: '${n} ترانيم', many: '${n} ترنيمة', other: '${n} ترنيمة', ), 
			'hymns.number' => ({required Object number}) => 'رقم ${number}',
			'hymns.emptyFavorites' => 'المس النجمة بجانب أي ترنيمة لتجدها هنا.',
			'hymns.emptyRecent' => 'ستظهر هنا الترانيم التي تفتحها.',
			'hymns.noResult' => ({required Object query}) => 'لا توجد ترنيمة تطابق «${query}».',
			'hymns.otherBooks' => 'في كتب الترانيم الأخرى',
			'hymns.upToDate' => 'كتب الترانيم محدّثة.',
			'hymns.updated' => 'تم تحديث كتب الترانيم.',
			'hymns.chorus' => 'القرار',
			'hymns.chorusNumber' => ({required Object label}) => 'القرار ${label}',
			'hymns.verse' => ({required Object label}) => 'المقطع ${label}',
			'hymns.times' => ({required Object n}) => '×${n}',
			'hymns.loadFailed' => 'تعذّر فتح كتب الترانيم.',
			'hymns.reader.smaller' => 'تصغير النص',
			'hymns.reader.larger' => 'تكبير النص',
			'hymns.reader.display' => 'العرض',
			'hymns.reader.textSize' => 'حجم النص',
			'hymns.reader.typeface' => 'الخط',
			'hymns.reader.typefaceAuto' => 'تلقائي',
			'hymns.reader.typefaceSans' => 'عصري',
			'hymns.reader.typefaceSerif' => 'كلاسيكي',
			'hymns.reader.typefaceAutoHelp' => 'كلاسيكي عندما يكون النص كبيرًا',
			'hymns.reader.background' => 'الخلفية',
			'hymns.reader.themeAuto' => 'تلقائي',
			'hymns.reader.themeLight' => 'فاتح',
			'hymns.reader.themeSepia' => 'سيبيا',
			'hymns.reader.themeDark' => 'داكن',
			'hymns.reader.repeatChorus' => 'تكرار القرار بعد كل مقطع',
			'hymns.reader.keepScreenOn' => 'إبقاء الشاشة مضاءة',
			_ => null,
		} ?? switch (path) {
			'hymns.reader.addFavorite' => 'إضافة إلى المفضلة',
			'hymns.reader.removeFavorite' => 'إزالة من المفضلة',
			'hymns.reader.favoriteAdded' => 'تمت الإضافة إلى المفضلة',
			'hymns.reader.favoriteRemoved' => 'تمت الإزالة من المفضلة',
			'hymns.reader.more' => 'خيارات أخرى',
			'hymns.reader.copy' => 'نسخ الكلمات',
			'hymns.reader.copied' => 'تم نسخ الكلمات',
			'hymns.reader.project' => 'وضع العرض',
			'hymns.reader.pinchHint' => 'باعد إصبعيك أو قرّبهما على الشاشة لتكبير النص أو تصغيره.',
			'hymns.reader.notFound' => 'لم تعد هذه الترنيمة موجودة في الكتاب.',
			'hymns.reader.share' => 'مشاركة الكلمات',
			'hymns.projection.exit' => 'الخروج من وضع العرض',
			'hymns.projection.previous' => 'المقطع السابق',
			'hymns.projection.next' => 'المقطع التالي',
			'hymns.projection.position' => ({required Object current, required Object total}) => '${current} / ${total}',
			'hymns.projection.hint' => 'المس اليسار للتقدّم، واليمين للرجوع.',
			'hymns.pad.title' => 'الانتقال إلى ترنيمة',
			'hymns.pad.open' => 'فتح',
			'hymns.pad.erase' => 'مسح',
			'hymns.pad.notFound' => ({required Object number}) => 'لا توجد ترنيمة رقم ${number} في هذا الكتاب',
			'hymns.pad.placeholder' => 'اكتب رقمًا',
			'comingSoon.badge' => 'قريبًا',
			'comingSoon.backHome' => 'العودة إلى الرئيسية',
			'events.title' => 'الفعاليات',
			'events.featured' => 'مميّز',
			'events.upcoming' => 'القادمة',
			'events.past' => 'الدورات السابقة',
			'events.emptyTitle' => 'لا توجد فعاليات قادمة',
			'events.emptyText' => 'ستظهر هنا مؤتمرات المجتمع بأكمله ولقاءاته، مع برامجها.',
			'events.manage' => 'إدارة الفعاليات',
			'events.next' => 'الفعالية القادمة',
			'events.seeAll' => 'كل الفعاليات',
			'events.homeText' => 'لقاءات المجتمع وبرامجها وأخبارها.',
			'events.today' => 'اليوم',
			'events.tomorrow' => 'غدًا',
			'events.inDays' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(n, zero: 'اليوم', one: 'بعد يوم واحد', two: 'بعد يومين', few: 'بعد ${n} أيام', many: 'بعد ${n} يومًا', other: 'بعد ${n} يوم', ), 
			'events.daysLeft' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(n, zero: 'اليوم', one: 'يوم واحد', two: 'يومان', few: '${n} أيام', many: '${n} يومًا', other: '${n} يوم', ), 
			'events.onNow' => 'جارية الآن',
			'events.over' => 'انتهت',
			'events.cancelled' => 'ملغاة',
			'events.draft' => 'مسودة',
			'events.registered' => 'مسجَّل',
			'events.stateOpen' => 'التسجيل مفتوح',
			'events.stateClosed' => 'التسجيل مغلق',
			'events.stateFull' => 'مكتمل العدد',
			'events.registrations' => ({required num n, required Object count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(n, zero: 'كن أول من يسجّل', one: 'مسجَّل واحد', two: 'مسجَّلان', few: '${count} مسجَّلين', many: '${count} مسجَّلًا', other: '${count} مسجَّل', ), 
			'events.people' => ({required num n, required Object count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(n, zero: '${count} شخص', one: 'شخص واحد', two: 'شخصان', few: '${count} أشخاص', many: '${count} شخصًا', other: '${count} شخص', ), 
			'events.placesLeft' => ({required num n, required Object count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(n, zero: 'لم يبقَ أي مكان', one: 'بقي مكان واحد', two: 'بقي مكانان', few: 'بقي ${count} أماكن', many: 'بقي ${count} مكانًا', other: 'بقي ${count} مكان', ), 
			'events.oneDay' => ({required Object start, required Object end}) => 'من ${start} إلى ${end}',
			'events.severalDays' => ({required Object startDay, required Object start, required Object endDay, required Object end}) => 'الافتتاح يوم ${startDay} الساعة ${start}، والختام يوم ${endDay} الساعة ${end}',
			'events.venueTime' => ({required Object place}) => 'بتوقيت ${place}',
			'events.addToCalendar' => 'إضافة إلى التقويم',
			'events.share' => 'مشاركة',
			'events.directions' => 'الاتجاهات',
			'events.viewPoster' => 'عرض الملصق',
			'events.tabs.program' => 'البرنامج',
			'events.tabs.news' => 'الأخبار',
			'events.tabs.info' => 'معلومات',
			'events.tabs.photos' => 'الصور',
			'events.noProgram' => 'سيُنشر البرنامج قريبًا.',
			'events.noNews' => 'لا توجد أخبار عن هذه الفعالية بعد.',
			'events.pinned' => 'مثبّت',
			'events.now' => 'يجري الآن',
			'events.hymn' => ({required Object number}) => 'ترنيمة ${number}',
			'events.about' => 'نبذة',
			'events.fees' => 'رسوم المشاركة',
			'events.deadline' => ({required Object date}) => 'التسجيل حتى ${date}',
			'events.contact' => 'للتواصل',
			'events.call' => ({required Object name}) => 'اتصل بـ${name}',
			'events.otherEditions' => 'الدورات الأخرى',
			'events.cancelledBanner' => 'تم إلغاء هذه الفعالية.',
			'events.calendarFailed' => 'تعذّر فتح تقويم الهاتف.',
			'events.linkFailed' => 'تعذّر فتح هذا الرابط.',
			'events.shareText' => ({required Object title, required Object dates, required Object place}) => '${title}\n${dates} · ${place}\nسجّل في تطبيق CMFI Connect.',
			'events.full' => 'لم يعد هناك مكان متاح في هذه الفعالية.',
			'events.closed' => 'التسجيل في هذه الفعالية مغلق.',
			'events.register.cta' => 'سأشارك',
			'events.register.title' => 'سأشارك',
			'events.register.people' => 'كم عددكم؟',
			'events.register.peopleHint' => 'بمن فيهم أنت، مع عائلتك أو مجموعتك.',
			'events.register.less' => 'شخص أقل',
			'events.register.more' => 'شخص إضافي',
			'events.register.lodging' => 'أحتاج إلى إقامة',
			'events.register.lodgingHint' => 'يجهّز المنظّمون الأماكن.',
			'events.register.departure' => 'مدينة الانطلاق',
			'events.register.departureHint' => 'مثال: Douala',
			'events.register.confirm' => 'تأكيد تسجيلي',
			'events.register.update' => 'تحديث',
			'events.register.cancel' => 'إلغاء تسجيلي',
			'events.register.done' => 'تم، أنت مسجَّل! سنذكّرك في اليوم السابق.',
			'events.register.updated' => 'تم تحديث تسجيلك.',
			'events.register.cancelled' => 'تم إلغاء تسجيلك.',
			'events.register.edit' => 'تعديل',
			'events.register.youAre' => 'أنت مسجَّل',
			'events.register.cancelTitle' => 'إلغاء تسجيلك؟',
			'events.register.cancelText' => 'سيصبح مكانك متاحًا لشخص آخر.',
			'events.register.keep' => 'الاحتفاظ بمكاني',
			'events.register.lodgingShort' => 'إقامة',
			'events.reminder.channel' => 'تذكيرات الفعاليات',
			'events.reminder.tomorrow' => ({required Object title}) => 'غدًا: ${title}',
			'events.reminder.soon' => ({required Object title}) => 'بعد ساعة: ${title}',
			'events.admin.title' => 'إدارة الفعاليات',
			'events.admin.create' => 'إنشاء فعالية',
			'events.admin.edit' => 'تعديل الفعالية',
			'events.admin.empty' => 'لا توجد فعاليات حتى الآن. أنشئ أول فعالية!',
			'events.admin.poster' => 'الملصق',
			'events.admin.posterAdd' => 'اختيار ملصق',
			'events.admin.posterChange' => 'تغيير الملصق',
			'events.admin.posterRemove' => 'إزالة الملصق',
			'events.admin.posterHint' => 'يُنصح بصيغة عمودية 4:5 (1080 × 1350)، JPEG أو PNG.',
			'events.admin.uploading' => 'جارٍ إرسال الصورة…',
			'events.admin.general' => 'الفعالية',
			'events.admin.titleField' => 'العنوان',
			'events.admin.titleHint' => 'مثال: المؤتمر السنوي 2026',
			'events.admin.titleRequired' => 'أعطِ الفعالية عنوانًا.',
			'events.admin.theme' => 'الموضوع',
			'events.admin.themeHint' => 'مثال: السلوك بالروح',
			'events.admin.verse' => 'آية الموضوع',
			'events.admin.description' => 'الوصف',
			'events.admin.when' => 'التواريخ',
			'events.admin.starts' => 'البداية',
			'events.admin.ends' => 'النهاية',
			'events.admin.endsBeforeStart' => 'يجب أن تكون النهاية بعد البداية.',
			'events.admin.timeZone' => ({required Object zone}) => 'بتوقيت المكان (${zone}).',
			'events.admin.where' => 'المكان',
			'events.admin.venue' => 'المكان',
			'events.admin.venueHint' => 'مثال: مركز المؤتمرات في Mvolyé',
			'events.admin.address' => 'عنوان المكان',
			'events.admin.city' => 'المدينة',
			'events.admin.country' => 'البلد',
			'events.admin.mapsUrl' => 'رابط Google Maps',
			'events.admin.registration' => 'التسجيل',
			'events.admin.registrationOpen' => 'التسجيل مفتوح',
			'events.admin.deadline' => 'آخر موعد',
			'events.admin.noDeadline' => 'بلا موعد نهائي',
			'events.admin.capacity' => 'عدد الأماكن',
			'events.admin.capacityHint' => 'فارغ: بلا حدّ',
			'events.admin.asksLodging' => 'السؤال عمّن يحتاج إلى إقامة',
			'events.admin.asksDeparture' => 'السؤال عن مدينة الانطلاق',
			'events.admin.fees' => 'رسوم المشاركة',
			'events.admin.feesHint' => 'مثال: الدخول مجاني. الوجبات: 2000 FCFA يوميًا.',
			'events.admin.contact' => 'جهة الاتصال',
			'events.admin.contactName' => 'اسم جهة الاتصال',
			'events.admin.contactPhone' => 'هاتف جهة الاتصال',
			'events.admin.visibility' => 'الظهور',
			'events.admin.statusDraft' => 'مسودة',
			'events.admin.statusDraftHint' => 'تظهر للمشرفين فقط',
			'events.admin.statusPublished' => 'منشورة',
			'events.admin.statusPublishedHint' => 'تظهر للمجتمع بأكمله',
			'events.admin.statusCancelled' => 'ملغاة',
			'events.admin.statusCancelledHint' => 'تظهر على أنها ملغاة، دون تسجيل',
			'events.admin.saved' => 'تم حفظ الفعالية.',
			'events.admin.menu' => 'إدارة',
			'events.admin.program' => 'البرنامج',
			'events.admin.registrants' => 'المسجَّلون',
			'events.admin.post' => 'نشر خبر',
			'events.admin.photos' => 'إضافة صور',
			'events.admin.nextEdition' => 'تحضير الدورة التالية',
			'events.admin.delete' => 'حذف الفعالية',
			'events.admin.deleteTitle' => 'حذف هذه الفعالية؟',
			'events.admin.deleteText' => 'سيتم أيضًا حذف التسجيلات والأخبار والصور.',
			'events.admin.deleteConfirm' => 'حذف',
			'events.admin.deleted' => 'تم حذف الفعالية.',
			'events.admin.nextEditionTitle' => 'تحضير الدورة التالية؟',
			'events.admin.nextEditionText' => 'تُنشأ مسودة بعد سنة، بالمكان نفسه والبرنامج نفسه. يمكنك تعديل كل شيء قبل نشرها.',
			'events.admin.nextEditionConfirm' => 'تحضير',
			'events.admin.nextEditionDone' => 'الدورة التالية جاهزة كمسودة.',
			'events.admin.programEmpty' => 'أضف فقرات الفعالية: الاستقبال، العبادة، التعاليم، سهرة الصلاة…',
			'events.admin.addSession' => 'إضافة فقرة',
			'events.admin.editSession' => 'تعديل هذه الفقرة',
			'events.admin.sessionTitle' => 'العنوان',
			'events.admin.sessionTitleHint' => 'مثال: عبادة الافتتاح',
			'events.admin.speaker' => 'المتحدّث',
			'events.admin.place' => 'القاعة',
			'events.admin.day' => 'اليوم',
			'events.admin.from' => 'من',
			'events.admin.to' => 'إلى',
			'events.admin.hymns' => 'الترانيم',
			'events.admin.hymnsHint' => 'الأرقام، مثال: 12، 45',
			'events.admin.removeSession' => 'إزالة',
			'events.admin.saveProgram' => 'حفظ البرنامج',
			'events.admin.programSaved' => 'تم حفظ البرنامج.',
			'events.admin.registrantsEmpty' => 'لم يسجّل أحد بعد.',
			'events.admin.totalRegistrations' => 'التسجيلات',
			'events.admin.totalPeople' => 'الأشخاص',
			'events.admin.totalLodging' => 'بحاجة إلى إقامة',
			'events.admin.byCity' => 'حسب مدينة الانطلاق',
			'events.admin.list' => 'القائمة',
			'events.admin.exportCsv' => 'تصدير القائمة (CSV)',
			'events.admin.csvHeader' => 'الاسم,اسم المستخدم,الهاتف,الكنيسة,الجماعة,الأشخاص,الإقامة,مدينة الانطلاق,تاريخ التسجيل',
			'events.admin.yes' => 'نعم',
			'events.admin.no' => 'لا',
			'events.admin.postBody' => 'الرسالة',
			'events.admin.postBodyHint' => 'مثال: التسجيل مفتوح!',
			'events.admin.postImage' => 'إضافة صورة',
			'events.admin.postPinned' => 'تثبيت في الأعلى',
			'events.admin.postSend' => 'نشر',
			'events.admin.postDone' => 'تم نشر الخبر.',
			'events.admin.postDelete' => 'حذف هذا الخبر',
			'events.admin.postDeleted' => 'تم حذف الخبر.',
			'events.admin.photosAdded' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(n, zero: 'تمت إضافة ${n} صورة.', one: 'تمت إضافة صورة واحدة.', two: 'تمت إضافة صورتين.', few: 'تمت إضافة ${n} صور.', many: 'تمت إضافة ${n} صورة.', other: 'تمت إضافة ${n} صورة.', ), 
			'events.admin.photosSending' => ({required Object done, required Object total}) => 'جارٍ إرسال الصور (${done}/${total})…',
			'events.admin.photoDelete' => 'حذف هذه الصورة',
			'events.admin.photoDeleted' => 'تم حذف الصورة.',
			'events.admin.confirmDelete' => 'حذف',
			'events.upcomingCount' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(n, zero: 'لا توجد فعاليات قادمة', one: 'فعالية قادمة واحدة', two: 'فعاليتان قادمتان', few: '${n} فعاليات قادمة', many: '${n} فعالية قادمة', other: '${n} فعالية قادمة', ), 
			'events.slide' => ({required Object current, required Object total}) => 'الفعالية ${current} من ${total}',
			'notifications.title' => 'الإشعارات',
			'notifications.channel' => 'إعلانات الجماعة',
			'notifications.empty' => 'لا توجد إشعارات بعد',
			'notifications.emptyHint' => 'ستصل إعلانات الجماعة إلى هنا.',
			'notifications.unreadLabel' => ({required Object title}) => 'غير مقروء: ${title}',
			'notifications.documents' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(n, zero: 'لا يوجد مستند PDF', one: 'مستند PDF واحد', two: 'مستندا PDF', few: '${n} مستندات PDF', many: '${n} مستندًا PDF', other: '${n} مستند PDF', ), 
			'notifications.unread' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(n, zero: 'لا شيء غير مقروء', one: 'إشعار واحد غير مقروء', two: 'إشعاران غير مقروءين', few: '${n} إشعارات غير مقروءة', many: '${n} إشعارًا غير مقروء', other: '${n} إشعار غير مقروء', ), 
			'notifications.image' => ({required Object n}) => 'الصورة ${n}',
			'notifications.document' => 'مستند PDF',
			'notifications.documentSize' => ({required Object kb}) => '${kb} ك.ب',
			'notifications.received' => ({required Object title}) => 'إشعار جديد: ${title}',
			'premium.name' => 'CMFI Connect Premium',
			'premium.pill' => 'Premium',
			'premium.subtitle' => 'تقدّم أكثر في مسيرتك مع الله، وادعم العمل.',
			'premium.widgetTitle' => 'أداة الشاشة الرئيسية',
			'premium.widgetText' => 'تقرير يومك وأهدافك، دون فتح التطبيق.',
			'premium.statsTitle' => 'أهدافك على مدار السنة',
			'premium.statsText' => 'حصيلة السنة وتطوّر أهدافك، أسبوعًا بعد أسبوع.',
			'premium.supportTitle' => 'أنت تدعم العمل',
			'premium.supportText' => 'اشتراكك يُبقي التطبيق حيًّا للجماعة كلها.',
			'premium.annual' => 'سنوي',
			'premium.monthly' => 'شهري',
			'premium.perYear' => ({required Object price}) => '${price} / سنة',
			'premium.perMonth' => ({required Object price}) => '${price} / شهر',
			'premium.annualPerMonth' => ({required Object price}) => 'أي ${price} شهريًا',
			'premium.best' => 'الأوفر',
			'premium.trialDays' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(n, zero: 'تجربة مجانية', one: 'يوم واحد تجربة مجانية', two: 'يومان تجربة مجانية', few: '${n} أيام تجربة مجانية', many: '${n} يومًا تجربة مجانية', other: '${n} يوم تجربة مجانية', ), 
			'premium.trialMonths' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(n, zero: 'تجربة مجانية', one: 'شهر واحد تجربة مجانية', two: 'شهران تجربة مجانية', few: '${n} أشهر تجربة مجانية', many: '${n} شهرًا تجربة مجانية', other: '${n} شهر تجربة مجانية', ), 
			'premium.subscribe' => 'اشترك',
			'premium.startTrial' => 'ابدأ التجربة المجانية',
			'premium.restore' => 'استعادة المشتريات',
			'premium.restored' => 'عاد Premium إلى هذا الهاتف',
			'premium.nothingToRestore' => 'لا يوجد شراء Premium لهذا الحساب',
			'premium.thanks' => 'شكرًا! تم تفعيل Premium.',
			'premium.failed' => 'لم تكتمل عملية الشراء. أعد المحاولة بعد قليل.',
			'premium.unavailable' => 'العروض غير متاحة حاليًا.',
			'premium.renews' => ({required Object store}) => 'يتجدد الاشتراك تلقائيًا. يمكنك إلغاؤه متى شئت من إعدادات حسابك في ${store}.',
			'premium.terms' => 'شروط الاستخدام',
			'premium.privacy' => 'الخصوصية',
			'premium.activeTitle' => 'لديك Premium',
			'premium.activeText' => 'شكرًا لدعمك CMFI Connect! الأداة وسنة حصيلتك مفتوحتان.',
			'premium.staffText' => 'Premium مقدَّم لك مجانًا لأنك من فريق CMFI Connect.',
			'premium.moreSubtitle' => 'الأداة، الأهداف على مدار السنة',
			'premium.moreActive' => 'مفعّل',
			'premium.unlock' => 'افتح مع Premium',
			'premium.trialThen' => ({required Object trial, required Object price}) => '${trial}، ثم ${price}',
			'premium.savePercent' => ({required Object percent}) => '−${percent}',
			'premium.choose' => 'اختر عرضك',
			'premium.cancelAnytime' => 'بلا التزام، يمكن الإلغاء في أي وقت',
			'premium.restoreShort' => 'استعادة',
			'premium.termsShort' => 'الشروط',
			'premium.semiannual' => 'نصف سنوي',
			'premium.perSemester' => ({required Object price}) => '${price} / 6 أشهر',
			'homeWidget.title' => 'اليوم',
			'homeWidget.done' => 'تم',
			'homeWidget.todo' => 'للتعبئة',
			'homeWidget.open' => 'عبّئ',
			'homeWidget.locked' => 'فعّل الأداة مع Premium',
			'homeWidget.signedOut' => 'سجّل الدخول في التطبيق',
			'ministry.title' => 'خدمتنا',
			'ministry.tagline' => 'إلى أقصى الأرض',
			'ministry.count' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(n, zero: 'لا توجد أمم', one: 'أمة واحدة', two: 'أمّتان', few: '${n} أمم', many: '${n} أمة', other: '${n} أمة', ), 
			'ministry.fromYaounde' => 'من ياوندي، ينتقل الإنجيل من أمة إلى أمة.',
			'ministry.dragHint' => 'أدر الكرة الأرضية بإصبعك، والمس أمة.',
			'ministry.globeLabel' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(n, zero: 'الكرة الأرضية: لا توجد أمم بعد.', one: 'الكرة الأرضية: أمة واحدة حيث العمل حاضر. القائمة أدناه تذكرها.', two: 'الكرة الأرضية: أمّتان حيث العمل حاضر. القائمة أدناه تذكرهما.', few: 'الكرة الأرضية: ${n} أمم حيث العمل حاضر. القائمة أدناه تذكرها كلها.', many: 'الكرة الأرضية: ${n} أمة حيث العمل حاضر. القائمة أدناه تذكرها كلها.', other: 'الكرة الأرضية: ${n} أمة حيث العمل حاضر. القائمة أدناه تذكرها كلها.', ), 
			'ministry.voyage' => 'رحلة',
			'ministry.pause' => 'إيقاف مؤقت',
			'ministry.previous' => 'الأمة السابقة',
			'ministry.next' => 'الأمة التالية',
			'ministry.number' => ({required Object n}) => 'الأمة رقم ${n}',
			'ministry.since' => ({required Object year}) => 'منذ ${year}',
			'ministry.pray' => 'صلِّ',
			'ministry.prayTitle' => ({required Object country}) => 'صلِّ من أجل ${country}',
			'ministry.prayThanks' => ({required Object country}) => 'اشكر الله على عمله في ${country}.',
			'ministry.prayAssemblies' => ({required Object country}) => 'صلِّ من أجل جماعات ${country} ومسؤوليها.',
			'ministry.prayUnreached' => ({required Object country}) => 'صلِّ لكي يلتقي بيسوع الذين لم يؤمنوا بعد في ${country}.',
			'ministry.purpose' => 'هدفنا',
			'ministry.nations' => 'الأمم',
			'ministry.search' => 'ابحث عن أمة',
			'ministry.none' => 'لا توجد أمة مطابقة',
			'ministry.homeText' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(n, zero: 'لا توجد أمم بعد', one: 'حاضرة في أمة واحدة', two: 'حاضرة في أمّتين', few: 'حاضرة في ${n} أمم', many: 'حاضرة في ${n} أمة', other: 'حاضرة في ${n} أمة', ), 
			'ministry.nationsSubtitle' => 'الكرة الأرضية والرحلة من أمة إلى أمة',
			'ministry.purposeSubtitle' => 'أهدافنا الثلاثة',
			'ministry.missionaries' => 'مرسلونا',
			'ministry.missionariesSubtitle' => 'الذين يرسلهم الرب إلى الأمم',
			'ministry.heroes' => 'أبطالنا',
			'ministry.heroesSubtitle' => 'الذين يلهمنا إيمانهم',
			'ministry.goalOf' => ({required Object n, required Object total}) => 'هدفنا · ${n}/${total}',
			'ministry.previousGoal' => 'الهدف السابق',
			'ministry.nextGoal' => 'الهدف التالي',
			'ministry.media.books' => 'الكتب',
			'ministry.media.tracts' => 'النبذات',
			'ministry.media.magazines' => 'المجلات',
			'ministry.media.cds' => 'الأقراص المدمجة',
			'ministry.media.dvds' => 'أقراص الفيديو',
			'ministry.media.radio' => 'الإذاعة',
			'ministry.media.tv' => 'التلفزيون',
			'ministry.media.internet' => 'الإنترنت',
			'ministry.goals.crusade.title' => 'حملة الإنجيل لكل خليقة',
			'ministry.goals.crusade.text' => 'أن نكرز بالإنجيل لكل من سيعيش في جيلنا، حتى يصل الإنجيل المكروز به بقوة الروح القدس إلى 10 مليارات شخص، مستخدمين كل وسائل الاتصال (كتبنا ونبذاتنا ومجلاتنا وأقراصنا المدمجة وأقراص الفيديو والإذاعة والتلفزيون والإنترنت) بأقصى سرعة ممكنة.',
			'ministry.goals.crusade.reached' => 'شخص يصلهم الإنجيل',
			'ministry.goals.disciples.title' => 'تلمذة التلاميذ',
			'ministry.goals.disciples.text' => 'أن نقود مليار شخص في 250 أمة إلى معرفة يسوع المسيح ربًا ومخلّصًا، وأن يصيروا تلاميذ يطيعونه في كل شيء، ومنظَّمين للاجتماع في 25 مليون كنيسة بيتية بحلول عام 2065.',
			'ministry.goals.disciples.people' => 'تلميذ',
			'ministry.goals.disciples.nations' => 'أمة',
			'ministry.goals.disciples.churches' => 'كنيسة بيتية',
			'ministry.goals.disciples.by' => ({required Object year}) => 'بحلول ${year}',
			'ministry.goals.revival.title' => 'التعجيل بالنهضة العالمية',
			'ministry.goals.revival.text' => 'أن نعمل مع الله بالصوم والتشفع من أجل النهضة العالمية التي ستشق السماوات وتزلزل الأرض وتمجد المسيح في جيلنا، لنعجّل بالعودة الوشيكة لربنا يسوع المسيح من السماء للقاء عروسه المُهيَّأة.',
			'ministry.goals.revival.fasting' => 'الصوم',
			'ministry.goals.revival.intercession' => 'التشفع',
			'ministry.goals.revival.pray' => 'صلِّ الآن',
			'prayer.moments.morning' => 'الصباح',
			'prayer.moments.noon' => 'الظهر',
			'prayer.moments.evening' => 'المساء',
			'prayer.moments.night' => 'الليل',
			'prayer.retreatOf.morning' => 'خلوة الصباح',
			'prayer.retreatOf.noon' => 'خلوة الظهر',
			'prayer.retreatOf.evening' => 'خلوة المساء',
			'prayer.retreatOf.night' => 'خلوة الليل',
			'prayer.hero.now' => ({required Object retreat}) => '${retreat} · الآن',
			'prayer.hero.title' => '15 دقيقة\nمع الرب',
			'prayer.hero.preview.morning' => 'قدِّم الشكر، وكرِّس يومك وعملك وعائلتك…',
			'prayer.hero.preview.noon' => 'جماعتك، وقادتك، و5 أشخاص من قائمتك، والأمم…',
			'prayer.hero.preview.evening' => 'حياة الصلاة لديك، وخدمتك، والعاملون معك في الخدمة…',
			'prayer.hero.preview.night' => 'المرضى، والإنجيل في الأمم، والحماية أثناء الليل…',
			'prayer.hero.meta' => '15 نقطة · دقيقة لكل نقطة',
			'prayer.hero.start' => 'ابدأ',
			'prayer.hero.allDone' => 'تمّت خلوات اليوم الأربع. ليستجب الله!',
			'prayer.hero.doneNow' => ({required Object retreat, required Object next}) => 'تمّت ${retreat}. التالية: ${next}',
			'prayer.today.toPray' => 'بانتظارك',
			'prayer.today.week' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(n, zero: 'لا خلوات هذا الأسبوع', one: 'خلوة واحدة هذا الأسبوع', two: 'خلوتان هذا الأسبوع', few: '${n} خلوات هذا الأسبوع', many: '${n} خلوة هذا الأسبوع', other: '${n} خلوة هذا الأسبوع', ), 
			'prayer.routine.title' => 'روتينك اليومي',
			'prayer.routine.count' => ({required Object done}) => '${done} من 4',
			'prayer.routine.days' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(n, zero: '${n} يوم من 7', one: 'يوم واحد من 7', two: 'يومان من 7', few: '${n} أيام من 7', many: '${n} يومًا من 7', other: '${n} يوم من 7', ), 
			'prayer.routine.week' => ({required Object time}) => '${time} هذا الأسبوع',
			'prayer.routine.done' => 'تمّت · 15 دقيقة',
			'prayer.routine.now' => 'الآن · 15 دقيقة',
			'prayer.routine.next' => 'التالية · 15 دقيقة',
			'prayer.routine.reminder' => ({required Object time}) => 'تذكير في ${time}',
			'prayer.routine.later.morning' => 'في الصباح · 15 دقيقة',
			'prayer.routine.later.noon' => 'عند الظهر · 15 دقيقة',
			'prayer.routine.later.evening' => 'في المساء · 15 دقيقة',
			'prayer.routine.later.night' => 'في الليل · 15 دقيقة',
			'prayer.together' => 'نصلّي معًا',
			'prayer.reminders.title' => 'تذكيرات الخلوات',
			'prayer.reminders.intro' => 'تذكير في موعد كل خلوة، فقط إذا لم تُتمَّها بعد.',
			'prayer.reminders.off' => 'معطّل',
			'prayer.reminders.channel' => 'خلوات الصلاة',
			'prayer.reminders.body' => '15 دقيقة مع الرب.',
			'prayer.retreat.title' => 'خلوات من 15 دقيقة',
			'prayer.retreat.hours.morning' => 'عند الاستيقاظ',
			'prayer.retreat.hours.noon' => 'بين 12:00 و14:00',
			'prayer.retreat.hours.evening' => 'في آخر العصر',
			'prayer.retreat.hours.night' => 'قبل النوم',
			'prayer.retreat.reminderAt' => ({required Object time}) => 'تذكير الساعة ${time}',
			'prayer.retreat.intro' => '15 نقطة، دقيقة لكل نقطة. صوت هادئ ينقلك إلى النقطة التالية.',
			'prayer.retreat.done' => 'تمّت اليوم',
			'prayer.retreat.start' => 'ابدأ · 15 دقيقة',
			'prayer.retreat.selfPaced' => 'القراءة على راحتي، دون مؤقّت',
			'prayer.retreat.hints.assembly' => ({required Object name}) => 'جماعتك: ${name}',
			'prayer.retreat.hints.assemblyMissing' => 'أضف جماعتك في ملفك الشخصي',
			'prayer.retreat.hints.authorities' => ({required Object names}) => 'مرشدوك: ${names}',
			'prayer.retreat.hints.authoritiesMissing' => 'أضف مرشديك الروحيين من «المزيد»',
			'prayer.retreat.hints.list' => ({required Object list}) => 'قوائمي · ${list}',
			'prayer.retreat.hints.listEmpty' => ({required Object list}) => 'قائمتك «${list}» فارغة: أضف أسماء',
			'prayer.retreat.hints.nation' => ({required Object name}) => 'اليوم: ${name}',
			'prayer.retreat.hints.myCountry' => ({required Object name}) => 'بلدك: ${name}',
			'prayer.retreat.hints.hymn' => 'فتح الترانيم',
			'prayer.session.point' => ({required Object n}) => 'النقطة ${n} من 15',
			'prayer.session.remaining' => 'متبقية',
			'prayer.session.paused' => 'متوقّف مؤقتًا',
			'prayer.session.inYourList' => ({required Object list}) => 'في قائمتك · ${list}',
			'prayer.session.tomorrow' => 'وغدًا، الأشخاص التالون.',
			'prayer.session.footer' => 'الشاشة مضاءة · صوت هادئ كل دقيقة',
			'prayer.session.previous' => 'النقطة السابقة',
			'prayer.session.next' => 'النقطة التالية',
			'prayer.session.pause' => 'إيقاف مؤقت',
			'prayer.session.resume' => 'استئناف',
			'prayer.session.soundOn' => 'الصوت مفعّل',
			'prayer.session.soundOff' => 'الصوت مكتوم',
			'prayer.session.finish' => 'إنهاء الخلوة',
			'prayer.session.quitTitle' => 'إيقاف الخلوة؟',
			'prayer.session.quitText' => 'لن تُحتسب في يومك.',
			'prayer.session.quit' => 'إيقاف',
			'prayer.session.keepPraying' => 'متابعة الصلاة',
			'prayer.done.title' => ({required Object retreat}) => 'اكتملت ${retreat}',
			'prayer.done.text' => '15 دقيقة مع الرب.\nلقد سمع كل صلاة من صلواتك.',
			'prayer.done.report' => 'تمت الإضافة إلى تقريرك',
			'prayer.done.reportDetail' => ({required Object added, required Object total}) => 'الصلاة الفردية: +${added} دقيقة · ${total} دقيقة اليوم',
			'prayer.done.undo' => 'تراجع',
			'prayer.done.undone' => 'أُزيلت الخلوة من يومك.',
			'prayer.done.today' => 'اليوم',
			'prayer.done.count' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(n, zero: '${n} خلوة من 4', one: 'خلوة واحدة من 4', two: 'خلوتان من 4', few: '${n} خلوات من 4', many: '${n} خلوة من 4', other: '${n} خلوة من 4', ), 
			'prayer.done.verse' => '«صلّوا بلا انقطاع.»',
			'prayer.done.reference' => 'تسالونيكي الأولى 5: 17',
			'prayer.done.finish' => 'إنهاء',
			'prayer.done.hymn' => 'رنّم ترنيمة',
			'prayer.topics.title' => 'طلبات صلاة المجتمع',
			'prayer.topics.all' => 'عرض الكل',
			'prayer.topics.empty' => 'لا توجد طلبات صلاة حاليًا. سينشر القادة الطلبات القادمة هنا.',
			'prayer.topics.categories.church' => 'الكنيسة',
			'prayer.topics.categories.nations' => 'الأمم',
			'prayer.topics.categories.sick' => 'المرضى',
			'prayer.topics.categories.event' => 'فعالية',
			'prayer.topics.categories.fasting' => 'صوم',
			'prayer.topics.categories.other' => 'طلب',
			'prayer.topics.until' => ({required Object date}) => 'حتى ${date}',
			'prayer.topics.archive' => 'الطلبات السابقة',
			'prayer.topics.archiveEmpty' => 'لا توجد طلبات سابقة.',
			'prayer.topics.current' => 'حاليًا',
			'prayer.topics.documentSize' => ({required Object kb}) => '${kb} ك.ب',
			'prayer.topics.download' => 'تنزيل ملف PDF',
			'prayer.topics.noDocument' => 'لا يوجد ملف PDF',
			'prayer.topics.openDocument' => 'فتح ملف PDF',
			'prayer.lists.title' => 'قوائم صلاتي',
			'prayer.lists.private' => 'لك وحدك',
			'prayer.lists.names.unbelievers' => 'لم يؤمنوا بعد',
			'prayer.lists.names.believers' => 'المؤمنون',
			'prayer.lists.names.backsliders' => 'المرتدّون',
			'prayer.lists.names.coworkers' => 'العاملون معك',
			'prayer.lists.uses.unbelievers' => 'تصلّي خلوة الظهر كل يوم من أجل 10 أشخاص من هذه القائمة (5 + 5)، بالتناوب.',
			'prayer.lists.uses.believers' => 'تصلّي خلوة الظهر كل يوم من أجل 5 أشخاص من هذه القائمة، بالتناوب.',
			'prayer.lists.uses.backsliders' => 'تصلّي خلوة الظهر كل يوم من أجل 5 أشخاص من هذه القائمة، بالتناوب.',
			'prayer.lists.uses.coworkers' => 'تصلّي خلوة المساء كل يوم من أجل 10 من العاملين معك في الخدمة (5 + 5)، بالتناوب.',
			'prayer.lists.privateNote' => 'لا يراها أحد غيرك.',
			'prayer.lists.count' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(n, zero: 'لا أحد', one: 'شخص واحد', two: 'شخصان', few: '${n} أشخاص', many: '${n} شخصًا', other: '${n} شخص', ), 
			'prayer.lists.empty' => 'لا أحد حتى الآن. أضف الذين تصلّي من أجلهم.',
			'prayer.lists.add' => 'إضافة شخص',
			'prayer.lists.prayedToday' => 'اليوم',
			'prayer.lists.next' => 'قريبًا',
			'prayer.lists.answeredTitle.unbelievers' => 'آمنوا بالرب',
			'prayer.lists.answeredTitle.believers' => 'صلوات مستجابة',
			'prayer.lists.answeredTitle.backsliders' => 'رجعوا إلى الرب',
			'prayer.lists.answeredTitle.coworkers' => 'صلوات مستجابة',
			'prayer.lists.answeredOn.unbelievers' => ({required Object date}) => 'آمن بالرب في ${date}',
			'prayer.lists.answeredOn.believers' => ({required Object date}) => 'استُجيبت الصلاة في ${date}',
			'prayer.lists.answeredOn.backsliders' => ({required Object date}) => 'رجع إلى الرب في ${date}',
			'prayer.lists.answeredOn.coworkers' => ({required Object date}) => 'استُجيبت الصلاة في ${date}',
			'prayer.lists.markAnswered.unbelievers' => 'آمن بالرب!',
			'prayer.lists.markAnswered.believers' => 'استُجيبت الصلاة',
			'prayer.lists.markAnswered.backsliders' => 'رجع إلى الرب!',
			'prayer.lists.markAnswered.coworkers' => 'استُجيبت الصلاة',
			'prayer.lists.answeredToast' => 'المجد لله!',
			'prayer.lists.putBack' => 'إعادة إلى القائمة',
			'prayer.lists.answeredBanner' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(n, zero: '${n} صلاة مستجابة هذا الشهر', one: 'صلاة واحدة مستجابة هذا الشهر', two: 'صلاتان مستجابتان هذا الشهر', few: '${n} صلوات مستجابة هذا الشهر', many: '${n} صلاة مستجابة هذا الشهر', other: '${n} صلاة مستجابة هذا الشهر', ), 
			'prayer.lists.lastAnswered' => ({required Object name, required Object what}) => '${name}: ${what}',
			'prayer.lists.sheet.addTitle' => 'إضافة شخص',
			'prayer.lists.sheet.editTitle' => 'تعديل',
			'prayer.lists.sheet.name' => 'الاسم',
			'prayer.lists.sheet.namePlaceholder' => 'بولس م.',
			'prayer.lists.sheet.note' => 'ملاحظة',
			'prayer.lists.sheet.notePlaceholder' => 'زميل، جار، ابنة عم…',
			'prayer.lists.sheet.list' => 'القائمة',
			'prayer.lists.sheet.save' => 'حفظ',
			'prayer.lists.sheet.remove' => 'إزالة من القائمة',
			'prayer.lists.sheet.removeTitle' => ({required Object name}) => 'إزالة ${name}؟',
			'prayer.lists.sheet.removeText' => 'لن تصلّي بعد الآن من أجل هذا الشخص في خلواتك.',
			'prayer.lists.addShort' => 'إضافة',
			'prayer.importunity.title' => 'طلبات اللجاجة',
			'prayer.importunity.newTopic' => 'طلب جديد',
			'prayer.importunity.intro' => 'طلب نرفعه إلى الرب بلا كلل حتى تأتي الاستجابة. حدّد عددًا من الإعلانات، وادعُ إخوتك وأخواتك ليصلّوا معك.',
			'prayer.importunity.invitedBy' => ({required Object name}) => '${name} يدعوك إلى الصلاة',
			'prayer.importunity.join' => 'أصلّي معكم',
			'prayer.importunity.decline' => 'ليس الآن',
			'prayer.importunity.joined' => 'أنت الآن تصلّي من أجل هذا الطلب.',
			'prayer.importunity.progress' => ({required Object total, required Object goal}) => '${total} من ${goal}',
			'prayer.importunity.total' => ({required num n, required Object count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(n, zero: '${count} إعلان', one: 'إعلان واحد', two: 'إعلانان', few: '${count} إعلانات', many: '${count} إعلانًا', other: '${count} إعلان', ), 
			'prayer.importunity.reached' => 'تحقّق الهدف!',
			'prayer.importunity.closed' => 'مُغلق',
			'prayer.importunity.participants' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(n, zero: 'لا أحد يصلّي بعد', one: 'شخص واحد يصلّي', two: 'شخصان يصلّيان', few: '${n} أشخاص يصلّون', many: '${n} شخصًا يصلّون', other: '${n} شخص يصلّون', ), 
			'prayer.importunity.mine' => ({required Object n}) => 'أنت: ${n}',
			'prayer.importunity.tapHint' => 'المس الشاشة مع كل إعلان',
			'prayer.importunity.addMany' => 'إضافة عدد',
			'prayer.importunity.addManyTitle' => 'كم عدد الإعلانات؟',
			'prayer.importunity.addManyLabel' => 'الإعلانات',
			'prayer.importunity.add' => 'إضافة',
			'prayer.importunity.pending' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(n, zero: '${n} إعلان بانتظار الإرسال', one: 'إعلان واحد بانتظار الإرسال', two: 'إعلانان بانتظار الإرسال', few: '${n} إعلانات بانتظار الإرسال', many: '${n} إعلانًا بانتظار الإرسال', other: '${n} إعلان بانتظار الإرسال', ), 
			'prayer.importunity.invite' => 'دعوة',
			'prayer.importunity.members' => 'المصلّون',
			'prayer.importunity.waiting' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(n, zero: '${n} دعوة بانتظار الرد', one: 'دعوة واحدة بانتظار الرد', two: 'دعوتان بانتظار الرد', few: '${n} دعوات بانتظار الرد', many: '${n} دعوة بانتظار الرد', other: '${n} دعوة بانتظار الرد', ), 
			'prayer.importunity.edit' => 'تعديل',
			'prayer.importunity.close' => 'إغلاق الطلب',
			'prayer.importunity.reopen' => 'إعادة فتح الطلب',
			'prayer.importunity.delete' => 'حذف الطلب',
			'prayer.importunity.deleteTitle' => 'حذف هذا الطلب؟',
			'prayer.importunity.deleteText' => 'سيختفي لدى كل من يصلّون معك.',
			'prayer.importunity.leave' => 'الانسحاب من هذا الطلب',
			'prayer.importunity.leaveTitle' => 'الانسحاب من هذا الطلب؟',
			'prayer.importunity.leaveText' => 'تبقى إعلاناتك ضمن المجموع.',
			'prayer.importunity.form.newTitle' => 'طلب لجاجة جديد',
			'prayer.importunity.form.editTitle' => 'تعديل الطلب',
			'prayer.importunity.form.subject' => 'الطلب',
			'prayer.importunity.form.subjectPlaceholder' => 'يا رب، خلِّص بولس',
			'prayer.importunity.form.description' => 'التفاصيل',
			'prayer.importunity.form.descriptionPlaceholder' => 'لأجل مَن، ولماذا…',
			'prayer.importunity.form.goal' => 'الهدف',
			'prayer.importunity.form.goalHint' => 'عدد الإعلانات الذي تريدون بلوغه معًا. اتركه فارغًا للعدّ دون هدف.',
			'prayer.importunity.form.goalPlaceholder' => '10000',
			'prayer.importunity.form.create' => 'إنشاء',
			'prayer.importunity.form.save' => 'حفظ',
			'prayer.importunity.inviteSheet.title' => 'الدعوة إلى الصلاة',
			'prayer.importunity.inviteSheet.family' => 'عائلتي الروحية',
			'prayer.importunity.inviteSheet.familyText' => ({required num n, required Object name}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(n, zero: '${name} وتلاميذه: لا أحد', one: '${name} وتلاميذه: شخص واحد', two: '${name} وتلاميذه: شخصان', few: '${name} وتلاميذه: ${n} أشخاص', many: '${name} وتلاميذه: ${n} شخصًا', other: '${name} وتلاميذه: ${n} شخص', ), 
			'prayer.importunity.inviteSheet.familyMissing' => 'اربط صانع التلاميذ الخاص بك في «مرشديّ الروحيون» لتدعو عائلتك الروحية.',
			_ => null,
		} ?? switch (path) {
			'prayer.importunity.inviteSheet.byUsername' => 'باسم المستخدم',
			'prayer.importunity.inviteSheet.usernameLabel' => 'اسم المستخدم',
			'prayer.importunity.inviteSheet.addUsername' => 'إضافة',
			'prayer.importunity.inviteSheet.send' => 'إرسال الدعوات',
			'prayer.importunity.inviteSheet.sent' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(n, zero: 'كانوا مدعوّين بالفعل.', one: 'تم إرسال دعوة واحدة', two: 'تم إرسال دعوتين', few: 'تم إرسال ${n} دعوات', many: 'تم إرسال ${n} دعوة', other: 'تم إرسال ${n} دعوة', ), 
			'prayer.importunity.eyebrow' => 'موضوع لجاجة',
			'prayer.importunity.proclaim' => 'أُعلن',
			'sending.title' => 'الإرسال إلى مرشديّ',
			'sending.moreOff' => 'متوقف',
			'sending.intro' => 'في الوقت الذي تختاره، يُعِدّ CMFI Connect تقريرك عن الفترة. ما عليك إلا إرساله إلى مرشديك الروحيين.',
			'sending.enabled' => 'جهّزه لي بانتظام',
			'sending.rhythm' => 'الوتيرة',
			'sending.weekly' => 'كل أسبوع',
			'sending.biweekly' => 'كل أسبوعين',
			'sending.monthly' => 'كل شهر',
			'sending.day' => 'اليوم',
			'sending.monthlyDay' => 'في أول كل شهر، عن الشهر الماضي',
			'sending.time' => 'الساعة',
			'sending.recipients' => 'المستلمون',
			'sending.noAuthorities' => 'أضف مرشديك الروحيين أولًا.',
			'sending.addAuthorities' => 'إضافة مرشديّ',
			'sending.viaWhatsApp' => 'عبر واتساب',
			'sending.viaEmail' => 'عبر البريد الإلكتروني',
			'sending.viaBoth' => 'عبر واتساب أو البريد',
			'sending.viaShare' => 'عبر المشاركة',
			'sending.next' => ({required Object date}) => 'التالي: ${date}',
			'sending.prepareNow' => 'جهّزه الآن',
			'sending.history' => 'آخر الإرسالات',
			'sending.notificationTitle' => 'تقريرك جاهز',
			'sending.notificationBody' => 'أرسله إلى مرشديك بلمسة واحدة.',
			'sending.channel' => 'إرسال التقرير',
			'sending.readyTitle' => 'تقريرك جاهز',
			'sending.preview' => 'معاينة الرسالة',
			'sending.greeting' => ({required Object name}) => 'مرحبًا ${name}،',
			'sending.whatsApp' => 'واتساب',
			'sending.email' => 'البريد',
			'sending.sharePdf' => 'مشاركة ملف PDF',
			'sending.shareText' => 'مشاركة النص',
			'sending.sent' => 'أُرسل',
			'sending.shared' => 'مشاركة',
			'sending.noRecipients' => 'اختر المستلمين في الإعدادات، أو شارك ملف PDF.',
			'sending.settings' => 'الإعدادات',
			'sending.permissionDenied' => 'اسمح بالإشعارات لتصلك في الوقت المناسب.',
			'streak.title' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(n, zero: '${n} يوم على التوالي!', one: 'يوم واحد على التوالي!', two: 'يومان على التوالي!', few: '${n} أيام على التوالي!', many: '${n} يومًا على التوالي!', other: '${n} يوم على التوالي!', ), 
			'streak.cardDays' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(n, zero: 'يوم مع الله', one: 'يوم مع الله', two: 'يومان مع الله', few: 'أيام مع الله', many: 'يومًا مع الله', other: 'يوم مع الله', ), 
			'streak.lines.week' => 'أسبوع كامل مع الرب، يومًا بعد يوم. أحسنت، تابع!',
			'streak.lines.month' => 'شهر من الأمانة! ما تزرعه كل يوم يأتي بثمر.',
			'streak.lines.hundred' => 'مئة يوم مع الله! مثابرتك شهادة جميلة.',
			'streak.lines.year' => 'سنة كاملة مع الله! المجد له على أمانتك.',
			'streak.share' => 'مشاركة',
			'streak.close' => 'متابعة',
			'shortcuts.today' => 'املأ تقريري',
			'shortcuts.hymns' => 'الترانيم',
			'shortcuts.retreat' => 'خلوة الآن',
			'blocking.report' => 'إبلاغ',
			'blocking.block' => ({required Object name}) => 'حظر ${name}',
			'blocking.blockTitle' => ({required Object name}) => 'حظر ${name}؟',
			'blocking.blockText' => ({required Object name}) => 'لن تصلك دعوات من ${name} بعد الآن. وتُزال هذه الدعوة.',
			'blocking.blockAction' => 'حظر',
			'blocking.blocked' => ({required Object name}) => 'لن يتمكن ${name} من دعوتك بعد الآن.',
			'blocking.reportTitle' => 'الإبلاغ عن هذه الدعوة',
			'blocking.reportText' => 'أخبرنا بما لا يناسب: سينظر مسؤولو الجماعة في الأمر.',
			'blocking.reasons.spam' => 'غير مرغوب فيه',
			'blocking.reasons.offensive' => 'محتوى صادم أو مسيء',
			'blocking.reasons.other' => 'سبب آخر',
			'blocking.comment' => 'تعليق',
			'blocking.commentHint' => 'ما ينبغي أن يعرفه المسؤولون',
			'blocking.send' => 'إرسال البلاغ',
			'blocking.reported' => 'شكرًا، سينظر المسؤولون في الأمر.',
			'blocking.listTitle' => 'الأعضاء المحظورون',
			'blocking.intro' => 'لم تعد دعواتهم إلى الصلاة تصلك.',
			'blocking.empty' => 'لم تحظر أحدًا.',
			'blocking.unblock' => 'إلغاء الحظر',
			'blocking.unblocked' => ({required Object name}) => 'يمكن لـ${name} أن يدعوك من جديد.',
			'verses.title' => 'آية اليوم',
			'verses.share' => 'مشاركة الآية',
			'verses.shareImage' => 'مشاركة الصورة',
			'verses.shareText' => 'مشاركة النص',
			'bible.title' => 'الكتاب المقدس',
			'bible.books' => 'الأسفار',
			'bible.oldTestament' => 'العهد القديم',
			'bible.newTestament' => 'العهد الجديد',
			'bible.chapters' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(n, zero: '${n} أصحاح', one: 'أصحاح واحد', two: 'أصحاحان', few: '${n} أصحاحات', many: '${n} أصحاحًا', other: '${n} أصحاح', ), 
			'bible.chapter' => ({required Object n}) => 'الأصحاح ${n}',
			'bible.version' => 'الترجمة',
			'bible.versions' => 'ترجمة الكتاب المقدس',
			'bible.search' => 'البحث في الكتاب المقدس',
			'bible.searchHint' => 'كلمة، أو «يوحنا 3:16»',
			'bible.searchTip' => 'ابحث عن كلمة («محبة») أو انتقل مباشرة إلى مقطع («مزمور 23»، «يوحنا 3:16»).',
			'bible.searchNone' => 'لا توجد آية تحتوي على هذه الكلمات.',
			'bible.searchCount' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(n, zero: '${n} آية', one: 'آية واحدة', two: 'آيتان', few: '${n} آيات', many: '${n} آية', other: '${n} آية', ), 
			'bible.searchLimit' => ({required Object n}) => 'أول ${n} آية',
			'bible.searchNeedsDownload' => 'للبحث عن كلمات في الكتاب المقدس كله، قم بتنزيله. يمكنك الآن كتابة مقطع: «يوحنا 3:16».',
			'bible.open' => ({required Object reference}) => 'فتح ${reference}',
			'bible.previous' => 'الأصحاح السابق',
			'bible.next' => 'الأصحاح التالي',
			'bible.markRead' => 'قرأت هذا الأصحاح',
			'bible.markedRead' => 'قُرئ اليوم',
			'bible.markReadHint' => 'يضيف أصحاحًا واحدًا إلى «قراءة الكتاب المقدس» في تقريرك.',
			'bible.addedToReport' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(n, zero: 'التقرير: ${n} أصحاح اليوم', one: 'التقرير: أصحاح واحد اليوم', two: 'التقرير: أصحاحان اليوم', few: 'التقرير: ${n} أصحاحات اليوم', many: 'التقرير: ${n} أصحاحًا اليوم', other: 'التقرير: ${n} أصحاح اليوم', ), 
			'bible.removedFromReport' => 'أُزيل من تقريرك',
			'bible.noReadingItem' => 'لا يحتوي تقريرك على عنصر «قراءة الكتاب المقدس».',
			'bible.download' => 'تنزيل هذا الكتاب المقدس',
			'bible.downloadHelp' => ({required Object size}) => 'حوالي ${size} ميغابايت، للقراءة والبحث دون اتصال.',
			'bible.downloading' => ({required Object percent}) => 'جارٍ التنزيل… ${percent}٪',
			'bible.downloaded' => 'على هاتفك',
			'bible.downloadDone' => ({required Object version}) => '${version} على هاتفك',
			'bible.removeDownload' => 'إزالة من الهاتف',
			'bible.removeDownloadTitle' => ({required Object version}) => 'إزالة ${version} من الهاتف؟',
			'bible.removeDownloadText' => 'الأصحاحات التي قرأتها تبقى متاحة دون اتصال.',
			'bible.offline' => 'هذا الأصحاح ليس على هاتفك بعد. أعد الاتصال، أو نزّل هذا الكتاب المقدس لقراءته دون اتصال.',
			'bible.notInVersion' => 'هذا المقطع غير موجود في هذه الترجمة.',
			'bible.marks' => 'آياتي',
			'bible.favorites' => 'المحفوظة',
			'bible.highlights' => 'المظللة',
			'bible.noFavorites' => 'المس آية ثم العلامة لتجدها هنا.',
			'bible.noHighlights' => 'المس آية ثم لونًا لتظليلها.',
			'bible.tapHint' => 'المس آية لتظليلها أو حفظها أو نسخها أو مشاركتها.',
			'bible.highlight' => ({required Object color}) => 'تظليل باللون ${color}',
			'bible.colors.yellow' => 'الأصفر',
			'bible.colors.green' => 'الأخضر',
			'bible.colors.blue' => 'الأزرق',
			'bible.colors.pink' => 'الوردي',
			'bible.removeHighlight' => 'إزالة اللون',
			'bible.addFavorite' => 'حفظ في آياتي',
			'bible.removeFavorite' => 'إزالة من آياتي',
			'bible.favoriteAdded' => 'حُفظت في آياتي',
			'bible.favoriteRemoved' => 'أُزيلت من آياتي',
			'bible.copy' => 'نسخ',
			'bible.copied' => 'تم النسخ',
			'bible.share' => 'مشاركة',
			'bible.closeSelection' => 'إغلاق التحديد',
			'bible.display' => 'العرض',
			'bible.jesusInRed' => 'كلمات يسوع بالأحمر',
			'bible.jesusInRedHelp' => 'في الترجمات التي تميّزها',
			'bible.remove' => 'إزالة',
			'bible.readInBible' => 'اقرأ في الكتاب المقدس',
			'bible.more' => 'خيارات أخرى',
			'profilePhoto.title' => 'صورة الملف الشخصي',
			'profilePhoto.add' => 'إضافة صورة للملف الشخصي',
			'profilePhoto.change' => 'تغيير صورة الملف الشخصي',
			'profilePhoto.seenBy' => 'يراها الأعضاء الآخرون حيثما يظهر اسمك.',
			'profilePhoto.camera' => 'التقاط صورة',
			'profilePhoto.gallery' => 'الاختيار من المعرض',
			'profilePhoto.remove' => 'إزالة الصورة',
			'profilePhoto.cropTitle' => 'اقتصاص صورتك',
			'profilePhoto.cropHint' => 'حرّك الصورة وكبّرها بأصابعك.',
			'profilePhoto.use' => 'استخدام هذه الصورة',
			'profilePhoto.unreadable' => 'تعذّر فتح هذه الصورة. اختر صورة أخرى.',
			'profilePhoto.saved' => 'تم حفظ صورة ملفك الشخصي.',
			'profilePhoto.removed' => 'تمت إزالة صورة ملفك الشخصي.',
			'disciples.title' => 'تلاميذي',
			'disciples.empty' => 'لا تلاميذ بعد',
			'disciples.emptyText' => 'عندما يختارك عضو صانعَ تلاميذ له أو سلطةً روحية وتقبل طلبه، يظهر هنا.',
			'disciples.count' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(n, zero: 'لا تلاميذ', one: 'تلميذ واحد', two: 'تلميذان', few: '${n} تلاميذ', many: '${n} تلميذًا', other: '${n} تلميذ', ), 
			'disciples.notShared' => 'لا يشارك تقاريره',
			'disciples.roleMaker' => 'أنت صانع تلاميذه',
			'disciples.roleAuthority' => 'أنت إحدى سلطاته الروحية',
			'disciples.dayGoals' => ({required Object percent}) => 'الأهداف ${percent} %',
			'disciples.dayItems' => ({required Object filled, required Object total, required Object percent}) => '${filled} من ${total} عناصر · ${percent} %',
			'disciples.older' => 'عرض الأيام الثلاثين السابقة',
			'disciples.noReports' => 'لا تقرير في هذه الفترة.',
			'disciples.searchHint' => 'الاسم أو اسم المستخدم',
			'disciples.noMatch' => ({required Object search}) => 'لا يوجد تلميذ يطابق «${search}».',
			'weekStory.title' => 'أسبوعك مع الله',
			'weekStory.range' => ({required Object from, required Object to}) => 'من ${from} إلى ${to}',
			'weekStory.intro' => 'استعد ما عشته مع الرب هذا الأسبوع.',
			'weekStory.tapHint' => 'المس اليمين للمتابعة واليسار للرجوع.',
			'weekStory.faithfulLead' => 'كنت أمينًا',
			'weekStory.emptyLead' => 'أسبوع جديد ينتظرك',
			'weekStory.days' => ({required num n, required Object total}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(n, zero: '${n} يوم\nمن ${total}', one: 'يوم واحد\nمن ${total}', two: 'يومان\nمن ${total}', few: '${n} أيام\nمن ${total}', many: '${n} يومًا\nمن ${total}', other: '${n} يوم\nمن ${total}', ), 
			'weekStory.streak' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(n, zero: '${n} يوم على التوالي', one: 'يوم واحد على التوالي', two: 'يومان على التوالي', few: '${n} أيام على التوالي', many: '${n} يومًا على التوالي', other: '${n} يوم على التوالي', ), 
			'weekStory.streakRecord' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(n, zero: '${n} يوم على التوالي: رقمك القياسي!', one: 'يوم واحد على التوالي: رقمك القياسي!', two: 'يومان على التوالي: رقمك القياسي!', few: '${n} أيام على التوالي: رقمك القياسي!', many: '${n} يومًا على التوالي: رقمك القياسي!', other: '${n} يوم على التوالي: رقمك القياسي!', ), 
			'weekStory.emptyText' => 'املأ تقريرك كل يوم: سيُكتب أسبوعك القادم هنا.',
			'weekStory.prayerLead' => 'صلّيت',
			'weekStory.retreats' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(n, zero: '${n} خلوة', one: 'خلوة واحدة', two: 'خلوتان', few: '${n} خلوات', many: '${n} خلوة', other: '${n} خلوة', ), 
			'weekStory.retreatsTime' => ({required Object time}) => 'من 15 دقيقة · ${time} مع الرب',
			'weekStory.faithfulMoment' => ({required num n, required Object moment}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(n, zero: 'وقتك الأكثر أمانة: ${moment} (${n} مرة)', one: 'وقتك الأكثر أمانة: ${moment} (مرة واحدة)', two: 'وقتك الأكثر أمانة: ${moment} (مرتان)', few: 'وقتك الأكثر أمانة: ${moment} (${n} مرات)', many: 'وقتك الأكثر أمانة: ${moment} (${n} مرة)', other: 'وقتك الأكثر أمانة: ${moment} (${n} مرة)', ), 
			'weekStory.noRetreat' => 'لا خلوة هذا الأسبوع',
			'weekStory.noRetreatText' => 'خلوة الظهر تنتظرك: 15 دقيقة مع الرب.',
			'weekStory.goalsLead' => 'أهدافك',
			'weekStory.goalsReached' => 'تحقّقت في المتوسط',
			'weekStory.bestDay' => ({required Object day, required Object percent}) => 'أفضل يوم لك: ${day} · ${percent}',
			'weekStory.summaryTitle' => 'أسبوعي مع الله',
			'weekStory.statDays' => 'أيام مملوءة',
			'weekStory.statStreak' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(n, zero: 'يوم على التوالي', one: 'يوم على التوالي', two: 'يومان على التوالي', few: 'أيام على التوالي', many: 'يومًا على التوالي', other: 'يوم على التوالي', ), 
			'weekStory.statRetreats' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(n, zero: 'خلوة', one: 'خلوة', two: 'خلوتان', few: 'خلوات', many: 'خلوة', other: 'خلوة', ), 
			'weekStory.statGoals' => 'من الأهداف',
			'weekStory.share' => 'مشاركة أسبوعي',
			'weekStory.homeText' => 'أمانتك وصلاتك وأهدافك هذا الأسبوع.',
			'weekStory.open' => 'عرض أسبوعي',
			'weekStory.notificationTitle' => 'أسبوعك مع الله جاهز',
			'weekStory.notificationBody' => 'استعد أمانتك هذا الأسبوع وشاركها.',
			'weekStory.channel' => 'أسبوعك مع الله',
			'weekStory.thisWeek' => 'هذا الأسبوع',
			'weekStory.pastWeeks' => 'الأسابيع الماضية',
			'weekStory.weekOf' => ({required Object date}) => 'أسبوع ${date}',
			'weekStory.page' => ({required Object current, required Object total}) => '${current} من ${total}',
			_ => null,
		};
	}
}
