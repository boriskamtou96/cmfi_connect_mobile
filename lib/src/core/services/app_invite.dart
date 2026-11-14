import '../config/app_config.dart';
import '../i18n/strings.g.dart';

/// The site of the app, as written on a shared image ("cmfi-connect.com").
final appSiteName = Uri.parse(AppConfig.siteUrl).host;

/// « Télécharge l'app CMFI Connect : https://cmfi-connect.com »: the last
/// line of everything shared with others (14/11/2026: a verse, words of a
/// hymn, an event, a story…), so whoever receives it can get the app. The
/// site offers the stores.
String appInvite(Translations t) => t.app.shareInvite(url: AppConfig.siteUrl);

/// [text], then a blank line and [appInvite].
String withAppInvite(Translations t, String text) =>
    '${text.trimRight()}\n\n${appInvite(t)}';
