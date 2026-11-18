# Premium : l'achat dans l'app revient, à côté du site (design court, 18/11/2026)

## Pourquoi

Apple a refusé la version 1.0.3 (règle 3.1.1) : l'app ouvre Premium acheté sur le site, mais Premium ne
s'achète pas dans l'app par achat intégré. Depuis le 5/11/2026 (commit `867b4a8`), RevenueCat et les
achats des stores ont été retirés : Premium ne se vend que sur cmfi-connect.com (Mobile Money). Google Play
exige aussi son paiement pour un contenu numérique.

## Décisions de l'utilisateur

- Voie 1 : remettre l'achat Apple / Google dans l'app, **à côté** du site (règle 3.1.3(b)).
- Sur les branches actuelles (dev), pour une seule mise à jour App Store et Google Play.
- Il garde pour lui le contrat « Applications payantes », la banque et les impôts ; le reste est fait
  par Claude.

## Approches

- **Retenue :** un seul `PremiumStore` qui réunit le serveur (site, Premium offert, renouvellement) et
  RevenueCat (App Store, Google Play, Test Store en dev).
- Écartée : deux providers séparés que chaque écran combinerait (le calcul « actif » se répéterait).
- Écartée : refaire le `revert` de `867b4a8` (trop de conflits avec les changements depuis).

## Comportement

- **Actif** : l'équipe (rôle), ou le serveur (acheté sur le site, offert), ou l'accès
  `cmfi_connect_pro` de RevenueCat. Les changements des deux sources mettent `premiumProvider` à jour.
- **Connexion** : `logIn(id du compte)` demande au serveur et relie RevenueCat au compte (un achat
  suit le membre d'un téléphone à l'autre) ; `logOut` oublie les deux.
- **Écran Premium** (avant le 5/11 pour l'achat, le reste d'aujourd'hui) :
  - pas actif : les formules de l'offre courante (mensuel, 6 mois, annuel, à vie) en tuiles, le badge
    d'économie, l'essai éventuel, les mentions du store, le bouton doré « S'abonner » / « Acheter à
    vie », « Restaurer », Conditions, Confidentialité ; pas de formule (pas de clé, store injoignable) :
    « Les offres ne sont pas disponibles pour l'instant » et « Réessayer » ;
  - actif : la carte « Tu as Premium », le renouvellement par demande de paiement (site) et
    « Arrêter le renouvellement » comme aujourd'hui ; « Gérer mon abonnement » (Customer Center de
    RevenueCat) seulement pour un achat fait dans un store.
- **Plus aucun lien vers le paiement du site dans l'app** (Apple hors États-Unis, Google). La
  constante `PREMIUM_ON_SITE` et les textes `onSite` partent.
- Clés publiques RevenueCat dans `.env` (et le secret `DOT_ENV`) : `REVENUE_CAT_TEST_API_KEY` (dev),
  `REVENUE_CAT_APPLE_API_KEY`, `REVENUE_CAT_GOOGLE_API_KEY`. Sans clé : seul le serveur compte, et
  l'écran dit que les offres ne sont pas disponibles.
- L'outil `tool/review_screenshot_test.dart` revient : la capture de l'écran d'achat pour la relecture
  d'Apple (jointe à chaque produit).

## Hors périmètre

- Le serveur et le site ne sont pas prévenus d'un achat fait dans un store (webhook RevenueCat plus
  tard) : sur le site, un membre qui a acheté dans l'app ne voit pas Premium.
- Les prix des stores (fixés dans App Store Connect et la Play Console).

## Laissé au constructeur

- Les textes rendus aux 7 langues : ceux d'avant le 5/11 (`867b4a8^`), repris tels quels.
