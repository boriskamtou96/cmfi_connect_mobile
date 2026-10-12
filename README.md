# CMFI Connect

App mobile Flutter des comptes rendus quotidiens. Elle consomme l'API Go `cmfi-connect`.

## Démarrer

```bash
flutter pub get
dart run build_runner build --force-jit
flutter run --flavor dev
```

| Flavor | Nom de l'app | Identifiant | API |
|---|---|---|---|
| `dev` | CMFI Connect Dev | `com.cmfi.connect.dev` | `http://10.0.2.2:8080/v1` (émulateur Android), `http://localhost:8080/v1` (simulateur iOS) |
| `prod` | CMFI Connect | `com.cmfi.connect` | à définir dans `lib/src/core/config/app_config.dart` |

Sur un vrai téléphone, l'API locale se joint par l'adresse IP du Mac :

```bash
flutter run --flavor dev --dart-define=API_BASE_URL=http://192.168.1.20:8080/v1
```

Les deux flavors peuvent être installés côte à côte sur le même téléphone. Ils ont été générés par `flutter_flavorizr` (configuration dans `pubspec.yaml`).

## Avant de pousser

```bash
flutter analyze
flutter test
```

Les conventions du projet (architecture, état, réseau, traductions, tests) sont dans [CLAUDE.md](CLAUDE.md).
