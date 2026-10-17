///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import
// dart format off

part of 'strings.g.dart';

// Path: <root>
typedef TranslationsFr = Translations; // ignore: unused_element
class Translations with BaseTranslations<AppLocale, Translations> {
	/// Returns the current translations of the given [context].
	///
	/// Usage:
	/// final t = Translations.of(context);
	static Translations of(BuildContext context) => InheritedLocaleData.of<AppLocale, Translations>(context).translations;

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	Translations({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  _meta = meta ?? TranslationMetadata(
		    locale: AppLocale.fr,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		_meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <fr>.
	final TranslationMetadata<AppLocale, Translations> _meta;
	@override TranslationMetadata<AppLocale, Translations> get $meta => _meta;

	/// Access flat map
	dynamic operator[](String key) => _meta.getTranslation(key);

	late final Translations _root = this; // ignore: unused_field

	Translations $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => Translations(meta: meta ?? this.$meta);

	// Translations
	late final Translations$app$fr app = Translations$app$fr.internal(_root);
	late final Translations$common$fr common = Translations$common$fr.internal(_root);
	late final Translations$errors$fr errors = Translations$errors$fr.internal(_root);
	late final Translations$validation$fr validation = Translations$validation$fr.internal(_root);
	late final Translations$onboarding$fr onboarding = Translations$onboarding$fr.internal(_root);
	late final Translations$welcome$fr welcome = Translations$welcome$fr.internal(_root);
	late final Translations$auth$fr auth = Translations$auth$fr.internal(_root);
	late final Translations$countries$fr countries = Translations$countries$fr.internal(_root);
	late final Translations$nav$fr nav = Translations$nav$fr.internal(_root);
	late final Translations$home$fr home = Translations$home$fr.internal(_root);
	late final Translations$reports$fr reports = Translations$reports$fr.internal(_root);
	late final Translations$reminder$fr reminder = Translations$reminder$fr.internal(_root);
	late final Translations$export$fr export = Translations$export$fr.internal(_root);
	late final Translations$items$fr items = Translations$items$fr.internal(_root);
	late final Translations$newItem$fr newItem = Translations$newItem$fr.internal(_root);
	late final Translations$more$fr more = Translations$more$fr.internal(_root);
	late final Translations$authorities$fr authorities = Translations$authorities$fr.internal(_root);
	late final Translations$members$fr members = Translations$members$fr.internal(_root);
	late final Translations$admin$fr admin = Translations$admin$fr.internal(_root);
	late final Translations$hymns$fr hymns = Translations$hymns$fr.internal(_root);
	late final Translations$comingSoon$fr comingSoon = Translations$comingSoon$fr.internal(_root);
	late final Translations$events$fr events = Translations$events$fr.internal(_root);
	late final Translations$notifications$fr notifications = Translations$notifications$fr.internal(_root);
	late final Translations$premium$fr premium = Translations$premium$fr.internal(_root);
	late final Translations$homeWidget$fr homeWidget = Translations$homeWidget$fr.internal(_root);
	late final Translations$ministry$fr ministry = Translations$ministry$fr.internal(_root);
	late final Translations$prayer$fr prayer = Translations$prayer$fr.internal(_root);
	late final Translations$sending$fr sending = Translations$sending$fr.internal(_root);
	late final Translations$streak$fr streak = Translations$streak$fr.internal(_root);
	late final Translations$shortcuts$fr shortcuts = Translations$shortcuts$fr.internal(_root);
	late final Translations$blocking$fr blocking = Translations$blocking$fr.internal(_root);
	late final Translations$verses$fr verses = Translations$verses$fr.internal(_root);
	late final Translations$bible$fr bible = Translations$bible$fr.internal(_root);
	late final Translations$profilePhoto$fr profilePhoto = Translations$profilePhoto$fr.internal(_root);
	late final Translations$disciples$fr disciples = Translations$disciples$fr.internal(_root);
	late final Translations$weekStory$fr weekStory = Translations$weekStory$fr.internal(_root);
	late final Translations$seekFirst$fr seekFirst = Translations$seekFirst$fr.internal(_root);
	late final Translations$documents$fr documents = Translations$documents$fr.internal(_root);
	late final Translations$biblePlan$fr biblePlan = Translations$biblePlan$fr.internal(_root);
	late final Translations$teachings$fr teachings = Translations$teachings$fr.internal(_root);
	late final Translations$memorize$fr memorize = Translations$memorize$fr.internal(_root);
	late final Translations$souls$fr souls = Translations$souls$fr.internal(_root);
}

// Path: app
class Translations$app$fr {
	Translations$app$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'CMFI Connect'
	String get name => 'CMFI Connect';

	/// fr: 'Grandir ensemble, chaque jour.'
	String get tagline => 'Grandir ensemble, chaque jour.';

	/// fr: 'Français'
	String get languageName => 'Français';
}

// Path: common
class Translations$common$fr {
	Translations$common$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Réessayer'
	String get retry => 'Réessayer';

	/// fr: 'Annuler'
	String get cancel => 'Annuler';

	/// fr: 'Enregistrer'
	String get save => 'Enregistrer';

	/// fr: 'Fermer'
	String get close => 'Fermer';

	/// fr: 'Retour'
	String get back => 'Retour';

	/// fr: 'Bientôt'
	String get soon => 'Bientôt';

	/// fr: '(facultatif)'
	String get optional => '(facultatif)';

	/// fr: 'et'
	String get and => 'et';

	/// fr: 'Chargement…'
	String get loading => 'Chargement…';

	/// fr: 'OK'
	String get done => 'OK';

	/// fr: 'Du'
	String get rangeStart => 'Du';

	/// fr: 'Au'
	String get rangeEnd => 'Au';
}

// Path: errors
class Translations$errors$fr {
	Translations$errors$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Pas de connexion à internet. Vérifie ton réseau et réessaie.'
	String get network => 'Pas de connexion à internet. Vérifie ton réseau et réessaie.';

	/// fr: 'Ta session a expiré. Reconnecte-toi.'
	String get unauthorized => 'Ta session a expiré. Reconnecte-toi.';

	/// fr: 'Numéro de téléphone ou mot de passe incorrect.'
	String get invalidCredentials => 'Numéro de téléphone ou mot de passe incorrect.';

	/// fr: 'Certaines informations ne sont pas valides.'
	String get badRequest => 'Certaines informations ne sont pas valides.';

	/// fr: 'Cet élément existe déjà.'
	String get conflict => 'Cet élément existe déjà.';

	/// fr: 'Élément introuvable.'
	String get notFound => 'Élément introuvable.';

	/// fr: 'Le serveur a rencontré un problème. Réessaie dans un instant.'
	String get server => 'Le serveur a rencontré un problème. Réessaie dans un instant.';

	/// fr: 'Une erreur est survenue. Réessaie.'
	String get unknown => 'Une erreur est survenue. Réessaie.';

	/// fr: 'Tu n'as pas le droit de faire cela.'
	String get forbidden => 'Tu n\'as pas le droit de faire cela.';

	/// fr: 'Il n'y a plus de place pour cet évènement.'
	String get eventFull => 'Il n\'y a plus de place pour cet évènement.';

	/// fr: 'Les inscriptions à cet évènement sont closes.'
	String get registrationClosed => 'Les inscriptions à cet évènement sont closes.';

	/// fr: 'Cette image est trop lourde (8 Mo au plus).'
	String get mediaTooLarge => 'Cette image est trop lourde (8 Mo au plus).';

	/// fr: 'Choisis une image JPEG ou PNG.'
	String get mediaUnsupported => 'Choisis une image JPEG ou PNG.';

	/// fr: 'Rejoins d'abord ce sujet pour compter tes proclamations.'
	String get notParticipant => 'Rejoins d\'abord ce sujet pour compter tes proclamations.';

	/// fr: 'Ce sujet est clos : il ne compte plus de proclamations.'
	String get importunityClosed => 'Ce sujet est clos : il ne compte plus de proclamations.';

	/// fr: 'Personne n'a ce pseudo. Vérifie l'orthographe.'
	String get usernameNotFound => 'Personne n\'a ce pseudo. Vérifie l\'orthographe.';

	/// fr: 'Tu as créé ce sujet : supprime-le plutôt que de le quitter.'
	String get ownerCannotLeave => 'Tu as créé ce sujet : supprime-le plutôt que de le quitter.';

	/// fr: 'Tes listes sont pleines (500 personnes au plus).'
	String get tooManyPeople => 'Tes listes sont pleines (500 personnes au plus).';

	/// fr: 'Cette photo ne peut pas être utilisée. Choisis-en une autre.'
	String get avatarInvalid => 'Cette photo ne peut pas être utilisée. Choisis-en une autre.';

	/// fr: 'Ce membre ne partage plus ses comptes rendus.'
	String get reportsNotShared => 'Ce membre ne partage plus ses comptes rendus.';
}

// Path: validation
class Translations$validation$fr {
	Translations$validation$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Ce champ est obligatoire'
	String get required => 'Ce champ est obligatoire';

	/// fr: 'Au moins 6 caractères'
	String get passwordTooShort => 'Au moins 6 caractères';

	/// fr: 'Numéro de téléphone invalide'
	String get invalidPhone => 'Numéro de téléphone invalide';

	/// fr: 'Adresse e-mail invalide'
	String get invalidEmail => 'Adresse e-mail invalide';

	/// fr: 'Lettres et chiffres uniquement, sans espace'
	String get invalidCode => 'Lettres et chiffres uniquement, sans espace';
}

// Path: onboarding
class Translations$onboarding$fr {
	Translations$onboarding$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Passer'
	String get skip => 'Passer';

	/// fr: 'Suivant'
	String get next => 'Suivant';

	/// fr: 'Commencer'
	String get start => 'Commencer';

	/// fr: 'Écran {current} sur {total}'
	String step({required Object current, required Object total}) => 'Écran ${current} sur ${total}';

	late final Translations$onboarding$reports$fr reports = Translations$onboarding$reports$fr.internal(_root);
	late final Translations$onboarding$worship$fr worship = Translations$onboarding$worship$fr.internal(_root);
	late final Translations$onboarding$community$fr community = Translations$onboarding$community$fr.internal(_root);
	late final Translations$onboarding$sample$fr sample = Translations$onboarding$sample$fr.internal(_root);
}

// Path: welcome
class Translations$welcome$fr {
	Translations$welcome$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Bienvenue sur CMFI Connect'
	String get title => 'Bienvenue sur CMFI Connect';

	/// fr: 'Crée ton compte en une minute pour remplir ton compte rendu et suivre la vie de ta communauté.'
	String get text => 'Crée ton compte en une minute pour remplir ton compte rendu et suivre la vie de ta communauté.';

	/// fr: 'Créer mon compte'
	String get createAccount => 'Créer mon compte';

	/// fr: 'J'ai déjà un compte'
	String get haveAccount => 'J\'ai déjà un compte';
}

// Path: auth
class Translations$auth$fr {
	Translations$auth$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Téléphone'
	String get phone => 'Téléphone';

	/// fr: 'Indicatif : {code}'
	String dialCode({required Object code}) => 'Indicatif : ${code}';

	/// fr: 'Mot de passe'
	String get password => 'Mot de passe';

	/// fr: 'Afficher le mot de passe'
	String get showPassword => 'Afficher le mot de passe';

	/// fr: 'Masquer le mot de passe'
	String get hidePassword => 'Masquer le mot de passe';

	late final Translations$auth$login$fr login = Translations$auth$login$fr.internal(_root);
	late final Translations$auth$register$fr register = Translations$auth$register$fr.internal(_root);
	late final Translations$auth$church$fr church = Translations$auth$church$fr.internal(_root);
	late final Translations$auth$forgot$fr forgot = Translations$auth$forgot$fr.internal(_root);
	late final Translations$auth$biometric$fr biometric = Translations$auth$biometric$fr.internal(_root);
}

// Path: countries
class Translations$countries$fr {
	Translations$countries$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Indicatif du pays'
	String get dialCodeTitle => 'Indicatif du pays';

	/// fr: 'Ton pays'
	String get title => 'Ton pays';

	/// fr: 'Rechercher un pays ou un indicatif'
	String get search => 'Rechercher un pays ou un indicatif';

	/// fr: 'Aucun pays ne correspond'
	String get none => 'Aucun pays ne correspond';

	/// fr: 'Changer de pays'
	String get change => 'Changer de pays';
}

// Path: nav
class Translations$nav$fr {
	Translations$nav$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Accueil'
	String get home => 'Accueil';

	/// fr: 'Compte rendu'
	String get reports => 'Compte rendu';

	/// fr: 'Cantiques'
	String get hymns => 'Cantiques';

	/// fr: 'Prière'
	String get prayer => 'Prière';

	/// fr: 'Bible'
	String get bible => 'Bible';
}

// Path: home
class Translations$home$fr {
	Translations$home$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Bonjour {name}'
	String greeting({required Object name}) => 'Bonjour ${name}';

	/// fr: 'Bonjour'
	String get greetingNoName => 'Bonjour';

	/// fr: 'Mon profil'
	String get profile => 'Mon profil';

	/// fr: '{filled} sur {total}'
	String progress({required Object filled, required Object total}) => '${filled} sur ${total}';

	/// fr: 'éléments renseignés'
	String get progressLabel => 'éléments renseignés';

	/// fr: 'objectifs'
	String get goals => 'objectifs';

	/// fr: 'Ta semaine'
	String get weekTitle => 'Ta semaine';

	/// fr: 'Actuellement à la CMCI'
	String get community => 'Actuellement à la CMCI';

	/// fr: 'Évènements'
	String get eventsTitle => 'Évènements';

	/// fr: 'Cantiques'
	String get hymnsTitle => 'Cantiques';

	/// fr: 'Ouvrir le recueil'
	String get hymnsOpen => 'Ouvrir le recueil';

	/// fr: 'Continuer mon compte rendu'
	String get continueMyReport => 'Continuer mon compte rendu';

	/// fr: 'Commencer mon compte rendu'
	String get startMyReport => 'Commencer mon compte rendu';

	/// fr: 'éléments'
	String get items => 'éléments';

	/// fr: 'Objectifs'
	String get goalsTitle => 'Objectifs';

	/// fr: 'Retraites'
	String get retreatsTitle => 'Retraites';

	/// fr: '{n} sur 4'
	String retreatsValue({required Object n}) => '${n} sur 4';

	/// fr: 'Série'
	String get streakTitle => 'Série';

	/// fr: 'À reprendre'
	String get resume => 'À reprendre';

	/// fr: 'Cantique n° {number}'
	String hymnNumber({required Object number}) => 'Cantique n° ${number}';

	/// fr: 'Tout voir'
	String get seeAll => 'Tout voir';

	/// fr: 'Les 4 retraites du jour sont faites'
	String get retreatsDone => 'Les 4 retraites du jour sont faites';

	/// fr: '(one) {{n} jour} (other) {{n} jours}'
	String days({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
		one: '${n} jour',
		other: '${n} jours',
	);

	/// fr: 'Masquer mes chiffres'
	String get hideNumbers => 'Masquer mes chiffres';

	/// fr: 'Afficher mes chiffres'
	String get showNumbers => 'Afficher mes chiffres';

	/// fr: 'masqué'
	String get numbersHidden => 'masqué';
}

// Path: reports
class Translations$reports$fr {
	Translations$reports$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Compte rendu'
	String get title => 'Compte rendu';

	/// fr: 'Mes éléments'
	String get myItems => 'Mes éléments';

	late final Translations$reports$tabs$fr tabs = Translations$reports$tabs$fr.internal(_root);

	/// fr: 'Choisir le jour'
	String get pickDay => 'Choisir le jour';

	/// fr: '{filled} sur {total} renseignés'
	String filled({required Object filled, required Object total}) => '${filled} sur ${total} renseignés';

	/// fr: 'Enregistré'
	String get statusSaved => 'Enregistré';

	/// fr: 'Non enregistré'
	String get statusModified => 'Non enregistré';

	/// fr: 'Standards'
	String get standard => 'Standards';

	/// fr: 'Mes éléments'
	String get personal => 'Mes éléments';

	/// fr: 'Créer un élément'
	String get createItem => 'Créer un élément';

	/// fr: 'Ajouter {label}'
	String add({required Object label}) => 'Ajouter ${label}';

	/// fr: 'Note du jour'
	String get note => 'Note du jour';

	/// fr: 'Un verset, un sujet de reconnaissance…'
	String get noteHint => 'Un verset, un sujet de reconnaissance…';

	/// fr: 'Enregistrer la journée'
	String get save => 'Enregistrer la journée';

	/// fr: 'Journée enregistrée'
	String get saved => 'Journée enregistrée';

	late final Translations$reports$measure$fr measure = Translations$reports$measure$fr.internal(_root);

	/// fr: '(one) {{n} fois} (other) {{n} fois}'
	String times({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
		one: '${n} fois',
		other: '${n} fois',
	);

	late final Translations$reports$sheet$fr sheet = Translations$reports$sheet$fr.internal(_root);
	late final Translations$reports$history$fr history = Translations$reports$history$fr.internal(_root);
	late final Translations$reports$summary$fr summary = Translations$reports$summary$fr.internal(_root);

	/// fr: 'Aucun élément à renseigner pour le moment.'
	String get noItems => 'Aucun élément à renseigner pour le moment.';

	/// fr: 'Pas encore envoyé'
	String get statusPending => 'Pas encore envoyé';

	/// fr: 'Pas de réseau : la journée est gardée sur le téléphone et partira dès que possible.'
	String get savedOffline => 'Pas de réseau : la journée est gardée sur le téléphone et partira dès que possible.';

	/// fr: '(one) {{n} journée attend le réseau pour être envoyée} (other) {{n} journées attendent le réseau pour être envoyées}'
	String pendingBanner({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
		one: '${n} journée attend le réseau pour être envoyée',
		other: '${n} journées attendent le réseau pour être envoyées',
	);

	/// fr: 'Exporter mon compte rendu'
	String get export => 'Exporter mon compte rendu';

	/// fr: 'Objectif : {value}'
	String goal({required Object value}) => 'Objectif : ${value}';

	/// fr: 'Objectif atteint'
	String get goalReached => 'Objectif atteint';

	/// fr: 'Objectifs de la journée'
	String get dayGoals => 'Objectifs de la journée';

	/// fr: 'Atteints : {reached} sur {total}'
	String goalsReached({required Object reached, required Object total}) => 'Atteints : ${reached} sur ${total}';

	late final Translations$reports$standardItems$fr standardItems = Translations$reports$standardItems$fr.internal(_root);
	late final Translations$reports$units$fr units = Translations$reports$units$fr.internal(_root);
}

// Path: reminder
class Translations$reminder$fr {
	Translations$reminder$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Ton compte rendu du jour'
	String get title => 'Ton compte rendu du jour';

	/// fr: 'Prends une minute pour noter ta lecture, ta prière… avant la fin de la journée.'
	String get body => 'Prends une minute pour noter ta lecture, ta prière… avant la fin de la journée.';

	/// fr: 'Rappel du compte rendu'
	String get channel => 'Rappel du compte rendu';

	/// fr: 'Rappel du soir'
	String get settings => 'Rappel du soir';

	/// fr: 'Désactivé'
	String get off => 'Désactivé';

	/// fr: 'Me rappeler de remplir ma journée'
	String get switchLabel => 'Me rappeler de remplir ma journée';

	/// fr: 'Seulement si la journée n'est pas encore remplie.'
	String get switchHint => 'Seulement si la journée n\'est pas encore remplie.';

	/// fr: 'Heure du rappel'
	String get time => 'Heure du rappel';

	/// fr: 'Un rappel chaque soir ?'
	String get offerTitle => 'Un rappel chaque soir ?';

	/// fr: 'Si ta journée n'est pas encore remplie, l'app te le rappelle à l'heure choisie. Rien si c'est déjà fait.'
	String get offerText => 'Si ta journée n\'est pas encore remplie, l\'app te le rappelle à l\'heure choisie. Rien si c\'est déjà fait.';

	/// fr: 'Activer le rappel'
	String get offerAccept => 'Activer le rappel';

	/// fr: 'Plus tard'
	String get offerLater => 'Plus tard';

	/// fr: 'Rappel activé à {time}'
	String enabled({required Object time}) => 'Rappel activé à ${time}';

	/// fr: 'Les notifications sont bloquées pour CMFI Connect. Autorise-les dans les réglages du téléphone.'
	String get denied => 'Les notifications sont bloquées pour CMFI Connect. Autorise-les dans les réglages du téléphone.';
}

// Path: export
class Translations$export$fr {
	Translations$export$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Exporter'
	String get title => 'Exporter';

	/// fr: 'Période'
	String get period => 'Période';

	/// fr: 'Cette semaine'
	String get thisWeek => 'Cette semaine';

	/// fr: 'Semaine dernière'
	String get lastWeek => 'Semaine dernière';

	/// fr: 'Ce mois-ci'
	String get thisMonth => 'Ce mois-ci';

	/// fr: 'Mois dernier'
	String get lastMonth => 'Mois dernier';

	/// fr: 'Cette année'
	String get thisYear => 'Cette année';

	/// fr: 'Autres dates'
	String get custom => 'Autres dates';

	/// fr: 'Choisir les dates'
	String get customPick => 'Choisir les dates';

	/// fr: 'Format'
	String get format => 'Format';

	/// fr: 'PDF'
	String get pdf => 'PDF';

	/// fr: 'Un document à envoyer ou à imprimer'
	String get pdfHint => 'Un document à envoyer ou à imprimer';

	/// fr: 'Tableur'
	String get csv => 'Tableur';

	/// fr: 'Un fichier CSV pour Excel ou Google Sheets'
	String get csvHint => 'Un fichier CSV pour Excel ou Google Sheets';

	/// fr: 'Message'
	String get text => 'Message';

	/// fr: 'Un résumé à coller dans WhatsApp'
	String get textHint => 'Un résumé à coller dans WhatsApp';

	/// fr: 'Exporter'
	String get button => 'Exporter';

	/// fr: 'Partager'
	String get shareButton => 'Partager';

	/// fr: '(one) {{filled} jour rempli sur {total} · {items}} (other) {{filled} jours remplis sur {total} · {items}}'
	String preview({required num filled, required Object total, required Object items}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(filled,
		one: '${filled} jour rempli sur ${total} · ${items}',
		other: '${filled} jours remplis sur ${total} · ${items}',
	);

	/// fr: '(one) {{n} élément} (other) {{n} éléments}'
	String previewItems({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
		one: '${n} élément',
		other: '${n} éléments',
	);

	/// fr: 'Aucun compte rendu sur cette période.'
	String get empty => 'Aucun compte rendu sur cette période.';

	/// fr: 'Choisis 366 jours au plus.'
	String get tooLong => 'Choisis 366 jours au plus.';

	/// fr: 'compte-rendu'
	String get fileName => 'compte-rendu';

	/// fr: 'Mon compte rendu, {period}'
	String subject({required Object period}) => 'Mon compte rendu, ${period}';

	late final Translations$export$doc$fr doc = Translations$export$doc$fr.internal(_root);
}

// Path: items
class Translations$items$fr {
	Translations$items$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Mes éléments'
	String get title => 'Mes éléments';

	/// fr: 'Standards · pour tous'
	String get standardSection => 'Standards · pour tous';

	/// fr: 'Mes éléments personnels'
	String get personalSection => 'Mes éléments personnels';

	/// fr: 'Tu n'as pas encore d'élément personnel.'
	String get emptyPersonal => 'Tu n\'as pas encore d\'élément personnel.';

	/// fr: 'Archiver'
	String get archive => 'Archiver';

	/// fr: 'Archiver {code} ?'
	String archiveTitle({required Object code}) => 'Archiver ${code} ?';

	/// fr: 'Il ne sera plus proposé dans ton compte rendu. Ses chiffres restent dans ton historique.'
	String get archiveText => 'Il ne sera plus proposé dans ton compte rendu. Ses chiffres restent dans ton historique.';

	/// fr: '{code} archivé'
	String archived({required Object code}) => '${code} archivé';

	/// fr: 'Créer un élément'
	String get create => 'Créer un élément';

	/// fr: 'Un élément archivé n'est plus proposé dans ton compte rendu, mais ses chiffres restent dans ton historique.'
	String get footnote => 'Un élément archivé n\'est plus proposé dans ton compte rendu, mais ses chiffres restent dans ton historique.';

	late final Translations$items$measure$fr measure = Translations$items$measure$fr.internal(_root);

	/// fr: 'Ajouter un objectif'
	String get goalAdd => 'Ajouter un objectif';

	/// fr: 'Objectif : {value} par jour'
	String goal({required Object value}) => 'Objectif : ${value} par jour';

	/// fr: 'Objectif par jour'
	String get goalTitle => 'Objectif par jour';

	/// fr: 'Ce que tu vises chaque jour. Il reste sur ton téléphone.'
	String get goalHint => 'Ce que tu vises chaque jour. Il reste sur ton téléphone.';

	/// fr: 'Retirer'
	String get goalRemove => 'Retirer';

	/// fr: 'Objectif enregistré'
	String get goalSaved => 'Objectif enregistré';

	/// fr: 'Objectif retiré'
	String get goalRemoved => 'Objectif retiré';
}

// Path: newItem
class Translations$newItem$fr {
	Translations$newItem$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Nouvel élément'
	String get title => 'Nouvel élément';

	/// fr: 'Code'
	String get code => 'Code';

	/// fr: 'Nom'
	String get label => 'Nom';

	/// fr: 'Lettres et chiffres, 20 au plus. Le code d'un élément standard (LB, PS…) n'est pas disponible.'
	String get help => 'Lettres et chiffres, 20 au plus. Le code d\'un élément standard (LB, PS…) n\'est pas disponible.';

	/// fr: 'Ce que tu mesures'
	String get measures => 'Ce que tu mesures';

	/// fr: 'Une quantité'
	String get quantity => 'Une quantité';

	/// fr: 'Chapitres, pages, personnes…'
	String get quantityHint => 'Chapitres, pages, personnes…';

	/// fr: 'Unité affichée après le nombre'
	String get unit => 'Unité affichée après le nombre';

	/// fr: 'personnes'
	String get unitHint => 'personnes';

	/// fr: 'Une durée'
	String get duration => 'Une durée';

	/// fr: 'En heures et minutes'
	String get durationHint => 'En heures et minutes';

	/// fr: 'Choisis au moins une mesure : une quantité, une durée ou les deux.'
	String get noMeasure => 'Choisis au moins une mesure : une quantité, une durée ou les deux.';

	/// fr: 'Aperçu dans ton compte rendu'
	String get preview => 'Aperçu dans ton compte rendu';

	/// fr: 'CODE'
	String get previewCode => 'CODE';

	/// fr: 'Nom de l'élément'
	String get previewLabel => 'Nom de l\'élément';

	/// fr: 'Créer l'élément'
	String get submit => 'Créer l\'élément';

	/// fr: '{code} est créé.'
	String created({required Object code}) => '${code} est créé.';

	/// fr: 'Ce code est déjà utilisé, par un élément standard ou par l'un de tes éléments (même archivé).'
	String get codeTaken => 'Ce code est déjà utilisé, par un élément standard ou par l\'un de tes éléments (même archivé).';

	/// fr: 'EVG'
	String get codeHint => 'EVG';

	/// fr: 'Évangélisation'
	String get labelHint => 'Évangélisation';
}

// Path: more
class Translations$more$fr {
	Translations$more$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Plus'
	String get title => 'Plus';

	/// fr: 'Modifier mon profil'
	String get editProfile => 'Modifier mon profil';

	/// fr: 'Communauté'
	String get community => 'Communauté';

	/// fr: 'Évènements'
	String get events => 'Évènements';

	/// fr: 'Compte rendu'
	String get reports => 'Compte rendu';

	/// fr: 'Mes éléments'
	String get myItems => 'Mes éléments';

	/// fr: 'Application'
	String get app => 'Application';

	/// fr: 'Langue'
	String get language => 'Langue';

	/// fr: 'Apparence'
	String get appearance => 'Apparence';

	/// fr: 'Automatique'
	String get themeSystem => 'Automatique';

	/// fr: 'En automatique, l'app suit le réglage clair ou sombre du téléphone.'
	String get themeSystemHint => 'En automatique, l\'app suit le réglage clair ou sombre du téléphone.';

	/// fr: 'Clair'
	String get themeLight => 'Clair';

	/// fr: 'Sombre'
	String get themeDark => 'Sombre';

	/// fr: 'Se déconnecter'
	String get logout => 'Se déconnecter';

	/// fr: 'Compte'
	String get account => 'Compte';

	/// fr: 'Langue de l'application'
	String get languageTitle => 'Langue de l\'application';

	/// fr: 'Ajoute ton nom'
	String get completeProfile => 'Ajoute ton nom';

	/// fr: 'Accompagnement'
	String get accompaniment => 'Accompagnement';

	/// fr: 'Exporter mon compte rendu'
	String get exportReport => 'Exporter mon compte rendu';

	/// fr: 'Journées pas encore envoyées'
	String get logoutPendingTitle => 'Journées pas encore envoyées';

	/// fr: '(one) {{n} journée enregistrée sans réseau n'a pas encore été envoyée. Si tu te déconnectes maintenant, elle sera perdue.} (other) {{n} journées enregistrées sans réseau n'ont pas encore été envoyées. Si tu te déconnectes maintenant, elles seront perdues.}'
	String logoutPendingText({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
		one: '${n} journée enregistrée sans réseau n\'a pas encore été envoyée. Si tu te déconnectes maintenant, elle sera perdue.',
		other: '${n} journées enregistrées sans réseau n\'ont pas encore été envoyées. Si tu te déconnectes maintenant, elles seront perdues.',
	);

	/// fr: 'Me déconnecter'
	String get logoutAnyway => 'Me déconnecter';

	/// fr: 'Administration'
	String get admin => 'Administration';

	/// fr: 'Équipe et rôles'
	String get staff => 'Équipe et rôles';

	/// fr: 'Évènements'
	String get manageEvents => 'Évènements';

	/// fr: 'Mes disciples'
	String get disciples => 'Mes disciples';

	/// fr: 'Version {version}'
	String version({required Object version}) => 'Version ${version}';

	/// fr: '© {year} Communauté Missionnaire Chrétienne Internationale. Tous droits réservés.'
	String copyright({required Object year}) => '© ${year} Communauté Missionnaire Chrétienne Internationale. Tous droits réservés.';
}

// Path: authorities
class Translations$authorities$fr {
	Translations$authorities$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Mes autorités spirituelles'
	String get title => 'Mes autorités spirituelles';

	/// fr: 'Les personnes qui t'accompagnent dans ta marche avec Dieu : ton faiseur de disciples et tes autres responsables.'
	String get intro => 'Les personnes qui t\'accompagnent dans ta marche avec Dieu : ton faiseur de disciples et tes autres responsables.';

	/// fr: 'Faiseur de disciples'
	String get discipleMaker => 'Faiseur de disciples';

	/// fr: 'Faiseur de disciples : {name}'
	String discipleMakerOf({required Object name}) => 'Faiseur de disciples : ${name}';

	/// fr: 'Pas encore de faiseur de disciples'
	String get noDiscipleMaker => 'Pas encore de faiseur de disciples';

	/// fr: 'Autres autorités'
	String get others => 'Autres autorités';

	/// fr: 'Tu n'as encore ajouté personne.'
	String get empty => 'Tu n\'as encore ajouté personne.';

	/// fr: 'Ajouter une autorité'
	String get add => 'Ajouter une autorité';

	/// fr: 'Retirer'
	String get remove => 'Retirer';

	/// fr: 'Retirer {name} ?'
	String removeTitle({required Object name}) => 'Retirer ${name} ?';

	/// fr: '{name} ne fera plus partie de tes autorités spirituelles.'
	String removeText({required Object name}) => '${name} ne fera plus partie de tes autorités spirituelles.';

	/// fr: '{name} ne fait plus partie de tes autorités.'
	String removed({required Object name}) => '${name} ne fait plus partie de tes autorités.';

	/// fr: '(zero) {Personne pour l'instant} (one) {{n} personne} (other) {{n} personnes}'
	String count({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
		zero: 'Personne pour l\'instant',
		one: '${n} personne',
		other: '${n} personnes',
	);

	late final Translations$authorities$form$fr form = Translations$authorities$form$fr.internal(_root);

	/// fr: 'En attente'
	String get statusPending => 'En attente';

	/// fr: 'Refusée'
	String get statusDeclined => 'Refusée';

	/// fr: 'Ses coordonnées s'afficheront quand {name} aura accepté.'
	String pendingHelp({required Object name}) => 'Ses coordonnées s\'afficheront quand ${name} aura accepté.';

	/// fr: 'Demandes reçues'
	String get requests => 'Demandes reçues';

	/// fr: 'te demande d'être son faiseur de disciples'
	String get requestDiscipleMaker => 'te demande d\'être son faiseur de disciples';

	/// fr: 'te demande de l'accompagner'
	String get requestAuthority => 'te demande de l\'accompagner';

	/// fr: 'Accepter'
	String get accept => 'Accepter';

	/// fr: 'Refuser'
	String get decline => 'Refuser';

	/// fr: 'Tu accompagnes maintenant {name}.'
	String acceptedRequest({required Object name}) => 'Tu accompagnes maintenant ${name}.';

	/// fr: 'Demande de {name} refusée.'
	String declinedRequest({required Object name}) => 'Demande de ${name} refusée.';

	/// fr: '(one) {{n} demande à voir} (other) {{n} demandes à voir}'
	String requestsCount({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
		one: '${n} demande à voir',
		other: '${n} demandes à voir',
	);

	late final Translations$authorities$sharing$fr sharing = Translations$authorities$sharing$fr.internal(_root);
}

// Path: members
class Translations$members$fr {
	Translations$members$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Pseudo'
	String get username => 'Pseudo';

	/// fr: 'prenom.nom'
	String get usernameHint => 'prenom.nom';

	/// fr: 'C'est ainsi que les autres membres te trouveront.'
	String get usernameHelp => 'C\'est ainsi que les autres membres te trouveront.';

	/// fr: 'Vérification…'
	String get usernameChecking => 'Vérification…';

	/// fr: '@{username} est libre'
	String usernameFree({required Object username}) => '@${username} est libre';

	/// fr: 'C'est ton pseudo actuel'
	String get usernameCurrent => 'C\'est ton pseudo actuel';

	/// fr: 'Ce pseudo est déjà pris.'
	String get usernameTaken => 'Ce pseudo est déjà pris.';

	/// fr: '3 à 30 caractères : lettres, chiffres, « . » et « _ », sans commencer ni finir par un signe.'
	String get usernameInvalid => '3 à 30 caractères : lettres, chiffres, « . » et « _ », sans commencer ni finir par un signe.';

	/// fr: 'Ce pseudo est réservé.'
	String get usernameReserved => 'Ce pseudo est réservé.';

	/// fr: 'Pseudo enregistré : @{username}'
	String usernameSaved({required Object username}) => 'Pseudo enregistré : @${username}';

	late final Translations$members$deleteAccount$fr deleteAccount = Translations$members$deleteAccount$fr.internal(_root);
}

// Path: admin
class Translations$admin$fr {
	Translations$admin$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Équipe et rôles'
	String get title => 'Équipe et rôles';

	/// fr: 'Les admins gèrent ce que toute la communauté partage. Seul un superadmin donne ou retire un rôle.'
	String get intro => 'Les admins gèrent ce que toute la communauté partage. Seul un superadmin donne ou retire un rôle.';

	/// fr: 'Membre'
	String get roleUser => 'Membre';

	/// fr: 'Admin'
	String get roleAdmin => 'Admin';

	/// fr: 'Superadmin'
	String get roleSuperadmin => 'Superadmin';

	/// fr: 'Donner un rôle'
	String get giveRole => 'Donner un rôle';

	/// fr: 'toi'
	String get you => 'toi';

	/// fr: 'Rôle de @{username}'
	String roleFor({required Object username}) => 'Rôle de @${username}';

	/// fr: '@{username} : {role}'
	String roleChanged({required Object username, required Object role}) => '@${username} : ${role}';

	/// fr: 'Pseudo du membre'
	String get memberUsername => 'Pseudo du membre';

	/// fr: 'Aucun admin pour l'instant.'
	String get empty => 'Aucun admin pour l\'instant.';
}

// Path: hymns
class Translations$hymns$fr {
	Translations$hymns$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Numéro, titre ou paroles'
	String get searchHint => 'Numéro, titre ou paroles';

	/// fr: 'Aller à un numéro'
	String get openNumber => 'Aller à un numéro';

	late final Translations$hymns$tabs$fr tabs = Translations$hymns$tabs$fr.internal(_root);

	/// fr: 'Choisir le recueil'
	String get chooseBook => 'Choisir le recueil';

	/// fr: '(one) {{n} cantique} (other) {{n} cantiques}'
	String count({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
		one: '${n} cantique',
		other: '${n} cantiques',
	);

	/// fr: 'N° {number}'
	String number({required Object number}) => 'N° ${number}';

	/// fr: 'Touche l'étoile d'un cantique pour le retrouver ici.'
	String get emptyFavorites => 'Touche l\'étoile d\'un cantique pour le retrouver ici.';

	/// fr: 'Les cantiques que tu ouvres apparaîtront ici.'
	String get emptyRecent => 'Les cantiques que tu ouvres apparaîtront ici.';

	/// fr: 'Aucun cantique ne correspond à « {query} ».'
	String noResult({required Object query}) => 'Aucun cantique ne correspond à « ${query} ».';

	/// fr: 'Dans les autres recueils'
	String get otherBooks => 'Dans les autres recueils';

	/// fr: 'Les recueils sont à jour.'
	String get upToDate => 'Les recueils sont à jour.';

	/// fr: 'Les recueils ont été mis à jour.'
	String get updated => 'Les recueils ont été mis à jour.';

	/// fr: 'Refrain'
	String get chorus => 'Refrain';

	/// fr: 'Refrain {label}'
	String chorusNumber({required Object label}) => 'Refrain ${label}';

	/// fr: 'Couplet {label}'
	String verse({required Object label}) => 'Couplet ${label}';

	/// fr: '×{n}'
	String times({required Object n}) => '×${n}';

	/// fr: 'Impossible d'ouvrir les recueils.'
	String get loadFailed => 'Impossible d\'ouvrir les recueils.';

	late final Translations$hymns$reader$fr reader = Translations$hymns$reader$fr.internal(_root);
	late final Translations$hymns$projection$fr projection = Translations$hymns$projection$fr.internal(_root);
	late final Translations$hymns$pad$fr pad = Translations$hymns$pad$fr.internal(_root);
}

// Path: comingSoon
class Translations$comingSoon$fr {
	Translations$comingSoon$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Bientôt disponible'
	String get badge => 'Bientôt disponible';

	/// fr: 'Retour à l'accueil'
	String get backHome => 'Retour à l\'accueil';
}

// Path: events
class Translations$events$fr {
	Translations$events$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Évènements'
	String get title => 'Évènements';

	/// fr: 'À la une'
	String get featured => 'À la une';

	/// fr: 'À venir'
	String get upcoming => 'À venir';

	/// fr: 'Éditions passées'
	String get past => 'Éditions passées';

	/// fr: 'Aucun évènement à venir'
	String get emptyTitle => 'Aucun évènement à venir';

	/// fr: 'Les conférences et les rencontres de toute la communauté apparaîtront ici, avec leur programme.'
	String get emptyText => 'Les conférences et les rencontres de toute la communauté apparaîtront ici, avec leur programme.';

	/// fr: 'Gérer les évènements'
	String get manage => 'Gérer les évènements';

	/// fr: 'Prochain évènement'
	String get next => 'Prochain évènement';

	/// fr: 'Tous les évènements'
	String get seeAll => 'Tous les évènements';

	/// fr: 'Les rencontres de la communauté, leur programme et leurs actualités.'
	String get homeText => 'Les rencontres de la communauté, leur programme et leurs actualités.';

	/// fr: 'Aujourd'hui'
	String get today => 'Aujourd\'hui';

	/// fr: 'Demain'
	String get tomorrow => 'Demain';

	/// fr: '(one) {Dans {n} jour} (other) {Dans {n} jours}'
	String inDays({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
		one: 'Dans ${n} jour',
		other: 'Dans ${n} jours',
	);

	/// fr: '(other) {J-{n}}'
	String daysLeft({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
		other: 'J-${n}',
	);

	/// fr: 'En cours'
	String get onNow => 'En cours';

	/// fr: 'Terminé'
	String get over => 'Terminé';

	/// fr: 'Annulé'
	String get cancelled => 'Annulé';

	/// fr: 'Brouillon'
	String get draft => 'Brouillon';

	/// fr: 'Inscrit'
	String get registered => 'Inscrit';

	/// fr: 'Inscriptions ouvertes'
	String get stateOpen => 'Inscriptions ouvertes';

	/// fr: 'Inscriptions closes'
	String get stateClosed => 'Inscriptions closes';

	/// fr: 'Complet'
	String get stateFull => 'Complet';

	/// fr: '(zero) {Sois le premier à t'inscrire} (one) {{count} inscrit} (other) {{count} inscrits}'
	String registrations({required num n, required Object count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
		zero: 'Sois le premier à t\'inscrire',
		one: '${count} inscrit',
		other: '${count} inscrits',
	);

	/// fr: '(one) {{count} personne} (other) {{count} personnes}'
	String people({required num n, required Object count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
		one: '${count} personne',
		other: '${count} personnes',
	);

	/// fr: '(zero) {plus de place} (one) {{count} place restante} (other) {{count} places restantes}'
	String placesLeft({required num n, required Object count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
		zero: 'plus de place',
		one: '${count} place restante',
		other: '${count} places restantes',
	);

	/// fr: 'De {start} à {end}'
	String oneDay({required Object start, required Object end}) => 'De ${start} à ${end}';

	/// fr: 'Ouverture le {startDay} à {start}, clôture le {endDay} à {end}'
	String severalDays({required Object startDay, required Object start, required Object endDay, required Object end}) => 'Ouverture le ${startDay} à ${start}, clôture le ${endDay} à ${end}';

	/// fr: 'heure de {place}'
	String venueTime({required Object place}) => 'heure de ${place}';

	/// fr: 'Ajouter au calendrier'
	String get addToCalendar => 'Ajouter au calendrier';

	/// fr: 'Partager'
	String get share => 'Partager';

	/// fr: 'Itinéraire'
	String get directions => 'Itinéraire';

	/// fr: 'Voir l'affiche'
	String get viewPoster => 'Voir l\'affiche';

	late final Translations$events$tabs$fr tabs = Translations$events$tabs$fr.internal(_root);

	/// fr: 'Le programme sera bientôt publié.'
	String get noProgram => 'Le programme sera bientôt publié.';

	/// fr: 'Pas encore d'actualité pour cet évènement.'
	String get noNews => 'Pas encore d\'actualité pour cet évènement.';

	/// fr: 'Épinglé'
	String get pinned => 'Épinglé';

	/// fr: 'En ce moment'
	String get now => 'En ce moment';

	/// fr: 'Cantique {number}'
	String hymn({required Object number}) => 'Cantique ${number}';

	/// fr: 'À propos'
	String get about => 'À propos';

	/// fr: 'Participation'
	String get fees => 'Participation';

	/// fr: 'Inscriptions jusqu'au {date}'
	String deadline({required Object date}) => 'Inscriptions jusqu\'au ${date}';

	/// fr: 'Contact'
	String get contact => 'Contact';

	/// fr: 'Appeler {name}'
	String call({required Object name}) => 'Appeler ${name}';

	/// fr: 'Les autres éditions'
	String get otherEditions => 'Les autres éditions';

	/// fr: 'Cet évènement est annulé.'
	String get cancelledBanner => 'Cet évènement est annulé.';

	/// fr: 'Impossible d'ouvrir le calendrier du téléphone.'
	String get calendarFailed => 'Impossible d\'ouvrir le calendrier du téléphone.';

	/// fr: 'Impossible d'ouvrir ce lien.'
	String get linkFailed => 'Impossible d\'ouvrir ce lien.';

	/// fr: '{title} {dates} · {place} Inscris-toi dans l'app CMFI Connect.'
	String shareText({required Object title, required Object dates, required Object place}) => '${title}\n${dates} · ${place}\nInscris-toi dans l\'app CMFI Connect.';

	/// fr: 'Il n'y a plus de place pour cet évènement.'
	String get full => 'Il n\'y a plus de place pour cet évènement.';

	/// fr: 'Les inscriptions à cet évènement sont closes.'
	String get closed => 'Les inscriptions à cet évènement sont closes.';

	late final Translations$events$register$fr register = Translations$events$register$fr.internal(_root);
	late final Translations$events$reminder$fr reminder = Translations$events$reminder$fr.internal(_root);
	late final Translations$events$admin$fr admin = Translations$events$admin$fr.internal(_root);

	/// fr: '(one) {{n} évènement à venir} (other) {{n} évènements à venir}'
	String upcomingCount({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
		one: '${n} évènement à venir',
		other: '${n} évènements à venir',
	);

	/// fr: 'Évènement {current} sur {total}'
	String slide({required Object current, required Object total}) => 'Évènement ${current} sur ${total}';
}

// Path: notifications
class Translations$notifications$fr {
	Translations$notifications$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Notifications'
	String get title => 'Notifications';

	/// fr: 'Annonces de la communauté'
	String get channel => 'Annonces de la communauté';

	/// fr: 'Aucune notification pour l'instant'
	String get empty => 'Aucune notification pour l\'instant';

	/// fr: 'Les annonces de la communauté arriveront ici.'
	String get emptyHint => 'Les annonces de la communauté arriveront ici.';

	/// fr: 'Non lue : {title}'
	String unreadLabel({required Object title}) => 'Non lue : ${title}';

	/// fr: '(one) {{n} document PDF} (other) {{n} documents PDF}'
	String documents({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
		one: '${n} document PDF',
		other: '${n} documents PDF',
	);

	/// fr: '(one) {{n} non lue} (other) {{n} non lues}'
	String unread({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
		one: '${n} non lue',
		other: '${n} non lues',
	);

	/// fr: 'Image {n}'
	String image({required Object n}) => 'Image ${n}';

	/// fr: 'Document PDF'
	String get document => 'Document PDF';

	/// fr: '{kb} Ko'
	String documentSize({required Object kb}) => '${kb} Ko';

	/// fr: 'Nouvelle notification : {title}'
	String received({required Object title}) => 'Nouvelle notification : ${title}';
}

// Path: premium
class Translations$premium$fr {
	Translations$premium$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'CMFI Connect Premium'
	String get name => 'CMFI Connect Premium';

	/// fr: 'Premium'
	String get pill => 'Premium';

	/// fr: 'Va plus loin dans ta marche avec Dieu, et soutiens l'œuvre.'
	String get subtitle => 'Va plus loin dans ta marche avec Dieu, et soutiens l\'œuvre.';

	/// fr: 'Le widget de l'écran d'accueil'
	String get widgetTitle => 'Le widget de l\'écran d\'accueil';

	/// fr: 'Ton compte rendu du jour et tes objectifs, sans ouvrir l'app.'
	String get widgetText => 'Ton compte rendu du jour et tes objectifs, sans ouvrir l\'app.';

	/// fr: 'Tes objectifs sur l'année'
	String get statsTitle => 'Tes objectifs sur l\'année';

	/// fr: 'Le bilan de l'année et l'évolution de tes objectifs, semaine après semaine.'
	String get statsText => 'Le bilan de l\'année et l\'évolution de tes objectifs, semaine après semaine.';

	/// fr: 'Tu soutiens l'œuvre'
	String get supportTitle => 'Tu soutiens l\'œuvre';

	/// fr: 'Ton abonnement fait vivre l'app pour toute la communauté.'
	String get supportText => 'Ton abonnement fait vivre l\'app pour toute la communauté.';

	/// fr: 'Annuel'
	String get annual => 'Annuel';

	/// fr: 'À vie'
	String get lifetime => 'À vie';

	/// fr: 'Mensuel'
	String get monthly => 'Mensuel';

	/// fr: '{price} / an'
	String perYear({required Object price}) => '${price} / an';

	/// fr: '{price} une fois'
	String once({required Object price}) => '${price} une fois';

	/// fr: '{price} / mois'
	String perMonth({required Object price}) => '${price} / mois';

	/// fr: 'soit {price} par mois'
	String annualPerMonth({required Object price}) => 'soit ${price} par mois';

	/// fr: 'Le plus avantageux'
	String get best => 'Le plus avantageux';

	/// fr: '(one) {{n} jour d'essai gratuit} (other) {{n} jours d'essai gratuit}'
	String trialDays({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
		one: '${n} jour d\'essai gratuit',
		other: '${n} jours d\'essai gratuit',
	);

	/// fr: '(one) {{n} mois d'essai gratuit} (other) {{n} mois d'essai gratuit}'
	String trialMonths({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
		one: '${n} mois d\'essai gratuit',
		other: '${n} mois d\'essai gratuit',
	);

	/// fr: 'S'abonner'
	String get subscribe => 'S\'abonner';

	/// fr: 'Commencer l'essai gratuit'
	String get startTrial => 'Commencer l\'essai gratuit';

	/// fr: 'Restaurer mes achats'
	String get restore => 'Restaurer mes achats';

	/// fr: 'Premium est de retour sur ce téléphone'
	String get restored => 'Premium est de retour sur ce téléphone';

	/// fr: 'Aucun achat Premium pour ce compte'
	String get nothingToRestore => 'Aucun achat Premium pour ce compte';

	/// fr: 'Merci ! Premium est activé.'
	String get thanks => 'Merci ! Premium est activé.';

	/// fr: 'L'achat n'a pas abouti. Réessaie dans un instant.'
	String get failed => 'L\'achat n\'a pas abouti. Réessaie dans un instant.';

	/// fr: 'Les offres ne sont pas disponibles pour l'instant.'
	String get unavailable => 'Les offres ne sont pas disponibles pour l\'instant.';

	/// fr: 'L'abonnement se renouvelle automatiquement. Tu peux l'annuler quand tu veux dans les réglages de ton compte {store}.'
	String renews({required Object store}) => 'L\'abonnement se renouvelle automatiquement. Tu peux l\'annuler quand tu veux dans les réglages de ton compte ${store}.';

	/// fr: 'Conditions d'utilisation'
	String get terms => 'Conditions d\'utilisation';

	/// fr: 'Confidentialité'
	String get privacy => 'Confidentialité';

	/// fr: 'Tu as Premium'
	String get activeTitle => 'Tu as Premium';

	/// fr: 'Merci de soutenir CMFI Connect ! Le widget et l'année de ton bilan sont ouverts.'
	String get activeText => 'Merci de soutenir CMFI Connect ! Le widget et l\'année de ton bilan sont ouverts.';

	/// fr: 'Premium t'est offert parce que tu fais partie de l'équipe de CMFI Connect.'
	String get staffText => 'Premium t\'est offert parce que tu fais partie de l\'équipe de CMFI Connect.';

	/// fr: 'Widget, objectifs sur l'année'
	String get moreSubtitle => 'Widget, objectifs sur l\'année';

	/// fr: 'Actif'
	String get moreActive => 'Actif';

	/// fr: 'Débloquer avec Premium'
	String get unlock => 'Débloquer avec Premium';

	/// fr: '{trial}, puis {price}'
	String trialThen({required Object trial, required Object price}) => '${trial}, puis ${price}';

	/// fr: '−{percent}'
	String savePercent({required Object percent}) => '−${percent}';

	/// fr: 'Choisis ton offre'
	String get choose => 'Choisis ton offre';

	/// fr: 'Sans engagement, annulable à tout moment'
	String get cancelAnytime => 'Sans engagement, annulable à tout moment';

	/// fr: 'Restaurer'
	String get restoreShort => 'Restaurer';

	/// fr: 'Conditions'
	String get termsShort => 'Conditions';

	/// fr: 'Semestriel'
	String get semiannual => 'Semestriel';

	/// fr: '{price} / 6 mois'
	String perSemester({required Object price}) => '${price} / 6 mois';

	/// fr: 'Acheter à vie'
	String get buyLifetime => 'Acheter à vie';

	/// fr: 'À vie : un seul paiement, sans abonnement ni renouvellement.'
	String get lifetimeNote => 'À vie : un seul paiement, sans abonnement ni renouvellement.';

	/// fr: 'Gérer mon abonnement'
	String get manage => 'Gérer mon abonnement';

	/// fr: 'La gestion de l'abonnement ne s'ouvre pas. Réessaie plus tard.'
	String get manageFailed => 'La gestion de l\'abonnement ne s\'ouvre pas. Réessaie plus tard.';
}

// Path: homeWidget
class Translations$homeWidget$fr {
	Translations$homeWidget$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Aujourd'hui'
	String get title => 'Aujourd\'hui';

	/// fr: 'Fait'
	String get done => 'Fait';

	/// fr: 'À remplir'
	String get todo => 'À remplir';

	/// fr: 'Remplir'
	String get open => 'Remplir';

	/// fr: 'Active le widget avec Premium'
	String get locked => 'Active le widget avec Premium';

	/// fr: 'Connecte-toi dans l'app'
	String get signedOut => 'Connecte-toi dans l\'app';
}

// Path: ministry
class Translations$ministry$fr {
	Translations$ministry$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Notre ministère'
	String get title => 'Notre ministère';

	/// fr: 'Jusqu'aux extrémités de la terre'
	String get tagline => 'Jusqu\'aux extrémités de la terre';

	/// fr: '(one) {{n} nation} (other) {{n} nations}'
	String count({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
		one: '${n} nation',
		other: '${n} nations',
	);

	/// fr: 'Depuis Yaoundé, l'Évangile va de nation en nation.'
	String get fromYaounde => 'Depuis Yaoundé, l\'Évangile va de nation en nation.';

	/// fr: 'Fais tourner le globe du doigt, touche une nation.'
	String get dragHint => 'Fais tourner le globe du doigt, touche une nation.';

	/// fr: '(one) {Globe : {n} nation où l'œuvre est présente. La liste plus bas la donne.} (other) {Globe : {n} nations où l'œuvre est présente. La liste plus bas les donne toutes.}'
	String globeLabel({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
		one: 'Globe : ${n} nation où l\'œuvre est présente. La liste plus bas la donne.',
		other: 'Globe : ${n} nations où l\'œuvre est présente. La liste plus bas les donne toutes.',
	);

	/// fr: 'Voyage'
	String get voyage => 'Voyage';

	/// fr: 'Pause'
	String get pause => 'Pause';

	/// fr: 'Nation précédente'
	String get previous => 'Nation précédente';

	/// fr: 'Nation suivante'
	String get next => 'Nation suivante';

	/// fr: 'Nation n° {n}'
	String number({required Object n}) => 'Nation n° ${n}';

	/// fr: 'Depuis {year}'
	String since({required Object year}) => 'Depuis ${year}';

	/// fr: 'Prier'
	String get pray => 'Prier';

	/// fr: 'Prier pour {country}'
	String prayTitle({required Object country}) => 'Prier pour ${country}';

	/// fr: 'Rends grâce pour l'œuvre de Dieu en {country}.'
	String prayThanks({required Object country}) => 'Rends grâce pour l\'œuvre de Dieu en ${country}.';

	/// fr: 'Prie pour les assemblées de {country} et pour leurs responsables.'
	String prayAssemblies({required Object country}) => 'Prie pour les assemblées de ${country} et pour leurs responsables.';

	/// fr: 'Prie pour que ceux qui n'ont pas encore cru en {country} rencontrent Jésus.'
	String prayUnreached({required Object country}) => 'Prie pour que ceux qui n\'ont pas encore cru en ${country} rencontrent Jésus.';

	/// fr: 'Notre but'
	String get purpose => 'Notre but';

	/// fr: 'Les nations'
	String get nations => 'Les nations';

	/// fr: 'Rechercher une nation'
	String get search => 'Rechercher une nation';

	/// fr: 'Aucune nation ne correspond'
	String get none => 'Aucune nation ne correspond';

	/// fr: '(one) {Présente dans {n} nation} (other) {Présente dans {n} nations}'
	String homeText({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
		one: 'Présente dans ${n} nation',
		other: 'Présente dans ${n} nations',
	);

	/// fr: 'Le globe et le voyage de nation en nation'
	String get nationsSubtitle => 'Le globe et le voyage de nation en nation';

	/// fr: 'Nos trois buts'
	String get purposeSubtitle => 'Nos trois buts';

	/// fr: 'Nos missionnaires'
	String get missionaries => 'Nos missionnaires';

	/// fr: 'Ceux que le Seigneur envoie aux nations'
	String get missionariesSubtitle => 'Ceux que le Seigneur envoie aux nations';

	/// fr: 'Nos héros'
	String get heroes => 'Nos héros';

	/// fr: 'Ceux dont la foi nous inspire'
	String get heroesSubtitle => 'Ceux dont la foi nous inspire';

	/// fr: 'Notre fondateur'
	String get founder => 'Notre fondateur';

	/// fr: 'Le Pr Zacharias Tanee Fomum'
	String get founderSubtitle => 'Le Pr Zacharias Tanee Fomum';

	/// fr: 'Notre leader'
	String get leader => 'Notre leader';

	/// fr: 'Théodore Andoseh'
	String get leaderSubtitle => 'Théodore Andoseh';

	/// fr: 'Les portraits de nos missionnaires arrivent bientôt.'
	String get missionariesEmpty => 'Les portraits de nos missionnaires arrivent bientôt.';

	/// fr: 'Les portraits de nos héros arrivent bientôt.'
	String get heroesEmpty => 'Les portraits de nos héros arrivent bientôt.';

	/// fr: 'Ce portrait n'est plus disponible.'
	String get personGone => 'Ce portrait n\'est plus disponible.';

	/// fr: 'Photo de {name}'
	String photoOf({required Object name}) => 'Photo de ${name}';

	/// fr: 'Les grandes dates'
	String get keyDates => 'Les grandes dates';

	/// fr: 'Sa vie'
	String get life => 'Sa vie';

	/// fr: 'Son histoire'
	String get story => 'Son histoire';

	/// fr: 'NOTRE BUT · {n}/{total}'
	String goalOf({required Object n, required Object total}) => 'NOTRE BUT · ${n}/${total}';

	/// fr: 'But précédent'
	String get previousGoal => 'But précédent';

	/// fr: 'But suivant'
	String get nextGoal => 'But suivant';

	Map<String, String> get media => {
		'books': 'Livres',
		'tracts': 'Traités',
		'magazines': 'Magazines',
		'cds': 'CD',
		'dvds': 'DVD',
		'radio': 'Radio',
		'tv': 'Télévision',
		'internet': 'Internet',
	};
	late final Translations$ministry$goals$fr goals = Translations$ministry$goals$fr.internal(_root);
	late final Translations$ministry$lives$fr lives = Translations$ministry$lives$fr.internal(_root);
}

// Path: prayer
class Translations$prayer$fr {
	Translations$prayer$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	Map<String, String> get moments => {
		'morning': 'Matin',
		'noon': 'Midi',
		'evening': 'Soirée',
		'night': 'Nuit',
	};
	Map<String, String> get retreatOf => {
		'morning': 'Retraite du matin',
		'noon': 'Retraite de midi',
		'evening': 'Retraite du soir',
		'night': 'Retraite de la nuit',
	};
	late final Translations$prayer$hero$fr hero = Translations$prayer$hero$fr.internal(_root);
	late final Translations$prayer$today$fr today = Translations$prayer$today$fr.internal(_root);
	late final Translations$prayer$routine$fr routine = Translations$prayer$routine$fr.internal(_root);

	/// fr: 'Prier ensemble'
	String get together => 'Prier ensemble';

	late final Translations$prayer$reminders$fr reminders = Translations$prayer$reminders$fr.internal(_root);
	late final Translations$prayer$retreat$fr retreat = Translations$prayer$retreat$fr.internal(_root);
	late final Translations$prayer$session$fr session = Translations$prayer$session$fr.internal(_root);
	late final Translations$prayer$done$fr done = Translations$prayer$done$fr.internal(_root);
	late final Translations$prayer$topics$fr topics = Translations$prayer$topics$fr.internal(_root);
	late final Translations$prayer$lists$fr lists = Translations$prayer$lists$fr.internal(_root);
	late final Translations$prayer$importunity$fr importunity = Translations$prayer$importunity$fr.internal(_root);
}

// Path: sending
class Translations$sending$fr {
	Translations$sending$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Envoi à mes autorités'
	String get title => 'Envoi à mes autorités';

	/// fr: 'Désactivé'
	String get moreOff => 'Désactivé';

	/// fr: 'Au moment choisi, CMFI Connect prépare ton compte rendu de la période. Tu n'as plus qu'à l'envoyer à tes autorités spirituelles.'
	String get intro => 'Au moment choisi, CMFI Connect prépare ton compte rendu de la période. Tu n\'as plus qu\'à l\'envoyer à tes autorités spirituelles.';

	/// fr: 'Me le préparer régulièrement'
	String get enabled => 'Me le préparer régulièrement';

	/// fr: 'Rythme'
	String get rhythm => 'Rythme';

	/// fr: 'Chaque semaine'
	String get weekly => 'Chaque semaine';

	/// fr: 'Toutes les 2 semaines'
	String get biweekly => 'Toutes les 2 semaines';

	/// fr: 'Chaque mois'
	String get monthly => 'Chaque mois';

	/// fr: 'Jour'
	String get day => 'Jour';

	/// fr: 'Le 1er de chaque mois, pour le mois écoulé'
	String get monthlyDay => 'Le 1er de chaque mois, pour le mois écoulé';

	/// fr: 'Heure'
	String get time => 'Heure';

	/// fr: 'Destinataires'
	String get recipients => 'Destinataires';

	/// fr: 'Ajoute d'abord tes autorités spirituelles.'
	String get noAuthorities => 'Ajoute d\'abord tes autorités spirituelles.';

	/// fr: 'Ajouter mes autorités'
	String get addAuthorities => 'Ajouter mes autorités';

	/// fr: 'Par WhatsApp'
	String get viaWhatsApp => 'Par WhatsApp';

	/// fr: 'Par e-mail'
	String get viaEmail => 'Par e-mail';

	/// fr: 'Par WhatsApp ou e-mail'
	String get viaBoth => 'Par WhatsApp ou e-mail';

	/// fr: 'Par le partage'
	String get viaShare => 'Par le partage';

	/// fr: 'Prochain : {date}'
	String next({required Object date}) => 'Prochain : ${date}';

	/// fr: 'Préparer maintenant'
	String get prepareNow => 'Préparer maintenant';

	/// fr: 'Derniers envois'
	String get history => 'Derniers envois';

	/// fr: 'Ton compte rendu est prêt'
	String get notificationTitle => 'Ton compte rendu est prêt';

	/// fr: 'Envoie-le à tes autorités en un geste.'
	String get notificationBody => 'Envoie-le à tes autorités en un geste.';

	/// fr: 'Envoi du compte rendu'
	String get channel => 'Envoi du compte rendu';

	/// fr: 'Ton compte rendu est prêt'
	String get readyTitle => 'Ton compte rendu est prêt';

	/// fr: 'Aperçu du message'
	String get preview => 'Aperçu du message';

	/// fr: 'Bonjour {name},'
	String greeting({required Object name}) => 'Bonjour ${name},';

	/// fr: 'WhatsApp'
	String get whatsApp => 'WhatsApp';

	/// fr: 'E-mail'
	String get email => 'E-mail';

	/// fr: 'Partager le PDF'
	String get sharePdf => 'Partager le PDF';

	/// fr: 'Partager le texte'
	String get shareText => 'Partager le texte';

	/// fr: 'Envoyé'
	String get sent => 'Envoyé';

	/// fr: 'Partage'
	String get shared => 'Partage';

	/// fr: 'Choisis tes destinataires dans les réglages, ou partage le PDF.'
	String get noRecipients => 'Choisis tes destinataires dans les réglages, ou partage le PDF.';

	/// fr: 'Réglages'
	String get settings => 'Réglages';

	/// fr: 'Autorise les notifications pour être prévenu au bon moment.'
	String get permissionDenied => 'Autorise les notifications pour être prévenu au bon moment.';
}

// Path: streak
class Translations$streak$fr {
	Translations$streak$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: '(one) {{n} jour d'affilée !} (other) {{n} jours d'affilée !}'
	String title({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
		one: '${n} jour d\'affilée !',
		other: '${n} jours d\'affilée !',
	);

	/// fr: '(one) {jour avec Dieu} (other) {jours avec Dieu}'
	String cardDays({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
		one: 'jour avec Dieu',
		other: 'jours avec Dieu',
	);

	late final Translations$streak$lines$fr lines = Translations$streak$lines$fr.internal(_root);

	/// fr: 'Partager'
	String get share => 'Partager';

	/// fr: 'Continuer'
	String get close => 'Continuer';
}

// Path: shortcuts
class Translations$shortcuts$fr {
	Translations$shortcuts$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Remplir mon compte rendu'
	String get today => 'Remplir mon compte rendu';

	/// fr: 'Cantiques'
	String get hymns => 'Cantiques';

	/// fr: 'Retraite du moment'
	String get retreat => 'Retraite du moment';
}

// Path: blocking
class Translations$blocking$fr {
	Translations$blocking$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Signaler'
	String get report => 'Signaler';

	/// fr: 'Bloquer {name}'
	String block({required Object name}) => 'Bloquer ${name}';

	/// fr: 'Bloquer {name} ?'
	String blockTitle({required Object name}) => 'Bloquer ${name} ?';

	/// fr: 'Tu ne recevras plus d'invitation de {name}. Cette invitation est retirée.'
	String blockText({required Object name}) => 'Tu ne recevras plus d\'invitation de ${name}. Cette invitation est retirée.';

	/// fr: 'Bloquer'
	String get blockAction => 'Bloquer';

	/// fr: '{name} ne pourra plus t'inviter.'
	String blocked({required Object name}) => '${name} ne pourra plus t\'inviter.';

	/// fr: 'Signaler cette invitation'
	String get reportTitle => 'Signaler cette invitation';

	/// fr: 'Dis-nous ce qui ne va pas : les responsables de la communauté regarderont.'
	String get reportText => 'Dis-nous ce qui ne va pas : les responsables de la communauté regarderont.';

	late final Translations$blocking$reasons$fr reasons = Translations$blocking$reasons$fr.internal(_root);

	/// fr: 'Commentaire'
	String get comment => 'Commentaire';

	/// fr: 'Ce que les responsables doivent savoir'
	String get commentHint => 'Ce que les responsables doivent savoir';

	/// fr: 'Envoyer le signalement'
	String get send => 'Envoyer le signalement';

	/// fr: 'Merci, les responsables vont regarder.'
	String get reported => 'Merci, les responsables vont regarder.';

	/// fr: 'Membres bloqués'
	String get listTitle => 'Membres bloqués';

	/// fr: 'Leurs invitations à prier ne t'arrivent plus.'
	String get intro => 'Leurs invitations à prier ne t\'arrivent plus.';

	/// fr: 'Tu n'as bloqué personne.'
	String get empty => 'Tu n\'as bloqué personne.';

	/// fr: 'Débloquer'
	String get unblock => 'Débloquer';

	/// fr: '{name} peut de nouveau t'inviter.'
	String unblocked({required Object name}) => '${name} peut de nouveau t\'inviter.';
}

// Path: verses
class Translations$verses$fr {
	Translations$verses$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Verset du jour'
	String get title => 'Verset du jour';

	/// fr: 'Partager le verset'
	String get share => 'Partager le verset';

	/// fr: 'Partager l'image'
	String get shareImage => 'Partager l\'image';

	/// fr: 'Partager le texte'
	String get shareText => 'Partager le texte';
}

// Path: bible
class Translations$bible$fr {
	Translations$bible$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Bible'
	String get title => 'Bible';

	/// fr: 'Livres'
	String get books => 'Livres';

	/// fr: 'Ancien Testament'
	String get oldTestament => 'Ancien Testament';

	/// fr: 'Nouveau Testament'
	String get newTestament => 'Nouveau Testament';

	/// fr: '(one) {{n} chapitre} (other) {{n} chapitres}'
	String chapters({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
		one: '${n} chapitre',
		other: '${n} chapitres',
	);

	/// fr: 'Chapitre {n}'
	String chapter({required Object n}) => 'Chapitre ${n}';

	/// fr: 'Version'
	String get version => 'Version';

	/// fr: 'Version de la Bible'
	String get versions => 'Version de la Bible';

	/// fr: 'Rechercher dans la Bible'
	String get search => 'Rechercher dans la Bible';

	/// fr: 'Un mot, ou « Jean 3:16 »'
	String get searchHint => 'Un mot, ou « Jean 3:16 »';

	/// fr: 'Cherche un mot (« amour ») ou va directement à un passage (« Psaume 23 », « Jean 3:16 »).'
	String get searchTip => 'Cherche un mot (« amour ») ou va directement à un passage (« Psaume 23 », « Jean 3:16 »).';

	/// fr: 'Aucun verset ne contient ces mots.'
	String get searchNone => 'Aucun verset ne contient ces mots.';

	/// fr: '(one) {{n} verset} (other) {{n} versets}'
	String searchCount({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
		one: '${n} verset',
		other: '${n} versets',
	);

	/// fr: 'Les {n} premiers versets'
	String searchLimit({required Object n}) => 'Les ${n} premiers versets';

	/// fr: 'Pour chercher des mots dans toute la Bible, télécharge-la. Tu peux déjà taper un passage : « Jean 3:16 ».'
	String get searchNeedsDownload => 'Pour chercher des mots dans toute la Bible, télécharge-la. Tu peux déjà taper un passage : « Jean 3:16 ».';

	/// fr: 'Ouvrir {reference}'
	String open({required Object reference}) => 'Ouvrir ${reference}';

	/// fr: 'Chapitre précédent'
	String get previous => 'Chapitre précédent';

	/// fr: 'Chapitre suivant'
	String get next => 'Chapitre suivant';

	/// fr: 'J'ai lu ce chapitre'
	String get markRead => 'J\'ai lu ce chapitre';

	/// fr: 'Lu aujourd'hui'
	String get markedRead => 'Lu aujourd\'hui';

	/// fr: 'Ajoute 1 chapitre à « Lecture biblique » dans ton compte rendu.'
	String get markReadHint => 'Ajoute 1 chapitre à « Lecture biblique » dans ton compte rendu.';

	/// fr: '(one) {Compte rendu : {n} chapitre lu aujourd'hui} (other) {Compte rendu : {n} chapitres lus aujourd'hui}'
	String addedToReport({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
		one: 'Compte rendu : ${n} chapitre lu aujourd\'hui',
		other: 'Compte rendu : ${n} chapitres lus aujourd\'hui',
	);

	/// fr: 'Retiré de ton compte rendu'
	String get removedFromReport => 'Retiré de ton compte rendu';

	/// fr: 'Ton compte rendu n'a pas d'élément « Lecture biblique ».'
	String get noReadingItem => 'Ton compte rendu n\'a pas d\'élément « Lecture biblique ».';

	/// fr: 'Télécharger cette Bible'
	String get download => 'Télécharger cette Bible';

	/// fr: 'Environ {size} Mo, pour lire et chercher sans réseau.'
	String downloadHelp({required Object size}) => 'Environ ${size} Mo, pour lire et chercher sans réseau.';

	/// fr: 'Téléchargement… {percent} %'
	String downloading({required Object percent}) => 'Téléchargement… ${percent} %';

	/// fr: 'Sur ton téléphone'
	String get downloaded => 'Sur ton téléphone';

	/// fr: '{version} est sur ton téléphone'
	String downloadDone({required Object version}) => '${version} est sur ton téléphone';

	/// fr: 'Retirer du téléphone'
	String get removeDownload => 'Retirer du téléphone';

	/// fr: 'Retirer {version} du téléphone ?'
	String removeDownloadTitle({required Object version}) => 'Retirer ${version} du téléphone ?';

	/// fr: 'Les chapitres que tu as déjà lus restent disponibles sans réseau.'
	String get removeDownloadText => 'Les chapitres que tu as déjà lus restent disponibles sans réseau.';

	/// fr: 'Ce chapitre n'est pas encore sur ton téléphone. Reconnecte-toi, ou télécharge cette Bible pour la lire sans réseau.'
	String get offline => 'Ce chapitre n\'est pas encore sur ton téléphone. Reconnecte-toi, ou télécharge cette Bible pour la lire sans réseau.';

	/// fr: 'Ce passage n'est pas dans cette version.'
	String get notInVersion => 'Ce passage n\'est pas dans cette version.';

	/// fr: 'Mes versets'
	String get marks => 'Mes versets';

	/// fr: 'Favoris'
	String get favorites => 'Favoris';

	/// fr: 'Surlignés'
	String get highlights => 'Surlignés';

	/// fr: 'Touche un verset, puis le marque-page, pour le retrouver ici.'
	String get noFavorites => 'Touche un verset, puis le marque-page, pour le retrouver ici.';

	/// fr: 'Touche un verset, puis une couleur, pour le surligner.'
	String get noHighlights => 'Touche un verset, puis une couleur, pour le surligner.';

	/// fr: 'Touche un verset pour le surligner, le garder, le copier ou le partager.'
	String get tapHint => 'Touche un verset pour le surligner, le garder, le copier ou le partager.';

	/// fr: 'Surligner en {color}'
	String highlight({required Object color}) => 'Surligner en ${color}';

	late final Translations$bible$colors$fr colors = Translations$bible$colors$fr.internal(_root);

	/// fr: 'Retirer la couleur'
	String get removeHighlight => 'Retirer la couleur';

	/// fr: 'Ajouter à Mes versets'
	String get addFavorite => 'Ajouter à Mes versets';

	/// fr: 'Retirer de Mes versets'
	String get removeFavorite => 'Retirer de Mes versets';

	/// fr: 'Ajouté à Mes versets'
	String get favoriteAdded => 'Ajouté à Mes versets';

	/// fr: 'Retiré de Mes versets'
	String get favoriteRemoved => 'Retiré de Mes versets';

	/// fr: 'Copier'
	String get copy => 'Copier';

	/// fr: 'Copié'
	String get copied => 'Copié';

	/// fr: 'Partager'
	String get share => 'Partager';

	/// fr: 'Fermer la sélection'
	String get closeSelection => 'Fermer la sélection';

	/// fr: 'Affichage'
	String get display => 'Affichage';

	/// fr: 'Paroles de Jésus en rouge'
	String get jesusInRed => 'Paroles de Jésus en rouge';

	/// fr: 'Dans les versions qui les indiquent'
	String get jesusInRedHelp => 'Dans les versions qui les indiquent';

	/// fr: 'Retirer'
	String get remove => 'Retirer';

	/// fr: 'Lire dans la Bible'
	String get readInBible => 'Lire dans la Bible';

	/// fr: 'Concordance'
	String get concordance => 'Concordance';

	/// fr: 'Concordance de « {word} »'
	String concordanceOf({required Object word}) => 'Concordance de « ${word} »';

	/// fr: 'Un mot de la Bible'
	String get concordanceHint => 'Un mot de la Bible';

	/// fr: 'Tape un mot : la concordance montre tous les versets où il apparaît, livre par livre.'
	String get concordanceTip => 'Tape un mot : la concordance montre tous les versets où il apparaît, livre par livre.';

	/// fr: 'La concordance parcourt toute la Bible : télécharge-la d'abord.'
	String get concordanceNeedsDownload => 'La concordance parcourt toute la Bible : télécharge-la d\'abord.';

	/// fr: 'Ce mot n'est pas dans cette Bible.'
	String get concordanceNone => 'Ce mot n\'est pas dans cette Bible.';

	/// fr: 'Ce mot'
	String get exactWord => 'Ce mot';

	/// fr: 'Commence par…'
	String get startsWith => 'Commence par…';

	/// fr: '(one) {occurrence} (other) {occurrences}'
	String occurrences({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
		one: 'occurrence',
		other: 'occurrences',
	);

	/// fr: '(one) {dans {n} verset} (other) {dans {n} versets}'
	String inVerses({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
		one: 'dans ${n} verset',
		other: 'dans ${n} versets',
	);

	/// fr: 'Où ce mot apparaît'
	String get spread => 'Où ce mot apparaît';

	/// fr: 'Formes trouvées'
	String get forms => 'Formes trouvées';

	/// fr: '{book} : {n}'
	String bookCount({required Object book, required Object n}) => '${book} : ${n}';

	/// fr: 'Tous les livres'
	String get allBooks => 'Tous les livres';

	/// fr: 'Choisis un mot'
	String get pickWord => 'Choisis un mot';

	/// fr: 'La concordance montre tous les versets où il apparaît.'
	String get pickWordHelp => 'La concordance montre tous les versets où il apparaît.';

	/// fr: 'Plus d'options'
	String get more => 'Plus d\'options';
}

// Path: profilePhoto
class Translations$profilePhoto$fr {
	Translations$profilePhoto$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Photo de profil'
	String get title => 'Photo de profil';

	/// fr: 'Ajouter une photo de profil'
	String get add => 'Ajouter une photo de profil';

	/// fr: 'Changer la photo de profil'
	String get change => 'Changer la photo de profil';

	/// fr: 'Les autres membres la voient là où ton nom apparaît.'
	String get seenBy => 'Les autres membres la voient là où ton nom apparaît.';

	/// fr: 'Prendre une photo'
	String get camera => 'Prendre une photo';

	/// fr: 'Choisir dans la galerie'
	String get gallery => 'Choisir dans la galerie';

	/// fr: 'Retirer la photo'
	String get remove => 'Retirer la photo';

	/// fr: 'Recadre ta photo'
	String get cropTitle => 'Recadre ta photo';

	/// fr: 'Déplace et agrandis la photo avec tes doigts.'
	String get cropHint => 'Déplace et agrandis la photo avec tes doigts.';

	/// fr: 'Utiliser cette photo'
	String get use => 'Utiliser cette photo';

	/// fr: 'Impossible d'ouvrir cette image. Choisis-en une autre.'
	String get unreadable => 'Impossible d\'ouvrir cette image. Choisis-en une autre.';

	/// fr: 'Ta photo de profil est enregistrée.'
	String get saved => 'Ta photo de profil est enregistrée.';

	/// fr: 'Ta photo de profil est retirée.'
	String get removed => 'Ta photo de profil est retirée.';
}

// Path: disciples
class Translations$disciples$fr {
	Translations$disciples$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Mes disciples'
	String get title => 'Mes disciples';

	/// fr: 'Pas encore de disciple'
	String get empty => 'Pas encore de disciple';

	/// fr: 'Quand un membre te choisit comme faiseur de disciples ou comme autorité et que tu acceptes sa demande, il apparaît ici.'
	String get emptyText => 'Quand un membre te choisit comme faiseur de disciples ou comme autorité et que tu acceptes sa demande, il apparaît ici.';

	/// fr: '(one) {{n} disciple} (other) {{n} disciples}'
	String count({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
		one: '${n} disciple',
		other: '${n} disciples',
	);

	/// fr: 'Ne partage pas ses comptes rendus'
	String get notShared => 'Ne partage pas ses comptes rendus';

	/// fr: 'Tu es son faiseur de disciples'
	String get roleMaker => 'Tu es son faiseur de disciples';

	/// fr: 'Tu es l'une de ses autorités'
	String get roleAuthority => 'Tu es l\'une de ses autorités';

	/// fr: 'Objectifs {percent} %'
	String dayGoals({required Object percent}) => 'Objectifs ${percent} %';

	/// fr: '{filled} sur {total} éléments · {percent} %'
	String dayItems({required Object filled, required Object total, required Object percent}) => '${filled} sur ${total} éléments · ${percent} %';

	/// fr: 'Voir les 30 jours précédents'
	String get older => 'Voir les 30 jours précédents';

	/// fr: 'Pas de compte rendu sur cette période.'
	String get noReports => 'Pas de compte rendu sur cette période.';

	/// fr: 'Nom ou pseudo'
	String get searchHint => 'Nom ou pseudo';

	/// fr: 'Aucun disciple ne correspond à « {search} ».'
	String noMatch({required Object search}) => 'Aucun disciple ne correspond à « ${search} ».';
}

// Path: weekStory
class Translations$weekStory$fr {
	Translations$weekStory$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Ta semaine avec Dieu'
	String get title => 'Ta semaine avec Dieu';

	/// fr: 'Du {from} au {to}'
	String range({required Object from, required Object to}) => 'Du ${from} au ${to}';

	/// fr: 'Revois ce que tu as vécu avec le Seigneur cette semaine.'
	String get intro => 'Revois ce que tu as vécu avec le Seigneur cette semaine.';

	/// fr: 'Touche à droite pour avancer, à gauche pour revenir.'
	String get tapHint => 'Touche à droite pour avancer, à gauche pour revenir.';

	/// fr: 'Tu as été fidèle'
	String get faithfulLead => 'Tu as été fidèle';

	/// fr: 'Une nouvelle semaine t'attend'
	String get emptyLead => 'Une nouvelle semaine t\'attend';

	/// fr: '(one) {{n} jour sur {total}} (other) {{n} jours sur {total}}'
	String days({required num n, required Object total}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
		one: '${n} jour\nsur ${total}',
		other: '${n} jours\nsur ${total}',
	);

	/// fr: '(one) {{n} jour d'affilée} (other) {{n} jours d'affilée}'
	String streak({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
		one: '${n} jour d\'affilée',
		other: '${n} jours d\'affilée',
	);

	/// fr: '(one) {{n} jour d'affilée : ton record !} (other) {{n} jours d'affilée : ton record !}'
	String streakRecord({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
		one: '${n} jour d\'affilée : ton record !',
		other: '${n} jours d\'affilée : ton record !',
	);

	/// fr: 'Remplis ton compte rendu chaque jour : ta prochaine semaine s'écrira ici.'
	String get emptyText => 'Remplis ton compte rendu chaque jour : ta prochaine semaine s\'écrira ici.';

	/// fr: 'Tu as prié'
	String get prayerLead => 'Tu as prié';

	/// fr: '(one) {{n} retraite} (other) {{n} retraites}'
	String retreats({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
		one: '${n} retraite',
		other: '${n} retraites',
	);

	/// fr: 'de 15 minutes · {time} avec le Seigneur'
	String retreatsTime({required Object time}) => 'de 15 minutes · ${time} avec le Seigneur';

	/// fr: '(one) {Ton moment le plus fidèle : {moment} ({n} fois)} (other) {Ton moment le plus fidèle : {moment} ({n} fois)}'
	String faithfulMoment({required num n, required Object moment}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
		one: 'Ton moment le plus fidèle : ${moment} (${n} fois)',
		other: 'Ton moment le plus fidèle : ${moment} (${n} fois)',
	);

	/// fr: 'Pas de retraite cette semaine'
	String get noRetreat => 'Pas de retraite cette semaine';

	/// fr: 'La retraite de midi t'attend : 15 minutes avec le Seigneur.'
	String get noRetreatText => 'La retraite de midi t\'attend : 15 minutes avec le Seigneur.';

	/// fr: 'Tes objectifs'
	String get goalsLead => 'Tes objectifs';

	/// fr: 'atteints en moyenne'
	String get goalsReached => 'atteints en moyenne';

	/// fr: 'Ton meilleur jour : {day} · {percent}'
	String bestDay({required Object day, required Object percent}) => 'Ton meilleur jour : ${day} · ${percent}';

	/// fr: 'Ma semaine avec Dieu'
	String get summaryTitle => 'Ma semaine avec Dieu';

	/// fr: 'jours remplis'
	String get statDays => 'jours remplis';

	/// fr: '(one) {jour d'affilée} (other) {jours d'affilée}'
	String statStreak({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
		one: 'jour d\'affilée',
		other: 'jours d\'affilée',
	);

	/// fr: '(one) {retraite} (other) {retraites}'
	String statRetreats({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
		one: 'retraite',
		other: 'retraites',
	);

	/// fr: 'd'objectifs'
	String get statGoals => 'd\'objectifs';

	/// fr: 'Partager ma semaine'
	String get share => 'Partager ma semaine';

	/// fr: 'Ta fidélité, ta prière et tes objectifs de la semaine.'
	String get homeText => 'Ta fidélité, ta prière et tes objectifs de la semaine.';

	/// fr: 'Voir ma semaine'
	String get open => 'Voir ma semaine';

	/// fr: 'Ta semaine avec Dieu est prête'
	String get notificationTitle => 'Ta semaine avec Dieu est prête';

	/// fr: 'Revois ta fidélité de la semaine et partage-la.'
	String get notificationBody => 'Revois ta fidélité de la semaine et partage-la.';

	/// fr: 'Ta semaine avec Dieu'
	String get channel => 'Ta semaine avec Dieu';

	/// fr: 'Cette semaine'
	String get thisWeek => 'Cette semaine';

	/// fr: 'Semaines passées'
	String get pastWeeks => 'Semaines passées';

	/// fr: 'Semaine du {date}'
	String weekOf({required Object date}) => 'Semaine du ${date}';

	/// fr: '{current} sur {total}'
	String page({required Object current, required Object total}) => '${current} sur ${total}';
}

// Path: seekFirst
class Translations$seekFirst$fr {
	Translations$seekFirst$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Cherche d'abord Dieu'
	String get title => 'Cherche d\'abord Dieu';

	/// fr: 'Cherchez premièrement le royaume et la justice de Dieu ; et toutes ces choses vous seront données par-dessus.'
	String get verse => 'Cherchez premièrement le royaume et la justice de Dieu ; et toutes ces choses vous seront données par-dessus.';

	/// fr: 'Matthieu 6:33'
	String get verseRef => 'Matthieu 6:33';

	/// fr: 'Chaque jour, les apps que tu choisis restent fermées tant que ton compte rendu n'est pas enregistré. Commence ta journée avec Dieu, le reste suit.'
	String get intro => 'Chaque jour, les apps que tu choisis restent fermées tant que ton compte rendu n\'est pas enregistré. Commence ta journée avec Dieu, le reste suit.';

	/// fr: 'Activer'
	String get enable => 'Activer';

	/// fr: 'Apps à garder fermées'
	String get apps => 'Apps à garder fermées';

	/// fr: 'Aucune app choisie'
	String get appsNone => 'Aucune app choisie';

	/// fr: '(one) {{n} app} (other) {{n} apps}'
	String appCount({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
		one: '${n} app',
		other: '${n} apps',
	);

	/// fr: '(one) {{n} catégorie} (other) {{n} catégories}'
	String categoryCount({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
		one: '${n} catégorie',
		other: '${n} catégories',
	);

	/// fr: '(one) {{n} site} (other) {{n} sites}'
	String siteCount({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
		one: '${n} site',
		other: '${n} sites',
	);

	/// fr: 'Fermées à partir de'
	String get start => 'Fermées à partir de';

	/// fr: 'Pauses de 5 minutes'
	String get pauses => 'Pauses de 5 minutes';

	/// fr: '3 par jour, pour une urgence'
	String get pausesText => '3 par jour, pour une urgence';

	/// fr: '(zero) {Plus de pause aujourd'hui} (one) {Encore {n} pause aujourd'hui} (other) {Encore {n} pauses aujourd'hui}'
	String pausesLeft({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
		zero: 'Plus de pause aujourd\'hui',
		one: 'Encore ${n} pause aujourd\'hui',
		other: 'Encore ${n} pauses aujourd\'hui',
	);

	/// fr: 'Aujourd'hui, tes apps sont ouvertes : tu as cherché Dieu d'abord.'
	String get todayOpen => 'Aujourd\'hui, tes apps sont ouvertes : tu as cherché Dieu d\'abord.';

	/// fr: 'Tes apps restent fermées jusqu'à ton compte rendu d'aujourd'hui.'
	String get todayLocked => 'Tes apps restent fermées jusqu\'à ton compte rendu d\'aujourd\'hui.';

	/// fr: 'Tes apps se fermeront à {time} si ton compte rendu n'est pas encore enregistré.'
	String todayBefore({required Object time}) => 'Tes apps se fermeront à ${time} si ton compte rendu n\'est pas encore enregistré.';

	/// fr: 'Remplir mon compte rendu'
	String get fillReport => 'Remplir mon compte rendu';

	/// fr: 'Sans l'accès à Temps d'écran, CMFI Connect ne peut pas fermer d'apps. Tu peux l'autoriser dans Réglages › Temps d'écran.'
	String get denied => 'Sans l\'accès à Temps d\'écran, CMFI Connect ne peut pas fermer d\'apps. Tu peux l\'autoriser dans Réglages › Temps d\'écran.';

	/// fr: 'Choisis au moins une app à garder fermée.'
	String get noApps => 'Choisis au moins une app à garder fermée.';

	/// fr: 'Bientôt disponible sur ce téléphone.'
	String get unsupported => 'Bientôt disponible sur ce téléphone.';

	/// fr: 'Dès {time}, jusqu'à ton compte rendu'
	String moreOn({required Object time}) => 'Dès ${time}, jusqu\'à ton compte rendu';

	/// fr: 'Fermer des apps tant que ton compte rendu n'est pas fait'
	String get moreOff => 'Fermer des apps tant que ton compte rendu n\'est pas fait';

	/// fr: 'CMFI Connect ne voit jamais les apps que tu choisis : ton iPhone les garde pour lui.'
	String get privacy => 'CMFI Connect ne voit jamais les apps que tu choisis : ton iPhone les garde pour lui.';

	late final Translations$seekFirst$shield$fr shield = Translations$seekFirst$shield$fr.internal(_root);
}

// Path: documents
class Translations$documents$fr {
	Translations$documents$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Nos documents'
	String get title => 'Nos documents';

	/// fr: 'Enseignements, règlements, formulaires…'
	String get subtitle => 'Enseignements, règlements, formulaires…';

	/// fr: 'La bibliothèque de la communauté'
	String get moreSubtitle => 'La bibliothèque de la communauté';

	/// fr: 'Rechercher un document'
	String get search => 'Rechercher un document';

	/// fr: 'Tous'
	String get all => 'Tous';

	/// fr: 'Aucun document pour l'instant. Les documents publiés par la communauté apparaîtront ici.'
	String get empty => 'Aucun document pour l\'instant. Les documents publiés par la communauté apparaîtront ici.';

	/// fr: 'Aucun document ne correspond à ta recherche.'
	String get none => 'Aucun document ne correspond à ta recherche.';

	/// fr: '{n} Ko'
	String sizeKb({required Object n}) => '${n} Ko';

	/// fr: '{n} Mo'
	String sizeMb({required Object n}) => '${n} Mo';

	/// fr: 'PDF'
	String get pdf => 'PDF';

	/// fr: 'Word'
	String get word => 'Word';

	/// fr: 'Ouvrir le document'
	String get open => 'Ouvrir le document';

	/// fr: 'Télécharger'
	String get download => 'Télécharger';

	/// fr: '(one) {{n} document} (other) {{n} documents}'
	String count({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
		one: '${n} document',
		other: '${n} documents',
	);

	/// fr: 'Voir plus'
	String get more => 'Voir plus';
}

// Path: biblePlan
class Translations$biblePlan$fr {
	Translations$biblePlan$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Plan de lecture'
	String get title => 'Plan de lecture';

	/// fr: 'Choisis ce que tu veux lire et en combien de temps : l'app répartit les chapitres jour après jour.'
	String get intro => 'Choisis ce que tu veux lire et en combien de temps : l\'app répartit les chapitres jour après jour.';

	/// fr: 'Durée'
	String get duration => 'Durée';

	/// fr: '3 mois'
	String get months3 => '3 mois';

	/// fr: '6 mois'
	String get months6 => '6 mois';

	/// fr: '1 an'
	String get year => '1 an';

	/// fr: 'Autre'
	String get custom => 'Autre';

	/// fr: '(one) {{n} jour} (other) {{n} jours}'
	String days({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
		one: '${n} jour',
		other: '${n} jours',
	);

	/// fr: 'Ce que tu lis'
	String get scope => 'Ce que tu lis';

	Map<String, String> get scopes => {
		'bible': 'Toute la Bible',
		'newTestament': 'Le Nouveau Testament',
		'oldTestament': 'L\'Ancien Testament',
		'psalmsProverbs': 'Psaumes et Proverbes',
	};

	/// fr: 'Ordre'
	String get order => 'Ordre';

	Map<String, String> get orders => {
		'canonical': 'Livre après livre',
		'parallel': 'AT + NT chaque jour',
	};

	/// fr: 'Rappel chaque jour'
	String get reminder => 'Rappel chaque jour';

	/// fr: 'Heure du rappel'
	String get reminderAt => 'Heure du rappel';

	/// fr: '{chapters} chapitres en {days} jours, environ {perDay} par jour'
	String summary({required Object chapters, required Object days, required Object perDay}) => '${chapters} chapitres en ${days} jours, environ ${perDay} par jour';

	/// fr: 'Fin le {date}'
	String endsOn({required Object date}) => 'Fin le ${date}';

	/// fr: 'Le plan commence le {date}.'
	String startsOn({required Object date}) => 'Le plan commence le ${date}.';

	/// fr: 'Commencer le plan'
	String get start => 'Commencer le plan';

	/// fr: 'Jour {day} sur {total}'
	String dayOf({required Object day, required Object total}) => 'Jour ${day} sur ${total}';

	/// fr: 'Lecture du jour'
	String get today => 'Lecture du jour';

	/// fr: 'Lecture du jour faite. Bravo !'
	String get todayDone => 'Lecture du jour faite. Bravo !';

	/// fr: 'Lire'
	String get read => 'Lire';

	/// fr: '(one) {{n} jour de retard} (other) {{n} jours de retard}'
	String behind({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
		one: '${n} jour de retard',
		other: '${n} jours de retard',
	);

	/// fr: 'Touche ici pour voir les chapitres à rattraper.'
	String get catchUp => 'Touche ici pour voir les chapitres à rattraper.';

	/// fr: '{read} chapitres sur {total}'
	String chaptersRead({required Object read, required Object total}) => '${read} chapitres sur ${total}';

	/// fr: 'En retard'
	String get late => 'En retard';

	/// fr: 'À venir'
	String get upcoming => 'À venir';

	/// fr: 'Jour {n}'
	String dayNumber({required Object n}) => 'Jour ${n}';

	/// fr: 'Plan terminé ! Tu as tout lu.'
	String get finished => 'Plan terminé ! Tu as tout lu.';

	/// fr: 'Arrêter le plan'
	String get stop => 'Arrêter le plan';

	/// fr: 'Arrêter ce plan ?'
	String get stopTitle => 'Arrêter ce plan ?';

	/// fr: 'Ta progression dans ce plan sera effacée. Les chapitres comptés dans tes comptes rendus y restent.'
	String get stopText => 'Ta progression dans ce plan sera effacée. Les chapitres comptés dans tes comptes rendus y restent.';

	/// fr: 'Ta lecture du jour'
	String get reminderTitle => 'Ta lecture du jour';

	/// fr: 'Plan de lecture'
	String get reminderChannel => 'Plan de lecture';

	/// fr: 'Lecture du jour'
	String get homeTitle => 'Lecture du jour';

	/// fr: 'Marquer {chapter} comme lu'
	String check({required Object chapter}) => 'Marquer ${chapter} comme lu';

	/// fr: '{chapter} : lu'
	String uncheck({required Object chapter}) => '${chapter} : lu';
}

// Path: teachings
class Translations$teachings$fr {
	Translations$teachings$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Enseignements'
	String get title => 'Enseignements';

	/// fr: 'Écoute la Parole, où que tu sois'
	String get subtitle => 'Écoute la Parole, où que tu sois';

	/// fr: 'Chercher un message, un orateur…'
	String get search => 'Chercher un message, un orateur…';

	/// fr: 'Tous'
	String get all => 'Tous';

	/// fr: 'Téléchargés'
	String get downloadedChip => 'Téléchargés';

	/// fr: '(one) {{n} message} (other) {{n} messages}'
	String count({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
		one: '${n} message',
		other: '${n} messages',
	);

	/// fr: 'Aucun enseignement pour l'instant.'
	String get empty => 'Aucun enseignement pour l\'instant.';

	/// fr: 'Aucun enseignement ne correspond.'
	String get none => 'Aucun enseignement ne correspond.';

	/// fr: 'Aucun message téléchargé. Touche le nuage d'un message pour l'écouter sans réseau.'
	String get noneDownloaded => 'Aucun message téléchargé. Touche le nuage d\'un message pour l\'écouter sans réseau.';

	/// fr: 'Voir plus'
	String get more => 'Voir plus';

	/// fr: 'Sans réseau : voici les messages gardés sur ton téléphone.'
	String get offline => 'Sans réseau : voici les messages gardés sur ton téléphone.';

	/// fr: 'Écouter'
	String get play => 'Écouter';

	/// fr: 'Pause'
	String get pause => 'Pause';

	/// fr: 'Écouté'
	String get heard => 'Écouté';

	/// fr: 'Télécharger pour écouter sans réseau'
	String get download => 'Télécharger pour écouter sans réseau';

	/// fr: 'Gardé sur ton téléphone'
	String get downloaded => 'Gardé sur ton téléphone';

	/// fr: 'Retiré du téléphone'
	String get removed => 'Retiré du téléphone';

	/// fr: 'Arrêter le téléchargement'
	String get cancelDownload => 'Arrêter le téléchargement';

	/// fr: 'Retirer du téléphone'
	String get removeDownload => 'Retirer du téléphone';

	/// fr: 'Reculer de 15 secondes'
	String get back15 => 'Reculer de 15 secondes';

	/// fr: 'Avancer de 15 secondes'
	String get forward15 => 'Avancer de 15 secondes';

	/// fr: 'Vitesse {speed}'
	String speed({required Object speed}) => 'Vitesse ${speed}';

	/// fr: 'Message du {date}'
	String recordedOn({required Object date}) => 'Message du ${date}';

	/// fr: 'Prédications et enseignements à écouter'
	String get moreSubtitle => 'Prédications et enseignements à écouter';
}

// Path: memorize
class Translations$memorize$fr {
	Translations$memorize$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Mémorisation'
	String get title => 'Mémorisation';

	/// fr: 'Cache la Parole dans ton cœur'
	String get subtitle => 'Cache la Parole dans ton cœur';

	/// fr: 'À réviser'
	String get toReview => 'À réviser';

	/// fr: 'En cours'
	String get learning => 'En cours';

	/// fr: 'Sus'
	String get known => 'Sus';

	/// fr: '(one) {Réviser {n} verset} (other) {Réviser {n} versets}'
	String reviewCount({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
		one: 'Réviser ${n} verset',
		other: 'Réviser ${n} versets',
	);

	/// fr: 'Rien à réviser aujourd'hui.'
	String get nothingDue => 'Rien à réviser aujourd\'hui.';

	/// fr: 'Prochaine révision : {date}.'
	String nextOn({required Object date}) => 'Prochaine révision : ${date}.';

	/// fr: 'demain'
	String get tomorrow => 'demain';

	/// fr: 'Rappel des révisions'
	String get reminder => 'Rappel des révisions';

	/// fr: 'Heure du rappel'
	String get reminderAt => 'Heure du rappel';

	/// fr: 'Mes versets'
	String get myVerses => 'Mes versets';

	/// fr: 'Pour en ajouter un : dans la Bible, touche un verset puis le cerveau de la barre.'
	String get howToAdd => 'Pour en ajouter un : dans la Bible, touche un verset puis le cerveau de la barre.';

	/// fr: 'Aucun verset à mémoriser pour l'instant.'
	String get empty => 'Aucun verset à mémoriser pour l\'instant.';

	/// fr: 'Ouvrir la Bible'
	String get openBible => 'Ouvrir la Bible';

	/// fr: 'En retard'
	String get late => 'En retard';

	/// fr: 'Aujourd'hui'
	String get today => 'Aujourd\'hui';

	/// fr: '(one) {Dans {n} jour} (other) {Dans {n} jours}'
	String dueIn({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
		one: 'Dans ${n} jour',
		other: 'Dans ${n} jours',
	);

	Map<String, String> get stages => {
		'fresh': 'Nouveau',
		'learning': 'En cours',
		'known': 'Su',
	};

	/// fr: '{stage} · oublié {lapses} fois'
	String stats({required Object stage, required Object lapses}) => '${stage} · oublié ${lapses} fois';

	/// fr: 'Réviser maintenant'
	String get reviewNow => 'Réviser maintenant';

	/// fr: 'Retirer'
	String get remove => 'Retirer';

	/// fr: 'Retirer ce verset ?'
	String get removeTitle => 'Retirer ce verset ?';

	/// fr: 'Sa progression sera effacée.'
	String get removeText => 'Sa progression sera effacée.';

	/// fr: 'Verset retiré'
	String get removed => 'Verset retiré';

	/// fr: '{done} / {total}'
	String progress({required Object done, required Object total}) => '${done} / ${total}';

	/// fr: 'Voir le verset'
	String get show => 'Voir le verset';

	Map<String, String> get hints => {
		'full': 'Texte',
		'gaps': 'Trous',
		'initials': 'Initiales',
		'none': 'Rien',
	};

	/// fr: 'Récite le verset, puis vérifie.'
	String get recite => 'Récite le verset, puis vérifie.';

	Map<String, String> get grades => {
		'again': 'Encore',
		'hard': 'Difficile',
		'good': 'Bien',
		'easy': 'Facile',
	};

	/// fr: 'Tout de suite'
	String get now => 'Tout de suite';

	/// fr: '(one) {{n} jour} (other) {{n} jours}'
	String later({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
		one: '${n} jour',
		other: '${n} jours',
	);

	/// fr: 'Révisions terminées !'
	String get doneTitle => 'Révisions terminées !';

	/// fr: '(one) {Tu as révisé {n} verset. Que la Parole demeure en toi !} (other) {Tu as révisé {n} versets. Que la Parole demeure en toi !}'
	String doneText({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
		one: 'Tu as révisé ${n} verset. Que la Parole demeure en toi !',
		other: 'Tu as révisé ${n} versets. Que la Parole demeure en toi !',
	);

	/// fr: 'Retour'
	String get back => 'Retour';

	/// fr: 'Tes versets à réviser'
	String get reminderTitle => 'Tes versets à réviser';

	/// fr: '(one) {{n} verset t'attend aujourd'hui.} (other) {{n} versets t'attendent aujourd'hui.}'
	String reminderBody({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
		one: '${n} verset t\'attend aujourd\'hui.',
		other: '${n} versets t\'attendent aujourd\'hui.',
	);

	/// fr: 'Mémorisation'
	String get reminderChannel => 'Mémorisation';

	/// fr: 'Versets à réviser'
	String get homeTitle => 'Versets à réviser';

	/// fr: '(one) {{n} verset t'attend} (other) {{n} versets t'attendent}'
	String homeText({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
		one: '${n} verset t\'attend',
		other: '${n} versets t\'attendent',
	);

	/// fr: 'Mémoriser des versets'
	String get menu => 'Mémoriser des versets';

	/// fr: 'Mémoriser'
	String get memorize => 'Mémoriser';

	/// fr: 'Ajouté à tes versets à mémoriser'
	String get added => 'Ajouté à tes versets à mémoriser';

	/// fr: 'Ce passage est déjà dans tes versets'
	String get already => 'Ce passage est déjà dans tes versets';
}

// Path: souls
class Translations$souls$fr {
	Translations$souls$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Suivi des âmes'
	String get title => 'Suivi des âmes';

	/// fr: '« Celui qui gagne des âmes est sage. » Proverbes 11:30'
	String get subtitle => '« Celui qui gagne des âmes est sage. » Proverbes 11:30';

	/// fr: 'Chercher une personne…'
	String get search => 'Chercher une personne…';

	/// fr: 'Personnes'
	String get people => 'Personnes';

	/// fr: 'Ont reçu Jésus'
	String get received => 'Ont reçu Jésus';

	/// fr: 'À recontacter'
	String get toContact => 'À recontacter';

	/// fr: 'Toutes'
	String get all => 'Toutes';

	Map<String, String> get stages => {
		'met': 'Rencontré(e)',
		'interested': 'Intéressé(e)',
		'received': 'A reçu Jésus',
		'followUp': 'En affermissement',
		'church': 'Vient à l\'église',
		'baptized': 'Baptisé(e)',
	};

	/// fr: 'À recontacter'
	String get contactSection => 'À recontacter';

	/// fr: 'Toutes les personnes'
	String get everyone => 'Toutes les personnes';

	/// fr: 'À recontacter aujourd'hui'
	String get contactToday => 'À recontacter aujourd\'hui';

	/// fr: '(one) {En retard de {n} jour} (other) {En retard de {n} jours}'
	String contactLate({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
		one: 'En retard de ${n} jour',
		other: 'En retard de ${n} jours',
	);

	/// fr: 'Prochain contact le {date}'
	String contactOn({required Object date}) => 'Prochain contact le ${date}';

	/// fr: 'Note ici les personnes que tu évangélises : prie pour elles et suis-les jusqu'à l'église.'
	String get empty => 'Note ici les personnes que tu évangélises : prie pour elles et suis-les jusqu\'à l\'église.';

	/// fr: 'Personne ne correspond.'
	String get none => 'Personne ne correspond.';

	/// fr: 'Ajouter'
	String get add => 'Ajouter';

	/// fr: 'Nouvelle personne'
	String get addTitle => 'Nouvelle personne';

	/// fr: 'Modifier'
	String get editTitle => 'Modifier';

	/// fr: 'Nom'
	String get name => 'Nom';

	/// fr: 'Écris son nom.'
	String get nameRequired => 'Écris son nom.';

	/// fr: 'Téléphone'
	String get phone => 'Téléphone';

	/// fr: 'Où vous vous êtes rencontrés'
	String get place => 'Où vous vous êtes rencontrés';

	/// fr: 'Rencontré(e) le'
	String get metOn => 'Rencontré(e) le';

	/// fr: 'Où en est cette personne ?'
	String get stage => 'Où en est cette personne ?';

	/// fr: 'Une note (facultatif)'
	String get firstNote => 'Une note (facultatif)';

	/// fr: 'Ce qui a été dit, ses sujets de prière…'
	String get noteHint => 'Ce qui a été dit, ses sujets de prière…';

	/// fr: 'Enregistrer'
	String get save => 'Enregistrer';

	/// fr: 'Enregistré'
	String get saved => 'Enregistré';

	/// fr: 'Appeler'
	String get call => 'Appeler';

	/// fr: 'WhatsApp'
	String get whatsApp => 'WhatsApp';

	/// fr: 'SMS'
	String get sms => 'SMS';

	/// fr: 'Modifier'
	String get edit => 'Modifier';

	/// fr: 'Supprimer'
	String get delete => 'Supprimer';

	/// fr: 'Supprimer {name} ?'
	String deleteTitle({required Object name}) => 'Supprimer ${name} ?';

	/// fr: 'Ses notes seront effacées de ton téléphone.'
	String get deleteText => 'Ses notes seront effacées de ton téléphone.';

	/// fr: 'Supprimé'
	String get deleted => 'Supprimé';

	/// fr: 'Prochain contact'
	String get nextContact => 'Prochain contact';

	/// fr: 'Planifier un rappel'
	String get plan => 'Planifier un rappel';

	/// fr: 'Changer la date'
	String get change => 'Changer la date';

	/// fr: 'Retirer le rappel'
	String get clear => 'Retirer le rappel';

	/// fr: 'Aucun rappel prévu'
	String get noContact => 'Aucun rappel prévu';

	/// fr: 'Rencontré(e) le {date}'
	String metAt({required Object date}) => 'Rencontré(e) le ${date}';

	/// fr: 'Notes'
	String get notes => 'Notes';

	/// fr: 'Ajouter la note'
	String get addNote => 'Ajouter la note';

	/// fr: 'Aucune note pour l'instant.'
	String get noNotes => 'Aucune note pour l\'instant.';

	/// fr: 'Supprimer la note'
	String get deleteNote => 'Supprimer la note';

	/// fr: 'Exporter (tableur)'
	String get export => 'Exporter (tableur)';

	late final Translations$souls$csv$fr csv = Translations$souls$csv$fr.internal(_root);

	/// fr: 'Verrouiller avec {method}'
	String lock({required Object method}) => 'Verrouiller avec ${method}';

	/// fr: 'Ton suivi des âmes est verrouillé'
	String get lockedTitle => 'Ton suivi des âmes est verrouillé';

	/// fr: 'Déverrouiller'
	String get unlock => 'Déverrouiller';

	/// fr: 'Ouvre ton suivi des âmes'
	String get unlockReason => 'Ouvre ton suivi des âmes';

	/// fr: 'Ces informations restent sur ton téléphone : elles ne sont jamais envoyées.'
	String get privacy => 'Ces informations restent sur ton téléphone : elles ne sont jamais envoyées.';

	/// fr: 'Suivi des âmes'
	String get reminderTitle => 'Suivi des âmes';

	/// fr: '(one) {{n} personne à recontacter aujourd'hui.} (other) {{n} personnes à recontacter aujourd'hui.}'
	String reminderBody({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
		one: '${n} personne à recontacter aujourd\'hui.',
		other: '${n} personnes à recontacter aujourd\'hui.',
	);

	/// fr: 'Suivi des âmes'
	String get reminderChannel => 'Suivi des âmes';

	/// fr: 'Les personnes que tu évangélises'
	String get moreSubtitle => 'Les personnes que tu évangélises';
}

// Path: onboarding.reports
class Translations$onboarding$reports$fr {
	Translations$onboarding$reports$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Ta marche avec Dieu, jour après jour'
	String get title => 'Ta marche avec Dieu, jour après jour';

	/// fr: 'Note en quelques secondes ta lecture biblique, ta prière, tes jeûnes… et vois ta progression semaine après semaine.'
	String get text => 'Note en quelques secondes ta lecture biblique, ta prière, tes jeûnes… et vois ta progression semaine après semaine.';
}

// Path: onboarding.worship
class Translations$onboarding$worship$fr {
	Translations$onboarding$worship$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Chante et prie, où que tu sois'
	String get title => 'Chante et prie, où que tu sois';

	/// fr: 'Retrouve les cantiques de la communauté et porte chaque jour les sujets de prière avec tes frères et sœurs.'
	String get text => 'Retrouve les cantiques de la communauté et porte chaque jour les sujets de prière avec tes frères et sœurs.';
}

// Path: onboarding.community
class Translations$onboarding$community$fr {
	Translations$onboarding$community$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Reste lié à ta communauté'
	String get title => 'Reste lié à ta communauté';

	/// fr: 'Les évènements et les annonces de ton assemblée, au même endroit, pour ne rien manquer.'
	String get text => 'Les évènements et les annonces de ton assemblée, au même endroit, pour ne rien manquer.';
}

// Path: onboarding.sample
class Translations$onboarding$sample$fr {
	Translations$onboarding$sample$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Aujourd'hui'
	String get today => 'Aujourd\'hui';

	/// fr: 'Lecture biblique'
	String get bibleReading => 'Lecture biblique';

	/// fr: 'Prière seule'
	String get prayerAlone => 'Prière seule';

	/// fr: 'Méditation'
	String get meditation => 'Méditation';

	/// fr: 'Prière en groupe'
	String get groupPrayer => 'Prière en groupe';

	/// fr: 'Cette semaine'
	String get thisWeek => 'Cette semaine';

	/// fr: '4 jours sur 5'
	String get weekScore => '4 jours sur 5';

	/// fr: 'Cantique'
	String get hymn => 'Cantique';

	/// fr: 'N° 12'
	String get hymnNumber => 'N° 12';

	/// fr: 'Plein écran'
	String get fullScreen => 'Plein écran';

	/// fr: 'Sujet de prière du jour'
	String get prayerOfTheDay => 'Sujet de prière du jour';

	/// fr: 'Pour les examens de nos jeunes'
	String get prayerTopic => 'Pour les examens de nos jeunes';

	/// fr: '12 personnes prient'
	String get praying => '12 personnes prient';

	/// fr: 'Je prie'
	String get iPray => 'Je prie';

	/// fr: 'Veillée de prière'
	String get vigil => 'Veillée de prière';

	/// fr: '20 h · Assemblée locale'
	String get vigilMeta => '20 h · Assemblée locale';

	/// fr: 'Je participe'
	String get join => 'Je participe';

	/// fr: 'Retraite des jeunes'
	String get retreat => 'Retraite des jeunes';

	/// fr: 'Toute la journée'
	String get retreatMeta => 'Toute la journée';

	/// fr: 'Annonce'
	String get announcement => 'Annonce';

	/// fr: 'Le culte de dimanche commence à 8 h 30.'
	String get announcementText => 'Le culte de dimanche commence à 8 h 30.';

	/// fr: '10 ch.'
	String get chapters => '10 ch.';
}

// Path: auth.login
class Translations$auth$login$fr {
	Translations$auth$login$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Content de te revoir'
	String get title => 'Content de te revoir';

	/// fr: 'Connecte-toi pour remplir ton compte rendu du jour.'
	String get subtitle => 'Connecte-toi pour remplir ton compte rendu du jour.';

	/// fr: 'Se connecter'
	String get submit => 'Se connecter';

	/// fr: 'Pas encore de compte ?'
	String get noAccount => 'Pas encore de compte ?';

	/// fr: 'Créer un compte'
	String get createAccount => 'Créer un compte';
}

// Path: auth.register
class Translations$auth$register$fr {
	Translations$auth$register$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: '{current} / {total}'
	String step({required Object current, required Object total}) => '${current} / ${total}';

	/// fr: 'Crée ton compte'
	String get title => 'Crée ton compte';

	/// fr: 'Ton numéro de téléphone te servira à te connecter.'
	String get subtitle => 'Ton numéro de téléphone te servira à te connecter.';

	/// fr: 'Prénom'
	String get firstName => 'Prénom';

	/// fr: 'Nom'
	String get lastName => 'Nom';

	/// fr: '6 caractères minimum'
	String get passwordHelp => '6 caractères minimum';

	/// fr: 'E-mail'
	String get email => 'E-mail';

	/// fr: 'Continuer'
	String get submit => 'Continuer';

	/// fr: 'Déjà un compte ?'
	String get haveAccount => 'Déjà un compte ?';

	/// fr: 'Se connecter'
	String get login => 'Se connecter';

	/// fr: 'Ce numéro ou cet e-mail a déjà un compte. Connecte-toi.'
	String get alreadyUsed => 'Ce numéro ou cet e-mail a déjà un compte. Connecte-toi.';

	/// fr: 'toi@exemple.com'
	String get emailHint => 'toi@exemple.com';
}

// Path: auth.church
class Translations$auth$church$fr {
	Translations$auth$church$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Ton église'
	String get title => 'Ton église';

	/// fr: 'Ces informations aident tes responsables à te retrouver. Tu pourras les modifier plus tard.'
	String get subtitle => 'Ces informations aident tes responsables à te retrouver. Tu pourras les modifier plus tard.';

	/// fr: 'Mon profil'
	String get editTitle => 'Mon profil';

	/// fr: 'Mets à jour ton nom, ton église et ton assemblée.'
	String get editSubtitle => 'Mets à jour ton nom, ton église et ton assemblée.';

	/// fr: 'Pays'
	String get country => 'Pays';

	/// fr: 'Choisis ton pays'
	String get countryHint => 'Choisis ton pays';

	/// fr: 'Ville'
	String get city => 'Ville';

	/// fr: 'Yaoundé'
	String get cityHint => 'Yaoundé';

	/// fr: 'Église'
	String get church => 'Église';

	/// fr: 'Nom de ton église'
	String get churchHint => 'Nom de ton église';

	/// fr: 'Assemblée'
	String get assembly => 'Assemblée';

	/// fr: 'Nom de ton assemblée'
	String get assemblyHint => 'Nom de ton assemblée';

	/// fr: 'Tu as déménagé ou changé d'assemblée ? Tu pourras tout mettre à jour depuis ton profil.'
	String get info => 'Tu as déménagé ou changé d\'assemblée ? Tu pourras tout mettre à jour depuis ton profil.';

	/// fr: 'Terminer'
	String get submit => 'Terminer';

	/// fr: 'Passer cette étape'
	String get skip => 'Passer cette étape';

	/// fr: 'Profil enregistré'
	String get saved => 'Profil enregistré';
}

// Path: auth.forgot
class Translations$auth$forgot$fr {
	Translations$auth$forgot$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Mot de passe oublié ?'
	String get link => 'Mot de passe oublié ?';

	/// fr: 'Mot de passe oublié'
	String get title => 'Mot de passe oublié';

	/// fr: 'Entre ton numéro : on t'envoie un code par SMS pour choisir un nouveau mot de passe.'
	String get phoneText => 'Entre ton numéro : on t\'envoie un code par SMS pour choisir un nouveau mot de passe.';

	/// fr: 'Recevoir le code'
	String get sendCode => 'Recevoir le code';

	/// fr: 'Entre le code'
	String get codeTitle => 'Entre le code';

	/// fr: 'Nous avons envoyé un code à 6 chiffres au {phone}.'
	String codeText({required Object phone}) => 'Nous avons envoyé un code à 6 chiffres au ${phone}.';

	/// fr: 'Code reçu par SMS'
	String get code => 'Code reçu par SMS';

	/// fr: 'Le code a 6 chiffres'
	String get codeInvalid => 'Le code a 6 chiffres';

	/// fr: 'Vérifier'
	String get verify => 'Vérifier';

	/// fr: 'Renvoyer le code'
	String get resend => 'Renvoyer le code';

	/// fr: 'Renvoyer le code dans {seconds} s'
	String resendIn({required Object seconds}) => 'Renvoyer le code dans ${seconds} s';

	/// fr: 'Changer de numéro'
	String get changeNumber => 'Changer de numéro';

	/// fr: 'Nouveau mot de passe'
	String get passwordTitle => 'Nouveau mot de passe';

	/// fr: 'Choisis un nouveau mot de passe pour ton compte.'
	String get passwordText => 'Choisis un nouveau mot de passe pour ton compte.';

	/// fr: 'Enregistrer et me connecter'
	String get submit => 'Enregistrer et me connecter';

	/// fr: 'Mot de passe changé. Content de te revoir !'
	String get done => 'Mot de passe changé. Content de te revoir !';

	/// fr: 'Tu t'en souviens ?'
	String get remembered => 'Tu t\'en souviens ?';

	/// fr: 'Ce code n'est pas le bon.'
	String get invalidCode => 'Ce code n\'est pas le bon.';

	/// fr: 'Le code a expiré. Demandes-en un nouveau.'
	String get expired => 'Le code a expiré. Demandes-en un nouveau.';

	/// fr: 'Trop de tentatives. Réessaie dans un moment.'
	String get tooManyRequests => 'Trop de tentatives. Réessaie dans un moment.';

	/// fr: 'La réinitialisation n'est pas disponible pour l'instant.'
	String get unavailable => 'La réinitialisation n\'est pas disponible pour l\'instant.';

	/// fr: 'Aucun compte n'utilise ce numéro.'
	String get noAccount => 'Aucun compte n\'utilise ce numéro.';
}

// Path: auth.biometric
class Translations$auth$biometric$fr {
	Translations$auth$biometric$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Face ID'
	String get faceId => 'Face ID';

	/// fr: 'Touch ID'
	String get touchId => 'Touch ID';

	/// fr: 'ton empreinte'
	String get fingerprint => 'ton empreinte';

	/// fr: 'ton visage'
	String get face => 'ton visage';

	/// fr: 'Se connecter avec {method}'
	String signIn({required Object method}) => 'Se connecter avec ${method}';

	/// fr: 'Te connecter avec {method} ?'
	String askTitle({required Object method}) => 'Te connecter avec ${method} ?';

	/// fr: 'La prochaine fois, plus besoin de taper ton mot de passe : il reste dans le coffre sécurisé de ton téléphone.'
	String get askText => 'La prochaine fois, plus besoin de taper ton mot de passe : il reste dans le coffre sécurisé de ton téléphone.';

	/// fr: 'Activer'
	String get enable => 'Activer';

	/// fr: 'Plus tard'
	String get later => 'Plus tard';

	/// fr: 'Connecte-toi à CMFI Connect'
	String get reason => 'Connecte-toi à CMFI Connect';

	/// fr: 'Active la connexion rapide à CMFI Connect'
	String get enableReason => 'Active la connexion rapide à CMFI Connect';

	/// fr: 'Ton mot de passe a changé : connecte-toi avec ton mot de passe, puis réactive {method}.'
	String changed({required Object method}) => 'Ton mot de passe a changé : connecte-toi avec ton mot de passe, puis réactive ${method}.';

	/// fr: 'Connexion avec {method}'
	String settings({required Object method}) => 'Connexion avec ${method}';

	/// fr: 'Sans taper ton mot de passe'
	String get settingsText => 'Sans taper ton mot de passe';

	/// fr: 'Ton mot de passe'
	String get passwordTitle => 'Ton mot de passe';

	/// fr: 'Mot de passe'
	String get passwordLabel => 'Mot de passe';

	/// fr: 'Valider'
	String get confirm => 'Valider';

	/// fr: 'Connexion avec {method} activée'
	String enabled({required Object method}) => 'Connexion avec ${method} activée';
}

// Path: reports.tabs
class Translations$reports$tabs$fr {
	Translations$reports$tabs$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Aujourd'hui'
	String get today => 'Aujourd\'hui';

	/// fr: 'Historique'
	String get history => 'Historique';

	/// fr: 'Bilan'
	String get summary => 'Bilan';
}

// Path: reports.measure
class Translations$reports$measure$fr {
	Translations$reports$measure$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: '{unit}'
	String quantity({required Object unit}) => '${unit}';

	/// fr: 'durée'
	String get duration => 'durée';

	/// fr: '{unit} et durée'
	String both({required Object unit}) => '${unit} et durée';

	/// fr: 'quantité'
	String get quantityNoUnit => 'quantité';

	/// fr: 'quantité et durée'
	String get bothNoUnit => 'quantité et durée';
}

// Path: reports.sheet
class Translations$reports$sheet$fr {
	Translations$reports$sheet$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Quantité'
	String get quantity => 'Quantité';

	/// fr: 'Durée'
	String get duration => 'Durée';

	/// fr: '− 1 min'
	String get minus1 => '− 1 min';

	/// fr: '+ 1 min'
	String get plus1 => '+ 1 min';

	/// fr: 'Retirer une minute'
	String get removeMinute => 'Retirer une minute';

	/// fr: 'Ajouter une minute'
	String get addMinute => 'Ajouter une minute';

	/// fr: 'Maintiens appuyé pour aller plus vite'
	String get holdToRepeat => 'Maintiens appuyé pour aller plus vite';

	/// fr: 'Diminuer'
	String get decrease => 'Diminuer';

	/// fr: 'Augmenter'
	String get increase => 'Augmenter';

	/// fr: 'Effacer'
	String get clear => 'Effacer';

	/// fr: 'Valider'
	String get validate => 'Valider';
}

// Path: reports.history
class Translations$reports$history$fr {
	Translations$reports$history$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: '{filled} jours remplis sur {total}'
	String daysFilled({required Object filled, required Object total}) => '${filled} jours remplis sur ${total}';

	/// fr: 'Rempli'
	String get legendFilled => 'Rempli';

	/// fr: 'Pas de compte rendu'
	String get legendMissing => 'Pas de compte rendu';

	/// fr: 'Aucun compte rendu'
	String get none => 'Aucun compte rendu';

	/// fr: 'Remplir'
	String get fill => 'Remplir';

	/// fr: 'En cours'
	String get inProgress => 'En cours';

	/// fr: 'Mois précédent'
	String get previousMonth => 'Mois précédent';

	/// fr: 'Mois suivant'
	String get nextMonth => 'Mois suivant';

	/// fr: 'aujourd'hui'
	String get today => 'aujourd\'hui';
}

// Path: reports.summary
class Translations$reports$summary$fr {
	Translations$reports$summary$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Semaine'
	String get week => 'Semaine';

	/// fr: 'Mois'
	String get month => 'Mois';

	/// fr: 'Année'
	String get year => 'Année';

	/// fr: 'Du {from} au {to}'
	String range({required Object from, required Object to}) => 'Du ${from} au ${to}';

	/// fr: 'Régularité'
	String get regularity => 'Régularité';

	/// fr: 'jours remplis'
	String get daysFilled => 'jours remplis';

	/// fr: '(one) {{n} jour sans compte rendu : le {days}} (other) {{n} jours sans compte rendu : les {days}}'
	String missingDays({required num n, required Object days}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
		one: '${n} jour sans compte rendu : le ${days}',
		other: '${n} jours sans compte rendu : les ${days}',
	);

	/// fr: '(one) {{n} jour sans compte rendu} (other) {{n} jours sans compte rendu}'
	String missingCount({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
		one: '${n} jour sans compte rendu',
		other: '${n} jours sans compte rendu',
	);

	/// fr: 'Aucun jour manqué, bravo !'
	String get noMissing => 'Aucun jour manqué, bravo !';

	/// fr: '{value} par jour rempli'
	String perDay({required Object value}) => '${value} par jour rempli';

	/// fr: '(one) {{n} jour} (other) {{n} jours}'
	String days({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
		one: '${n} jour',
		other: '${n} jours',
	);

	/// fr: 'Pas encore renseignés'
	String get notFilled => 'Pas encore renseignés';

	/// fr: 'Par jour · barre la plus haute : {max}'
	String barsCaption({required Object max}) => 'Par jour · barre la plus haute : ${max}';

	/// fr: 'Par mois · barre la plus haute : {max}'
	String barsCaptionMonthly({required Object max}) => 'Par mois · barre la plus haute : ${max}';

	/// fr: 'Aucun compte rendu sur cette période.'
	String get empty => 'Aucun compte rendu sur cette période.';

	/// fr: '(one) {Objectif atteint {n} jour sur {total}} (other) {Objectif atteint {n} jours sur {total}}'
	String goalDays({required num n, required Object total}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
		one: 'Objectif atteint ${n} jour sur ${total}',
		other: 'Objectif atteint ${n} jours sur ${total}',
	);

	/// fr: 'Partager ce bilan'
	String get share => 'Partager ce bilan';

	/// fr: 'Objectifs'
	String get goals => 'Objectifs';

	/// fr: 'Accomplissement moyen de tes objectifs'
	String get goalsAverage => 'Accomplissement moyen de tes objectifs';

	/// fr: 'Chaque jour compte, même vide. Aujourd'hui compte une fois rempli.'
	String get goalsHint => 'Chaque jour compte, même vide. Aujourd\'hui compte une fois rempli.';

	/// fr: 'Évolution de tes objectifs'
	String get evolution => 'Évolution de tes objectifs';

	/// fr: 'Semaine après semaine, sur les 12 dernières.'
	String get evolutionHint => 'Semaine après semaine, sur les 12 dernières.';

	/// fr: 'L'année et l'évolution de tes objectifs viennent avec Premium.'
	String get premiumYear => 'L\'année et l\'évolution de tes objectifs viennent avec Premium.';
}

// Path: reports.standardItems
class Translations$reports$standardItems$fr {
	Translations$reports$standardItems$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Lecture biblique'
	String get lb => 'Lecture biblique';

	/// fr: 'Prière seule'
	String get ps => 'Prière seule';

	/// fr: 'Méditation'
	String get rdqad => 'Méditation';

	/// fr: 'Prière en groupe'
	String get pg => 'Prière en groupe';

	/// fr: 'Lecture de la littérature chrétienne'
	String get llc => 'Lecture de la littérature chrétienne';

	/// fr: 'Jeûne complet'
	String get jc => 'Jeûne complet';

	/// fr: 'Jeûne partiel'
	String get jp => 'Jeûne partiel';

	/// fr: 'Dîmes'
	String get dimes => 'Dîmes';

	/// fr: 'Offrandes'
	String get off => 'Offrandes';
}

// Path: reports.units
class Translations$reports$units$fr {
	Translations$reports$units$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final Translations$reports$units$chapters$fr chapters = Translations$reports$units$chapters$fr.internal(_root);
	late final Translations$reports$units$times$fr times = Translations$reports$units$times$fr.internal(_root);
	late final Translations$reports$units$pages$fr pages = Translations$reports$units$pages$fr.internal(_root);
	late final Translations$reports$units$percent$fr percent = Translations$reports$units$percent$fr.internal(_root);
}

// Path: export.doc
class Translations$export$doc$fr {
	Translations$export$doc$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Compte rendu'
	String get title => 'Compte rendu';

	/// fr: 'Régularité'
	String get regularity => 'Régularité';

	/// fr: '(one) {{filled} jour rempli sur {total}} (other) {{filled} jours remplis sur {total}}'
	String daysFilled({required num filled, required Object total}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(filled,
		one: '${filled} jour rempli sur ${total}',
		other: '${filled} jours remplis sur ${total}',
	);

	/// fr: 'Sur la période'
	String get totals => 'Sur la période';

	/// fr: 'Élément'
	String get item => 'Élément';

	/// fr: 'Total'
	String get total => 'Total';

	/// fr: 'Jours'
	String get days => 'Jours';

	/// fr: 'Moyenne / jour rempli'
	String get average => 'Moyenne / jour rempli';

	/// fr: 'Objectif atteint'
	String get goal => 'Objectif atteint';

	/// fr: 'Jour par jour'
	String get detail => 'Jour par jour';

	/// fr: 'Date'
	String get date => 'Date';

	/// fr: 'Rempli'
	String get values => 'Rempli';

	/// fr: 'Note'
	String get note => 'Note';

	/// fr: 'Pas de compte rendu'
	String get noReport => 'Pas de compte rendu';

	/// fr: 'Généré le {date} avec CMFI Connect'
	String generated({required Object date}) => 'Généré le ${date} avec CMFI Connect';

	/// fr: 'Page {n} / {total}'
	String page({required Object n, required Object total}) => 'Page ${n} / ${total}';

	/// fr: 'Compte rendu'
	String get filledColumn => 'Compte rendu';

	/// fr: 'oui'
	String get yes => 'oui';

	/// fr: 'non'
	String get no => 'non';

	/// fr: 'Envoyé depuis CMFI Connect'
	String get sentFrom => 'Envoyé depuis CMFI Connect';
}

// Path: items.measure
class Translations$items$measure$fr {
	Translations$items$measure$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Quantité · {unit}'
	String quantity({required Object unit}) => 'Quantité · ${unit}';

	/// fr: 'Quantité'
	String get quantityNoUnit => 'Quantité';

	/// fr: 'Durée'
	String get duration => 'Durée';

	/// fr: 'Quantité ({unit}) et durée'
	String both({required Object unit}) => 'Quantité (${unit}) et durée';

	/// fr: 'Quantité et durée'
	String get bothNoUnit => 'Quantité et durée';
}

// Path: authorities.form
class Translations$authorities$form$fr {
	Translations$authorities$form$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Nouvelle autorité'
	String get title => 'Nouvelle autorité';

	/// fr: 'nom@exemple.com'
	String get emailHint => 'nom@exemple.com';

	/// fr: 'C'est mon faiseur de disciples'
	String get isDiscipleMaker => 'C\'est mon faiseur de disciples';

	/// fr: 'La personne qui t'accompagne personnellement. Tu n'en as qu'un.'
	String get isDiscipleMakerHelp => 'La personne qui t\'accompagne personnellement. Tu n\'en as qu\'un.';

	/// fr: '{name} est déjà ton faiseur de disciples. Retire-le de la liste pour en désigner un autre.'
	String discipleMakerTaken({required Object name}) => '${name} est déjà ton faiseur de disciples. Retire-le de la liste pour en désigner un autre.';

	/// fr: 'Ajouter'
	String get submit => 'Ajouter';

	/// fr: '{name} fait maintenant partie de tes autorités.'
	String added({required Object name}) => '${name} fait maintenant partie de tes autorités.';

	/// fr: 'Son pseudo'
	String get searchLabel => 'Son pseudo';

	/// fr: 'pseudo'
	String get searchHint => 'pseudo';

	/// fr: 'Rechercher'
	String get search => 'Rechercher';

	/// fr: 'Si la personne utilise CMFI Connect, cherche-la par son pseudo. Elle recevra ta demande, et ses coordonnées s'afficheront quand elle l'aura acceptée.'
	String get searchHelp => 'Si la personne utilise CMFI Connect, cherche-la par son pseudo. Elle recevra ta demande, et ses coordonnées s\'afficheront quand elle l\'aura acceptée.';

	/// fr: 'Personne n'a le pseudo @{username}.'
	String notFound({required Object username}) => 'Personne n\'a le pseudo @${username}.';

	/// fr: 'L'inviter à rejoindre CMFI Connect'
	String get invite => 'L\'inviter à rejoindre CMFI Connect';

	/// fr: 'Bonjour ! J'utilise CMFI Connect pour noter ma marche avec Dieu, et j'aimerais que tu m'accompagnes. Installe l'application, crée ton compte, puis envoie-moi ton pseudo pour que je t'ajoute.'
	String get inviteText => 'Bonjour ! J\'utilise CMFI Connect pour noter ma marche avec Dieu, et j\'aimerais que tu m\'accompagnes. Installe l\'application, crée ton compte, puis envoie-moi ton pseudo pour que je t\'ajoute.';

	/// fr: 'Mon pseudo : @{username}'
	String inviteMine({required Object username}) => 'Mon pseudo : @${username}';

	/// fr: 'Elle n'a pas l'application ? Saisir ses coordonnées'
	String get manual => 'Elle n\'a pas l\'application ? Saisir ses coordonnées';

	/// fr: 'Chercher plutôt par pseudo'
	String get backToSearch => 'Chercher plutôt par pseudo';

	/// fr: 'Envoyer la demande'
	String get request => 'Envoyer la demande';

	/// fr: 'Demande envoyée à {name}.'
	String requested({required Object name}) => 'Demande envoyée à ${name}.';

	/// fr: 'Cette personne fait déjà partie de tes autorités.'
	String get alreadyAdded => 'Cette personne fait déjà partie de tes autorités.';

	/// fr: 'Tu as déjà un faiseur de disciples.'
	String get makerExists => 'Tu as déjà un faiseur de disciples.';

	/// fr: 'C'est ton propre pseudo.'
	String get yourself => 'C\'est ton propre pseudo.';

	/// fr: '{name} verra tes comptes rendus : les éléments remplis, ta régularité et tes pourcentages, jamais ta note. Tu peux l'arrêter sur sa fiche.'
	String sharingHelp({required Object name}) => '${name} verra tes comptes rendus : les éléments remplis, ta régularité et tes pourcentages, jamais ta note. Tu peux l\'arrêter sur sa fiche.';
}

// Path: authorities.sharing
class Translations$authorities$sharing$fr {
	Translations$authorities$sharing$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Partager mes comptes rendus'
	String get title => 'Partager mes comptes rendus';

	/// fr: '{name} voit tes comptes rendus : les éléments remplis, ta régularité et tes pourcentages, jamais ta note.'
	String help({required Object name}) => '${name} voit tes comptes rendus : les éléments remplis, ta régularité et tes pourcentages, jamais ta note.';

	/// fr: 'Tes comptes rendus sont partagés avec {name}.'
	String on({required Object name}) => 'Tes comptes rendus sont partagés avec ${name}.';

	/// fr: '{name} ne voit plus tes comptes rendus.'
	String off({required Object name}) => '${name} ne voit plus tes comptes rendus.';
}

// Path: members.deleteAccount
class Translations$members$deleteAccount$fr {
	Translations$members$deleteAccount$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Supprimer mon compte'
	String get button => 'Supprimer mon compte';

	/// fr: 'Supprimer mon compte'
	String get title => 'Supprimer mon compte';

	/// fr: 'C'est définitif. Ton compte et tout ce qui y est lié seront effacés :'
	String get intro => 'C\'est définitif. Ton compte et tout ce qui y est lié seront effacés :';

	/// fr: 'ton profil, ta photo, ton pseudo et ton mot de passe'
	String get itemProfile => 'ton profil, ta photo, ton pseudo et ton mot de passe';

	/// fr: 'tous tes comptes rendus, tes éléments et tes objectifs'
	String get itemReports => 'tous tes comptes rendus, tes éléments et tes objectifs';

	/// fr: 'tes autorités spirituelles et les demandes reçues'
	String get itemAuthorities => 'tes autorités spirituelles et les demandes reçues';

	/// fr: 'tes inscriptions aux évènements'
	String get itemEvents => 'tes inscriptions aux évènements';

	/// fr: 'tes listes de prière, tes retraites et tes sujets d'importunité'
	String get itemPrayer => 'tes listes de prière, tes retraites et tes sujets d\'importunité';

	/// fr: 'Les évènements, actualités, photos et sujets de prière que tu as publiés comme admin restent pour la communauté, sans ton nom.'
	String get kept => 'Les évènements, actualités, photos et sujets de prière que tu as publiés comme admin restent pour la communauté, sans ton nom.';

	/// fr: 'Pour confirmer que c'est bien toi.'
	String get passwordHelp => 'Pour confirmer que c\'est bien toi.';

	/// fr: 'Supprimer définitivement'
	String get confirm => 'Supprimer définitivement';

	/// fr: 'Ton compte a été supprimé. Que Dieu te bénisse !'
	String get done => 'Ton compte a été supprimé. Que Dieu te bénisse !';

	/// fr: 'Mot de passe incorrect.'
	String get wrongPassword => 'Mot de passe incorrect.';

	/// fr: 'Tu es le seul superadmin : donne ce rôle à quelqu'un d'autre avant de supprimer ton compte.'
	String get lastSuperadmin => 'Tu es le seul superadmin : donne ce rôle à quelqu\'un d\'autre avant de supprimer ton compte.';
}

// Path: hymns.tabs
class Translations$hymns$tabs$fr {
	Translations$hymns$tabs$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Tous'
	String get all => 'Tous';

	/// fr: 'Favoris'
	String get favorites => 'Favoris';

	/// fr: 'Récents'
	String get recent => 'Récents';
}

// Path: hymns.reader
class Translations$hymns$reader$fr {
	Translations$hymns$reader$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Réduire le texte'
	String get smaller => 'Réduire le texte';

	/// fr: 'Agrandir le texte'
	String get larger => 'Agrandir le texte';

	/// fr: 'Affichage'
	String get display => 'Affichage';

	/// fr: 'Taille du texte'
	String get textSize => 'Taille du texte';

	/// fr: 'Police'
	String get typeface => 'Police';

	/// fr: 'Auto'
	String get typefaceAuto => 'Auto';

	/// fr: 'Moderne'
	String get typefaceSans => 'Moderne';

	/// fr: 'Classique'
	String get typefaceSerif => 'Classique';

	/// fr: 'Classique quand le texte est grand'
	String get typefaceAutoHelp => 'Classique quand le texte est grand';

	/// fr: 'Fond'
	String get background => 'Fond';

	/// fr: 'Auto'
	String get themeAuto => 'Auto';

	/// fr: 'Clair'
	String get themeLight => 'Clair';

	/// fr: 'Sépia'
	String get themeSepia => 'Sépia';

	/// fr: 'Sombre'
	String get themeDark => 'Sombre';

	/// fr: 'Répéter le refrain après chaque couplet'
	String get repeatChorus => 'Répéter le refrain après chaque couplet';

	/// fr: 'Garder l'écran allumé'
	String get keepScreenOn => 'Garder l\'écran allumé';

	/// fr: 'Ajouter aux favoris'
	String get addFavorite => 'Ajouter aux favoris';

	/// fr: 'Retirer des favoris'
	String get removeFavorite => 'Retirer des favoris';

	/// fr: 'Ajouté aux favoris'
	String get favoriteAdded => 'Ajouté aux favoris';

	/// fr: 'Retiré des favoris'
	String get favoriteRemoved => 'Retiré des favoris';

	/// fr: 'Plus d'options'
	String get more => 'Plus d\'options';

	/// fr: 'Copier les paroles'
	String get copy => 'Copier les paroles';

	/// fr: 'Paroles copiées'
	String get copied => 'Paroles copiées';

	/// fr: 'Mode projection'
	String get project => 'Mode projection';

	/// fr: 'Pince l'écran pour agrandir ou réduire le texte.'
	String get pinchHint => 'Pince l\'écran pour agrandir ou réduire le texte.';

	/// fr: 'Ce cantique n'existe plus dans le recueil.'
	String get notFound => 'Ce cantique n\'existe plus dans le recueil.';

	/// fr: 'Partager les paroles'
	String get share => 'Partager les paroles';
}

// Path: hymns.projection
class Translations$hymns$projection$fr {
	Translations$hymns$projection$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Quitter le mode projection'
	String get exit => 'Quitter le mode projection';

	/// fr: 'Strophe précédente'
	String get previous => 'Strophe précédente';

	/// fr: 'Strophe suivante'
	String get next => 'Strophe suivante';

	/// fr: '{current} / {total}'
	String position({required Object current, required Object total}) => '${current} / ${total}';

	/// fr: 'Touche à droite pour avancer, à gauche pour revenir.'
	String get hint => 'Touche à droite pour avancer, à gauche pour revenir.';
}

// Path: hymns.pad
class Translations$hymns$pad$fr {
	Translations$hymns$pad$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Aller au cantique'
	String get title => 'Aller au cantique';

	/// fr: 'Ouvrir'
	String get open => 'Ouvrir';

	/// fr: 'Effacer'
	String get erase => 'Effacer';

	/// fr: 'Pas de cantique n° {number} dans ce recueil'
	String notFound({required Object number}) => 'Pas de cantique n° ${number} dans ce recueil';

	/// fr: 'Tape un numéro'
	String get placeholder => 'Tape un numéro';
}

// Path: events.tabs
class Translations$events$tabs$fr {
	Translations$events$tabs$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Programme'
	String get program => 'Programme';

	/// fr: 'Actualités'
	String get news => 'Actualités';

	/// fr: 'Infos'
	String get info => 'Infos';

	/// fr: 'Photos'
	String get photos => 'Photos';
}

// Path: events.register
class Translations$events$register$fr {
	Translations$events$register$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Je participe'
	String get cta => 'Je participe';

	/// fr: 'Je participe'
	String get title => 'Je participe';

	/// fr: 'Combien serez-vous ?'
	String get people => 'Combien serez-vous ?';

	/// fr: 'Toi compris, avec ta famille ou ton groupe.'
	String get peopleHint => 'Toi compris, avec ta famille ou ton groupe.';

	/// fr: 'Une personne de moins'
	String get less => 'Une personne de moins';

	/// fr: 'Une personne de plus'
	String get more => 'Une personne de plus';

	/// fr: 'J'ai besoin d'un hébergement'
	String get lodging => 'J\'ai besoin d\'un hébergement';

	/// fr: 'Les organisateurs prévoient les places.'
	String get lodgingHint => 'Les organisateurs prévoient les places.';

	/// fr: 'Ville de départ'
	String get departure => 'Ville de départ';

	/// fr: 'Ex. Douala'
	String get departureHint => 'Ex. Douala';

	/// fr: 'Confirmer mon inscription'
	String get confirm => 'Confirmer mon inscription';

	/// fr: 'Mettre à jour'
	String get update => 'Mettre à jour';

	/// fr: 'Annuler mon inscription'
	String get cancel => 'Annuler mon inscription';

	/// fr: 'C'est noté, tu es inscrit ! On te le rappellera la veille.'
	String get done => 'C\'est noté, tu es inscrit ! On te le rappellera la veille.';

	/// fr: 'Ton inscription est à jour.'
	String get updated => 'Ton inscription est à jour.';

	/// fr: 'Ton inscription est annulée.'
	String get cancelled => 'Ton inscription est annulée.';

	/// fr: 'Modifier'
	String get edit => 'Modifier';

	/// fr: 'Tu es inscrit'
	String get youAre => 'Tu es inscrit';

	/// fr: 'Annuler ton inscription ?'
	String get cancelTitle => 'Annuler ton inscription ?';

	/// fr: 'Ta place sera libérée pour quelqu'un d'autre.'
	String get cancelText => 'Ta place sera libérée pour quelqu\'un d\'autre.';

	/// fr: 'Garder ma place'
	String get keep => 'Garder ma place';

	/// fr: 'hébergement'
	String get lodgingShort => 'hébergement';
}

// Path: events.reminder
class Translations$events$reminder$fr {
	Translations$events$reminder$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Rappels des évènements'
	String get channel => 'Rappels des évènements';

	/// fr: 'Demain : {title}'
	String tomorrow({required Object title}) => 'Demain : ${title}';

	/// fr: 'Dans 1 h : {title}'
	String soon({required Object title}) => 'Dans 1 h : ${title}';
}

// Path: events.admin
class Translations$events$admin$fr {
	Translations$events$admin$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Gérer les évènements'
	String get title => 'Gérer les évènements';

	/// fr: 'Créer un évènement'
	String get create => 'Créer un évènement';

	/// fr: 'Modifier l'évènement'
	String get edit => 'Modifier l\'évènement';

	/// fr: 'Aucun évènement pour l'instant. Crée le premier !'
	String get empty => 'Aucun évènement pour l\'instant. Crée le premier !';

	/// fr: 'Affiche'
	String get poster => 'Affiche';

	/// fr: 'Choisir une affiche'
	String get posterAdd => 'Choisir une affiche';

	/// fr: 'Changer l'affiche'
	String get posterChange => 'Changer l\'affiche';

	/// fr: 'Retirer l'affiche'
	String get posterRemove => 'Retirer l\'affiche';

	/// fr: 'Format portrait 4:5 conseillé (1080 × 1350), JPEG ou PNG.'
	String get posterHint => 'Format portrait 4:5 conseillé (1080 × 1350), JPEG ou PNG.';

	/// fr: 'Envoi de l'image…'
	String get uploading => 'Envoi de l\'image…';

	/// fr: 'L'évènement'
	String get general => 'L\'évènement';

	/// fr: 'Titre'
	String get titleField => 'Titre';

	/// fr: 'Ex. Conférence annuelle 2026'
	String get titleHint => 'Ex. Conférence annuelle 2026';

	/// fr: 'Donne un titre à l'évènement.'
	String get titleRequired => 'Donne un titre à l\'évènement.';

	/// fr: 'Thème'
	String get theme => 'Thème';

	/// fr: 'Ex. Marcher dans l'Esprit'
	String get themeHint => 'Ex. Marcher dans l\'Esprit';

	/// fr: 'Verset du thème'
	String get verse => 'Verset du thème';

	/// fr: 'Présentation'
	String get description => 'Présentation';

	/// fr: 'Dates'
	String get when => 'Dates';

	/// fr: 'Début'
	String get starts => 'Début';

	/// fr: 'Fin'
	String get ends => 'Fin';

	/// fr: 'La fin doit venir après le début.'
	String get endsBeforeStart => 'La fin doit venir après le début.';

	/// fr: 'Heures du lieu ({zone}).'
	String timeZone({required Object zone}) => 'Heures du lieu (${zone}).';

	/// fr: 'Lieu'
	String get where => 'Lieu';

	/// fr: 'Lieu'
	String get venue => 'Lieu';

	/// fr: 'Ex. Centre de conférences de Mvolyé'
	String get venueHint => 'Ex. Centre de conférences de Mvolyé';

	/// fr: 'Adresse'
	String get address => 'Adresse';

	/// fr: 'Ville'
	String get city => 'Ville';

	/// fr: 'Pays'
	String get country => 'Pays';

	/// fr: 'Lien Google Maps'
	String get mapsUrl => 'Lien Google Maps';

	/// fr: 'Inscriptions'
	String get registration => 'Inscriptions';

	/// fr: 'Inscriptions ouvertes'
	String get registrationOpen => 'Inscriptions ouvertes';

	/// fr: 'Date limite'
	String get deadline => 'Date limite';

	/// fr: 'Pas de date limite'
	String get noDeadline => 'Pas de date limite';

	/// fr: 'Nombre de places'
	String get capacity => 'Nombre de places';

	/// fr: 'Vide : sans limite'
	String get capacityHint => 'Vide : sans limite';

	/// fr: 'Demander qui a besoin d'un hébergement'
	String get asksLodging => 'Demander qui a besoin d\'un hébergement';

	/// fr: 'Demander la ville de départ'
	String get asksDeparture => 'Demander la ville de départ';

	/// fr: 'Participation'
	String get fees => 'Participation';

	/// fr: 'Ex. Entrée libre. Repas : 2 000 FCFA par jour.'
	String get feesHint => 'Ex. Entrée libre. Repas : 2 000 FCFA par jour.';

	/// fr: 'Contact'
	String get contact => 'Contact';

	/// fr: 'Nom du contact'
	String get contactName => 'Nom du contact';

	/// fr: 'Téléphone du contact'
	String get contactPhone => 'Téléphone du contact';

	/// fr: 'Visibilité'
	String get visibility => 'Visibilité';

	/// fr: 'Brouillon'
	String get statusDraft => 'Brouillon';

	/// fr: 'Visible seulement des admins'
	String get statusDraftHint => 'Visible seulement des admins';

	/// fr: 'Publié'
	String get statusPublished => 'Publié';

	/// fr: 'Visible de toute la communauté'
	String get statusPublishedHint => 'Visible de toute la communauté';

	/// fr: 'Annulé'
	String get statusCancelled => 'Annulé';

	/// fr: 'Affiché comme annulé, sans inscription'
	String get statusCancelledHint => 'Affiché comme annulé, sans inscription';

	/// fr: 'Évènement enregistré.'
	String get saved => 'Évènement enregistré.';

	/// fr: 'Gérer'
	String get menu => 'Gérer';

	/// fr: 'Programme'
	String get program => 'Programme';

	/// fr: 'Inscrits'
	String get registrants => 'Inscrits';

	/// fr: 'Publier une actualité'
	String get post => 'Publier une actualité';

	/// fr: 'Ajouter des photos'
	String get photos => 'Ajouter des photos';

	/// fr: 'Préparer l'édition suivante'
	String get nextEdition => 'Préparer l\'édition suivante';

	/// fr: 'Supprimer l'évènement'
	String get delete => 'Supprimer l\'évènement';

	/// fr: 'Supprimer cet évènement ?'
	String get deleteTitle => 'Supprimer cet évènement ?';

	/// fr: 'Les inscriptions, les actualités et les photos seront supprimées aussi.'
	String get deleteText => 'Les inscriptions, les actualités et les photos seront supprimées aussi.';

	/// fr: 'Supprimer'
	String get deleteConfirm => 'Supprimer';

	/// fr: 'Évènement supprimé.'
	String get deleted => 'Évènement supprimé.';

	/// fr: 'Préparer l'édition suivante ?'
	String get nextEditionTitle => 'Préparer l\'édition suivante ?';

	/// fr: 'Un brouillon est créé un an plus tard, avec le même lieu et le même programme. Tu pourras tout ajuster avant de le publier.'
	String get nextEditionText => 'Un brouillon est créé un an plus tard, avec le même lieu et le même programme. Tu pourras tout ajuster avant de le publier.';

	/// fr: 'Préparer'
	String get nextEditionConfirm => 'Préparer';

	/// fr: 'L'édition suivante est prête en brouillon.'
	String get nextEditionDone => 'L\'édition suivante est prête en brouillon.';

	/// fr: 'Ajoute les moments de l'évènement : accueil, cultes, enseignements, veillée…'
	String get programEmpty => 'Ajoute les moments de l\'évènement : accueil, cultes, enseignements, veillée…';

	/// fr: 'Ajouter un moment'
	String get addSession => 'Ajouter un moment';

	/// fr: 'Modifier ce moment'
	String get editSession => 'Modifier ce moment';

	/// fr: 'Titre'
	String get sessionTitle => 'Titre';

	/// fr: 'Ex. Culte d'ouverture'
	String get sessionTitleHint => 'Ex. Culte d\'ouverture';

	/// fr: 'Orateur'
	String get speaker => 'Orateur';

	/// fr: 'Salle'
	String get place => 'Salle';

	/// fr: 'Jour'
	String get day => 'Jour';

	/// fr: 'De'
	String get from => 'De';

	/// fr: 'À'
	String get to => 'À';

	/// fr: 'Cantiques'
	String get hymns => 'Cantiques';

	/// fr: 'Numéros, ex. 12, 45'
	String get hymnsHint => 'Numéros, ex. 12, 45';

	/// fr: 'Retirer'
	String get removeSession => 'Retirer';

	/// fr: 'Enregistrer le programme'
	String get saveProgram => 'Enregistrer le programme';

	/// fr: 'Programme enregistré.'
	String get programSaved => 'Programme enregistré.';

	/// fr: 'Personne n'est encore inscrit.'
	String get registrantsEmpty => 'Personne n\'est encore inscrit.';

	/// fr: 'Inscriptions'
	String get totalRegistrations => 'Inscriptions';

	/// fr: 'Personnes'
	String get totalPeople => 'Personnes';

	/// fr: 'À loger'
	String get totalLodging => 'À loger';

	/// fr: 'Par ville de départ'
	String get byCity => 'Par ville de départ';

	/// fr: 'Liste'
	String get list => 'Liste';

	/// fr: 'Exporter la liste (CSV)'
	String get exportCsv => 'Exporter la liste (CSV)';

	/// fr: 'Nom;Pseudo;Téléphone;Église;Assemblée;Personnes;Hébergement;Ville de départ;Inscrit le'
	String get csvHeader => 'Nom;Pseudo;Téléphone;Église;Assemblée;Personnes;Hébergement;Ville de départ;Inscrit le';

	/// fr: 'oui'
	String get yes => 'oui';

	/// fr: 'non'
	String get no => 'non';

	/// fr: 'Message'
	String get postBody => 'Message';

	/// fr: 'Ex. Les inscriptions sont ouvertes !'
	String get postBodyHint => 'Ex. Les inscriptions sont ouvertes !';

	/// fr: 'Ajouter une image'
	String get postImage => 'Ajouter une image';

	/// fr: 'Épingler en haut'
	String get postPinned => 'Épingler en haut';

	/// fr: 'Publier'
	String get postSend => 'Publier';

	/// fr: 'Actualité publiée.'
	String get postDone => 'Actualité publiée.';

	/// fr: 'Supprimer cette actualité'
	String get postDelete => 'Supprimer cette actualité';

	/// fr: 'Actualité supprimée.'
	String get postDeleted => 'Actualité supprimée.';

	/// fr: '(one) {{n} photo ajoutée.} (other) {{n} photos ajoutées.}'
	String photosAdded({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
		one: '${n} photo ajoutée.',
		other: '${n} photos ajoutées.',
	);

	/// fr: 'Envoi des photos ({done}/{total})…'
	String photosSending({required Object done, required Object total}) => 'Envoi des photos (${done}/${total})…';

	/// fr: 'Supprimer cette photo'
	String get photoDelete => 'Supprimer cette photo';

	/// fr: 'Photo supprimée.'
	String get photoDeleted => 'Photo supprimée.';

	/// fr: 'Supprimer'
	String get confirmDelete => 'Supprimer';
}

// Path: ministry.goals
class Translations$ministry$goals$fr {
	Translations$ministry$goals$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final Translations$ministry$goals$crusade$fr crusade = Translations$ministry$goals$crusade$fr.internal(_root);
	late final Translations$ministry$goals$disciples$fr disciples = Translations$ministry$goals$disciples$fr.internal(_root);
	late final Translations$ministry$goals$revival$fr revival = Translations$ministry$goals$revival$fr.internal(_root);
}

// Path: ministry.lives
class Translations$ministry$lives$fr {
	Translations$ministry$lives$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final Translations$ministry$lives$founder$fr founder = Translations$ministry$lives$founder$fr.internal(_root);
	late final Translations$ministry$lives$leader$fr leader = Translations$ministry$lives$leader$fr.internal(_root);
}

// Path: prayer.hero
class Translations$prayer$hero$fr {
	Translations$prayer$hero$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: '{retreat} · maintenant'
	String now({required Object retreat}) => '${retreat} · maintenant';

	/// fr: '15 minutes avec le Seigneur'
	String get title => '15 minutes\navec le Seigneur';

	Map<String, String> get preview => {
		'morning': 'Rends grâce, consacre ta journée, ton travail, ta famille…',
		'noon': 'Ton assemblée, tes dirigeants, 5 personnes de ta liste, les nations…',
		'evening': 'Ta vie de prière, ton ministère, tes co-ouvriers…',
		'night': 'Les malades, l\'Évangile dans les nations, la protection de la nuit…',
	};

	/// fr: '15 points · 1 min chacun'
	String get meta => '15 points · 1 min chacun';

	/// fr: 'Commencer'
	String get start => 'Commencer';

	/// fr: 'Les 4 retraites du jour sont faites. Que Dieu exauce !'
	String get allDone => 'Les 4 retraites du jour sont faites. Que Dieu exauce !';

	/// fr: '{retreat} faite. Prochaine : {next}'
	String doneNow({required Object retreat, required Object next}) => '${retreat} faite. Prochaine : ${next}';
}

// Path: prayer.today
class Translations$prayer$today$fr {
	Translations$prayer$today$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'À prier'
	String get toPray => 'À prier';

	/// fr: '(zero) {Aucune retraite cette semaine} (one) {{n} retraite cette semaine} (other) {{n} retraites cette semaine}'
	String week({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
		zero: 'Aucune retraite cette semaine',
		one: '${n} retraite cette semaine',
		other: '${n} retraites cette semaine',
	);
}

// Path: prayer.routine
class Translations$prayer$routine$fr {
	Translations$prayer$routine$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Ta routine du jour'
	String get title => 'Ta routine du jour';

	/// fr: '{done} sur 4'
	String count({required Object done}) => '${done} sur 4';

	/// fr: '(one) {{n} jour sur 7} (other) {{n} jours sur 7}'
	String days({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
		one: '${n} jour sur 7',
		other: '${n} jours sur 7',
	);

	/// fr: '{time} cette semaine'
	String week({required Object time}) => '${time} cette semaine';

	/// fr: 'Faite · 15 min'
	String get done => 'Faite · 15 min';

	/// fr: 'Maintenant · 15 min'
	String get now => 'Maintenant · 15 min';

	/// fr: 'À suivre · 15 min'
	String get next => 'À suivre · 15 min';

	/// fr: 'Rappel à {time}'
	String reminder({required Object time}) => 'Rappel à ${time}';

	Map<String, String> get later => {
		'morning': 'Le matin · 15 min',
		'noon': 'À midi · 15 min',
		'evening': 'En soirée · 15 min',
		'night': 'La nuit · 15 min',
	};
}

// Path: prayer.reminders
class Translations$prayer$reminders$fr {
	Translations$prayer$reminders$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Rappels des retraites'
	String get title => 'Rappels des retraites';

	/// fr: 'Un rappel à l'heure de chaque retraite, seulement si elle n'est pas encore faite.'
	String get intro => 'Un rappel à l\'heure de chaque retraite, seulement si elle n\'est pas encore faite.';

	/// fr: 'Désactivé'
	String get off => 'Désactivé';

	/// fr: 'Retraites de prière'
	String get channel => 'Retraites de prière';

	/// fr: '15 minutes avec le Seigneur.'
	String get body => '15 minutes avec le Seigneur.';
}

// Path: prayer.retreat
class Translations$prayer$retreat$fr {
	Translations$prayer$retreat$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Retraites de 15 minutes'
	String get title => 'Retraites de 15 minutes';

	Map<String, String> get hours => {
		'morning': 'Au réveil',
		'noon': 'Entre 12 h et 14 h',
		'evening': 'En fin d\'après-midi',
		'night': 'Avant de dormir',
	};

	/// fr: 'rappel à {time}'
	String reminderAt({required Object time}) => 'rappel à ${time}';

	/// fr: '15 points, une minute chacun. Un son doux te fait passer au suivant.'
	String get intro => '15 points, une minute chacun. Un son doux te fait passer au suivant.';

	/// fr: 'Faite aujourd'hui'
	String get done => 'Faite aujourd\'hui';

	/// fr: 'Commencer · 15 min'
	String get start => 'Commencer · 15 min';

	/// fr: 'Lire à mon rythme, sans minuteur'
	String get selfPaced => 'Lire à mon rythme, sans minuteur';

	late final Translations$prayer$retreat$hints$fr hints = Translations$prayer$retreat$hints$fr.internal(_root);
}

// Path: prayer.session
class Translations$prayer$session$fr {
	Translations$prayer$session$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Point {n} sur 15'
	String point({required Object n}) => 'Point ${n} sur 15';

	/// fr: 'restantes'
	String get remaining => 'restantes';

	/// fr: 'en pause'
	String get paused => 'en pause';

	/// fr: 'Dans ta liste · {list}'
	String inYourList({required Object list}) => 'Dans ta liste · ${list}';

	/// fr: 'Demain, les suivants.'
	String get tomorrow => 'Demain, les suivants.';

	/// fr: 'Écran allumé · un son doux à chaque minute'
	String get footer => 'Écran allumé · un son doux à chaque minute';

	/// fr: 'Point précédent'
	String get previous => 'Point précédent';

	/// fr: 'Point suivant'
	String get next => 'Point suivant';

	/// fr: 'Pause'
	String get pause => 'Pause';

	/// fr: 'Reprendre'
	String get resume => 'Reprendre';

	/// fr: 'Son activé'
	String get soundOn => 'Son activé';

	/// fr: 'Son coupé'
	String get soundOff => 'Son coupé';

	/// fr: 'Terminer la retraite'
	String get finish => 'Terminer la retraite';

	/// fr: 'Arrêter la retraite ?'
	String get quitTitle => 'Arrêter la retraite ?';

	/// fr: 'Elle ne sera pas comptée dans ta journée.'
	String get quitText => 'Elle ne sera pas comptée dans ta journée.';

	/// fr: 'Arrêter'
	String get quit => 'Arrêter';

	/// fr: 'Continuer'
	String get keepPraying => 'Continuer';
}

// Path: prayer.done
class Translations$prayer$done$fr {
	Translations$prayer$done$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: '{retreat} terminée'
	String title({required Object retreat}) => '${retreat} terminée';

	/// fr: '15 minutes avec le Seigneur. Il a entendu chacune de tes prières.'
	String get text => '15 minutes avec le Seigneur.\nIl a entendu chacune de tes prières.';

	/// fr: 'Ajouté à ton compte rendu'
	String get report => 'Ajouté à ton compte rendu';

	/// fr: 'Prière seule : +{added} min · {total} min aujourd'hui'
	String reportDetail({required Object added, required Object total}) => 'Prière seule : +${added} min · ${total} min aujourd\'hui';

	/// fr: 'Annuler'
	String get undo => 'Annuler';

	/// fr: 'Retraite retirée de ta journée.'
	String get undone => 'Retraite retirée de ta journée.';

	/// fr: 'Aujourd'hui'
	String get today => 'Aujourd\'hui';

	/// fr: '(one) {{n} retraite sur 4} (other) {{n} retraites sur 4}'
	String count({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
		one: '${n} retraite sur 4',
		other: '${n} retraites sur 4',
	);

	/// fr: '« Priez sans cesse. »'
	String get verse => '« Priez sans cesse. »';

	/// fr: '1 Thessaloniciens 5.17'
	String get reference => '1 Thessaloniciens 5.17';

	/// fr: 'Terminer'
	String get finish => 'Terminer';

	/// fr: 'Chanter un cantique'
	String get hymn => 'Chanter un cantique';
}

// Path: prayer.topics
class Translations$prayer$topics$fr {
	Translations$prayer$topics$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Sujets de la communauté'
	String get title => 'Sujets de la communauté';

	/// fr: 'Tout voir'
	String get all => 'Tout voir';

	/// fr: 'Aucun sujet en ce moment. Les responsables publieront les prochains ici.'
	String get empty => 'Aucun sujet en ce moment. Les responsables publieront les prochains ici.';

	Map<String, String> get categories => {
		'church': 'Église',
		'nations': 'Nations',
		'sick': 'Malades',
		'event': 'Évènement',
		'fasting': 'Jeûne',
		'other': 'Sujet',
	};

	/// fr: 'jusqu'au {date}'
	String until({required Object date}) => 'jusqu\'au ${date}';

	/// fr: 'Sujets passés'
	String get archive => 'Sujets passés';

	/// fr: 'Aucun sujet passé.'
	String get archiveEmpty => 'Aucun sujet passé.';

	/// fr: 'En ce moment'
	String get current => 'En ce moment';

	/// fr: '{kb} Ko'
	String documentSize({required Object kb}) => '${kb} Ko';

	/// fr: 'Télécharger le PDF'
	String get download => 'Télécharger le PDF';

	/// fr: 'Pas de PDF'
	String get noDocument => 'Pas de PDF';

	/// fr: 'Ouvrir le PDF'
	String get openDocument => 'Ouvrir le PDF';
}

// Path: prayer.lists
class Translations$prayer$lists$fr {
	Translations$prayer$lists$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Mes listes de prière'
	String get title => 'Mes listes de prière';

	/// fr: 'Pour toi seul'
	String get private => 'Pour toi seul';

	Map<String, String> get names => {
		'unbelievers': 'Pas encore cru',
		'believers': 'Croyants',
		'backsliders': 'Rétrogrades',
		'coworkers': 'Co-ouvriers',
	};
	Map<String, String> get uses => {
		'unbelievers': 'La retraite de midi prie chaque jour pour 10 personnes de cette liste (5 + 5), à tour de rôle.',
		'believers': 'La retraite de midi prie chaque jour pour 5 personnes de cette liste, à tour de rôle.',
		'backsliders': 'La retraite de midi prie chaque jour pour 5 personnes de cette liste, à tour de rôle.',
		'coworkers': 'La retraite du soir prie chaque jour pour 10 de tes co-ouvriers (5 + 5), à tour de rôle.',
	};

	/// fr: 'Elle n'est visible que par toi.'
	String get privateNote => 'Elle n\'est visible que par toi.';

	/// fr: '(zero) {Personne} (one) {{n} personne} (other) {{n} personnes}'
	String count({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
		zero: 'Personne',
		one: '${n} personne',
		other: '${n} personnes',
	);

	/// fr: 'Personne pour l'instant. Ajoute ceux pour qui tu pries.'
	String get empty => 'Personne pour l\'instant. Ajoute ceux pour qui tu pries.';

	/// fr: 'Ajouter une personne'
	String get add => 'Ajouter une personne';

	/// fr: 'Aujourd'hui'
	String get prayedToday => 'Aujourd\'hui';

	/// fr: 'Prochainement'
	String get next => 'Prochainement';

	Map<String, String> get answeredTitle => {
		'unbelievers': 'Ont cru au Seigneur',
		'believers': 'Prières exaucées',
		'backsliders': 'Sont revenus au Seigneur',
		'coworkers': 'Prières exaucées',
	};
	late final Translations$prayer$lists$answeredOn$fr answeredOn = Translations$prayer$lists$answeredOn$fr.internal(_root);
	Map<String, String> get markAnswered => {
		'unbelievers': 'A cru au Seigneur !',
		'believers': 'Prière exaucée',
		'backsliders': 'Est revenu au Seigneur !',
		'coworkers': 'Prière exaucée',
	};

	/// fr: 'Gloire à Dieu !'
	String get answeredToast => 'Gloire à Dieu !';

	/// fr: 'Remettre dans la liste'
	String get putBack => 'Remettre dans la liste';

	/// fr: '(one) {{n} prière exaucée ce mois-ci} (other) {{n} prières exaucées ce mois-ci}'
	String answeredBanner({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
		one: '${n} prière exaucée ce mois-ci',
		other: '${n} prières exaucées ce mois-ci',
	);

	/// fr: '{name} : {what}'
	String lastAnswered({required Object name, required Object what}) => '${name} : ${what}';

	late final Translations$prayer$lists$sheet$fr sheet = Translations$prayer$lists$sheet$fr.internal(_root);

	/// fr: 'Ajouter'
	String get addShort => 'Ajouter';
}

// Path: prayer.importunity
class Translations$prayer$importunity$fr {
	Translations$prayer$importunity$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Sujets d'importunité'
	String get title => 'Sujets d\'importunité';

	/// fr: 'Nouveau sujet'
	String get newTopic => 'Nouveau sujet';

	/// fr: 'Un sujet que l'on présente au Seigneur sans se lasser, jusqu'à la réponse. Fixe un nombre de proclamations et invite tes frères et sœurs à prier avec toi.'
	String get intro => 'Un sujet que l\'on présente au Seigneur sans se lasser, jusqu\'à la réponse. Fixe un nombre de proclamations et invite tes frères et sœurs à prier avec toi.';

	/// fr: '{name} t'invite à prier'
	String invitedBy({required Object name}) => '${name} t\'invite à prier';

	/// fr: 'Je prie avec vous'
	String get join => 'Je prie avec vous';

	/// fr: 'Pas maintenant'
	String get decline => 'Pas maintenant';

	/// fr: 'Tu pries maintenant pour ce sujet.'
	String get joined => 'Tu pries maintenant pour ce sujet.';

	/// fr: '{total} sur {goal}'
	String progress({required Object total, required Object goal}) => '${total} sur ${goal}';

	/// fr: '(one) {{count} proclamation} (other) {{count} proclamations}'
	String total({required num n, required Object count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
		one: '${count} proclamation',
		other: '${count} proclamations',
	);

	/// fr: 'Objectif atteint !'
	String get reached => 'Objectif atteint !';

	/// fr: 'Clos'
	String get closed => 'Clos';

	/// fr: '(one) {{n} prie} (other) {{n} prient}'
	String participants({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
		one: '${n} prie',
		other: '${n} prient',
	);

	/// fr: 'Toi : {n}'
	String mine({required Object n}) => 'Toi : ${n}';

	/// fr: 'Touche à chaque proclamation'
	String get tapHint => 'Touche à chaque proclamation';

	/// fr: 'Ajouter un nombre'
	String get addMany => 'Ajouter un nombre';

	/// fr: 'Combien de proclamations ?'
	String get addManyTitle => 'Combien de proclamations ?';

	/// fr: 'Proclamations'
	String get addManyLabel => 'Proclamations';

	/// fr: 'Ajouter'
	String get add => 'Ajouter';

	/// fr: '(one) {{n} en attente d'envoi} (other) {{n} en attente d'envoi}'
	String pending({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
		one: '${n} en attente d\'envoi',
		other: '${n} en attente d\'envoi',
	);

	/// fr: 'Inviter'
	String get invite => 'Inviter';

	/// fr: 'Ceux qui prient'
	String get members => 'Ceux qui prient';

	/// fr: '(one) {{n} invitation en attente} (other) {{n} invitations en attente}'
	String waiting({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
		one: '${n} invitation en attente',
		other: '${n} invitations en attente',
	);

	/// fr: 'Modifier'
	String get edit => 'Modifier';

	/// fr: 'Clore le sujet'
	String get close => 'Clore le sujet';

	/// fr: 'Rouvrir le sujet'
	String get reopen => 'Rouvrir le sujet';

	/// fr: 'Supprimer le sujet'
	String get delete => 'Supprimer le sujet';

	/// fr: 'Supprimer ce sujet ?'
	String get deleteTitle => 'Supprimer ce sujet ?';

	/// fr: 'Il disparaît pour tous ceux qui prient avec toi.'
	String get deleteText => 'Il disparaît pour tous ceux qui prient avec toi.';

	/// fr: 'Quitter ce sujet'
	String get leave => 'Quitter ce sujet';

	/// fr: 'Quitter ce sujet ?'
	String get leaveTitle => 'Quitter ce sujet ?';

	/// fr: 'Tes proclamations restent dans le total.'
	String get leaveText => 'Tes proclamations restent dans le total.';

	late final Translations$prayer$importunity$form$fr form = Translations$prayer$importunity$form$fr.internal(_root);
	late final Translations$prayer$importunity$inviteSheet$fr inviteSheet = Translations$prayer$importunity$inviteSheet$fr.internal(_root);

	/// fr: 'Sujet d'importunité'
	String get eyebrow => 'Sujet d\'importunité';

	/// fr: 'Proclamer'
	String get proclaim => 'Proclamer';
}

// Path: streak.lines
class Translations$streak$lines$fr {
	Translations$streak$lines$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Une semaine entière avec le Seigneur, jour après jour. Bravo, continue !'
	String get week => 'Une semaine entière avec le Seigneur, jour après jour. Bravo, continue !';

	/// fr: 'Un mois de fidélité ! Ce que tu sèmes chaque jour porte du fruit.'
	String get month => 'Un mois de fidélité ! Ce que tu sèmes chaque jour porte du fruit.';

	/// fr: 'Cent jours avec Dieu ! Ta persévérance est un beau témoignage.'
	String get hundred => 'Cent jours avec Dieu ! Ta persévérance est un beau témoignage.';

	/// fr: 'Une année entière avec Dieu ! Gloire à Lui pour ta fidélité.'
	String get year => 'Une année entière avec Dieu ! Gloire à Lui pour ta fidélité.';
}

// Path: blocking.reasons
class Translations$blocking$reasons$fr {
	Translations$blocking$reasons$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Indésirable'
	String get spam => 'Indésirable';

	/// fr: 'Contenu choquant ou offensant'
	String get offensive => 'Contenu choquant ou offensant';

	/// fr: 'Autre'
	String get other => 'Autre';
}

// Path: bible.colors
class Translations$bible$colors$fr {
	Translations$bible$colors$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'jaune'
	String get yellow => 'jaune';

	/// fr: 'vert'
	String get green => 'vert';

	/// fr: 'bleu'
	String get blue => 'bleu';

	/// fr: 'rose'
	String get pink => 'rose';
}

// Path: seekFirst.shield
class Translations$seekFirst$shield$fr {
	Translations$seekFirst$shield$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Cherche d'abord Dieu'
	String get title => 'Cherche d\'abord Dieu';

	/// fr: '{app} reste fermée jusqu'à ton compte rendu d'aujourd'hui.'
	String subtitle({required Object app}) => '${app} reste fermée jusqu\'à ton compte rendu d\'aujourd\'hui.';

	/// fr: 'Cette app'
	String get thisApp => 'Cette app';

	/// fr: 'Remplir mon compte rendu'
	String get fill => 'Remplir mon compte rendu';

	/// fr: 'Pause de 5 min ({n}/3)'
	String pause({required Object n}) => 'Pause de 5 min (${n}/3)';

	/// fr: 'Cherche d'abord Dieu'
	String get notificationTitle => 'Cherche d\'abord Dieu';

	/// fr: 'Touche ici pour remplir ton compte rendu.'
	String get notificationBody => 'Touche ici pour remplir ton compte rendu.';
}

// Path: souls.csv
class Translations$souls$csv$fr {
	Translations$souls$csv$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Nom'
	String get name => 'Nom';

	/// fr: 'Téléphone'
	String get phone => 'Téléphone';

	/// fr: 'Lieu'
	String get place => 'Lieu';

	/// fr: 'Rencontré le'
	String get metOn => 'Rencontré le';

	/// fr: 'Étape'
	String get stage => 'Étape';

	/// fr: 'Prochain contact'
	String get next => 'Prochain contact';

	/// fr: 'Notes'
	String get notes => 'Notes';
}

// Path: reports.units.chapters
class Translations$reports$units$chapters$fr {
	Translations$reports$units$chapters$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Nombre de chapitres'
	String get name => 'Nombre de chapitres';

	/// fr: 'chapitres'
	String get label => 'chapitres';

	/// fr: 'chapitres'
	String get symbol => 'chapitres';

	/// fr: '(one) {{value} chapitre} (other) {{value} chapitres}'
	String count({required num n, required Object value}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
		one: '${value} chapitre',
		other: '${value} chapitres',
	);
}

// Path: reports.units.times
class Translations$reports$units$times$fr {
	Translations$reports$units$times$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Nombre de fois'
	String get name => 'Nombre de fois';

	/// fr: 'fois'
	String get label => 'fois';

	/// fr: 'fois'
	String get symbol => 'fois';

	/// fr: '(one) {{value} fois} (other) {{value} fois}'
	String count({required num n, required Object value}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
		one: '${value} fois',
		other: '${value} fois',
	);
}

// Path: reports.units.pages
class Translations$reports$units$pages$fr {
	Translations$reports$units$pages$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Nombre de pages'
	String get name => 'Nombre de pages';

	/// fr: 'pages'
	String get label => 'pages';

	/// fr: 'pages'
	String get symbol => 'pages';

	/// fr: '(one) {{value} page} (other) {{value} pages}'
	String count({required num n, required Object value}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
		one: '${value} page',
		other: '${value} pages',
	);
}

// Path: reports.units.percent
class Translations$reports$units$percent$fr {
	Translations$reports$units$percent$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Pourcentage'
	String get name => 'Pourcentage';

	/// fr: 'pourcentage'
	String get label => 'pourcentage';

	/// fr: '%'
	String get symbol => '%';

	/// fr: '{value} %'
	String count({required Object value}) => '${value} %';
}

// Path: ministry.goals.crusade
class Translations$ministry$goals$crusade$fr {
	Translations$ministry$goals$crusade$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'La toute-créature gospel crusade'
	String get title => 'La toute-créature gospel crusade';

	/// fr: 'Prêcher l’évangile à chacun de ceux qui vivront dans notre génération de sorte que 10 milliards de personnes soient atteintes avec l’évangile prêché dans la puissance du Saint-Esprit, en utilisant tous les moyens de communication (nos livres, nos traités, nos magazines, nos CD, nos DVD, notre radio, notre télévision et Internet) de la manière la plus urgente possible.'
	String get text => 'Prêcher l’évangile à chacun de ceux qui vivront dans notre génération de sorte que 10 milliards de personnes soient atteintes avec l’évangile prêché dans la puissance du Saint-Esprit, en utilisant tous les moyens de communication (nos livres, nos traités, nos magazines, nos CD, nos DVD, notre radio, notre télévision et Internet) de la manière la plus urgente possible.';

	/// fr: 'personnes atteintes par l’évangile'
	String get reached => 'personnes atteintes par l’évangile';
}

// Path: ministry.goals.disciples
class Translations$ministry$goals$disciples$fr {
	Translations$ministry$goals$disciples$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'La formation des disciples'
	String get title => 'La formation des disciples';

	/// fr: 'Amener 1 milliard de personnes dans 250 nations à connaître Jésus-Christ comme Seigneur et Sauveur et qu’elles soient faites disciples pour lui obéir en toutes choses et organisées pour se réunir dans 25 millions d’églises de maison d’ici l’an 2065.'
	String get text => 'Amener 1 milliard de personnes dans 250 nations à connaître Jésus-Christ comme Seigneur et Sauveur et qu’elles soient faites disciples pour lui obéir en toutes choses et organisées pour se réunir dans 25 millions d’églises de maison d’ici l’an 2065.';

	/// fr: 'disciples'
	String get people => 'disciples';

	/// fr: 'nations'
	String get nations => 'nations';

	/// fr: 'églises de maison'
	String get churches => 'églises de maison';

	/// fr: 'd’ici {year}'
	String by({required Object year}) => 'd’ici ${year}';
}

// Path: ministry.goals.revival
class Translations$ministry$goals$revival$fr {
	Translations$ministry$goals$revival$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Précipiter le réveil global'
	String get title => 'Précipiter le réveil global';

	/// fr: 'Coopérer avec Dieu par le jeûne et l’intercession pour le réveil mondial qui va déchirer les cieux, secouer la terre, glorifier Christ dans notre génération pour précipiter le retour imminent de notre Seigneur Jésus-Christ du ciel pour la rencontre avec son Épouse rendue prête.'
	String get text => 'Coopérer avec Dieu par le jeûne et l’intercession pour le réveil mondial qui va déchirer les cieux, secouer la terre, glorifier Christ dans notre génération pour précipiter le retour imminent de notre Seigneur Jésus-Christ du ciel pour la rencontre avec son Épouse rendue prête.';

	/// fr: 'Jeûne'
	String get fasting => 'Jeûne';

	/// fr: 'Intercession'
	String get intercession => 'Intercession';

	/// fr: 'Prier maintenant'
	String get pray => 'Prier maintenant';
}

// Path: ministry.lives.founder
class Translations$ministry$lives$founder$fr {
	Translations$ministry$lives$founder$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Pr Zacharias Tanee Fomum'
	String get name => 'Pr Zacharias Tanee Fomum';

	/// fr: '1945 – 2009 · Fondateur de la CMCI'
	String get line => '1945 – 2009 · Fondateur de la CMCI';

	List<String> get facts => [
		'fondation de la CMCI',
		'livres écrits',
		'nations visitées',
	];
	List<String> get dates => [
		'Naît le 20 juin au Cameroun, dans une famille presbytérienne.',
		'Donne sa vie à Jésus-Christ le 13 juin, en lisant un tract.',
		'Se livre tout entier au Seigneur le 1er octobre, en Sierra Leone.',
		'Est rempli du Saint-Esprit le 24 octobre, après sept jours de prière.',
		'Fonde la CMCI à Yaoundé le 12 mai.',
		'Reçoit le doctorat ès sciences de l\'Université de Durham.',
		'Rejoint le Seigneur le 14 mars.',
	];
	List<String> get story => [
		'Zacharias Tanee Fomum est né le 20 juin 1945 au Cameroun, dans une famille presbytérienne originaire de Batibo, dans le Nord-Ouest. Encore écolier, il a donné sa vie à Jésus-Christ le 13 juin 1956, en lisant un tract intitulé « Quelqu\'un est mort pour toi ».',
		'Étudiant à Fourah Bay College, en Sierra Leone, il s\'est livré sans réserve au Seigneur et à son service le 1er octobre 1966. Le 24 octobre 1970, au terme de sept jours de prière et de jeûne, il a été rempli du Saint-Esprit. Dès lors, la prière est devenue le centre de sa vie.',
		'Docteur en chimie organique de l\'université Makerere, en Ouganda, il a enseigné à l\'Université de Yaoundé, où il est devenu professeur. Il a dirigé une centaine de thèses et de mémoires, et l\'Université de Durham, en Grande-Bretagne, lui a décerné en 2005 un doctorat ès sciences pour l\'ensemble de ses travaux.',
		'Le 12 mai 1975, à Yaoundé, il a fondé la Communauté Missionnaire Chrétienne Internationale : un mouvement pour gagner des âmes, faire des disciples, implanter des églises et envoyer des missionnaires. Il a fait plus de 700 voyages missionnaires au Cameroun et plus de 500 dans plus de 70 nations, sur six continents.',
		'Il passait chaque jour de longues heures seul avec Dieu, a conduit de nombreuses croisades, sièges et marches de prière, et a souvent jeûné. Il a écrit plus de 150 livres sur la prière, le jeûne, la sainteté, la formation des disciples et la mission, lus dans de nombreuses langues.',
		'Avec son épouse, Prisca Zei Fomum, servante de Dieu auprès des enfants, il a eu sept enfants, tous engagés dans l\'œuvre de l\'Évangile. Ensemble, ils vivaient simplement pour donner à l\'Évangile la plus grande part de leurs revenus.',
		'Il est entré dans la présence du Seigneur le 14 mars 2009 et a été inhumé à Yaoundé le 21 mars. L\'œuvre qu\'il a fondée continue dans les nations.',
	];
}

// Path: ministry.lives.leader
class Translations$ministry$lives$leader$fr {
	Translations$ministry$lives$leader$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Théodore Andoseh'
	String get name => 'Théodore Andoseh';

	/// fr: 'Leader de la CMCI depuis 2009'
	String get line => 'Leader de la CMCI depuis 2009';

	List<String> get facts => [
		'églises implantées',
		'ans au Nigeria',
		'à la tête de la CMCI',
	];
	List<String> get dates => [
		'Donne sa vie à Jésus-Christ sous la prédication du Pr Fomum.',
		'Est consacré évêque à Yaoundé.',
		'Part comme missionnaire au Nigeria avec son épouse, Adela.',
		'Prend la conduite de la CMCI.',
		'Apporte les messages de la 3e convention mondiale à des membres de 93 nations.',
	];
	List<String> get story => [
		'Théodore Andoseh a donné sa vie à Jésus-Christ en 1978, en écoutant prêcher le Pr Zacharias Tanee Fomum, qui est devenu son père spirituel et l\'a formé comme disciple.',
		'Il a d\'abord servi à ses côtés : assistant de laboratoire à l\'Université de Yaoundé, puis son assistant personnel et son secrétaire particulier. Dans ces années, il a publié le premier tract du réveil, « Dieu parle à l\'homme qui veut entendre », et lancé la première chaîne de prière de Yaoundé.',
		'Missionnaire national, il a implanté plus de cinquante églises au Cameroun. Il a été consacré évêque à Yaoundé en 1989.',
		'En 1994, il est parti comme missionnaire au Nigeria avec son épouse, Adela. Ils y ont servi quatorze ans.',
		'Depuis 2009, quand le Pr Fomum est entré dans la présence du Seigneur, il conduit la CMCI dans les nations. En décembre 2019, à Koumé, près de Bertoua, il a apporté les messages de la troisième convention mondiale à des membres venus de 93 nations. Il est aussi l\'auteur de plusieurs livres sur le service de Dieu et l\'édification de l\'Église.',
	];
}

// Path: prayer.retreat.hints
class Translations$prayer$retreat$hints$fr {
	Translations$prayer$retreat$hints$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Ton assemblée : {name}'
	String assembly({required Object name}) => 'Ton assemblée : ${name}';

	/// fr: 'Ajoute ton assemblée dans ton profil'
	String get assemblyMissing => 'Ajoute ton assemblée dans ton profil';

	/// fr: 'Tes autorités : {names}'
	String authorities({required Object names}) => 'Tes autorités : ${names}';

	/// fr: 'Ajoute tes autorités spirituelles dans Plus'
	String get authoritiesMissing => 'Ajoute tes autorités spirituelles dans Plus';

	/// fr: 'Mes listes · {list}'
	String list({required Object list}) => 'Mes listes · ${list}';

	/// fr: 'Ta liste « {list} » est vide : ajoute des noms'
	String listEmpty({required Object list}) => 'Ta liste « ${list} » est vide : ajoute des noms';

	/// fr: 'Aujourd'hui : {name}'
	String nation({required Object name}) => 'Aujourd\'hui : ${name}';

	/// fr: 'Ton pays : {name}'
	String myCountry({required Object name}) => 'Ton pays : ${name}';

	/// fr: 'Ouvrir les cantiques'
	String get hymn => 'Ouvrir les cantiques';
}

// Path: prayer.lists.answeredOn
class Translations$prayer$lists$answeredOn$fr {
	Translations$prayer$lists$answeredOn$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'A cru au Seigneur le {date}'
	String unbelievers({required Object date}) => 'A cru au Seigneur le ${date}';

	/// fr: 'Exaucé le {date}'
	String believers({required Object date}) => 'Exaucé le ${date}';

	/// fr: 'Est revenu le {date}'
	String backsliders({required Object date}) => 'Est revenu le ${date}';

	/// fr: 'Exaucé le {date}'
	String coworkers({required Object date}) => 'Exaucé le ${date}';
}

// Path: prayer.lists.sheet
class Translations$prayer$lists$sheet$fr {
	Translations$prayer$lists$sheet$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Ajouter une personne'
	String get addTitle => 'Ajouter une personne';

	/// fr: 'Modifier'
	String get editTitle => 'Modifier';

	/// fr: 'Nom'
	String get name => 'Nom';

	/// fr: 'Paul M.'
	String get namePlaceholder => 'Paul M.';

	/// fr: 'Note'
	String get note => 'Note';

	/// fr: 'Collègue, voisin, cousine…'
	String get notePlaceholder => 'Collègue, voisin, cousine…';

	/// fr: 'Liste'
	String get list => 'Liste';

	/// fr: 'Enregistrer'
	String get save => 'Enregistrer';

	/// fr: 'Retirer de la liste'
	String get remove => 'Retirer de la liste';

	/// fr: 'Retirer {name} ?'
	String removeTitle({required Object name}) => 'Retirer ${name} ?';

	/// fr: 'Tu ne prieras plus pour cette personne dans tes retraites.'
	String get removeText => 'Tu ne prieras plus pour cette personne dans tes retraites.';
}

// Path: prayer.importunity.form
class Translations$prayer$importunity$form$fr {
	Translations$prayer$importunity$form$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Nouveau sujet d'importunité'
	String get newTitle => 'Nouveau sujet d\'importunité';

	/// fr: 'Modifier le sujet'
	String get editTitle => 'Modifier le sujet';

	/// fr: 'Sujet'
	String get subject => 'Sujet';

	/// fr: 'Seigneur, sauve Paul'
	String get subjectPlaceholder => 'Seigneur, sauve Paul';

	/// fr: 'Détails'
	String get description => 'Détails';

	/// fr: 'Pour qui, pourquoi…'
	String get descriptionPlaceholder => 'Pour qui, pourquoi…';

	/// fr: 'Objectif'
	String get goal => 'Objectif';

	/// fr: 'Le nombre de proclamations à atteindre ensemble. Laisse vide pour compter sans objectif.'
	String get goalHint => 'Le nombre de proclamations à atteindre ensemble. Laisse vide pour compter sans objectif.';

	/// fr: '10 000'
	String get goalPlaceholder => '10 000';

	/// fr: 'Créer'
	String get create => 'Créer';

	/// fr: 'Enregistrer'
	String get save => 'Enregistrer';
}

// Path: prayer.importunity.inviteSheet
class Translations$prayer$importunity$inviteSheet$fr {
	Translations$prayer$importunity$inviteSheet$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Inviter à prier'
	String get title => 'Inviter à prier';

	/// fr: 'Ma famille spirituelle'
	String get family => 'Ma famille spirituelle';

	/// fr: '(one) {{name} et ses disciples : {n} personne} (other) {{name} et ses disciples : {n} personnes}'
	String familyText({required num n, required Object name}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
		one: '${name} et ses disciples : ${n} personne',
		other: '${name} et ses disciples : ${n} personnes',
	);

	/// fr: 'Lie ton faiseur de disciples (FD) dans Mes autorités spirituelles pour inviter ta famille spirituelle.'
	String get familyMissing => 'Lie ton faiseur de disciples (FD) dans Mes autorités spirituelles pour inviter ta famille spirituelle.';

	/// fr: 'Par pseudo'
	String get byUsername => 'Par pseudo';

	/// fr: 'Pseudo'
	String get usernameLabel => 'Pseudo';

	/// fr: 'Ajouter'
	String get addUsername => 'Ajouter';

	/// fr: 'Envoyer les invitations'
	String get send => 'Envoyer les invitations';

	/// fr: '(zero) {Ils étaient déjà invités.} (one) {{n} invitation envoyée} (other) {{n} invitations envoyées}'
	String sent({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
		zero: 'Ils étaient déjà invités.',
		one: '${n} invitation envoyée',
		other: '${n} invitations envoyées',
	);
}

/// The flat map containing all translations for locale <fr>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on Translations {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'app.name' => 'CMFI Connect',
			'app.tagline' => 'Grandir ensemble, chaque jour.',
			'app.languageName' => 'Français',
			'common.retry' => 'Réessayer',
			'common.cancel' => 'Annuler',
			'common.save' => 'Enregistrer',
			'common.close' => 'Fermer',
			'common.back' => 'Retour',
			'common.soon' => 'Bientôt',
			'common.optional' => '(facultatif)',
			'common.and' => 'et',
			'common.loading' => 'Chargement…',
			'common.done' => 'OK',
			'common.rangeStart' => 'Du',
			'common.rangeEnd' => 'Au',
			'errors.network' => 'Pas de connexion à internet. Vérifie ton réseau et réessaie.',
			'errors.unauthorized' => 'Ta session a expiré. Reconnecte-toi.',
			'errors.invalidCredentials' => 'Numéro de téléphone ou mot de passe incorrect.',
			'errors.badRequest' => 'Certaines informations ne sont pas valides.',
			'errors.conflict' => 'Cet élément existe déjà.',
			'errors.notFound' => 'Élément introuvable.',
			'errors.server' => 'Le serveur a rencontré un problème. Réessaie dans un instant.',
			'errors.unknown' => 'Une erreur est survenue. Réessaie.',
			'errors.forbidden' => 'Tu n\'as pas le droit de faire cela.',
			'errors.eventFull' => 'Il n\'y a plus de place pour cet évènement.',
			'errors.registrationClosed' => 'Les inscriptions à cet évènement sont closes.',
			'errors.mediaTooLarge' => 'Cette image est trop lourde (8 Mo au plus).',
			'errors.mediaUnsupported' => 'Choisis une image JPEG ou PNG.',
			'errors.notParticipant' => 'Rejoins d\'abord ce sujet pour compter tes proclamations.',
			'errors.importunityClosed' => 'Ce sujet est clos : il ne compte plus de proclamations.',
			'errors.usernameNotFound' => 'Personne n\'a ce pseudo. Vérifie l\'orthographe.',
			'errors.ownerCannotLeave' => 'Tu as créé ce sujet : supprime-le plutôt que de le quitter.',
			'errors.tooManyPeople' => 'Tes listes sont pleines (500 personnes au plus).',
			'errors.avatarInvalid' => 'Cette photo ne peut pas être utilisée. Choisis-en une autre.',
			'errors.reportsNotShared' => 'Ce membre ne partage plus ses comptes rendus.',
			'validation.required' => 'Ce champ est obligatoire',
			'validation.passwordTooShort' => 'Au moins 6 caractères',
			'validation.invalidPhone' => 'Numéro de téléphone invalide',
			'validation.invalidEmail' => 'Adresse e-mail invalide',
			'validation.invalidCode' => 'Lettres et chiffres uniquement, sans espace',
			'onboarding.skip' => 'Passer',
			'onboarding.next' => 'Suivant',
			'onboarding.start' => 'Commencer',
			'onboarding.step' => ({required Object current, required Object total}) => 'Écran ${current} sur ${total}',
			'onboarding.reports.title' => 'Ta marche avec Dieu, jour après jour',
			'onboarding.reports.text' => 'Note en quelques secondes ta lecture biblique, ta prière, tes jeûnes… et vois ta progression semaine après semaine.',
			'onboarding.worship.title' => 'Chante et prie, où que tu sois',
			'onboarding.worship.text' => 'Retrouve les cantiques de la communauté et porte chaque jour les sujets de prière avec tes frères et sœurs.',
			'onboarding.community.title' => 'Reste lié à ta communauté',
			'onboarding.community.text' => 'Les évènements et les annonces de ton assemblée, au même endroit, pour ne rien manquer.',
			'onboarding.sample.today' => 'Aujourd\'hui',
			'onboarding.sample.bibleReading' => 'Lecture biblique',
			'onboarding.sample.prayerAlone' => 'Prière seule',
			'onboarding.sample.meditation' => 'Méditation',
			'onboarding.sample.groupPrayer' => 'Prière en groupe',
			'onboarding.sample.thisWeek' => 'Cette semaine',
			'onboarding.sample.weekScore' => '4 jours sur 5',
			'onboarding.sample.hymn' => 'Cantique',
			'onboarding.sample.hymnNumber' => 'N° 12',
			'onboarding.sample.fullScreen' => 'Plein écran',
			'onboarding.sample.prayerOfTheDay' => 'Sujet de prière du jour',
			'onboarding.sample.prayerTopic' => 'Pour les examens de nos jeunes',
			'onboarding.sample.praying' => '12 personnes prient',
			'onboarding.sample.iPray' => 'Je prie',
			'onboarding.sample.vigil' => 'Veillée de prière',
			'onboarding.sample.vigilMeta' => '20 h · Assemblée locale',
			'onboarding.sample.join' => 'Je participe',
			'onboarding.sample.retreat' => 'Retraite des jeunes',
			'onboarding.sample.retreatMeta' => 'Toute la journée',
			'onboarding.sample.announcement' => 'Annonce',
			'onboarding.sample.announcementText' => 'Le culte de dimanche commence à 8 h 30.',
			'onboarding.sample.chapters' => '10 ch.',
			'welcome.title' => 'Bienvenue sur CMFI Connect',
			'welcome.text' => 'Crée ton compte en une minute pour remplir ton compte rendu et suivre la vie de ta communauté.',
			'welcome.createAccount' => 'Créer mon compte',
			'welcome.haveAccount' => 'J\'ai déjà un compte',
			'auth.phone' => 'Téléphone',
			'auth.dialCode' => ({required Object code}) => 'Indicatif : ${code}',
			'auth.password' => 'Mot de passe',
			'auth.showPassword' => 'Afficher le mot de passe',
			'auth.hidePassword' => 'Masquer le mot de passe',
			'auth.login.title' => 'Content de te revoir',
			'auth.login.subtitle' => 'Connecte-toi pour remplir ton compte rendu du jour.',
			'auth.login.submit' => 'Se connecter',
			'auth.login.noAccount' => 'Pas encore de compte ?',
			'auth.login.createAccount' => 'Créer un compte',
			'auth.register.step' => ({required Object current, required Object total}) => '${current} / ${total}',
			'auth.register.title' => 'Crée ton compte',
			'auth.register.subtitle' => 'Ton numéro de téléphone te servira à te connecter.',
			'auth.register.firstName' => 'Prénom',
			'auth.register.lastName' => 'Nom',
			'auth.register.passwordHelp' => '6 caractères minimum',
			'auth.register.email' => 'E-mail',
			'auth.register.submit' => 'Continuer',
			'auth.register.haveAccount' => 'Déjà un compte ?',
			'auth.register.login' => 'Se connecter',
			'auth.register.alreadyUsed' => 'Ce numéro ou cet e-mail a déjà un compte. Connecte-toi.',
			'auth.register.emailHint' => 'toi@exemple.com',
			'auth.church.title' => 'Ton église',
			'auth.church.subtitle' => 'Ces informations aident tes responsables à te retrouver. Tu pourras les modifier plus tard.',
			'auth.church.editTitle' => 'Mon profil',
			'auth.church.editSubtitle' => 'Mets à jour ton nom, ton église et ton assemblée.',
			'auth.church.country' => 'Pays',
			'auth.church.countryHint' => 'Choisis ton pays',
			'auth.church.city' => 'Ville',
			'auth.church.cityHint' => 'Yaoundé',
			'auth.church.church' => 'Église',
			'auth.church.churchHint' => 'Nom de ton église',
			'auth.church.assembly' => 'Assemblée',
			'auth.church.assemblyHint' => 'Nom de ton assemblée',
			'auth.church.info' => 'Tu as déménagé ou changé d\'assemblée ? Tu pourras tout mettre à jour depuis ton profil.',
			'auth.church.submit' => 'Terminer',
			'auth.church.skip' => 'Passer cette étape',
			'auth.church.saved' => 'Profil enregistré',
			'auth.forgot.link' => 'Mot de passe oublié ?',
			'auth.forgot.title' => 'Mot de passe oublié',
			'auth.forgot.phoneText' => 'Entre ton numéro : on t\'envoie un code par SMS pour choisir un nouveau mot de passe.',
			'auth.forgot.sendCode' => 'Recevoir le code',
			'auth.forgot.codeTitle' => 'Entre le code',
			'auth.forgot.codeText' => ({required Object phone}) => 'Nous avons envoyé un code à 6 chiffres au ${phone}.',
			'auth.forgot.code' => 'Code reçu par SMS',
			'auth.forgot.codeInvalid' => 'Le code a 6 chiffres',
			'auth.forgot.verify' => 'Vérifier',
			'auth.forgot.resend' => 'Renvoyer le code',
			'auth.forgot.resendIn' => ({required Object seconds}) => 'Renvoyer le code dans ${seconds} s',
			'auth.forgot.changeNumber' => 'Changer de numéro',
			'auth.forgot.passwordTitle' => 'Nouveau mot de passe',
			'auth.forgot.passwordText' => 'Choisis un nouveau mot de passe pour ton compte.',
			'auth.forgot.submit' => 'Enregistrer et me connecter',
			'auth.forgot.done' => 'Mot de passe changé. Content de te revoir !',
			'auth.forgot.remembered' => 'Tu t\'en souviens ?',
			'auth.forgot.invalidCode' => 'Ce code n\'est pas le bon.',
			'auth.forgot.expired' => 'Le code a expiré. Demandes-en un nouveau.',
			'auth.forgot.tooManyRequests' => 'Trop de tentatives. Réessaie dans un moment.',
			'auth.forgot.unavailable' => 'La réinitialisation n\'est pas disponible pour l\'instant.',
			'auth.forgot.noAccount' => 'Aucun compte n\'utilise ce numéro.',
			'auth.biometric.faceId' => 'Face ID',
			'auth.biometric.touchId' => 'Touch ID',
			'auth.biometric.fingerprint' => 'ton empreinte',
			'auth.biometric.face' => 'ton visage',
			'auth.biometric.signIn' => ({required Object method}) => 'Se connecter avec ${method}',
			'auth.biometric.askTitle' => ({required Object method}) => 'Te connecter avec ${method} ?',
			'auth.biometric.askText' => 'La prochaine fois, plus besoin de taper ton mot de passe : il reste dans le coffre sécurisé de ton téléphone.',
			'auth.biometric.enable' => 'Activer',
			'auth.biometric.later' => 'Plus tard',
			'auth.biometric.reason' => 'Connecte-toi à CMFI Connect',
			'auth.biometric.enableReason' => 'Active la connexion rapide à CMFI Connect',
			'auth.biometric.changed' => ({required Object method}) => 'Ton mot de passe a changé : connecte-toi avec ton mot de passe, puis réactive ${method}.',
			'auth.biometric.settings' => ({required Object method}) => 'Connexion avec ${method}',
			'auth.biometric.settingsText' => 'Sans taper ton mot de passe',
			'auth.biometric.passwordTitle' => 'Ton mot de passe',
			'auth.biometric.passwordLabel' => 'Mot de passe',
			'auth.biometric.confirm' => 'Valider',
			'auth.biometric.enabled' => ({required Object method}) => 'Connexion avec ${method} activée',
			'countries.dialCodeTitle' => 'Indicatif du pays',
			'countries.title' => 'Ton pays',
			'countries.search' => 'Rechercher un pays ou un indicatif',
			'countries.none' => 'Aucun pays ne correspond',
			'countries.change' => 'Changer de pays',
			'nav.home' => 'Accueil',
			'nav.reports' => 'Compte rendu',
			'nav.hymns' => 'Cantiques',
			'nav.prayer' => 'Prière',
			'nav.bible' => 'Bible',
			'home.greeting' => ({required Object name}) => 'Bonjour ${name}',
			'home.greetingNoName' => 'Bonjour',
			'home.profile' => 'Mon profil',
			'home.progress' => ({required Object filled, required Object total}) => '${filled} sur ${total}',
			'home.progressLabel' => 'éléments renseignés',
			'home.goals' => 'objectifs',
			'home.weekTitle' => 'Ta semaine',
			'home.community' => 'Actuellement à la CMCI',
			'home.eventsTitle' => 'Évènements',
			'home.hymnsTitle' => 'Cantiques',
			'home.hymnsOpen' => 'Ouvrir le recueil',
			'home.continueMyReport' => 'Continuer mon compte rendu',
			'home.startMyReport' => 'Commencer mon compte rendu',
			'home.items' => 'éléments',
			'home.goalsTitle' => 'Objectifs',
			'home.retreatsTitle' => 'Retraites',
			'home.retreatsValue' => ({required Object n}) => '${n} sur 4',
			'home.streakTitle' => 'Série',
			'home.resume' => 'À reprendre',
			'home.hymnNumber' => ({required Object number}) => 'Cantique n° ${number}',
			'home.seeAll' => 'Tout voir',
			'home.retreatsDone' => 'Les 4 retraites du jour sont faites',
			'home.days' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n, one: '${n} jour', other: '${n} jours', ), 
			'home.hideNumbers' => 'Masquer mes chiffres',
			'home.showNumbers' => 'Afficher mes chiffres',
			'home.numbersHidden' => 'masqué',
			'reports.title' => 'Compte rendu',
			'reports.myItems' => 'Mes éléments',
			'reports.tabs.today' => 'Aujourd\'hui',
			'reports.tabs.history' => 'Historique',
			'reports.tabs.summary' => 'Bilan',
			'reports.pickDay' => 'Choisir le jour',
			'reports.filled' => ({required Object filled, required Object total}) => '${filled} sur ${total} renseignés',
			'reports.statusSaved' => 'Enregistré',
			'reports.statusModified' => 'Non enregistré',
			'reports.standard' => 'Standards',
			'reports.personal' => 'Mes éléments',
			'reports.createItem' => 'Créer un élément',
			'reports.add' => ({required Object label}) => 'Ajouter ${label}',
			'reports.note' => 'Note du jour',
			'reports.noteHint' => 'Un verset, un sujet de reconnaissance…',
			'reports.save' => 'Enregistrer la journée',
			'reports.saved' => 'Journée enregistrée',
			'reports.measure.quantity' => ({required Object unit}) => '${unit}',
			'reports.measure.duration' => 'durée',
			'reports.measure.both' => ({required Object unit}) => '${unit} et durée',
			'reports.measure.quantityNoUnit' => 'quantité',
			'reports.measure.bothNoUnit' => 'quantité et durée',
			'reports.times' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n, one: '${n} fois', other: '${n} fois', ), 
			'reports.sheet.quantity' => 'Quantité',
			'reports.sheet.duration' => 'Durée',
			'reports.sheet.minus1' => '− 1 min',
			'reports.sheet.plus1' => '+ 1 min',
			'reports.sheet.removeMinute' => 'Retirer une minute',
			'reports.sheet.addMinute' => 'Ajouter une minute',
			'reports.sheet.holdToRepeat' => 'Maintiens appuyé pour aller plus vite',
			'reports.sheet.decrease' => 'Diminuer',
			'reports.sheet.increase' => 'Augmenter',
			'reports.sheet.clear' => 'Effacer',
			'reports.sheet.validate' => 'Valider',
			'reports.history.daysFilled' => ({required Object filled, required Object total}) => '${filled} jours remplis sur ${total}',
			'reports.history.legendFilled' => 'Rempli',
			'reports.history.legendMissing' => 'Pas de compte rendu',
			'reports.history.none' => 'Aucun compte rendu',
			'reports.history.fill' => 'Remplir',
			'reports.history.inProgress' => 'En cours',
			'reports.history.previousMonth' => 'Mois précédent',
			'reports.history.nextMonth' => 'Mois suivant',
			'reports.history.today' => 'aujourd\'hui',
			'reports.summary.week' => 'Semaine',
			'reports.summary.month' => 'Mois',
			'reports.summary.year' => 'Année',
			'reports.summary.range' => ({required Object from, required Object to}) => 'Du ${from} au ${to}',
			'reports.summary.regularity' => 'Régularité',
			'reports.summary.daysFilled' => 'jours remplis',
			'reports.summary.missingDays' => ({required num n, required Object days}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n, one: '${n} jour sans compte rendu : le ${days}', other: '${n} jours sans compte rendu : les ${days}', ), 
			'reports.summary.missingCount' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n, one: '${n} jour sans compte rendu', other: '${n} jours sans compte rendu', ), 
			'reports.summary.noMissing' => 'Aucun jour manqué, bravo !',
			'reports.summary.perDay' => ({required Object value}) => '${value} par jour rempli',
			'reports.summary.days' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n, one: '${n} jour', other: '${n} jours', ), 
			'reports.summary.notFilled' => 'Pas encore renseignés',
			'reports.summary.barsCaption' => ({required Object max}) => 'Par jour · barre la plus haute : ${max}',
			'reports.summary.barsCaptionMonthly' => ({required Object max}) => 'Par mois · barre la plus haute : ${max}',
			'reports.summary.empty' => 'Aucun compte rendu sur cette période.',
			'reports.summary.goalDays' => ({required num n, required Object total}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n, one: 'Objectif atteint ${n} jour sur ${total}', other: 'Objectif atteint ${n} jours sur ${total}', ), 
			'reports.summary.share' => 'Partager ce bilan',
			'reports.summary.goals' => 'Objectifs',
			'reports.summary.goalsAverage' => 'Accomplissement moyen de tes objectifs',
			'reports.summary.goalsHint' => 'Chaque jour compte, même vide. Aujourd\'hui compte une fois rempli.',
			'reports.summary.evolution' => 'Évolution de tes objectifs',
			'reports.summary.evolutionHint' => 'Semaine après semaine, sur les 12 dernières.',
			'reports.summary.premiumYear' => 'L\'année et l\'évolution de tes objectifs viennent avec Premium.',
			'reports.noItems' => 'Aucun élément à renseigner pour le moment.',
			'reports.statusPending' => 'Pas encore envoyé',
			'reports.savedOffline' => 'Pas de réseau : la journée est gardée sur le téléphone et partira dès que possible.',
			'reports.pendingBanner' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n, one: '${n} journée attend le réseau pour être envoyée', other: '${n} journées attendent le réseau pour être envoyées', ), 
			'reports.export' => 'Exporter mon compte rendu',
			'reports.goal' => ({required Object value}) => 'Objectif : ${value}',
			'reports.goalReached' => 'Objectif atteint',
			'reports.dayGoals' => 'Objectifs de la journée',
			'reports.goalsReached' => ({required Object reached, required Object total}) => 'Atteints : ${reached} sur ${total}',
			'reports.standardItems.lb' => 'Lecture biblique',
			'reports.standardItems.ps' => 'Prière seule',
			'reports.standardItems.rdqad' => 'Méditation',
			'reports.standardItems.pg' => 'Prière en groupe',
			'reports.standardItems.llc' => 'Lecture de la littérature chrétienne',
			'reports.standardItems.jc' => 'Jeûne complet',
			'reports.standardItems.jp' => 'Jeûne partiel',
			'reports.standardItems.dimes' => 'Dîmes',
			'reports.standardItems.off' => 'Offrandes',
			'reports.units.chapters.name' => 'Nombre de chapitres',
			'reports.units.chapters.label' => 'chapitres',
			'reports.units.chapters.symbol' => 'chapitres',
			'reports.units.chapters.count' => ({required num n, required Object value}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n, one: '${value} chapitre', other: '${value} chapitres', ), 
			'reports.units.times.name' => 'Nombre de fois',
			'reports.units.times.label' => 'fois',
			'reports.units.times.symbol' => 'fois',
			'reports.units.times.count' => ({required num n, required Object value}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n, one: '${value} fois', other: '${value} fois', ), 
			'reports.units.pages.name' => 'Nombre de pages',
			'reports.units.pages.label' => 'pages',
			'reports.units.pages.symbol' => 'pages',
			'reports.units.pages.count' => ({required num n, required Object value}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n, one: '${value} page', other: '${value} pages', ), 
			'reports.units.percent.name' => 'Pourcentage',
			'reports.units.percent.label' => 'pourcentage',
			'reports.units.percent.symbol' => '%',
			'reports.units.percent.count' => ({required Object value}) => '${value} %',
			'reminder.title' => 'Ton compte rendu du jour',
			'reminder.body' => 'Prends une minute pour noter ta lecture, ta prière… avant la fin de la journée.',
			'reminder.channel' => 'Rappel du compte rendu',
			'reminder.settings' => 'Rappel du soir',
			'reminder.off' => 'Désactivé',
			'reminder.switchLabel' => 'Me rappeler de remplir ma journée',
			'reminder.switchHint' => 'Seulement si la journée n\'est pas encore remplie.',
			'reminder.time' => 'Heure du rappel',
			'reminder.offerTitle' => 'Un rappel chaque soir ?',
			'reminder.offerText' => 'Si ta journée n\'est pas encore remplie, l\'app te le rappelle à l\'heure choisie. Rien si c\'est déjà fait.',
			'reminder.offerAccept' => 'Activer le rappel',
			'reminder.offerLater' => 'Plus tard',
			'reminder.enabled' => ({required Object time}) => 'Rappel activé à ${time}',
			'reminder.denied' => 'Les notifications sont bloquées pour CMFI Connect. Autorise-les dans les réglages du téléphone.',
			'export.title' => 'Exporter',
			'export.period' => 'Période',
			'export.thisWeek' => 'Cette semaine',
			'export.lastWeek' => 'Semaine dernière',
			'export.thisMonth' => 'Ce mois-ci',
			'export.lastMonth' => 'Mois dernier',
			'export.thisYear' => 'Cette année',
			'export.custom' => 'Autres dates',
			'export.customPick' => 'Choisir les dates',
			'export.format' => 'Format',
			'export.pdf' => 'PDF',
			'export.pdfHint' => 'Un document à envoyer ou à imprimer',
			'export.csv' => 'Tableur',
			'export.csvHint' => 'Un fichier CSV pour Excel ou Google Sheets',
			'export.text' => 'Message',
			'export.textHint' => 'Un résumé à coller dans WhatsApp',
			'export.button' => 'Exporter',
			'export.shareButton' => 'Partager',
			'export.preview' => ({required num filled, required Object total, required Object items}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(filled, one: '${filled} jour rempli sur ${total} · ${items}', other: '${filled} jours remplis sur ${total} · ${items}', ), 
			'export.previewItems' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n, one: '${n} élément', other: '${n} éléments', ), 
			'export.empty' => 'Aucun compte rendu sur cette période.',
			'export.tooLong' => 'Choisis 366 jours au plus.',
			'export.fileName' => 'compte-rendu',
			'export.subject' => ({required Object period}) => 'Mon compte rendu, ${period}',
			'export.doc.title' => 'Compte rendu',
			'export.doc.regularity' => 'Régularité',
			'export.doc.daysFilled' => ({required num filled, required Object total}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(filled, one: '${filled} jour rempli sur ${total}', other: '${filled} jours remplis sur ${total}', ), 
			'export.doc.totals' => 'Sur la période',
			'export.doc.item' => 'Élément',
			'export.doc.total' => 'Total',
			'export.doc.days' => 'Jours',
			'export.doc.average' => 'Moyenne / jour rempli',
			'export.doc.goal' => 'Objectif atteint',
			'export.doc.detail' => 'Jour par jour',
			'export.doc.date' => 'Date',
			'export.doc.values' => 'Rempli',
			'export.doc.note' => 'Note',
			'export.doc.noReport' => 'Pas de compte rendu',
			'export.doc.generated' => ({required Object date}) => 'Généré le ${date} avec CMFI Connect',
			'export.doc.page' => ({required Object n, required Object total}) => 'Page ${n} / ${total}',
			'export.doc.filledColumn' => 'Compte rendu',
			'export.doc.yes' => 'oui',
			'export.doc.no' => 'non',
			'export.doc.sentFrom' => 'Envoyé depuis CMFI Connect',
			'items.title' => 'Mes éléments',
			'items.standardSection' => 'Standards · pour tous',
			'items.personalSection' => 'Mes éléments personnels',
			'items.emptyPersonal' => 'Tu n\'as pas encore d\'élément personnel.',
			'items.archive' => 'Archiver',
			'items.archiveTitle' => ({required Object code}) => 'Archiver ${code} ?',
			'items.archiveText' => 'Il ne sera plus proposé dans ton compte rendu. Ses chiffres restent dans ton historique.',
			'items.archived' => ({required Object code}) => '${code} archivé',
			'items.create' => 'Créer un élément',
			'items.footnote' => 'Un élément archivé n\'est plus proposé dans ton compte rendu, mais ses chiffres restent dans ton historique.',
			'items.measure.quantity' => ({required Object unit}) => 'Quantité · ${unit}',
			'items.measure.quantityNoUnit' => 'Quantité',
			'items.measure.duration' => 'Durée',
			'items.measure.both' => ({required Object unit}) => 'Quantité (${unit}) et durée',
			'items.measure.bothNoUnit' => 'Quantité et durée',
			'items.goalAdd' => 'Ajouter un objectif',
			'items.goal' => ({required Object value}) => 'Objectif : ${value} par jour',
			'items.goalTitle' => 'Objectif par jour',
			'items.goalHint' => 'Ce que tu vises chaque jour. Il reste sur ton téléphone.',
			'items.goalRemove' => 'Retirer',
			'items.goalSaved' => 'Objectif enregistré',
			'items.goalRemoved' => 'Objectif retiré',
			'newItem.title' => 'Nouvel élément',
			'newItem.code' => 'Code',
			'newItem.label' => 'Nom',
			'newItem.help' => 'Lettres et chiffres, 20 au plus. Le code d\'un élément standard (LB, PS…) n\'est pas disponible.',
			'newItem.measures' => 'Ce que tu mesures',
			'newItem.quantity' => 'Une quantité',
			'newItem.quantityHint' => 'Chapitres, pages, personnes…',
			'newItem.unit' => 'Unité affichée après le nombre',
			'newItem.unitHint' => 'personnes',
			'newItem.duration' => 'Une durée',
			'newItem.durationHint' => 'En heures et minutes',
			'newItem.noMeasure' => 'Choisis au moins une mesure : une quantité, une durée ou les deux.',
			'newItem.preview' => 'Aperçu dans ton compte rendu',
			'newItem.previewCode' => 'CODE',
			'newItem.previewLabel' => 'Nom de l\'élément',
			'newItem.submit' => 'Créer l\'élément',
			'newItem.created' => ({required Object code}) => '${code} est créé.',
			'newItem.codeTaken' => 'Ce code est déjà utilisé, par un élément standard ou par l\'un de tes éléments (même archivé).',
			'newItem.codeHint' => 'EVG',
			'newItem.labelHint' => 'Évangélisation',
			'more.title' => 'Plus',
			'more.editProfile' => 'Modifier mon profil',
			'more.community' => 'Communauté',
			'more.events' => 'Évènements',
			'more.reports' => 'Compte rendu',
			'more.myItems' => 'Mes éléments',
			'more.app' => 'Application',
			'more.language' => 'Langue',
			'more.appearance' => 'Apparence',
			'more.themeSystem' => 'Automatique',
			'more.themeSystemHint' => 'En automatique, l\'app suit le réglage clair ou sombre du téléphone.',
			'more.themeLight' => 'Clair',
			'more.themeDark' => 'Sombre',
			'more.logout' => 'Se déconnecter',
			'more.account' => 'Compte',
			'more.languageTitle' => 'Langue de l\'application',
			'more.completeProfile' => 'Ajoute ton nom',
			'more.accompaniment' => 'Accompagnement',
			'more.exportReport' => 'Exporter mon compte rendu',
			'more.logoutPendingTitle' => 'Journées pas encore envoyées',
			'more.logoutPendingText' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n, one: '${n} journée enregistrée sans réseau n\'a pas encore été envoyée. Si tu te déconnectes maintenant, elle sera perdue.', other: '${n} journées enregistrées sans réseau n\'ont pas encore été envoyées. Si tu te déconnectes maintenant, elles seront perdues.', ), 
			'more.logoutAnyway' => 'Me déconnecter',
			'more.admin' => 'Administration',
			'more.staff' => 'Équipe et rôles',
			'more.manageEvents' => 'Évènements',
			'more.disciples' => 'Mes disciples',
			'more.version' => ({required Object version}) => 'Version ${version}',
			'more.copyright' => ({required Object year}) => '© ${year} Communauté Missionnaire Chrétienne Internationale. Tous droits réservés.',
			'authorities.title' => 'Mes autorités spirituelles',
			'authorities.intro' => 'Les personnes qui t\'accompagnent dans ta marche avec Dieu : ton faiseur de disciples et tes autres responsables.',
			'authorities.discipleMaker' => 'Faiseur de disciples',
			'authorities.discipleMakerOf' => ({required Object name}) => 'Faiseur de disciples : ${name}',
			'authorities.noDiscipleMaker' => 'Pas encore de faiseur de disciples',
			'authorities.others' => 'Autres autorités',
			'authorities.empty' => 'Tu n\'as encore ajouté personne.',
			'authorities.add' => 'Ajouter une autorité',
			'authorities.remove' => 'Retirer',
			'authorities.removeTitle' => ({required Object name}) => 'Retirer ${name} ?',
			'authorities.removeText' => ({required Object name}) => '${name} ne fera plus partie de tes autorités spirituelles.',
			'authorities.removed' => ({required Object name}) => '${name} ne fait plus partie de tes autorités.',
			'authorities.count' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n, zero: 'Personne pour l\'instant', one: '${n} personne', other: '${n} personnes', ), 
			'authorities.form.title' => 'Nouvelle autorité',
			'authorities.form.emailHint' => 'nom@exemple.com',
			'authorities.form.isDiscipleMaker' => 'C\'est mon faiseur de disciples',
			'authorities.form.isDiscipleMakerHelp' => 'La personne qui t\'accompagne personnellement. Tu n\'en as qu\'un.',
			'authorities.form.discipleMakerTaken' => ({required Object name}) => '${name} est déjà ton faiseur de disciples. Retire-le de la liste pour en désigner un autre.',
			'authorities.form.submit' => 'Ajouter',
			'authorities.form.added' => ({required Object name}) => '${name} fait maintenant partie de tes autorités.',
			'authorities.form.searchLabel' => 'Son pseudo',
			'authorities.form.searchHint' => 'pseudo',
			'authorities.form.search' => 'Rechercher',
			'authorities.form.searchHelp' => 'Si la personne utilise CMFI Connect, cherche-la par son pseudo. Elle recevra ta demande, et ses coordonnées s\'afficheront quand elle l\'aura acceptée.',
			'authorities.form.notFound' => ({required Object username}) => 'Personne n\'a le pseudo @${username}.',
			'authorities.form.invite' => 'L\'inviter à rejoindre CMFI Connect',
			'authorities.form.inviteText' => 'Bonjour ! J\'utilise CMFI Connect pour noter ma marche avec Dieu, et j\'aimerais que tu m\'accompagnes. Installe l\'application, crée ton compte, puis envoie-moi ton pseudo pour que je t\'ajoute.',
			'authorities.form.inviteMine' => ({required Object username}) => 'Mon pseudo : @${username}',
			'authorities.form.manual' => 'Elle n\'a pas l\'application ? Saisir ses coordonnées',
			'authorities.form.backToSearch' => 'Chercher plutôt par pseudo',
			'authorities.form.request' => 'Envoyer la demande',
			'authorities.form.requested' => ({required Object name}) => 'Demande envoyée à ${name}.',
			'authorities.form.alreadyAdded' => 'Cette personne fait déjà partie de tes autorités.',
			'authorities.form.makerExists' => 'Tu as déjà un faiseur de disciples.',
			'authorities.form.yourself' => 'C\'est ton propre pseudo.',
			'authorities.form.sharingHelp' => ({required Object name}) => '${name} verra tes comptes rendus : les éléments remplis, ta régularité et tes pourcentages, jamais ta note. Tu peux l\'arrêter sur sa fiche.',
			'authorities.statusPending' => 'En attente',
			'authorities.statusDeclined' => 'Refusée',
			'authorities.pendingHelp' => ({required Object name}) => 'Ses coordonnées s\'afficheront quand ${name} aura accepté.',
			'authorities.requests' => 'Demandes reçues',
			'authorities.requestDiscipleMaker' => 'te demande d\'être son faiseur de disciples',
			'authorities.requestAuthority' => 'te demande de l\'accompagner',
			'authorities.accept' => 'Accepter',
			'authorities.decline' => 'Refuser',
			'authorities.acceptedRequest' => ({required Object name}) => 'Tu accompagnes maintenant ${name}.',
			'authorities.declinedRequest' => ({required Object name}) => 'Demande de ${name} refusée.',
			'authorities.requestsCount' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n, one: '${n} demande à voir', other: '${n} demandes à voir', ), 
			'authorities.sharing.title' => 'Partager mes comptes rendus',
			'authorities.sharing.help' => ({required Object name}) => '${name} voit tes comptes rendus : les éléments remplis, ta régularité et tes pourcentages, jamais ta note.',
			'authorities.sharing.on' => ({required Object name}) => 'Tes comptes rendus sont partagés avec ${name}.',
			'authorities.sharing.off' => ({required Object name}) => '${name} ne voit plus tes comptes rendus.',
			'members.username' => 'Pseudo',
			'members.usernameHint' => 'prenom.nom',
			'members.usernameHelp' => 'C\'est ainsi que les autres membres te trouveront.',
			'members.usernameChecking' => 'Vérification…',
			'members.usernameFree' => ({required Object username}) => '@${username} est libre',
			'members.usernameCurrent' => 'C\'est ton pseudo actuel',
			'members.usernameTaken' => 'Ce pseudo est déjà pris.',
			'members.usernameInvalid' => '3 à 30 caractères : lettres, chiffres, « . » et « _ », sans commencer ni finir par un signe.',
			'members.usernameReserved' => 'Ce pseudo est réservé.',
			'members.usernameSaved' => ({required Object username}) => 'Pseudo enregistré : @${username}',
			'members.deleteAccount.button' => 'Supprimer mon compte',
			'members.deleteAccount.title' => 'Supprimer mon compte',
			'members.deleteAccount.intro' => 'C\'est définitif. Ton compte et tout ce qui y est lié seront effacés :',
			'members.deleteAccount.itemProfile' => 'ton profil, ta photo, ton pseudo et ton mot de passe',
			'members.deleteAccount.itemReports' => 'tous tes comptes rendus, tes éléments et tes objectifs',
			'members.deleteAccount.itemAuthorities' => 'tes autorités spirituelles et les demandes reçues',
			'members.deleteAccount.itemEvents' => 'tes inscriptions aux évènements',
			'members.deleteAccount.itemPrayer' => 'tes listes de prière, tes retraites et tes sujets d\'importunité',
			'members.deleteAccount.kept' => 'Les évènements, actualités, photos et sujets de prière que tu as publiés comme admin restent pour la communauté, sans ton nom.',
			'members.deleteAccount.passwordHelp' => 'Pour confirmer que c\'est bien toi.',
			'members.deleteAccount.confirm' => 'Supprimer définitivement',
			'members.deleteAccount.done' => 'Ton compte a été supprimé. Que Dieu te bénisse !',
			'members.deleteAccount.wrongPassword' => 'Mot de passe incorrect.',
			'members.deleteAccount.lastSuperadmin' => 'Tu es le seul superadmin : donne ce rôle à quelqu\'un d\'autre avant de supprimer ton compte.',
			'admin.title' => 'Équipe et rôles',
			'admin.intro' => 'Les admins gèrent ce que toute la communauté partage. Seul un superadmin donne ou retire un rôle.',
			'admin.roleUser' => 'Membre',
			'admin.roleAdmin' => 'Admin',
			'admin.roleSuperadmin' => 'Superadmin',
			'admin.giveRole' => 'Donner un rôle',
			'admin.you' => 'toi',
			'admin.roleFor' => ({required Object username}) => 'Rôle de @${username}',
			'admin.roleChanged' => ({required Object username, required Object role}) => '@${username} : ${role}',
			'admin.memberUsername' => 'Pseudo du membre',
			'admin.empty' => 'Aucun admin pour l\'instant.',
			'hymns.searchHint' => 'Numéro, titre ou paroles',
			'hymns.openNumber' => 'Aller à un numéro',
			'hymns.tabs.all' => 'Tous',
			'hymns.tabs.favorites' => 'Favoris',
			'hymns.tabs.recent' => 'Récents',
			'hymns.chooseBook' => 'Choisir le recueil',
			'hymns.count' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n, one: '${n} cantique', other: '${n} cantiques', ), 
			'hymns.number' => ({required Object number}) => 'N° ${number}',
			_ => null,
		} ?? switch (path) {
			'hymns.emptyFavorites' => 'Touche l\'étoile d\'un cantique pour le retrouver ici.',
			'hymns.emptyRecent' => 'Les cantiques que tu ouvres apparaîtront ici.',
			'hymns.noResult' => ({required Object query}) => 'Aucun cantique ne correspond à « ${query} ».',
			'hymns.otherBooks' => 'Dans les autres recueils',
			'hymns.upToDate' => 'Les recueils sont à jour.',
			'hymns.updated' => 'Les recueils ont été mis à jour.',
			'hymns.chorus' => 'Refrain',
			'hymns.chorusNumber' => ({required Object label}) => 'Refrain ${label}',
			'hymns.verse' => ({required Object label}) => 'Couplet ${label}',
			'hymns.times' => ({required Object n}) => '×${n}',
			'hymns.loadFailed' => 'Impossible d\'ouvrir les recueils.',
			'hymns.reader.smaller' => 'Réduire le texte',
			'hymns.reader.larger' => 'Agrandir le texte',
			'hymns.reader.display' => 'Affichage',
			'hymns.reader.textSize' => 'Taille du texte',
			'hymns.reader.typeface' => 'Police',
			'hymns.reader.typefaceAuto' => 'Auto',
			'hymns.reader.typefaceSans' => 'Moderne',
			'hymns.reader.typefaceSerif' => 'Classique',
			'hymns.reader.typefaceAutoHelp' => 'Classique quand le texte est grand',
			'hymns.reader.background' => 'Fond',
			'hymns.reader.themeAuto' => 'Auto',
			'hymns.reader.themeLight' => 'Clair',
			'hymns.reader.themeSepia' => 'Sépia',
			'hymns.reader.themeDark' => 'Sombre',
			'hymns.reader.repeatChorus' => 'Répéter le refrain après chaque couplet',
			'hymns.reader.keepScreenOn' => 'Garder l\'écran allumé',
			'hymns.reader.addFavorite' => 'Ajouter aux favoris',
			'hymns.reader.removeFavorite' => 'Retirer des favoris',
			'hymns.reader.favoriteAdded' => 'Ajouté aux favoris',
			'hymns.reader.favoriteRemoved' => 'Retiré des favoris',
			'hymns.reader.more' => 'Plus d\'options',
			'hymns.reader.copy' => 'Copier les paroles',
			'hymns.reader.copied' => 'Paroles copiées',
			'hymns.reader.project' => 'Mode projection',
			'hymns.reader.pinchHint' => 'Pince l\'écran pour agrandir ou réduire le texte.',
			'hymns.reader.notFound' => 'Ce cantique n\'existe plus dans le recueil.',
			'hymns.reader.share' => 'Partager les paroles',
			'hymns.projection.exit' => 'Quitter le mode projection',
			'hymns.projection.previous' => 'Strophe précédente',
			'hymns.projection.next' => 'Strophe suivante',
			'hymns.projection.position' => ({required Object current, required Object total}) => '${current} / ${total}',
			'hymns.projection.hint' => 'Touche à droite pour avancer, à gauche pour revenir.',
			'hymns.pad.title' => 'Aller au cantique',
			'hymns.pad.open' => 'Ouvrir',
			'hymns.pad.erase' => 'Effacer',
			'hymns.pad.notFound' => ({required Object number}) => 'Pas de cantique n° ${number} dans ce recueil',
			'hymns.pad.placeholder' => 'Tape un numéro',
			'comingSoon.badge' => 'Bientôt disponible',
			'comingSoon.backHome' => 'Retour à l\'accueil',
			'events.title' => 'Évènements',
			'events.featured' => 'À la une',
			'events.upcoming' => 'À venir',
			'events.past' => 'Éditions passées',
			'events.emptyTitle' => 'Aucun évènement à venir',
			'events.emptyText' => 'Les conférences et les rencontres de toute la communauté apparaîtront ici, avec leur programme.',
			'events.manage' => 'Gérer les évènements',
			'events.next' => 'Prochain évènement',
			'events.seeAll' => 'Tous les évènements',
			'events.homeText' => 'Les rencontres de la communauté, leur programme et leurs actualités.',
			'events.today' => 'Aujourd\'hui',
			'events.tomorrow' => 'Demain',
			'events.inDays' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n, one: 'Dans ${n} jour', other: 'Dans ${n} jours', ), 
			'events.daysLeft' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n, other: 'J-${n}', ), 
			'events.onNow' => 'En cours',
			'events.over' => 'Terminé',
			'events.cancelled' => 'Annulé',
			'events.draft' => 'Brouillon',
			'events.registered' => 'Inscrit',
			'events.stateOpen' => 'Inscriptions ouvertes',
			'events.stateClosed' => 'Inscriptions closes',
			'events.stateFull' => 'Complet',
			'events.registrations' => ({required num n, required Object count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n, zero: 'Sois le premier à t\'inscrire', one: '${count} inscrit', other: '${count} inscrits', ), 
			'events.people' => ({required num n, required Object count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n, one: '${count} personne', other: '${count} personnes', ), 
			'events.placesLeft' => ({required num n, required Object count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n, zero: 'plus de place', one: '${count} place restante', other: '${count} places restantes', ), 
			'events.oneDay' => ({required Object start, required Object end}) => 'De ${start} à ${end}',
			'events.severalDays' => ({required Object startDay, required Object start, required Object endDay, required Object end}) => 'Ouverture le ${startDay} à ${start}, clôture le ${endDay} à ${end}',
			'events.venueTime' => ({required Object place}) => 'heure de ${place}',
			'events.addToCalendar' => 'Ajouter au calendrier',
			'events.share' => 'Partager',
			'events.directions' => 'Itinéraire',
			'events.viewPoster' => 'Voir l\'affiche',
			'events.tabs.program' => 'Programme',
			'events.tabs.news' => 'Actualités',
			'events.tabs.info' => 'Infos',
			'events.tabs.photos' => 'Photos',
			'events.noProgram' => 'Le programme sera bientôt publié.',
			'events.noNews' => 'Pas encore d\'actualité pour cet évènement.',
			'events.pinned' => 'Épinglé',
			'events.now' => 'En ce moment',
			'events.hymn' => ({required Object number}) => 'Cantique ${number}',
			'events.about' => 'À propos',
			'events.fees' => 'Participation',
			'events.deadline' => ({required Object date}) => 'Inscriptions jusqu\'au ${date}',
			'events.contact' => 'Contact',
			'events.call' => ({required Object name}) => 'Appeler ${name}',
			'events.otherEditions' => 'Les autres éditions',
			'events.cancelledBanner' => 'Cet évènement est annulé.',
			'events.calendarFailed' => 'Impossible d\'ouvrir le calendrier du téléphone.',
			'events.linkFailed' => 'Impossible d\'ouvrir ce lien.',
			'events.shareText' => ({required Object title, required Object dates, required Object place}) => '${title}\n${dates} · ${place}\nInscris-toi dans l\'app CMFI Connect.',
			'events.full' => 'Il n\'y a plus de place pour cet évènement.',
			'events.closed' => 'Les inscriptions à cet évènement sont closes.',
			'events.register.cta' => 'Je participe',
			'events.register.title' => 'Je participe',
			'events.register.people' => 'Combien serez-vous ?',
			'events.register.peopleHint' => 'Toi compris, avec ta famille ou ton groupe.',
			'events.register.less' => 'Une personne de moins',
			'events.register.more' => 'Une personne de plus',
			'events.register.lodging' => 'J\'ai besoin d\'un hébergement',
			'events.register.lodgingHint' => 'Les organisateurs prévoient les places.',
			'events.register.departure' => 'Ville de départ',
			'events.register.departureHint' => 'Ex. Douala',
			'events.register.confirm' => 'Confirmer mon inscription',
			'events.register.update' => 'Mettre à jour',
			'events.register.cancel' => 'Annuler mon inscription',
			'events.register.done' => 'C\'est noté, tu es inscrit ! On te le rappellera la veille.',
			'events.register.updated' => 'Ton inscription est à jour.',
			'events.register.cancelled' => 'Ton inscription est annulée.',
			'events.register.edit' => 'Modifier',
			'events.register.youAre' => 'Tu es inscrit',
			'events.register.cancelTitle' => 'Annuler ton inscription ?',
			'events.register.cancelText' => 'Ta place sera libérée pour quelqu\'un d\'autre.',
			'events.register.keep' => 'Garder ma place',
			'events.register.lodgingShort' => 'hébergement',
			'events.reminder.channel' => 'Rappels des évènements',
			'events.reminder.tomorrow' => ({required Object title}) => 'Demain : ${title}',
			'events.reminder.soon' => ({required Object title}) => 'Dans 1 h : ${title}',
			'events.admin.title' => 'Gérer les évènements',
			'events.admin.create' => 'Créer un évènement',
			'events.admin.edit' => 'Modifier l\'évènement',
			'events.admin.empty' => 'Aucun évènement pour l\'instant. Crée le premier !',
			'events.admin.poster' => 'Affiche',
			'events.admin.posterAdd' => 'Choisir une affiche',
			'events.admin.posterChange' => 'Changer l\'affiche',
			'events.admin.posterRemove' => 'Retirer l\'affiche',
			'events.admin.posterHint' => 'Format portrait 4:5 conseillé (1080 × 1350), JPEG ou PNG.',
			'events.admin.uploading' => 'Envoi de l\'image…',
			'events.admin.general' => 'L\'évènement',
			'events.admin.titleField' => 'Titre',
			'events.admin.titleHint' => 'Ex. Conférence annuelle 2026',
			'events.admin.titleRequired' => 'Donne un titre à l\'évènement.',
			'events.admin.theme' => 'Thème',
			'events.admin.themeHint' => 'Ex. Marcher dans l\'Esprit',
			'events.admin.verse' => 'Verset du thème',
			'events.admin.description' => 'Présentation',
			'events.admin.when' => 'Dates',
			'events.admin.starts' => 'Début',
			'events.admin.ends' => 'Fin',
			'events.admin.endsBeforeStart' => 'La fin doit venir après le début.',
			'events.admin.timeZone' => ({required Object zone}) => 'Heures du lieu (${zone}).',
			'events.admin.where' => 'Lieu',
			'events.admin.venue' => 'Lieu',
			'events.admin.venueHint' => 'Ex. Centre de conférences de Mvolyé',
			'events.admin.address' => 'Adresse',
			'events.admin.city' => 'Ville',
			'events.admin.country' => 'Pays',
			'events.admin.mapsUrl' => 'Lien Google Maps',
			'events.admin.registration' => 'Inscriptions',
			'events.admin.registrationOpen' => 'Inscriptions ouvertes',
			'events.admin.deadline' => 'Date limite',
			'events.admin.noDeadline' => 'Pas de date limite',
			'events.admin.capacity' => 'Nombre de places',
			'events.admin.capacityHint' => 'Vide : sans limite',
			'events.admin.asksLodging' => 'Demander qui a besoin d\'un hébergement',
			'events.admin.asksDeparture' => 'Demander la ville de départ',
			'events.admin.fees' => 'Participation',
			'events.admin.feesHint' => 'Ex. Entrée libre. Repas : 2 000 FCFA par jour.',
			'events.admin.contact' => 'Contact',
			'events.admin.contactName' => 'Nom du contact',
			'events.admin.contactPhone' => 'Téléphone du contact',
			'events.admin.visibility' => 'Visibilité',
			'events.admin.statusDraft' => 'Brouillon',
			'events.admin.statusDraftHint' => 'Visible seulement des admins',
			'events.admin.statusPublished' => 'Publié',
			'events.admin.statusPublishedHint' => 'Visible de toute la communauté',
			'events.admin.statusCancelled' => 'Annulé',
			'events.admin.statusCancelledHint' => 'Affiché comme annulé, sans inscription',
			'events.admin.saved' => 'Évènement enregistré.',
			'events.admin.menu' => 'Gérer',
			'events.admin.program' => 'Programme',
			'events.admin.registrants' => 'Inscrits',
			'events.admin.post' => 'Publier une actualité',
			'events.admin.photos' => 'Ajouter des photos',
			'events.admin.nextEdition' => 'Préparer l\'édition suivante',
			'events.admin.delete' => 'Supprimer l\'évènement',
			'events.admin.deleteTitle' => 'Supprimer cet évènement ?',
			'events.admin.deleteText' => 'Les inscriptions, les actualités et les photos seront supprimées aussi.',
			'events.admin.deleteConfirm' => 'Supprimer',
			'events.admin.deleted' => 'Évènement supprimé.',
			'events.admin.nextEditionTitle' => 'Préparer l\'édition suivante ?',
			'events.admin.nextEditionText' => 'Un brouillon est créé un an plus tard, avec le même lieu et le même programme. Tu pourras tout ajuster avant de le publier.',
			'events.admin.nextEditionConfirm' => 'Préparer',
			'events.admin.nextEditionDone' => 'L\'édition suivante est prête en brouillon.',
			'events.admin.programEmpty' => 'Ajoute les moments de l\'évènement : accueil, cultes, enseignements, veillée…',
			'events.admin.addSession' => 'Ajouter un moment',
			'events.admin.editSession' => 'Modifier ce moment',
			'events.admin.sessionTitle' => 'Titre',
			'events.admin.sessionTitleHint' => 'Ex. Culte d\'ouverture',
			'events.admin.speaker' => 'Orateur',
			'events.admin.place' => 'Salle',
			'events.admin.day' => 'Jour',
			'events.admin.from' => 'De',
			'events.admin.to' => 'À',
			'events.admin.hymns' => 'Cantiques',
			'events.admin.hymnsHint' => 'Numéros, ex. 12, 45',
			'events.admin.removeSession' => 'Retirer',
			'events.admin.saveProgram' => 'Enregistrer le programme',
			'events.admin.programSaved' => 'Programme enregistré.',
			'events.admin.registrantsEmpty' => 'Personne n\'est encore inscrit.',
			'events.admin.totalRegistrations' => 'Inscriptions',
			'events.admin.totalPeople' => 'Personnes',
			'events.admin.totalLodging' => 'À loger',
			'events.admin.byCity' => 'Par ville de départ',
			'events.admin.list' => 'Liste',
			'events.admin.exportCsv' => 'Exporter la liste (CSV)',
			'events.admin.csvHeader' => 'Nom;Pseudo;Téléphone;Église;Assemblée;Personnes;Hébergement;Ville de départ;Inscrit le',
			'events.admin.yes' => 'oui',
			'events.admin.no' => 'non',
			'events.admin.postBody' => 'Message',
			'events.admin.postBodyHint' => 'Ex. Les inscriptions sont ouvertes !',
			'events.admin.postImage' => 'Ajouter une image',
			'events.admin.postPinned' => 'Épingler en haut',
			'events.admin.postSend' => 'Publier',
			'events.admin.postDone' => 'Actualité publiée.',
			'events.admin.postDelete' => 'Supprimer cette actualité',
			'events.admin.postDeleted' => 'Actualité supprimée.',
			'events.admin.photosAdded' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n, one: '${n} photo ajoutée.', other: '${n} photos ajoutées.', ), 
			'events.admin.photosSending' => ({required Object done, required Object total}) => 'Envoi des photos (${done}/${total})…',
			'events.admin.photoDelete' => 'Supprimer cette photo',
			'events.admin.photoDeleted' => 'Photo supprimée.',
			'events.admin.confirmDelete' => 'Supprimer',
			'events.upcomingCount' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n, one: '${n} évènement à venir', other: '${n} évènements à venir', ), 
			'events.slide' => ({required Object current, required Object total}) => 'Évènement ${current} sur ${total}',
			'notifications.title' => 'Notifications',
			'notifications.channel' => 'Annonces de la communauté',
			'notifications.empty' => 'Aucune notification pour l\'instant',
			'notifications.emptyHint' => 'Les annonces de la communauté arriveront ici.',
			'notifications.unreadLabel' => ({required Object title}) => 'Non lue : ${title}',
			'notifications.documents' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n, one: '${n} document PDF', other: '${n} documents PDF', ), 
			'notifications.unread' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n, one: '${n} non lue', other: '${n} non lues', ), 
			'notifications.image' => ({required Object n}) => 'Image ${n}',
			'notifications.document' => 'Document PDF',
			'notifications.documentSize' => ({required Object kb}) => '${kb} Ko',
			'notifications.received' => ({required Object title}) => 'Nouvelle notification : ${title}',
			'premium.name' => 'CMFI Connect Premium',
			'premium.pill' => 'Premium',
			'premium.subtitle' => 'Va plus loin dans ta marche avec Dieu, et soutiens l\'œuvre.',
			'premium.widgetTitle' => 'Le widget de l\'écran d\'accueil',
			'premium.widgetText' => 'Ton compte rendu du jour et tes objectifs, sans ouvrir l\'app.',
			'premium.statsTitle' => 'Tes objectifs sur l\'année',
			'premium.statsText' => 'Le bilan de l\'année et l\'évolution de tes objectifs, semaine après semaine.',
			'premium.supportTitle' => 'Tu soutiens l\'œuvre',
			'premium.supportText' => 'Ton abonnement fait vivre l\'app pour toute la communauté.',
			'premium.annual' => 'Annuel',
			'premium.lifetime' => 'À vie',
			'premium.monthly' => 'Mensuel',
			'premium.perYear' => ({required Object price}) => '${price} / an',
			'premium.once' => ({required Object price}) => '${price} une fois',
			'premium.perMonth' => ({required Object price}) => '${price} / mois',
			'premium.annualPerMonth' => ({required Object price}) => 'soit ${price} par mois',
			'premium.best' => 'Le plus avantageux',
			'premium.trialDays' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n, one: '${n} jour d\'essai gratuit', other: '${n} jours d\'essai gratuit', ), 
			'premium.trialMonths' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n, one: '${n} mois d\'essai gratuit', other: '${n} mois d\'essai gratuit', ), 
			'premium.subscribe' => 'S\'abonner',
			'premium.startTrial' => 'Commencer l\'essai gratuit',
			'premium.restore' => 'Restaurer mes achats',
			'premium.restored' => 'Premium est de retour sur ce téléphone',
			'premium.nothingToRestore' => 'Aucun achat Premium pour ce compte',
			'premium.thanks' => 'Merci ! Premium est activé.',
			'premium.failed' => 'L\'achat n\'a pas abouti. Réessaie dans un instant.',
			'premium.unavailable' => 'Les offres ne sont pas disponibles pour l\'instant.',
			'premium.renews' => ({required Object store}) => 'L\'abonnement se renouvelle automatiquement. Tu peux l\'annuler quand tu veux dans les réglages de ton compte ${store}.',
			'premium.terms' => 'Conditions d\'utilisation',
			'premium.privacy' => 'Confidentialité',
			'premium.activeTitle' => 'Tu as Premium',
			'premium.activeText' => 'Merci de soutenir CMFI Connect ! Le widget et l\'année de ton bilan sont ouverts.',
			'premium.staffText' => 'Premium t\'est offert parce que tu fais partie de l\'équipe de CMFI Connect.',
			'premium.moreSubtitle' => 'Widget, objectifs sur l\'année',
			'premium.moreActive' => 'Actif',
			'premium.unlock' => 'Débloquer avec Premium',
			'premium.trialThen' => ({required Object trial, required Object price}) => '${trial}, puis ${price}',
			'premium.savePercent' => ({required Object percent}) => '−${percent}',
			'premium.choose' => 'Choisis ton offre',
			'premium.cancelAnytime' => 'Sans engagement, annulable à tout moment',
			'premium.restoreShort' => 'Restaurer',
			'premium.termsShort' => 'Conditions',
			'premium.semiannual' => 'Semestriel',
			'premium.perSemester' => ({required Object price}) => '${price} / 6 mois',
			'premium.buyLifetime' => 'Acheter à vie',
			'premium.lifetimeNote' => 'À vie : un seul paiement, sans abonnement ni renouvellement.',
			'premium.manage' => 'Gérer mon abonnement',
			'premium.manageFailed' => 'La gestion de l\'abonnement ne s\'ouvre pas. Réessaie plus tard.',
			'homeWidget.title' => 'Aujourd\'hui',
			'homeWidget.done' => 'Fait',
			'homeWidget.todo' => 'À remplir',
			'homeWidget.open' => 'Remplir',
			'homeWidget.locked' => 'Active le widget avec Premium',
			'homeWidget.signedOut' => 'Connecte-toi dans l\'app',
			'ministry.title' => 'Notre ministère',
			'ministry.tagline' => 'Jusqu\'aux extrémités de la terre',
			'ministry.count' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n, one: '${n} nation', other: '${n} nations', ), 
			'ministry.fromYaounde' => 'Depuis Yaoundé, l\'Évangile va de nation en nation.',
			'ministry.dragHint' => 'Fais tourner le globe du doigt, touche une nation.',
			'ministry.globeLabel' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n, one: 'Globe : ${n} nation où l\'œuvre est présente. La liste plus bas la donne.', other: 'Globe : ${n} nations où l\'œuvre est présente. La liste plus bas les donne toutes.', ), 
			'ministry.voyage' => 'Voyage',
			'ministry.pause' => 'Pause',
			'ministry.previous' => 'Nation précédente',
			'ministry.next' => 'Nation suivante',
			'ministry.number' => ({required Object n}) => 'Nation n° ${n}',
			'ministry.since' => ({required Object year}) => 'Depuis ${year}',
			'ministry.pray' => 'Prier',
			'ministry.prayTitle' => ({required Object country}) => 'Prier pour ${country}',
			'ministry.prayThanks' => ({required Object country}) => 'Rends grâce pour l\'œuvre de Dieu en ${country}.',
			'ministry.prayAssemblies' => ({required Object country}) => 'Prie pour les assemblées de ${country} et pour leurs responsables.',
			'ministry.prayUnreached' => ({required Object country}) => 'Prie pour que ceux qui n\'ont pas encore cru en ${country} rencontrent Jésus.',
			'ministry.purpose' => 'Notre but',
			'ministry.nations' => 'Les nations',
			'ministry.search' => 'Rechercher une nation',
			'ministry.none' => 'Aucune nation ne correspond',
			'ministry.homeText' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n, one: 'Présente dans ${n} nation', other: 'Présente dans ${n} nations', ), 
			'ministry.nationsSubtitle' => 'Le globe et le voyage de nation en nation',
			'ministry.purposeSubtitle' => 'Nos trois buts',
			'ministry.missionaries' => 'Nos missionnaires',
			'ministry.missionariesSubtitle' => 'Ceux que le Seigneur envoie aux nations',
			'ministry.heroes' => 'Nos héros',
			'ministry.heroesSubtitle' => 'Ceux dont la foi nous inspire',
			'ministry.founder' => 'Notre fondateur',
			'ministry.founderSubtitle' => 'Le Pr Zacharias Tanee Fomum',
			'ministry.leader' => 'Notre leader',
			'ministry.leaderSubtitle' => 'Théodore Andoseh',
			'ministry.missionariesEmpty' => 'Les portraits de nos missionnaires arrivent bientôt.',
			'ministry.heroesEmpty' => 'Les portraits de nos héros arrivent bientôt.',
			'ministry.personGone' => 'Ce portrait n\'est plus disponible.',
			'ministry.photoOf' => ({required Object name}) => 'Photo de ${name}',
			'ministry.keyDates' => 'Les grandes dates',
			'ministry.life' => 'Sa vie',
			'ministry.story' => 'Son histoire',
			'ministry.goalOf' => ({required Object n, required Object total}) => 'NOTRE BUT · ${n}/${total}',
			'ministry.previousGoal' => 'But précédent',
			'ministry.nextGoal' => 'But suivant',
			'ministry.media.books' => 'Livres',
			'ministry.media.tracts' => 'Traités',
			'ministry.media.magazines' => 'Magazines',
			'ministry.media.cds' => 'CD',
			'ministry.media.dvds' => 'DVD',
			'ministry.media.radio' => 'Radio',
			'ministry.media.tv' => 'Télévision',
			'ministry.media.internet' => 'Internet',
			'ministry.goals.crusade.title' => 'La toute-créature gospel crusade',
			'ministry.goals.crusade.text' => 'Prêcher l’évangile à chacun de ceux qui vivront dans notre génération de sorte que 10 milliards de personnes soient atteintes avec l’évangile prêché dans la puissance du Saint-Esprit, en utilisant tous les moyens de communication (nos livres, nos traités, nos magazines, nos CD, nos DVD, notre radio, notre télévision et Internet) de la manière la plus urgente possible.',
			'ministry.goals.crusade.reached' => 'personnes atteintes par l’évangile',
			'ministry.goals.disciples.title' => 'La formation des disciples',
			'ministry.goals.disciples.text' => 'Amener 1 milliard de personnes dans 250 nations à connaître Jésus-Christ comme Seigneur et Sauveur et qu’elles soient faites disciples pour lui obéir en toutes choses et organisées pour se réunir dans 25 millions d’églises de maison d’ici l’an 2065.',
			'ministry.goals.disciples.people' => 'disciples',
			'ministry.goals.disciples.nations' => 'nations',
			'ministry.goals.disciples.churches' => 'églises de maison',
			'ministry.goals.disciples.by' => ({required Object year}) => 'd’ici ${year}',
			'ministry.goals.revival.title' => 'Précipiter le réveil global',
			'ministry.goals.revival.text' => 'Coopérer avec Dieu par le jeûne et l’intercession pour le réveil mondial qui va déchirer les cieux, secouer la terre, glorifier Christ dans notre génération pour précipiter le retour imminent de notre Seigneur Jésus-Christ du ciel pour la rencontre avec son Épouse rendue prête.',
			'ministry.goals.revival.fasting' => 'Jeûne',
			'ministry.goals.revival.intercession' => 'Intercession',
			'ministry.goals.revival.pray' => 'Prier maintenant',
			'ministry.lives.founder.name' => 'Pr Zacharias Tanee Fomum',
			'ministry.lives.founder.line' => '1945 – 2009 · Fondateur de la CMCI',
			'ministry.lives.founder.facts.0' => 'fondation de la CMCI',
			'ministry.lives.founder.facts.1' => 'livres écrits',
			'ministry.lives.founder.facts.2' => 'nations visitées',
			'ministry.lives.founder.dates.0' => 'Naît le 20 juin au Cameroun, dans une famille presbytérienne.',
			'ministry.lives.founder.dates.1' => 'Donne sa vie à Jésus-Christ le 13 juin, en lisant un tract.',
			'ministry.lives.founder.dates.2' => 'Se livre tout entier au Seigneur le 1er octobre, en Sierra Leone.',
			'ministry.lives.founder.dates.3' => 'Est rempli du Saint-Esprit le 24 octobre, après sept jours de prière.',
			'ministry.lives.founder.dates.4' => 'Fonde la CMCI à Yaoundé le 12 mai.',
			'ministry.lives.founder.dates.5' => 'Reçoit le doctorat ès sciences de l\'Université de Durham.',
			'ministry.lives.founder.dates.6' => 'Rejoint le Seigneur le 14 mars.',
			'ministry.lives.founder.story.0' => 'Zacharias Tanee Fomum est né le 20 juin 1945 au Cameroun, dans une famille presbytérienne originaire de Batibo, dans le Nord-Ouest. Encore écolier, il a donné sa vie à Jésus-Christ le 13 juin 1956, en lisant un tract intitulé « Quelqu\'un est mort pour toi ».',
			'ministry.lives.founder.story.1' => 'Étudiant à Fourah Bay College, en Sierra Leone, il s\'est livré sans réserve au Seigneur et à son service le 1er octobre 1966. Le 24 octobre 1970, au terme de sept jours de prière et de jeûne, il a été rempli du Saint-Esprit. Dès lors, la prière est devenue le centre de sa vie.',
			'ministry.lives.founder.story.2' => 'Docteur en chimie organique de l\'université Makerere, en Ouganda, il a enseigné à l\'Université de Yaoundé, où il est devenu professeur. Il a dirigé une centaine de thèses et de mémoires, et l\'Université de Durham, en Grande-Bretagne, lui a décerné en 2005 un doctorat ès sciences pour l\'ensemble de ses travaux.',
			'ministry.lives.founder.story.3' => 'Le 12 mai 1975, à Yaoundé, il a fondé la Communauté Missionnaire Chrétienne Internationale : un mouvement pour gagner des âmes, faire des disciples, implanter des églises et envoyer des missionnaires. Il a fait plus de 700 voyages missionnaires au Cameroun et plus de 500 dans plus de 70 nations, sur six continents.',
			'ministry.lives.founder.story.4' => 'Il passait chaque jour de longues heures seul avec Dieu, a conduit de nombreuses croisades, sièges et marches de prière, et a souvent jeûné. Il a écrit plus de 150 livres sur la prière, le jeûne, la sainteté, la formation des disciples et la mission, lus dans de nombreuses langues.',
			'ministry.lives.founder.story.5' => 'Avec son épouse, Prisca Zei Fomum, servante de Dieu auprès des enfants, il a eu sept enfants, tous engagés dans l\'œuvre de l\'Évangile. Ensemble, ils vivaient simplement pour donner à l\'Évangile la plus grande part de leurs revenus.',
			'ministry.lives.founder.story.6' => 'Il est entré dans la présence du Seigneur le 14 mars 2009 et a été inhumé à Yaoundé le 21 mars. L\'œuvre qu\'il a fondée continue dans les nations.',
			'ministry.lives.leader.name' => 'Théodore Andoseh',
			'ministry.lives.leader.line' => 'Leader de la CMCI depuis 2009',
			'ministry.lives.leader.facts.0' => 'églises implantées',
			'ministry.lives.leader.facts.1' => 'ans au Nigeria',
			'ministry.lives.leader.facts.2' => 'à la tête de la CMCI',
			'ministry.lives.leader.dates.0' => 'Donne sa vie à Jésus-Christ sous la prédication du Pr Fomum.',
			'ministry.lives.leader.dates.1' => 'Est consacré évêque à Yaoundé.',
			'ministry.lives.leader.dates.2' => 'Part comme missionnaire au Nigeria avec son épouse, Adela.',
			'ministry.lives.leader.dates.3' => 'Prend la conduite de la CMCI.',
			'ministry.lives.leader.dates.4' => 'Apporte les messages de la 3e convention mondiale à des membres de 93 nations.',
			'ministry.lives.leader.story.0' => 'Théodore Andoseh a donné sa vie à Jésus-Christ en 1978, en écoutant prêcher le Pr Zacharias Tanee Fomum, qui est devenu son père spirituel et l\'a formé comme disciple.',
			'ministry.lives.leader.story.1' => 'Il a d\'abord servi à ses côtés : assistant de laboratoire à l\'Université de Yaoundé, puis son assistant personnel et son secrétaire particulier. Dans ces années, il a publié le premier tract du réveil, « Dieu parle à l\'homme qui veut entendre », et lancé la première chaîne de prière de Yaoundé.',
			'ministry.lives.leader.story.2' => 'Missionnaire national, il a implanté plus de cinquante églises au Cameroun. Il a été consacré évêque à Yaoundé en 1989.',
			'ministry.lives.leader.story.3' => 'En 1994, il est parti comme missionnaire au Nigeria avec son épouse, Adela. Ils y ont servi quatorze ans.',
			'ministry.lives.leader.story.4' => 'Depuis 2009, quand le Pr Fomum est entré dans la présence du Seigneur, il conduit la CMCI dans les nations. En décembre 2019, à Koumé, près de Bertoua, il a apporté les messages de la troisième convention mondiale à des membres venus de 93 nations. Il est aussi l\'auteur de plusieurs livres sur le service de Dieu et l\'édification de l\'Église.',
			'prayer.moments.morning' => 'Matin',
			'prayer.moments.noon' => 'Midi',
			'prayer.moments.evening' => 'Soirée',
			'prayer.moments.night' => 'Nuit',
			'prayer.retreatOf.morning' => 'Retraite du matin',
			'prayer.retreatOf.noon' => 'Retraite de midi',
			'prayer.retreatOf.evening' => 'Retraite du soir',
			'prayer.retreatOf.night' => 'Retraite de la nuit',
			'prayer.hero.now' => ({required Object retreat}) => '${retreat} · maintenant',
			'prayer.hero.title' => '15 minutes\navec le Seigneur',
			'prayer.hero.preview.morning' => 'Rends grâce, consacre ta journée, ton travail, ta famille…',
			'prayer.hero.preview.noon' => 'Ton assemblée, tes dirigeants, 5 personnes de ta liste, les nations…',
			'prayer.hero.preview.evening' => 'Ta vie de prière, ton ministère, tes co-ouvriers…',
			'prayer.hero.preview.night' => 'Les malades, l\'Évangile dans les nations, la protection de la nuit…',
			'prayer.hero.meta' => '15 points · 1 min chacun',
			'prayer.hero.start' => 'Commencer',
			'prayer.hero.allDone' => 'Les 4 retraites du jour sont faites. Que Dieu exauce !',
			'prayer.hero.doneNow' => ({required Object retreat, required Object next}) => '${retreat} faite. Prochaine : ${next}',
			'prayer.today.toPray' => 'À prier',
			'prayer.today.week' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n, zero: 'Aucune retraite cette semaine', one: '${n} retraite cette semaine', other: '${n} retraites cette semaine', ), 
			'prayer.routine.title' => 'Ta routine du jour',
			'prayer.routine.count' => ({required Object done}) => '${done} sur 4',
			'prayer.routine.days' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n, one: '${n} jour sur 7', other: '${n} jours sur 7', ), 
			'prayer.routine.week' => ({required Object time}) => '${time} cette semaine',
			'prayer.routine.done' => 'Faite · 15 min',
			'prayer.routine.now' => 'Maintenant · 15 min',
			'prayer.routine.next' => 'À suivre · 15 min',
			'prayer.routine.reminder' => ({required Object time}) => 'Rappel à ${time}',
			'prayer.routine.later.morning' => 'Le matin · 15 min',
			'prayer.routine.later.noon' => 'À midi · 15 min',
			'prayer.routine.later.evening' => 'En soirée · 15 min',
			'prayer.routine.later.night' => 'La nuit · 15 min',
			'prayer.together' => 'Prier ensemble',
			'prayer.reminders.title' => 'Rappels des retraites',
			'prayer.reminders.intro' => 'Un rappel à l\'heure de chaque retraite, seulement si elle n\'est pas encore faite.',
			'prayer.reminders.off' => 'Désactivé',
			'prayer.reminders.channel' => 'Retraites de prière',
			'prayer.reminders.body' => '15 minutes avec le Seigneur.',
			'prayer.retreat.title' => 'Retraites de 15 minutes',
			'prayer.retreat.hours.morning' => 'Au réveil',
			'prayer.retreat.hours.noon' => 'Entre 12 h et 14 h',
			'prayer.retreat.hours.evening' => 'En fin d\'après-midi',
			'prayer.retreat.hours.night' => 'Avant de dormir',
			'prayer.retreat.reminderAt' => ({required Object time}) => 'rappel à ${time}',
			'prayer.retreat.intro' => '15 points, une minute chacun. Un son doux te fait passer au suivant.',
			'prayer.retreat.done' => 'Faite aujourd\'hui',
			'prayer.retreat.start' => 'Commencer · 15 min',
			'prayer.retreat.selfPaced' => 'Lire à mon rythme, sans minuteur',
			'prayer.retreat.hints.assembly' => ({required Object name}) => 'Ton assemblée : ${name}',
			'prayer.retreat.hints.assemblyMissing' => 'Ajoute ton assemblée dans ton profil',
			'prayer.retreat.hints.authorities' => ({required Object names}) => 'Tes autorités : ${names}',
			'prayer.retreat.hints.authoritiesMissing' => 'Ajoute tes autorités spirituelles dans Plus',
			'prayer.retreat.hints.list' => ({required Object list}) => 'Mes listes · ${list}',
			'prayer.retreat.hints.listEmpty' => ({required Object list}) => 'Ta liste « ${list} » est vide : ajoute des noms',
			'prayer.retreat.hints.nation' => ({required Object name}) => 'Aujourd\'hui : ${name}',
			'prayer.retreat.hints.myCountry' => ({required Object name}) => 'Ton pays : ${name}',
			'prayer.retreat.hints.hymn' => 'Ouvrir les cantiques',
			'prayer.session.point' => ({required Object n}) => 'Point ${n} sur 15',
			'prayer.session.remaining' => 'restantes',
			'prayer.session.paused' => 'en pause',
			'prayer.session.inYourList' => ({required Object list}) => 'Dans ta liste · ${list}',
			'prayer.session.tomorrow' => 'Demain, les suivants.',
			'prayer.session.footer' => 'Écran allumé · un son doux à chaque minute',
			'prayer.session.previous' => 'Point précédent',
			'prayer.session.next' => 'Point suivant',
			'prayer.session.pause' => 'Pause',
			'prayer.session.resume' => 'Reprendre',
			'prayer.session.soundOn' => 'Son activé',
			'prayer.session.soundOff' => 'Son coupé',
			'prayer.session.finish' => 'Terminer la retraite',
			'prayer.session.quitTitle' => 'Arrêter la retraite ?',
			'prayer.session.quitText' => 'Elle ne sera pas comptée dans ta journée.',
			'prayer.session.quit' => 'Arrêter',
			'prayer.session.keepPraying' => 'Continuer',
			'prayer.done.title' => ({required Object retreat}) => '${retreat} terminée',
			'prayer.done.text' => '15 minutes avec le Seigneur.\nIl a entendu chacune de tes prières.',
			'prayer.done.report' => 'Ajouté à ton compte rendu',
			'prayer.done.reportDetail' => ({required Object added, required Object total}) => 'Prière seule : +${added} min · ${total} min aujourd\'hui',
			'prayer.done.undo' => 'Annuler',
			'prayer.done.undone' => 'Retraite retirée de ta journée.',
			'prayer.done.today' => 'Aujourd\'hui',
			'prayer.done.count' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n, one: '${n} retraite sur 4', other: '${n} retraites sur 4', ), 
			'prayer.done.verse' => '« Priez sans cesse. »',
			'prayer.done.reference' => '1 Thessaloniciens 5.17',
			'prayer.done.finish' => 'Terminer',
			'prayer.done.hymn' => 'Chanter un cantique',
			'prayer.topics.title' => 'Sujets de la communauté',
			'prayer.topics.all' => 'Tout voir',
			'prayer.topics.empty' => 'Aucun sujet en ce moment. Les responsables publieront les prochains ici.',
			'prayer.topics.categories.church' => 'Église',
			'prayer.topics.categories.nations' => 'Nations',
			'prayer.topics.categories.sick' => 'Malades',
			'prayer.topics.categories.event' => 'Évènement',
			'prayer.topics.categories.fasting' => 'Jeûne',
			'prayer.topics.categories.other' => 'Sujet',
			'prayer.topics.until' => ({required Object date}) => 'jusqu\'au ${date}',
			'prayer.topics.archive' => 'Sujets passés',
			'prayer.topics.archiveEmpty' => 'Aucun sujet passé.',
			'prayer.topics.current' => 'En ce moment',
			'prayer.topics.documentSize' => ({required Object kb}) => '${kb} Ko',
			'prayer.topics.download' => 'Télécharger le PDF',
			'prayer.topics.noDocument' => 'Pas de PDF',
			'prayer.topics.openDocument' => 'Ouvrir le PDF',
			'prayer.lists.title' => 'Mes listes de prière',
			'prayer.lists.private' => 'Pour toi seul',
			'prayer.lists.names.unbelievers' => 'Pas encore cru',
			'prayer.lists.names.believers' => 'Croyants',
			'prayer.lists.names.backsliders' => 'Rétrogrades',
			'prayer.lists.names.coworkers' => 'Co-ouvriers',
			'prayer.lists.uses.unbelievers' => 'La retraite de midi prie chaque jour pour 10 personnes de cette liste (5 + 5), à tour de rôle.',
			'prayer.lists.uses.believers' => 'La retraite de midi prie chaque jour pour 5 personnes de cette liste, à tour de rôle.',
			'prayer.lists.uses.backsliders' => 'La retraite de midi prie chaque jour pour 5 personnes de cette liste, à tour de rôle.',
			'prayer.lists.uses.coworkers' => 'La retraite du soir prie chaque jour pour 10 de tes co-ouvriers (5 + 5), à tour de rôle.',
			'prayer.lists.privateNote' => 'Elle n\'est visible que par toi.',
			'prayer.lists.count' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n, zero: 'Personne', one: '${n} personne', other: '${n} personnes', ), 
			_ => null,
		} ?? switch (path) {
			'prayer.lists.empty' => 'Personne pour l\'instant. Ajoute ceux pour qui tu pries.',
			'prayer.lists.add' => 'Ajouter une personne',
			'prayer.lists.prayedToday' => 'Aujourd\'hui',
			'prayer.lists.next' => 'Prochainement',
			'prayer.lists.answeredTitle.unbelievers' => 'Ont cru au Seigneur',
			'prayer.lists.answeredTitle.believers' => 'Prières exaucées',
			'prayer.lists.answeredTitle.backsliders' => 'Sont revenus au Seigneur',
			'prayer.lists.answeredTitle.coworkers' => 'Prières exaucées',
			'prayer.lists.answeredOn.unbelievers' => ({required Object date}) => 'A cru au Seigneur le ${date}',
			'prayer.lists.answeredOn.believers' => ({required Object date}) => 'Exaucé le ${date}',
			'prayer.lists.answeredOn.backsliders' => ({required Object date}) => 'Est revenu le ${date}',
			'prayer.lists.answeredOn.coworkers' => ({required Object date}) => 'Exaucé le ${date}',
			'prayer.lists.markAnswered.unbelievers' => 'A cru au Seigneur !',
			'prayer.lists.markAnswered.believers' => 'Prière exaucée',
			'prayer.lists.markAnswered.backsliders' => 'Est revenu au Seigneur !',
			'prayer.lists.markAnswered.coworkers' => 'Prière exaucée',
			'prayer.lists.answeredToast' => 'Gloire à Dieu !',
			'prayer.lists.putBack' => 'Remettre dans la liste',
			'prayer.lists.answeredBanner' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n, one: '${n} prière exaucée ce mois-ci', other: '${n} prières exaucées ce mois-ci', ), 
			'prayer.lists.lastAnswered' => ({required Object name, required Object what}) => '${name} : ${what}',
			'prayer.lists.sheet.addTitle' => 'Ajouter une personne',
			'prayer.lists.sheet.editTitle' => 'Modifier',
			'prayer.lists.sheet.name' => 'Nom',
			'prayer.lists.sheet.namePlaceholder' => 'Paul M.',
			'prayer.lists.sheet.note' => 'Note',
			'prayer.lists.sheet.notePlaceholder' => 'Collègue, voisin, cousine…',
			'prayer.lists.sheet.list' => 'Liste',
			'prayer.lists.sheet.save' => 'Enregistrer',
			'prayer.lists.sheet.remove' => 'Retirer de la liste',
			'prayer.lists.sheet.removeTitle' => ({required Object name}) => 'Retirer ${name} ?',
			'prayer.lists.sheet.removeText' => 'Tu ne prieras plus pour cette personne dans tes retraites.',
			'prayer.lists.addShort' => 'Ajouter',
			'prayer.importunity.title' => 'Sujets d\'importunité',
			'prayer.importunity.newTopic' => 'Nouveau sujet',
			'prayer.importunity.intro' => 'Un sujet que l\'on présente au Seigneur sans se lasser, jusqu\'à la réponse. Fixe un nombre de proclamations et invite tes frères et sœurs à prier avec toi.',
			'prayer.importunity.invitedBy' => ({required Object name}) => '${name} t\'invite à prier',
			'prayer.importunity.join' => 'Je prie avec vous',
			'prayer.importunity.decline' => 'Pas maintenant',
			'prayer.importunity.joined' => 'Tu pries maintenant pour ce sujet.',
			'prayer.importunity.progress' => ({required Object total, required Object goal}) => '${total} sur ${goal}',
			'prayer.importunity.total' => ({required num n, required Object count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n, one: '${count} proclamation', other: '${count} proclamations', ), 
			'prayer.importunity.reached' => 'Objectif atteint !',
			'prayer.importunity.closed' => 'Clos',
			'prayer.importunity.participants' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n, one: '${n} prie', other: '${n} prient', ), 
			'prayer.importunity.mine' => ({required Object n}) => 'Toi : ${n}',
			'prayer.importunity.tapHint' => 'Touche à chaque proclamation',
			'prayer.importunity.addMany' => 'Ajouter un nombre',
			'prayer.importunity.addManyTitle' => 'Combien de proclamations ?',
			'prayer.importunity.addManyLabel' => 'Proclamations',
			'prayer.importunity.add' => 'Ajouter',
			'prayer.importunity.pending' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n, one: '${n} en attente d\'envoi', other: '${n} en attente d\'envoi', ), 
			'prayer.importunity.invite' => 'Inviter',
			'prayer.importunity.members' => 'Ceux qui prient',
			'prayer.importunity.waiting' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n, one: '${n} invitation en attente', other: '${n} invitations en attente', ), 
			'prayer.importunity.edit' => 'Modifier',
			'prayer.importunity.close' => 'Clore le sujet',
			'prayer.importunity.reopen' => 'Rouvrir le sujet',
			'prayer.importunity.delete' => 'Supprimer le sujet',
			'prayer.importunity.deleteTitle' => 'Supprimer ce sujet ?',
			'prayer.importunity.deleteText' => 'Il disparaît pour tous ceux qui prient avec toi.',
			'prayer.importunity.leave' => 'Quitter ce sujet',
			'prayer.importunity.leaveTitle' => 'Quitter ce sujet ?',
			'prayer.importunity.leaveText' => 'Tes proclamations restent dans le total.',
			'prayer.importunity.form.newTitle' => 'Nouveau sujet d\'importunité',
			'prayer.importunity.form.editTitle' => 'Modifier le sujet',
			'prayer.importunity.form.subject' => 'Sujet',
			'prayer.importunity.form.subjectPlaceholder' => 'Seigneur, sauve Paul',
			'prayer.importunity.form.description' => 'Détails',
			'prayer.importunity.form.descriptionPlaceholder' => 'Pour qui, pourquoi…',
			'prayer.importunity.form.goal' => 'Objectif',
			'prayer.importunity.form.goalHint' => 'Le nombre de proclamations à atteindre ensemble. Laisse vide pour compter sans objectif.',
			'prayer.importunity.form.goalPlaceholder' => '10 000',
			'prayer.importunity.form.create' => 'Créer',
			'prayer.importunity.form.save' => 'Enregistrer',
			'prayer.importunity.inviteSheet.title' => 'Inviter à prier',
			'prayer.importunity.inviteSheet.family' => 'Ma famille spirituelle',
			'prayer.importunity.inviteSheet.familyText' => ({required num n, required Object name}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n, one: '${name} et ses disciples : ${n} personne', other: '${name} et ses disciples : ${n} personnes', ), 
			'prayer.importunity.inviteSheet.familyMissing' => 'Lie ton faiseur de disciples (FD) dans Mes autorités spirituelles pour inviter ta famille spirituelle.',
			'prayer.importunity.inviteSheet.byUsername' => 'Par pseudo',
			'prayer.importunity.inviteSheet.usernameLabel' => 'Pseudo',
			'prayer.importunity.inviteSheet.addUsername' => 'Ajouter',
			'prayer.importunity.inviteSheet.send' => 'Envoyer les invitations',
			'prayer.importunity.inviteSheet.sent' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n, zero: 'Ils étaient déjà invités.', one: '${n} invitation envoyée', other: '${n} invitations envoyées', ), 
			'prayer.importunity.eyebrow' => 'Sujet d\'importunité',
			'prayer.importunity.proclaim' => 'Proclamer',
			'sending.title' => 'Envoi à mes autorités',
			'sending.moreOff' => 'Désactivé',
			'sending.intro' => 'Au moment choisi, CMFI Connect prépare ton compte rendu de la période. Tu n\'as plus qu\'à l\'envoyer à tes autorités spirituelles.',
			'sending.enabled' => 'Me le préparer régulièrement',
			'sending.rhythm' => 'Rythme',
			'sending.weekly' => 'Chaque semaine',
			'sending.biweekly' => 'Toutes les 2 semaines',
			'sending.monthly' => 'Chaque mois',
			'sending.day' => 'Jour',
			'sending.monthlyDay' => 'Le 1er de chaque mois, pour le mois écoulé',
			'sending.time' => 'Heure',
			'sending.recipients' => 'Destinataires',
			'sending.noAuthorities' => 'Ajoute d\'abord tes autorités spirituelles.',
			'sending.addAuthorities' => 'Ajouter mes autorités',
			'sending.viaWhatsApp' => 'Par WhatsApp',
			'sending.viaEmail' => 'Par e-mail',
			'sending.viaBoth' => 'Par WhatsApp ou e-mail',
			'sending.viaShare' => 'Par le partage',
			'sending.next' => ({required Object date}) => 'Prochain : ${date}',
			'sending.prepareNow' => 'Préparer maintenant',
			'sending.history' => 'Derniers envois',
			'sending.notificationTitle' => 'Ton compte rendu est prêt',
			'sending.notificationBody' => 'Envoie-le à tes autorités en un geste.',
			'sending.channel' => 'Envoi du compte rendu',
			'sending.readyTitle' => 'Ton compte rendu est prêt',
			'sending.preview' => 'Aperçu du message',
			'sending.greeting' => ({required Object name}) => 'Bonjour ${name},',
			'sending.whatsApp' => 'WhatsApp',
			'sending.email' => 'E-mail',
			'sending.sharePdf' => 'Partager le PDF',
			'sending.shareText' => 'Partager le texte',
			'sending.sent' => 'Envoyé',
			'sending.shared' => 'Partage',
			'sending.noRecipients' => 'Choisis tes destinataires dans les réglages, ou partage le PDF.',
			'sending.settings' => 'Réglages',
			'sending.permissionDenied' => 'Autorise les notifications pour être prévenu au bon moment.',
			'streak.title' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n, one: '${n} jour d\'affilée !', other: '${n} jours d\'affilée !', ), 
			'streak.cardDays' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n, one: 'jour avec Dieu', other: 'jours avec Dieu', ), 
			'streak.lines.week' => 'Une semaine entière avec le Seigneur, jour après jour. Bravo, continue !',
			'streak.lines.month' => 'Un mois de fidélité ! Ce que tu sèmes chaque jour porte du fruit.',
			'streak.lines.hundred' => 'Cent jours avec Dieu ! Ta persévérance est un beau témoignage.',
			'streak.lines.year' => 'Une année entière avec Dieu ! Gloire à Lui pour ta fidélité.',
			'streak.share' => 'Partager',
			'streak.close' => 'Continuer',
			'shortcuts.today' => 'Remplir mon compte rendu',
			'shortcuts.hymns' => 'Cantiques',
			'shortcuts.retreat' => 'Retraite du moment',
			'blocking.report' => 'Signaler',
			'blocking.block' => ({required Object name}) => 'Bloquer ${name}',
			'blocking.blockTitle' => ({required Object name}) => 'Bloquer ${name} ?',
			'blocking.blockText' => ({required Object name}) => 'Tu ne recevras plus d\'invitation de ${name}. Cette invitation est retirée.',
			'blocking.blockAction' => 'Bloquer',
			'blocking.blocked' => ({required Object name}) => '${name} ne pourra plus t\'inviter.',
			'blocking.reportTitle' => 'Signaler cette invitation',
			'blocking.reportText' => 'Dis-nous ce qui ne va pas : les responsables de la communauté regarderont.',
			'blocking.reasons.spam' => 'Indésirable',
			'blocking.reasons.offensive' => 'Contenu choquant ou offensant',
			'blocking.reasons.other' => 'Autre',
			'blocking.comment' => 'Commentaire',
			'blocking.commentHint' => 'Ce que les responsables doivent savoir',
			'blocking.send' => 'Envoyer le signalement',
			'blocking.reported' => 'Merci, les responsables vont regarder.',
			'blocking.listTitle' => 'Membres bloqués',
			'blocking.intro' => 'Leurs invitations à prier ne t\'arrivent plus.',
			'blocking.empty' => 'Tu n\'as bloqué personne.',
			'blocking.unblock' => 'Débloquer',
			'blocking.unblocked' => ({required Object name}) => '${name} peut de nouveau t\'inviter.',
			'verses.title' => 'Verset du jour',
			'verses.share' => 'Partager le verset',
			'verses.shareImage' => 'Partager l\'image',
			'verses.shareText' => 'Partager le texte',
			'bible.title' => 'Bible',
			'bible.books' => 'Livres',
			'bible.oldTestament' => 'Ancien Testament',
			'bible.newTestament' => 'Nouveau Testament',
			'bible.chapters' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n, one: '${n} chapitre', other: '${n} chapitres', ), 
			'bible.chapter' => ({required Object n}) => 'Chapitre ${n}',
			'bible.version' => 'Version',
			'bible.versions' => 'Version de la Bible',
			'bible.search' => 'Rechercher dans la Bible',
			'bible.searchHint' => 'Un mot, ou « Jean 3:16 »',
			'bible.searchTip' => 'Cherche un mot (« amour ») ou va directement à un passage (« Psaume 23 », « Jean 3:16 »).',
			'bible.searchNone' => 'Aucun verset ne contient ces mots.',
			'bible.searchCount' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n, one: '${n} verset', other: '${n} versets', ), 
			'bible.searchLimit' => ({required Object n}) => 'Les ${n} premiers versets',
			'bible.searchNeedsDownload' => 'Pour chercher des mots dans toute la Bible, télécharge-la. Tu peux déjà taper un passage : « Jean 3:16 ».',
			'bible.open' => ({required Object reference}) => 'Ouvrir ${reference}',
			'bible.previous' => 'Chapitre précédent',
			'bible.next' => 'Chapitre suivant',
			'bible.markRead' => 'J\'ai lu ce chapitre',
			'bible.markedRead' => 'Lu aujourd\'hui',
			'bible.markReadHint' => 'Ajoute 1 chapitre à « Lecture biblique » dans ton compte rendu.',
			'bible.addedToReport' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n, one: 'Compte rendu : ${n} chapitre lu aujourd\'hui', other: 'Compte rendu : ${n} chapitres lus aujourd\'hui', ), 
			'bible.removedFromReport' => 'Retiré de ton compte rendu',
			'bible.noReadingItem' => 'Ton compte rendu n\'a pas d\'élément « Lecture biblique ».',
			'bible.download' => 'Télécharger cette Bible',
			'bible.downloadHelp' => ({required Object size}) => 'Environ ${size} Mo, pour lire et chercher sans réseau.',
			'bible.downloading' => ({required Object percent}) => 'Téléchargement… ${percent} %',
			'bible.downloaded' => 'Sur ton téléphone',
			'bible.downloadDone' => ({required Object version}) => '${version} est sur ton téléphone',
			'bible.removeDownload' => 'Retirer du téléphone',
			'bible.removeDownloadTitle' => ({required Object version}) => 'Retirer ${version} du téléphone ?',
			'bible.removeDownloadText' => 'Les chapitres que tu as déjà lus restent disponibles sans réseau.',
			'bible.offline' => 'Ce chapitre n\'est pas encore sur ton téléphone. Reconnecte-toi, ou télécharge cette Bible pour la lire sans réseau.',
			'bible.notInVersion' => 'Ce passage n\'est pas dans cette version.',
			'bible.marks' => 'Mes versets',
			'bible.favorites' => 'Favoris',
			'bible.highlights' => 'Surlignés',
			'bible.noFavorites' => 'Touche un verset, puis le marque-page, pour le retrouver ici.',
			'bible.noHighlights' => 'Touche un verset, puis une couleur, pour le surligner.',
			'bible.tapHint' => 'Touche un verset pour le surligner, le garder, le copier ou le partager.',
			'bible.highlight' => ({required Object color}) => 'Surligner en ${color}',
			'bible.colors.yellow' => 'jaune',
			'bible.colors.green' => 'vert',
			'bible.colors.blue' => 'bleu',
			'bible.colors.pink' => 'rose',
			'bible.removeHighlight' => 'Retirer la couleur',
			'bible.addFavorite' => 'Ajouter à Mes versets',
			'bible.removeFavorite' => 'Retirer de Mes versets',
			'bible.favoriteAdded' => 'Ajouté à Mes versets',
			'bible.favoriteRemoved' => 'Retiré de Mes versets',
			'bible.copy' => 'Copier',
			'bible.copied' => 'Copié',
			'bible.share' => 'Partager',
			'bible.closeSelection' => 'Fermer la sélection',
			'bible.display' => 'Affichage',
			'bible.jesusInRed' => 'Paroles de Jésus en rouge',
			'bible.jesusInRedHelp' => 'Dans les versions qui les indiquent',
			'bible.remove' => 'Retirer',
			'bible.readInBible' => 'Lire dans la Bible',
			'bible.concordance' => 'Concordance',
			'bible.concordanceOf' => ({required Object word}) => 'Concordance de « ${word} »',
			'bible.concordanceHint' => 'Un mot de la Bible',
			'bible.concordanceTip' => 'Tape un mot : la concordance montre tous les versets où il apparaît, livre par livre.',
			'bible.concordanceNeedsDownload' => 'La concordance parcourt toute la Bible : télécharge-la d\'abord.',
			'bible.concordanceNone' => 'Ce mot n\'est pas dans cette Bible.',
			'bible.exactWord' => 'Ce mot',
			'bible.startsWith' => 'Commence par…',
			'bible.occurrences' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n, one: 'occurrence', other: 'occurrences', ), 
			'bible.inVerses' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n, one: 'dans ${n} verset', other: 'dans ${n} versets', ), 
			'bible.spread' => 'Où ce mot apparaît',
			'bible.forms' => 'Formes trouvées',
			'bible.bookCount' => ({required Object book, required Object n}) => '${book} : ${n}',
			'bible.allBooks' => 'Tous les livres',
			'bible.pickWord' => 'Choisis un mot',
			'bible.pickWordHelp' => 'La concordance montre tous les versets où il apparaît.',
			'bible.more' => 'Plus d\'options',
			'profilePhoto.title' => 'Photo de profil',
			'profilePhoto.add' => 'Ajouter une photo de profil',
			'profilePhoto.change' => 'Changer la photo de profil',
			'profilePhoto.seenBy' => 'Les autres membres la voient là où ton nom apparaît.',
			'profilePhoto.camera' => 'Prendre une photo',
			'profilePhoto.gallery' => 'Choisir dans la galerie',
			'profilePhoto.remove' => 'Retirer la photo',
			'profilePhoto.cropTitle' => 'Recadre ta photo',
			'profilePhoto.cropHint' => 'Déplace et agrandis la photo avec tes doigts.',
			'profilePhoto.use' => 'Utiliser cette photo',
			'profilePhoto.unreadable' => 'Impossible d\'ouvrir cette image. Choisis-en une autre.',
			'profilePhoto.saved' => 'Ta photo de profil est enregistrée.',
			'profilePhoto.removed' => 'Ta photo de profil est retirée.',
			'disciples.title' => 'Mes disciples',
			'disciples.empty' => 'Pas encore de disciple',
			'disciples.emptyText' => 'Quand un membre te choisit comme faiseur de disciples ou comme autorité et que tu acceptes sa demande, il apparaît ici.',
			'disciples.count' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n, one: '${n} disciple', other: '${n} disciples', ), 
			'disciples.notShared' => 'Ne partage pas ses comptes rendus',
			'disciples.roleMaker' => 'Tu es son faiseur de disciples',
			'disciples.roleAuthority' => 'Tu es l\'une de ses autorités',
			'disciples.dayGoals' => ({required Object percent}) => 'Objectifs ${percent} %',
			'disciples.dayItems' => ({required Object filled, required Object total, required Object percent}) => '${filled} sur ${total} éléments · ${percent} %',
			'disciples.older' => 'Voir les 30 jours précédents',
			'disciples.noReports' => 'Pas de compte rendu sur cette période.',
			'disciples.searchHint' => 'Nom ou pseudo',
			'disciples.noMatch' => ({required Object search}) => 'Aucun disciple ne correspond à « ${search} ».',
			'weekStory.title' => 'Ta semaine avec Dieu',
			'weekStory.range' => ({required Object from, required Object to}) => 'Du ${from} au ${to}',
			'weekStory.intro' => 'Revois ce que tu as vécu avec le Seigneur cette semaine.',
			'weekStory.tapHint' => 'Touche à droite pour avancer, à gauche pour revenir.',
			'weekStory.faithfulLead' => 'Tu as été fidèle',
			'weekStory.emptyLead' => 'Une nouvelle semaine t\'attend',
			'weekStory.days' => ({required num n, required Object total}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n, one: '${n} jour\nsur ${total}', other: '${n} jours\nsur ${total}', ), 
			'weekStory.streak' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n, one: '${n} jour d\'affilée', other: '${n} jours d\'affilée', ), 
			'weekStory.streakRecord' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n, one: '${n} jour d\'affilée : ton record !', other: '${n} jours d\'affilée : ton record !', ), 
			'weekStory.emptyText' => 'Remplis ton compte rendu chaque jour : ta prochaine semaine s\'écrira ici.',
			'weekStory.prayerLead' => 'Tu as prié',
			'weekStory.retreats' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n, one: '${n} retraite', other: '${n} retraites', ), 
			'weekStory.retreatsTime' => ({required Object time}) => 'de 15 minutes · ${time} avec le Seigneur',
			'weekStory.faithfulMoment' => ({required num n, required Object moment}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n, one: 'Ton moment le plus fidèle : ${moment} (${n} fois)', other: 'Ton moment le plus fidèle : ${moment} (${n} fois)', ), 
			'weekStory.noRetreat' => 'Pas de retraite cette semaine',
			'weekStory.noRetreatText' => 'La retraite de midi t\'attend : 15 minutes avec le Seigneur.',
			'weekStory.goalsLead' => 'Tes objectifs',
			'weekStory.goalsReached' => 'atteints en moyenne',
			'weekStory.bestDay' => ({required Object day, required Object percent}) => 'Ton meilleur jour : ${day} · ${percent}',
			'weekStory.summaryTitle' => 'Ma semaine avec Dieu',
			'weekStory.statDays' => 'jours remplis',
			'weekStory.statStreak' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n, one: 'jour d\'affilée', other: 'jours d\'affilée', ), 
			'weekStory.statRetreats' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n, one: 'retraite', other: 'retraites', ), 
			'weekStory.statGoals' => 'd\'objectifs',
			'weekStory.share' => 'Partager ma semaine',
			'weekStory.homeText' => 'Ta fidélité, ta prière et tes objectifs de la semaine.',
			'weekStory.open' => 'Voir ma semaine',
			'weekStory.notificationTitle' => 'Ta semaine avec Dieu est prête',
			'weekStory.notificationBody' => 'Revois ta fidélité de la semaine et partage-la.',
			'weekStory.channel' => 'Ta semaine avec Dieu',
			'weekStory.thisWeek' => 'Cette semaine',
			'weekStory.pastWeeks' => 'Semaines passées',
			'weekStory.weekOf' => ({required Object date}) => 'Semaine du ${date}',
			'weekStory.page' => ({required Object current, required Object total}) => '${current} sur ${total}',
			'seekFirst.title' => 'Cherche d\'abord Dieu',
			'seekFirst.verse' => 'Cherchez premièrement le royaume et la justice de Dieu ; et toutes ces choses vous seront données par-dessus.',
			'seekFirst.verseRef' => 'Matthieu 6:33',
			'seekFirst.intro' => 'Chaque jour, les apps que tu choisis restent fermées tant que ton compte rendu n\'est pas enregistré. Commence ta journée avec Dieu, le reste suit.',
			'seekFirst.enable' => 'Activer',
			'seekFirst.apps' => 'Apps à garder fermées',
			'seekFirst.appsNone' => 'Aucune app choisie',
			'seekFirst.appCount' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n, one: '${n} app', other: '${n} apps', ), 
			'seekFirst.categoryCount' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n, one: '${n} catégorie', other: '${n} catégories', ), 
			'seekFirst.siteCount' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n, one: '${n} site', other: '${n} sites', ), 
			'seekFirst.start' => 'Fermées à partir de',
			'seekFirst.pauses' => 'Pauses de 5 minutes',
			'seekFirst.pausesText' => '3 par jour, pour une urgence',
			'seekFirst.pausesLeft' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n, zero: 'Plus de pause aujourd\'hui', one: 'Encore ${n} pause aujourd\'hui', other: 'Encore ${n} pauses aujourd\'hui', ), 
			'seekFirst.todayOpen' => 'Aujourd\'hui, tes apps sont ouvertes : tu as cherché Dieu d\'abord.',
			'seekFirst.todayLocked' => 'Tes apps restent fermées jusqu\'à ton compte rendu d\'aujourd\'hui.',
			'seekFirst.todayBefore' => ({required Object time}) => 'Tes apps se fermeront à ${time} si ton compte rendu n\'est pas encore enregistré.',
			'seekFirst.fillReport' => 'Remplir mon compte rendu',
			'seekFirst.denied' => 'Sans l\'accès à Temps d\'écran, CMFI Connect ne peut pas fermer d\'apps. Tu peux l\'autoriser dans Réglages › Temps d\'écran.',
			'seekFirst.noApps' => 'Choisis au moins une app à garder fermée.',
			'seekFirst.unsupported' => 'Bientôt disponible sur ce téléphone.',
			'seekFirst.moreOn' => ({required Object time}) => 'Dès ${time}, jusqu\'à ton compte rendu',
			'seekFirst.moreOff' => 'Fermer des apps tant que ton compte rendu n\'est pas fait',
			'seekFirst.privacy' => 'CMFI Connect ne voit jamais les apps que tu choisis : ton iPhone les garde pour lui.',
			'seekFirst.shield.title' => 'Cherche d\'abord Dieu',
			'seekFirst.shield.subtitle' => ({required Object app}) => '${app} reste fermée jusqu\'à ton compte rendu d\'aujourd\'hui.',
			'seekFirst.shield.thisApp' => 'Cette app',
			'seekFirst.shield.fill' => 'Remplir mon compte rendu',
			'seekFirst.shield.pause' => ({required Object n}) => 'Pause de 5 min (${n}/3)',
			'seekFirst.shield.notificationTitle' => 'Cherche d\'abord Dieu',
			'seekFirst.shield.notificationBody' => 'Touche ici pour remplir ton compte rendu.',
			'documents.title' => 'Nos documents',
			'documents.subtitle' => 'Enseignements, règlements, formulaires…',
			'documents.moreSubtitle' => 'La bibliothèque de la communauté',
			'documents.search' => 'Rechercher un document',
			'documents.all' => 'Tous',
			'documents.empty' => 'Aucun document pour l\'instant. Les documents publiés par la communauté apparaîtront ici.',
			'documents.none' => 'Aucun document ne correspond à ta recherche.',
			'documents.sizeKb' => ({required Object n}) => '${n} Ko',
			'documents.sizeMb' => ({required Object n}) => '${n} Mo',
			'documents.pdf' => 'PDF',
			'documents.word' => 'Word',
			'documents.open' => 'Ouvrir le document',
			'documents.download' => 'Télécharger',
			'documents.count' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n, one: '${n} document', other: '${n} documents', ), 
			'documents.more' => 'Voir plus',
			'biblePlan.title' => 'Plan de lecture',
			'biblePlan.intro' => 'Choisis ce que tu veux lire et en combien de temps : l\'app répartit les chapitres jour après jour.',
			'biblePlan.duration' => 'Durée',
			'biblePlan.months3' => '3 mois',
			'biblePlan.months6' => '6 mois',
			'biblePlan.year' => '1 an',
			'biblePlan.custom' => 'Autre',
			'biblePlan.days' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n, one: '${n} jour', other: '${n} jours', ), 
			'biblePlan.scope' => 'Ce que tu lis',
			'biblePlan.scopes.bible' => 'Toute la Bible',
			'biblePlan.scopes.newTestament' => 'Le Nouveau Testament',
			'biblePlan.scopes.oldTestament' => 'L\'Ancien Testament',
			'biblePlan.scopes.psalmsProverbs' => 'Psaumes et Proverbes',
			'biblePlan.order' => 'Ordre',
			'biblePlan.orders.canonical' => 'Livre après livre',
			'biblePlan.orders.parallel' => 'AT + NT chaque jour',
			'biblePlan.reminder' => 'Rappel chaque jour',
			'biblePlan.reminderAt' => 'Heure du rappel',
			'biblePlan.summary' => ({required Object chapters, required Object days, required Object perDay}) => '${chapters} chapitres en ${days} jours, environ ${perDay} par jour',
			'biblePlan.endsOn' => ({required Object date}) => 'Fin le ${date}',
			'biblePlan.startsOn' => ({required Object date}) => 'Le plan commence le ${date}.',
			'biblePlan.start' => 'Commencer le plan',
			'biblePlan.dayOf' => ({required Object day, required Object total}) => 'Jour ${day} sur ${total}',
			'biblePlan.today' => 'Lecture du jour',
			'biblePlan.todayDone' => 'Lecture du jour faite. Bravo !',
			'biblePlan.read' => 'Lire',
			'biblePlan.behind' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n, one: '${n} jour de retard', other: '${n} jours de retard', ), 
			'biblePlan.catchUp' => 'Touche ici pour voir les chapitres à rattraper.',
			'biblePlan.chaptersRead' => ({required Object read, required Object total}) => '${read} chapitres sur ${total}',
			'biblePlan.late' => 'En retard',
			'biblePlan.upcoming' => 'À venir',
			'biblePlan.dayNumber' => ({required Object n}) => 'Jour ${n}',
			'biblePlan.finished' => 'Plan terminé ! Tu as tout lu.',
			'biblePlan.stop' => 'Arrêter le plan',
			'biblePlan.stopTitle' => 'Arrêter ce plan ?',
			'biblePlan.stopText' => 'Ta progression dans ce plan sera effacée. Les chapitres comptés dans tes comptes rendus y restent.',
			'biblePlan.reminderTitle' => 'Ta lecture du jour',
			'biblePlan.reminderChannel' => 'Plan de lecture',
			'biblePlan.homeTitle' => 'Lecture du jour',
			'biblePlan.check' => ({required Object chapter}) => 'Marquer ${chapter} comme lu',
			'biblePlan.uncheck' => ({required Object chapter}) => '${chapter} : lu',
			'teachings.title' => 'Enseignements',
			'teachings.subtitle' => 'Écoute la Parole, où que tu sois',
			'teachings.search' => 'Chercher un message, un orateur…',
			'teachings.all' => 'Tous',
			'teachings.downloadedChip' => 'Téléchargés',
			'teachings.count' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n, one: '${n} message', other: '${n} messages', ), 
			'teachings.empty' => 'Aucun enseignement pour l\'instant.',
			'teachings.none' => 'Aucun enseignement ne correspond.',
			'teachings.noneDownloaded' => 'Aucun message téléchargé. Touche le nuage d\'un message pour l\'écouter sans réseau.',
			'teachings.more' => 'Voir plus',
			'teachings.offline' => 'Sans réseau : voici les messages gardés sur ton téléphone.',
			'teachings.play' => 'Écouter',
			'teachings.pause' => 'Pause',
			'teachings.heard' => 'Écouté',
			'teachings.download' => 'Télécharger pour écouter sans réseau',
			'teachings.downloaded' => 'Gardé sur ton téléphone',
			'teachings.removed' => 'Retiré du téléphone',
			'teachings.cancelDownload' => 'Arrêter le téléchargement',
			'teachings.removeDownload' => 'Retirer du téléphone',
			'teachings.back15' => 'Reculer de 15 secondes',
			'teachings.forward15' => 'Avancer de 15 secondes',
			'teachings.speed' => ({required Object speed}) => 'Vitesse ${speed}',
			'teachings.recordedOn' => ({required Object date}) => 'Message du ${date}',
			'teachings.moreSubtitle' => 'Prédications et enseignements à écouter',
			'memorize.title' => 'Mémorisation',
			'memorize.subtitle' => 'Cache la Parole dans ton cœur',
			'memorize.toReview' => 'À réviser',
			'memorize.learning' => 'En cours',
			'memorize.known' => 'Sus',
			'memorize.reviewCount' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n, one: 'Réviser ${n} verset', other: 'Réviser ${n} versets', ), 
			'memorize.nothingDue' => 'Rien à réviser aujourd\'hui.',
			'memorize.nextOn' => ({required Object date}) => 'Prochaine révision : ${date}.',
			'memorize.tomorrow' => 'demain',
			'memorize.reminder' => 'Rappel des révisions',
			'memorize.reminderAt' => 'Heure du rappel',
			'memorize.myVerses' => 'Mes versets',
			'memorize.howToAdd' => 'Pour en ajouter un : dans la Bible, touche un verset puis le cerveau de la barre.',
			'memorize.empty' => 'Aucun verset à mémoriser pour l\'instant.',
			'memorize.openBible' => 'Ouvrir la Bible',
			'memorize.late' => 'En retard',
			'memorize.today' => 'Aujourd\'hui',
			'memorize.dueIn' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n, one: 'Dans ${n} jour', other: 'Dans ${n} jours', ), 
			'memorize.stages.fresh' => 'Nouveau',
			'memorize.stages.learning' => 'En cours',
			'memorize.stages.known' => 'Su',
			'memorize.stats' => ({required Object stage, required Object lapses}) => '${stage} · oublié ${lapses} fois',
			'memorize.reviewNow' => 'Réviser maintenant',
			'memorize.remove' => 'Retirer',
			'memorize.removeTitle' => 'Retirer ce verset ?',
			'memorize.removeText' => 'Sa progression sera effacée.',
			'memorize.removed' => 'Verset retiré',
			'memorize.progress' => ({required Object done, required Object total}) => '${done} / ${total}',
			'memorize.show' => 'Voir le verset',
			'memorize.hints.full' => 'Texte',
			'memorize.hints.gaps' => 'Trous',
			'memorize.hints.initials' => 'Initiales',
			'memorize.hints.none' => 'Rien',
			'memorize.recite' => 'Récite le verset, puis vérifie.',
			'memorize.grades.again' => 'Encore',
			'memorize.grades.hard' => 'Difficile',
			'memorize.grades.good' => 'Bien',
			'memorize.grades.easy' => 'Facile',
			'memorize.now' => 'Tout de suite',
			'memorize.later' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n, one: '${n} jour', other: '${n} jours', ), 
			'memorize.doneTitle' => 'Révisions terminées !',
			'memorize.doneText' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n, one: 'Tu as révisé ${n} verset. Que la Parole demeure en toi !', other: 'Tu as révisé ${n} versets. Que la Parole demeure en toi !', ), 
			'memorize.back' => 'Retour',
			'memorize.reminderTitle' => 'Tes versets à réviser',
			'memorize.reminderBody' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n, one: '${n} verset t\'attend aujourd\'hui.', other: '${n} versets t\'attendent aujourd\'hui.', ), 
			'memorize.reminderChannel' => 'Mémorisation',
			'memorize.homeTitle' => 'Versets à réviser',
			'memorize.homeText' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n, one: '${n} verset t\'attend', other: '${n} versets t\'attendent', ), 
			'memorize.menu' => 'Mémoriser des versets',
			'memorize.memorize' => 'Mémoriser',
			'memorize.added' => 'Ajouté à tes versets à mémoriser',
			'memorize.already' => 'Ce passage est déjà dans tes versets',
			'souls.title' => 'Suivi des âmes',
			'souls.subtitle' => '« Celui qui gagne des âmes est sage. » Proverbes 11:30',
			'souls.search' => 'Chercher une personne…',
			'souls.people' => 'Personnes',
			'souls.received' => 'Ont reçu Jésus',
			'souls.toContact' => 'À recontacter',
			'souls.all' => 'Toutes',
			'souls.stages.met' => 'Rencontré(e)',
			'souls.stages.interested' => 'Intéressé(e)',
			'souls.stages.received' => 'A reçu Jésus',
			'souls.stages.followUp' => 'En affermissement',
			'souls.stages.church' => 'Vient à l\'église',
			'souls.stages.baptized' => 'Baptisé(e)',
			'souls.contactSection' => 'À recontacter',
			'souls.everyone' => 'Toutes les personnes',
			'souls.contactToday' => 'À recontacter aujourd\'hui',
			'souls.contactLate' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n, one: 'En retard de ${n} jour', other: 'En retard de ${n} jours', ), 
			'souls.contactOn' => ({required Object date}) => 'Prochain contact le ${date}',
			'souls.empty' => 'Note ici les personnes que tu évangélises : prie pour elles et suis-les jusqu\'à l\'église.',
			'souls.none' => 'Personne ne correspond.',
			'souls.add' => 'Ajouter',
			'souls.addTitle' => 'Nouvelle personne',
			'souls.editTitle' => 'Modifier',
			'souls.name' => 'Nom',
			'souls.nameRequired' => 'Écris son nom.',
			'souls.phone' => 'Téléphone',
			'souls.place' => 'Où vous vous êtes rencontrés',
			'souls.metOn' => 'Rencontré(e) le',
			'souls.stage' => 'Où en est cette personne ?',
			'souls.firstNote' => 'Une note (facultatif)',
			'souls.noteHint' => 'Ce qui a été dit, ses sujets de prière…',
			'souls.save' => 'Enregistrer',
			'souls.saved' => 'Enregistré',
			'souls.call' => 'Appeler',
			'souls.whatsApp' => 'WhatsApp',
			'souls.sms' => 'SMS',
			'souls.edit' => 'Modifier',
			'souls.delete' => 'Supprimer',
			'souls.deleteTitle' => ({required Object name}) => 'Supprimer ${name} ?',
			'souls.deleteText' => 'Ses notes seront effacées de ton téléphone.',
			'souls.deleted' => 'Supprimé',
			'souls.nextContact' => 'Prochain contact',
			'souls.plan' => 'Planifier un rappel',
			'souls.change' => 'Changer la date',
			'souls.clear' => 'Retirer le rappel',
			'souls.noContact' => 'Aucun rappel prévu',
			'souls.metAt' => ({required Object date}) => 'Rencontré(e) le ${date}',
			'souls.notes' => 'Notes',
			'souls.addNote' => 'Ajouter la note',
			'souls.noNotes' => 'Aucune note pour l\'instant.',
			'souls.deleteNote' => 'Supprimer la note',
			'souls.export' => 'Exporter (tableur)',
			'souls.csv.name' => 'Nom',
			'souls.csv.phone' => 'Téléphone',
			'souls.csv.place' => 'Lieu',
			'souls.csv.metOn' => 'Rencontré le',
			'souls.csv.stage' => 'Étape',
			_ => null,
		} ?? switch (path) {
			'souls.csv.next' => 'Prochain contact',
			'souls.csv.notes' => 'Notes',
			'souls.lock' => ({required Object method}) => 'Verrouiller avec ${method}',
			'souls.lockedTitle' => 'Ton suivi des âmes est verrouillé',
			'souls.unlock' => 'Déverrouiller',
			'souls.unlockReason' => 'Ouvre ton suivi des âmes',
			'souls.privacy' => 'Ces informations restent sur ton téléphone : elles ne sont jamais envoyées.',
			'souls.reminderTitle' => 'Suivi des âmes',
			'souls.reminderBody' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n, one: '${n} personne à recontacter aujourd\'hui.', other: '${n} personnes à recontacter aujourd\'hui.', ), 
			'souls.reminderChannel' => 'Suivi des âmes',
			'souls.moreSubtitle' => 'Les personnes que tu évangélises',
			_ => null,
		};
	}
}
