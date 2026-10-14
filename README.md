# CMFI Connect

App mobile Flutter des comptes rendus quotidiens. Elle consomme l'API Go `cmfi-connect`.

## Démarrer

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
