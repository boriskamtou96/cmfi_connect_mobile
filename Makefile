# Les commandes de CMFI Connect. `make` (ou `make help`) les liste.
#
# Options : FLAVOR=dev|prod, IP=192.168.1.20 (vrai téléphone), TYPE=patch|minor|major,
# TRACK=internal|alpha|beta|production.

FLAVOR ?= dev
IP     ?= 192.168.1.20
TYPE   ?= patch
TRACK  ?= internal

FLUTTER  := flutter
DART     := dart
FASTLANE := bundle exec fastlane
DEFINES  := --dart-define-from-file=.env
LANGUAGES := fr en de es ar zh hi

# fastlane sans questions ni publicité
export FASTLANE_SKIP_UPDATE_CHECK := 1
export FASTLANE_HIDE_CHANGELOG := 1
export FASTLANE_OPT_OUT_USAGE := 1
export LC_ALL := en_US.UTF-8

.DEFAULT_GOAL := help
.PHONY: help setup gen gen-clean watch run run-dev run-prod run-device catalog \
	analyze test check format brand mascots screenshots landing-screens \
	build-apk build-aab build-ipa build-dev-apk pods clean \
	lanes bump bump-dry ios-beta ios-release android-beta match-setup publish

help: ## Affiche cette aide
	@grep -hE '^[a-zA-Z_-]+:.*?## ' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-18s\033[0m %s\n", $$1, $$2}'

# ----- installation et génération -----------------------------------------------------

setup: ## Installe tout : paquets Flutter, fastlane, code généré
	$(FLUTTER) pub get
	bundle install
	$(MAKE) gen

gen: ## Génère le code (riverpod, freezed, routes, traductions)
	$(DART) run build_runner build --force-jit
	@# build_runner efface parfois des fichiers suivis par git : on les remet
	@git ls-files --deleted -z | xargs -0 git checkout -- 2>/dev/null || true

gen-clean: ## Régénère après « Asset already exists » (supprime strings*.g.dart)
	rm -f lib/src/core/i18n/strings*.g.dart
	$(MAKE) gen

watch: ## Génère le code en continu pendant le développement
	$(DART) run build_runner watch --force-jit

# ----- lancement ----------------------------------------------------------------------

run: ## Lance l'app (FLAVOR=dev par défaut, API locale)
	$(FLUTTER) run --flavor $(FLAVOR) $(DEFINES)

run-dev: ## Lance l'app dev (API locale)
	$(FLUTTER) run --flavor dev $(DEFINES)

run-prod: ## Lance l'app prod en release (API en ligne)
	$(FLUTTER) run --flavor prod --release $(DEFINES)

run-device: ## Lance l'app dev sur un vrai téléphone (IP=adresse du Mac)
	$(FLUTTER) run --flavor dev $(DEFINES) --dart-define=API_BASE_URL=http://$(IP):8080/v1

catalog: ## Lance le catalogue de widgets
	$(FLUTTER) run --flavor dev -t lib/main_catalog.dart

# ----- qualité ------------------------------------------------------------------------

analyze: ## Analyse le code
	$(FLUTTER) analyze

test: ## Lance tous les tests
	$(FLUTTER) test

check: analyze test ## Analyse + tests (obligatoires avant de finir une tâche)

format: ## Formate le code (lib, test, tool)
	$(DART) format lib test tool

# ----- images -------------------------------------------------------------------------

brand: ## Régénère icônes, icônes adaptatives et écran de lancement depuis le logo
	$(FLUTTER) test tool/brand_assets_test.dart
	$(DART) run flutter_launcher_icons -f flutter_launcher_icons-dev.yaml
	$(DART) run flutter_launcher_icons -f flutter_launcher_icons-prod.yaml
	$(DART) run flutter_native_splash:create

mascots: ## Régénère les images de Zoé (widget de l'écran d'accueil)
	$(FLUTTER) test tool/brand_assets_test.dart --plain-name 'generate mascot images'

screenshots: ## Refait les captures des stores et l'image de mise en avant (store/screenshots)
	$(FLUTTER) test tool/store_screenshots_test.dart --plain-name 'store screenshot'
	$(FLUTTER) test tool/store_screenshots_test.dart --plain-name 'feature graphic'

landing-screens: ## Refait les écrans du site vitrine dans les 7 langues (build/landing_screens)
	@# une langue à la fois : la police de l'arabe, du chinois et du hindi ne se mélange pas
	@for language in $(LANGUAGES); do \
	$(FLUTTER) test tool/store_screenshots_test.dart --plain-name "landing screens $$language" || exit 1; \
	done

# ----- builds -------------------------------------------------------------------------

build-apk: ## APK prod (build/app/outputs/flutter-apk)
	$(FLUTTER) build apk --release --flavor prod $(DEFINES)

build-aab: ## App bundle prod pour Google Play (build/app/outputs/bundle)
	$(FLUTTER) build appbundle --release --flavor prod $(DEFINES)

build-ipa: ## IPA prod pour l'App Store, signature automatique de Xcode (build/ios/ipa)
	$(FLUTTER) build ipa --release --flavor prod $(DEFINES)

build-dev-apk: ## APK dev, à installer pour des tests
	$(FLUTTER) build apk --release --flavor dev $(DEFINES)

build-prod-apk: ## APK prod, à installer pour des tests en prod
	$(FLUTTER) clean;$(FLUTTER) pub get;$(FLUTTER) build apk --release --split-per-abi --flavor prod

pods: ## Réinstalle les pods iOS
	cd ios && pod install

clean: ## Nettoie les builds et réinstalle les paquets
	$(FLUTTER) clean
	$(FLUTTER) pub get

# ----- publication (fastlane) ---------------------------------------------------------

lanes: ## Liste les lanes fastlane
	$(FASTLANE) lanes

bump: ## Monte la version (TYPE=patch|minor|major), commit et tag
	$(FASTLANE) bump type:$(TYPE)

bump-dry: ## Montre la prochaine version sans rien changer
	$(FASTLANE) bump type:$(TYPE) dry_run:true

ios-beta: ## Envoie sur TestFlight, avec les notes (clés App Store Connect et match)
	$(FASTLANE) ios beta

ios-release: ## Envoie le build et les notes sur App Store Connect (sans soumettre à Apple)
	$(FASTLANE) ios release

android-beta: ## Envoie sur Google Play (TRACK=internal par défaut)
	$(FASTLANE) android beta track:$(TRACK)

match-setup: ## Une fois : crée certificats et profils iOS dans le dépôt de match (MATCH_GIT_URL)
	$(FASTLANE) match appstore

publish: ## Pousse le commit et le dernier tag : GitHub Actions publie la version
	git push
	git push origin $$(git describe --tags --abbrev=0)
