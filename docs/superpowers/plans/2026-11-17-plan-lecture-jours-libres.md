# Plan de lecture, jours libres : plan d'implémentation

**Goal:** « Autre » de 1 à 730 jours, nombre tapé au clavier, pas de 1 sous 30 jours.
**Spec:** `docs/superpowers/specs/2026-11-17-plan-lecture-jours-libres-design.md`
**Contraintes :** pas de commit sans demande ; une clé de texte ajoutée l'est dans les 7 langues (slang, `make gen` ou `dart run slang`).

### Task 1: `stepCustomDays`
- `lib/src/features/bible/domain/reading_plan.dart` : `const customDaysMin = 1`, `const customDaysMax = 730`, `int stepCustomDays(int days, {required bool up})`.
- Test `test/features/bible/reading_plan_test.dart` « custom days: 1 by 1 under 30, then 10 by 10 » :
  up 1→2, 29→30, 30→40, 725→730, 730→730 ; down 40→30, 30→29, 2→1, 1→1, 35→30.

### Task 2: l'écran
- `bible_plan_screen.dart` (`_Setup`) : bornes et pas par `stepCustomDays` ; info-bulles `−1`/`−10`, `+1`/`+10` ; le nombre est un bouton qui ouvre `_askDays` (AlertDialog, TextField chiffres seuls, 3 caractères).
- Textes `biblePlan.customDays` (« Nombre de jours ») et `biblePlan.customDaysHint` (« De 1 à 730 jours ») dans les 7 langues.
- Test widget « a custom plan: the New Testament in 3 days » (scénario du spec).

### Task 3: vérification
`flutter analyze`, suite complète, CLAUDE.md (§ Bible, plan de lecture : « Autre » de 1 à 730, tapé ou par pas de 1 sous 30).
