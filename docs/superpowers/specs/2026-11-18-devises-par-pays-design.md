# Dons et Premium dans la devise du pays (design, 18/11/2026)

## Pourquoi

Les dons (app) et Premium (site) sont en francs CFA (XAF) pour tout le monde. Un membre hors du
Cameroun voit « 5 000 FCFA » sans savoir ce que c'est et ne s'y retrouve pas. L'utilisateur veut que
**la devise suive le pays choisi à la connexion / à l'inscription**, et que **le moyen de paiement mis
en avant** suive aussi ce pays.

## Ce que KPay permet (testé en sandbox le 18/11/2026)

- Devises : CDF, KES, RWF, SLE, UGX, USD, XAF, XOF, ZMW. **Pas d'euro.**
- Mobile Money : la devise doit être celle de l'opérateur (« En mode USSD, currency doit correspondre
  à la devise du provider (XAF) »). Seuls MTN et Orange Cameroun sont activés chez nous.
- Carte (`paymentMethod: CARD`) : acceptée en USD, XOF et XAF (testé), **minimum 1 USD après conversion** :
  1 000 FCFA passe, 500 FCFA est refusé.

## Approches (choisie : A)

- **A, retenue :** les devises de KPay selon le pays (XAF, XOF, USD), prix fixés à la main par devise.
- B, écartée : afficher un équivalent mais facturer en XAF. La page de KPay resterait en FCFA.
- C, plus tard peut-être : ajouter Stripe pour €, £, $ CA. Il faudrait un second prestataire et un
  compte de plus.

## Décisions de l'utilisateur

- Le pays est celui **choisi à la connexion / à l'inscription**, c'est-à-dire l'indicatif du numéro du
  compte (+237 → Cameroun). C'était ma proposition, validée.
- Pays → devise :
  - **XAF** : CM, GA, CG, TD, CF, GQ (+237, +241, +242, +235, +236, +240) ;
  - **XOF** : CI, SN, BJ, BF, ML, NE, TG, GW (+225, +221, +229, +226, +223, +227, +228, +245) ;
  - **USD** : tous les autres pays, RDC et Kenya compris pour l'instant.
- Moyen mis en avant :
  - Mobile Money en premier là où un opérateur est activé pour le pays (le Cameroun aujourd'hui) ;
  - la carte en premier ailleurs ;
  - l'autre moyen reste proposé en dessous.
- Le Mobile Money se paie toujours dans la devise de l'opérateur (XAF pour MTN et Orange Cameroun).
- Prix :

  | | XAF et XOF | USD |
  |---|---|---|
  | Premium 1 mois | 1 500 | **5** |
  | Premium 6 mois | 6 000 | **25** |
  | Premium 1 an | 12 000 | **50** |
  | Premium à vie | 50 000 | **100** |
  | Dons proposés | 1 000 · 2 000 · 5 000 · 10 000 | 5 · 10 · 25 · 50 |
  | Don min / max | 100 / 500 000 (carte : **1 000** min) | 1 / 1 000 |

- Non concerné : les frais d'inscription aux évènements restent dans la devise de l'organisateur (XAF).

## Le comportement

### Serveur (cmfi-connect-backend)

1. **Pays et devise d'un compte.**
   - `countryOfPhone(numéro)` lit l'indicatif du numéro international du compte : les 14 indicatifs
     ci-dessus, sinon « autre ».
   - `cardCurrency(pays)` donne XAF, XOF ou USD.
2. **Avec Wajub** (`PAYMENT_PROVIDER` différent de `kpay`), **rien ne change** : tout reste en XAF.
   Wajub, toujours en service en production, n'a pas été vérifié pour d'autres devises.
3. **Prix Premium par devise** :
   - `PREMIUM_PRICES` reste le prix en XAF ;
   - nouvelles variables `PREMIUM_PRICES_XOF` (par défaut, celles de XAF) et `PREMIUM_PRICES_USD`
     (par défaut `monthly:5,six_month:25,yearly:50,lifetime:100`).
4. **Bornes et montants de don par devise** : des constantes du serveur, données par l'API (l'app
   ne les code plus en dur).
