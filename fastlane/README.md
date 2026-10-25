fastlane documentation
----

# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```sh
xcode-select --install
```

For _fastlane_ installation instructions, see [Installing _fastlane_](https://docs.fastlane.tools/#installing-fastlane)

# Available Actions

### test

```sh
[bundle exec] fastlane test
```

Analyse et tests (comme le CI)

### bump

```sh
[bundle exec] fastlane bump
```

Monte la version (type:patch|minor|major), le numéro de build +1, commit et tag

----


## iOS

### ios certificates

```sh
[bundle exec] fastlane ios certificates
```

Une fois (puis à chaque nouvelle extension) : crée certificat et profils App Store dans le dépôt de match

### ios beta

```sh
[bundle exec] fastlane ios beta
```

TestFlight, avec les notes de version dans chaque langue

### ios metadata

```sh
[bundle exec] fastlane ios metadata
```

App Store Connect : la fiche dans les 7 langues (fastlane/metadata), les notes, le copyright et les catégories, sans build ni captures

### ios release

```sh
[bundle exec] fastlane ios release
```

App Store Connect : le build et les notes de la version (sans l'envoyer à Apple)

----


## Android

### android beta

```sh
[bundle exec] fastlane android beta
```

Google Play : l'app prod sur une piste (track:internal par défaut), avec les notes

----

This README.md is auto-generated and will be re-generated every time [_fastlane_](https://fastlane.tools) is run.

More information about _fastlane_ can be found on [fastlane.tools](https://fastlane.tools).

The documentation of _fastlane_ can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
