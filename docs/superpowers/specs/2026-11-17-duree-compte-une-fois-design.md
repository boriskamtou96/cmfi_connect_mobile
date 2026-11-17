# Une durée compte aussi une fois (design court, validé le 17/11/2026)

## Pourquoi

Le membre chronomètre une méditation, ou en met la durée, et le nombre de fois reste à 0. Il doit
alors le remplir lui-même. Une méditation faite, c'est une fois, et sa durée en plus.

## Ce qui est concerné

Un élément qui compte à la fois un nombre **de fois** et une durée (`ReportEntry.countsTimes`) :

- éléments standards : ceux dont l'unité est `StandardUnit.times` et qui comptent aussi une durée,
  soit Méditation (RDQAD) et Prière en groupe (PG) ;
- éléments personnels qui ont un nombre et une durée, avec **une unité laissée vide**. *(Choix de
  Claude : on ne peut pas deviner une unité tapée librement ; « pages » ne doit pas bouger.)*

Pas concernés : Lecture biblique (chapitres), Littérature chrétienne (pages), Prière seule (durée
seule), et tout ce qui n'a pas de durée.

## Comportement

1. **Chrono terminé** (`ReportTimer.finish` → `addMinutesToDayReport`) : les minutes s'ajoutent comme
   avant et, pour un élément `countsTimes`, le nombre augmente de 1. Deux chronos donnent « 2 fois ».
   Choisi par l'utilisateur : « Chaque chrono ajoute 1 ».
2. **Saisie dans la feuille** (préréglages, ±1 min, « Début – fin ») : quand la durée devient
   supérieure à 0 alors que le nombre est vide ou à 0, il passe à 1, sous les yeux du membre. Un
   nombre déjà à 1 ou plus n'est pas touché. Remis à 0 à la main, il le reste.
3. Retraites et importunité (`addMinutesToDayReportItem`, PS) : inchangées.

## Approches considérées

- **Retenue :** la règle dans l'app (une propriété de `ReportEntry` et deux points d'appel). Aucun
  changement de serveur ni de migration.
- Écartée : le serveur force le nombre à 1 à l'enregistrement. Le membre ne le verrait pas avant
  l'enregistrement, et chaque chrono ne pourrait pas ajouter 1.
- Écartée : ajouter 1 à chaque modification de durée dans la feuille. Le nombre grimperait à chaque
  toucher de ±1 min.

## Tests

- `countsTimes` : RDQAD, PG oui ; LB, LLC, PS, JC non ; personnel sans unité oui, avec unité non.
- Chrono : RDQAD 0 → 1 puis 2, minutes additionnées ; LB : nombre de chapitres inchangé.
- Feuille : RDQAD vide + préréglage de durée → nombre 1 ; nombre déjà à 3 → reste 3 ; LLC → inchangé.
