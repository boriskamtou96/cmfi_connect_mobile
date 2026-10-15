# Fiche des stores · CMFI Connect

Tout ce qu'il faut coller dans App Store Connect et la Google Play Console pour publier CMFI Connect. Textes en français, puis en anglais pour la fiche internationale. Les longueurs indiquées ont été comptées.

Rédigé le 14 octobre 2026 à partir du code de l'app (`lib/`), du serveur (`cmfi-connect-backend`) et des pages légales du site (`cmfi-connect-landing-page`). À relire après chaque nouvelle fonction qui touche aux données.

Ce qui reste à fournir est entre [crochets] et regroupé dans la liste de contrôle à la fin.

> **Version 1 (lancement) : sans achats, iPhone seulement.** Premium est offert à tous (`premiumForEveryoneProvider`) : pas d'abonnement à créer, pas d'« Achats intégrés », RevenueCat inactif. Les passages marqués *(v1.1)* servent quand les achats s'ouvriront. L'app n'est pas proposée sur iPad (`TARGETED_DEVICE_FAMILY = 1`) : pas de captures iPad.

---

## 1. Identité de la fiche

| Champ | Français | Anglais | Limite |
| --- | --- | --- | --- |
| Nom de l'app (App Store et Google Play) | `CMFI Connect` (12) | `CMFI Connect` (12) | 30 |
| Sous-titre (App Store) | `Compte rendu, prière et chants` (30) | `Daily report, prayer & hymns` (28) | 30 |
| Description courte (Google Play) | voir ci-dessous (74) | voir ci-dessous (78) | 80 |
| Texte promotionnel (App Store) | voir ci-dessous (166) | voir ci-dessous (163) | 170 |

- Nom : garder « CMFI Connect », le nom international, comme sous l'icône. Variante possible pour la fiche française seulement : `CMFI Connect · CMCI` (19), pour être trouvée par ceux qui cherchent « CMCI ». Recommandé : le nom seul, et « CMCI » dans les mots-clés.
- Sous-titre français, autre choix : `Prie, chante, grandis ensemble` (30), plus chaleureux mais sans « compte rendu ».
- Le sous-titre est déjà indexé par Apple : ses mots ne sont pas répétés dans les mots-clés.

### Description courte (Google Play, 80 max)

```text
Ton compte rendu spirituel, les cantiques, la prière et la vie de la CMCI.
```

```text
Your daily spiritual report, hymns, prayer and the life of the CMFI community.
```

### Texte promotionnel (App Store, 170 max, modifiable sans nouvelle version)

```text
Note ta journée avec Dieu en une minute, prie avec les retraites de 15 minutes, chante hors ligne et suis la vie de la CMCI dans 154 nations. L'essentiel est gratuit.
```

```text
Record your day with God in a minute, pray with 15-minute retreats, sing offline and follow the life of the CMFI community in 154 nations. The essentials are free.
```

### Mots-clés (App Store, 100 max, séparés par des virgules sans espace)

Français (92 caractères, 96 octets : certains outils comptent les accents double, ça passe dans les deux cas) :

```text
CMCI,église,chrétien,cantiques,Bible,jeûne,évangile,foi,retraite,disciple,culte,intercession
```

Anglais (98) :

```text
CMFI,church,christian,Bible,fasting,gospel,faith,disciple,devotional,worship,songs,retreat,mission
```

---

## 2. Description complète

Moins de 4 000 caractères chacune (français : 3 088 ; anglais : 2 787). Les puces « • » s'affichent bien dans les deux stores. Pas de prix écrits en dur : le store les affiche lui-même.

### Français

