# Plan de lecture : un nombre de jours libre (design court, validé le 17/11/2026)

## Pourquoi
Le membre veut un plan court et intensif, par ex. « le Nouveau Testament en 3 jours ». Le calcul
(`ReadingPlan`) accepte déjà 1 à 730 jours ; seul l'écran bloque : « Autre » part de 120, descend à
20 au plus bas, par pas de 10.

## Ce qui change (écran `_Setup` de `BiblePlanScreen`)
1. « Autre » va de **1 à 730 jours**.
2. **Le nombre se tape** : toucher « 120 jours » ouvre une petite fenêtre (« Nombre de jours », clavier
   numérique, « De 1 à 730 jours », Annuler / OK ; OK seulement pour une valeur de 1 à 730).
3. **Les boutons − / +** avancent de 1 en 1 sous 30 jours, de 10 en 10 au-delà (`stepCustomDays`,
   pur, dans `domain/reading_plan.dart` ; jamais sous 1 ni au-dessus de 730 ; en descendant on
   s'arrête à 30 avant de passer aux pas de 1). Leur info-bulle dit le pas (« −1 », « +10 »).
4. Le rythme (« environ 86,7 par jour ») est **déjà** affiché dans le résumé : rien à faire.

Inchangé : ce qu'on lit, l'ordre, le rappel, le suivi (l'écran de suivi défile déjà : 87 chapitres
du jour s'affichent).

## Approches
- Retenue : saisie au clavier + pas adaptés. Atteindre 3 comme 400 en quelques gestes.
- Écartées : pas de 1 partout (trop de touchers pour 400) ; un curseur (imprécis de 1 à 730).

## Tests
`stepCustomDays` (bornes, passage 29↔30↔40) ; écran : Autre → taper 3 → Nouveau Testament →
« 260 chapitres en 3 jours, environ 86,7 par jour » → −1 donne 2 jours → « Commencer » → « Jour 1 sur 2 ».
