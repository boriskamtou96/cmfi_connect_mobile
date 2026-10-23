# CMFI Connect

App mobile Flutter des comptes rendus quotidiens. Elle consomme l'API Go `cmfi-connect`.

## Démarrer

Toutes les commandes ci-dessous sont aussi dans le `Makefile` : `make` les liste (`make setup`, `make run`, `make check`, `make catalog`, `make bump TYPE=minor`…).

```bash
flutter pub get
dart run build_runner build --force-jit
flutter run --flavor dev --dart-define-from-file=.env
```

`.env` donne les clés publiques de RevenueCat (Premium) ; sans elles l'app marche, Premium reste fermé.

| Flavor | Nom de l'app | Identifiant | API |
|---|---|---|---|
| `dev` | CMFI Connect Dev | `com.cmficonnect.app.dev` | `http://10.0.2.2:8080/v1` (émulateur Android), `http://localhost:8080/v1` (simulateur iOS) |
| `prod` | CMFI Connect | `com.cmficonnect.app` | `https://api.cmfi-connect.com/v1` (`lib/src/core/config/app_config.dart`) |

Sur un vrai téléphone, l'API locale se joint par l'adresse IP du Mac :

```bash
flutter run --flavor dev --dart-define-from-file=.env --dart-define=API_BASE_URL=http://192.168.1.20:8080/v1
```

Les deux flavors peuvent être installés côte à côte sur le même téléphone. Ils ont été générés par `flutter_flavorizr` (configuration dans `pubspec.yaml`).

Firebase (notifications) : projets `cmfi-connect-dev` et `cmfi-connect`, apps déjà enregistrées (`lib/src/core/config/firebase_options.dart`).

## Avant de pousser

```bash
flutter analyze
flutter test
```

Les conventions du projet (architecture, état, réseau, traductions, tests) sont dans [CLAUDE.md](CLAUDE.md).

## Le catalogue de widgets

Une petite appli à part montre les composants de l'app (logo, icône, Zoé, pastilles, cartes, médailles d'étapes, couvertures et cartes de paroles des cantiques…) avec leurs réglages, en clair ou en sombre, dans les 7 langues et à toutes les tailles de texte :

```bash
flutter run --flavor dev -t lib/main_catalog.dart
```

Les fiches sont dans `lib/catalog/stories.dart` : une fiche = un nom, une famille et l'aperçu, qui demande ses réglages (`knobs.boolean`, `knobs.slider`, `knobs.options`, `knobs.text`). `test/catalog` ouvre chaque fiche dans chaque langue, en clair et en sombre, texte agrandi : un composant qui déborde fait échouer les tests.

## Publier une version

fastlane construit et envoie l'app aux stores ; GitHub Actions le fait tout seul quand une version est taguée. Les lanes (`fastlane/Fastfile`) marchent aussi sur le Mac :

```bash
bundle install                                   # une fois : installe fastlane dans vendor/bundle
bundle exec fastlane test                        # analyse et tests
bundle exec fastlane bump type:patch             # 1.0.0+1 -> 1.0.1+2 (minor, major), commit et tag v1.0.1
bundle exec fastlane ios beta                    # TestFlight
bundle exec fastlane ios release                 # App Store Connect, sans l'envoyer à Apple
bundle exec fastlane android beta                # Google Play, piste interne
bundle exec fastlane android beta track:production
```

### À chaque version

1. Écrire les nouveautés dans `store/release_notes/<langue>.txt` (`fr`, `en`, `de`, `es`, `ar`, `zh`, `hi`), 500 caractères au plus : ce sont les notes affichées par les deux stores. `bump` refuse de continuer s'il en manque une.
2. `bundle exec fastlane bump type:patch` (ou `minor`, `major`) : la version et le numéro de build montent dans `pubspec.yaml`, un commit « release: bump version to … » et le tag `v…` sont créés.
3. `git push && git push origin v1.0.1` : le workflow **Release** teste, puis envoie sur la piste interne de Google Play et sur TestFlight, avec les notes.
4. Dans les consoles, passer la version en production (Google Play) ou l'envoyer à Apple (App Store Connect), quand elle est prête.

### La mise en place (une seule fois)

- **Google Play** : la toute première version s'envoie à la main dans la Play Console (Google l'exige). Puis créer un compte de service (Play Console › Configuration › Accès à l'API), lui donner les droits de publication, télécharger sa clé JSON.
- **App Store Connect** : Utilisateurs et accès › Intégrations › **Clés de l'API App Store Connect**, une clé avec le rôle « App Manager » ; noter son Key ID et l'Issuer ID, télécharger le `.p8`.
- **match** : créer un dépôt GitHub **privé** vide (par exemple `cmfi-connect-certificates`), puis, sur le Mac, `MATCH_GIT_URL=<son adresse> bundle exec fastlane match appstore` : match crée le certificat de distribution et les 5 profils (l'app, le widget, les 3 extensions Temps d'écran) et les chiffre avec la phrase de passe choisie.
- **Secrets GitHub** (dépôt › Settings › Secrets and variables › Actions) :

| Secret | Contenu |
|---|---|
| `DOT_ENV` | le contenu du `.env` de l'app |
| `ANDROID_KEYSTORE_BASE64` | la clé d'upload Google Play (`.jks`) : `base64 -i upload-keystore.jks` |
| `ANDROID_KEY_PROPERTIES` | le contenu de `android/key.properties`, avec `storeFile=upload-keystore.jks` |
| `PLAY_JSON_KEY` | la clé JSON du compte de service Google Play |
| `ASC_KEY_ID`, `ASC_ISSUER_ID` | la clé de l'API App Store Connect |
| `ASC_KEY_P8` | son fichier `.p8` : `base64 -i AuthKey_XXXX.p8` |
| `MATCH_GIT_URL` | l'adresse du dépôt privé de match |
| `MATCH_PASSWORD` | la phrase de passe de match |
| `MATCH_GIT_BASIC_AUTHORIZATION` | `echo -n "utilisateur:jeton" \| base64`, un jeton GitHub qui lit ce dépôt |

Le workflow **CI** lance `flutter analyze` et `flutter test` à chaque push sur `main` et à chaque pull request.