```text
CMFI Connect est l'app de la Communauté Missionnaire Chrétienne Internationale (CMCI) : un compagnon simple et fidèle pour ta marche avec Dieu, et un lien vivant avec tes frères et sœurs, où que tu sois.

TON COMPTE RENDU EN UNE MINUTE
• Note ta lecture biblique, ton temps de prière, tes jeûnes… et ajoute tes propres éléments.
• Fixe-toi des objectifs pour chaque jour et regarde l'anneau se remplir.
• Retrouve ton historique jour après jour et ton Bilan de la semaine ou du mois : régularité, progression, objectifs atteints.
• Un rappel le soir, seulement si ta journée n'est pas encore remplie.
• Exporte ton compte rendu en PDF, en tableur ou en message.

ENVOIE-LE À TES AUTORITÉS SPIRITUELLES
• Choisis ton rythme : chaque semaine, toutes les deux semaines ou chaque mois. L'app prépare ton compte rendu de la période.
• Envoie-le en un geste par WhatsApp, par e-mail ou en PDF à ceux qui t'accompagnent.
• Ajoute ton faiseur de disciples et tes autorités par leur pseudo : rien n'est partagé sans leur accord.

PRIE AVEC LA COMMUNAUTÉ
• Les retraites de prière de 15 minutes, le matin, à midi, le soir et la nuit, guidées minute par minute avec un son doux.
• Les sujets de prière de la communauté, point par point.
• Tes listes de prière : ceux qui n'ont pas encore cru, les croyants, les rétrogrades, les co-ouvriers. Rends grâce pour chaque prière exaucée.
• L'importunité : portez ensemble un sujet devant le Seigneur, proclamation après proclamation, jusqu'à l'objectif.

LES CANTIQUES, MÊME SANS RÉSEAU
• Les recueils de la communauté dans ta poche : Rendons ministère au Seigneur, Christ est vainqueur, Christ the Victor, Chants d'édification…
• Recherche par numéro, titre ou paroles, favoris et derniers ouverts.
• Grand texte, fond sépia ou sombre, et un mode projection pour le culte.

LA VIE DE LA CMCI
• Les évènements : affiche, programme jour par jour, actualités et photos.
• Inscription en quelques secondes, rappel la veille et une heure avant, ajout au calendrier.
• Les annonces des responsables, en notification et dans l'app.
• Notre ministère : un globe interactif des 154 nations où l'œuvre est présente, un voyage de nation en nation pour prier, et notre vision.

PENSÉE POUR TOI
• En 7 langues : français, anglais, allemand, espagnol, arabe, chinois et hindi.
• Thème clair ou sombre, et Zoé, notre petite colombe, pour t'encourager.
• Ton compte rendu n'est visible que par toi. Aucune publicité.

OFFERT POUR LE LANCEMENT
Le widget de l'écran d'accueil, avec ta journée et tes objectifs, l'année de ton Bilan et l'évolution de tes objectifs semaine après semaine sont offerts à tous.

Conditions d'utilisation : https://cmfi-connect.com/terms
Confidentialité : https://cmfi-connect.com/privacy

Grandir ensemble, chaque jour.
```

### English

```text
CMFI Connect is the app of the Christian Missionary Fellowship International (CMFI): a simple, faithful companion for your walk with God, and a living link with your brothers and sisters, wherever you are.

YOUR DAILY REPORT IN ONE MINUTE
• Record your Bible reading, prayer time, fasting… and add your own items.
• Set goals for each day and watch the ring fill up.
• See your history day by day and your weekly or monthly Summary: regularity, progress, goals reached.
• An evening reminder, only if your day is not filled in yet.
• Export your report as a PDF, a spreadsheet or a message.

SEND IT TO YOUR SPIRITUAL LEADERS
• Choose your rhythm: every week, every two weeks or every month. The app prepares your report for the period.
• Send it in one tap by WhatsApp, by e-mail or as a PDF to the people who walk with you.
• Add your disciple maker and your leaders by their username: nothing is shared without their consent.

PRAY WITH THE COMMUNITY
• 15-minute prayer retreats, morning, noon, evening and night, guided minute by minute with a soft chime.
• The community's prayer topics, point by point.
• Your prayer lists: those who have not believed yet, believers, backsliders, co-workers. Give thanks for every answered prayer.
• Importunity: carry a request before the Lord together, proclamation after proclamation, until the goal is reached.

HYMNS, EVEN OFFLINE
• The community's hymn books in your pocket: Christ the Victor, Christ est vainqueur, Rendons ministère au Seigneur, Chants d'édification…
• Search by number, title or lyrics, favorites and recently opened.
• Large text, sepia or dark background, and a projection mode for worship.

THE LIFE OF THE CMFI
• Events: poster, day-by-day program, news and photos.
• Register in seconds, reminders the day before and one hour before, add to your calendar.
• Announcements from the leaders, as notifications and in the app.
• Our ministry: an interactive globe of the 154 nations where the work is present, a journey from nation to nation to pray, and our vision.

MADE FOR YOU
• In 7 languages: English, French, German, Spanish, Arabic, Chinese and Hindi.
• Light or dark theme, and Zoé, our little dove, to cheer you on.
• Only you can see your report. No ads.

FREE FOR THE LAUNCH
The home-screen widget with your day and your goals, the year in your Summary and how your goals progress week after week are offered to everyone.

Terms of use: https://cmfi-connect.com/en/terms
Privacy: https://cmfi-connect.com/en/privacy

Growing together, every day.
```

