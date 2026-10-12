# CMFI Connect : règles du projet Flutter

App mobile de la communauté CMFI : comptes rendus quotidiens d'abord, puis cantiques, prière, évènements… Elle consomme l'API Go `cmfi-connect` (`/Users/hardpro/GolandProjects/cmfi-connect`).
Flutter 3.38 / Dart 3.10.

## Façon de travailler

- Toujours poser des questions dès qu'une demande n'est pas claire ou laisse un choix qui revient à l'utilisateur (comportement attendu, portée, texte, compromis UX, paquet à ajouter…) : demander avant de coder plutôt que deviner. Proposer une réponse recommandée avec la question.

## Commandes

```bash
flutter run --flavor dev                     # API locale (émulateur Android : 10.0.2.2, simulateur iOS : localhost)
flutter run --flavor dev --dart-define=API_BASE_URL=http://<IP du Mac>:8080/v1   # vrai téléphone
flutter run --flavor prod --release
dart run build_runner watch --force-jit      # génération de code (le mode AOT échoue sur ce projet)
flutter analyze && flutter test              # obligatoires avant de considérer une tâche finie
```

- Relancer la génération après toute modification de `@riverpod`, `@freezed`, `@RoutePage` ou d'un fichier `.i18n.json`.
- Logo, icônes et splash : `CmfiLogoPainter` (`core/widgets/cmfi_logo.dart`) est la seule source. C'est l'emblème redessiné du logo de la communauté, sans ses lettres : le « C » autour du globe, la croix sur la Bible ouverte, la colombe (détails retirés sous 40 px ; `CmfiLogo.onDark` le pose sur un disque blanc). Le même dessin existe en SVG dans l'export PDF (`report_files.dart`), le site admin (`Logo.tsx`), le site vitrine (`Logo.astro`, favicons) et, en silhouette, dans l'icône des notifications (`ic_notification.xml`) : les garder identiques. Après une modification du logo :
  `flutter test tool/brand_assets_test.dart` (régénère `assets/brand/*.png`), puis
  `dart run flutter_launcher_icons -f flutter_launcher_icons-dev.yaml`, idem pour `-prod.yaml`, puis `dart run flutter_native_splash:create`.
- Ne jamais modifier à la main `*.g.dart`, `*.freezed.dart`, `*.gr.dart`.

## Architecture

```
lib/
├── main.dart, bootstrap.dart, app.dart   point d'entrée, init, MaterialApp.router
└── src/
    ├── core/      config, network, session, storage, theme, i18n, widgets, utils
    ├── routing/   app_router.dart (+ guards) : seule couche qui assemble les features
    └── features/<feature>/
        ├── domain/          modèles freezed, Dart pur (ni Flutter, ni dio)
        ├── infrastructure/  <feature>_api.dart (HTTP), DTO, repository si utile
        ├── application/     notifiers Riverpod (état des écrans)
        └── presentation/    écrans (*_screen.dart) et widgets
```

Features actuelles : `onboarding` (splash, présentation, bienvenue), `auth` (connexion, inscription), `profile` (église, profil),
`shell` (les 5 onglets), `home`, `reports` (compte rendu, éléments), `authorities` (autorités spirituelles), `hymns` (cantiques), `events` (évènements de la communauté), `prayer` (retraites, sujets, listes, importunité), `more`, `members` (pseudo, compte), `admin`.

