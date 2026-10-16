# Mise en production · CMFI Connect

Tout ce qu'il faut faire pour publier l'app, dans l'ordre. Coche au fur et à mesure. Ce qui est déjà prêt dans le code est marqué ✅.

L'app parle à l'API **https://api.cmfi-connect.com** ; le site admin est sur **admin.cmfi-connect.com**, la page vitrine sur **cmfi-connect.com**.

---

## 1. Le serveur (API) : en premier

L'app publiée ne marche que si l'API est en ligne.

- [ ] **Choisir l'hébergeur** de l'API : Render, Railway ou Fly.io (le `Dockerfile` du backend est fait pour eux) et y créer une base **PostgreSQL** gérée, avec des sauvegardes automatiques chaque jour.
- [ ] **Donner les réglages** (variables d'environnement) à l'hébergeur :
  - `DATABASE_URL` (ou `DB_DSN`) : l'adresse de la base, donnée par l'hébergeur ;
  - `TOKEN_SECRET` : une longue phrase secrète, au hasard (au moins 32 caractères), jamais partagée ;
  - `GIN_MODE=release`, `LOG_LEVEL=info` ;
  - `CORS_ORIGINS=https://admin.cmfi-connect.com` (sinon le site admin ne peut pas parler à l'API) ;
  - `FIREBASE_CREDENTIALS_JSON` : le contenu de la clé du compte de service Firebase du projet **cmfi-connect** (prod), en variable secrète ;
  - `PUBLIC_URL=https://api.cmfi-connect.com` ;
  - les images et PDF : soit un disque permanent monté sur `MEDIA_DIR`, soit un espace de stockage (Cloudflare R2, recommandé) avec `S3_ENDPOINT`, `S3_BUCKET`, `S3_ACCESS_KEY_ID`, `S3_SECRET_ACCESS_KEY`, et `MEDIA_PUBLIC_URL`.
- [ ] **Brancher le domaine** `api.cmfi-connect.com` sur l'hébergeur (un enregistrement DNS dans Cloudflare).
- [ ] **Mettre les cantiques** dans la base : `import-hymns data/hymns/*.json` (commande de l'image, depuis la console de l'hébergeur).
- [ ] **Créer le premier superadmin** : s'inscrire dans l'app, puis `promote -username <ton pseudo> -role superadmin` depuis la console de l'hébergeur.
- [ ] Vérifier que https://api.cmfi-connect.com/v1/health répond.

Les mises à jour de la base (migrations) se font toutes seules au démarrage du serveur.

## 2. Les deux sites

Voir le README de chacun (`npm run deploy`).

- [ ] Compte Cloudflare, domaine `cmfi-connect.com` ajouté, `npx wrangler@4 login`.
- [ ] **Page vitrine** : remplir `src/config.ts` (adresse postale, pays, e-mail de contact, hébergeur), puis `npm run deploy`, puis le domaine `cmfi-connect.com`. Indispensable avant les stores : Apple et Google demandent l'adresse de la **politique de confidentialité** (https://cmfi-connect.com/privacy) et de la **suppression du compte** (https://cmfi-connect.com/delete-account).
- [ ] **Site admin** : `npm run deploy`, puis le domaine `admin.cmfi-connect.com`.
- [ ] Relire la politique de confidentialité : depuis sa dernière mise à jour, l'app a ajouté la connexion par Face ID / empreinte (rien ne quitte le téléphone) et « Cherche d'abord Dieu » (l'app ne voit jamais les apps choisies). Je peux mettre le texte à jour si tu veux.

## 3. Avant de construire l'app

- [x] ✅ Adresse de l'API en production : `https://api.cmfi-connect.com/v1` (`lib/src/core/config/app_config.dart`).
- [x] ✅ Firebase prod (projet `cmfi-connect`) pour iOS et Android : notifications, SMS du mot de passe oublié, Crashlytics.
- [x] ✅ Signature Android de publication lue depuis `android/key.properties` (voir 5.).
- [x] ✅ Déclaration de confidentialité Apple (`PrivacyInfo.xcprivacy`) dans l'app, le widget et les extensions ; « pas de chiffrement spécial » déclaré (`ITSAppUsesNonExemptEncryption`), Apple ne pose plus la question à chaque envoi.
- [ ] **Numéro de version** dans `pubspec.yaml` : `version: 1.0.0+1` → le premier envoi peut rester `1.0.0+1`. À chaque nouvel envoi, augmenter le nombre après le `+` (`1.0.0+2`, `1.0.1+3`…).
- [ ] **Premium** : en v1, offert à tous dans l'app publiée (rien à créer). Pour ouvrir les achats plus tard : remplir `REVENUE_CAT_APPLE_API_KEY` et `REVENUE_CAT_GOOGLE_API_KEY` dans `.env`, créer les produits dans les stores et dans RevenueCat (accès `cmfi_connect_pro`), puis me demander de basculer `premiumForEveryone`.
- [ ] **Notifications push iOS** : dans Firebase (projet `cmfi-connect`) › Paramètres › Cloud Messaging, ajouter la **clé APNs** (fichier `.p8` créé sur developer.apple.com › Keys, avec « Apple Push Notifications service »).
- [ ] Supprimer les comptes de test de la base (les 46 comptes de ta base locale ne vont pas en production : la base de prod part vide).

## 4. iPhone (App Store)

Sur developer.apple.com (équipe `8S3QJGW6FL`) :

- [ ] **Identifiants** : `com.cmficonnect.app` et ses extensions `.TodayWidget`, `.ShieldMonitor`, `.ShieldConfig`, `.ShieldActions` (Xcode les crée à la première signature automatique), avec les capacités App Groups (`group.com.cmficonnect.app`), Push Notifications, Associated Domains, Family Controls.
- [ ] **Family Controls (Distribution)** pour « Cherche d'abord Dieu » : demander l'accord sur https://developer.apple.com/contact/request/family-controls-distribution pour l'app **et** les trois extensions Shield. Sans cet accord, l'App Store refuse l'envoi. Compter quelques jours à quelques semaines.

Dans App Store Connect :

- [ ] **Créer l'app** : nom « CMFI Connect », identifiant `com.cmficonnect.app`, langue principale français.
- [ ] **Fiche** : textes, mots-clés, catégorie, captures (déjà prêts : `store/fiche-stores.md` et `store/screenshots/ios/`).
- [ ] **Confidentialité de l'app** (les « étiquettes ») : nom, téléphone, e-mail, photos, contenu (compte rendu, prière), historique d'achat, données de plantage, identifiant de l'appareil (push) ; tout lié au compte, rien pour la publicité ni le pistage. Le détail est dans `store/fiche-stores.md`.
- [ ] **Classification par âge** (questionnaire) et **adresses** : confidentialité, assistance (https://cmfi-connect.com).
- [ ] **Compte de démonstration pour Apple** : un compte de test sur la **prod** (numéro + mot de passe) à donner dans « Informations pour la vérification », avec une phrase expliquant « Cherche d'abord Dieu » (Temps d'écran) et Face ID.
- [ ] **Construire et envoyer** : dans Xcode, schéma `prod`, Product › Archive, puis Distribute App › App Store Connect. Ou en ligne de commande :

  ```bash
  flutter build ipa --flavor prod --dart-define-from-file=.env
  ```

  puis envoyer le fichier `build/ios/ipa/*.ipa` avec l'app **Transporter**.
- [ ] **TestFlight** d'abord : installer la version sur ton iPhone, tout essayer (connexion, Face ID, notifications, widget, Cherche d'abord Dieu, liens), puis « Soumettre pour vérification ».

## 5. Android (Google Play)

La fiche des stores prévoit la v1 sur iPhone seulement ; si Android part en même temps :

- [x] ✅ **Clé d'envoi** créée (`~/upload-keystore.jks`, « CMFI », valable jusqu'en 2054) et `android/key.properties` rempli. Garde une copie de la clé et de son mot de passe ailleurs que sur ce Mac. Pour mémoire, elle se crée ainsi :

  ```bash
  keytool -genkey -v -keystore ~/cmfi-connect-upload.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload
  ```

  puis copier `android/key.properties.example` en `android/key.properties` et le remplir (ce fichier ne va jamais dans git).
- [ ] **Google Play Console** (compte développeur, 25 $ une fois) : créer l'app `com.cmficonnect.app`, la fiche (`store/fiche-stores.md`, captures `store/screenshots/android/`), la **sécurité des données**, la classification, le public cible, la politique de confidentialité.
- [ ] **Outils Android** (une fois) : dans Android Studio › Settings › Languages & Frameworks › Android SDK › onglet **SDK Tools**, cocher **Android SDK Command-line Tools (latest)**, Apply. Puis accepter les licences :

  ```bash
  flutter doctor --android-licenses
  ```

  Sans ces outils, `flutter build appbundle` s'arrête sur « failed to strip debug symbols ».
- [ ] **Construire** : tout est vérifié et construit par

  ```bash
  scripts/release-android.sh
  ```

  (clé d'envoi présente, code vérifié et testé, paquet `prod`, signé avec ta clé et pas celle de debug), puis envoyer `build/app/outputs/bundle/prodRelease/app-prod-release.aab` en **test interne** d'abord. Google Play découpe le paquet par type de téléphone : chaque utilisateur ne télécharge que sa part.
- [ ] **Liens qui ouvrent l'app** : copier l'empreinte SHA-256 de Play Console › Intégrité de l'application dans `playSigningSha256` du site (`src/config.ts`), puis `npm run deploy` du site.
- [ ] Nouveau compte développeur personnel : Google demande 12 testeurs pendant 14 jours avant la production. Un compte d'organisation (avec un numéro D-U-N-S) n'a pas cette règle.

## 6. Le jour du lancement

- [ ] Mettre les liens des stores dans le site (`appStoreUrl`, `playStoreUrl` de `src/config.ts`), puis `npm run deploy`.
- [ ] Publier une première annonce depuis le site admin, pour vérifier les notifications.
- [ ] Surveiller Crashlytics (console Firebase) et les journaux de l'API les premiers jours.

---

Les secrets (mots de passe, `TOKEN_SECRET`, clé Firebase, clé `.jks`, `.env`) ne vont jamais dans git ni dans un message : seulement chez l'hébergeur ou dans ton gestionnaire de mots de passe.
