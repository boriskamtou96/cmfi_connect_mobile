#!/bin/zsh
# The Android release for Google Play, in one command (docs/MISE_EN_PROD.md):
#
#   scripts/release-android.sh
#
# Checks the signing key and the code, builds the app bundle of the prod
# flavor, then says who signed it and which version it is. Upload the .aab
# in Play Console › Test interne first.
set -euo pipefail
cd "$(dirname "$0")/.."

bundle=build/app/outputs/bundle/prodRelease/app-prod-release.aab

say() { print -P "%B$1%b"; }

# ----- the upload key: android/key.properties, never in git -----
if [[ ! -f android/key.properties ]]; then
  say "android/key.properties est absent : copie android/key.properties.example et remplis-le."
  exit 1
fi
for key in storeFile storePassword keyAlias keyPassword; do
  if ! grep -q "^$key=." android/key.properties; then
    say "android/key.properties : la ligne $key est vide."
    exit 1
  fi
done
store=$(grep '^storeFile=' android/key.properties | cut -d= -f2-)
if [[ ! -f "$store" ]]; then
  say "La clé indiquée dans android/key.properties est introuvable : $store"
  exit 1
fi

# ----- the settings of the build: .env (RevenueCat keys) -----
if [[ ! -f .env ]]; then
  say ".env est absent : la construction en a besoin (--dart-define-from-file)."
  exit 1
fi

version=$(grep '^version:' pubspec.yaml | awk '{print $2}')
say "CMFI Connect $version (le nombre après le + est le versionCode de Google Play)"

# ----- the code -----
say "1/3 Vérification du code"
dart format --output=none --set-exit-if-changed lib test
flutter analyze
flutter test

# ----- the bundle -----
say "2/3 Construction du paquet de publication"
flutter build appbundle --flavor prod --dart-define-from-file=.env

# ----- signed with the upload key, not the debug one -----
say "3/3 Signature"
signer=$(keytool -printcert -jarfile "$bundle" | grep -m1 -E 'Owner|Propriétaire')
print "$signer"
if [[ "$signer" == *"Android Debug"* ]]; then
  say "Signé avec la clé de debug : Google Play le refusera. Vérifie android/key.properties."
  exit 1
fi

say "Prêt : $bundle ($(du -h "$bundle" | cut -f1))"
say "À envoyer dans Play Console › Tester › Test interne › Créer une release."
say "Prochaine release : augmenter le nombre après le + dans pubspec.yaml ($version)."
