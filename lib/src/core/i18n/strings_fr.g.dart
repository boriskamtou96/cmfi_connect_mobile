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
	late final Translations$prayer$fr prayer = Translations$prayer$fr.internal(_root);
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

	/// fr: '6 90 00 00 01'
	String get phoneHint => '6 90 00 00 01';

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

	/// fr: 'Plus'
	String get more => 'Plus';
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

	/// fr: 'Compte rendu du jour'
	String get todayTitle => 'Compte rendu du jour';

	/// fr: '{filled} sur {total}'
	String progress({required Object filled, required Object total}) => '${filled} sur ${total}';

	/// fr: 'éléments renseignés'
	String get progressLabel => 'éléments renseignés';

	/// fr: 'Continuer'
	String get continueReport => 'Continuer';

	/// fr: 'Commencer'
	String get startReport => 'Commencer';

	/// fr: 'Ta semaine'
	String get weekTitle => 'Ta semaine';

	/// fr: '(one) {{filled} jour sur {total}} (other) {{filled} jours sur {total}}'
	String weekScore({required num filled, required Object total}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(filled,
		one: '${filled} jour sur ${total}',
		other: '${filled} jours sur ${total}',
	);

	/// fr: 'Dans ta communauté'
	String get community => 'Dans ta communauté';

	/// fr: 'Sujets de prière'
	String get prayerTitle => 'Sujets de prière';

	/// fr: 'Bientôt, tu pourras porter chaque jour les sujets de prière de ton assemblée.'
	String get prayerText => 'Bientôt, tu pourras porter chaque jour les sujets de prière de ton assemblée.';

	/// fr: 'Évènements'
	String get eventsTitle => 'Évènements';

	/// fr: 'Cantiques'
	String get hymnsTitle => 'Cantiques';

	/// fr: 'Reprendre le n° {number}'
	String hymnsResume({required Object number}) => 'Reprendre le n° ${number}';

	/// fr: 'Ouvrir le recueil'
	String get hymnsOpen => 'Ouvrir le recueil';

	/// fr: '(one) {{n} jour d'affilée} (other) {{n} jours d'affilée}'
	String streak({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
		one: '${n} jour d\'affilée',
		other: '${n} jours d\'affilée',
	);

	/// fr: 'Remplis aujourd'hui pour continuer'
	String get streakKeep => 'Remplis aujourd\'hui pour continuer';

	/// fr: 'Bravo, continue demain !'
	String get streakToday => 'Bravo, continue demain !';
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

	/// fr: 'Annonces'
	String get announcements => 'Annonces';

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
	late final Translations$prayer$reminders$fr reminders = Translations$prayer$reminders$fr.internal(_root);
	late final Translations$prayer$retreat$fr retreat = Translations$prayer$retreat$fr.internal(_root);
	late final Translations$prayer$session$fr session = Translations$prayer$session$fr.internal(_root);
	late final Translations$prayer$done$fr done = Translations$prayer$done$fr.internal(_root);
	late final Translations$prayer$topics$fr topics = Translations$prayer$topics$fr.internal(_root);
	late final Translations$prayer$lists$fr lists = Translations$prayer$lists$fr.internal(_root);
	late final Translations$prayer$importunity$fr importunity = Translations$prayer$importunity$fr.internal(_root);
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

	/// fr: 'Cameroun'
	String get countryHint => 'Cameroun';

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

	/// fr: 'ton profil, ton pseudo et ton mot de passe'
	String get itemProfile => 'ton profil, ton pseudo et ton mot de passe';

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

	/// fr: '(one) {{n} sujet} (other) {{n} sujets}'
	String points({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
		one: '${n} sujet',
		other: '${n} sujets',
	);

	/// fr: 'jusqu'au {date}'
	String until({required Object date}) => 'jusqu\'au ${date}';

	/// fr: 'depuis le {date}'
	String since({required Object date}) => 'depuis le ${date}';

	/// fr: '(zero) {Personne encore} (one) {{n} prie} (other) {{n} prient}'
	String people({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
		zero: 'Personne encore',
		one: '${n} prie',
		other: '${n} prient',
	);

	/// fr: 'Avec le PDF'
	String get withPdf => 'Avec le PDF';

	/// fr: 'Nouveau'
	String get isNew => 'Nouveau';

	/// fr: 'Sujet de prière'
	String get screenTitle => 'Sujet de prière';

	/// fr: 'Du {from} au {to}'
	String period({required Object from, required Object to}) => 'Du ${from} au ${to}';

	/// fr: '(zero) {Sois le premier à prier pour ces sujets.} (one) {{n} frère ou sœur prie pour ces sujets} (other) {{n} frères et sœurs prient pour ces sujets}'
	String peopleBanner({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
		zero: 'Sois le premier à prier pour ces sujets.',
		one: '${n} frère ou sœur prie pour ces sujets',
		other: '${n} frères et sœurs prient pour ces sujets',
	);

	/// fr: '{count} · {prayed} priés aujourd'hui'
	String prayedToday({required Object count, required Object prayed}) => '${count} · ${prayed} priés aujourd\'hui';

	/// fr: 'Document d'origine'
	String get document => 'Document d\'origine';

	/// fr: 'J'ai prié pour tous ces sujets'
	String get prayAll => 'J\'ai prié pour tous ces sujets';

	/// fr: 'Tous priés aujourd'hui'
	String get allPrayed => 'Tous priés aujourd\'hui';

	/// fr: 'Sujets passés'
	String get archive => 'Sujets passés';

	/// fr: 'Aucun sujet passé.'
	String get archiveEmpty => 'Aucun sujet passé.';

	/// fr: 'En ce moment'
	String get current => 'En ce moment';

	/// fr: '{title} {points} Prions ensemble dans l'app CMFI Connect.'
	String shareText({required Object title, required Object points}) => '${title}\n\n${points}\n\nPrions ensemble dans l\'app CMFI Connect.';

	/// fr: '{kb} Ko'
	String documentSize({required Object kb}) => '${kb} Ko';
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
			'auth.phoneHint' => '6 90 00 00 01',
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
			'auth.church.countryHint' => 'Cameroun',
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
			'nav.home' => 'Accueil',
			'nav.reports' => 'Compte rendu',
			'nav.hymns' => 'Cantiques',
			'nav.prayer' => 'Prière',
			'nav.more' => 'Plus',
			'home.greeting' => ({required Object name}) => 'Bonjour ${name}',
			'home.greetingNoName' => 'Bonjour',
			'home.profile' => 'Mon profil',
			'home.todayTitle' => 'Compte rendu du jour',
			'home.progress' => ({required Object filled, required Object total}) => '${filled} sur ${total}',
			'home.progressLabel' => 'éléments renseignés',
			'home.continueReport' => 'Continuer',
			'home.startReport' => 'Commencer',
			'home.weekTitle' => 'Ta semaine',
			'home.weekScore' => ({required num filled, required Object total}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(filled, one: '${filled} jour sur ${total}', other: '${filled} jours sur ${total}', ), 
			'home.community' => 'Dans ta communauté',
			'home.prayerTitle' => 'Sujets de prière',
			'home.prayerText' => 'Bientôt, tu pourras porter chaque jour les sujets de prière de ton assemblée.',
			'home.eventsTitle' => 'Évènements',
			'home.hymnsTitle' => 'Cantiques',
			'home.hymnsResume' => ({required Object number}) => 'Reprendre le n° ${number}',
			'home.hymnsOpen' => 'Ouvrir le recueil',
			'home.streak' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n, one: '${n} jour d\'affilée', other: '${n} jours d\'affilée', ), 
			'home.streakKeep' => 'Remplis aujourd\'hui pour continuer',
			'home.streakToday' => 'Bravo, continue demain !',
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
			'reports.noItems' => 'Aucun élément à renseigner pour le moment.',
			'reports.statusPending' => 'Pas encore envoyé',
			'reports.savedOffline' => 'Pas de réseau : la journée est gardée sur le téléphone et partira dès que possible.',
			'reports.pendingBanner' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n, one: '${n} journée attend le réseau pour être envoyée', other: '${n} journées attendent le réseau pour être envoyées', ), 
			'reports.export' => 'Exporter mon compte rendu',
			'reports.goal' => ({required Object value}) => 'Objectif : ${value}',
			'reports.goalReached' => 'Objectif atteint',
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
			'more.announcements' => 'Annonces',
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
			'members.deleteAccount.itemProfile' => 'ton profil, ton pseudo et ton mot de passe',
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
			_ => null,
		} ?? switch (path) {
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
			'prayer.topics.points' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n, one: '${n} sujet', other: '${n} sujets', ), 
			'prayer.topics.until' => ({required Object date}) => 'jusqu\'au ${date}',
			'prayer.topics.since' => ({required Object date}) => 'depuis le ${date}',
			'prayer.topics.people' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n, zero: 'Personne encore', one: '${n} prie', other: '${n} prient', ), 
			'prayer.topics.withPdf' => 'Avec le PDF',
			'prayer.topics.isNew' => 'Nouveau',
			'prayer.topics.screenTitle' => 'Sujet de prière',
			'prayer.topics.period' => ({required Object from, required Object to}) => 'Du ${from} au ${to}',
			'prayer.topics.peopleBanner' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n, zero: 'Sois le premier à prier pour ces sujets.', one: '${n} frère ou sœur prie pour ces sujets', other: '${n} frères et sœurs prient pour ces sujets', ), 
			'prayer.topics.prayedToday' => ({required Object count, required Object prayed}) => '${count} · ${prayed} priés aujourd\'hui',
			'prayer.topics.document' => 'Document d\'origine',
			'prayer.topics.prayAll' => 'J\'ai prié pour tous ces sujets',
			'prayer.topics.allPrayed' => 'Tous priés aujourd\'hui',
			'prayer.topics.archive' => 'Sujets passés',
			'prayer.topics.archiveEmpty' => 'Aucun sujet passé.',
			'prayer.topics.current' => 'En ce moment',
			'prayer.topics.shareText' => ({required Object title, required Object points}) => '${title}\n\n${points}\n\nPrions ensemble dans l\'app CMFI Connect.',
			'prayer.topics.documentSize' => ({required Object kb}) => '${kb} Ko',
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
			_ => null,
		};
	}
}
