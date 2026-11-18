# Dons et Premium dans la devise du pays — plan d'implémentation

> **For agentic workers:** REQUIRED SUB-SKILL: superpowers:executing-plans (choisi par l'utilisateur : exécution directe). Steps use checkbox (`- [ ]`).

**Goal:** la devise (XAF, XOF, USD) et le moyen de paiement mis en avant suivent le pays du numéro du compte, pour les dons (app) et Premium (site), avec KPay.

**Architecture:** le serveur décide de tout. Il lit le pays dans l'indicatif du numéro du compte, en déduit la devise de la carte, la devise du Mobile Money (celle de l'opérateur) et le moyen préféré, puis les expose à l'app et au site. Ceux-ci affichent ce que le serveur dit et renvoient la devise affichée, que le serveur vérifie.

**Tech Stack:** Go 1.x + gin + sqlc (serveur), Flutter + Riverpod + freezed (app), Astro + script TS (site).

**Spec:** `docs/superpowers/specs/2026-11-18-devises-par-pays-design.md`

## Global Constraints

- **Serveur :**
  - Branche `dev`, accord donné le 18/11/2026 pour `api/payments.go`, un nouveau `api/currencies.go`, `internal/utils/config.go` et leurs tests.
  - Ni migration ni `sqlc generate`.
  - Tests sur une base jetable seulement (`TEST_DATABASE_URL`, jamais `cmfi_connect`).
  - `gofmt` sur les fichiers touchés : couvert par l'accord.
- **App :** branche `dev`. Après un changement freezed, lancer `make gen` (ou `make gen-clean`). Ne jamais commiter `.env` ni `app_log.dart`.
- **Site :** branche `feat/kpay-integration` (pas `prod` : la production paie avec Wajub, donc tout y reste en XAF). `npm run check` doit passer.
- **Commits :** pas de commit sans demande de l'utilisateur.
- **Wajub :** avec `PAYMENT_PROVIDER` autre que `kpay`, tout reste en XAF.
- **Prix USD :** `monthly:5,six_month:25,yearly:50,lifetime:100`. Prix XOF par défaut = ceux de XAF.
- **Dons :**

  | Devise | Montants proposés | min | min carte | max |
  |---|---|---|---|---|
  | XAF et XOF | 1000, 2000, 5000, 10000 | 100 | 1000 | 500000 |
  | USD | 5, 10, 25, 50 | 1 | 1 | 1000 |

- **Indicatifs :**
  - XAF : 237, 241, 242, 235, 236, 240.
  - XOF : 225, 221, 229, 226, 223, 227, 228, 245.
  - Tout autre numéro : USD.