Le nom anglais de la communauté (« Christian Missionary Fellowship International ») est à confirmer par le propriétaire.

---

## 3. Catégories

| Store | Recommandé | Pourquoi |
| --- | --- | --- |
| App Store, catégorie principale | **Style de vie** (Lifestyle) | Apple y range la religion et la spiritualité. Le cœur de l'app est une habitude quotidienne (le compte rendu) et la vie d'une communauté, pas la consultation d'un ouvrage. |
| App Store, catégorie secondaire | **Références** (Reference) | Les recueils de cantiques lus hors ligne, comme les apps de Bible. |
| Google Play | **Style de vie** (Lifestyle) | Même raison. « Enseignement » (Education) laisserait croire à des cours ; « Livres et références » est l'autre choix possible si l'on veut mettre les cantiques en avant. |

Étiquettes Google Play (au choix dans la console) : religion, spiritualité, habitudes, communauté.

---

## 4. Adresses (à confirmer)

Domaine pris dans `lib/src/core/config/app_config.dart` (`siteUrl = https://cmfi-connect.com`, avec un TODO « check once the site is online »). Toutes **à confirmer** une fois le site en ligne. Attention : le site vitrine a encore `url: 'https://cmfi-connect.example'` dans `src/config.ts`.

| Usage | Français | Anglais |
| --- | --- | --- |
| Assistance (support, obligatoire chez Apple) | https://cmfi-connect.com/ (le pied de page donne le contact) | https://cmfi-connect.com/en/ |
| Marketing (facultatif) | https://cmfi-connect.com/ | https://cmfi-connect.com/en/ |
| Politique de confidentialité | https://cmfi-connect.com/privacy | https://cmfi-connect.com/en/privacy |
| Conditions d'utilisation (EULA) | https://cmfi-connect.com/terms | https://cmfi-connect.com/en/terms |
| Suppression du compte (Google Play) | https://cmfi-connect.com/delete-account | https://cmfi-connect.com/en/delete-account |

- *(v1.1)* Apple : pour les abonnements, mettre le lien des conditions dans la description (fait ci-dessus) ou dans le champ « Contrat de licence ». Le contrat standard d'Apple suffit ; nos conditions y renvoient.
- Copyright (App Store) : `© 2026 Communauté Missionnaire Chrétienne Internationale`.
- E-mail de contact public (Google Play) : `[e-mail de contact]`.

---

## 5. Classification par âge

Résultat attendu : **4+** chez Apple, **3 / Tout public** chez IARC (Google Play), avec la mention « Interactions entre utilisateurs » (et « Achats intégrés » à partir de la v1.1). C'est le store qui calcule la note finale.

### Apple (questionnaire d'App Store Connect)

