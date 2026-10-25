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
	lanes bump bump-dry ios-beta ios-metadata ios-release android-beta match-setup asc-env play-env ci-secrets publish

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

screenshots: ## Refait les captures des stores et l'image de mise en avant (store/screenshots), en JPEG sans transparence
	$(FLUTTER) test tool/store_screenshots_test.dart --plain-name 'store screenshot'
	$(FLUTTER) test tool/store_screenshots_test.dart --plain-name 'feature graphic'
	@# Apple and Google refuse images with an alpha channel: JPEG has none
	@for f in store/screenshots/ios/fr/*.png store/screenshots/android/fr/*.png store/screenshots/feature_graphic.png; do \
		sips -s format jpeg -s formatOptions 95 "$$f" --out "$${f%.png}.jpg" >/dev/null && rm "$$f"; \
	done
	@echo "Captures prêtes : store/screenshots (JPEG)"

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

ios-beta: ## Envoie sur TestFlight, avec les notes ; SCREEN_TIME=true quand Apple accorde Family Controls
	$(FASTLANE) ios beta $(if $(SCREEN_TIME),screen_time:$(SCREEN_TIME),)

ios-metadata: ## Envoie la fiche App Store dans les 7 langues (fastlane/metadata), sans build
	$(FASTLANE) ios metadata

ios-release: ## Envoie le build et les notes sur App Store Connect (sans soumettre à Apple) ; SCREEN_TIME=true quand Apple accorde Family Controls
	$(FASTLANE) ios release $(if $(SCREEN_TIME),screen_time:$(SCREEN_TIME),)

android-beta: ## Envoie sur Google Play (TRACK=internal par défaut)
	$(FASTLANE) android beta track:$(TRACK)

match-setup: ## Une fois : crée certificat et profils iOS dans le dépôt de match (clé API et MATCH_* dans fastlane/.env)
	$(FASTLANE) ios certificates

play-env: ## Écrit PLAY_JSON_KEY dans fastlane/.env depuis la clé JSON du compte de service Google Play : make play-env JSON=…
	@test -f "$(JSON)" || { echo "Usage : make play-env JSON=~/chemin/compte-de-service.json"; exit 1; }
	@touch fastlane/.env && chmod 600 fastlane/.env
	@grep -v '^PLAY_JSON_KEY=' fastlane/.env > fastlane/.env.tmp || true
	@{ cat fastlane/.env.tmp; printf "PLAY_JSON_KEY="; python3 -c "import json,sys; print(json.dumps(json.load(open(sys.argv[1]))))" "$(JSON)"; } > fastlane/.env
	@rm -f fastlane/.env.tmp
	@echo "fastlane/.env : PLAY_JSON_KEY écrit (make android-beta peut publier sur Google Play)."

ci-secrets: ## Envoie les secrets iOS de fastlane/.env dans GitHub Actions (gh connecté au compte du dépôt) ; CERTS_TOKEN=jeton GitHub lecture du dépôt de match
	@test -f fastlane/.env || { echo "fastlane/.env manquant : make asc-env d'abord"; exit 1; }
	@test -n "$(CERTS_TOKEN)" || { echo "Usage : make ci-secrets CERTS_TOKEN=<jeton GitHub en lecture sur le dépôt de certificats>"; exit 1; }
	@for name in ASC_KEY_ID ASC_ISSUER_ID ASC_KEY_P8 MATCH_PASSWORD; do \
		grep "^$$name=" fastlane/.env | cut -d= -f2- | tr -d '\n' | gh secret set $$name || exit 1; \
	done
	@# CI clones the certificates over HTTPS: the same repository, and "user:token" in base64
	@grep '^MATCH_GIT_URL=' fastlane/.env | cut -d= -f2- | sed -E 's#^git@github.com:#https://github.com/#' | tr -d '\n' | gh secret set MATCH_GIT_URL
	@printf '%s' "$$(gh api user --jq .login):$(CERTS_TOKEN)" | base64 | tr -d '\n' | gh secret set MATCH_GIT_BASIC_AUTHORIZATION
	@echo "Secrets iOS envoyés : ASC_KEY_ID, ASC_ISSUER_ID, ASC_KEY_P8, MATCH_PASSWORD, MATCH_GIT_URL, MATCH_GIT_BASIC_AUTHORIZATION"

asc-env: ## Écrit fastlane/.env depuis la clé API App Store Connect : make asc-env P8=… KEY_ID=… ISSUER=…
	@test -n "$(P8)" -a -n "$(KEY_ID)" -a -n "$(ISSUER)" || { echo "Usage : make asc-env P8=~/AuthKey_XXXX.p8 KEY_ID=XXXX ISSUER=xxxx-…"; exit 1; }
	@test -f "$(P8)" || { echo "Fichier introuvable : $(P8)"; exit 1; }
	@touch fastlane/.env && chmod 600 fastlane/.env
	@grep -v '^ASC_' fastlane/.env > fastlane/.env.tmp || true
	@{ echo "ASC_KEY_ID=$(KEY_ID)"; echo "ASC_ISSUER_ID=$(ISSUER)"; printf "ASC_KEY_P8="; base64 -i "$(P8)" | tr -d '\n'; echo; cat fastlane/.env.tmp; } > fastlane/.env
	@rm -f fastlane/.env.tmp
	@echo "fastlane/.env écrit (ASC_KEY_ID, ASC_ISSUER_ID, ASC_KEY_P8). Ajoute MATCH_GIT_URL et MATCH_PASSWORD (voir fastlane/.env.example)."

publish: ## Pousse le commit et le dernier tag : GitHub Actions publie la version
	git push
	git push origin $$(git describe --tags --abbrev=0)


build-ios:
	cd /Users/hardpro/cmfi-connect/cmfi_connect_mobile_free && 
	flutter build ios --release --flavor prod --dart-define-from-file=.env && xcrun devicectl device install app --device 773DA0BA-00A9-5970-A4F4-E6E35513575A build/ios/iphoneos/Runner.app