- **Compatibilité :** une requête de paiement sans `currency` (anciennes versions de l'app ou du site) est en XAF, comme avant.

## Review Focus

- Un compte sans numéro, ou au numéro sans « + » : pays vide, donc USD pour la carte et Mobile Money en XAF. Ne doit jamais planter. *(Task 1.)*
- Un membre +33 qui choisit Mobile Money avec un numéro camerounais : paie en XAF, et l'app affiche des FCFA. *(Tasks 3 et 4.)*
- Une ancienne app (sans `currency`) d'un membre +33 qui donne par carte : facturé en XAF, comme avant, et non en USD. *(Task 3.)*
- Un don par carte de 500 XAF : refusé par le serveur avant KPay, avec 409 `AMOUNT_OUT_OF_BOUNDS`. *(Task 3.)*
- Avec Wajub, `card_currency` vaut XAF et les prix USD ne sont jamais proposés. *(Task 3.)*

---

### Task 1: pays et devise d'un numéro (serveur, pur)

**Files:** Create `cmfi-connect-backend/api/currencies.go`, Test `api/currencies_test.go`.

**Interfaces — Produces:**
- `func countryOfPhone(phone string) string` : `"CM"`, `"SN"`… ou `""`. Ne lit que les numéros internationaux (`+` puis chiffres ; espaces ignorés).
- `func cardCurrencyOf(country string) string` : `"XAF"`, `"XOF"` ou `"USD"`.
- `type donationRule struct { Currency string; Amounts []int64; Min, CardMin, Max int64 }` (balises JSON `currency, amounts, min, card_min, max`).
- `var donationRules = map[string]donationRule{...}` avec les valeurs des contraintes globales.

- [ ] Test `TestTheCountryOfANumberGivesItsCardCurrency`, table de cas :
  - `+237670000000` → CM / XAF ;
  - `+241…` → GA / XAF ;
  - `+225…` → CI / XOF ;
  - `+221…` → SN / XOF ;
  - `+33612345678` → "" / USD ;
  - `+1…` → USD ;
  - `""` → "" / USD ;
  - `237670000000` (sans +) → "" / USD ;
  - `+237 6 70 00 00 00` → CM.
- [ ] `go test ./api -run TestTheCountryOfANumber` : échoue (indéfini).
- [ ] Écrire le fichier.
- [ ] Relancer : PASS. Ce test ne touche pas la base, mais `TestMain` ouvre une connexion : passer `TEST_DATABASE_URL` vers la base jetable.

### Task 2: prix Premium par devise (config)

**Files:** Modify `internal/utils/config.go`.

**Interfaces — Produces:**
- Champs `PremiumPricesXOF`, `PremiumPricesUSD map[string]int64` dans `PaymentsConfig`.
- `func (p PaymentsConfig) PremiumPricesIn(currency string) map[string]int64` :
  - XAF → `PremiumPrices` ;
  - XOF → `PremiumPricesXOF`, sinon `PremiumPrices` s'il est vide ;
  - USD → `PremiumPricesUSD` ;
  - autre → nil.
- `parsePrices(name, value string)` : le nom de la variable apparaît dans l'erreur.
- Variables `PREMIUM_PRICES_XOF` et `PREMIUM_PRICES_USD`. La valeur par défaut d'USD est la grille ci-dessus.

- [ ] Test `TestPremiumPricesFollowTheCurrency` dans `api/currencies_test.go`. Monter un `utils.PaymentsConfig{PremiumPrices: {"monthly":1500}, PremiumPricesUSD: {"monthly":5}}` :
  - XAF → 1500 ;
  - XOF → 1500 (repli) ;
  - USD → 5 ;
  - EUR → nil.
- [ ] Rouge, implémenter, vert. `go build ./...` doit passer.

### Task 3: l'API choisit la devise

**Files:** Modify `api/payments.go`. Test `api/payments_test.go`.

**Interfaces:**
- Consumes : Tasks 1 et 2.
- Produces : `func (s *Server) chargeCurrency(ctx context.Context, userID int64, method, asked string) (string, error)`.
  - Si `Provider != kpay` : XAF.
  - Si `asked` est vide : XAF (compatibilité).
  - Sinon, la devise attendue est XAF pour le Mobile Money (devise de l'opérateur) et `cardCurrencyOf(countryOfPhone(numéro du compte))` pour la carte.
  - Si `asked` diffère de la devise attendue : erreur `errCurrencyMismatch`, réponse 409 `CURRENCY_MISMATCH`.

**Changements de l'API :**
- `donationRequest` et `premiumPaymentRequest` gagnent `Currency string json:"currency"`.
- `donate` :
  - borne avec `donationRules[currency]` ;
  - `CardMin` pour la carte, `Min` sinon ;
  - `Max` dans tous les cas.
- `payForPremium` : prix tiré de `PremiumPricesIn(currency)[plan]`. Un plan absent dans cette devise donne 400.
- `listPaymentProviders` ajoute :
  - `country` ;
  - `card_currency` (XAF si Wajub) ;
  - `preferred` : `mobile_money` si un opérateur de `s.operators()` est du pays (comparer `operator.Country` en ISO3 « CMR » ; table ISO2→ISO3 pour les 14 pays ou comparaison avec le préfixe), sinon `card`. Si les cartes sont coupées : toujours `mobile_money` ;
  - `donations` : les règles des devises utilisables, soit XAF plus `card_currency` si différente. Avec Wajub : XAF seul.
- `listPremiumPlans` ajoute `prices` : `{XAF: [...], XOF: [...], USD: [...]}`, au même format que `plans`. Avec Wajub : XAF seul.
- `getPremiumStatus` ajoute `card_currency` et `preferred`, même calcul que pour les fournisseurs.

**Tests :**
- Monde KPay : `newPaymentsWorld(t)` puis `w.server.config.Pay.Provider = utils.ProviderKPay`, `KPayCards = true`, `PremiumPricesUSD` défini.
- Numéro +33 : `runSQL(t, "UPDATE users SET phone_number=$1 WHERE id=$2", "+33612345678", m.ID)`.

- [ ] `TestADonationByCardIsInTheCurrencyOfTheAccountsCountry` :
  - membre +33, KPay ;
  - `/payments/providers` → `card_currency` USD, `preferred` card, `donations` contient XAF et USD ;
  - don `{amount:10, currency:"USD", method:"card"}` → `Currency` USD, montant 10, et `w.money.inits[id].Currency == "USD"` ;
  - `{amount:10, currency:"XAF", method:"card"}` → 409 `CURRENCY_MISMATCH` ;
  - `{amount:2000, currency:"USD", method:"card"}` → 409 `AMOUNT_OUT_OF_BOUNDS`.
- [ ] `TestMobileMoneyStaysInTheOperatorsCurrency` :
  - membre +33, KPay, `{amount:1000, currency:"XAF", phone_number:"+237670000009"}` → XAF ;
  - `{…, currency:"USD"}` → 409 `CURRENCY_MISMATCH`.
- [ ] `TestAnOldAppWithoutACurrencyStillPaysInXAF` :
  - membre +33, KPay, `{amount:2500, method:"card"}` → XAF 2500 ;
  - `{amount:500, method:"card"}` → 409 `AMOUNT_OUT_OF_BOUNDS` (min carte 1000).
- [ ] `TestPremiumByCardIsPricedInTheAccountsCurrency` :
  - membre +33, KPay ;
  - `/premium/plans` → `prices.USD` contient `{monthly, 5}` ;
  - `/premium/status` → `card_currency` USD ;
  - `/premium/payments {plan:"monthly", method:"card", currency:"USD"}` → montant 5, devise USD.
- [ ] `TestWithWajubEverythingStaysInXAF` :
  - membre +33, monde par défaut ;
  - `/payments/providers` → `card_currency` XAF, `donations` = XAF seul ;
  - `/premium/plans` → `prices` n'a que XAF ;
  - don carte avec `currency:"XAF"` → XAF.
- [ ] Un membre +237 sous KPay : `preferred` vaut `mobile_money` (dans le premier test, avec un second membre).
- [ ] Lancer `go test ./api -run 'Currency|InXAF|Wajub|Donation|Premium' -count=1` sur la base jetable : rouge, puis implémenter, puis vert. Ensuite `go test ./api -count=1` en entier, puis `go vet ./...`.

### Task 4: l'app

**Files:**
- Modify `lib/src/features/payments/domain/payment.dart` (`PaymentOptions`).
- Modify `infrastructure/payments_api.dart` (`donate` prend `String? currency`).
- Modify `presentation/donation_screen.dart`.
- Modify `test/helpers/fakes.dart`.
- Test `test/features/payments/donation_test.dart`.

**Interfaces — Produces :**
- `PaymentOptions` :
  - `String cardCurrency` (défaut `'XAF'`) ;
  - `String preferred` (défaut `'mobile_money'`) ;
  - `List<DonationRule> donations` (défaut vide).
- `DonationRule` (freezed) : `currency`, `amounts`, `min`, `cardMin`, `max`.
- `DonationRule.fallback` : XAF, `[1000,2000,5000,10000]`, 100, 100, 500000. Il garde l'ancien comportement : sans les nouveaux champs, le minimum de la carte reste 100.
- `PaymentOptions.ruleFor(String currency) → DonationRule` : la règle de cette devise, sinon `fallback`.
- `donate(..., String? currency)` envoie `currency` seulement si non nul.

**Écran :**
- Le moyen choisi au départ est `preferred` (si les cartes sont ouvertes), et ce moyen passe en premier dans le choix.
- La devise vaut `cardCurrency` pour la carte, XAF pour le Mobile Money.
- Les montants proposés et les bornes viennent de `ruleFor(devise)`, avec `cardMin` pour la carte.
- Changer de moyen change la devise ; le montant revient alors à `amounts.first` de la nouvelle devise.
- `formatMoney(montant, devise, locale)` existe déjà.
- Le don est envoyé avec `currency: devise` seulement si `donations` n'est pas vide (nouveau serveur).
- La constante `_currency` disparaît ; `donationAmounts`, `minDonation` et `maxDonation` passent dans `DonationRule.fallback`.
- `FakePaymentsApi` : `options` configurable (`paymentOptions`), et `donations` enregistre `currency`.

**Tests :**
- [ ] `a member abroad gives by card in dollars` : options `{cards: true, cardCurrency: 'USD', preferred: 'card', donations: [XAF…, USD 5/10/25/50, 1, 1, 1000]}`. Résultat attendu :
  - la carte est choisie ;
  - « 5 $ » (ou le format de `formatMoney` pour USD en fr) est visible ;
  - toucher le deuxième montant puis donner → don `amount 10, currency 'USD', method card`.
- [ ] `… back to FCFA with mobile money` : même options, choisir Mobile Money → montants en FCFA ; le don part avec `currency 'XAF'`.
- [ ] Les tests de don existants passent sans changement : ancien serveur, XAF, Mobile Money en premier.
- [ ] `make gen`, puis `flutter test test/features/payments`, puis `flutter analyze`.

### Task 5: le site

**Files:**
- Modify `src/views/PremiumView.astro` (script).
- Modify `src/data/dialCodes.ts` (rien si le code pays → indicatif y est déjà).
- Modify `CLAUDE.md` du site.

**Changements :**
- `currencyOfDial(dial: string): 'XAF'|'XOF'|'USD'` : mêmes indicatifs que le serveur.
- Les plans viennent de `prices[currency] ?? plans`.
- Avant la connexion, `currency` suit l'indicatif choisi dans le formulaire de connexion (à l'événement `change` du select). Après la connexion, il suit `status.card_currency`.
- `preferred` présélectionne le moyen.
- Le Mobile Money affiche les prix `prices.XAF` ; la carte affiche `prices[card_currency]`.
- `money()` : USD s'affiche « 5 $ » (via `Intl.NumberFormat(locale, {style:'currency', currency:'USD', maximumFractionDigits: 0})`).
- `POST /premium/payments` envoie `currency`.

**Vérification :**
- [ ] `npm run check` : PASS.
- [ ] Essai navigateur contre le serveur local KPay sandbox (`landing-kpay-sandbox`, :4330 → :8095 relancé avec le nouveau code), avec un compte de test passé en +33 sur la base locale de ce serveur.
  - Attendu : prix en $, carte en premier.
  - Avec le compte +237 : FCFA, Mobile Money en premier.

### Task 6: docs et vérification finale

- [ ] CLAUDE.md de l'app : § Premium / dons, quelques lignes sur `PaymentOptions.donations`, `cardCurrency` et `preferred`.
- [ ] CLAUDE.md du site : § « Premium par mobile money ».
- [ ] Le CLAUDE.md du serveur ne contient que des règles : ne rien y ajouter.
- [ ] Suites complètes :
  - serveur `go test ./... -count=1` (base jetable) ;
  - app `flutter test` ;
  - site `npm run check`.
- [ ] Relecture finale indépendante.