| Question | Réponse | Pourquoi |
| --- | --- | --- |
| Contrôle parental | Non | Pas de réglage parental dans l'app. |
| Vérification de l'âge | Non | L'âge n'est pas demandé à l'inscription. |
| Accès Web sans restriction | Non | Pas de navigateur intégré : les liens (itinéraire, WhatsApp, e-mail, conditions) ouvrent les apps du téléphone. |
| Contenu généré par les utilisateurs | **Oui, limité** (voir la note) | Un membre peut écrire un sujet d'importunité (titre, description) et y inviter un autre membre par son pseudo ; les demandes d'accompagnement montrent nom, église et assemblée. Pas de fil public, pas de commentaires. |
| Messagerie et discussion | Non | Aucune messagerie entre membres ; les envois aux autorités partent par WhatsApp ou e-mail, hors de l'app. |
| Publicité | Non | Aucune publicité. |
| Grossièretés ou humour vulgaire | Aucun | Contenus religieux publiés par les responsables. |
| Thèmes d'horreur ou de peur | Aucun | |
| Alcool, tabac ou drogues | Aucun | |
| Informations médicales ou de traitement | Aucune | Le jeûne est suivi comme pratique spirituelle, sans conseil de santé. |
| Thèmes de santé ou de bien-être | Non | Même raison. |
| Contenu sexuel ou nudité | Aucun | |
| Violence (dessin animé, réaliste, prolongée) | Aucune | |
| Jeux de hasard simulés, jeux d'argent, concours, coffres à butin | Aucun / Non | |