Règles de dépendance :
- `core` n'importe jamais une feature ni `routing`.
- Une feature n'importe pas une autre feature : ce qui est partagé va dans `core`.
  Exception : `home` (tableau de bord) et `more` (menu « Plus ») lisent les providers `application` des autres features (jamais l'inverse).
- Pour ouvrir l'écran d'une autre feature, passer par les routes de `routing/app_router.dart`.
- `presentation` lit `application`, qui appelle `infrastructure`. `domain` ne dépend de rien.
- Imports relatifs dans `lib/` (`prefer_relative_imports`).

## État : Riverpod 3 avec génération de code

- Toujours `@riverpod` / `@Riverpod(keepAlive: true)`. `keepAlive` seulement pour les services globaux (Dio, session, router, préférences)
  et les petits états partagés entre onglets (`SelectedReportsView`, `SelectedReportDay`).
- Une saisie non enregistrée ne doit pas se perdre en changeant d'onglet : voir `DayReportController` (`ref.keepAlive()` tant que la journée a des modifications, relâché après l'enregistrement).
- Chargement et erreurs passent par `AsyncValue` (`AsyncNotifier` + `AsyncValue.guard`). Pas d'états `initial/loading/error` écrits à la main, pas de `dartz`/`Either`.
- `ref.watch` dans `build`, `ref.read` dans les callbacks. Après un `await` dans un notifier, vérifier `ref.mounted` avant d'écrire `state`.
- Écrans : `HookConsumerWidget` s'il y a un état local (controllers, booléens), sinon `ConsumerWidget`. Pas de `StatefulWidget` pour un `TextEditingController` : utiliser `useTextEditingController`.
- Afficher un `AsyncValue` avec un `switch` (`AsyncData` / `AsyncError` / chargement) et `ErrorView` pour les erreurs.

## Réseau

- Un seul client : `dioProvider`. Ne jamais créer de `Dio`.
- Une classe API par feature (`infrastructure/<feature>_api.dart`). Chaque appel est enveloppé dans `apiCall(...)` et renvoie un modèle typé, jamais `dynamic` ni `Map`.
- Le backend enveloppe les succès dans `{"status", "content"}` : lire `response.content`. Les erreurs arrivent sous la forme `{"status", "code", "message"}`.
- Les erreurs remontent en `AppException` (`NetworkException`, `UnauthorizedException`, `ApiException(code)`, `UnknownException`). L'UI affiche `userMessageFor(error, t)`, jamais le `message` du serveur (en anglais).
- Raisonner sur le `code` de l'API (`CONFLICT`, `NOT_FOUND`, `INVALID_CREDENTIALS`...), pas sur le texte.
- JSON en snake_case automatique (`build.yaml`). Exception connue : `accessToken` au login (`@JsonKey`).
- Dates vers l'API : `date.toApiDate()` (`YYYY-MM-DD`). Durées : minutes en `int`, affichées avec `toDurationLabel()`.
- Un repository seulement s'il apporte quelque chose (cache, combinaison de sources, conversion DTO vers domaine). Sinon le notifier appelle l'API directement.

## Session et navigation

