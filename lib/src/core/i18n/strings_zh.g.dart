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
class TranslationsZh extends Translations with BaseTranslations<AppLocale, Translations> {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsZh({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  _meta = meta ?? TranslationMetadata(
		    locale: AppLocale.zh,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ),
		  super(cardinalResolver: cardinalResolver, ordinalResolver: ordinalResolver) {
		_meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <zh>.
	final TranslationMetadata<AppLocale, Translations> _meta;
	@override TranslationMetadata<AppLocale, Translations> get $meta => _meta;

	/// Access flat map
	@override dynamic operator[](String key) => _meta.getTranslation(key) ?? super[key];

	late final TranslationsZh _root = this; // ignore: unused_field

	@override 
	TranslationsZh $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsZh(meta: meta ?? this.$meta);

	// Translations
	@override late final _Translations$app$zh app = _Translations$app$zh._(_root);
	@override late final _Translations$common$zh common = _Translations$common$zh._(_root);
	@override late final _Translations$errors$zh errors = _Translations$errors$zh._(_root);
	@override late final _Translations$validation$zh validation = _Translations$validation$zh._(_root);
	@override late final _Translations$welcome$zh welcome = _Translations$welcome$zh._(_root);
	@override late final _Translations$auth$zh auth = _Translations$auth$zh._(_root);
	@override late final _Translations$countries$zh countries = _Translations$countries$zh._(_root);
	@override late final _Translations$nav$zh nav = _Translations$nav$zh._(_root);
	@override late final _Translations$home$zh home = _Translations$home$zh._(_root);
	@override late final _Translations$reports$zh reports = _Translations$reports$zh._(_root);
	@override late final _Translations$reminder$zh reminder = _Translations$reminder$zh._(_root);
	@override late final _Translations$export$zh export = _Translations$export$zh._(_root);
	@override late final _Translations$items$zh items = _Translations$items$zh._(_root);
	@override late final _Translations$newItem$zh newItem = _Translations$newItem$zh._(_root);
	@override late final _Translations$more$zh more = _Translations$more$zh._(_root);
	@override late final _Translations$authorities$zh authorities = _Translations$authorities$zh._(_root);
	@override late final _Translations$members$zh members = _Translations$members$zh._(_root);
	@override late final _Translations$admin$zh admin = _Translations$admin$zh._(_root);
	@override late final _Translations$hymns$zh hymns = _Translations$hymns$zh._(_root);
	@override late final _Translations$comingSoon$zh comingSoon = _Translations$comingSoon$zh._(_root);
	@override late final _Translations$events$zh events = _Translations$events$zh._(_root);
	@override late final _Translations$notifications$zh notifications = _Translations$notifications$zh._(_root);
	@override late final _Translations$premium$zh premium = _Translations$premium$zh._(_root);
	@override late final _Translations$homeWidget$zh homeWidget = _Translations$homeWidget$zh._(_root);
	@override late final _Translations$ministry$zh ministry = _Translations$ministry$zh._(_root);
	@override late final _Translations$prayer$zh prayer = _Translations$prayer$zh._(_root);
	@override late final _Translations$sending$zh sending = _Translations$sending$zh._(_root);
	@override late final _Translations$streak$zh streak = _Translations$streak$zh._(_root);
	@override late final _Translations$shortcuts$zh shortcuts = _Translations$shortcuts$zh._(_root);
	@override late final _Translations$blocking$zh blocking = _Translations$blocking$zh._(_root);
	@override late final _Translations$verses$zh verses = _Translations$verses$zh._(_root);
	@override late final _Translations$bible$zh bible = _Translations$bible$zh._(_root);
	@override late final _Translations$profilePhoto$zh profilePhoto = _Translations$profilePhoto$zh._(_root);
	@override late final _Translations$disciples$zh disciples = _Translations$disciples$zh._(_root);
	@override late final _Translations$weekStory$zh weekStory = _Translations$weekStory$zh._(_root);
	@override late final _Translations$seekFirst$zh seekFirst = _Translations$seekFirst$zh._(_root);
	@override late final _Translations$documents$zh documents = _Translations$documents$zh._(_root);
	@override late final _Translations$biblePlan$zh biblePlan = _Translations$biblePlan$zh._(_root);
	@override late final _Translations$teachings$zh teachings = _Translations$teachings$zh._(_root);
	@override late final _Translations$memorize$zh memorize = _Translations$memorize$zh._(_root);
	@override late final _Translations$souls$zh souls = _Translations$souls$zh._(_root);
	@override late final _Translations$fasts$zh fasts = _Translations$fasts$zh._(_root);
}

// Path: app
class _Translations$app$zh extends Translations$app$fr {
	_Translations$app$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get name => 'CMFI Connect';
	@override String get tagline => '一起成长，每一天。';
	@override String get languageName => '中文';
}

// Path: common
class _Translations$common$zh extends Translations$common$fr {
	_Translations$common$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get retry => '重试';
	@override String get cancel => '取消';
	@override String get save => '保存';
	@override String get close => '关闭';
	@override String get back => '返回';
	@override String get soon => '即将推出';
	@override String get optional => '（选填）';
	@override String get and => '和';
	@override String get loading => '加载中…';
	@override String get done => '完成';
	@override String get rangeStart => '开始';
	@override String get rangeEnd => '结束';
}

// Path: errors
class _Translations$errors$zh extends Translations$errors$fr {
	_Translations$errors$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get network => '没有网络连接。请检查网络后重试。';
	@override String get unauthorized => '登录已过期，请重新登录。';
	@override String get invalidCredentials => '手机号或密码错误。';
	@override String get badRequest => '部分信息无效。';
	@override String get conflict => '该内容已存在。';
	@override String get notFound => '找不到该内容。';
	@override String get server => '服务器出了点问题，请稍后再试。';
	@override String get unknown => '出错了，请重试。';
	@override String get forbidden => '你没有权限进行此操作。';
	@override String get eventFull => '此活动已没有名额。';
	@override String get registrationClosed => '此活动的报名已截止。';
	@override String get mediaTooLarge => '这张图片太大了（最大 8 MB）。';
	@override String get mediaUnsupported => '请选择 JPEG 或 PNG 格式的图片。';
	@override String get notParticipant => '请先加入这个祷告事项，才能记录你的宣告。';
	@override String get importunityClosed => '这个事项已结束，不再记录宣告。';
	@override String get usernameNotFound => '没有人使用这个用户名。请检查拼写。';
	@override String get ownerCannotLeave => '这个事项是你创建的：请删除它，而不是退出。';
	@override String get tooManyPeople => '你的名单已满（最多 500 人）。';
	@override String get avatarInvalid => '这张照片无法使用，请选择另一张。';
	@override String get reportsNotShared => '该成员不再分享其报告。';
}

// Path: validation
class _Translations$validation$zh extends Translations$validation$fr {
	_Translations$validation$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get required => '此项为必填';
	@override String get passwordTooShort => '至少 6 个字符';
	@override String get invalidPhone => '手机号无效';
	@override String get invalidEmail => '邮箱地址无效';
	@override String get invalidCode => '只能使用字母和数字，不含空格';
}

// Path: welcome
class _Translations$welcome$zh extends Translations$welcome$fr {
	_Translations$welcome$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override late final _Translations$welcome$seek$zh seek = _Translations$welcome$seek$zh._(_root);
	@override late final _Translations$welcome$worship$zh worship = _Translations$welcome$worship$zh._(_root);
	@override late final _Translations$welcome$community$zh community = _Translations$welcome$community$zh._(_root);
	@override String step({required Object current, required Object total}) => '第 ${current} 页，共 ${total} 页';
	@override String streak({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
		other: '与神同行 ${n} 天',
	);
	@override late final _Translations$welcome$sample$zh sample = _Translations$welcome$sample$zh._(_root);
	@override String get createAccount => '创建账号';
	@override String get haveAccount => '我已有账号';
}

// Path: auth
class _Translations$auth$zh extends Translations$auth$fr {
	_Translations$auth$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get phone => '手机号';
	@override String dialCode({required Object code}) => '国际区号：${code}';
	@override String get password => '密码';
	@override String get showPassword => '显示密码';
	@override String get hidePassword => '隐藏密码';
	@override late final _Translations$auth$login$zh login = _Translations$auth$login$zh._(_root);
	@override late final _Translations$auth$register$zh register = _Translations$auth$register$zh._(_root);
	@override late final _Translations$auth$church$zh church = _Translations$auth$church$zh._(_root);
	@override late final _Translations$auth$forgot$zh forgot = _Translations$auth$forgot$zh._(_root);
	@override late final _Translations$auth$biometric$zh biometric = _Translations$auth$biometric$zh._(_root);
}

// Path: countries
class _Translations$countries$zh extends Translations$countries$fr {
	_Translations$countries$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get dialCodeTitle => '国家/地区区号';
	@override String get title => '你的国家/地区';
	@override String get search => '搜索国家/地区或区号';
	@override String get none => '没有匹配的国家/地区';
	@override String get change => '更改国家/地区';
}

// Path: nav
class _Translations$nav$zh extends Translations$nav$fr {
	_Translations$nav$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get home => '首页';
	@override String get reports => '汇报';
	@override String get hymns => '诗歌';
	@override String get prayer => '祷告';
	@override String get bible => '圣经';
}

// Path: home
class _Translations$home$zh extends Translations$home$fr {
	_Translations$home$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String greeting({required Object name}) => '你好，${name}';
	@override String get greetingNoName => '你好';
	@override String get profile => '我的资料';
	@override String progress({required Object filled, required Object total}) => '${filled}/${total}';
	@override String get progressLabel => '项已填写';
	@override String get goals => '目标';
	@override String get weekTitle => '你的一周';
	@override String get community => 'CMFI 近况';
	@override String get eventsTitle => '活动';
	@override String get hymnsTitle => '诗歌';
	@override String get hymnsOpen => '打开诗歌本';
	@override String get continueMyReport => '继续填写汇报';
	@override String get startMyReport => '开始填写汇报';
	@override String get items => '项';
	@override String get goalsTitle => '目标';
	@override String get retreatsTitle => '灵修';
	@override String retreatsValue({required Object n}) => '4 次中 ${n} 次';
	@override String get streakTitle => '连续';
	@override String get resume => '继续';
	@override String hymnNumber({required Object number}) => '第 ${number} 首诗歌';
	@override String get seeAll => '查看全部';
	@override String get retreatsDone => '今天的 4 次灵修都已完成';
	@override String days({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
		other: '${n} 天',
	);
	@override String get hideNumbers => '隐藏我的数字';
	@override String get showNumbers => '显示我的数字';
	@override String get numbersHidden => '已隐藏';
}

// Path: reports
class _Translations$reports$zh extends Translations$reports$fr {
	_Translations$reports$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '每日汇报';
	@override String get myItems => '我的项目';
	@override late final _Translations$reports$tabs$zh tabs = _Translations$reports$tabs$zh._(_root);
	@override String get pickDay => '选择日期';
	@override String filled({required Object filled, required Object total}) => '已填写 ${filled}/${total} 项';
	@override String get statusSaved => '已保存';
	@override String get statusModified => '未保存';
	@override String get standard => '标准项目';
	@override String get personal => '我的项目';
	@override String get createItem => '创建项目';
	@override String add({required Object label}) => '添加${label}';
	@override String get note => '今日笔记';
	@override String get noteHint => '一节经文、一件感恩的事……';
	@override String get save => '保存当天汇报';
	@override String get saved => '当天汇报已保存';
	@override late final _Translations$reports$measure$zh measure = _Translations$reports$measure$zh._(_root);
	@override String times({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
		other: '${n} 次',
	);
	@override late final _Translations$reports$sheet$zh sheet = _Translations$reports$sheet$zh._(_root);
	@override late final _Translations$reports$history$zh history = _Translations$reports$history$zh._(_root);
	@override late final _Translations$reports$summary$zh summary = _Translations$reports$summary$zh._(_root);
	@override String get noItems => '暂时没有需要填写的项目。';
	@override String get statusPending => '尚未发送';
	@override String get savedOffline => '没有网络：当天汇报已保存在手机上，联网后会尽快发送。';
	@override String pendingBanner({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
		other: '${n} 天的汇报正在等待网络发送',
	);
	@override String get export => '导出我的汇报';
	@override String goal({required Object value}) => '目标：${value}';
	@override String get goalReached => '已达成目标';
	@override String get dayGoals => '当天目标';
	@override String goalsReached({required Object reached, required Object total}) => '已达成：${reached}/${total}';
	@override late final _Translations$reports$standardItems$zh standardItems = _Translations$reports$standardItems$zh._(_root);
	@override late final _Translations$reports$units$zh units = _Translations$reports$units$zh._(_root);
	@override late final _Translations$reports$timer$zh timer = _Translations$reports$timer$zh._(_root);
}

// Path: reminder
class _Translations$reminder$zh extends Translations$reminder$fr {
	_Translations$reminder$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '你的今日汇报';
	@override String get body => '在今天结束前，花一分钟记下你的读经、祷告……';
	@override String get channel => '汇报提醒';
	@override String get settings => '晚间提醒';
	@override String get off => '已关闭';
	@override String get switchLabel => '提醒我填写当天汇报';
	@override String get switchHint => '仅在当天尚未填写时提醒。';
	@override String get time => '提醒时间';
	@override String get offerTitle => '每晚提醒你一次？';
	@override String get offerText => '如果当天还没填写，应用会在你选定的时间提醒你；已经填写就不会打扰你。';
	@override String get offerAccept => '开启提醒';
	@override String get offerLater => '以后再说';
	@override String enabled({required Object time}) => '已设置在 ${time} 提醒';
	@override String get denied => 'CMFI Connect 的通知已被关闭。请在手机设置中允许通知。';
}

// Path: export
class _Translations$export$zh extends Translations$export$fr {
	_Translations$export$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '导出';
	@override String get period => '时间段';
	@override String get thisWeek => '本周';
	@override String get lastWeek => '上周';
	@override String get thisMonth => '本月';
	@override String get lastMonth => '上个月';
	@override String get thisYear => '今年';
	@override String get custom => '其他日期';
	@override String get customPick => '选择日期';
	@override String get format => '格式';
	@override String get pdf => 'PDF';
	@override String get pdfHint => '可发送或打印的文档';
	@override String get csv => '表格';
	@override String get csvHint => '适用于 Excel 或 Google 表格的 CSV 文件';
	@override String get text => '消息';
	@override String get textHint => '可粘贴到 WhatsApp 的摘要';
	@override String get button => '导出';
	@override String get shareButton => '分享';
	@override String preview({required num filled, required Object total, required Object items}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(filled,
		other: '已填写 ${filled}/${total} 天 · ${items}',
	);
	@override String previewItems({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
		other: '${n} 个项目',
	);
	@override String get empty => '这段时间没有汇报。';
	@override String get tooLong => '最多选择 366 天。';
	@override String get fileName => '每日汇报';
	@override String subject({required Object period}) => '我的每日汇报：${period}';
	@override late final _Translations$export$doc$zh doc = _Translations$export$doc$zh._(_root);
}

// Path: items
class _Translations$items$zh extends Translations$items$fr {
	_Translations$items$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '我的项目';
	@override String get standardSection => '标准项目 · 所有人适用';
	@override String get personalSection => '我的个人项目';
	@override String get emptyPersonal => '你还没有个人项目。';
	@override String get archive => '归档';
	@override String archiveTitle({required Object code}) => '归档 ${code}？';
	@override String get archiveText => '它将不再出现在你的汇报中，但数据仍会保留在历史记录里。';
	@override String archived({required Object code}) => '${code} 已归档';
	@override String get create => '创建项目';
	@override String get footnote => '已归档的项目不再出现在你的汇报中，但数据仍会保留在历史记录里。';
	@override late final _Translations$items$measure$zh measure = _Translations$items$measure$zh._(_root);
	@override String get goalAdd => '添加目标';
	@override String goal({required Object value}) => '目标：每天 ${value}';
	@override String get goalTitle => '每日目标';
	@override String get goalHint => '你每天想要达到的目标，只保存在你的手机上。';
	@override String get goalRemove => '移除';
	@override String get goalSaved => '目标已保存';
	@override String get goalRemoved => '目标已移除';
}

// Path: newItem
class _Translations$newItem$zh extends Translations$newItem$fr {
	_Translations$newItem$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '新项目';
	@override String get code => '代码';
	@override String get label => '名称';
	@override String get help => '字母和数字，最多 20 个。标准项目的代码（LB、PS……）不可使用。';
	@override String get measures => '你要记录什么';
	@override String get quantity => '数量';
	@override String get quantityHint => '章、页、人……';
	@override String get unit => '数字后显示的单位';
	@override String get unitHint => '人';
	@override String get duration => '时长';
	@override String get durationHint => '以小时和分钟计';
	@override String get noMeasure => '请至少选择一项：数量、时长，或两者都选。';
	@override String get preview => '在汇报中的预览';
	@override String get previewCode => 'CODE';
	@override String get previewLabel => '项目名称';
	@override String get submit => '创建项目';
	@override String created({required Object code}) => '${code} 已创建。';
	@override String get codeTaken => '此代码已被使用，可能是标准项目，也可能是你自己的某个项目（包括已归档的）。';
	@override String get codeHint => 'EVG';
	@override String get labelHint => '传福音';
}

// Path: more
class _Translations$more$zh extends Translations$more$fr {
	_Translations$more$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '更多';
	@override String get editProfile => '编辑我的资料';
	@override String get community => '团契';
	@override String get events => '活动';
	@override String get reports => '每日汇报';
	@override String get myItems => '我的项目';
	@override String get app => '应用';
	@override String get language => '语言';
	@override String get appearance => '外观';
	@override String get themeSystem => '自动';
	@override String get themeSystemHint => '选择自动时，应用会跟随手机的浅色或深色设置。';
	@override String get themeLight => '浅色';
	@override String get themeDark => '深色';
	@override String get logout => '退出登录';
	@override String get account => '账户';
	@override String get languageTitle => '应用语言';
	@override String get completeProfile => '添加你的姓名';
	@override String get accompaniment => '属灵陪伴';
	@override String get exportReport => '导出我的汇报';
	@override String get logoutPendingTitle => '还有未发送的汇报';
	@override String logoutPendingText({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
		other: '有 ${n} 天的汇报是在没有网络时保存的，尚未发送。如果现在退出登录，这些汇报将会丢失。',
	);
	@override String get logoutAnyway => '仍然退出';
	@override String get admin => '管理';
	@override String get staff => '团队与角色';
	@override String get manageEvents => '活动';
	@override String get disciples => '我的门徒';
	@override String version({required Object version}) => '版本 ${version}';
	@override String copyright({required Object year}) => '© ${year} Christian Missionary Fellowship International. 保留所有权利。';
}

// Path: authorities
class _Translations$authorities$zh extends Translations$authorities$fr {
	_Translations$authorities$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '我的属灵带领者';
	@override String get intro => '在与神同行的路上陪伴你的人：你的门训者和其他带领者。';
	@override String get discipleMaker => '门训者';
	@override String discipleMakerOf({required Object name}) => '门训者：${name}';
	@override String get noDiscipleMaker => '还没有门训者';
	@override String get others => '其他带领者';
	@override String get empty => '你还没有添加任何人。';
	@override String get add => '添加带领者';
	@override String get remove => '移除';
	@override String removeTitle({required Object name}) => '移除 ${name}？';
	@override String removeText({required Object name}) => '${name} 将不再是你的属灵带领者。';
	@override String removed({required Object name}) => '${name} 已不再是你的带领者。';
	@override String count({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
		zero: '暂时还没有',
		other: '${n} 人',
	);
	@override late final _Translations$authorities$form$zh form = _Translations$authorities$form$zh._(_root);
	@override String get statusPending => '等待中';
	@override String get statusDeclined => '已拒绝';
	@override String pendingHelp({required Object name}) => '${name} 接受后，你就能看到其联系方式。';
	@override String get requests => '收到的请求';
	@override String get requestDiscipleMaker => '请你做他/她的门训者';
	@override String get requestAuthority => '请你在信仰路上陪伴他/她';
	@override String get accept => '接受';
	@override String get decline => '拒绝';
	@override String acceptedRequest({required Object name}) => '你现在开始陪伴 ${name}。';
	@override String declinedRequest({required Object name}) => '已拒绝 ${name} 的请求。';
	@override String requestsCount({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
		other: '${n} 个请求待查看',
	);
	@override late final _Translations$authorities$sharing$zh sharing = _Translations$authorities$sharing$zh._(_root);
}

// Path: members
class _Translations$members$zh extends Translations$members$fr {
	_Translations$members$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get username => '用户名';
	@override String get usernameHint => 'zhang.san';
	@override String get usernameHelp => '其他成员会通过它找到你。';
	@override String get usernameChecking => '正在检查…';
	@override String usernameFree({required Object username}) => '@${username} 可以使用';
	@override String get usernameCurrent => '这是你当前的用户名';
	@override String get usernameTaken => '该用户名已被占用。';
	@override String get usernameInvalid => '3–30 个字符：字母、数字、「.」和「_」，不能以符号开头或结尾。';
	@override String get usernameReserved => '该用户名已被保留。';
	@override String usernameSaved({required Object username}) => '用户名已保存：@${username}';
	@override late final _Translations$members$deleteAccount$zh deleteAccount = _Translations$members$deleteAccount$zh._(_root);
}

// Path: admin
class _Translations$admin$zh extends Translations$admin$fr {
	_Translations$admin$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '团队与角色';
	@override String get intro => '管理员负责管理整个团契共享的内容。只有超级管理员可以授予或收回角色。';
	@override String get roleUser => '成员';
	@override String get roleAdmin => '管理员';
	@override String get roleSuperadmin => '超级管理员';
	@override String get giveRole => '授予角色';
	@override String get you => '你';
	@override String roleFor({required Object username}) => '@${username} 的角色';
	@override String roleChanged({required Object username, required Object role}) => '@${username}：${role}';
	@override String get memberUsername => '成员的用户名';
	@override String get empty => '暂时还没有管理员。';
}

// Path: hymns
class _Translations$hymns$zh extends Translations$hymns$fr {
	_Translations$hymns$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get searchHint => '编号、标题或歌词';
	@override String get openNumber => '按编号查找';
	@override late final _Translations$hymns$tabs$zh tabs = _Translations$hymns$tabs$zh._(_root);
	@override String get chooseBook => '选择诗歌本';
	@override String count({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
		other: '${n} 首诗歌',
	);
	@override String number({required Object number}) => '第 ${number} 首';
	@override String get emptyFavorites => '点一下诗歌的星标，就能在这里找到它。';
	@override String get emptyRecent => '你打开过的诗歌会显示在这里。';
	@override String noResult({required Object query}) => '没有与「${query}」相符的诗歌。';
	@override String get otherBooks => '其他诗歌本中';
	@override String get upToDate => '诗歌本已是最新。';
	@override String get updated => '诗歌本已更新。';
	@override String get chorus => '副歌';
	@override String chorusNumber({required Object label}) => '副歌 ${label}';
	@override String verse({required Object label}) => '第 ${label} 节';
	@override String times({required Object n}) => '×${n}';
	@override String get loadFailed => '无法打开诗歌本。';
	@override late final _Translations$hymns$reader$zh reader = _Translations$hymns$reader$zh._(_root);
	@override late final _Translations$hymns$projection$zh projection = _Translations$hymns$projection$zh._(_root);
	@override late final _Translations$hymns$pad$zh pad = _Translations$hymns$pad$zh._(_root);
}

// Path: comingSoon
class _Translations$comingSoon$zh extends Translations$comingSoon$fr {
	_Translations$comingSoon$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get badge => '即将推出';
	@override String get backHome => '返回首页';
}

// Path: events
class _Translations$events$zh extends Translations$events$fr {
	_Translations$events$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '活动';
	@override String get featured => '精选';
	@override String get upcoming => '即将举行';
	@override String get past => '往届活动';
	@override String get emptyTitle => '暂无即将举行的活动';
	@override String get emptyText => '整个团契的大会和聚会将显示在这里，并附有日程安排。';
	@override String get manage => '管理活动';
	@override String get next => '下一个活动';
	@override String get seeAll => '全部活动';
	@override String get homeText => '团契的聚会、日程和最新动态。';
	@override String get today => '今天';
	@override String get tomorrow => '明天';
	@override String inDays({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
		other: '${n} 天后',
	);
	@override String daysLeft({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
		other: '还剩 ${n} 天',
	);
	@override String get onNow => '进行中';
	@override String get over => '已结束';
	@override String get cancelled => '已取消';
	@override String get draft => '草稿';
	@override String get registered => '已报名';
	@override String get stateOpen => '报名中';
	@override String get stateClosed => '报名已截止';
	@override String get stateFull => '名额已满';
	@override String registrations({required num n, required Object count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
		zero: '成为第一个报名的人',
		other: '${count} 人已报名',
	);
	@override String people({required num n, required Object count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
		other: '${count} 人',
	);
	@override String placesLeft({required num n, required Object count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
		zero: '已无名额',
		other: '剩余 ${count} 个名额',
	);
	@override String oneDay({required Object start, required Object end}) => '${start} 至 ${end}';
	@override String severalDays({required Object startDay, required Object start, required Object endDay, required Object end}) => '${startDay} ${start} 开始，${endDay} ${end} 结束';
	@override String venueTime({required Object place}) => '${place}当地时间';
	@override String get addToCalendar => '添加到日历';
	@override String get share => '分享';
	@override String get directions => '路线';
	@override String get viewPoster => '查看海报';
	@override late final _Translations$events$tabs$zh tabs = _Translations$events$tabs$zh._(_root);
	@override String get noProgram => '日程即将公布。';
	@override String get noNews => '此活动暂无动态。';
	@override String get pinned => '置顶';
	@override String get now => '正在进行';
	@override String hymn({required Object number}) => '第 ${number} 首诗歌';
	@override String get about => '简介';
	@override String get fees => '费用';
	@override String deadline({required Object date}) => '报名截止：${date}';
	@override String get contact => '联系人';
	@override String call({required Object name}) => '致电 ${name}';
	@override String get otherEditions => '其他届次';
	@override String get cancelledBanner => '此活动已取消。';
	@override String get calendarFailed => '无法打开手机日历。';
	@override String get linkFailed => '无法打开此链接。';
	@override String shareText({required Object title, required Object dates, required Object place}) => '${title}\n${dates} · ${place}\n在 CMFI Connect 应用中报名。';
	@override String get full => '此活动已没有名额。';
	@override String get closed => '此活动的报名已截止。';
	@override late final _Translations$events$register$zh register = _Translations$events$register$zh._(_root);
	@override late final _Translations$events$reminder$zh reminder = _Translations$events$reminder$zh._(_root);
	@override late final _Translations$events$admin$zh admin = _Translations$events$admin$zh._(_root);
	@override String upcomingCount({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
		other: '${n} 个即将举行的活动',
	);
	@override String slide({required Object current, required Object total}) => '第 ${current} 个活动，共 ${total} 个';
}

// Path: notifications
class _Translations$notifications$zh extends Translations$notifications$fr {
	_Translations$notifications$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '通知';
	@override String get channel => '团契公告';
	@override String get empty => '暂无通知';
	@override String get emptyHint => '团契的公告会显示在这里。';
	@override String unreadLabel({required Object title}) => '未读：${title}';
	@override String documents({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
		other: '${n} 个 PDF 文档',
	);
	@override String unread({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
		other: '${n} 条未读',
	);
	@override String image({required Object n}) => '图片 ${n}';
	@override String get document => 'PDF 文档';
	@override String documentSize({required Object kb}) => '${kb} KB';
	@override String received({required Object title}) => '新通知：${title}';
}

// Path: premium
class _Translations$premium$zh extends Translations$premium$fr {
	_Translations$premium$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get name => 'CMFI Connect Premium';
	@override String get pill => 'Premium';
	@override String get subtitle => '在与神同行的路上走得更远，并支持这份事工。';
	@override String get widgetTitle => '主屏幕小组件';
	@override String get widgetText => '无需打开应用，即可查看今天的报告和目标。';
	@override String get statsTitle => '全年的目标';
	@override String get statsText => '年度总结和目标的进展，一周接一周。';
	@override String get supportTitle => '你在支持这份事工';
	@override String get supportText => '你的订阅让整个团契都能继续使用这个应用。';
	@override String get annual => '按年';
	@override String get lifetime => '终身';
	@override String get monthly => '按月';
	@override String perYear({required Object price}) => '${price} / 年';
	@override String once({required Object price}) => '${price} 一次性';
	@override String perMonth({required Object price}) => '${price} / 月';
	@override String annualPerMonth({required Object price}) => '相当于每月 ${price}';
	@override String get best => '最划算';
	@override String trialDays({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
		other: '免费试用 ${n} 天',
	);
	@override String trialMonths({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
		other: '免费试用 ${n} 个月',
	);
	@override String get subscribe => '订阅';
	@override String get startTrial => '开始免费试用';
	@override String get restore => '恢复购买';
	@override String get restored => 'Premium 已在这部手机上恢复';
	@override String get nothingToRestore => '此账户没有 Premium 购买记录';
	@override String get thanks => '谢谢你！Premium 已开启。';
	@override String get failed => '购买未完成，请稍后再试。';
	@override String get unavailable => '暂时无法获取订阅方案。';
	@override String renews({required Object store}) => '订阅会自动续订。你可以随时在 ${store} 账户设置中取消。';
	@override String get terms => '使用条款';
	@override String get privacy => '隐私';
	@override String get activeTitle => '你已拥有 Premium';
	@override String get activeText => '感谢你支持 CMFI Connect！小组件和年度总结已经开放。';
	@override String get staffText => '你是 CMFI Connect 团队的成员，Premium 免费为你开放。';
	@override String get moreSubtitle => '小组件、全年目标';
	@override String get moreActive => '已开启';
	@override String get unlock => '用 Premium 解锁';
	@override String trialThen({required Object trial, required Object price}) => '${trial}，之后 ${price}';
	@override String savePercent({required Object percent}) => '−${percent}';
	@override String get choose => '选择你的方案';
	@override String get cancelAnytime => '无需承诺，随时可取消';
	@override String get restoreShort => '恢复购买';
	@override String get termsShort => '条款';
	@override String get semiannual => '半年';
	@override String perSemester({required Object price}) => '${price} / 6 个月';
	@override String get buyLifetime => '终身购买';
	@override String get lifetimeNote => '终身：一次付款，无需订阅，不会续费。';
	@override String get manage => '管理我的订阅';
	@override String get manageFailed => '无法打开订阅管理，请稍后再试。';
	@override String get crown => '高级版会员';
}

// Path: homeWidget
class _Translations$homeWidget$zh extends Translations$homeWidget$fr {
	_Translations$homeWidget$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '今天';
	@override String get done => '已完成';
	@override String get todo => '待填写';
	@override String get open => '填写';
	@override String get locked => '用 Premium 开启小组件';
	@override String get signedOut => '请在应用中登录';
}

// Path: ministry
class _Translations$ministry$zh extends Translations$ministry$fr {
	_Translations$ministry$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '我们的事工';
	@override String get tagline => '直到地极';
	@override String count({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
		other: '${n} 个国家',
	);
	@override String get fromYaounde => '福音从雅温得出发，传到一个又一个国家。';
	@override String get dragHint => '用手指转动地球，点一个国家。';
	@override String globeLabel({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
		other: '地球：事工所在的 ${n} 个国家。下面的列表列出了全部。',
	);
	@override String get voyage => '环游';
	@override String get pause => '暂停';
	@override String get previous => '上一个国家';
	@override String get next => '下一个国家';
	@override String number({required Object n}) => '第 ${n} 个国家';
	@override String since({required Object year}) => '自 ${year} 年起';
	@override String get pray => '祷告';
	@override String prayTitle({required Object country}) => '为${country}祷告';
	@override String prayThanks({required Object country}) => '为神在${country}的工作献上感谢。';
	@override String prayAssemblies({required Object country}) => '为${country}的教会和他们的带领人祷告。';
	@override String prayUnreached({required Object country}) => '祷告让${country}还未信主的人遇见耶稣。';
	@override String get purpose => '我们的目标';
	@override String get nations => '国家';
	@override String get search => '搜索国家';
	@override String get none => '没有匹配的国家';
	@override String homeText({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
		other: '遍及 ${n} 个国家',
	);
	@override String get nationsSubtitle => '地球与逐国之旅';
	@override String get purposeSubtitle => '我们的三个目标';
	@override String get missionaries => '我们的宣教士';
	@override String get missionariesSubtitle => '主差往万国的人';
	@override String get heroes => '我们的英雄';
	@override String get heroesSubtitle => '他们的信心激励着我们';
	@override String get founder => '我们的创始人';
	@override String get founderSubtitle => 'Zacharias Tanee Fomum 教授';
	@override String get leader => '我们的领袖';
	@override String get leaderSubtitle => 'Theodore Andoseh';
	@override String get missionariesEmpty => '我们宣教士的介绍即将推出。';
	@override String get heroesEmpty => '我们英雄的介绍即将推出。';
	@override String get personGone => '此介绍已不再提供。';
	@override String photoOf({required Object name}) => '${name}的照片';
	@override String get keyDates => '重要日期';
	@override String get life => '生平';
	@override String get story => '故事';
	@override String goalOf({required Object n, required Object total}) => '我们的目标 · ${n}/${total}';
	@override String get previousGoal => '上一个目标';
	@override String get nextGoal => '下一个目标';
	@override Map<String, String> get media => {
		'books': '书籍',
		'tracts': '单张',
		'magazines': '杂志',
		'cds': 'CD',
		'dvds': 'DVD',
		'radio': '广播',
		'tv': '电视',
		'internet': '互联网',
	};
	@override late final _Translations$ministry$goals$zh goals = _Translations$ministry$goals$zh._(_root);
	@override late final _Translations$ministry$lives$zh lives = _Translations$ministry$lives$zh._(_root);
}

// Path: prayer
class _Translations$prayer$zh extends Translations$prayer$fr {
	_Translations$prayer$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override Map<String, String> get moments => {
		'morning': '早晨',
		'noon': '中午',
		'evening': '傍晚',
		'night': '夜晚',
	};
	@override Map<String, String> get retreatOf => {
		'morning': '早晨祷告',
		'noon': '中午祷告',
		'evening': '傍晚祷告',
		'night': '夜晚祷告',
	};
	@override late final _Translations$prayer$hero$zh hero = _Translations$prayer$hero$zh._(_root);
	@override late final _Translations$prayer$today$zh today = _Translations$prayer$today$zh._(_root);
	@override late final _Translations$prayer$routine$zh routine = _Translations$prayer$routine$zh._(_root);
	@override String get together => '一起祷告';
	@override late final _Translations$prayer$reminders$zh reminders = _Translations$prayer$reminders$zh._(_root);
	@override late final _Translations$prayer$retreat$zh retreat = _Translations$prayer$retreat$zh._(_root);
	@override late final _Translations$prayer$session$zh session = _Translations$prayer$session$zh._(_root);
	@override late final _Translations$prayer$done$zh done = _Translations$prayer$done$zh._(_root);
	@override late final _Translations$prayer$topics$zh topics = _Translations$prayer$topics$zh._(_root);
	@override late final _Translations$prayer$lists$zh lists = _Translations$prayer$lists$zh._(_root);
	@override late final _Translations$prayer$importunity$zh importunity = _Translations$prayer$importunity$zh._(_root);
}

// Path: sending
class _Translations$sending$zh extends Translations$sending$fr {
	_Translations$sending$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '发送给我的属灵长辈';
	@override String get moreOff => '已关闭';
	@override String get intro => '到了你选定的时间，CMFI Connect 会准备好这段时间的报告，你只需发送给你的属灵长辈。';
	@override String get enabled => '定期为我准备';
	@override String get rhythm => '频率';
	@override String get weekly => '每周';
	@override String get biweekly => '每两周';
	@override String get monthly => '每月';
	@override String get day => '日期';
	@override String get monthlyDay => '每月 1 日，发送上个月的报告';
	@override String get time => '时间';
	@override String get recipients => '收件人';
	@override String get noAuthorities => '请先添加你的属灵长辈。';
	@override String get addAuthorities => '添加属灵长辈';
	@override String get viaWhatsApp => '通过 WhatsApp';
	@override String get viaEmail => '通过电子邮件';
	@override String get viaBoth => '通过 WhatsApp 或电子邮件';
	@override String get viaShare => '通过分享';
	@override String next({required Object date}) => '下一次：${date}';
	@override String get prepareNow => '立即准备';
	@override String get history => '最近发送';
	@override String get notificationTitle => '你的报告已准备好';
	@override String get notificationBody => '一键发送给你的属灵长辈。';
	@override String get channel => '报告发送';
	@override String get readyTitle => '你的报告已准备好';
	@override String get preview => '消息预览';
	@override String greeting({required Object name}) => '${name}，你好：';
	@override String get whatsApp => 'WhatsApp';
	@override String get email => '电子邮件';
	@override String get sharePdf => '分享 PDF';
	@override String get shareText => '分享文字';
	@override String get sent => '已发送';
	@override String get shared => '已分享';
	@override String get noRecipients => '请在设置中选择收件人，或分享 PDF。';
	@override String get settings => '设置';
	@override String get permissionDenied => '请允许通知，以便按时提醒你。';
}

// Path: streak
class _Translations$streak$zh extends Translations$streak$fr {
	_Translations$streak$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String title({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
		other: '连续 ${n} 天！',
	);
	@override String cardDays({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
		other: '天，与神同在',
	);
	@override late final _Translations$streak$lines$zh lines = _Translations$streak$lines$zh._(_root);
	@override String get share => '分享';
	@override String get close => '继续';
}

// Path: shortcuts
class _Translations$shortcuts$zh extends Translations$shortcuts$fr {
	_Translations$shortcuts$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get today => '填写我的汇报';
	@override String get hymns => '诗歌';
	@override String get retreat => '此刻的祷告';
}

// Path: blocking
class _Translations$blocking$zh extends Translations$blocking$fr {
	_Translations$blocking$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get report => '举报';
	@override String block({required Object name}) => '屏蔽${name}';
	@override String blockTitle({required Object name}) => '屏蔽${name}？';
	@override String blockText({required Object name}) => '你将不再收到${name}的邀请。这条邀请会被移除。';
	@override String get blockAction => '屏蔽';
	@override String blocked({required Object name}) => '${name}将无法再邀请你。';
	@override String get reportTitle => '举报这条邀请';
	@override String get reportText => '告诉我们哪里不对：团契的负责人会查看。';
	@override late final _Translations$blocking$reasons$zh reasons = _Translations$blocking$reasons$zh._(_root);
	@override String get comment => '备注';
	@override String get commentHint => '负责人需要了解的情况';
	@override String get send => '提交举报';
	@override String get reported => '谢谢，负责人会查看。';
	@override String get listTitle => '已屏蔽的成员';
	@override String get intro => '他们的祷告邀请不会再发给你。';
	@override String get empty => '你还没有屏蔽任何人。';
	@override String get unblock => '取消屏蔽';
	@override String unblocked({required Object name}) => '${name}可以再次邀请你。';
}

// Path: verses
class _Translations$verses$zh extends Translations$verses$fr {
	_Translations$verses$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '每日经文';
	@override String get share => '分享经文';
	@override String get shareImage => '分享图片';
	@override String get shareText => '分享文字';
}

// Path: bible
class _Translations$bible$zh extends Translations$bible$fr {
	_Translations$bible$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '圣经';
	@override String get books => '书卷';
	@override String get oldTestament => '旧约';
	@override String get newTestament => '新约';
	@override String chapters({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
		other: '${n} 章',
	);
	@override String chapter({required Object n}) => '第 ${n} 章';
	@override String get version => '译本';
	@override String get versions => '圣经译本';
	@override String get search => '搜索圣经';
	@override String get searchHint => '一个词，或“约翰福音 3:16”';
	@override String get searchTip => '搜索一个词（“爱”），或直接前往经文（“诗篇 23”、“约翰福音 3:16”）。';
	@override String get searchNone => '没有经文包含这些词。';
	@override String searchCount({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
		other: '${n} 节经文',
	);
	@override String searchLimit({required Object n}) => '前 ${n} 节经文';
	@override String get searchNeedsDownload => '下载这本圣经后，即可在全书中搜索词语。现在已经可以输入经文：“约翰福音 3:16”。';
	@override String open({required Object reference}) => '打开 ${reference}';
	@override String get previous => '上一章';
	@override String get next => '下一章';
	@override String get markRead => '我读完了这一章';
	@override String get markedRead => '今天已读';
	@override String get markReadHint => '在你的汇报中为“读经”加 1 章。';
	@override String addedToReport({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
		other: '汇报：今天已读 ${n} 章',
	);
	@override String get removedFromReport => '已从汇报中移除';
	@override String get noReadingItem => '你的汇报中没有“读经”这一项。';
	@override String get download => '下载这本圣经';
	@override String downloadHelp({required Object size}) => '约 ${size} MB，无网络时也能阅读和搜索。';
	@override String downloading({required Object percent}) => '正在下载… ${percent}%';
	@override String get downloaded => '已在手机上';
	@override String downloadDone({required Object version}) => '${version} 已在你的手机上';
	@override String get removeDownload => '从手机移除';
	@override String removeDownloadTitle({required Object version}) => '从手机移除 ${version}？';
	@override String get removeDownloadText => '你已读过的章节仍可离线阅读。';
	@override String get offline => '这一章还不在你的手机上。请重新联网，或下载这本圣经以便离线阅读。';
	@override String get notInVersion => '这个译本中没有这段经文。';
	@override String get marks => '我的经文';
	@override String get favorites => '收藏';
	@override String get highlights => '标记';
	@override String get noFavorites => '点一节经文，再点书签，就能在这里找到它。';
	@override String get noHighlights => '点一节经文，再选一种颜色来标记它。';
	@override String get tapHint => '点一节经文，即可标记、收藏、复制或分享。';
	@override String highlight({required Object color}) => '用${color}标记';
	@override late final _Translations$bible$colors$zh colors = _Translations$bible$colors$zh._(_root);
	@override String get removeHighlight => '移除颜色';
	@override String get addFavorite => '收藏到我的经文';
	@override String get removeFavorite => '从我的经文中移除';
	@override String get favoriteAdded => '已收藏到我的经文';
	@override String get favoriteRemoved => '已从我的经文中移除';
	@override String get copy => '复制';
	@override String get copied => '已复制';
	@override String get share => '分享';
	@override String get closeSelection => '关闭选择';
	@override String get display => '显示';
	@override String get jesusInRed => '耶稣的话用红色显示';
	@override String get jesusInRedHelp => '适用于标注了耶稣话语的译本';
	@override String get remove => '移除';
	@override String get readInBible => '在圣经中阅读';
	@override String get concordance => '经文汇编';
	@override String concordanceOf({required Object word}) => '“${word}”的经文汇编';
	@override String get concordanceHint => '圣经中的一个词';
	@override String get concordanceTip => '输入一个词：经文汇编按书卷列出它出现的每一节经文。';
	@override String get concordanceNeedsDownload => '经文汇编会查遍整本圣经：请先下载。';
	@override String get concordanceNone => '这本圣经中没有这个词。';
	@override String get exactWord => '这个词';
	@override String get startsWith => '开头为…';
	@override String occurrences({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
		other: '次',
	);
	@override String inVerses({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
		other: '出现在 ${n} 节经文中',
	);
	@override String get spread => '这个词出现的位置';
	@override String get forms => '找到的形式';
	@override String bookCount({required Object book, required Object n}) => '${book}：${n}';
	@override String get allBooks => '所有书卷';
	@override String get pickWord => '选择一个词';
	@override String get pickWordHelp => '经文汇编会列出它出现的每一节经文。';
	@override String get more => '更多选项';
	@override String get crossReferences => '串珠经文';
	@override String crossReferencesOf({required Object passage}) => '串珠经文 · ${passage}';
	@override String get noCrossReferences => '此段经文没有串珠。';
	@override String get crossReferencesSource => '来源：OpenBible.info（CC-BY）';
}

// Path: profilePhoto
class _Translations$profilePhoto$zh extends Translations$profilePhoto$fr {
	_Translations$profilePhoto$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '头像';
	@override String get add => '添加头像';
	@override String get change => '更换头像';
	@override String get seenBy => '其他成员在你的名字出现的地方都能看到它。';
	@override String get camera => '拍照';
	@override String get gallery => '从相册选择';
	@override String get remove => '移除照片';
	@override String get cropTitle => '裁剪你的照片';
	@override String get cropHint => '用手指移动和放大照片。';
	@override String get use => '使用这张照片';
	@override String get unreadable => '无法打开此图片，请选择另一张。';
	@override String get saved => '你的头像已保存。';
	@override String get removed => '你的头像已移除。';
}

// Path: disciples
class _Translations$disciples$zh extends Translations$disciples$fr {
	_Translations$disciples$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '我的门徒';
	@override String get empty => '还没有门徒';
	@override String get emptyText => '当有成员选择你作为门训者或属灵权柄、并且你接受了请求，他就会出现在这里。';
	@override String count({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
		other: '${n} 位门徒',
	);
	@override String get notShared => '未分享其报告';
	@override String get roleMaker => '你是他的门训者';
	@override String get roleAuthority => '你是他的属灵权柄之一';
	@override String dayGoals({required Object percent}) => '目标 ${percent} %';
	@override String dayItems({required Object total, required Object filled, required Object percent}) => '${total} 项中填写了 ${filled} 项 · ${percent} %';
	@override String get older => '查看之前的 30 天';
	@override String get noReports => '这段时间没有报告。';
	@override String get searchHint => '姓名或用户名';
	@override String noMatch({required Object search}) => '没有与“${search}”匹配的门徒。';
}

// Path: weekStory
class _Translations$weekStory$zh extends Translations$weekStory$fr {
	_Translations$weekStory$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '你与神同在的一周';
	@override String range({required Object from, required Object to}) => '${from}至${to}';
	@override String get intro => '回顾这一周你与主同在的点滴。';
	@override String get tapHint => '点击右侧继续，点击左侧返回。';
	@override String get faithfulLead => '你很忠心';
	@override String get emptyLead => '新的一周在等着你';
	@override String days({required num n, required Object total}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
		other: '${total} 天中\n有 ${n} 天',
	);
	@override String streak({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
		other: '连续 ${n} 天',
	);
	@override String streakRecord({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
		other: '连续 ${n} 天：你的纪录！',
	);
	@override String get emptyText => '每天填写你的报告：你的下一周将写在这里。';
	@override String get prayerLead => '你祷告了';
	@override String retreats({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
		other: '${n} 次退修',
	);
	@override String retreatsTime({required Object time}) => '每次 15 分钟 · 与主同在 ${time}';
	@override String faithfulMoment({required num n, required Object moment}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
		other: '你最忠心的时段：${moment}（${n} 次）',
	);
	@override String get noRetreat => '本周没有退修';
	@override String get noRetreatText => '午间退修在等着你：与主同在 15 分钟。';
	@override String get goalsLead => '你的目标';
	@override String get goalsReached => '平均达成';
	@override String bestDay({required Object day, required Object percent}) => '你最好的一天：${day} · ${percent}';
	@override String get summaryTitle => '我与神同在的一周';
	@override String get statDays => '天已填写';
	@override String statStreak({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
		other: '天连续',
	);
	@override String statRetreats({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
		other: '次退修',
	);
	@override String get statGoals => '目标';
	@override String get share => '分享我的一周';
	@override String get homeText => '你这一周的忠心、祷告和目标。';
	@override String get open => '查看我的一周';
	@override String get notificationTitle => '你与神同在的一周已准备好';
	@override String get notificationBody => '回顾你这一周的忠心并分享出去。';
	@override String get channel => '你与神同在的一周';
	@override String get thisWeek => '本周';
	@override String get pastWeeks => '过去几周';
	@override String weekOf({required Object date}) => '${date} 那一周';
	@override String page({required Object current, required Object total}) => '第 ${current} 页，共 ${total} 页';
}

// Path: seekFirst
class _Translations$seekFirst$zh extends Translations$seekFirst$fr {
	_Translations$seekFirst$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '先求神';
	@override String get verse => '你们要先求他的国和他的义，这些东西都要加给你们了。';
	@override String get verseRef => '马太福音 6:33';
	@override String get intro => '每天，你选择的应用会一直关闭，直到你保存当天的汇报。用神开始你的一天，其余的随后而来。';
	@override String get enable => '开启';
	@override String get apps => '要关闭的应用';
	@override String get appsNone => '尚未选择应用';
	@override String appCount({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
		other: '${n} 个应用',
	);
	@override String categoryCount({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
		other: '${n} 个类别',
	);
	@override String siteCount({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
		other: '${n} 个网站',
	);
	@override String get start => '关闭时间';
	@override String get pauses => '5 分钟暂停';
	@override String get pausesText => '每天 3 次，用于紧急情况';
	@override String pausesLeft({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
		zero: '今天没有剩余的暂停',
		other: '今天还剩 ${n} 次暂停',
	);
	@override String get todayOpen => '今天你的应用已打开：你先求了神。';
	@override String get todayLocked => '在完成今天的汇报之前，你的应用保持关闭。';
	@override String todayBefore({required Object time}) => '如果你的汇报还没有保存，你的应用将在 ${time} 关闭。';
	@override String get fillReport => '填写我的汇报';
	@override String get denied => '没有“屏幕使用时间”的权限，CMFI Connect 无法关闭应用。你可以在“设置 › 屏幕使用时间”中允许。';
	@override String get noApps => '请至少选择一个要关闭的应用。';
	@override String get unsupported => '即将在此手机上推出。';
	@override String moreOn({required Object time}) => '从 ${time} 起，直到你的汇报';
	@override String get moreOff => '在完成汇报前关闭应用';
	@override String get privacy => 'CMFI Connect 永远看不到你选择了哪些应用：它们只保存在你的 iPhone 上。';
	@override late final _Translations$seekFirst$shield$zh shield = _Translations$seekFirst$shield$zh._(_root);
	@override String get permissionsAndroid => '为了关闭你的应用，CMFI Connect 需要在即将打开的设置中开启两项权限：“使用情况访问权限”（知道哪个应用在前台）和“显示在其他应用上层”（显示“先求神”页面）。任何数据都不会离开你的手机。';
	@override String get permissionsContinue => '继续';
	@override String get deniedAndroid => '没有这两项权限，CMFI Connect 无法关闭应用。你可以在“设置 › 应用 › 特殊访问权限”中开启。';
	@override String get privacyAndroid => '你选择的应用只保存在手机上：CMFI Connect 绝不会上传。';
}

// Path: documents
class _Translations$documents$zh extends Translations$documents$fr {
	_Translations$documents$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '我们的文件';
	@override String get subtitle => '教导、规章、表格…';
	@override String get moreSubtitle => '团契的资料库';
	@override String get search => '搜索文件';
	@override String get all => '全部';
	@override String get empty => '暂无文件。团契发布的文件会显示在这里。';
	@override String get none => '没有符合搜索的文件。';
	@override String sizeKb({required Object n}) => '${n} KB';
	@override String sizeMb({required Object n}) => '${n} MB';
	@override String get pdf => 'PDF';
	@override String get word => 'Word';
	@override String get open => '打开文件';
	@override String get download => '下载';
	@override String count({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
		other: '${n} 个文件',
	);
	@override String get more => '查看更多';
}

// Path: biblePlan
class _Translations$biblePlan$zh extends Translations$biblePlan$fr {
	_Translations$biblePlan$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '读经计划';
	@override String get intro => '选择你要读的内容和用多长时间：应用会把章节一天天分配好。';
	@override String get duration => '时长';
	@override String get months3 => '3 个月';
	@override String get months6 => '6 个月';
	@override String get year => '1 年';
	@override String get custom => '其他';
	@override String days({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
		other: '${n} 天',
	);
	@override String get scope => '读什么';
	@override Map<String, String> get scopes => {
		'bible': '整本圣经',
		'newTestament': '新约',
		'oldTestament': '旧约',
		'psalmsProverbs': '诗篇和箴言',
	};
	@override String get order => '顺序';
	@override Map<String, String> get orders => {
		'canonical': '按书卷顺序',
		'parallel': '新旧约每天',
	};
	@override String get reminder => '每日提醒';
	@override String get reminderAt => '提醒时间';
	@override String summary({required Object days, required Object chapters, required Object perDay}) => '${days} 天读 ${chapters} 章，每天约 ${perDay} 章';
	@override String endsOn({required Object date}) => '${date} 结束';
	@override String startsOn({required Object date}) => '计划将于 ${date} 开始。';
	@override String get start => '开始计划';
	@override String dayOf({required Object day, required Object total}) => '第 ${day} 天，共 ${total} 天';
	@override String get today => '今日读经';
	@override String get todayDone => '今日读经已完成，真棒！';
	@override String get read => '阅读';
	@override String behind({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
		other: '落后 ${n} 天',
	);
	@override String get catchUp => '点这里查看要补读的章节。';
	@override String chaptersRead({required Object read, required Object total}) => '已读 ${read} / ${total} 章';
	@override String get late => '落后';
	@override String get upcoming => '接下来';
	@override String dayNumber({required Object n}) => '第 ${n} 天';
	@override String get finished => '计划完成！你全部读完了。';
	@override String get stop => '停止计划';
	@override String get stopTitle => '停止这个计划？';
	@override String get stopText => '你在此计划中的进度将被清除。已计入汇报的章节仍会保留。';
	@override String get reminderTitle => '你的今日读经';
	@override String get reminderChannel => '读经计划';
	@override String get homeTitle => '今日读经';
	@override String check({required Object chapter}) => '将${chapter}标为已读';
	@override String uncheck({required Object chapter}) => '${chapter}：已读';
}

// Path: teachings
class _Translations$teachings$zh extends Translations$teachings$fr {
	_Translations$teachings$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '教导';
	@override String get subtitle => '随时随地聆听圣言';
	@override String get search => '搜索信息或讲员…';
	@override String get all => '全部';
	@override String get downloadedChip => '已下载';
	@override String count({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
		one: '${n} 篇信息',
		other: '${n} 篇信息',
	);
	@override String get empty => '暂时还没有教导。';
	@override String get none => '没有符合的教导。';
	@override String get noneDownloaded => '还没有下载信息。点信息旁的云朵，即可离线收听。';
	@override String get more => '查看更多';
	@override String get offline => '没有网络：这是保存在手机上的信息。';
	@override String get play => '收听';
	@override String get pause => '暂停';
	@override String get heard => '已听完';
	@override String get download => '下载以便离线收听';
	@override String get downloaded => '已保存到手机';
	@override String get removed => '已从手机移除';
	@override String get cancelDownload => '停止下载';
	@override String get removeDownload => '从手机移除';
	@override String get back15 => '后退 15 秒';
	@override String get forward15 => '前进 15 秒';
	@override String speed({required Object speed}) => '速度 ${speed}';
	@override String recordedOn({required Object date}) => '${date} 的信息';
	@override String get moreSubtitle => '可收听的讲道与教导';
}

// Path: memorize
class _Translations$memorize$zh extends Translations$memorize$fr {
	_Translations$memorize$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '背经';
	@override String get subtitle => '将神的话藏在心里';
	@override String get toReview => '待复习';
	@override String get learning => '学习中';
	@override String get known => '已熟记';
	@override String reviewCount({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
		one: '复习 ${n} 节经文',
		other: '复习 ${n} 节经文',
	);
	@override String get nothingDue => '今天没有要复习的。';
	@override String nextOn({required Object date}) => '下次复习：${date}。';
	@override String get tomorrow => '明天';
	@override String get reminder => '复习提醒';
	@override String get reminderAt => '提醒时间';
	@override String get myVerses => '我的经文';
	@override String get howToAdd => '添加方法：在圣经中点一节经文，再点工具栏里的大脑图标。';
	@override String get empty => '还没有要背的经文。';
	@override String get openBible => '打开圣经';
	@override String get late => '已逾期';
	@override String get today => '今天';
	@override String dueIn({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
		one: '${n} 天后',
		other: '${n} 天后',
	);
	@override Map<String, String> get stages => {
		'fresh': '新',
		'learning': '学习中',
		'known': '已熟记',
	};
	@override String stats({required Object stage, required Object lapses}) => '${stage} · 忘记 ${lapses} 次';
	@override String get reviewNow => '现在复习';
	@override String get remove => '移除';
	@override String get removeTitle => '移除这节经文？';
	@override String get removeText => '它的进度将被清除。';
	@override String get removed => '经文已移除';
	@override String progress({required Object done, required Object total}) => '${done} / ${total}';
	@override String get show => '显示经文';
	@override Map<String, String> get hints => {
		'full': '全文',
		'gaps': '填空',
		'initials': '首字',
		'none': '无提示',
	};
	@override String get recite => '先背诵经文，再核对。';
	@override Map<String, String> get grades => {
		'again': '再来',
		'hard': '困难',
		'good': '良好',
		'easy': '容易',
	};
	@override String get now => '马上';
	@override String later({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
		one: '${n} 天',
		other: '${n} 天',
	);
	@override String get doneTitle => '复习完成！';
	@override String doneText({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
		one: '你复习了 ${n} 节经文。愿主的道住在你心里！',
		other: '你复习了 ${n} 节经文。愿主的道住在你心里！',
	);
	@override String get back => '返回';
	@override String get reminderTitle => '你要复习的经文';
	@override String reminderBody({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
		one: '今天有 ${n} 节经文等你复习。',
		other: '今天有 ${n} 节经文等你复习。',
	);
	@override String get reminderChannel => '背经';
	@override String get homeTitle => '待复习经文';
	@override String homeText({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
		one: '${n} 节经文等你',
		other: '${n} 节经文等你',
	);
	@override String get menu => '背诵经文';
	@override String get memorize => '背诵';
	@override String get added => '已加入背经列表';
	@override String get already => '这段经文已在你的列表中';
}

// Path: souls
class _Translations$souls$zh extends Translations$souls$fr {
	_Translations$souls$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '灵魂跟进';
	@override String get subtitle => '「有智慧的必能得人。」箴言 11:30';
	@override String get search => '搜索某人…';
	@override String get people => '人数';
	@override String get received => '已接受耶稣';
	@override String get toContact => '待联系';
	@override String get all => '全部';
	@override Map<String, String> get stages => {
		'met': '已结识',
		'interested': '有兴趣',
		'received': '已接受耶稣',
		'followUp': '坚固中',
		'church': '来教会',
		'baptized': '已受洗',
	};
	@override String get contactSection => '待再次联系';
	@override String get everyone => '所有人';
	@override String get contactToday => '今天联系';
	@override String contactLate({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
		one: '逾期 ${n} 天',
		other: '逾期 ${n} 天',
	);
	@override String contactOn({required Object date}) => '下次联系：${date}';
	@override String get empty => '在这里记下你传福音的对象：为他们祷告，陪伴他们走进教会。';
	@override String get none => '没有符合的人。';
	@override String get add => '添加';
	@override String get addTitle => '新增人员';
	@override String get editTitle => '编辑';
	@override String get name => '姓名';
	@override String get nameRequired => '请填写姓名。';
	@override String get phone => '电话';
	@override String get place => '在哪里认识';
	@override String get metOn => '认识日期';
	@override String get stage => '此人目前的状况？';
	@override String get firstNote => '备注（可选）';
	@override String get noteHint => '谈话内容、代祷事项…';
	@override String get save => '保存';
	@override String get saved => '已保存';
	@override String get call => '打电话';
	@override String get whatsApp => 'WhatsApp';
	@override String get sms => '短信';
	@override String get edit => '编辑';
	@override String get delete => '删除';
	@override String deleteTitle({required Object name}) => '删除 ${name}？';
	@override String get deleteText => '相关备注将从手机中删除。';
	@override String get deleted => '已删除';
	@override String get nextContact => '下次联系';
	@override String get plan => '设置提醒';
	@override String get change => '更改日期';
	@override String get clear => '取消提醒';
	@override String get noContact => '没有提醒';
	@override String metAt({required Object date}) => '${date} 认识';
	@override String get notes => '备注';
	@override String get addNote => '添加备注';
	@override String get noNotes => '还没有备注。';
	@override String get deleteNote => '删除备注';
	@override String get export => '导出（表格）';
	@override late final _Translations$souls$csv$zh csv = _Translations$souls$csv$zh._(_root);
	@override String lock({required Object method}) => '使用${method}锁定';
	@override String get lockedTitle => '灵魂跟进已锁定';
	@override String get unlock => '解锁';
	@override String get unlockReason => '打开灵魂跟进';
	@override String get privacy => '这些信息只保存在你的手机上，绝不会上传。';
	@override String get reminderTitle => '灵魂跟进';
	@override String reminderBody({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
		one: '今天要联系 ${n} 人。',
		other: '今天要联系 ${n} 人。',
	);
	@override String get reminderChannel => '灵魂跟进';
	@override String get moreSubtitle => '你传福音的对象';
	@override String get prayToday => '今天为他代祷';
	@override String get prayerReminder => '每天早上提醒我';
	@override String get prayerReminderAt => '代祷提醒时间';
	@override String get prayerTitle => '为一个灵魂代祷';
	@override String get prayerBody => '花点时间为今天的这个人祷告。';
	@override String get prayerChannel => '为灵魂代祷';
}

// Path: fasts
class _Translations$fasts$zh extends Translations$fasts$fr {
	_Translations$fasts$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '我的禁食';
	@override String get intro => '为神分别出来：选择你的禁食和代祷事项。每坚持一天都会计入你的报告。';
	@override String get moreSubtitle => '完全或部分禁食，每天计入';
	@override String get kind => '你的禁食';
	@override Map<String, String> get kinds => {
		'full': '完全禁食',
		'partial': '部分禁食',
	};
	@override Map<String, String> get kindTexts => {
		'full': '昼夜不食，每天 24 小时，从现在开始。',
		'partial': '每天禁食到所选时间，然后开斋。',
	};
	@override String get length => '时长';
	@override String days({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
		one: '${n} 天',
		other: '${n} 天',
	);
	@override String get endEachDay => '每天结束禁食的时间';
	@override String get topics => '我为此禁食';
	@override String get topicHint => '一个代祷事项…';
	@override String get addTopic => '添加事项';
	@override String get removeTopic => '移除事项';
	@override String get history => '最近的禁食';
	@override String kept({required Object kept, required Object days}) => '${kept}/${days} 天';
	@override String get start => '开始禁食';
	@override String until({required Object date}) => '直到 ${date}';
	@override String hoursLeft({required Object h, required Object m}) => '${h} 小时 ${m}';
	@override String minutesLeft({required Object m}) => '${m} 分钟';
	@override String dayOf({required Object day, required Object total}) => '第 ${day} 天，共 ${total} 天';
	@override String dayEnds({required Object time}) => '今天的禁食在 ${time} 结束';
	@override String get stop => '结束禁食';
	@override String get stopTitle => '要结束禁食吗？';
	@override String get stopText => '已完成的天数仍计入，进行中的这一天不计。';
	@override String counted({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
		one: '已有 ${n} 天禁食计入报告',
		other: '已有 ${n} 天禁食计入报告',
	);
	@override String reportNote({required Object item}) => '每坚持一天，报告中的“${item}”加 1。';
	@override Map<String, String> get items => {
		'full': '完全禁食',
		'partial': '部分禁食',
	};
	@override String dayTitle({required Object day}) => '禁食第 ${day} 天完成';
	@override String get dayBody => '已计入报告。加油，继续！';
	@override String get endTitle => '你的禁食结束了';
	@override String get endBody => '愿主垂听你的祷告。';
	@override String get channel => '我的禁食';
	@override String homeTitle({required Object day, required Object total}) => '禁食 · 第 ${day}/${total} 天';
	@override String homeText({required Object time}) => '今天在 ${time} 结束';
}

// Path: welcome.seek
class _Translations$welcome$seek$zh extends Translations$welcome$seek$fr {
	_Translations$welcome$seek$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get before => '每天先寻求';
	@override String get marked => '神';
	@override String get after => '';
	@override String get text => '几秒钟就能记下你的读经、祷告、禁食……每周都能看到自己的进步。';
}

// Path: welcome.worship
class _Translations$welcome$worship$zh extends Translations$welcome$worship$fr {
	_Translations$welcome$worship$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get before => '随时随地，歌唱与';
	@override String get marked => '祷告';
	@override String get after => '';
	@override String get text => '查看团契的诗歌，每天与弟兄姊妹一起为代祷事项祷告。';
}

// Path: welcome.community
class _Translations$welcome$community$zh extends Translations$welcome$community$fr {
	_Translations$welcome$community$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get before => '与你的';
	@override String get marked => '团契';
	@override String get after => '保持联系';
	@override String get text => '你所在聚会点的活动和通知都在这里，一条也不会错过。';
}

// Path: welcome.sample
class _Translations$welcome$sample$zh extends Translations$welcome$sample$fr {
	_Translations$welcome$sample$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get bibleReading => '读经';
	@override String get chapters => '10 章';
	@override String get prayerAlone => '个人祷告';
	@override String get hymn => '诗歌';
	@override String get hymnNumber => '第 12 首';
	@override String get prayerOfTheDay => '今日代祷事项';
	@override String get prayerTopic => '为青年们的考试祷告';
	@override String get praying => '12 人正在祷告';
	@override String get iPray => '我来祷告';
	@override String get retreat => '青年退修会';
	@override String get announcement => '通知';
	@override String get announcementText => '主日崇拜早上 8:30 开始。';
}

// Path: auth.login
class _Translations$auth$login$zh extends Translations$auth$login$fr {
	_Translations$auth$login$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '欢迎回来';
	@override String get subtitle => '登录，继续你与神同行的路，与教会肢体相连。';
	@override String get welcomeBack => '很高兴见到你！';
	@override String get submit => '登录';
	@override String get noAccount => '还没有账号？';
	@override String get createAccount => '创建账号';
}

// Path: auth.register
class _Translations$auth$register$zh extends Translations$auth$register$fr {
	_Translations$auth$register$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String step({required Object current, required Object total}) => '${current} / ${total}';
	@override String get title => '创建你的账号';
	@override String get subtitle => '你将使用手机号登录。';
	@override String get firstName => '名';
	@override String get lastName => '姓';
	@override String get passwordHelp => '至少 6 个字符';
	@override String get email => '邮箱';
	@override String get submit => '继续';
	@override String get haveAccount => '已有账号？';
	@override String get login => '登录';
	@override String get alreadyUsed => '该手机号或邮箱已注册，请直接登录。';
	@override String get emailHint => 'you@example.com';
}

// Path: auth.church
class _Translations$auth$church$zh extends Translations$auth$church$fr {
	_Translations$auth$church$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '你的教会';
	@override String get subtitle => '这些信息能帮助你的带领者找到你。之后可以随时修改。';
	@override String get editTitle => '我的资料';
	@override String get editSubtitle => '更新你的姓名、教会和聚会点。';
	@override String get country => '国家';
	@override String get countryHint => '选择你的国家/地区';
	@override String get city => '城市';
	@override String get cityHint => '雅温得';
	@override String get church => '教会';
	@override String get churchHint => '你的教会名称';
	@override String get assembly => '聚会点';
	@override String get assemblyHint => '你的聚会点名称';
	@override String get info => '搬家了或换了聚会点？随时可以在个人资料中更新。';
	@override String get submit => '完成';
	@override String get skip => '跳过此步';
	@override String get saved => '资料已保存';
}

// Path: auth.forgot
class _Translations$auth$forgot$zh extends Translations$auth$forgot$fr {
	_Translations$auth$forgot$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get link => '忘记密码？';
	@override String get title => '忘记密码';
	@override String get phoneText => '输入你的号码：我们会通过短信发送验证码，用来设置新密码。';
	@override String get sendCode => '获取验证码';
	@override String get codeTitle => '输入验证码';
	@override String codeText({required Object phone}) => '我们已向 ${phone} 发送了 6 位验证码。';
	@override String get code => '短信验证码';
	@override String get codeInvalid => '验证码为 6 位数字';
	@override String get verify => '验证';
	@override String get resend => '重新发送验证码';
	@override String resendIn({required Object seconds}) => '${seconds} 秒后可重新发送';
	@override String get changeNumber => '更换号码';
	@override String get passwordTitle => '新密码';
	@override String get passwordText => '为你的账号设置一个新密码。';
	@override String get submit => '保存并登录';
	@override String get done => '密码已更改，欢迎回来！';
	@override String get remembered => '想起来了？';
	@override String get invalidCode => '验证码不正确。';
	@override String get expired => '验证码已过期，请重新获取。';
	@override String get tooManyRequests => '尝试次数过多，请稍后再试。';
	@override String get unavailable => '暂时无法重置密码。';
	@override String get noAccount => '没有账号使用这个号码。';
}

// Path: auth.biometric
class _Translations$auth$biometric$zh extends Translations$auth$biometric$fr {
	_Translations$auth$biometric$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get faceId => '面容 ID';
	@override String get touchId => '触控 ID';
	@override String get fingerprint => '指纹';
	@override String get face => '面部';
	@override String signIn({required Object method}) => '使用${method}登录';
	@override String askTitle({required Object method}) => '使用${method}登录？';
	@override String get askText => '下次无需再输入密码：它保存在你手机的安全保险箱中。';
	@override String get enable => '开启';
	@override String get later => '以后再说';
	@override String get reason => '登录 CMFI Connect';
	@override String get enableReason => '开启 CMFI Connect 快速登录';
	@override String changed({required Object method}) => '你的密码已更改：请用密码登录，然后重新开启${method}。';
	@override String settings({required Object method}) => '使用${method}登录';
	@override String get settingsText => '无需输入密码';
	@override String get passwordTitle => '你的密码';
	@override String get passwordLabel => '密码';
	@override String get confirm => '确认';
	@override String enabled({required Object method}) => '已开启${method}登录';
}

// Path: reports.tabs
class _Translations$reports$tabs$zh extends Translations$reports$tabs$fr {
	_Translations$reports$tabs$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get today => '今天';
	@override String get history => '历史';
	@override String get summary => '总结';
}

// Path: reports.measure
class _Translations$reports$measure$zh extends Translations$reports$measure$fr {
	_Translations$reports$measure$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String quantity({required Object unit}) => '${unit}';
	@override String get duration => '时长';
	@override String both({required Object unit}) => '${unit}和时长';
	@override String get quantityNoUnit => '数量';
	@override String get bothNoUnit => '数量和时长';
}

// Path: reports.sheet
class _Translations$reports$sheet$zh extends Translations$reports$sheet$fr {
	_Translations$reports$sheet$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get quantity => '数量';
	@override String get duration => '时长';
	@override String get minus1 => '− 1 分钟';
	@override String get plus1 => '+ 1 分钟';
	@override String get removeMinute => '减少一分钟';
	@override String get addMinute => '增加一分钟';
	@override String get holdToRepeat => '长按可快速调整';
	@override String get decrease => '减少';
	@override String get increase => '增加';
	@override String get clear => '清除';
	@override String get validate => '确定';
}

// Path: reports.history
class _Translations$reports$history$zh extends Translations$reports$history$fr {
	_Translations$reports$history$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String daysFilled({required Object total, required Object filled}) => '${total} 天中已填写 ${filled} 天';
	@override String get legendFilled => '已填写';
	@override String get legendMissing => '无汇报';
	@override String get none => '无汇报';
	@override String get fill => '填写';
	@override String get inProgress => '进行中';
	@override String get previousMonth => '上个月';
	@override String get nextMonth => '下个月';
	@override String get today => '今天';
}

// Path: reports.summary
class _Translations$reports$summary$zh extends Translations$reports$summary$fr {
	_Translations$reports$summary$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get week => '周';
	@override String get month => '月';
	@override String get year => '年';
	@override String range({required Object from, required Object to}) => '${from} 至 ${to}';
	@override String get regularity => '坚持度';
	@override String get daysFilled => '天已填写';
	@override String missingDays({required num n, required Object days}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
		other: '${n} 天没有汇报：${days}',
	);
	@override String missingCount({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
		other: '${n} 天没有汇报',
	);
	@override String get noMissing => '一天都没落下，太棒了！';
	@override String perDay({required Object value}) => '每个填写日平均 ${value}';
	@override String days({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
		other: '${n} 天',
	);
	@override String get notFilled => '尚未填写';
	@override String barsCaption({required Object max}) => '按天 · 最高：${max}';
	@override String barsCaptionMonthly({required Object max}) => '按月 · 最高：${max}';
	@override String get empty => '这段时间没有汇报。';
	@override String goalDays({required num n, required Object total}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
		other: '${total} 天中有 ${n} 天达成目标',
	);
	@override String get share => '分享这份总结';
	@override String get goals => '目标';
	@override String get goalsAverage => '目标平均完成度';
	@override String get goalsHint => '每一天都计算在内，空白的也算。今天填写后才计入。';
	@override String get evolution => '目标的进展';
	@override String get evolutionHint => '最近 12 周，一周接一周。';
	@override String get premiumYear => '年度视图和目标进展随 Premium 提供。';
}

// Path: reports.standardItems
class _Translations$reports$standardItems$zh extends Translations$reports$standardItems$fr {
	_Translations$reports$standardItems$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get lb => '读经';
	@override String get ps => '个人祷告';
	@override String get rdqad => '默想';
	@override String get pg => '小组祷告';
	@override String get llc => '阅读属灵书籍';
	@override String get jc => '完全禁食';
	@override String get jp => '部分禁食';
	@override String get dimes => '十一奉献';
	@override String get off => '奉献';
}

// Path: reports.units
class _Translations$reports$units$zh extends Translations$reports$units$fr {
	_Translations$reports$units$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override late final _Translations$reports$units$chapters$zh chapters = _Translations$reports$units$chapters$zh._(_root);
	@override late final _Translations$reports$units$times$zh times = _Translations$reports$units$times$zh._(_root);
	@override late final _Translations$reports$units$pages$zh pages = _Translations$reports$units$pages$zh._(_root);
	@override late final _Translations$reports$units$percent$zh percent = _Translations$reports$units$percent$zh._(_root);
}

// Path: reports.timer
class _Translations$reports$timer$zh extends Translations$reports$timer$fr {
	_Translations$reports$timer$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get start => '开始计时';
	@override String get running => '正在计时';
	@override String get startEnd => '开始 – 结束';
	@override String get from => '开始时间';
	@override String get to => '结束时间';
	@override String span({required Object from, required Object to}) => '从 ${from} 到 ${to}';
	@override String get pause => '暂停';
	@override String get resume => '继续';
	@override String get finish => '结束';
	@override String get discard => '取消计时';
	@override String get paused => '已暂停';
	@override String added({required Object item, required Object time}) => '已为“${item}”增加 ${time}';
	@override String get noItem => '计时已停止，但此项目已不在你的报告中。';
	@override String get replaceTitle => '替换计时？';
	@override String replaceText({required Object item}) => '“${item}”已在计时，它将停止且不计入。';
	@override String get replace => '替换';
}

// Path: export.doc
class _Translations$export$doc$zh extends Translations$export$doc$fr {
	_Translations$export$doc$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '每日汇报';
	@override String get regularity => '坚持度';
	@override String daysFilled({required num filled, required Object total}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(filled,
		other: '已填写 ${filled}/${total} 天',
	);
	@override String get totals => '期间合计';
	@override String get item => '项目';
	@override String get total => '合计';
	@override String get days => '天数';
	@override String get average => '每个填写日平均';
	@override String get goal => '达成目标';
	@override String get detail => '逐日明细';
	@override String get date => '日期';
	@override String get values => '填写内容';
	@override String get note => '笔记';
	@override String get noReport => '无汇报';
	@override String generated({required Object date}) => '${date}由 CMFI Connect 生成';
	@override String page({required Object n, required Object total}) => '第 ${n} 页 / 共 ${total} 页';
	@override String get filledColumn => '汇报';
	@override String get yes => '是';
	@override String get no => '否';
	@override String get sentFrom => '发送自 CMFI Connect';
}

// Path: items.measure
class _Translations$items$measure$zh extends Translations$items$measure$fr {
	_Translations$items$measure$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String quantity({required Object unit}) => '数量 · ${unit}';
	@override String get quantityNoUnit => '数量';
	@override String get duration => '时长';
	@override String both({required Object unit}) => '数量（${unit}）和时长';
	@override String get bothNoUnit => '数量和时长';
}

// Path: authorities.form
class _Translations$authorities$form$zh extends Translations$authorities$form$fr {
	_Translations$authorities$form$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '新的带领者';
	@override String get emailHint => 'name@example.com';
	@override String get isDiscipleMaker => '这是我的门训者';
	@override String get isDiscipleMakerHelp => '亲自带领你的那个人。你只能有一位。';
	@override String discipleMakerTaken({required Object name}) => '${name} 已经是你的门训者。若要指定其他人，请先将其从列表中移除。';
	@override String get submit => '添加';
	@override String added({required Object name}) => '${name} 现在是你的带领者了。';
	@override String get searchLabel => '对方的用户名';
	@override String get searchHint => '用户名';
	@override String get search => '搜索';
	@override String get searchHelp => '如果对方在使用 CMFI Connect，可以通过用户名找到他/她。对方会收到你的请求，接受后你就能看到其联系方式。';
	@override String notFound({required Object username}) => '没有用户名为 @${username} 的用户。';
	@override String get invite => '邀请对方加入 CMFI Connect';
	@override String get inviteText => '你好！我在用 CMFI Connect 记录我与神同行的生活，希望你能陪伴我。请安装这个应用并创建账号，然后把你的用户名发给我，我好添加你。';
	@override String inviteMine({required Object username}) => '我的用户名：@${username}';
	@override String get manual => '对方没有这个应用？手动填写联系方式';
	@override String get backToSearch => '改为按用户名搜索';
	@override String get request => '发送请求';
	@override String requested({required Object name}) => '已向 ${name} 发送请求。';
	@override String get alreadyAdded => '此人已经是你的带领者。';
	@override String get makerExists => '你已经有门训者了。';
	@override String get yourself => '这是你自己的用户名。';
	@override String sharingHelp({required Object name}) => '${name} 将能看到你的报告：已填写的项目、你的规律性和百分比，但永远看不到你的备注。你可以在他的卡片上停止分享。';
}

// Path: authorities.sharing
class _Translations$authorities$sharing$zh extends Translations$authorities$sharing$fr {
	_Translations$authorities$sharing$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '分享我的报告';
	@override String help({required Object name}) => '${name} 能看到你的报告：已填写的项目、你的规律性和百分比，但永远看不到你的备注。';
	@override String on({required Object name}) => '你的报告已与 ${name} 分享。';
	@override String off({required Object name}) => '${name} 不再能看到你的报告。';
}

// Path: members.deleteAccount
class _Translations$members$deleteAccount$zh extends Translations$members$deleteAccount$fr {
	_Translations$members$deleteAccount$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get button => '删除我的账户';
	@override String get title => '删除我的账户';
	@override String get intro => '此操作无法撤销。你的账户及其相关的一切都将被删除：';
	@override String get itemProfile => '你的个人资料、头像、用户名和密码';
	@override String get itemReports => '你所有的汇报、项目和目标';
	@override String get itemAuthorities => '你的属灵带领者以及收到的请求';
	@override String get itemEvents => '你的活动报名';
	@override String get itemPrayer => '你的祷告名单、祷告记录和恒切祷告事项';
	@override String get kept => '你作为管理员发布的活动、动态、照片和代祷事项会继续留给团契，但不再显示你的名字。';
	@override String get passwordHelp => '用于确认是你本人。';
	@override String get confirm => '永久删除';
	@override String get done => '你的账户已删除。愿神赐福给你！';
	@override String get wrongPassword => '密码错误。';
	@override String get lastSuperadmin => '你是唯一的超级管理员：删除账户前，请先把这个角色交给别人。';
}

// Path: hymns.tabs
class _Translations$hymns$tabs$zh extends Translations$hymns$tabs$fr {
	_Translations$hymns$tabs$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get all => '全部';
	@override String get favorites => '收藏';
	@override String get recent => '最近';
}

// Path: hymns.reader
class _Translations$hymns$reader$zh extends Translations$hymns$reader$fr {
	_Translations$hymns$reader$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get smaller => '缩小文字';
	@override String get larger => '放大文字';
	@override String get display => '显示';
	@override String get textSize => '文字大小';
	@override String get typeface => '字体';
	@override String get typefaceAuto => '自动';
	@override String get typefaceSans => '现代';
	@override String get typefaceSerif => '经典';
	@override String get typefaceAutoHelp => '文字较大时使用经典字体';
	@override String get background => '背景';
	@override String get themeAuto => '自动';
	@override String get themeLight => '浅色';
	@override String get themeSepia => '羊皮纸';
	@override String get themeDark => '深色';
	@override String get repeatChorus => '每节之后重复副歌';
	@override String get keepScreenOn => '保持屏幕常亮';
	@override String get addFavorite => '加入收藏';
	@override String get removeFavorite => '取消收藏';
	@override String get favoriteAdded => '已加入收藏';
	@override String get favoriteRemoved => '已取消收藏';
	@override String get more => '更多选项';
	@override String get copy => '复制歌词';
	@override String get copied => '歌词已复制';
	@override String get project => '投影模式';
	@override String get pinchHint => '双指缩放屏幕，即可放大或缩小文字。';
	@override String get notFound => '此诗歌已不在诗歌本中。';
	@override String get share => '分享歌词';
}

// Path: hymns.projection
class _Translations$hymns$projection$zh extends Translations$hymns$projection$fr {
	_Translations$hymns$projection$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get exit => '退出投影模式';
	@override String get previous => '上一节';
	@override String get next => '下一节';
	@override String position({required Object current, required Object total}) => '${current} / ${total}';
	@override String get hint => '点击右侧前进，点击左侧返回。';
}

// Path: hymns.pad
class _Translations$hymns$pad$zh extends Translations$hymns$pad$fr {
	_Translations$hymns$pad$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '跳转到诗歌';
	@override String get open => '打开';
	@override String get erase => '删除';
	@override String notFound({required Object number}) => '此诗歌本中没有第 ${number} 首';
	@override String get placeholder => '输入编号';
}

// Path: events.tabs
class _Translations$events$tabs$zh extends Translations$events$tabs$fr {
	_Translations$events$tabs$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get program => '日程';
	@override String get news => '动态';
	@override String get info => '信息';
	@override String get photos => '照片';
}

// Path: events.register
class _Translations$events$register$zh extends Translations$events$register$fr {
	_Translations$events$register$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get cta => '我要参加';
	@override String get title => '我要参加';
	@override String get people => '你们一共几人？';
	@override String get peopleHint => '包括你自己，以及你的家人或小组成员。';
	@override String get less => '减少一人';
	@override String get more => '增加一人';
	@override String get lodging => '我需要住宿';
	@override String get lodgingHint => '主办方会据此安排床位。';
	@override String get departure => '出发城市';
	@override String get departureHint => '例：杜阿拉';
	@override String get confirm => '确认报名';
	@override String get update => '更新';
	@override String get cancel => '取消报名';
	@override String get done => '报名成功！我们会在活动前一天提醒你。';
	@override String get updated => '你的报名信息已更新。';
	@override String get cancelled => '你的报名已取消。';
	@override String get edit => '修改';
	@override String get youAre => '你已报名';
	@override String get cancelTitle => '取消报名？';
	@override String get cancelText => '你的名额将让给其他人。';
	@override String get keep => '保留名额';
	@override String get lodgingShort => '住宿';
}

// Path: events.reminder
class _Translations$events$reminder$zh extends Translations$events$reminder$fr {
	_Translations$events$reminder$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get channel => '活动提醒';
	@override String tomorrow({required Object title}) => '明天：${title}';
	@override String soon({required Object title}) => '1 小时后：${title}';
}

// Path: events.admin
class _Translations$events$admin$zh extends Translations$events$admin$fr {
	_Translations$events$admin$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '管理活动';
	@override String get create => '创建活动';
	@override String get edit => '编辑活动';
	@override String get empty => '还没有活动。来创建第一个吧！';
	@override String get poster => '海报';
	@override String get posterAdd => '选择海报';
	@override String get posterChange => '更换海报';
	@override String get posterRemove => '移除海报';
	@override String get posterHint => '建议使用 4:5 竖版（1080 × 1350），JPEG 或 PNG 格式。';
	@override String get uploading => '正在上传图片…';
	@override String get general => '活动信息';
	@override String get titleField => '标题';
	@override String get titleHint => '例：2026 年度大会';
	@override String get titleRequired => '请为活动填写标题。';
	@override String get theme => '主题';
	@override String get themeHint => '例：顺着圣灵而行';
	@override String get verse => '主题经文';
	@override String get description => '简介';
	@override String get when => '日期';
	@override String get starts => '开始';
	@override String get ends => '结束';
	@override String get endsBeforeStart => '结束时间必须晚于开始时间。';
	@override String timeZone({required Object zone}) => '时间以活动地点为准（${zone}）。';
	@override String get where => '地点';
	@override String get venue => '场地';
	@override String get venueHint => '例：Mvolyé 会议中心';
	@override String get address => '地址';
	@override String get city => '城市';
	@override String get country => '国家';
	@override String get mapsUrl => 'Google 地图链接';
	@override String get registration => '报名';
	@override String get registrationOpen => '开放报名';
	@override String get deadline => '截止日期';
	@override String get noDeadline => '无截止日期';
	@override String get capacity => '名额';
	@override String get capacityHint => '留空表示不限名额';
	@override String get asksLodging => '询问谁需要住宿';
	@override String get asksDeparture => '询问出发城市';
	@override String get fees => '费用';
	@override String get feesHint => '例：免费入场。餐费：每天 2000 FCFA。';
	@override String get contact => '联系人';
	@override String get contactName => '联系人姓名';
	@override String get contactPhone => '联系人电话';
	@override String get visibility => '可见范围';
	@override String get statusDraft => '草稿';
	@override String get statusDraftHint => '仅管理员可见';
	@override String get statusPublished => '已发布';
	@override String get statusPublishedHint => '整个团契可见';
	@override String get statusCancelled => '已取消';
	@override String get statusCancelledHint => '显示为已取消，不可报名';
	@override String get saved => '活动已保存。';
	@override String get menu => '管理';
	@override String get program => '日程';
	@override String get registrants => '报名者';
	@override String get post => '发布动态';
	@override String get photos => '添加照片';
	@override String get nextEdition => '筹备下一届';
	@override String get delete => '删除活动';
	@override String get deleteTitle => '删除此活动？';
	@override String get deleteText => '报名信息、动态和照片也将一并删除。';
	@override String get deleteConfirm => '删除';
	@override String get deleted => '活动已删除。';
	@override String get nextEditionTitle => '筹备下一届？';
	@override String get nextEditionText => '将创建一份日期顺延一年的草稿，沿用相同的地点和日程。发布前你可以调整所有内容。';
	@override String get nextEditionConfirm => '筹备';
	@override String get nextEditionDone => '下一届已创建为草稿。';
	@override String get programEmpty => '添加活动的各个环节：迎接、崇拜、教导、守夜祷告……';
	@override String get addSession => '添加环节';
	@override String get editSession => '编辑此环节';
	@override String get sessionTitle => '标题';
	@override String get sessionTitleHint => '例：开幕崇拜';
	@override String get speaker => '讲员';
	@override String get place => '会场';
	@override String get day => '日期';
	@override String get from => '从';
	@override String get to => '到';
	@override String get hymns => '诗歌';
	@override String get hymnsHint => '编号，例：12, 45';
	@override String get removeSession => '移除';
	@override String get saveProgram => '保存日程';
	@override String get programSaved => '日程已保存。';
	@override String get registrantsEmpty => '还没有人报名。';
	@override String get totalRegistrations => '报名数';
	@override String get totalPeople => '人数';
	@override String get totalLodging => '需住宿';
	@override String get byCity => '按出发城市';
	@override String get list => '名单';
	@override String get exportCsv => '导出名单（CSV）';
	@override String get csvHeader => '姓名,用户名,电话,教会,聚会点,人数,住宿,出发城市,报名日期';
	@override String get yes => '是';
	@override String get no => '否';
	@override String get postBody => '内容';
	@override String get postBodyHint => '例：报名已开始！';
	@override String get postImage => '添加图片';
	@override String get postPinned => '置顶';
	@override String get postSend => '发布';
	@override String get postDone => '动态已发布。';
	@override String get postDelete => '删除此动态';
	@override String get postDeleted => '动态已删除。';
	@override String photosAdded({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
		other: '已添加 ${n} 张照片。',
	);
	@override String photosSending({required Object done, required Object total}) => '正在上传照片（${done}/${total}）…';
	@override String get photoDelete => '删除此照片';
	@override String get photoDeleted => '照片已删除。';
	@override String get confirmDelete => '删除';
}

// Path: ministry.goals
class _Translations$ministry$goals$zh extends Translations$ministry$goals$fr {
	_Translations$ministry$goals$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override late final _Translations$ministry$goals$crusade$zh crusade = _Translations$ministry$goals$crusade$zh._(_root);
	@override late final _Translations$ministry$goals$disciples$zh disciples = _Translations$ministry$goals$disciples$zh._(_root);
	@override late final _Translations$ministry$goals$revival$zh revival = _Translations$ministry$goals$revival$zh._(_root);
}

// Path: ministry.lives
class _Translations$ministry$lives$zh extends Translations$ministry$lives$fr {
	_Translations$ministry$lives$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override late final _Translations$ministry$lives$founder$zh founder = _Translations$ministry$lives$founder$zh._(_root);
	@override late final _Translations$ministry$lives$leader$zh leader = _Translations$ministry$lives$leader$zh._(_root);
}

// Path: prayer.hero
class _Translations$prayer$hero$zh extends Translations$prayer$hero$fr {
	_Translations$prayer$hero$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String now({required Object retreat}) => '${retreat} · 现在';
	@override String get title => '15 分钟\n与主同在';
	@override Map<String, String> get preview => {
		'morning': '献上感恩，将你的一天、你的工作、你的家人奉献给主……',
		'noon': '你的聚会点、你的领袖、你名单上的 5 个人、列国……',
		'evening': '你的祷告生活、你的事工、你的同工……',
		'night': '病人、福音传遍列国、夜间的保护……',
	};
	@override String get meta => '15 个要点 · 每个 1 分钟';
	@override String get start => '开始';
	@override String get allDone => '今天的 4 次祷告都完成了。愿神应允！';
	@override String doneNow({required Object retreat, required Object next}) => '${retreat}已完成。下一次：${next}';
}

// Path: prayer.today
class _Translations$prayer$today$zh extends Translations$prayer$today$fr {
	_Translations$prayer$today$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get toPray => '待祷告';
	@override String week({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
		zero: '本周还没有完成祷告',
		other: '本周完成了 ${n} 次祷告',
	);
}

// Path: prayer.routine
class _Translations$prayer$routine$zh extends Translations$prayer$routine$fr {
	_Translations$prayer$routine$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '你今天的祷告安排';
	@override String count({required Object done}) => '${done} / 4';
	@override String days({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
		other: '7 天中有 ${n} 天',
	);
	@override String week({required Object time}) => '本周 ${time}';
	@override String get done => '已完成 · 15 分钟';
	@override String get now => '现在 · 15 分钟';
	@override String get next => '下一个 · 15 分钟';
	@override String reminder({required Object time}) => '${time} 提醒';
	@override Map<String, String> get later => {
		'morning': '早上 · 15 分钟',
		'noon': '中午 · 15 分钟',
		'evening': '傍晚 · 15 分钟',
		'night': '夜里 · 15 分钟',
	};
}

// Path: prayer.reminders
class _Translations$prayer$reminders$zh extends Translations$prayer$reminders$fr {
	_Translations$prayer$reminders$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '祷告提醒';
	@override String get intro => '在每次祷告的时间提醒你，仅在尚未完成时提醒。';
	@override String get off => '已关闭';
	@override String get channel => '15 分钟祷告';
	@override String get body => '与主同在 15 分钟。';
}

// Path: prayer.retreat
class _Translations$prayer$retreat$zh extends Translations$prayer$retreat$fr {
	_Translations$prayer$retreat$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '15 分钟祷告';
	@override Map<String, String> get hours => {
		'morning': '起床时',
		'noon': '中午 12 点到下午 2 点',
		'evening': '下午晚些时候',
		'night': '睡前',
	};
	@override String reminderAt({required Object time}) => '${time} 提醒';
	@override String get intro => '15 个要点，每个一分钟。轻柔的提示音会带你进入下一个要点。';
	@override String get done => '今天已完成';
	@override String get start => '开始 · 15 分钟';
	@override String get selfPaced => '按自己的节奏阅读，不计时';
	@override late final _Translations$prayer$retreat$hints$zh hints = _Translations$prayer$retreat$hints$zh._(_root);
}

// Path: prayer.session
class _Translations$prayer$session$zh extends Translations$prayer$session$fr {
	_Translations$prayer$session$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String point({required Object n}) => '第 ${n} 点，共 15 点';
	@override String get remaining => '剩余';
	@override String get paused => '已暂停';
	@override String inYourList({required Object list}) => '你的名单 · ${list}';
	@override String get tomorrow => '明天为接下来的人祷告。';
	@override String get footer => '屏幕常亮 · 每分钟一声轻柔提示音';
	@override String get previous => '上一个要点';
	@override String get next => '下一个要点';
	@override String get pause => '暂停';
	@override String get resume => '继续';
	@override String get soundOn => '声音已开启';
	@override String get soundOff => '已静音';
	@override String get finish => '完成祷告';
	@override String get quitTitle => '要停止这次祷告吗？';
	@override String get quitText => '这次祷告不会计入你今天的汇报。';
	@override String get quit => '停止';
	@override String get keepPraying => '继续祷告';
}

// Path: prayer.done
class _Translations$prayer$done$zh extends Translations$prayer$done$fr {
	_Translations$prayer$done$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String title({required Object retreat}) => '${retreat}已完成';
	@override String get text => '与主同在 15 分钟。\n他听见了你的每一个祷告。';
	@override String get report => '已添加到你的汇报';
	@override String reportDetail({required Object added, required Object total}) => '个人祷告：+${added} 分钟 · 今天共 ${total} 分钟';
	@override String get undo => '撤销';
	@override String get undone => '已从今天的汇报中移除这次祷告。';
	@override String get today => '今天';
	@override String count({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
		other: '${n}/4 次祷告',
	);
	@override String get verse => '“要不住地祷告。”';
	@override String get reference => '帖撒罗尼迦前书 5:17';
	@override String get finish => '完成';
	@override String get hymn => '唱一首诗歌';
}

// Path: prayer.topics
class _Translations$prayer$topics$zh extends Translations$prayer$topics$fr {
	_Translations$prayer$topics$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '团契代祷事项';
	@override String get all => '查看全部';
	@override String get empty => '目前没有代祷事项。带领者会在这里发布新的事项。';
	@override Map<String, String> get categories => {
		'church': '教会',
		'nations': '列国',
		'sick': '病人',
		'event': '活动',
		'fasting': '禁食',
		'other': '代祷',
	};
	@override String until({required Object date}) => '至 ${date}';
	@override String get archive => '往期事项';
	@override String get archiveEmpty => '没有往期事项。';
	@override String get current => '当前';
	@override String documentSize({required Object kb}) => '${kb} KB';
	@override String get download => '下载 PDF';
	@override String get noDocument => '没有 PDF';
	@override String get openDocument => '打开 PDF';
}

// Path: prayer.lists
class _Translations$prayer$lists$zh extends Translations$prayer$lists$fr {
	_Translations$prayer$lists$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '我的祷告名单';
	@override String get private => '仅你可见';
	@override Map<String, String> get names => {
		'unbelievers': '尚未信主',
		'believers': '信徒',
		'backsliders': '退后的信徒',
		'coworkers': '同工',
	};
	@override Map<String, String> get uses => {
		'unbelievers': '中午祷告每天轮流为这份名单上的 10 个人（5 + 5）祷告。',
		'believers': '中午祷告每天轮流为这份名单上的 5 个人祷告。',
		'backsliders': '中午祷告每天轮流为这份名单上的 5 个人祷告。',
		'coworkers': '傍晚祷告每天轮流为你的 10 位同工（5 + 5）祷告。',
	};
	@override String get privateNote => '只有你能看到。';
	@override String count({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
		zero: '暂无',
		other: '${n} 人',
	);
	@override String get empty => '暂时还没有人。添加你为之祷告的人吧。';
	@override String get add => '添加一个人';
	@override String get prayedToday => '今天';
	@override String get next => '即将轮到';
	@override Map<String, String> get answeredTitle => {
		'unbelievers': '已信主',
		'believers': '蒙应允的祷告',
		'backsliders': '已回到主面前',
		'coworkers': '蒙应允的祷告',
	};
	@override late final _Translations$prayer$lists$answeredOn$zh answeredOn = _Translations$prayer$lists$answeredOn$zh._(_root);
	@override Map<String, String> get markAnswered => {
		'unbelievers': '已信主！',
		'believers': '祷告蒙应允',
		'backsliders': '已回到主面前！',
		'coworkers': '祷告蒙应允',
	};
	@override String get answeredToast => '荣耀归给神！';
	@override String get putBack => '放回名单';
	@override String answeredBanner({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
		other: '本月有 ${n} 个祷告蒙应允',
	);
	@override String lastAnswered({required Object name, required Object what}) => '${name}：${what}';
	@override late final _Translations$prayer$lists$sheet$zh sheet = _Translations$prayer$lists$sheet$zh._(_root);
	@override String get addShort => '添加';
}

// Path: prayer.importunity
class _Translations$prayer$importunity$zh extends Translations$prayer$importunity$fr {
	_Translations$prayer$importunity$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '恒切祷告事项';
	@override String get newTopic => '新事项';
	@override String get intro => '一个向主恒切祈求、不灰心，直到蒙应允的事项。设定宣告的次数，并邀请弟兄姊妹与你一起祷告。';
	@override String invitedBy({required Object name}) => '${name} 邀请你一起祷告';
	@override String get join => '我和你们一起祷告';
	@override String get decline => '暂不';
	@override String get joined => '你已加入这个事项的祷告。';
	@override String progress({required Object total, required Object goal}) => '${total}/${goal}';
	@override String total({required num n, required Object count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
		other: '${count} 次宣告',
	);
	@override String get reached => '已达成目标！';
	@override String get closed => '已结束';
	@override String participants({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
		other: '${n} 人在祷告',
	);
	@override String mine({required Object n}) => '你：${n}';
	@override String get tapHint => '每宣告一次，就点一下';
	@override String get addMany => '添加次数';
	@override String get addManyTitle => '宣告了多少次？';
	@override String get addManyLabel => '宣告次数';
	@override String get add => '添加';
	@override String pending({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
		other: '${n} 次待发送',
	);
	@override String get invite => '邀请';
	@override String get members => '一起祷告的人';
	@override String waiting({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
		other: '${n} 个邀请待回复',
	);
	@override String get edit => '编辑';
	@override String get close => '结束事项';
	@override String get reopen => '重新开启事项';
	@override String get delete => '删除事项';
	@override String get deleteTitle => '删除这个事项？';
	@override String get deleteText => '所有与你一起祷告的人都将看不到它。';
	@override String get leave => '退出这个事项';
	@override String get leaveTitle => '退出这个事项？';
	@override String get leaveText => '你的宣告次数仍会计入总数。';
	@override late final _Translations$prayer$importunity$form$zh form = _Translations$prayer$importunity$form$zh._(_root);
	@override late final _Translations$prayer$importunity$inviteSheet$zh inviteSheet = _Translations$prayer$importunity$inviteSheet$zh._(_root);
	@override String get eyebrow => '恒切祷告事项';
	@override String get proclaim => '宣告';
	@override String get timer => '为祷告计时';
	@override String get timeLabel => '为此事项祷告的时间';
	@override String mineTime({required Object n, required Object time}) => '你：${n} · 祷告 ${time}';
	@override String get timerNote => '时间会计入报告中的“个人祷告”。';
}

// Path: streak.lines
class _Translations$streak$lines$zh extends Translations$streak$lines$fr {
	_Translations$streak$lines$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get week => '整整一周，天天与主同在。真棒，继续加油！';
	@override String get month => '一个月的忠心！你每天所撒的种必结出果子。';
	@override String get hundred => '与神同在一百天！你的坚持是美好的见证。';
	@override String get year => '与神同在整整一年！为你的忠心将荣耀归给祂。';
}

// Path: blocking.reasons
class _Translations$blocking$reasons$zh extends Translations$blocking$reasons$fr {
	_Translations$blocking$reasons$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get spam => '垃圾信息';
	@override String get offensive => '令人震惊或冒犯的内容';
	@override String get other => '其他';
}

// Path: bible.colors
class _Translations$bible$colors$zh extends Translations$bible$colors$fr {
	_Translations$bible$colors$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get yellow => '黄色';
	@override String get green => '绿色';
	@override String get blue => '蓝色';
	@override String get pink => '粉色';
}

// Path: seekFirst.shield
class _Translations$seekFirst$shield$zh extends Translations$seekFirst$shield$fr {
	_Translations$seekFirst$shield$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '先求神';
	@override String subtitle({required Object app}) => '在完成今天的汇报之前，${app} 保持关闭。';
	@override String get thisApp => '此应用';
	@override String get fill => '填写我的汇报';
	@override String pause({required Object n}) => '暂停 5 分钟（${n}/3）';
	@override String get notificationTitle => '先求神';
	@override String get notificationBody => '轻点此处填写你的汇报。';
	@override String get serviceBody => '你的应用每天都会关闭，直到你填写报告。';
}

// Path: souls.csv
class _Translations$souls$csv$zh extends Translations$souls$csv$fr {
	_Translations$souls$csv$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get name => '姓名';
	@override String get phone => '电话';
	@override String get place => '地点';
	@override String get metOn => '认识日期';
	@override String get stage => '阶段';
	@override String get next => '下次联系';
	@override String get notes => '备注';
}

// Path: reports.units.chapters
class _Translations$reports$units$chapters$zh extends Translations$reports$units$chapters$fr {
	_Translations$reports$units$chapters$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get name => '章数';
	@override String get label => '章数';
	@override String get symbol => '章';
	@override String count({required num n, required Object value}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
		other: '${value} 章',
	);
}

// Path: reports.units.times
class _Translations$reports$units$times$zh extends Translations$reports$units$times$fr {
	_Translations$reports$units$times$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get name => '次数';
	@override String get label => '次数';
	@override String get symbol => '次';
	@override String count({required num n, required Object value}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
		other: '${value} 次',
	);
}

// Path: reports.units.pages
class _Translations$reports$units$pages$zh extends Translations$reports$units$pages$fr {
	_Translations$reports$units$pages$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get name => '页数';
	@override String get label => '页数';
	@override String get symbol => '页';
	@override String count({required num n, required Object value}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
		other: '${value} 页',
	);
}

// Path: reports.units.percent
class _Translations$reports$units$percent$zh extends Translations$reports$units$percent$fr {
	_Translations$reports$units$percent$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get name => '百分比';
	@override String get label => '百分比';
	@override String get symbol => '%';
	@override String count({required Object value}) => '${value}%';
}

// Path: ministry.goals.crusade
class _Translations$ministry$goals$crusade$zh extends Translations$ministry$goals$crusade$fr {
	_Translations$ministry$goals$crusade$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '向凡受造的传福音运动';
	@override String get text => '把福音传给我们这一代将要活着的每一个人，使福音借着圣灵的大能传扬，临到100亿人；运用一切传播途径（我们的书籍、单张、杂志、CD、DVD、广播、电视和互联网），以最迫切的方式进行。';
	@override String get reached => '人听闻福音';
}

// Path: ministry.goals.disciples
class _Translations$ministry$goals$disciples$zh extends Translations$ministry$goals$disciples$fr {
	_Translations$ministry$goals$disciples$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '门徒培训';
	@override String get text => '到2065年，带领250个国家的10亿人认识耶稣基督为主和救主，使他们成为门徒，在凡事上顺服祂，并组织他们在2500万个家庭教会中聚会。';
	@override String get people => '门徒';
	@override String get nations => '个国家';
	@override String get churches => '家庭教会';
	@override String by({required Object year}) => '${year}年前';
}

// Path: ministry.goals.revival
class _Translations$ministry$goals$revival$zh extends Translations$ministry$goals$revival$fr {
	_Translations$ministry$goals$revival$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '催促全球复兴';
	@override String get text => '借着禁食和代祷与神同工，为那将要裂开天、震动地、在我们这一代荣耀基督的全球大复兴祷告，以催促我们的主耶稣基督从天降临，迎接祂已预备好的新妇。';
	@override String get fasting => '禁食';
	@override String get intercession => '代祷';
	@override String get pray => '现在祷告';
}

// Path: ministry.lives.founder
class _Translations$ministry$lives$founder$zh extends Translations$ministry$lives$founder$fr {
	_Translations$ministry$lives$founder$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get name => 'Zacharias Tanee Fomum 教授';
	@override String get line => '1945 – 2009 · CMFI 创始人';
	@override List<String> get facts => [
		'创立 CMFI',
		'本著作',
		'个走访的国家',
	];
	@override List<String> get dates => [
		'6月20日生于喀麦隆一个长老会家庭。',
		'6月13日通过一份福音单张把生命交给耶稣基督。',
		'10月1日在塞拉利昂把自己完全献给主。',
		'经过七天祷告，于10月24日被圣灵充满。',
		'5月12日在雅温得创立 CMFI。',
		'获得杜伦大学理学博士学位。',
		'3月14日被主接去。',
	];
	@override List<String> get story => [
		'他于1945年6月20日出生在喀麦隆，家族是来自西北部巴蒂博的长老会信徒。还在上学时，他于1956年6月13日读了一份名为《有人为你而死》的福音单张，把生命交给了耶稣基督。',
		'在塞拉利昂富拉湾学院求学期间，他于1966年10月1日毫无保留地把自己献给主和主的事工。1970年10月24日，在七天的祷告禁食之后，他被圣灵充满。从那时起，祷告成了他生命的中心。',
		'他在乌干达马凯雷雷大学获得有机化学博士学位，之后在雅温得大学任教并成为教授。他指导了约一百篇博士和硕士论文；2005年，英国杜伦大学因他的全部学术成就授予他理学博士学位。',
		'1975年5月12日，他在雅温得创立了国际基督教宣教团契（CMFI）：一个赢得灵魂、使人作门徒、建立教会、差派宣教士的运动。他在喀麦隆进行了700多次宣教旅程，又在六大洲70多个国家进行了500多次旅程。',
		'他每天花很长时间独自与神相处，带领了许多祷告大会、祷告围城和祷告行走，并经常禁食。他写了150多本关于祷告、禁食、圣洁、门徒训练和宣教的书，以多种语言被阅读。',
		'他与妻子 Prisca Zei Fomum（一位在儿童中服事的同工）育有七个孩子，都投身于福音工作。他们一同过着简朴的生活，把收入的绝大部分奉献给福音。',
		'2009年3月14日，他被主接去，3月21日安葬于雅温得。他所创立的事工在万国中继续前进。',
	];
}

// Path: ministry.lives.leader
class _Translations$ministry$lives$leader$zh extends Translations$ministry$lives$leader$fr {
	_Translations$ministry$lives$leader$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get name => 'Theodore Andoseh';
	@override String get line => '自2009年起担任 CMFI 领袖';
	@override List<String> get facts => [
		'建立的教会',
		'在尼日利亚的年数',
		'开始领导 CMFI',
	];
	@override List<String> get dates => [
		'在 Fomum 教授的讲道中把生命交给耶稣基督。',
		'在雅温得被按立为主教。',
		'与妻子 Adela 一同作为宣教士前往尼日利亚。',
		'开始领导 CMFI。',
		'在第三届世界大会上向来自93个国家的成员传讲信息。',
	];
	@override List<String> get story => [
		'1978年，Theodore Andoseh 在聆听 Zacharias Tanee Fomum 教授讲道时把生命交给了耶稣基督。Fomum 教授成了他属灵的父亲，并培养他作门徒。',
		'他起初在 Fomum 教授身边服事：先是在雅温得大学担任实验室助理，后来成为他的私人助理和私人秘书。在那些年里，他出版了第一份复兴福音单张《神对愿意聆听的人说话》，并在雅温得发起了第一条祷告链。',
		'作为本国宣教士，他在喀麦隆建立了五十多间教会。1989年，他在雅温得被按立为主教。',
		'1994年，他与妻子 Adela 一同作为宣教士前往尼日利亚，在那里服事了十四年。',
		'自2009年 Fomum 教授被主接去之后，他在万国中带领 CMFI。2019年12月，他在贝尔图阿附近的库梅，向来自93个国家的成员传讲第三届世界大会的信息。他也写了多本关于事奉神和建造教会的书。',
	];
}

// Path: prayer.retreat.hints
class _Translations$prayer$retreat$hints$zh extends Translations$prayer$retreat$hints$fr {
	_Translations$prayer$retreat$hints$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String assembly({required Object name}) => '你的聚会点：${name}';
	@override String get assemblyMissing => '在个人资料中添加你的聚会点';
	@override String authorities({required Object names}) => '你的带领者：${names}';
	@override String get authoritiesMissing => '在「更多」中添加你的属灵带领者';
	@override String list({required Object list}) => '我的名单 · ${list}';
	@override String listEmpty({required Object list}) => '你的「${list}」名单是空的：添加一些名字吧';
	@override String nation({required Object name}) => '今天：${name}';
	@override String myCountry({required Object name}) => '你的国家：${name}';
	@override String get hymn => '打开诗歌';
}

// Path: prayer.lists.answeredOn
class _Translations$prayer$lists$answeredOn$zh extends Translations$prayer$lists$answeredOn$fr {
	_Translations$prayer$lists$answeredOn$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String unbelievers({required Object date}) => '于 ${date} 信主';
	@override String believers({required Object date}) => '于 ${date} 蒙应允';
	@override String backsliders({required Object date}) => '于 ${date} 回到主面前';
	@override String coworkers({required Object date}) => '于 ${date} 蒙应允';
}

// Path: prayer.lists.sheet
class _Translations$prayer$lists$sheet$zh extends Translations$prayer$lists$sheet$fr {
	_Translations$prayer$lists$sheet$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get addTitle => '添加一个人';
	@override String get editTitle => '编辑';
	@override String get name => '姓名';
	@override String get namePlaceholder => '李明';
	@override String get note => '备注';
	@override String get notePlaceholder => '同事、邻居、表妹……';
	@override String get list => '名单';
	@override String get save => '保存';
	@override String get remove => '从名单中移除';
	@override String removeTitle({required Object name}) => '移除 ${name}？';
	@override String get removeText => '你的每日祷告中将不再为这个人祷告。';
}

// Path: prayer.importunity.form
class _Translations$prayer$importunity$form$zh extends Translations$prayer$importunity$form$fr {
	_Translations$prayer$importunity$form$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get newTitle => '新的恒切祷告事项';
	@override String get editTitle => '编辑事项';
	@override String get subject => '事项';
	@override String get subjectPlaceholder => '主啊，求你拯救李明';
	@override String get description => '详情';
	@override String get descriptionPlaceholder => '为谁、为什么……';
	@override String get goal => '目标';
	@override String get goalHint => '大家一起要达到的宣告次数。留空则只计数、不设目标。';
	@override String get goalPlaceholder => '10000';
	@override String get create => '创建';
	@override String get save => '保存';
}

// Path: prayer.importunity.inviteSheet
class _Translations$prayer$importunity$inviteSheet$zh extends Translations$prayer$importunity$inviteSheet$fr {
	_Translations$prayer$importunity$inviteSheet$zh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '邀请一起祷告';
	@override String get family => '我的属灵家人';
	@override String familyText({required num n, required Object name}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
		other: '${name}及其门徒：${n} 人',
	);
	@override String get familyMissing => '在「我的属灵带领者」中关联你的门训者，就能邀请你的属灵家人。';
	@override String get byUsername => '按用户名';
	@override String get usernameLabel => '用户名';
	@override String get addUsername => '添加';
	@override String get send => '发送邀请';
	@override String sent({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n,
		zero: '他们之前已被邀请过了。',
		other: '已发送 ${n} 个邀请',
	);
}

/// The flat map containing all translations for locale <zh>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsZh {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'app.name' => 'CMFI Connect',
			'app.tagline' => '一起成长，每一天。',
			'app.languageName' => '中文',
			'common.retry' => '重试',
			'common.cancel' => '取消',
			'common.save' => '保存',
			'common.close' => '关闭',
			'common.back' => '返回',
			'common.soon' => '即将推出',
			'common.optional' => '（选填）',
			'common.and' => '和',
			'common.loading' => '加载中…',
			'common.done' => '完成',
			'common.rangeStart' => '开始',
			'common.rangeEnd' => '结束',
			'errors.network' => '没有网络连接。请检查网络后重试。',
			'errors.unauthorized' => '登录已过期，请重新登录。',
			'errors.invalidCredentials' => '手机号或密码错误。',
			'errors.badRequest' => '部分信息无效。',
			'errors.conflict' => '该内容已存在。',
			'errors.notFound' => '找不到该内容。',
			'errors.server' => '服务器出了点问题，请稍后再试。',
			'errors.unknown' => '出错了，请重试。',
			'errors.forbidden' => '你没有权限进行此操作。',
			'errors.eventFull' => '此活动已没有名额。',
			'errors.registrationClosed' => '此活动的报名已截止。',
			'errors.mediaTooLarge' => '这张图片太大了（最大 8 MB）。',
			'errors.mediaUnsupported' => '请选择 JPEG 或 PNG 格式的图片。',
			'errors.notParticipant' => '请先加入这个祷告事项，才能记录你的宣告。',
			'errors.importunityClosed' => '这个事项已结束，不再记录宣告。',
			'errors.usernameNotFound' => '没有人使用这个用户名。请检查拼写。',
			'errors.ownerCannotLeave' => '这个事项是你创建的：请删除它，而不是退出。',
			'errors.tooManyPeople' => '你的名单已满（最多 500 人）。',
			'errors.avatarInvalid' => '这张照片无法使用，请选择另一张。',
			'errors.reportsNotShared' => '该成员不再分享其报告。',
			'validation.required' => '此项为必填',
			'validation.passwordTooShort' => '至少 6 个字符',
			'validation.invalidPhone' => '手机号无效',
			'validation.invalidEmail' => '邮箱地址无效',
			'validation.invalidCode' => '只能使用字母和数字，不含空格',
			'welcome.seek.before' => '每天先寻求',
			'welcome.seek.marked' => '神',
			'welcome.seek.after' => '',
			'welcome.seek.text' => '几秒钟就能记下你的读经、祷告、禁食……每周都能看到自己的进步。',
			'welcome.worship.before' => '随时随地，歌唱与',
			'welcome.worship.marked' => '祷告',
			'welcome.worship.after' => '',
			'welcome.worship.text' => '查看团契的诗歌，每天与弟兄姊妹一起为代祷事项祷告。',
			'welcome.community.before' => '与你的',
			'welcome.community.marked' => '团契',
			'welcome.community.after' => '保持联系',
			'welcome.community.text' => '你所在聚会点的活动和通知都在这里，一条也不会错过。',
			'welcome.step' => ({required Object current, required Object total}) => '第 ${current} 页，共 ${total} 页',
			'welcome.streak' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n, other: '与神同行 ${n} 天', ), 
			'welcome.sample.bibleReading' => '读经',
			'welcome.sample.chapters' => '10 章',
			'welcome.sample.prayerAlone' => '个人祷告',
			'welcome.sample.hymn' => '诗歌',
			'welcome.sample.hymnNumber' => '第 12 首',
			'welcome.sample.prayerOfTheDay' => '今日代祷事项',
			'welcome.sample.prayerTopic' => '为青年们的考试祷告',
			'welcome.sample.praying' => '12 人正在祷告',
			'welcome.sample.iPray' => '我来祷告',
			'welcome.sample.retreat' => '青年退修会',
			'welcome.sample.announcement' => '通知',
			'welcome.sample.announcementText' => '主日崇拜早上 8:30 开始。',
			'welcome.createAccount' => '创建账号',
			'welcome.haveAccount' => '我已有账号',
			'auth.phone' => '手机号',
			'auth.dialCode' => ({required Object code}) => '国际区号：${code}',
			'auth.password' => '密码',
			'auth.showPassword' => '显示密码',
			'auth.hidePassword' => '隐藏密码',
			'auth.login.title' => '欢迎回来',
			'auth.login.subtitle' => '登录，继续你与神同行的路，与教会肢体相连。',
			'auth.login.welcomeBack' => '很高兴见到你！',
			'auth.login.submit' => '登录',
			'auth.login.noAccount' => '还没有账号？',
			'auth.login.createAccount' => '创建账号',
			'auth.register.step' => ({required Object current, required Object total}) => '${current} / ${total}',
			'auth.register.title' => '创建你的账号',
			'auth.register.subtitle' => '你将使用手机号登录。',
			'auth.register.firstName' => '名',
			'auth.register.lastName' => '姓',
			'auth.register.passwordHelp' => '至少 6 个字符',
			'auth.register.email' => '邮箱',
			'auth.register.submit' => '继续',
			'auth.register.haveAccount' => '已有账号？',
			'auth.register.login' => '登录',
			'auth.register.alreadyUsed' => '该手机号或邮箱已注册，请直接登录。',
			'auth.register.emailHint' => 'you@example.com',
			'auth.church.title' => '你的教会',
			'auth.church.subtitle' => '这些信息能帮助你的带领者找到你。之后可以随时修改。',
			'auth.church.editTitle' => '我的资料',
			'auth.church.editSubtitle' => '更新你的姓名、教会和聚会点。',
			'auth.church.country' => '国家',
			'auth.church.countryHint' => '选择你的国家/地区',
			'auth.church.city' => '城市',
			'auth.church.cityHint' => '雅温得',
			'auth.church.church' => '教会',
			'auth.church.churchHint' => '你的教会名称',
			'auth.church.assembly' => '聚会点',
			'auth.church.assemblyHint' => '你的聚会点名称',
			'auth.church.info' => '搬家了或换了聚会点？随时可以在个人资料中更新。',
			'auth.church.submit' => '完成',
			'auth.church.skip' => '跳过此步',
			'auth.church.saved' => '资料已保存',
			'auth.forgot.link' => '忘记密码？',
			'auth.forgot.title' => '忘记密码',
			'auth.forgot.phoneText' => '输入你的号码：我们会通过短信发送验证码，用来设置新密码。',
			'auth.forgot.sendCode' => '获取验证码',
			'auth.forgot.codeTitle' => '输入验证码',
			'auth.forgot.codeText' => ({required Object phone}) => '我们已向 ${phone} 发送了 6 位验证码。',
			'auth.forgot.code' => '短信验证码',
			'auth.forgot.codeInvalid' => '验证码为 6 位数字',
			'auth.forgot.verify' => '验证',
			'auth.forgot.resend' => '重新发送验证码',
			'auth.forgot.resendIn' => ({required Object seconds}) => '${seconds} 秒后可重新发送',
			'auth.forgot.changeNumber' => '更换号码',
			'auth.forgot.passwordTitle' => '新密码',
			'auth.forgot.passwordText' => '为你的账号设置一个新密码。',
			'auth.forgot.submit' => '保存并登录',
			'auth.forgot.done' => '密码已更改，欢迎回来！',
			'auth.forgot.remembered' => '想起来了？',
			'auth.forgot.invalidCode' => '验证码不正确。',
			'auth.forgot.expired' => '验证码已过期，请重新获取。',
			'auth.forgot.tooManyRequests' => '尝试次数过多，请稍后再试。',
			'auth.forgot.unavailable' => '暂时无法重置密码。',
			'auth.forgot.noAccount' => '没有账号使用这个号码。',
			'auth.biometric.faceId' => '面容 ID',
			'auth.biometric.touchId' => '触控 ID',
			'auth.biometric.fingerprint' => '指纹',
			'auth.biometric.face' => '面部',
			'auth.biometric.signIn' => ({required Object method}) => '使用${method}登录',
			'auth.biometric.askTitle' => ({required Object method}) => '使用${method}登录？',
			'auth.biometric.askText' => '下次无需再输入密码：它保存在你手机的安全保险箱中。',
			'auth.biometric.enable' => '开启',
			'auth.biometric.later' => '以后再说',
			'auth.biometric.reason' => '登录 CMFI Connect',
			'auth.biometric.enableReason' => '开启 CMFI Connect 快速登录',
			'auth.biometric.changed' => ({required Object method}) => '你的密码已更改：请用密码登录，然后重新开启${method}。',
			'auth.biometric.settings' => ({required Object method}) => '使用${method}登录',
			'auth.biometric.settingsText' => '无需输入密码',
			'auth.biometric.passwordTitle' => '你的密码',
			'auth.biometric.passwordLabel' => '密码',
			'auth.biometric.confirm' => '确认',
			'auth.biometric.enabled' => ({required Object method}) => '已开启${method}登录',
			'countries.dialCodeTitle' => '国家/地区区号',
			'countries.title' => '你的国家/地区',
			'countries.search' => '搜索国家/地区或区号',
			'countries.none' => '没有匹配的国家/地区',
			'countries.change' => '更改国家/地区',
			'nav.home' => '首页',
			'nav.reports' => '汇报',
			'nav.hymns' => '诗歌',
			'nav.prayer' => '祷告',
			'nav.bible' => '圣经',
			'home.greeting' => ({required Object name}) => '你好，${name}',
			'home.greetingNoName' => '你好',
			'home.profile' => '我的资料',
			'home.progress' => ({required Object filled, required Object total}) => '${filled}/${total}',
			'home.progressLabel' => '项已填写',
			'home.goals' => '目标',
			'home.weekTitle' => '你的一周',
			'home.community' => 'CMFI 近况',
			'home.eventsTitle' => '活动',
			'home.hymnsTitle' => '诗歌',
			'home.hymnsOpen' => '打开诗歌本',
			'home.continueMyReport' => '继续填写汇报',
			'home.startMyReport' => '开始填写汇报',
			'home.items' => '项',
			'home.goalsTitle' => '目标',
			'home.retreatsTitle' => '灵修',
			'home.retreatsValue' => ({required Object n}) => '4 次中 ${n} 次',
			'home.streakTitle' => '连续',
			'home.resume' => '继续',
			'home.hymnNumber' => ({required Object number}) => '第 ${number} 首诗歌',
			'home.seeAll' => '查看全部',
			'home.retreatsDone' => '今天的 4 次灵修都已完成',
			'home.days' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n, other: '${n} 天', ), 
			'home.hideNumbers' => '隐藏我的数字',
			'home.showNumbers' => '显示我的数字',
			'home.numbersHidden' => '已隐藏',
			'reports.title' => '每日汇报',
			'reports.myItems' => '我的项目',
			'reports.tabs.today' => '今天',
			'reports.tabs.history' => '历史',
			'reports.tabs.summary' => '总结',
			'reports.pickDay' => '选择日期',
			'reports.filled' => ({required Object filled, required Object total}) => '已填写 ${filled}/${total} 项',
			'reports.statusSaved' => '已保存',
			'reports.statusModified' => '未保存',
			'reports.standard' => '标准项目',
			'reports.personal' => '我的项目',
			'reports.createItem' => '创建项目',
			'reports.add' => ({required Object label}) => '添加${label}',
			'reports.note' => '今日笔记',
			'reports.noteHint' => '一节经文、一件感恩的事……',
			'reports.save' => '保存当天汇报',
			'reports.saved' => '当天汇报已保存',
			'reports.measure.quantity' => ({required Object unit}) => '${unit}',
			'reports.measure.duration' => '时长',
			'reports.measure.both' => ({required Object unit}) => '${unit}和时长',
			'reports.measure.quantityNoUnit' => '数量',
			'reports.measure.bothNoUnit' => '数量和时长',
			'reports.times' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n, other: '${n} 次', ), 
			'reports.sheet.quantity' => '数量',
			'reports.sheet.duration' => '时长',
			'reports.sheet.minus1' => '− 1 分钟',
			'reports.sheet.plus1' => '+ 1 分钟',
			'reports.sheet.removeMinute' => '减少一分钟',
			'reports.sheet.addMinute' => '增加一分钟',
			'reports.sheet.holdToRepeat' => '长按可快速调整',
			'reports.sheet.decrease' => '减少',
			'reports.sheet.increase' => '增加',
			'reports.sheet.clear' => '清除',
			'reports.sheet.validate' => '确定',
			'reports.history.daysFilled' => ({required Object total, required Object filled}) => '${total} 天中已填写 ${filled} 天',
			'reports.history.legendFilled' => '已填写',
			'reports.history.legendMissing' => '无汇报',
			'reports.history.none' => '无汇报',
			'reports.history.fill' => '填写',
			'reports.history.inProgress' => '进行中',
			'reports.history.previousMonth' => '上个月',
			'reports.history.nextMonth' => '下个月',
			'reports.history.today' => '今天',
			'reports.summary.week' => '周',
			'reports.summary.month' => '月',
			'reports.summary.year' => '年',
			'reports.summary.range' => ({required Object from, required Object to}) => '${from} 至 ${to}',
			'reports.summary.regularity' => '坚持度',
			'reports.summary.daysFilled' => '天已填写',
			'reports.summary.missingDays' => ({required num n, required Object days}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n, other: '${n} 天没有汇报：${days}', ), 
			'reports.summary.missingCount' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n, other: '${n} 天没有汇报', ), 
			'reports.summary.noMissing' => '一天都没落下，太棒了！',
			'reports.summary.perDay' => ({required Object value}) => '每个填写日平均 ${value}',
			'reports.summary.days' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n, other: '${n} 天', ), 
			'reports.summary.notFilled' => '尚未填写',
			'reports.summary.barsCaption' => ({required Object max}) => '按天 · 最高：${max}',
			'reports.summary.barsCaptionMonthly' => ({required Object max}) => '按月 · 最高：${max}',
			'reports.summary.empty' => '这段时间没有汇报。',
			'reports.summary.goalDays' => ({required num n, required Object total}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n, other: '${total} 天中有 ${n} 天达成目标', ), 
			'reports.summary.share' => '分享这份总结',
			'reports.summary.goals' => '目标',
			'reports.summary.goalsAverage' => '目标平均完成度',
			'reports.summary.goalsHint' => '每一天都计算在内，空白的也算。今天填写后才计入。',
			'reports.summary.evolution' => '目标的进展',
			'reports.summary.evolutionHint' => '最近 12 周，一周接一周。',
			'reports.summary.premiumYear' => '年度视图和目标进展随 Premium 提供。',
			'reports.noItems' => '暂时没有需要填写的项目。',
			'reports.statusPending' => '尚未发送',
			'reports.savedOffline' => '没有网络：当天汇报已保存在手机上，联网后会尽快发送。',
			'reports.pendingBanner' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n, other: '${n} 天的汇报正在等待网络发送', ), 
			'reports.export' => '导出我的汇报',
			'reports.goal' => ({required Object value}) => '目标：${value}',
			'reports.goalReached' => '已达成目标',
			'reports.dayGoals' => '当天目标',
			'reports.goalsReached' => ({required Object reached, required Object total}) => '已达成：${reached}/${total}',
			'reports.standardItems.lb' => '读经',
			'reports.standardItems.ps' => '个人祷告',
			'reports.standardItems.rdqad' => '默想',
			'reports.standardItems.pg' => '小组祷告',
			'reports.standardItems.llc' => '阅读属灵书籍',
			'reports.standardItems.jc' => '完全禁食',
			'reports.standardItems.jp' => '部分禁食',
			'reports.standardItems.dimes' => '十一奉献',
			'reports.standardItems.off' => '奉献',
			'reports.units.chapters.name' => '章数',
			'reports.units.chapters.label' => '章数',
			'reports.units.chapters.symbol' => '章',
			'reports.units.chapters.count' => ({required num n, required Object value}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n, other: '${value} 章', ), 
			'reports.units.times.name' => '次数',
			'reports.units.times.label' => '次数',
			'reports.units.times.symbol' => '次',
			'reports.units.times.count' => ({required num n, required Object value}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n, other: '${value} 次', ), 
			'reports.units.pages.name' => '页数',
			'reports.units.pages.label' => '页数',
			'reports.units.pages.symbol' => '页',
			'reports.units.pages.count' => ({required num n, required Object value}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n, other: '${value} 页', ), 
			'reports.units.percent.name' => '百分比',
			'reports.units.percent.label' => '百分比',
			'reports.units.percent.symbol' => '%',
			'reports.units.percent.count' => ({required Object value}) => '${value}%',
			'reports.timer.start' => '开始计时',
			'reports.timer.running' => '正在计时',
			'reports.timer.startEnd' => '开始 – 结束',
			'reports.timer.from' => '开始时间',
			'reports.timer.to' => '结束时间',
			'reports.timer.span' => ({required Object from, required Object to}) => '从 ${from} 到 ${to}',
			'reports.timer.pause' => '暂停',
			'reports.timer.resume' => '继续',
			'reports.timer.finish' => '结束',
			'reports.timer.discard' => '取消计时',
			'reports.timer.paused' => '已暂停',
			'reports.timer.added' => ({required Object item, required Object time}) => '已为“${item}”增加 ${time}',
			'reports.timer.noItem' => '计时已停止，但此项目已不在你的报告中。',
			'reports.timer.replaceTitle' => '替换计时？',
			'reports.timer.replaceText' => ({required Object item}) => '“${item}”已在计时，它将停止且不计入。',
			'reports.timer.replace' => '替换',
			'reminder.title' => '你的今日汇报',
			'reminder.body' => '在今天结束前，花一分钟记下你的读经、祷告……',
			'reminder.channel' => '汇报提醒',
			'reminder.settings' => '晚间提醒',
			'reminder.off' => '已关闭',
			'reminder.switchLabel' => '提醒我填写当天汇报',
			'reminder.switchHint' => '仅在当天尚未填写时提醒。',
			'reminder.time' => '提醒时间',
			'reminder.offerTitle' => '每晚提醒你一次？',
			'reminder.offerText' => '如果当天还没填写，应用会在你选定的时间提醒你；已经填写就不会打扰你。',
			'reminder.offerAccept' => '开启提醒',
			'reminder.offerLater' => '以后再说',
			'reminder.enabled' => ({required Object time}) => '已设置在 ${time} 提醒',
			'reminder.denied' => 'CMFI Connect 的通知已被关闭。请在手机设置中允许通知。',
			'export.title' => '导出',
			'export.period' => '时间段',
			'export.thisWeek' => '本周',
			'export.lastWeek' => '上周',
			'export.thisMonth' => '本月',
			'export.lastMonth' => '上个月',
			'export.thisYear' => '今年',
			'export.custom' => '其他日期',
			'export.customPick' => '选择日期',
			'export.format' => '格式',
			'export.pdf' => 'PDF',
			'export.pdfHint' => '可发送或打印的文档',
			'export.csv' => '表格',
			'export.csvHint' => '适用于 Excel 或 Google 表格的 CSV 文件',
			'export.text' => '消息',
			'export.textHint' => '可粘贴到 WhatsApp 的摘要',
			'export.button' => '导出',
			'export.shareButton' => '分享',
			'export.preview' => ({required num filled, required Object total, required Object items}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(filled, other: '已填写 ${filled}/${total} 天 · ${items}', ), 
			'export.previewItems' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n, other: '${n} 个项目', ), 
			'export.empty' => '这段时间没有汇报。',
			'export.tooLong' => '最多选择 366 天。',
			'export.fileName' => '每日汇报',
			'export.subject' => ({required Object period}) => '我的每日汇报：${period}',
			'export.doc.title' => '每日汇报',
			'export.doc.regularity' => '坚持度',
			'export.doc.daysFilled' => ({required num filled, required Object total}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(filled, other: '已填写 ${filled}/${total} 天', ), 
			'export.doc.totals' => '期间合计',
			'export.doc.item' => '项目',
			'export.doc.total' => '合计',
			'export.doc.days' => '天数',
			'export.doc.average' => '每个填写日平均',
			'export.doc.goal' => '达成目标',
			'export.doc.detail' => '逐日明细',
			'export.doc.date' => '日期',
			'export.doc.values' => '填写内容',
			'export.doc.note' => '笔记',
			'export.doc.noReport' => '无汇报',
			'export.doc.generated' => ({required Object date}) => '${date}由 CMFI Connect 生成',
			'export.doc.page' => ({required Object n, required Object total}) => '第 ${n} 页 / 共 ${total} 页',
			'export.doc.filledColumn' => '汇报',
			'export.doc.yes' => '是',
			'export.doc.no' => '否',
			'export.doc.sentFrom' => '发送自 CMFI Connect',
			'items.title' => '我的项目',
			'items.standardSection' => '标准项目 · 所有人适用',
			'items.personalSection' => '我的个人项目',
			'items.emptyPersonal' => '你还没有个人项目。',
			'items.archive' => '归档',
			'items.archiveTitle' => ({required Object code}) => '归档 ${code}？',
			'items.archiveText' => '它将不再出现在你的汇报中，但数据仍会保留在历史记录里。',
			'items.archived' => ({required Object code}) => '${code} 已归档',
			'items.create' => '创建项目',
			'items.footnote' => '已归档的项目不再出现在你的汇报中，但数据仍会保留在历史记录里。',
			'items.measure.quantity' => ({required Object unit}) => '数量 · ${unit}',
			'items.measure.quantityNoUnit' => '数量',
			'items.measure.duration' => '时长',
			'items.measure.both' => ({required Object unit}) => '数量（${unit}）和时长',
			'items.measure.bothNoUnit' => '数量和时长',
			'items.goalAdd' => '添加目标',
			'items.goal' => ({required Object value}) => '目标：每天 ${value}',
			'items.goalTitle' => '每日目标',
			'items.goalHint' => '你每天想要达到的目标，只保存在你的手机上。',
			'items.goalRemove' => '移除',
			'items.goalSaved' => '目标已保存',
			'items.goalRemoved' => '目标已移除',
			'newItem.title' => '新项目',
			'newItem.code' => '代码',
			'newItem.label' => '名称',
			'newItem.help' => '字母和数字，最多 20 个。标准项目的代码（LB、PS……）不可使用。',
			'newItem.measures' => '你要记录什么',
			'newItem.quantity' => '数量',
			'newItem.quantityHint' => '章、页、人……',
			'newItem.unit' => '数字后显示的单位',
			'newItem.unitHint' => '人',
			'newItem.duration' => '时长',
			'newItem.durationHint' => '以小时和分钟计',
			'newItem.noMeasure' => '请至少选择一项：数量、时长，或两者都选。',
			'newItem.preview' => '在汇报中的预览',
			'newItem.previewCode' => 'CODE',
			'newItem.previewLabel' => '项目名称',
			'newItem.submit' => '创建项目',
			'newItem.created' => ({required Object code}) => '${code} 已创建。',
			'newItem.codeTaken' => '此代码已被使用，可能是标准项目，也可能是你自己的某个项目（包括已归档的）。',
			'newItem.codeHint' => 'EVG',
			'newItem.labelHint' => '传福音',
			'more.title' => '更多',
			'more.editProfile' => '编辑我的资料',
			'more.community' => '团契',
			'more.events' => '活动',
			'more.reports' => '每日汇报',
			'more.myItems' => '我的项目',
			'more.app' => '应用',
			'more.language' => '语言',
			'more.appearance' => '外观',
			'more.themeSystem' => '自动',
			'more.themeSystemHint' => '选择自动时，应用会跟随手机的浅色或深色设置。',
			'more.themeLight' => '浅色',
			'more.themeDark' => '深色',
			'more.logout' => '退出登录',
			'more.account' => '账户',
			'more.languageTitle' => '应用语言',
			'more.completeProfile' => '添加你的姓名',
			'more.accompaniment' => '属灵陪伴',
			'more.exportReport' => '导出我的汇报',
			'more.logoutPendingTitle' => '还有未发送的汇报',
			'more.logoutPendingText' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n, other: '有 ${n} 天的汇报是在没有网络时保存的，尚未发送。如果现在退出登录，这些汇报将会丢失。', ), 
			'more.logoutAnyway' => '仍然退出',
			'more.admin' => '管理',
			'more.staff' => '团队与角色',
			'more.manageEvents' => '活动',
			'more.disciples' => '我的门徒',
			'more.version' => ({required Object version}) => '版本 ${version}',
			'more.copyright' => ({required Object year}) => '© ${year} Christian Missionary Fellowship International. 保留所有权利。',
			'authorities.title' => '我的属灵带领者',
			'authorities.intro' => '在与神同行的路上陪伴你的人：你的门训者和其他带领者。',
			'authorities.discipleMaker' => '门训者',
			'authorities.discipleMakerOf' => ({required Object name}) => '门训者：${name}',
			'authorities.noDiscipleMaker' => '还没有门训者',
			'authorities.others' => '其他带领者',
			'authorities.empty' => '你还没有添加任何人。',
			'authorities.add' => '添加带领者',
			'authorities.remove' => '移除',
			'authorities.removeTitle' => ({required Object name}) => '移除 ${name}？',
			'authorities.removeText' => ({required Object name}) => '${name} 将不再是你的属灵带领者。',
			'authorities.removed' => ({required Object name}) => '${name} 已不再是你的带领者。',
			'authorities.count' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n, zero: '暂时还没有', other: '${n} 人', ), 
			'authorities.form.title' => '新的带领者',
			'authorities.form.emailHint' => 'name@example.com',
			'authorities.form.isDiscipleMaker' => '这是我的门训者',
			'authorities.form.isDiscipleMakerHelp' => '亲自带领你的那个人。你只能有一位。',
			'authorities.form.discipleMakerTaken' => ({required Object name}) => '${name} 已经是你的门训者。若要指定其他人，请先将其从列表中移除。',
			'authorities.form.submit' => '添加',
			'authorities.form.added' => ({required Object name}) => '${name} 现在是你的带领者了。',
			'authorities.form.searchLabel' => '对方的用户名',
			'authorities.form.searchHint' => '用户名',
			'authorities.form.search' => '搜索',
			'authorities.form.searchHelp' => '如果对方在使用 CMFI Connect，可以通过用户名找到他/她。对方会收到你的请求，接受后你就能看到其联系方式。',
			'authorities.form.notFound' => ({required Object username}) => '没有用户名为 @${username} 的用户。',
			'authorities.form.invite' => '邀请对方加入 CMFI Connect',
			'authorities.form.inviteText' => '你好！我在用 CMFI Connect 记录我与神同行的生活，希望你能陪伴我。请安装这个应用并创建账号，然后把你的用户名发给我，我好添加你。',
			'authorities.form.inviteMine' => ({required Object username}) => '我的用户名：@${username}',
			'authorities.form.manual' => '对方没有这个应用？手动填写联系方式',
			'authorities.form.backToSearch' => '改为按用户名搜索',
			'authorities.form.request' => '发送请求',
			'authorities.form.requested' => ({required Object name}) => '已向 ${name} 发送请求。',
			'authorities.form.alreadyAdded' => '此人已经是你的带领者。',
			'authorities.form.makerExists' => '你已经有门训者了。',
			'authorities.form.yourself' => '这是你自己的用户名。',
			'authorities.form.sharingHelp' => ({required Object name}) => '${name} 将能看到你的报告：已填写的项目、你的规律性和百分比，但永远看不到你的备注。你可以在他的卡片上停止分享。',
			'authorities.statusPending' => '等待中',
			'authorities.statusDeclined' => '已拒绝',
			'authorities.pendingHelp' => ({required Object name}) => '${name} 接受后，你就能看到其联系方式。',
			'authorities.requests' => '收到的请求',
			'authorities.requestDiscipleMaker' => '请你做他/她的门训者',
			'authorities.requestAuthority' => '请你在信仰路上陪伴他/她',
			'authorities.accept' => '接受',
			'authorities.decline' => '拒绝',
			'authorities.acceptedRequest' => ({required Object name}) => '你现在开始陪伴 ${name}。',
			'authorities.declinedRequest' => ({required Object name}) => '已拒绝 ${name} 的请求。',
			'authorities.requestsCount' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n, other: '${n} 个请求待查看', ), 
			'authorities.sharing.title' => '分享我的报告',
			'authorities.sharing.help' => ({required Object name}) => '${name} 能看到你的报告：已填写的项目、你的规律性和百分比，但永远看不到你的备注。',
			'authorities.sharing.on' => ({required Object name}) => '你的报告已与 ${name} 分享。',
			'authorities.sharing.off' => ({required Object name}) => '${name} 不再能看到你的报告。',
			'members.username' => '用户名',
			'members.usernameHint' => 'zhang.san',
			'members.usernameHelp' => '其他成员会通过它找到你。',
			'members.usernameChecking' => '正在检查…',
			'members.usernameFree' => ({required Object username}) => '@${username} 可以使用',
			'members.usernameCurrent' => '这是你当前的用户名',
			'members.usernameTaken' => '该用户名已被占用。',
			'members.usernameInvalid' => '3–30 个字符：字母、数字、「.」和「_」，不能以符号开头或结尾。',
			'members.usernameReserved' => '该用户名已被保留。',
			'members.usernameSaved' => ({required Object username}) => '用户名已保存：@${username}',
			'members.deleteAccount.button' => '删除我的账户',
			'members.deleteAccount.title' => '删除我的账户',
			'members.deleteAccount.intro' => '此操作无法撤销。你的账户及其相关的一切都将被删除：',
			'members.deleteAccount.itemProfile' => '你的个人资料、头像、用户名和密码',
			'members.deleteAccount.itemReports' => '你所有的汇报、项目和目标',
			'members.deleteAccount.itemAuthorities' => '你的属灵带领者以及收到的请求',
			'members.deleteAccount.itemEvents' => '你的活动报名',
			'members.deleteAccount.itemPrayer' => '你的祷告名单、祷告记录和恒切祷告事项',
			'members.deleteAccount.kept' => '你作为管理员发布的活动、动态、照片和代祷事项会继续留给团契，但不再显示你的名字。',
			'members.deleteAccount.passwordHelp' => '用于确认是你本人。',
			'members.deleteAccount.confirm' => '永久删除',
			'members.deleteAccount.done' => '你的账户已删除。愿神赐福给你！',
			'members.deleteAccount.wrongPassword' => '密码错误。',
			'members.deleteAccount.lastSuperadmin' => '你是唯一的超级管理员：删除账户前，请先把这个角色交给别人。',
			'admin.title' => '团队与角色',
			'admin.intro' => '管理员负责管理整个团契共享的内容。只有超级管理员可以授予或收回角色。',
			'admin.roleUser' => '成员',
			'admin.roleAdmin' => '管理员',
			'admin.roleSuperadmin' => '超级管理员',
			'admin.giveRole' => '授予角色',
			'admin.you' => '你',
			'admin.roleFor' => ({required Object username}) => '@${username} 的角色',
			'admin.roleChanged' => ({required Object username, required Object role}) => '@${username}：${role}',
			'admin.memberUsername' => '成员的用户名',
			_ => null,
		} ?? switch (path) {
			'admin.empty' => '暂时还没有管理员。',
			'hymns.searchHint' => '编号、标题或歌词',
			'hymns.openNumber' => '按编号查找',
			'hymns.tabs.all' => '全部',
			'hymns.tabs.favorites' => '收藏',
			'hymns.tabs.recent' => '最近',
			'hymns.chooseBook' => '选择诗歌本',
			'hymns.count' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n, other: '${n} 首诗歌', ), 
			'hymns.number' => ({required Object number}) => '第 ${number} 首',
			'hymns.emptyFavorites' => '点一下诗歌的星标，就能在这里找到它。',
			'hymns.emptyRecent' => '你打开过的诗歌会显示在这里。',
			'hymns.noResult' => ({required Object query}) => '没有与「${query}」相符的诗歌。',
			'hymns.otherBooks' => '其他诗歌本中',
			'hymns.upToDate' => '诗歌本已是最新。',
			'hymns.updated' => '诗歌本已更新。',
			'hymns.chorus' => '副歌',
			'hymns.chorusNumber' => ({required Object label}) => '副歌 ${label}',
			'hymns.verse' => ({required Object label}) => '第 ${label} 节',
			'hymns.times' => ({required Object n}) => '×${n}',
			'hymns.loadFailed' => '无法打开诗歌本。',
			'hymns.reader.smaller' => '缩小文字',
			'hymns.reader.larger' => '放大文字',
			'hymns.reader.display' => '显示',
			'hymns.reader.textSize' => '文字大小',
			'hymns.reader.typeface' => '字体',
			'hymns.reader.typefaceAuto' => '自动',
			'hymns.reader.typefaceSans' => '现代',
			'hymns.reader.typefaceSerif' => '经典',
			'hymns.reader.typefaceAutoHelp' => '文字较大时使用经典字体',
			'hymns.reader.background' => '背景',
			'hymns.reader.themeAuto' => '自动',
			'hymns.reader.themeLight' => '浅色',
			'hymns.reader.themeSepia' => '羊皮纸',
			'hymns.reader.themeDark' => '深色',
			'hymns.reader.repeatChorus' => '每节之后重复副歌',
			'hymns.reader.keepScreenOn' => '保持屏幕常亮',
			'hymns.reader.addFavorite' => '加入收藏',
			'hymns.reader.removeFavorite' => '取消收藏',
			'hymns.reader.favoriteAdded' => '已加入收藏',
			'hymns.reader.favoriteRemoved' => '已取消收藏',
			'hymns.reader.more' => '更多选项',
			'hymns.reader.copy' => '复制歌词',
			'hymns.reader.copied' => '歌词已复制',
			'hymns.reader.project' => '投影模式',
			'hymns.reader.pinchHint' => '双指缩放屏幕，即可放大或缩小文字。',
			'hymns.reader.notFound' => '此诗歌已不在诗歌本中。',
			'hymns.reader.share' => '分享歌词',
			'hymns.projection.exit' => '退出投影模式',
			'hymns.projection.previous' => '上一节',
			'hymns.projection.next' => '下一节',
			'hymns.projection.position' => ({required Object current, required Object total}) => '${current} / ${total}',
			'hymns.projection.hint' => '点击右侧前进，点击左侧返回。',
			'hymns.pad.title' => '跳转到诗歌',
			'hymns.pad.open' => '打开',
			'hymns.pad.erase' => '删除',
			'hymns.pad.notFound' => ({required Object number}) => '此诗歌本中没有第 ${number} 首',
			'hymns.pad.placeholder' => '输入编号',
			'comingSoon.badge' => '即将推出',
			'comingSoon.backHome' => '返回首页',
			'events.title' => '活动',
			'events.featured' => '精选',
			'events.upcoming' => '即将举行',
			'events.past' => '往届活动',
			'events.emptyTitle' => '暂无即将举行的活动',
			'events.emptyText' => '整个团契的大会和聚会将显示在这里，并附有日程安排。',
			'events.manage' => '管理活动',
			'events.next' => '下一个活动',
			'events.seeAll' => '全部活动',
			'events.homeText' => '团契的聚会、日程和最新动态。',
			'events.today' => '今天',
			'events.tomorrow' => '明天',
			'events.inDays' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n, other: '${n} 天后', ), 
			'events.daysLeft' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n, other: '还剩 ${n} 天', ), 
			'events.onNow' => '进行中',
			'events.over' => '已结束',
			'events.cancelled' => '已取消',
			'events.draft' => '草稿',
			'events.registered' => '已报名',
			'events.stateOpen' => '报名中',
			'events.stateClosed' => '报名已截止',
			'events.stateFull' => '名额已满',
			'events.registrations' => ({required num n, required Object count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n, zero: '成为第一个报名的人', other: '${count} 人已报名', ), 
			'events.people' => ({required num n, required Object count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n, other: '${count} 人', ), 
			'events.placesLeft' => ({required num n, required Object count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n, zero: '已无名额', other: '剩余 ${count} 个名额', ), 
			'events.oneDay' => ({required Object start, required Object end}) => '${start} 至 ${end}',
			'events.severalDays' => ({required Object startDay, required Object start, required Object endDay, required Object end}) => '${startDay} ${start} 开始，${endDay} ${end} 结束',
			'events.venueTime' => ({required Object place}) => '${place}当地时间',
			'events.addToCalendar' => '添加到日历',
			'events.share' => '分享',
			'events.directions' => '路线',
			'events.viewPoster' => '查看海报',
			'events.tabs.program' => '日程',
			'events.tabs.news' => '动态',
			'events.tabs.info' => '信息',
			'events.tabs.photos' => '照片',
			'events.noProgram' => '日程即将公布。',
			'events.noNews' => '此活动暂无动态。',
			'events.pinned' => '置顶',
			'events.now' => '正在进行',
			'events.hymn' => ({required Object number}) => '第 ${number} 首诗歌',
			'events.about' => '简介',
			'events.fees' => '费用',
			'events.deadline' => ({required Object date}) => '报名截止：${date}',
			'events.contact' => '联系人',
			'events.call' => ({required Object name}) => '致电 ${name}',
			'events.otherEditions' => '其他届次',
			'events.cancelledBanner' => '此活动已取消。',
			'events.calendarFailed' => '无法打开手机日历。',
			'events.linkFailed' => '无法打开此链接。',
			'events.shareText' => ({required Object title, required Object dates, required Object place}) => '${title}\n${dates} · ${place}\n在 CMFI Connect 应用中报名。',
			'events.full' => '此活动已没有名额。',
			'events.closed' => '此活动的报名已截止。',
			'events.register.cta' => '我要参加',
			'events.register.title' => '我要参加',
			'events.register.people' => '你们一共几人？',
			'events.register.peopleHint' => '包括你自己，以及你的家人或小组成员。',
			'events.register.less' => '减少一人',
			'events.register.more' => '增加一人',
			'events.register.lodging' => '我需要住宿',
			'events.register.lodgingHint' => '主办方会据此安排床位。',
			'events.register.departure' => '出发城市',
			'events.register.departureHint' => '例：杜阿拉',
			'events.register.confirm' => '确认报名',
			'events.register.update' => '更新',
			'events.register.cancel' => '取消报名',
			'events.register.done' => '报名成功！我们会在活动前一天提醒你。',
			'events.register.updated' => '你的报名信息已更新。',
			'events.register.cancelled' => '你的报名已取消。',
			'events.register.edit' => '修改',
			'events.register.youAre' => '你已报名',
			'events.register.cancelTitle' => '取消报名？',
			'events.register.cancelText' => '你的名额将让给其他人。',
			'events.register.keep' => '保留名额',
			'events.register.lodgingShort' => '住宿',
			'events.reminder.channel' => '活动提醒',
			'events.reminder.tomorrow' => ({required Object title}) => '明天：${title}',
			'events.reminder.soon' => ({required Object title}) => '1 小时后：${title}',
			'events.admin.title' => '管理活动',
			'events.admin.create' => '创建活动',
			'events.admin.edit' => '编辑活动',
			'events.admin.empty' => '还没有活动。来创建第一个吧！',
			'events.admin.poster' => '海报',
			'events.admin.posterAdd' => '选择海报',
			'events.admin.posterChange' => '更换海报',
			'events.admin.posterRemove' => '移除海报',
			'events.admin.posterHint' => '建议使用 4:5 竖版（1080 × 1350），JPEG 或 PNG 格式。',
			'events.admin.uploading' => '正在上传图片…',
			'events.admin.general' => '活动信息',
			'events.admin.titleField' => '标题',
			'events.admin.titleHint' => '例：2026 年度大会',
			'events.admin.titleRequired' => '请为活动填写标题。',
			'events.admin.theme' => '主题',
			'events.admin.themeHint' => '例：顺着圣灵而行',
			'events.admin.verse' => '主题经文',
			'events.admin.description' => '简介',
			'events.admin.when' => '日期',
			'events.admin.starts' => '开始',
			'events.admin.ends' => '结束',
			'events.admin.endsBeforeStart' => '结束时间必须晚于开始时间。',
			'events.admin.timeZone' => ({required Object zone}) => '时间以活动地点为准（${zone}）。',
			'events.admin.where' => '地点',
			'events.admin.venue' => '场地',
			'events.admin.venueHint' => '例：Mvolyé 会议中心',
			'events.admin.address' => '地址',
			'events.admin.city' => '城市',
			'events.admin.country' => '国家',
			'events.admin.mapsUrl' => 'Google 地图链接',
			'events.admin.registration' => '报名',
			'events.admin.registrationOpen' => '开放报名',
			'events.admin.deadline' => '截止日期',
			'events.admin.noDeadline' => '无截止日期',
			'events.admin.capacity' => '名额',
			'events.admin.capacityHint' => '留空表示不限名额',
			'events.admin.asksLodging' => '询问谁需要住宿',
			'events.admin.asksDeparture' => '询问出发城市',
			'events.admin.fees' => '费用',
			'events.admin.feesHint' => '例：免费入场。餐费：每天 2000 FCFA。',
			'events.admin.contact' => '联系人',
			'events.admin.contactName' => '联系人姓名',
			'events.admin.contactPhone' => '联系人电话',
			'events.admin.visibility' => '可见范围',
			'events.admin.statusDraft' => '草稿',
			'events.admin.statusDraftHint' => '仅管理员可见',
			'events.admin.statusPublished' => '已发布',
			'events.admin.statusPublishedHint' => '整个团契可见',
			'events.admin.statusCancelled' => '已取消',
			'events.admin.statusCancelledHint' => '显示为已取消，不可报名',
			'events.admin.saved' => '活动已保存。',
			'events.admin.menu' => '管理',
			'events.admin.program' => '日程',
			'events.admin.registrants' => '报名者',
			'events.admin.post' => '发布动态',
			'events.admin.photos' => '添加照片',
			'events.admin.nextEdition' => '筹备下一届',
			'events.admin.delete' => '删除活动',
			'events.admin.deleteTitle' => '删除此活动？',
			'events.admin.deleteText' => '报名信息、动态和照片也将一并删除。',
			'events.admin.deleteConfirm' => '删除',
			'events.admin.deleted' => '活动已删除。',
			'events.admin.nextEditionTitle' => '筹备下一届？',
			'events.admin.nextEditionText' => '将创建一份日期顺延一年的草稿，沿用相同的地点和日程。发布前你可以调整所有内容。',
			'events.admin.nextEditionConfirm' => '筹备',
			'events.admin.nextEditionDone' => '下一届已创建为草稿。',
			'events.admin.programEmpty' => '添加活动的各个环节：迎接、崇拜、教导、守夜祷告……',
			'events.admin.addSession' => '添加环节',
			'events.admin.editSession' => '编辑此环节',
			'events.admin.sessionTitle' => '标题',
			'events.admin.sessionTitleHint' => '例：开幕崇拜',
			'events.admin.speaker' => '讲员',
			'events.admin.place' => '会场',
			'events.admin.day' => '日期',
			'events.admin.from' => '从',
			'events.admin.to' => '到',
			'events.admin.hymns' => '诗歌',
			'events.admin.hymnsHint' => '编号，例：12, 45',
			'events.admin.removeSession' => '移除',
			'events.admin.saveProgram' => '保存日程',
			'events.admin.programSaved' => '日程已保存。',
			'events.admin.registrantsEmpty' => '还没有人报名。',
			'events.admin.totalRegistrations' => '报名数',
			'events.admin.totalPeople' => '人数',
			'events.admin.totalLodging' => '需住宿',
			'events.admin.byCity' => '按出发城市',
			'events.admin.list' => '名单',
			'events.admin.exportCsv' => '导出名单（CSV）',
			'events.admin.csvHeader' => '姓名,用户名,电话,教会,聚会点,人数,住宿,出发城市,报名日期',
			'events.admin.yes' => '是',
			'events.admin.no' => '否',
			'events.admin.postBody' => '内容',
			'events.admin.postBodyHint' => '例：报名已开始！',
			'events.admin.postImage' => '添加图片',
			'events.admin.postPinned' => '置顶',
			'events.admin.postSend' => '发布',
			'events.admin.postDone' => '动态已发布。',
			'events.admin.postDelete' => '删除此动态',
			'events.admin.postDeleted' => '动态已删除。',
			'events.admin.photosAdded' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n, other: '已添加 ${n} 张照片。', ), 
			'events.admin.photosSending' => ({required Object done, required Object total}) => '正在上传照片（${done}/${total}）…',
			'events.admin.photoDelete' => '删除此照片',
			'events.admin.photoDeleted' => '照片已删除。',
			'events.admin.confirmDelete' => '删除',
			'events.upcomingCount' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n, other: '${n} 个即将举行的活动', ), 
			'events.slide' => ({required Object current, required Object total}) => '第 ${current} 个活动，共 ${total} 个',
			'notifications.title' => '通知',
			'notifications.channel' => '团契公告',
			'notifications.empty' => '暂无通知',
			'notifications.emptyHint' => '团契的公告会显示在这里。',
			'notifications.unreadLabel' => ({required Object title}) => '未读：${title}',
			'notifications.documents' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n, other: '${n} 个 PDF 文档', ), 
			'notifications.unread' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n, other: '${n} 条未读', ), 
			'notifications.image' => ({required Object n}) => '图片 ${n}',
			'notifications.document' => 'PDF 文档',
			'notifications.documentSize' => ({required Object kb}) => '${kb} KB',
			'notifications.received' => ({required Object title}) => '新通知：${title}',
			'premium.name' => 'CMFI Connect Premium',
			'premium.pill' => 'Premium',
			'premium.subtitle' => '在与神同行的路上走得更远，并支持这份事工。',
			'premium.widgetTitle' => '主屏幕小组件',
			'premium.widgetText' => '无需打开应用，即可查看今天的报告和目标。',
			'premium.statsTitle' => '全年的目标',
			'premium.statsText' => '年度总结和目标的进展，一周接一周。',
			'premium.supportTitle' => '你在支持这份事工',
			'premium.supportText' => '你的订阅让整个团契都能继续使用这个应用。',
			'premium.annual' => '按年',
			'premium.lifetime' => '终身',
			'premium.monthly' => '按月',
			'premium.perYear' => ({required Object price}) => '${price} / 年',
			'premium.once' => ({required Object price}) => '${price} 一次性',
			'premium.perMonth' => ({required Object price}) => '${price} / 月',
			'premium.annualPerMonth' => ({required Object price}) => '相当于每月 ${price}',
			'premium.best' => '最划算',
			'premium.trialDays' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n, other: '免费试用 ${n} 天', ), 
			'premium.trialMonths' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n, other: '免费试用 ${n} 个月', ), 
			'premium.subscribe' => '订阅',
			'premium.startTrial' => '开始免费试用',
			'premium.restore' => '恢复购买',
			'premium.restored' => 'Premium 已在这部手机上恢复',
			'premium.nothingToRestore' => '此账户没有 Premium 购买记录',
			'premium.thanks' => '谢谢你！Premium 已开启。',
			'premium.failed' => '购买未完成，请稍后再试。',
			'premium.unavailable' => '暂时无法获取订阅方案。',
			'premium.renews' => ({required Object store}) => '订阅会自动续订。你可以随时在 ${store} 账户设置中取消。',
			'premium.terms' => '使用条款',
			'premium.privacy' => '隐私',
			'premium.activeTitle' => '你已拥有 Premium',
			'premium.activeText' => '感谢你支持 CMFI Connect！小组件和年度总结已经开放。',
			'premium.staffText' => '你是 CMFI Connect 团队的成员，Premium 免费为你开放。',
			'premium.moreSubtitle' => '小组件、全年目标',
			'premium.moreActive' => '已开启',
			'premium.unlock' => '用 Premium 解锁',
			'premium.trialThen' => ({required Object trial, required Object price}) => '${trial}，之后 ${price}',
			'premium.savePercent' => ({required Object percent}) => '−${percent}',
			'premium.choose' => '选择你的方案',
			'premium.cancelAnytime' => '无需承诺，随时可取消',
			'premium.restoreShort' => '恢复购买',
			'premium.termsShort' => '条款',
			'premium.semiannual' => '半年',
			'premium.perSemester' => ({required Object price}) => '${price} / 6 个月',
			'premium.buyLifetime' => '终身购买',
			'premium.lifetimeNote' => '终身：一次付款，无需订阅，不会续费。',
			'premium.manage' => '管理我的订阅',
			'premium.manageFailed' => '无法打开订阅管理，请稍后再试。',
			'premium.crown' => '高级版会员',
			'homeWidget.title' => '今天',
			'homeWidget.done' => '已完成',
			'homeWidget.todo' => '待填写',
			'homeWidget.open' => '填写',
			'homeWidget.locked' => '用 Premium 开启小组件',
			'homeWidget.signedOut' => '请在应用中登录',
			'ministry.title' => '我们的事工',
			'ministry.tagline' => '直到地极',
			'ministry.count' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n, other: '${n} 个国家', ), 
			'ministry.fromYaounde' => '福音从雅温得出发，传到一个又一个国家。',
			'ministry.dragHint' => '用手指转动地球，点一个国家。',
			'ministry.globeLabel' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n, other: '地球：事工所在的 ${n} 个国家。下面的列表列出了全部。', ), 
			'ministry.voyage' => '环游',
			'ministry.pause' => '暂停',
			'ministry.previous' => '上一个国家',
			'ministry.next' => '下一个国家',
			'ministry.number' => ({required Object n}) => '第 ${n} 个国家',
			'ministry.since' => ({required Object year}) => '自 ${year} 年起',
			'ministry.pray' => '祷告',
			'ministry.prayTitle' => ({required Object country}) => '为${country}祷告',
			'ministry.prayThanks' => ({required Object country}) => '为神在${country}的工作献上感谢。',
			'ministry.prayAssemblies' => ({required Object country}) => '为${country}的教会和他们的带领人祷告。',
			'ministry.prayUnreached' => ({required Object country}) => '祷告让${country}还未信主的人遇见耶稣。',
			'ministry.purpose' => '我们的目标',
			'ministry.nations' => '国家',
			'ministry.search' => '搜索国家',
			'ministry.none' => '没有匹配的国家',
			'ministry.homeText' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n, other: '遍及 ${n} 个国家', ), 
			'ministry.nationsSubtitle' => '地球与逐国之旅',
			'ministry.purposeSubtitle' => '我们的三个目标',
			'ministry.missionaries' => '我们的宣教士',
			'ministry.missionariesSubtitle' => '主差往万国的人',
			'ministry.heroes' => '我们的英雄',
			'ministry.heroesSubtitle' => '他们的信心激励着我们',
			'ministry.founder' => '我们的创始人',
			'ministry.founderSubtitle' => 'Zacharias Tanee Fomum 教授',
			'ministry.leader' => '我们的领袖',
			'ministry.leaderSubtitle' => 'Theodore Andoseh',
			'ministry.missionariesEmpty' => '我们宣教士的介绍即将推出。',
			'ministry.heroesEmpty' => '我们英雄的介绍即将推出。',
			'ministry.personGone' => '此介绍已不再提供。',
			'ministry.photoOf' => ({required Object name}) => '${name}的照片',
			'ministry.keyDates' => '重要日期',
			'ministry.life' => '生平',
			'ministry.story' => '故事',
			'ministry.goalOf' => ({required Object n, required Object total}) => '我们的目标 · ${n}/${total}',
			'ministry.previousGoal' => '上一个目标',
			'ministry.nextGoal' => '下一个目标',
			'ministry.media.books' => '书籍',
			'ministry.media.tracts' => '单张',
			'ministry.media.magazines' => '杂志',
			'ministry.media.cds' => 'CD',
			'ministry.media.dvds' => 'DVD',
			'ministry.media.radio' => '广播',
			'ministry.media.tv' => '电视',
			'ministry.media.internet' => '互联网',
			'ministry.goals.crusade.title' => '向凡受造的传福音运动',
			'ministry.goals.crusade.text' => '把福音传给我们这一代将要活着的每一个人，使福音借着圣灵的大能传扬，临到100亿人；运用一切传播途径（我们的书籍、单张、杂志、CD、DVD、广播、电视和互联网），以最迫切的方式进行。',
			'ministry.goals.crusade.reached' => '人听闻福音',
			'ministry.goals.disciples.title' => '门徒培训',
			'ministry.goals.disciples.text' => '到2065年，带领250个国家的10亿人认识耶稣基督为主和救主，使他们成为门徒，在凡事上顺服祂，并组织他们在2500万个家庭教会中聚会。',
			'ministry.goals.disciples.people' => '门徒',
			'ministry.goals.disciples.nations' => '个国家',
			'ministry.goals.disciples.churches' => '家庭教会',
			'ministry.goals.disciples.by' => ({required Object year}) => '${year}年前',
			'ministry.goals.revival.title' => '催促全球复兴',
			'ministry.goals.revival.text' => '借着禁食和代祷与神同工，为那将要裂开天、震动地、在我们这一代荣耀基督的全球大复兴祷告，以催促我们的主耶稣基督从天降临，迎接祂已预备好的新妇。',
			'ministry.goals.revival.fasting' => '禁食',
			'ministry.goals.revival.intercession' => '代祷',
			'ministry.goals.revival.pray' => '现在祷告',
			'ministry.lives.founder.name' => 'Zacharias Tanee Fomum 教授',
			'ministry.lives.founder.line' => '1945 – 2009 · CMFI 创始人',
			'ministry.lives.founder.facts.0' => '创立 CMFI',
			'ministry.lives.founder.facts.1' => '本著作',
			'ministry.lives.founder.facts.2' => '个走访的国家',
			'ministry.lives.founder.dates.0' => '6月20日生于喀麦隆一个长老会家庭。',
			'ministry.lives.founder.dates.1' => '6月13日通过一份福音单张把生命交给耶稣基督。',
			'ministry.lives.founder.dates.2' => '10月1日在塞拉利昂把自己完全献给主。',
			'ministry.lives.founder.dates.3' => '经过七天祷告，于10月24日被圣灵充满。',
			'ministry.lives.founder.dates.4' => '5月12日在雅温得创立 CMFI。',
			'ministry.lives.founder.dates.5' => '获得杜伦大学理学博士学位。',
			'ministry.lives.founder.dates.6' => '3月14日被主接去。',
			'ministry.lives.founder.story.0' => '他于1945年6月20日出生在喀麦隆，家族是来自西北部巴蒂博的长老会信徒。还在上学时，他于1956年6月13日读了一份名为《有人为你而死》的福音单张，把生命交给了耶稣基督。',
			'ministry.lives.founder.story.1' => '在塞拉利昂富拉湾学院求学期间，他于1966年10月1日毫无保留地把自己献给主和主的事工。1970年10月24日，在七天的祷告禁食之后，他被圣灵充满。从那时起，祷告成了他生命的中心。',
			'ministry.lives.founder.story.2' => '他在乌干达马凯雷雷大学获得有机化学博士学位，之后在雅温得大学任教并成为教授。他指导了约一百篇博士和硕士论文；2005年，英国杜伦大学因他的全部学术成就授予他理学博士学位。',
			'ministry.lives.founder.story.3' => '1975年5月12日，他在雅温得创立了国际基督教宣教团契（CMFI）：一个赢得灵魂、使人作门徒、建立教会、差派宣教士的运动。他在喀麦隆进行了700多次宣教旅程，又在六大洲70多个国家进行了500多次旅程。',
			'ministry.lives.founder.story.4' => '他每天花很长时间独自与神相处，带领了许多祷告大会、祷告围城和祷告行走，并经常禁食。他写了150多本关于祷告、禁食、圣洁、门徒训练和宣教的书，以多种语言被阅读。',
			'ministry.lives.founder.story.5' => '他与妻子 Prisca Zei Fomum（一位在儿童中服事的同工）育有七个孩子，都投身于福音工作。他们一同过着简朴的生活，把收入的绝大部分奉献给福音。',
			'ministry.lives.founder.story.6' => '2009年3月14日，他被主接去，3月21日安葬于雅温得。他所创立的事工在万国中继续前进。',
			'ministry.lives.leader.name' => 'Theodore Andoseh',
			'ministry.lives.leader.line' => '自2009年起担任 CMFI 领袖',
			'ministry.lives.leader.facts.0' => '建立的教会',
			'ministry.lives.leader.facts.1' => '在尼日利亚的年数',
			'ministry.lives.leader.facts.2' => '开始领导 CMFI',
			'ministry.lives.leader.dates.0' => '在 Fomum 教授的讲道中把生命交给耶稣基督。',
			'ministry.lives.leader.dates.1' => '在雅温得被按立为主教。',
			'ministry.lives.leader.dates.2' => '与妻子 Adela 一同作为宣教士前往尼日利亚。',
			'ministry.lives.leader.dates.3' => '开始领导 CMFI。',
			'ministry.lives.leader.dates.4' => '在第三届世界大会上向来自93个国家的成员传讲信息。',
			'ministry.lives.leader.story.0' => '1978年，Theodore Andoseh 在聆听 Zacharias Tanee Fomum 教授讲道时把生命交给了耶稣基督。Fomum 教授成了他属灵的父亲，并培养他作门徒。',
			'ministry.lives.leader.story.1' => '他起初在 Fomum 教授身边服事：先是在雅温得大学担任实验室助理，后来成为他的私人助理和私人秘书。在那些年里，他出版了第一份复兴福音单张《神对愿意聆听的人说话》，并在雅温得发起了第一条祷告链。',
			'ministry.lives.leader.story.2' => '作为本国宣教士，他在喀麦隆建立了五十多间教会。1989年，他在雅温得被按立为主教。',
			'ministry.lives.leader.story.3' => '1994年，他与妻子 Adela 一同作为宣教士前往尼日利亚，在那里服事了十四年。',
			'ministry.lives.leader.story.4' => '自2009年 Fomum 教授被主接去之后，他在万国中带领 CMFI。2019年12月，他在贝尔图阿附近的库梅，向来自93个国家的成员传讲第三届世界大会的信息。他也写了多本关于事奉神和建造教会的书。',
			'prayer.moments.morning' => '早晨',
			'prayer.moments.noon' => '中午',
			'prayer.moments.evening' => '傍晚',
			'prayer.moments.night' => '夜晚',
			'prayer.retreatOf.morning' => '早晨祷告',
			'prayer.retreatOf.noon' => '中午祷告',
			'prayer.retreatOf.evening' => '傍晚祷告',
			'prayer.retreatOf.night' => '夜晚祷告',
			'prayer.hero.now' => ({required Object retreat}) => '${retreat} · 现在',
			'prayer.hero.title' => '15 分钟\n与主同在',
			'prayer.hero.preview.morning' => '献上感恩，将你的一天、你的工作、你的家人奉献给主……',
			'prayer.hero.preview.noon' => '你的聚会点、你的领袖、你名单上的 5 个人、列国……',
			'prayer.hero.preview.evening' => '你的祷告生活、你的事工、你的同工……',
			'prayer.hero.preview.night' => '病人、福音传遍列国、夜间的保护……',
			'prayer.hero.meta' => '15 个要点 · 每个 1 分钟',
			'prayer.hero.start' => '开始',
			'prayer.hero.allDone' => '今天的 4 次祷告都完成了。愿神应允！',
			'prayer.hero.doneNow' => ({required Object retreat, required Object next}) => '${retreat}已完成。下一次：${next}',
			'prayer.today.toPray' => '待祷告',
			'prayer.today.week' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n, zero: '本周还没有完成祷告', other: '本周完成了 ${n} 次祷告', ), 
			'prayer.routine.title' => '你今天的祷告安排',
			'prayer.routine.count' => ({required Object done}) => '${done} / 4',
			'prayer.routine.days' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n, other: '7 天中有 ${n} 天', ), 
			'prayer.routine.week' => ({required Object time}) => '本周 ${time}',
			'prayer.routine.done' => '已完成 · 15 分钟',
			'prayer.routine.now' => '现在 · 15 分钟',
			'prayer.routine.next' => '下一个 · 15 分钟',
			'prayer.routine.reminder' => ({required Object time}) => '${time} 提醒',
			'prayer.routine.later.morning' => '早上 · 15 分钟',
			'prayer.routine.later.noon' => '中午 · 15 分钟',
			'prayer.routine.later.evening' => '傍晚 · 15 分钟',
			'prayer.routine.later.night' => '夜里 · 15 分钟',
			'prayer.together' => '一起祷告',
			'prayer.reminders.title' => '祷告提醒',
			'prayer.reminders.intro' => '在每次祷告的时间提醒你，仅在尚未完成时提醒。',
			'prayer.reminders.off' => '已关闭',
			'prayer.reminders.channel' => '15 分钟祷告',
			'prayer.reminders.body' => '与主同在 15 分钟。',
			'prayer.retreat.title' => '15 分钟祷告',
			'prayer.retreat.hours.morning' => '起床时',
			'prayer.retreat.hours.noon' => '中午 12 点到下午 2 点',
			'prayer.retreat.hours.evening' => '下午晚些时候',
			'prayer.retreat.hours.night' => '睡前',
			'prayer.retreat.reminderAt' => ({required Object time}) => '${time} 提醒',
			'prayer.retreat.intro' => '15 个要点，每个一分钟。轻柔的提示音会带你进入下一个要点。',
			'prayer.retreat.done' => '今天已完成',
			'prayer.retreat.start' => '开始 · 15 分钟',
			'prayer.retreat.selfPaced' => '按自己的节奏阅读，不计时',
			'prayer.retreat.hints.assembly' => ({required Object name}) => '你的聚会点：${name}',
			'prayer.retreat.hints.assemblyMissing' => '在个人资料中添加你的聚会点',
			'prayer.retreat.hints.authorities' => ({required Object names}) => '你的带领者：${names}',
			'prayer.retreat.hints.authoritiesMissing' => '在「更多」中添加你的属灵带领者',
			'prayer.retreat.hints.list' => ({required Object list}) => '我的名单 · ${list}',
			'prayer.retreat.hints.listEmpty' => ({required Object list}) => '你的「${list}」名单是空的：添加一些名字吧',
			'prayer.retreat.hints.nation' => ({required Object name}) => '今天：${name}',
			'prayer.retreat.hints.myCountry' => ({required Object name}) => '你的国家：${name}',
			'prayer.retreat.hints.hymn' => '打开诗歌',
			'prayer.session.point' => ({required Object n}) => '第 ${n} 点，共 15 点',
			'prayer.session.remaining' => '剩余',
			'prayer.session.paused' => '已暂停',
			'prayer.session.inYourList' => ({required Object list}) => '你的名单 · ${list}',
			'prayer.session.tomorrow' => '明天为接下来的人祷告。',
			'prayer.session.footer' => '屏幕常亮 · 每分钟一声轻柔提示音',
			'prayer.session.previous' => '上一个要点',
			'prayer.session.next' => '下一个要点',
			'prayer.session.pause' => '暂停',
			'prayer.session.resume' => '继续',
			'prayer.session.soundOn' => '声音已开启',
			'prayer.session.soundOff' => '已静音',
			'prayer.session.finish' => '完成祷告',
			'prayer.session.quitTitle' => '要停止这次祷告吗？',
			'prayer.session.quitText' => '这次祷告不会计入你今天的汇报。',
			'prayer.session.quit' => '停止',
			'prayer.session.keepPraying' => '继续祷告',
			'prayer.done.title' => ({required Object retreat}) => '${retreat}已完成',
			'prayer.done.text' => '与主同在 15 分钟。\n他听见了你的每一个祷告。',
			'prayer.done.report' => '已添加到你的汇报',
			'prayer.done.reportDetail' => ({required Object added, required Object total}) => '个人祷告：+${added} 分钟 · 今天共 ${total} 分钟',
			'prayer.done.undo' => '撤销',
			'prayer.done.undone' => '已从今天的汇报中移除这次祷告。',
			'prayer.done.today' => '今天',
			'prayer.done.count' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n, other: '${n}/4 次祷告', ), 
			'prayer.done.verse' => '“要不住地祷告。”',
			'prayer.done.reference' => '帖撒罗尼迦前书 5:17',
			'prayer.done.finish' => '完成',
			'prayer.done.hymn' => '唱一首诗歌',
			'prayer.topics.title' => '团契代祷事项',
			'prayer.topics.all' => '查看全部',
			'prayer.topics.empty' => '目前没有代祷事项。带领者会在这里发布新的事项。',
			'prayer.topics.categories.church' => '教会',
			'prayer.topics.categories.nations' => '列国',
			'prayer.topics.categories.sick' => '病人',
			'prayer.topics.categories.event' => '活动',
			'prayer.topics.categories.fasting' => '禁食',
			'prayer.topics.categories.other' => '代祷',
			'prayer.topics.until' => ({required Object date}) => '至 ${date}',
			'prayer.topics.archive' => '往期事项',
			'prayer.topics.archiveEmpty' => '没有往期事项。',
			'prayer.topics.current' => '当前',
			'prayer.topics.documentSize' => ({required Object kb}) => '${kb} KB',
			'prayer.topics.download' => '下载 PDF',
			'prayer.topics.noDocument' => '没有 PDF',
			'prayer.topics.openDocument' => '打开 PDF',
			'prayer.lists.title' => '我的祷告名单',
			'prayer.lists.private' => '仅你可见',
			_ => null,
		} ?? switch (path) {
			'prayer.lists.names.unbelievers' => '尚未信主',
			'prayer.lists.names.believers' => '信徒',
			'prayer.lists.names.backsliders' => '退后的信徒',
			'prayer.lists.names.coworkers' => '同工',
			'prayer.lists.uses.unbelievers' => '中午祷告每天轮流为这份名单上的 10 个人（5 + 5）祷告。',
			'prayer.lists.uses.believers' => '中午祷告每天轮流为这份名单上的 5 个人祷告。',
			'prayer.lists.uses.backsliders' => '中午祷告每天轮流为这份名单上的 5 个人祷告。',
			'prayer.lists.uses.coworkers' => '傍晚祷告每天轮流为你的 10 位同工（5 + 5）祷告。',
			'prayer.lists.privateNote' => '只有你能看到。',
			'prayer.lists.count' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n, zero: '暂无', other: '${n} 人', ), 
			'prayer.lists.empty' => '暂时还没有人。添加你为之祷告的人吧。',
			'prayer.lists.add' => '添加一个人',
			'prayer.lists.prayedToday' => '今天',
			'prayer.lists.next' => '即将轮到',
			'prayer.lists.answeredTitle.unbelievers' => '已信主',
			'prayer.lists.answeredTitle.believers' => '蒙应允的祷告',
			'prayer.lists.answeredTitle.backsliders' => '已回到主面前',
			'prayer.lists.answeredTitle.coworkers' => '蒙应允的祷告',
			'prayer.lists.answeredOn.unbelievers' => ({required Object date}) => '于 ${date} 信主',
			'prayer.lists.answeredOn.believers' => ({required Object date}) => '于 ${date} 蒙应允',
			'prayer.lists.answeredOn.backsliders' => ({required Object date}) => '于 ${date} 回到主面前',
			'prayer.lists.answeredOn.coworkers' => ({required Object date}) => '于 ${date} 蒙应允',
			'prayer.lists.markAnswered.unbelievers' => '已信主！',
			'prayer.lists.markAnswered.believers' => '祷告蒙应允',
			'prayer.lists.markAnswered.backsliders' => '已回到主面前！',
			'prayer.lists.markAnswered.coworkers' => '祷告蒙应允',
			'prayer.lists.answeredToast' => '荣耀归给神！',
			'prayer.lists.putBack' => '放回名单',
			'prayer.lists.answeredBanner' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n, other: '本月有 ${n} 个祷告蒙应允', ), 
			'prayer.lists.lastAnswered' => ({required Object name, required Object what}) => '${name}：${what}',
			'prayer.lists.sheet.addTitle' => '添加一个人',
			'prayer.lists.sheet.editTitle' => '编辑',
			'prayer.lists.sheet.name' => '姓名',
			'prayer.lists.sheet.namePlaceholder' => '李明',
			'prayer.lists.sheet.note' => '备注',
			'prayer.lists.sheet.notePlaceholder' => '同事、邻居、表妹……',
			'prayer.lists.sheet.list' => '名单',
			'prayer.lists.sheet.save' => '保存',
			'prayer.lists.sheet.remove' => '从名单中移除',
			'prayer.lists.sheet.removeTitle' => ({required Object name}) => '移除 ${name}？',
			'prayer.lists.sheet.removeText' => '你的每日祷告中将不再为这个人祷告。',
			'prayer.lists.addShort' => '添加',
			'prayer.importunity.title' => '恒切祷告事项',
			'prayer.importunity.newTopic' => '新事项',
			'prayer.importunity.intro' => '一个向主恒切祈求、不灰心，直到蒙应允的事项。设定宣告的次数，并邀请弟兄姊妹与你一起祷告。',
			'prayer.importunity.invitedBy' => ({required Object name}) => '${name} 邀请你一起祷告',
			'prayer.importunity.join' => '我和你们一起祷告',
			'prayer.importunity.decline' => '暂不',
			'prayer.importunity.joined' => '你已加入这个事项的祷告。',
			'prayer.importunity.progress' => ({required Object total, required Object goal}) => '${total}/${goal}',
			'prayer.importunity.total' => ({required num n, required Object count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n, other: '${count} 次宣告', ), 
			'prayer.importunity.reached' => '已达成目标！',
			'prayer.importunity.closed' => '已结束',
			'prayer.importunity.participants' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n, other: '${n} 人在祷告', ), 
			'prayer.importunity.mine' => ({required Object n}) => '你：${n}',
			'prayer.importunity.tapHint' => '每宣告一次，就点一下',
			'prayer.importunity.addMany' => '添加次数',
			'prayer.importunity.addManyTitle' => '宣告了多少次？',
			'prayer.importunity.addManyLabel' => '宣告次数',
			'prayer.importunity.add' => '添加',
			'prayer.importunity.pending' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n, other: '${n} 次待发送', ), 
			'prayer.importunity.invite' => '邀请',
			'prayer.importunity.members' => '一起祷告的人',
			'prayer.importunity.waiting' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n, other: '${n} 个邀请待回复', ), 
			'prayer.importunity.edit' => '编辑',
			'prayer.importunity.close' => '结束事项',
			'prayer.importunity.reopen' => '重新开启事项',
			'prayer.importunity.delete' => '删除事项',
			'prayer.importunity.deleteTitle' => '删除这个事项？',
			'prayer.importunity.deleteText' => '所有与你一起祷告的人都将看不到它。',
			'prayer.importunity.leave' => '退出这个事项',
			'prayer.importunity.leaveTitle' => '退出这个事项？',
			'prayer.importunity.leaveText' => '你的宣告次数仍会计入总数。',
			'prayer.importunity.form.newTitle' => '新的恒切祷告事项',
			'prayer.importunity.form.editTitle' => '编辑事项',
			'prayer.importunity.form.subject' => '事项',
			'prayer.importunity.form.subjectPlaceholder' => '主啊，求你拯救李明',
			'prayer.importunity.form.description' => '详情',
			'prayer.importunity.form.descriptionPlaceholder' => '为谁、为什么……',
			'prayer.importunity.form.goal' => '目标',
			'prayer.importunity.form.goalHint' => '大家一起要达到的宣告次数。留空则只计数、不设目标。',
			'prayer.importunity.form.goalPlaceholder' => '10000',
			'prayer.importunity.form.create' => '创建',
			'prayer.importunity.form.save' => '保存',
			'prayer.importunity.inviteSheet.title' => '邀请一起祷告',
			'prayer.importunity.inviteSheet.family' => '我的属灵家人',
			'prayer.importunity.inviteSheet.familyText' => ({required num n, required Object name}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n, other: '${name}及其门徒：${n} 人', ), 
			'prayer.importunity.inviteSheet.familyMissing' => '在「我的属灵带领者」中关联你的门训者，就能邀请你的属灵家人。',
			'prayer.importunity.inviteSheet.byUsername' => '按用户名',
			'prayer.importunity.inviteSheet.usernameLabel' => '用户名',
			'prayer.importunity.inviteSheet.addUsername' => '添加',
			'prayer.importunity.inviteSheet.send' => '发送邀请',
			'prayer.importunity.inviteSheet.sent' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n, zero: '他们之前已被邀请过了。', other: '已发送 ${n} 个邀请', ), 
			'prayer.importunity.eyebrow' => '恒切祷告事项',
			'prayer.importunity.proclaim' => '宣告',
			'prayer.importunity.timer' => '为祷告计时',
			'prayer.importunity.timeLabel' => '为此事项祷告的时间',
			'prayer.importunity.mineTime' => ({required Object n, required Object time}) => '你：${n} · 祷告 ${time}',
			'prayer.importunity.timerNote' => '时间会计入报告中的“个人祷告”。',
			'sending.title' => '发送给我的属灵长辈',
			'sending.moreOff' => '已关闭',
			'sending.intro' => '到了你选定的时间，CMFI Connect 会准备好这段时间的报告，你只需发送给你的属灵长辈。',
			'sending.enabled' => '定期为我准备',
			'sending.rhythm' => '频率',
			'sending.weekly' => '每周',
			'sending.biweekly' => '每两周',
			'sending.monthly' => '每月',
			'sending.day' => '日期',
			'sending.monthlyDay' => '每月 1 日，发送上个月的报告',
			'sending.time' => '时间',
			'sending.recipients' => '收件人',
			'sending.noAuthorities' => '请先添加你的属灵长辈。',
			'sending.addAuthorities' => '添加属灵长辈',
			'sending.viaWhatsApp' => '通过 WhatsApp',
			'sending.viaEmail' => '通过电子邮件',
			'sending.viaBoth' => '通过 WhatsApp 或电子邮件',
			'sending.viaShare' => '通过分享',
			'sending.next' => ({required Object date}) => '下一次：${date}',
			'sending.prepareNow' => '立即准备',
			'sending.history' => '最近发送',
			'sending.notificationTitle' => '你的报告已准备好',
			'sending.notificationBody' => '一键发送给你的属灵长辈。',
			'sending.channel' => '报告发送',
			'sending.readyTitle' => '你的报告已准备好',
			'sending.preview' => '消息预览',
			'sending.greeting' => ({required Object name}) => '${name}，你好：',
			'sending.whatsApp' => 'WhatsApp',
			'sending.email' => '电子邮件',
			'sending.sharePdf' => '分享 PDF',
			'sending.shareText' => '分享文字',
			'sending.sent' => '已发送',
			'sending.shared' => '已分享',
			'sending.noRecipients' => '请在设置中选择收件人，或分享 PDF。',
			'sending.settings' => '设置',
			'sending.permissionDenied' => '请允许通知，以便按时提醒你。',
			'streak.title' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n, other: '连续 ${n} 天！', ), 
			'streak.cardDays' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n, other: '天，与神同在', ), 
			'streak.lines.week' => '整整一周，天天与主同在。真棒，继续加油！',
			'streak.lines.month' => '一个月的忠心！你每天所撒的种必结出果子。',
			'streak.lines.hundred' => '与神同在一百天！你的坚持是美好的见证。',
			'streak.lines.year' => '与神同在整整一年！为你的忠心将荣耀归给祂。',
			'streak.share' => '分享',
			'streak.close' => '继续',
			'shortcuts.today' => '填写我的汇报',
			'shortcuts.hymns' => '诗歌',
			'shortcuts.retreat' => '此刻的祷告',
			'blocking.report' => '举报',
			'blocking.block' => ({required Object name}) => '屏蔽${name}',
			'blocking.blockTitle' => ({required Object name}) => '屏蔽${name}？',
			'blocking.blockText' => ({required Object name}) => '你将不再收到${name}的邀请。这条邀请会被移除。',
			'blocking.blockAction' => '屏蔽',
			'blocking.blocked' => ({required Object name}) => '${name}将无法再邀请你。',
			'blocking.reportTitle' => '举报这条邀请',
			'blocking.reportText' => '告诉我们哪里不对：团契的负责人会查看。',
			'blocking.reasons.spam' => '垃圾信息',
			'blocking.reasons.offensive' => '令人震惊或冒犯的内容',
			'blocking.reasons.other' => '其他',
			'blocking.comment' => '备注',
			'blocking.commentHint' => '负责人需要了解的情况',
			'blocking.send' => '提交举报',
			'blocking.reported' => '谢谢，负责人会查看。',
			'blocking.listTitle' => '已屏蔽的成员',
			'blocking.intro' => '他们的祷告邀请不会再发给你。',
			'blocking.empty' => '你还没有屏蔽任何人。',
			'blocking.unblock' => '取消屏蔽',
			'blocking.unblocked' => ({required Object name}) => '${name}可以再次邀请你。',
			'verses.title' => '每日经文',
			'verses.share' => '分享经文',
			'verses.shareImage' => '分享图片',
			'verses.shareText' => '分享文字',
			'bible.title' => '圣经',
			'bible.books' => '书卷',
			'bible.oldTestament' => '旧约',
			'bible.newTestament' => '新约',
			'bible.chapters' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n, other: '${n} 章', ), 
			'bible.chapter' => ({required Object n}) => '第 ${n} 章',
			'bible.version' => '译本',
			'bible.versions' => '圣经译本',
			'bible.search' => '搜索圣经',
			'bible.searchHint' => '一个词，或“约翰福音 3:16”',
			'bible.searchTip' => '搜索一个词（“爱”），或直接前往经文（“诗篇 23”、“约翰福音 3:16”）。',
			'bible.searchNone' => '没有经文包含这些词。',
			'bible.searchCount' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n, other: '${n} 节经文', ), 
			'bible.searchLimit' => ({required Object n}) => '前 ${n} 节经文',
			'bible.searchNeedsDownload' => '下载这本圣经后，即可在全书中搜索词语。现在已经可以输入经文：“约翰福音 3:16”。',
			'bible.open' => ({required Object reference}) => '打开 ${reference}',
			'bible.previous' => '上一章',
			'bible.next' => '下一章',
			'bible.markRead' => '我读完了这一章',
			'bible.markedRead' => '今天已读',
			'bible.markReadHint' => '在你的汇报中为“读经”加 1 章。',
			'bible.addedToReport' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n, other: '汇报：今天已读 ${n} 章', ), 
			'bible.removedFromReport' => '已从汇报中移除',
			'bible.noReadingItem' => '你的汇报中没有“读经”这一项。',
			'bible.download' => '下载这本圣经',
			'bible.downloadHelp' => ({required Object size}) => '约 ${size} MB，无网络时也能阅读和搜索。',
			'bible.downloading' => ({required Object percent}) => '正在下载… ${percent}%',
			'bible.downloaded' => '已在手机上',
			'bible.downloadDone' => ({required Object version}) => '${version} 已在你的手机上',
			'bible.removeDownload' => '从手机移除',
			'bible.removeDownloadTitle' => ({required Object version}) => '从手机移除 ${version}？',
			'bible.removeDownloadText' => '你已读过的章节仍可离线阅读。',
			'bible.offline' => '这一章还不在你的手机上。请重新联网，或下载这本圣经以便离线阅读。',
			'bible.notInVersion' => '这个译本中没有这段经文。',
			'bible.marks' => '我的经文',
			'bible.favorites' => '收藏',
			'bible.highlights' => '标记',
			'bible.noFavorites' => '点一节经文，再点书签，就能在这里找到它。',
			'bible.noHighlights' => '点一节经文，再选一种颜色来标记它。',
			'bible.tapHint' => '点一节经文，即可标记、收藏、复制或分享。',
			'bible.highlight' => ({required Object color}) => '用${color}标记',
			'bible.colors.yellow' => '黄色',
			'bible.colors.green' => '绿色',
			'bible.colors.blue' => '蓝色',
			'bible.colors.pink' => '粉色',
			'bible.removeHighlight' => '移除颜色',
			'bible.addFavorite' => '收藏到我的经文',
			'bible.removeFavorite' => '从我的经文中移除',
			'bible.favoriteAdded' => '已收藏到我的经文',
			'bible.favoriteRemoved' => '已从我的经文中移除',
			'bible.copy' => '复制',
			'bible.copied' => '已复制',
			'bible.share' => '分享',
			'bible.closeSelection' => '关闭选择',
			'bible.display' => '显示',
			'bible.jesusInRed' => '耶稣的话用红色显示',
			'bible.jesusInRedHelp' => '适用于标注了耶稣话语的译本',
			'bible.remove' => '移除',
			'bible.readInBible' => '在圣经中阅读',
			'bible.concordance' => '经文汇编',
			'bible.concordanceOf' => ({required Object word}) => '“${word}”的经文汇编',
			'bible.concordanceHint' => '圣经中的一个词',
			'bible.concordanceTip' => '输入一个词：经文汇编按书卷列出它出现的每一节经文。',
			'bible.concordanceNeedsDownload' => '经文汇编会查遍整本圣经：请先下载。',
			'bible.concordanceNone' => '这本圣经中没有这个词。',
			'bible.exactWord' => '这个词',
			'bible.startsWith' => '开头为…',
			'bible.occurrences' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n, other: '次', ), 
			'bible.inVerses' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n, other: '出现在 ${n} 节经文中', ), 
			'bible.spread' => '这个词出现的位置',
			'bible.forms' => '找到的形式',
			'bible.bookCount' => ({required Object book, required Object n}) => '${book}：${n}',
			'bible.allBooks' => '所有书卷',
			'bible.pickWord' => '选择一个词',
			'bible.pickWordHelp' => '经文汇编会列出它出现的每一节经文。',
			'bible.more' => '更多选项',
			'bible.crossReferences' => '串珠经文',
			'bible.crossReferencesOf' => ({required Object passage}) => '串珠经文 · ${passage}',
			'bible.noCrossReferences' => '此段经文没有串珠。',
			'bible.crossReferencesSource' => '来源：OpenBible.info（CC-BY）',
			'profilePhoto.title' => '头像',
			'profilePhoto.add' => '添加头像',
			'profilePhoto.change' => '更换头像',
			'profilePhoto.seenBy' => '其他成员在你的名字出现的地方都能看到它。',
			'profilePhoto.camera' => '拍照',
			'profilePhoto.gallery' => '从相册选择',
			'profilePhoto.remove' => '移除照片',
			'profilePhoto.cropTitle' => '裁剪你的照片',
			'profilePhoto.cropHint' => '用手指移动和放大照片。',
			'profilePhoto.use' => '使用这张照片',
			'profilePhoto.unreadable' => '无法打开此图片，请选择另一张。',
			'profilePhoto.saved' => '你的头像已保存。',
			'profilePhoto.removed' => '你的头像已移除。',
			'disciples.title' => '我的门徒',
			'disciples.empty' => '还没有门徒',
			'disciples.emptyText' => '当有成员选择你作为门训者或属灵权柄、并且你接受了请求，他就会出现在这里。',
			'disciples.count' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n, other: '${n} 位门徒', ), 
			'disciples.notShared' => '未分享其报告',
			'disciples.roleMaker' => '你是他的门训者',
			'disciples.roleAuthority' => '你是他的属灵权柄之一',
			'disciples.dayGoals' => ({required Object percent}) => '目标 ${percent} %',
			'disciples.dayItems' => ({required Object total, required Object filled, required Object percent}) => '${total} 项中填写了 ${filled} 项 · ${percent} %',
			'disciples.older' => '查看之前的 30 天',
			'disciples.noReports' => '这段时间没有报告。',
			'disciples.searchHint' => '姓名或用户名',
			'disciples.noMatch' => ({required Object search}) => '没有与“${search}”匹配的门徒。',
			'weekStory.title' => '你与神同在的一周',
			'weekStory.range' => ({required Object from, required Object to}) => '${from}至${to}',
			'weekStory.intro' => '回顾这一周你与主同在的点滴。',
			'weekStory.tapHint' => '点击右侧继续，点击左侧返回。',
			'weekStory.faithfulLead' => '你很忠心',
			'weekStory.emptyLead' => '新的一周在等着你',
			'weekStory.days' => ({required num n, required Object total}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n, other: '${total} 天中\n有 ${n} 天', ), 
			'weekStory.streak' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n, other: '连续 ${n} 天', ), 
			'weekStory.streakRecord' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n, other: '连续 ${n} 天：你的纪录！', ), 
			'weekStory.emptyText' => '每天填写你的报告：你的下一周将写在这里。',
			'weekStory.prayerLead' => '你祷告了',
			'weekStory.retreats' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n, other: '${n} 次退修', ), 
			'weekStory.retreatsTime' => ({required Object time}) => '每次 15 分钟 · 与主同在 ${time}',
			'weekStory.faithfulMoment' => ({required num n, required Object moment}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n, other: '你最忠心的时段：${moment}（${n} 次）', ), 
			'weekStory.noRetreat' => '本周没有退修',
			'weekStory.noRetreatText' => '午间退修在等着你：与主同在 15 分钟。',
			'weekStory.goalsLead' => '你的目标',
			'weekStory.goalsReached' => '平均达成',
			'weekStory.bestDay' => ({required Object day, required Object percent}) => '你最好的一天：${day} · ${percent}',
			'weekStory.summaryTitle' => '我与神同在的一周',
			'weekStory.statDays' => '天已填写',
			'weekStory.statStreak' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n, other: '天连续', ), 
			'weekStory.statRetreats' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n, other: '次退修', ), 
			'weekStory.statGoals' => '目标',
			'weekStory.share' => '分享我的一周',
			'weekStory.homeText' => '你这一周的忠心、祷告和目标。',
			'weekStory.open' => '查看我的一周',
			'weekStory.notificationTitle' => '你与神同在的一周已准备好',
			'weekStory.notificationBody' => '回顾你这一周的忠心并分享出去。',
			'weekStory.channel' => '你与神同在的一周',
			'weekStory.thisWeek' => '本周',
			'weekStory.pastWeeks' => '过去几周',
			'weekStory.weekOf' => ({required Object date}) => '${date} 那一周',
			'weekStory.page' => ({required Object current, required Object total}) => '第 ${current} 页，共 ${total} 页',
			'seekFirst.title' => '先求神',
			'seekFirst.verse' => '你们要先求他的国和他的义，这些东西都要加给你们了。',
			'seekFirst.verseRef' => '马太福音 6:33',
			'seekFirst.intro' => '每天，你选择的应用会一直关闭，直到你保存当天的汇报。用神开始你的一天，其余的随后而来。',
			'seekFirst.enable' => '开启',
			'seekFirst.apps' => '要关闭的应用',
			'seekFirst.appsNone' => '尚未选择应用',
			'seekFirst.appCount' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n, other: '${n} 个应用', ), 
			'seekFirst.categoryCount' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n, other: '${n} 个类别', ), 
			'seekFirst.siteCount' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n, other: '${n} 个网站', ), 
			'seekFirst.start' => '关闭时间',
			'seekFirst.pauses' => '5 分钟暂停',
			'seekFirst.pausesText' => '每天 3 次，用于紧急情况',
			'seekFirst.pausesLeft' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n, zero: '今天没有剩余的暂停', other: '今天还剩 ${n} 次暂停', ), 
			'seekFirst.todayOpen' => '今天你的应用已打开：你先求了神。',
			'seekFirst.todayLocked' => '在完成今天的汇报之前，你的应用保持关闭。',
			'seekFirst.todayBefore' => ({required Object time}) => '如果你的汇报还没有保存，你的应用将在 ${time} 关闭。',
			'seekFirst.fillReport' => '填写我的汇报',
			'seekFirst.denied' => '没有“屏幕使用时间”的权限，CMFI Connect 无法关闭应用。你可以在“设置 › 屏幕使用时间”中允许。',
			'seekFirst.noApps' => '请至少选择一个要关闭的应用。',
			'seekFirst.unsupported' => '即将在此手机上推出。',
			'seekFirst.moreOn' => ({required Object time}) => '从 ${time} 起，直到你的汇报',
			'seekFirst.moreOff' => '在完成汇报前关闭应用',
			'seekFirst.privacy' => 'CMFI Connect 永远看不到你选择了哪些应用：它们只保存在你的 iPhone 上。',
			'seekFirst.shield.title' => '先求神',
			'seekFirst.shield.subtitle' => ({required Object app}) => '在完成今天的汇报之前，${app} 保持关闭。',
			'seekFirst.shield.thisApp' => '此应用',
			'seekFirst.shield.fill' => '填写我的汇报',
			'seekFirst.shield.pause' => ({required Object n}) => '暂停 5 分钟（${n}/3）',
			'seekFirst.shield.notificationTitle' => '先求神',
			'seekFirst.shield.notificationBody' => '轻点此处填写你的汇报。',
			'seekFirst.shield.serviceBody' => '你的应用每天都会关闭，直到你填写报告。',
			'seekFirst.permissionsAndroid' => '为了关闭你的应用，CMFI Connect 需要在即将打开的设置中开启两项权限：“使用情况访问权限”（知道哪个应用在前台）和“显示在其他应用上层”（显示“先求神”页面）。任何数据都不会离开你的手机。',
			'seekFirst.permissionsContinue' => '继续',
			'seekFirst.deniedAndroid' => '没有这两项权限，CMFI Connect 无法关闭应用。你可以在“设置 › 应用 › 特殊访问权限”中开启。',
			'seekFirst.privacyAndroid' => '你选择的应用只保存在手机上：CMFI Connect 绝不会上传。',
			'documents.title' => '我们的文件',
			'documents.subtitle' => '教导、规章、表格…',
			'documents.moreSubtitle' => '团契的资料库',
			'documents.search' => '搜索文件',
			'documents.all' => '全部',
			'documents.empty' => '暂无文件。团契发布的文件会显示在这里。',
			'documents.none' => '没有符合搜索的文件。',
			'documents.sizeKb' => ({required Object n}) => '${n} KB',
			'documents.sizeMb' => ({required Object n}) => '${n} MB',
			'documents.pdf' => 'PDF',
			'documents.word' => 'Word',
			'documents.open' => '打开文件',
			'documents.download' => '下载',
			'documents.count' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n, other: '${n} 个文件', ), 
			'documents.more' => '查看更多',
			'biblePlan.title' => '读经计划',
			'biblePlan.intro' => '选择你要读的内容和用多长时间：应用会把章节一天天分配好。',
			'biblePlan.duration' => '时长',
			'biblePlan.months3' => '3 个月',
			'biblePlan.months6' => '6 个月',
			'biblePlan.year' => '1 年',
			'biblePlan.custom' => '其他',
			'biblePlan.days' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n, other: '${n} 天', ), 
			'biblePlan.scope' => '读什么',
			'biblePlan.scopes.bible' => '整本圣经',
			'biblePlan.scopes.newTestament' => '新约',
			'biblePlan.scopes.oldTestament' => '旧约',
			'biblePlan.scopes.psalmsProverbs' => '诗篇和箴言',
			'biblePlan.order' => '顺序',
			'biblePlan.orders.canonical' => '按书卷顺序',
			'biblePlan.orders.parallel' => '新旧约每天',
			'biblePlan.reminder' => '每日提醒',
			'biblePlan.reminderAt' => '提醒时间',
			'biblePlan.summary' => ({required Object days, required Object chapters, required Object perDay}) => '${days} 天读 ${chapters} 章，每天约 ${perDay} 章',
			'biblePlan.endsOn' => ({required Object date}) => '${date} 结束',
			'biblePlan.startsOn' => ({required Object date}) => '计划将于 ${date} 开始。',
			'biblePlan.start' => '开始计划',
			'biblePlan.dayOf' => ({required Object day, required Object total}) => '第 ${day} 天，共 ${total} 天',
			'biblePlan.today' => '今日读经',
			'biblePlan.todayDone' => '今日读经已完成，真棒！',
			'biblePlan.read' => '阅读',
			'biblePlan.behind' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n, other: '落后 ${n} 天', ), 
			'biblePlan.catchUp' => '点这里查看要补读的章节。',
			'biblePlan.chaptersRead' => ({required Object read, required Object total}) => '已读 ${read} / ${total} 章',
			'biblePlan.late' => '落后',
			'biblePlan.upcoming' => '接下来',
			'biblePlan.dayNumber' => ({required Object n}) => '第 ${n} 天',
			'biblePlan.finished' => '计划完成！你全部读完了。',
			'biblePlan.stop' => '停止计划',
			'biblePlan.stopTitle' => '停止这个计划？',
			'biblePlan.stopText' => '你在此计划中的进度将被清除。已计入汇报的章节仍会保留。',
			'biblePlan.reminderTitle' => '你的今日读经',
			'biblePlan.reminderChannel' => '读经计划',
			'biblePlan.homeTitle' => '今日读经',
			'biblePlan.check' => ({required Object chapter}) => '将${chapter}标为已读',
			'biblePlan.uncheck' => ({required Object chapter}) => '${chapter}：已读',
			'teachings.title' => '教导',
			'teachings.subtitle' => '随时随地聆听圣言',
			'teachings.search' => '搜索信息或讲员…',
			'teachings.all' => '全部',
			'teachings.downloadedChip' => '已下载',
			'teachings.count' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n, one: '${n} 篇信息', other: '${n} 篇信息', ), 
			'teachings.empty' => '暂时还没有教导。',
			'teachings.none' => '没有符合的教导。',
			'teachings.noneDownloaded' => '还没有下载信息。点信息旁的云朵，即可离线收听。',
			'teachings.more' => '查看更多',
			'teachings.offline' => '没有网络：这是保存在手机上的信息。',
			'teachings.play' => '收听',
			'teachings.pause' => '暂停',
			'teachings.heard' => '已听完',
			'teachings.download' => '下载以便离线收听',
			'teachings.downloaded' => '已保存到手机',
			'teachings.removed' => '已从手机移除',
			'teachings.cancelDownload' => '停止下载',
			'teachings.removeDownload' => '从手机移除',
			'teachings.back15' => '后退 15 秒',
			'teachings.forward15' => '前进 15 秒',
			'teachings.speed' => ({required Object speed}) => '速度 ${speed}',
			'teachings.recordedOn' => ({required Object date}) => '${date} 的信息',
			'teachings.moreSubtitle' => '可收听的讲道与教导',
			'memorize.title' => '背经',
			'memorize.subtitle' => '将神的话藏在心里',
			'memorize.toReview' => '待复习',
			'memorize.learning' => '学习中',
			'memorize.known' => '已熟记',
			'memorize.reviewCount' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n, one: '复习 ${n} 节经文', other: '复习 ${n} 节经文', ), 
			'memorize.nothingDue' => '今天没有要复习的。',
			'memorize.nextOn' => ({required Object date}) => '下次复习：${date}。',
			'memorize.tomorrow' => '明天',
			'memorize.reminder' => '复习提醒',
			'memorize.reminderAt' => '提醒时间',
			'memorize.myVerses' => '我的经文',
			'memorize.howToAdd' => '添加方法：在圣经中点一节经文，再点工具栏里的大脑图标。',
			'memorize.empty' => '还没有要背的经文。',
			'memorize.openBible' => '打开圣经',
			'memorize.late' => '已逾期',
			'memorize.today' => '今天',
			'memorize.dueIn' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n, one: '${n} 天后', other: '${n} 天后', ), 
			'memorize.stages.fresh' => '新',
			'memorize.stages.learning' => '学习中',
			'memorize.stages.known' => '已熟记',
			'memorize.stats' => ({required Object stage, required Object lapses}) => '${stage} · 忘记 ${lapses} 次',
			'memorize.reviewNow' => '现在复习',
			'memorize.remove' => '移除',
			'memorize.removeTitle' => '移除这节经文？',
			'memorize.removeText' => '它的进度将被清除。',
			'memorize.removed' => '经文已移除',
			'memorize.progress' => ({required Object done, required Object total}) => '${done} / ${total}',
			'memorize.show' => '显示经文',
			'memorize.hints.full' => '全文',
			'memorize.hints.gaps' => '填空',
			'memorize.hints.initials' => '首字',
			'memorize.hints.none' => '无提示',
			'memorize.recite' => '先背诵经文，再核对。',
			'memorize.grades.again' => '再来',
			'memorize.grades.hard' => '困难',
			'memorize.grades.good' => '良好',
			'memorize.grades.easy' => '容易',
			'memorize.now' => '马上',
			'memorize.later' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n, one: '${n} 天', other: '${n} 天', ), 
			'memorize.doneTitle' => '复习完成！',
			'memorize.doneText' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n, one: '你复习了 ${n} 节经文。愿主的道住在你心里！', other: '你复习了 ${n} 节经文。愿主的道住在你心里！', ), 
			'memorize.back' => '返回',
			'memorize.reminderTitle' => '你要复习的经文',
			'memorize.reminderBody' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n, one: '今天有 ${n} 节经文等你复习。', other: '今天有 ${n} 节经文等你复习。', ), 
			'memorize.reminderChannel' => '背经',
			'memorize.homeTitle' => '待复习经文',
			'memorize.homeText' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n, one: '${n} 节经文等你', other: '${n} 节经文等你', ), 
			'memorize.menu' => '背诵经文',
			'memorize.memorize' => '背诵',
			'memorize.added' => '已加入背经列表',
			'memorize.already' => '这段经文已在你的列表中',
			'souls.title' => '灵魂跟进',
			'souls.subtitle' => '「有智慧的必能得人。」箴言 11:30',
			'souls.search' => '搜索某人…',
			'souls.people' => '人数',
			'souls.received' => '已接受耶稣',
			'souls.toContact' => '待联系',
			'souls.all' => '全部',
			'souls.stages.met' => '已结识',
			'souls.stages.interested' => '有兴趣',
			'souls.stages.received' => '已接受耶稣',
			'souls.stages.followUp' => '坚固中',
			'souls.stages.church' => '来教会',
			'souls.stages.baptized' => '已受洗',
			'souls.contactSection' => '待再次联系',
			'souls.everyone' => '所有人',
			'souls.contactToday' => '今天联系',
			'souls.contactLate' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n, one: '逾期 ${n} 天', other: '逾期 ${n} 天', ), 
			'souls.contactOn' => ({required Object date}) => '下次联系：${date}',
			'souls.empty' => '在这里记下你传福音的对象：为他们祷告，陪伴他们走进教会。',
			'souls.none' => '没有符合的人。',
			'souls.add' => '添加',
			'souls.addTitle' => '新增人员',
			'souls.editTitle' => '编辑',
			'souls.name' => '姓名',
			'souls.nameRequired' => '请填写姓名。',
			'souls.phone' => '电话',
			'souls.place' => '在哪里认识',
			'souls.metOn' => '认识日期',
			'souls.stage' => '此人目前的状况？',
			'souls.firstNote' => '备注（可选）',
			'souls.noteHint' => '谈话内容、代祷事项…',
			'souls.save' => '保存',
			'souls.saved' => '已保存',
			'souls.call' => '打电话',
			_ => null,
		} ?? switch (path) {
			'souls.whatsApp' => 'WhatsApp',
			'souls.sms' => '短信',
			'souls.edit' => '编辑',
			'souls.delete' => '删除',
			'souls.deleteTitle' => ({required Object name}) => '删除 ${name}？',
			'souls.deleteText' => '相关备注将从手机中删除。',
			'souls.deleted' => '已删除',
			'souls.nextContact' => '下次联系',
			'souls.plan' => '设置提醒',
			'souls.change' => '更改日期',
			'souls.clear' => '取消提醒',
			'souls.noContact' => '没有提醒',
			'souls.metAt' => ({required Object date}) => '${date} 认识',
			'souls.notes' => '备注',
			'souls.addNote' => '添加备注',
			'souls.noNotes' => '还没有备注。',
			'souls.deleteNote' => '删除备注',
			'souls.export' => '导出（表格）',
			'souls.csv.name' => '姓名',
			'souls.csv.phone' => '电话',
			'souls.csv.place' => '地点',
			'souls.csv.metOn' => '认识日期',
			'souls.csv.stage' => '阶段',
			'souls.csv.next' => '下次联系',
			'souls.csv.notes' => '备注',
			'souls.lock' => ({required Object method}) => '使用${method}锁定',
			'souls.lockedTitle' => '灵魂跟进已锁定',
			'souls.unlock' => '解锁',
			'souls.unlockReason' => '打开灵魂跟进',
			'souls.privacy' => '这些信息只保存在你的手机上，绝不会上传。',
			'souls.reminderTitle' => '灵魂跟进',
			'souls.reminderBody' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n, one: '今天要联系 ${n} 人。', other: '今天要联系 ${n} 人。', ), 
			'souls.reminderChannel' => '灵魂跟进',
			'souls.moreSubtitle' => '你传福音的对象',
			'souls.prayToday' => '今天为他代祷',
			'souls.prayerReminder' => '每天早上提醒我',
			'souls.prayerReminderAt' => '代祷提醒时间',
			'souls.prayerTitle' => '为一个灵魂代祷',
			'souls.prayerBody' => '花点时间为今天的这个人祷告。',
			'souls.prayerChannel' => '为灵魂代祷',
			'fasts.title' => '我的禁食',
			'fasts.intro' => '为神分别出来：选择你的禁食和代祷事项。每坚持一天都会计入你的报告。',
			'fasts.moreSubtitle' => '完全或部分禁食，每天计入',
			'fasts.kind' => '你的禁食',
			'fasts.kinds.full' => '完全禁食',
			'fasts.kinds.partial' => '部分禁食',
			'fasts.kindTexts.full' => '昼夜不食，每天 24 小时，从现在开始。',
			'fasts.kindTexts.partial' => '每天禁食到所选时间，然后开斋。',
			'fasts.length' => '时长',
			'fasts.days' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n, one: '${n} 天', other: '${n} 天', ), 
			'fasts.endEachDay' => '每天结束禁食的时间',
			'fasts.topics' => '我为此禁食',
			'fasts.topicHint' => '一个代祷事项…',
			'fasts.addTopic' => '添加事项',
			'fasts.removeTopic' => '移除事项',
			'fasts.history' => '最近的禁食',
			'fasts.kept' => ({required Object kept, required Object days}) => '${kept}/${days} 天',
			'fasts.start' => '开始禁食',
			'fasts.until' => ({required Object date}) => '直到 ${date}',
			'fasts.hoursLeft' => ({required Object h, required Object m}) => '${h} 小时 ${m}',
			'fasts.minutesLeft' => ({required Object m}) => '${m} 分钟',
			'fasts.dayOf' => ({required Object day, required Object total}) => '第 ${day} 天，共 ${total} 天',
			'fasts.dayEnds' => ({required Object time}) => '今天的禁食在 ${time} 结束',
			'fasts.stop' => '结束禁食',
			'fasts.stopTitle' => '要结束禁食吗？',
			'fasts.stopText' => '已完成的天数仍计入，进行中的这一天不计。',
			'fasts.counted' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('zh'))(n, one: '已有 ${n} 天禁食计入报告', other: '已有 ${n} 天禁食计入报告', ), 
			'fasts.reportNote' => ({required Object item}) => '每坚持一天，报告中的“${item}”加 1。',
			'fasts.items.full' => '完全禁食',
			'fasts.items.partial' => '部分禁食',
			'fasts.dayTitle' => ({required Object day}) => '禁食第 ${day} 天完成',
			'fasts.dayBody' => '已计入报告。加油，继续！',
			'fasts.endTitle' => '你的禁食结束了',
			'fasts.endBody' => '愿主垂听你的祷告。',
			'fasts.channel' => '我的禁食',
			'fasts.homeTitle' => ({required Object day, required Object total}) => '禁食 · 第 ${day}/${total} 天',
			'fasts.homeText' => ({required Object time}) => '今天在 ${time} 结束',
			_ => null,
		};
	}
}