Note sur le contenu généré par les utilisateurs : répondre « Oui » est le plus honnête. Apple attend alors (règle 1.2) un moyen de signaler un contenu, de bloquer un membre et un contact publié. L'app permet déjà de refuser une invitation ou une demande, mais n'a ni « Signaler » ni « Bloquer ». Voir la liste de contrôle. Répondre « Non » se défend (rien n'est public, chaque échange suppose une invitation nominative), mais un examinateur qui voit les invitations peut le contester.

### Google Play (questionnaire IARC)

- Catégorie : **Toutes les autres applications** (ni jeu, ni réseau social, ni boutique). Raison : un outil personnel et communautaire. « Référence, actualités ou éducation » est le second choix.
- Violence, peur, sexualité, langage grossier, substances, humour vulgaire, discrimination : **Non** à tout.
- Jeux d'argent ou de hasard : **Non**.
- Les utilisateurs peuvent-ils interagir ou échanger du contenu ? **Oui** : invitations à un sujet d'importunité (texte court) et demandes d'accompagnement, entre membres qui se connaissent par leur pseudo.
- L'app partage-t-elle la position de l'utilisateur ? **Non**.
- Achats de biens numériques ? **Non** en v1 (*v1.1* : **Oui**, l'abonnement Premium).
- Accès Internet sans restriction ? **Non**.
- Public cible (section « Public cible et contenu ») : **13 ans et plus** (13–15, 16–17, 18+). Ne pas cocher les moins de 13 ans : l'app n'est pas conçue pour les enfants et sortirait alors du programme Familles. Cohérent avec `minAge = 13` des pages légales.
- Annonces : **Non**. Application d'actualités : **Non**. Application gouvernementale : **Non**. Fonctions financières : **Non**. Application de santé : **Non**.

---

## 6. Inventaire des données (vérifié dans le code)

| Donnée | Où | Lien avec le compte | Tiers |
| --- | --- | --- | --- |
| Prénom, nom, téléphone (identifiant), e-mail facultatif, pseudo, mot de passe (bcrypt) | Serveur | Oui | Hébergeur |
| Pays (code ISO), ville, église, assemblée | Serveur | Oui | Hébergeur |
| Comptes rendus (éléments, valeurs, notes), éléments personnels | Serveur (+ copie hors ligne) | Oui | Hébergeur |
| Objectifs du jour (`report_goals`) | Téléphone seulement | Non transmis | Aucun |
| Retraites faites, points priés, listes de prière (noms, notes), sujets d'importunité et proclamations | Serveur | Oui | Hébergeur |
| Autorités : liées par pseudo, ou saisies à la main (nom, téléphone, e-mail d'un tiers) | Serveur | Oui | Hébergeur |
| Inscriptions aux évènements (personnes, hébergement, ville de départ) | Serveur | Oui | Hébergeur |
| Jeton FCM, plateforme, langue ; annonces reçues et lues | Serveur + Google (FCM) | Oui | Google |
| Numéro vérifié par SMS (mot de passe oublié) | Google (Firebase Authentication) | Oui (numéro) | Google |
| Rapports de plantage : erreur, version, modèle et système, identifiant d'installation, numéro de compte | Google (Crashlytics), 90 jours ; rien en debug | Oui (numéro de compte) | Google |
| *(v1.1)* Achats Premium, état de l'abonnement, numéro de compte | RevenueCat, Apple, Google | Oui (numéro de compte) | RevenueCat, Apple, Google |
| Photo de profil (facultative, prise ou choisie puis recadrée ; réenregistrée sans ses métadonnées), visible des autres membres | Serveur | Oui | Hébergeur |
| Photos et affiches choisies par un admin | Serveur | Oui (admin) | Hébergeur |
| Journaux du serveur (IP, date, requête) | Serveur | Oui | Hébergeur |
| Réglage et historique de l'envoi aux autorités, favoris, réglages, widget | Téléphone seulement | Non transmis | Aucun |

Jamais collectés : position GPS, carnet d'adresses, calendrier (l'app ouvre seulement l'écran d'ajout du téléphone), identifiant publicitaire, mesure d'audience, carte bancaire. Aucun pistage (tracking).

---

## 7. App Store : « Confidentialité de l'app » (étiquettes)

- Collectez-vous des données ? **Oui**.
- Pistage (tracking) : **Non** pour tous les types. Aucune donnée n'est croisée avec celles d'autres entreprises pour de la publicité, ni transmise à un courtier.
- Toutes les données ci-dessous sont **liées à l'identité** de l'utilisateur, pour la finalité **Fonctionnalité de l'app** (qui couvre aussi « réduire les plantages »).

| Catégorie Apple | Type | Collecté | Remarque |
| --- | --- | --- | --- |
| Coordonnées | Nom | Oui | Prénom, nom. |
| Coordonnées | Adresse e-mail | Oui | Facultative. |
| Coordonnées | Numéro de téléphone | Oui | Identifiant de connexion ; vérifié par SMS pour le mot de passe oublié. |
| Coordonnées | Adresse postale, autres coordonnées | Non | |
| Données sensibles | Croyances religieuses | Oui | Église, assemblée, comptes rendus, prière. Les comptes rendus (éléments et pourcentages, sans la note) sont visibles des autorités spirituelles membres que l'utilisateur choisit lui-même ; il peut l'arrêter. |
| Localisation | Position approximative | Oui (par prudence) | Ville et pays du profil, tapés par l'utilisateur. L'app ne lit jamais la position du téléphone ; ne pas cocher « Position précise ». |
| Contacts | Contacts | Oui | Autorités saisies à la main (nom, téléphone, e-mail d'une autre personne) et liens entre membres. Le carnet d'adresses n'est pas lu. |
| Contenu utilisateur | Photos ou vidéos | Oui | La photo de profil (facultative, visible des autres membres), et les affiches et photos publiées par les administrateurs. |
| Contenu utilisateur | Autre contenu | Oui | Comptes rendus, notes, listes de prière, sujets d'importunité, réponses d'inscription. |
| Contenu utilisateur | E-mails ou SMS, audio, contenu de jeu, assistance | Non | |
| Historique de recherche / navigation | | Non | La recherche de cantiques reste sur le téléphone. |
| Identifiants | Identifiant d'utilisateur | Oui | Numéro de compte, pseudo ; envoyé à Crashlytics (et à RevenueCat à partir de la v1.1). |
| Identifiants | Identifiant de l'appareil | Oui | Jeton de notification (FCM), identifiant d'installation Crashlytics. Pas d'IDFA. |
| Achats | Historique d'achats | *(v1.1)* Oui ; **non collecté en v1** | Abonnement Premium (RevenueCat). |
| Infos financières | Infos de paiement, crédit, autres | Non | Paiement géré par Apple. |
| Données d'utilisation | Interactions avec le produit | Oui | Annonces lues, retraites faites, proclamations comptées. |
| Données d'utilisation | Données publicitaires, autres | Non | |
| Diagnostic | Données de plantage | Oui | Crashlytics. |
| Diagnostic | Autres données de diagnostic | Oui | Version de l'app, modèle et système du téléphone. |
| Diagnostic | Données de performances | Non | Pas de Firebase Performance. |
| Santé et forme | | Non | |
| Autres données | | Non | |

---

## 8. Google Play : « Sécurité des données »

Réponses générales :

- L'app collecte-t-elle ou partage-t-elle des données ? **Oui** (collecte).
- Partage avec des tiers : **Non**. Google (Firebase), RevenueCat et l'hébergeur agissent comme prestataires pour notre compte, ce que Google ne compte pas comme un partage ; l'envoi aux autorités par WhatsApp ou e-mail, comme le partage de ses comptes rendus avec les autorités membres qu'il a choisies, sont des actions de l'utilisateur.
- Données chiffrées en transit : **Oui** (HTTPS obligatoire en production ; voir la liste de contrôle pour iOS).
- Suppression : **Oui**, dans l'app (Plus, ouvert par la photo de profil en haut de l'Accueil › Supprimer mon compte) et par la page https://cmfi-connect.com/delete-account (à confirmer). Une donnée seule peut aussi être effacée dans l'app (élément, personne d'une liste, autorité, inscription).
- Engagement du programme Familles : non concerné (public 13+).

| Catégorie Play | Type | Collecté | Obligatoire ? | Finalités |
| --- | --- | --- | --- | --- |
| Informations personnelles | Nom | Oui | Obligatoire | Fonctionnement de l'app, gestion du compte |
| Informations personnelles | Adresse e-mail | Oui | Facultatif | Fonctionnement de l'app, gestion du compte |
| Informations personnelles | ID utilisateur | Oui | Obligatoire | Fonctionnement de l'app, gestion du compte |
| Informations personnelles | Numéro de téléphone | Oui | Obligatoire | Gestion du compte, fonctionnement de l'app, sécurité (mot de passe oublié) |
| Informations personnelles | Opinions politiques ou religieuses | Oui | Facultatif | Fonctionnement de l'app |
| Informations personnelles | Adresse, origine ethnique, orientation sexuelle, autres infos | Non | | |
| Position | Position approximative | Oui (ville et pays tapés, par prudence) | Facultatif | Fonctionnement de l'app |
| Position | Position exacte | Non | | |
| Informations financières | Historique des achats | *(v1.1)* Oui ; **non collecté en v1** | Facultatif | Fonctionnement de l'app, gestion du compte |
| Informations financières | Infos de paiement, autres | Non | | |
| Santé et remise en forme | | Non | | |
| Messages | E-mails, SMS/MMS, autres messages | Non | | L'app ne lit pas les SMS ; le code est vérifié par Firebase. |
| Photos et vidéos | Photos | Oui | Facultatif | Fonctionnement de l'app (photo de profil ; affiches et photos des admins) |
| Fichiers audio, fichiers et documents | | Non | | Les exports sont créés sur le téléphone. |
| Agenda | | Non | | |
| Contacts | Contacts | Oui | Facultatif | Fonctionnement de l'app (autorités) |
| Activité dans l'app | Interactions avec l'app | Oui | Facultatif | Fonctionnement de l'app |
| Activité dans l'app | Autre contenu généré par l'utilisateur | Oui | Facultatif | Fonctionnement de l'app |
| Activité dans l'app | Historique des recherches, applis installées, autres actions | Non | | |
| Navigation sur le Web | | Non | | |
| Infos sur l'appli et performances | Journaux de plantage | Oui | Obligatoire | Analyse, fonctionnement de l'app |
| Infos sur l'appli et performances | Diagnostics | Oui | Obligatoire | Analyse, fonctionnement de l'app |
| Infos sur l'appli et performances | Autres données de performances | Non | | |
| Appareil ou autres identifiants | Appareil ou autres ID | Oui | Obligatoire | Fonctionnement de l'app, analyse |

« Traité de façon éphémère » : **Non** pour toutes ces lignes (les données sont enregistrées).

---

## 9. Notes pour l'examen (App Review et « Accès à l'application » de Google Play)

À coller en anglais (les examinateurs lisent l'anglais). Créer d'abord le compte de démonstration sur le serveur de production, avec le rôle `user` et quelques données : des comptes rendus sur plusieurs jours, une autorité, une liste de prière, et au moins un évènement publié.

```text
CMFI Connect is the app of a Christian missionary community (CMFI). Anyone can create an account; members keep a daily spiritual report, read hymn books offline, pray with guided 15-minute retreats and follow community events.

SIGN IN
The app signs in with a phone number and a password (no third-party sign-in).
Demo account:
- Phone: [numéro de démo] (type the full international number with its "+" prefix: the country code selector switches by itself)
- Password: [mot de passe de démo]

MAIN FEATURES (bottom tabs)
- Home: today's report, goals ring, streak, upcoming events, notifications bell.
- Report: Today (fill in the day), History (calendar), Summary (week, month, year).
- Hymns: hymn books available offline, search, favorites, projection mode.
- Prayer: 15-minute retreats, community prayer topics, prayer lists, importunity topics.
- More: spiritual leaders, events, "Our ministry" (globe of nations), notifications, my items, export, "Send to my authorities", blocked members, evening reminder, appearance, language, sign out, delete account.

ACCOUNT DELETION
More tab > scroll to the bottom > "Delete my account" > confirm with the password. The account and its data are deleted at once.

IN-APP PURCHASES
None in this version: every feature is free.

REPORT AND BLOCK
An invitation to pray for a topic (Prayer tab) has a menu with "Report" (reason and comment, sent to the community administrators, who handle reports in their back office) and "Block" (no more invitations from that member). Blocked members can be unblocked in More > "Blocked members".

FORGOT PASSWORD (optional)
On the sign-in screen, "Forgot your password?" sends an SMS code through Firebase Authentication. You can test it with [numéro de test Firebase] and the code [code de test], a Firebase test number linked to [the demo account / a second demo account]: please set the password back to [mot de passe de démo] afterwards.

NOTIFICATIONS AND PERMISSIONS
- Notifications: evening reminder and event reminders are local; announcements are sent by the community leaders (Firebase Cloud Messaging).
- Calendar: only to add an event the user chooses (write-only).
- Photo library: only for administrators choosing an event poster.

Contact during review: [nom], [e-mail], [téléphone]
```

Pour Google Play (Contenu de l'appli › Accès à l'application) : « Toutes ou certaines fonctionnalités sont restreintes », puis le même numéro et le même mot de passe, avec la phrase sur l'indicatif. *(v1.1)* Pour tester Premium, ajouter les adresses des testeurs dans « Test de licence » de la Play Console.

Rappels techniques pour que l'examen se passe bien :

- *(v1.1)* Les abonnements (mensuel, semestriel, annuel, dans un même groupe) doivent être créés dans App Store Connect et **soumis avec la première version** de l'app ; idem dans la Play Console. RevenueCat : entitlement `premium`, offering courante avec les paquets Monthly, Six Month et Annual, clés publiques dans `.env` (`REVENUE_CAT_APPLE_API_KEY`, `REVENUE_CAT_GOOGLE_API_KEY`), clé In-App Purchase d'Apple et compte de service Google ajoutés dans RevenueCat.
- *(v1.1)* L'essai gratuit (« 7 jours d'essai gratuit » prévu par l'écran Premium) n'existe que s'il est configuré sur chaque produit dans les stores. Durée : `[durée de l'essai, ou aucun]`.
- Mot de passe oublié : activer la connexion « Téléphone » dans le projet Firebase `cmfi-connect` (prod), les empreintes SHA de l'app Android, la clé APNs, et le numéro de test (Authentication › Sign-in method › Phone › Numéros de test). Le serveur de production doit avoir la clé Firebase (`FIREBASE_CREDENTIALS_FILE`), sinon la réinitialisation répond « indisponible ». Le numéro de test doit être celui d'un compte existant.
- Le widget iOS est une extension (`ios/TodayWidget`) : il part avec l'app, rien à déclarer de plus.

---

## 10. Liste de contrôle : ce qu'il manque au propriétaire

Pages légales (site, `src/config.ts`) :

- [ ] `address` : adresse postale de la CMCI.
- [ ] `country` : pays dont la loi s'applique.
- [ ] `contactEmail` : e-mail pour les données personnelles et le support.
- [ ] `hosting` : hébergeur du serveur et pays des serveurs.
- [ ] `url` du site (encore `https://cmfi-connect.example`) et domaine réellement en ligne ; confirmer `https://cmfi-connect.com` utilisé par l'app.
- [ ] Faire relire les pages légales par une personne compétente en droit, notamment la base « activités légitimes d'une organisation religieuse » (article 9.2.d du RGPD, qui suppose un organisme à but non lucratif) et le droit du pays choisi.

Comptes et accès pour l'examen :

- [ ] `[numéro de démo]` et `[mot de passe de démo]` : compte de rôle `user` en production, avec des données.
- [ ] `[numéro de test Firebase]` et `[code de test]` pour le mot de passe oublié (et, de préférence, un second compte de démonstration pour ce test).
- [ ] Contact pendant l'examen : `[nom]`, `[e-mail]`, `[téléphone]`.

Stores :

- [ ] Comptes développeur au nom de l'organisation (Apple et Google demandent un numéro D-U-N-S pour une organisation).
- [ ] *(v1.1)* Contrat « Apps payantes » signé, coordonnées bancaires et fiscales (App Store Connect) ; profil de paiement (Play Console).
- [ ] *(v1.1)* Prix des trois abonnements, `[durée de l'essai, ou aucun]`, nom du groupe d'abonnements et textes de chaque abonnement.
- [x] Captures d'écran : iPhone 6,9 pouces et téléphone Android dans `store/screenshots/` (générées par `flutter test tool/store_screenshots_test.dart`), image de présentation Google Play `store/screenshots/feature_graphic.png`. Pas d'iPad (app iPhone seulement).
- [ ] Nom anglais officiel de la communauté (« Christian Missionary Fellowship International » ?) pour la description anglaise.
- [ ] Droits sur les recueils de cantiques (Rendons ministère au Seigneur, Christ est vainqueur, Christ the Victor, Chants d'édification) : Apple demande si l'app contient du contenu de tiers et si l'on a les droits.

Décisions et corrections avant la soumission (à confier à l'équipe de l'app) :

- [x] Contenu entre membres : « Signaler » et « Bloquer » sur les invitations d'importunité, signalements traités dans le back office (page Signalements) — règle 1.2.
- [ ] iOS : `ios/Runner/Info.plist` contient deux clés `NSAppTransportSecurity`, dont une avec `NSAllowsArbitraryLoads = true` (HTTP permis partout). La retirer pour la production (garder `NSAllowsLocalNetworking` pour le développement), sinon Apple demande une justification et la réponse « chiffré en transit » devient fausse.
- [ ] iOS : ajouter `ITSAppUsesNonExemptEncryption = NO` dans `Info.plist` (l'app n'utilise que le chiffrement standard HTTPS), pour éviter la question d'export à chaque envoi.
- [ ] iOS : `NSContactsUsageDescription` est présent (« pour choisir le lieu d'un évènement… ») ; vérifier qu'il est vraiment nécessaire à l'ajout au calendrier, sinon le retirer.
- [ ] Crashlytics (ajouté) : envoi des symboles (dSYM iOS, fichiers de mapping Android) pour des rapports lisibles.