- auto_route : écran `XxxScreen` annoté `@RoutePage()`, route générée `XxxRoute`, déclarée dans `src/routing/app_router.dart`.
- Démarrage : `SplashScreen` lit la session et le drapeau « présentation vue », puis `replaceAll` vers `OnboardingRoute`, `WelcomeRoute` ou `AppShellRoute`, et retire le splash natif.
- Navigation explicite après une action réussie : connexion → `replaceAll([AppShellRoute()])`, inscription → `ChurchFormRoute` → `AppShellRoute`. Le controller renvoie un `bool` (succès), l'écran navigue.
- Déconnexion et 401 : on change seulement `sessionProvider` ; `App` écoute la session et renvoie vers `WelcomeRoute`. Ne pas naviguer à la main dans ces cas.
- Les routes qui demandent un compte ont `guards: [authGuard]` (filet de sécurité : sans session, retour à l'accueil).
- Les onglets (`AppShellScreen`) sont un `AutoTabsRouter` ; depuis un onglet, `context.navigateTo(const ReportsRoute())` change d'onglet.
- Le token reste dans `TokenStorage` (secure storage), jamais dans shared_preferences ni dans les logs. shared_preferences ne sert qu'aux petits réglages (`core/storage/preferences.dart`).

## Textes et langues (slang)

- 7 langues : français (base), anglais, allemand, espagnol, arabe (de droite à gauche), chinois simplifié et hindi (`lib/src/core/i18n/<code>.i18n.json`). L'app suit la langue du téléphone ; Plus › Langue la change (`SavedLanguage`).
- Aucun texte visible écrit en dur : ajouter la clé dans **les 7 fichiers** (`fr` d'abord), puis `final t = context.t;`. `test/core/i18n_test.dart` échoue s'il manque une clé dans une langue. Une langue absente retomberait sinon sur le français sans prévenir.
- Le nom de l'app est « CMFI Connect » dans toutes les langues (le nom international, `t.app.name`), sous l'icône aussi. La communauté elle-même se dit « la CMCI » en français (Communauté Missionnaire Chrétienne Internationale) et CMFI dans les autres langues, si un texte la cite.
- En français, l'app tutoie l'utilisateur. Garder ce ton partout (du, tú, تَ, 你, तुम).
- Pluriels : `"cle(plural, param=n)"` avec les formes de chaque langue (`one`/`other` ; arabe `zero`, `one`, `two`, `few`, `many`, `other` ; chinois `other` seul ; `zero` pour une phrase spéciale à 0). Un nombre dans une phrase passe par un pluriel, même s'il vaut toujours plus de 1 en français (l'arabe accorde jusqu'à 100). Règles du hindi et du chinois, et chiffres 0-9 pour les dates arabes : `setUpLanguages()` (`core/i18n/languages.dart`), appelé dans `bootstrap` et dans les tests.
- Droite à gauche (arabe) : jamais `left`/`right` pour un écart ou une position qui suit le sens de lecture. Utiliser `EdgeInsetsDirectional.fromSTEB`/`only(start:)`, `AlignmentDirectional.centerStart`, `PositionedDirectional(end:)`, `BorderDirectional(start:)`. Les icônes Phosphor se retournent toutes seules (`matchTextDirection`). Restent physiques : les décors (anneaux, dégradés) et le PDF (paquet `pdf`, `pw.EdgeInsets`).
- Contenus saisis (titre, thème, verset, actualité, présentation d'un évènement) : `textDirection: contentDirection(texte)` (`core/utils/text_direction.dart`), pour qu'un texte français garde son sens dans l'app en arabe. Les paroles des cantiques (recueils français et anglais) sont toujours de gauche à droite (`HymnView`).
- Polices : Onest et Lora n'ont ni l'arabe, ni le devanagari, ni le chinois ; le téléphone prend ses polices système pour ces lettres. L'export PDF n'embarque qu'Onest : en arabe, chinois et hindi, les libellés du PDF ne s'affichent pas encore (il faudra embarquer des polices Noto).
- Les éléments standards du compte rendu (« Lecture biblique »…) viennent du serveur, en français : ils ne sont pas encore traduits.

## UI et design

- Maquettes : https://claude.ai/artifact/FAQyACNpAHMfJUnxjeveGg (identité, onboarding, compte, onglets, compte rendu).
- Police : Onest (400 à 800), fichiers statiques dans `assets/fonts`. Un `textStyle` posé sur un bouton (`styleFrom(textStyle: …)`) remplace celui du thème : y remettre `fontFamily: AppTheme.fontFamily`.
- Couleurs : `Theme.of(context).colorScheme` en priorité. Ce qui change entre clair et sombre sans être dans le `colorScheme` est dans `AppTones` (`core/theme/app_tones.dart`, une `ThemeExtension`) : `AppTones.of(context).personal/personalSoft` (éléments personnels), `missing/missingDash` (jours sans compte rendu), `disabled` (jours à venir), et la couleur de chaque module, `AppModule.hymns.tone(context)` → `color` (aplat, contenu blanc dessus), `soft` (fond teinté), `onSoft` (icône ou texte sur `soft` ou sur une carte). `AppColors` ne garde que ce qui est identique dans les deux modes (bleu CMFI `primary` des cartes bleues, bleu nuit `primaryDeep` du splash, or `gold` pour les petites victoires) et les valeurs du thème clair : jamais de `AppColors.surface`/`ink`/`muted` ni de `Colors.white` comme fond dans un écran.
- Icônes : toujours `AppIcons` (`core/theme/app_icons.dart`, paquet Phosphor), jamais `Icons.*` ni `PhosphorIconsRegular`/`PhosphorIconsFill` dans un écran (ni d'import de `phosphor_flutter` : `app_icons.dart` exporte `PhosphorIcon`) : changer de jeu d'icônes ne touche que ce fichier. Regular dans l'interface, Fill pour un état actif (onglet choisi, favori, coché : `AppIcons.homeActive`, `starFilled`), Duotone pour l'icône d'un module sur une tuile teintée (cartes de l'accueil, Plus, `ComingSoonView`, états vides) : `PhosphorIcon(AppIcons.hymnsTile, color: tone.onSoft)`. Une icône qui manque s'ajoute dans `AppIcons`, nommée d'après son rôle dans l'app (`reminder`, `goal`), pas d'après le dessin.
- Thème : Automatique (comme le téléphone, par défaut), Clair ou Sombre, choisi dans Plus › Apparence (`savedThemeModeProvider`, clé `theme_mode`) ; le changement est animé (`themeAnimationStyle`). La barre d'état suit le thème de l'app (`AnnotatedRegion` dans `App.builder`) ; un écran au fond bleu nuit pose la sienne (`SystemUiOverlayStyle.light`, splash et bienvenue).
- Espacements et rayons : `AppSpacing`, `AppRadius`. Pas de valeurs en dur.
- Réutiliser `core/widgets` avant d'en créer un : `AppButton`, `ErrorView`, `InlineError`, `LabeledField`, `PhoneField`, `PasswordField`, `SectionCard`, `SectionLabel`, `StatusPill`, `CodeChip`, `SegmentedTabs`, `TabPage`, `SubPage` (avec `actions`), `MediaPicture`, `ComingSoonView`, `DashedOutline`, `CmfiLogo`, `BrandRing`, `FadeSlideIn`, `RollingText`, `AnimatedProgressBar`. Un widget partagé par plusieurs features va dans `core/widgets`.
- Messages : erreurs et confirmations en popup en haut de l'écran (toastification), jamais en SnackBar : `final toast = ref.read(toasterProvider).of(context);` avant un `await`, puis `toast.error(userMessageFor(error, t))`, `toast.success(…)` ou `toast.info(…)`. Une erreur d'envoi de formulaire passe par `ref.listen(controllerProvider, …)` sur `AsyncError`. `InlineError` ne sert plus qu'aux indications qui restent affichées (ex. « choisis au moins une mesure »), `ErrorView` aux chargements ratés (avec « Réessayer »). Dans les tests, `app.toasts.messages` / `app.toasts.errors` (`FakeToaster`).
- flutter_animate pour les animations simples (`FadeSlideIn`, l'icône des popups) : un décalage passe par le `delay` d'un effet (`fadeIn(delay: …)`), pas par `Animate.delay` qui pose un minuteur.
- Animations : durées et courbes de `AppMotion` (`core/theme/app_motion.dart` : `fast` 180 ms, `medium` 260 ms, `slow` 380 ms, `standard`, `emphasized`), courtes, jamais infinies (les tests font `pumpAndSettle`). Toujours `AppMotion.of(context, …)` / `AppMotion.reduced(context)` : avec « réduire les animations », l'état final s'affiche directement.
- Entrées en cascade : `FadeSlideIn(index: n)` (une seule fois par élément, pas à chaque rebuild). Compteurs : `RollingText` ; barres : `AnimatedProgressBar`. Un `AnimatedSwitcher` a pour clé la valeur affichée, pour ne pas rejouer à chaque rebuild Riverpod.
- Transitions de pages : les pages poussées gardent la transition de la plateforme (retour par balayage sur iOS). Les parcours racine atteints par `replaceAll` (splash, présentation, accueil, app, église après inscription) passent par `FadeThroughRoute` (`routing/fade_through_route.dart`, `CustomRoute(customRouteBuilder: …)`) : fondu enchaîné avec léger zoom.
- Transitions de contenus (`core/widgets/motion.dart`, paquet `animations`, motifs Material) :
  - `SharedAxisSwitcher(index:)` : contenus côte à côte (onglets segmentés Aujourd'hui / Historique / Bilan, Tous / Favoris / Récents) ; le nouveau arrive du côté de l'onglet touché. Dans une liste qui défile (fiche d'un évènement), `expand: false` : il prend la hauteur de son contenu ;
  - `FadeThroughSwitcher(id:)` : contenus sans lien spatial (la liste des cantiques qui devient des résultats de recherche) ;
  - `OpenPage` (container transform) : un bouton qui ouvre un formulaire de création grandit en page, et la page s'y referme (Ajouter une autorité, Créer un élément). Pas pour une page atteinte depuis une liste (cantique, autorités, export…) : elle garde la transition de la plateforme et le retour par balayage iOS, qu'un container transform supprime ;
  - `showAppDialog` au lieu de `showDialog` : fondu avec léger zoom.
  - Les onglets du bas gardent leur fondu avec zoom maison : le routeur d'onglets masque l'ancien onglet d'un coup, le fondu enchaîné du paquet laisserait un écran vide ~100 ms. `FadeThroughRoute` reste aussi maison : même rendu que le paquet, plus le décalage iOS de la page dessous.
- Dates affichées : `context.formatDate(date, 'EEEE d MMMM').capitalized` (langue de l'app). Unités des éléments : `MeasureFormat` (« Nombre de fois » → « fois », « Pourcentage » → « % »).
- Zones tactiles d'au moins 48 dp, `tooltip` ou `Semantics` sur les boutons-icônes, et un rendu correct en thème sombre.
- Pas de hauteur fixe sur un bloc qui contient du texte (`minHeight` plutôt) : les grandes tailles de police ne doivent rien couper.

## Cantiques

- Les recueils marchent hors ligne. `assets/hymns/<code>.json` contient une copie de chaque recueil livrée avec l'app, au format de `GET /v1/hymns/books/:code`, avec un `index.json` qui donne la liste et l'ordre des recueils.
- Au lancement, `HymnLibrary` affiche la copie du téléphone (la livrée, ou la téléchargée si elle est plus récente), puis demande au serveur les versions, au plus toutes les 6 h ou sur « tirer pour actualiser ». Seuls les recueils dont la version a changé sont téléchargés (`If-None-Match`, réponse 304 sinon), et ils sont gardés avec `path_provider`.
- Rafraîchir les recueils livrés après un import côté serveur :
  ```bash
  TOKEN=…   # accessToken de POST /v1/users/login
  for code in $(jq -r '.[]' assets/hymns/index.json); do
    curl -s -H "Authorization: Bearer $TOKEN" http://localhost:8080/v1/hymns/books/$code | jq -c .content > assets/hymns/$code.json
  done
  ```
- Favoris, récents, recueil choisi et réglages de lecture (taille, police Auto/Moderne/Classique, fond Auto/Clair/Sépia/Sombre, refrain répété, écran allumé) restent sur le téléphone (shared_preferences), pas encore sur le compte.
- La police de lecture « Classique » est Lora (OFL, `assets/fonts`). En Auto, elle prend le relais à partir de 130 % : un grand texte se lit mieux avec empattements.
- L'écran reste allumé via `screenAwakeProvider` (wakelock_plus). Dans les tests, il est remplacé par `FakeScreenAwake`.
- Le mode projection affiche une strophe à la fois, à la plus grande taille qui tient. Le refrain y revient toujours après chaque couplet.

## Compte rendu : hors ligne, objectifs, rappel, export

- Hors ligne : `ReportsLocalStore` (shared_preferences) garde les éléments, les 31 derniers jours ouverts et les journées enregistrées sans réseau. Sans réseau, `DayReportController` montre la copie du téléphone (ou un formulaire vide) et `save()` répond `SaveOutcome.keptOffline` : la journée attend dans `PendingReports`, qui l'envoie au retour du réseau (`networkStatusProvider`, connectivity_plus), au retour dans l'app et après un enregistrement réussi. Une `ApiException` (refus définitif) retire la journée de la file. `reportHistory` y ajoute les journées en attente et réutilise la dernière réponse du serveur sans réseau (`lastHistoryProvider`). À la déconnexion, `App` vide tout ça et annule les rappels.
- Objectifs par jour et par élément : `ReportGoals` (clé `report_goals`, sur le téléphone), réglés dans Mes éléments avec la feuille de saisie (`showEntrySheet(caption:, clearLabel:)`). Progression dans Aujourd'hui (`EntryRow(goal:)`), jours atteints dans le Bilan et l'export.
- Série : `currentStreak` (`domain/report_streak.dart`) ; aujourd'hui pas encore rempli ne la casse pas. Affichée sur l'accueil à partir de 2 jours.
- Rappel du soir : `ReportReminder` (clés `reminder_enabled`, `reminder_time` en minutes, `reminder_offered`). Proposé une fois après la première journée enregistrée, réglable dans Plus. Les 14 prochains soirs sont planifiés d'un coup (`localNotificationsProvider`, flutter_local_notifications, mode inexact : pas de permission d'alarme exacte) et replanifiés au lancement, au changement de jour et après chaque enregistrement : un jour rempli ne sonne pas. Un tap ouvre Aujourd'hui (`SignedInTasks`, qui enveloppe l'app connectée). Icône Android : `res/drawable/ic_notification.xml` (gardée par `res/raw/keep.xml`).
- Export (Plus › Exporter, ou l'icône de partage de l'onglet sur Historique et Bilan) : `ReportExport.build` puis `reportAsPdf` (A4, police Onest, paquet `pdf`), `reportAsCsv` (une ligne par jour, `;` en français, BOM UTF-8 pour Excel) ou `reportAsText` (pour WhatsApp). Le Bilan a aussi « Partager ce bilan ». Le partage passe par `shareServiceProvider` (share_plus), avec `origin` pour l'iPad.
- Dans les tests : `FakeLocalNotifications`, `FakeShareService`, `FakeNetworkStatus` ; `FakeReportsApi.offline` / `FakeActivitiesApi.offline` simulent la perte de réseau. `pumpApp` marque le rappel comme déjà proposé (`reminderOffered: false` pour le tester).

## Pseudo, rôles et autorités liées

- Chaque membre a un pseudo unique (`Account.username`) : 3 à 30 caractères, a-z, 0-9, « . » et « _ » (`UsernameRules`, mêmes règles que `internal/usernames` côté serveur). À l'inscription, `UsernameField` propose des pseudos libres tirés du nom (`GET /v1/usernames/availability`), se remplit avec le premier tant que l'utilisateur n'en tape pas un, et vérifie la disponibilité 400 ms après la frappe. Modifiable dans « Modifier mon profil » (`PUT /v1/users/me/username`).
- `myAccountProvider` (`GET /v1/users/me`) donne le pseudo et le rôle à jour : `user`, `admin` ou `superadmin` (`Account.isAdmin`, `isSuperadmin`). Les admins voient Plus › Administration › Équipe et rôles ; seul un superadmin donne un rôle (`AdminApi.setRole`). Le premier superadmin se nomme côté serveur : `make promote PHONE=+237…`.
- Une autorité s'ajoute par pseudo (`GET /v1/users/by-username/:username` : nom, église, assemblée, jamais téléphone ni e-mail) : elle est « En attente » jusqu'à ce que la personne accepte dans Mes autorités › Demandes reçues ; ses coordonnées arrivent alors. Pseudo introuvable : invitation à partager. Sinon, saisie à la main comme avant.
- Suppression du compte (exigée par l'App Store et Google Play) : Plus › « Supprimer mon compte », sous « Se déconnecter » (`DeleteAccountScreen`, route `/account/delete`). Le membre redonne son mot de passe ; `MyAccount.deleteAccount` appelle `DELETE /v1/users/me` puis déconnecte, et `App` revient à l'accueil en vidant les données du téléphone. Mauvais mot de passe : 401 `INVALID_CREDENTIALS`, message sous le champ (l'écran défile jusqu'à lui). Le dernier superadmin est refusé : 409 `LAST_SUPERADMIN`. Le site (page « Supprimer un compte ») et la FAQ décrivent ce chemin : les garder d'accord si l'entrée bouge.
- Dans les tests : `FakeMembersApi` (compte `sampleAccount`, membres `sampleMembers` ; `password` et `lastSuperadmin` pour la suppression, `deletions` la trace), `FakeAdminApi`. Le champ pseudo attend : `pump()` puis `pump(500 ms)` avant de lire sa réponse. Pour taper « Se déconnecter » ou « Supprimer mon compte », `scrollToEnd(tester)`.

## Évènements

- Un seul module pour les évènements de toute la communauté et leurs actualités (`/v1/events`). Pas d'onglet : Plus › Communauté › Évènements et la carte « Prochain évènement » de l'accueil (`nextEventProvider`). Les évènements par assemblée locale viendront plus tard (fonction premium).
- `CommunityEvent` (`domain/event.dart`) : les listes ne remplissent que le haut (titre, dates, lieu, affiche, `registration`) ; `GET /v1/events/:id` donne tout (programme, actualités, photos, `myRegistration`, autres éditions). `EventDetail(id)` montre l'évènement, `replace(event)` affiche ce que le serveur renvoie après une inscription ou une action d'admin (listes et rappels suivent).
- Heures : affichées à l'heure du lieu (`event.timeZone`, `Africa/Douala` par défaut) avec `date.inZone(zone)` (`core/utils/zoned_time.dart`) ; « heure de Yaoundé » s'ajoute quand le téléphone est sur un autre fuseau. Une heure saisie par un admin devient un instant avec `instantAt(zone, wall)`, envoyé en UTC (`UtcInstantConverter`).
- Images du serveur (`/v1/media/…`) : `MediaPicture` (`core/widgets/media_picture.dart`, couleur moyenne puis fondu) via `mediaImagesProvider` (cached_network_image, gardées sur le téléphone). Affiche entière : `PosterBackdrop` (l'affiche sur une copie floutée, rien n'est coupé) ; plein écran avec zoom : `showImageViewer`. Une affiche se fait en portrait 4:5 (1080 × 1350).
- Inscription courte (`showRegistrationSheet`) : combien de personnes, hébergement et ville de départ seulement si l'évènement les demande. Rappels la veille à 19 h et 1 h avant (`EventReminders`, groupe `NotificationGroup.events`, séparé du rappel du soir) ; un tap ouvre l'évènement. Hors ligne : `EventsLocalStore` garde les listes et les 10 derniers évènements ouverts.
- Admins (rôle `admin`/`superadmin`) : Plus › Administration › Évènements, et le menu « ⋮ » de la fiche (modifier, programme, inscrits + CSV, actualité, photos, préparer l'édition suivante, supprimer). `EventAdmin` fait les appels ; une image se choisit avec `imagePickingProvider` (2048 px, JPEG) puis s'envoie avec `EventAdmin.upload`.
- Calendrier, cartes et téléphone : `calendarServiceProvider` (add_2_calendar), `linkLauncherProvider` (url_launcher). Dans les tests : `FakeEventsApi` (`sampleEvents()`), `FakeMediaImages`, `FakeCalendarService`, `FakeLinkLauncher`, `FakeImagePicking` ; `app.notifications.plannedEvents`. Dans une page qui défile sous une barre fixe, `scrollUntilVisible` puis `ensureVisible` avant de toucher.
- Démo côté serveur : `make demo-events` (`cmd/demo-events`, affiches dans `data/demo`).

## Prière

- Onglet Prière (`features/prayer`) : la retraite du moment, les invitations et sujets d'importunité, les sujets de la communauté et les listes de l'utilisateur. Couleur du module : `AppModule.prayer` ; chaque retraite a ses couleurs (`RetreatMomentLook` : aube, midi, crépuscule, nuit).
- Retraites de 15 minutes (le dépliant « Retraites de prière de 15' » de la communauté) : 4 retraites × 15 points, une minute chacun. Les textes sont dans `assets/prayer/retreats_<langue>.json` (le français fait référence ; les autres langues suivent, à faire relire), avec les listes de pays et de peuples priés à tour de rôle. Ce que l'app ajoute à un point est décrit dans `domain/retreat.dart` (`retreatHints`) : l'assemblée du profil, les autorités, les 5 suivants d'une liste (`nextPeople` : jamais priés d'abord, puis les plus anciens), le pays du jour (`nationOfDay`), le pays du profil, les cantiques. `retreatPlanProvider(moment, langue)` remplit les points.
- `RetreatSessionScreen` : minuté (60 s par point, son doux `Chime` via audioplayers, qui respecte le mode silencieux, vibration, écran allumé) ou « à mon rythme ». À la fin : `RetreatLog.markDone` (gardée sur le téléphone et envoyée plus tard sans réseau), les personnes priées passent en fin de liste (`PrayerPeople.markPrayed`), et `RetreatReport.add(15)` ajoute 15 minutes à « Prière seule » (élément `PS`) du compte rendu du jour, sauf si cette retraite était déjà faite aujourd'hui. « Annuler » défait les deux.
- Rappels : `RetreatReminders` (une heure par retraite, clés `retreat_reminder_<moment>`), groupe `NotificationGroup.prayer`, une retraite faite ne sonne plus ; le payload `retreat:<moment>` ouvre la retraite (`SignedInTasks`).
- Sujets de la communauté : publiés par les admins depuis le site admin (le PDF est lu dans le navigateur pour proposer les points). `PrayerTopics` (copie gardée hors ligne), un membre coche les points priés du jour ; l'app ne montre que le nombre de personnes qui prient, jamais qui.
- Listes (pas encore cru, croyants, rétrogrades, co-ouvriers) : sur le serveur, visibles par l'utilisateur seul (`PrayerPeople`, gardé en vie, copie hors ligne) ; « a cru / exaucé » = `answeredOn`.
- Sujets d'importunité : `Importunities` (gardé en vie). Un toucher compte une proclamation à l'instant sur le téléphone (`pendingCounts`) ; `sendCounts` envoie le tout 2 s après le dernier toucher, en quittant l'écran, au retour dans l'app et au retour du réseau. L'écran prend ses nombres dans la liste (qui ajoute ce qui n'est pas envoyé) et les noms dans `importunityDetailProvider` : compter ne rappelle pas le serveur. Chacun voit le total et son propre nombre, jamais celui des autres. Invitations par pseudo ou à « ma famille spirituelle » (le FD lié et accepté, et ses autres disciples : seul leur nombre est montré).
- Déconnexion : `App` vide `PrayerLocalStore` et invalide les providers gardés en vie de la prière.
- Dans les tests : `FakePrayerApi` (`offline`, `spiritualFamily`, et ce qui a été envoyé : `retreatList`, `prayedCalls`, `markedPrayed`, `counts`, `invitations`), `FakeChime`. Pendant une retraite minutée, pas de `pumpAndSettle` : il ferait tourner l'horloge ; `pump(durée)` à la place. Les textes des retraites sont lus sans le cache du bundle (`cache: false`), qui mélangerait les tests.

## Tests

- Classes API : `http_mock_adapter`, avec les vrais formats JSON du backend.
- Notifiers et écrans : `ProviderContainer` / `UncontrolledProviderScope` avec les faux de `test/helpers/fakes.dart`. Jamais de vrai réseau ni de vrai secure storage.
- Parcours complets : `pumpApp(tester, token: …, onboardingSeen: …)` de `test/helpers/pump_app.dart` (toutes les API simulées, écran de 390×844).
- Après `enterText`, faire `await tester.pump()` avant de toucher un bouton qui dépend du texte saisi.
- Nommer un test par le comportement attendu (« wrong password shows a translated message »).

## Dépendances et versions

- Utiliser les paquets déjà présents avant d'en proposer un nouveau, et demander avant d'en ajouter. Ajoutés avec accord : `path_provider` et `wakelock_plus` (cantiques) ; `flutter_local_notifications`, `timezone`, `flutter_timezone`, `share_plus`, `pdf` et `connectivity_plus` (compte rendu) ; `toastification`, `flutter_animate` et `animations` (popups, animations) ; `phosphor_flutter` (icônes) ; `image_picker`, `cached_network_image`, `add_2_calendar` et `url_launcher` (évènements) ; `audioplayers` (le son entre deux points d'une retraite).
- Rester compatible avec Flutter 3.38 : `auto_route` est bloqué sous 11.2, qui exige une version plus récente de Flutter.

## Git

- Messages de commit au format `feat: …`, `fix: …`, `chore: …`, comme dans oxysend.
- Ne commiter qu'à la demande.