5. **`GET /v1/payments/providers`** (avec compte) ajoute :
   - `country` : CM… ou vide ;
   - `card_currency` ;
   - `preferred` : `mobile_money` si un opérateur activé est de ce pays, sinon `card` ;
   - `donations` : pour chaque devise utilisable par ce membre, `{currency, amounts, min, card_min, max}`.
    *(Choix de Claude, après la relecture : KPay refuse une carte sous 1 USD ; en XAF et XOF la carte
    commence à 1 000, le Mobile Money à 100 ; le minimum suit le moyen choisi dans l'app.)*

   Les champs existants ne changent pas.
6. **`GET /v1/premium/plans`** (sans compte) garde ses champs XAF (`currency`, `plans`) et ajoute
   `prices` : `{XAF: [...], XOF: [...], USD: [...]}`.
7. **`GET /v1/premium/status`** ajoute `card_currency` et `preferred` pour le membre.
8. **`POST /v1/premium/payments`** et **`POST /v1/donations`** :
   - la devise est **décidée par le serveur** : la devise de l'opérateur pour le Mobile Money, la
     devise du compte pour la carte ;
   - le prix Premium est celui de cette devise ;
   - le don prend un champ facultatif `currency`. Absent (anciennes versions de l'app) = XAF, comme
     avant. Présent, il doit être la devise que le serveur aurait choisie (sinon 409
     `CURRENCY_MISMATCH`), et le montant doit respecter les bornes de cette devise ;
   - le paiement garde sa devise (`payments.currency` existe déjà).

   Le renouvellement Premium reste en Mobile Money, donc en XAF.
9. Aucune migration : la colonne `payments.currency` existe.

### App (cmfi_connect_mobile)

`DonationScreen` :
- la devise, les montants proposés et les bornes viennent de `PaymentOptions` (`donations`), plus de
  `_currency = 'XAF'` ;
- le moyen mis en avant (`preferred`) est présélectionné et passe en premier ;
- changer de moyen change la devise affichée (carte : `card_currency` ; Mobile Money : celle de
  l'opérateur), et le montant choisi revient au premier montant proposé de cette devise ;
- l'app envoie `currency`.

Sans les nouveaux champs (ancien serveur), on garde le comportement actuel en XAF.

### Site (cmfi-connect-landing-page, `PremiumView`)

- Avant la connexion, la devise suit le pays de l'indicatif choisi dans le formulaire de connexion
  (`dialCodes` → pays → devise, même règle que le serveur, 14 indicatifs).
- Après la connexion, `card_currency` et `preferred` de `/premium/status` décident.
- Les prix viennent de `prices[devise]`. Le moyen préféré est présélectionné.
- Le libellé du prix s'adapte : « 5 $ / mois », « 1 500 FCFA / mois ».

## Conséquences à connaître

- Chez KPay, les paiements en USD et XOF arrivent sur **des soldes séparés** du solde XAF. Les
  reversements de l'app (`payouts.go`, vers un Mobile Money) ne touchent que le XAF. Les autres se
  retirent depuis le tableau de bord KPay.
- Les rapports admin des paiements montrent déjà la devise de chaque paiement. Les totaux
  multi-devises n'y sont pas additionnés : à vérifier pendant l'implémentation.

## Hors périmètre

- L'euro et les autres devises hors KPay (approche C).
- Les devises CDF, KES, RWF, UGX, ZMW, SLE.
- Les opérateurs Mobile Money hors Cameroun.
- Les évènements.

## Tests attendus

- **Serveur :**
  - `countryOfPhone` et `cardCurrency` (14 indicatifs, +33, +1, numéro vide) ;
  - un don par carte d'un compte +33 en USD, un don sans `currency` en XAF, un don USD hors bornes ;
  - Premium carte en USD au prix USD ;
  - Mobile Money toujours en XAF ;
  - avec Wajub, tout en XAF.
- **App :**
  - un membre +237 voit Mobile Money en premier et des montants en FCFA ;
  - un membre +33 voit la carte en premier et des montants en $, puis passe en FCFA en choisissant
    Mobile Money ;
  - un ancien serveur sans `donations` garde le XAF.
- **Site :** `npm run check`, et un essai dans le navigateur avec un compte sandbox +33 contre le
  serveur local.
