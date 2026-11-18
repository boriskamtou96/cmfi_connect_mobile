# Premium : achat dans l'app, plan d'implémentation

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal :** Premium s'achète de nouveau dans l'app (App Store, Google Play, via RevenueCat), à côté de l'achat sur le site que l'app continue de reconnaître.

**Architecture :** `PremiumStore` (`core/services/premium_store.dart`) garde son rôle et gagne l'achat : `plans`, `buy`, `restore`, `manage`, `boughtInStore`. L'implémentation réelle `AppPremiumStore` réunit `ServerPremiumStore` (le serveur) et `RevenueCatShop` (le code d'avant `867b4a8`). L'écran Premium reprend les formules et l'achat d'avant le 5/11, garde la carte « Tu as Premium » et le renouvellement d'aujourd'hui.

**Tech Stack :** Flutter 3.38, Riverpod 3, purchases_flutter et purchases_ui_flutter 10.x, slang.

**Spec :** `docs/superpowers/specs/2026-11-18-premium-achat-integre-design.md`

## Global Constraints

- Aucun lien vers le paiement du site dans l'app ; `AppConfig.premiumOnSite` et `premium.onSite` disparaissent.
- Entitlement `cmfi_connect_pro` ; offre courante, paquets Monthly, Six Month, Annual, Lifetime.
- Clés `.env` : `REVENUE_CAT_TEST_API_KEY` (dev seulement), `REVENUE_CAT_APPLE_API_KEY`, `REVENUE_CAT_GOOGLE_API_KEY` ; sans clé, pas de RevenueCat.
- Textes : ceux de `867b4a8^` dans les 7 langues ; `unavailable` redevient « Les offres ne sont pas disponibles pour l'instant. »
- `flutter analyze && flutter test` verts ; commit seulement à la fin (demandé par l'utilisateur : « fais tout »).

## Review Focus

- Un membre Premium par le site ouvre l'écran : la carte « Tu as Premium » et son renouvellement, pas de « Gérer mon abonnement ».
- RevenueCat injoignable ou sans clé : le Premium du serveur compte toujours ; l'écran dit que les offres manquent.
- La déconnexion oublie le Premium des deux sources ; un autre compte ne l'hérite pas.
- Un achat annulé (feuille du store fermée) : rien ne change, pas d'erreur.
- La capture de relecture montre les 4 formules aux prix du store, sans Premium actif.

---

### Task 1 : le magasin réunit le serveur et RevenueCat

**Files :** `pubspec.yaml`, `lib/src/core/config/app_config.dart`, `lib/src/core/services/premium_store.dart`, `test/core/services/premium_store_test.dart`, `test/helpers/fakes.dart`, `android/.../MainActivity.kt` (commentaire).

**Interfaces :**
- `PremiumPeriod`, `PremiumPlan` (comme `867b4a8^`).
- `abstract class PremiumStore` : en plus d'aujourd'hui, `Future<List<PremiumPlan>> plans()`, `Future<bool> buy(PremiumPlan)`, `Future<bool> restore()`, `Future<void> manage()`, `bool get boughtInStore`.
- `abstract class PremiumShop` (`isActive`, `changes`, `logIn`, `logOut`, `plans`, `buy`, `restore`, `manage`, `refresh`) ; `RevenueCatShop(key)` ; `NoPremiumShop`.
- `AppPremiumStore(ServerPremiumStore server, PremiumShop shop)` : actif = serveur || shop ; `changes` des deux ; `boughtInStore` = shop actif.
- `AppConfig.revenueCatKey` (comme `867b4a8^`).

- [ ] Tests (`premium_store_test.dart`) avec un faux shop : actif par le serveur seul, par le shop seul ; `logOut` oublie les deux ; un `changes` du shop passe.
- [ ] Les voir échouer, écrire le code, les voir passer.

### Task 2 : l'écran Premium vend dans l'app

**Files :** `lib/src/features/premium/presentation/premium_screen.dart`, `lib/src/features/premium/application/premium_plans.dart`, les 7 `*.i18n.json`, `test/features/premium/premium_test.dart`.

- [ ] Tests (repris de `867b4a8^`) : « the year of the summary leads to Premium, bought in one tap » ; « restoring without purchase says so » ; « for life: paid once, then managed in the Customer Center » ; « bought on the site: no Customer Center, the renewal shows » ; « no plans: said, and asked again ».
- [ ] Les voir échouer, écrire l'écran, les voir passer.

### Task 3 : la capture de relecture et la doc

**Files :** `tool/review_screenshot_test.dart` (de `867b4a8^`, adapté), `CLAUDE.md` (section Premium).

- [ ] `flutter test tool/review_screenshot_test.dart` écrit `store/review/premium_paywall_fr.png` et `_en.png`.
- [ ] `flutter analyze && flutter test` verts.
