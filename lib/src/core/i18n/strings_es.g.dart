///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import
// dart format off

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:slang/generated.dart';
import 'strings.g.dart';

// Path: <root>
class TranslationsEs extends Translations with BaseTranslations<AppLocale, Translations> {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsEs({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  _meta = meta ?? TranslationMetadata(
		    locale: AppLocale.es,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ),
		  super(cardinalResolver: cardinalResolver, ordinalResolver: ordinalResolver) {
		_meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <es>.
	final TranslationMetadata<AppLocale, Translations> _meta;
	@override TranslationMetadata<AppLocale, Translations> get $meta => _meta;

	/// Access flat map
	@override dynamic operator[](String key) => _meta.getTranslation(key) ?? super[key];

	late final TranslationsEs _root = this; // ignore: unused_field

	@override 
	TranslationsEs $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsEs(meta: meta ?? this.$meta);

	// Translations
	@override late final _Translations$app$es app = _Translations$app$es._(_root);
	@override late final _Translations$common$es common = _Translations$common$es._(_root);
	@override late final _Translations$errors$es errors = _Translations$errors$es._(_root);
	@override late final _Translations$validation$es validation = _Translations$validation$es._(_root);
	@override late final _Translations$welcome$es welcome = _Translations$welcome$es._(_root);
	@override late final _Translations$auth$es auth = _Translations$auth$es._(_root);
	@override late final _Translations$countries$es countries = _Translations$countries$es._(_root);
	@override late final _Translations$nav$es nav = _Translations$nav$es._(_root);
	@override late final _Translations$home$es home = _Translations$home$es._(_root);
	@override late final _Translations$reports$es reports = _Translations$reports$es._(_root);
	@override late final _Translations$reminder$es reminder = _Translations$reminder$es._(_root);
	@override late final _Translations$export$es export = _Translations$export$es._(_root);
	@override late final _Translations$items$es items = _Translations$items$es._(_root);
	@override late final _Translations$newItem$es newItem = _Translations$newItem$es._(_root);
	@override late final _Translations$more$es more = _Translations$more$es._(_root);
	@override late final _Translations$authorities$es authorities = _Translations$authorities$es._(_root);
	@override late final _Translations$members$es members = _Translations$members$es._(_root);
	@override late final _Translations$admin$es admin = _Translations$admin$es._(_root);
	@override late final _Translations$hymns$es hymns = _Translations$hymns$es._(_root);
	@override late final _Translations$comingSoon$es comingSoon = _Translations$comingSoon$es._(_root);
	@override late final _Translations$events$es events = _Translations$events$es._(_root);
	@override late final _Translations$notifications$es notifications = _Translations$notifications$es._(_root);
	@override late final _Translations$premium$es premium = _Translations$premium$es._(_root);
	@override late final _Translations$homeWidget$es homeWidget = _Translations$homeWidget$es._(_root);
	@override late final _Translations$ministry$es ministry = _Translations$ministry$es._(_root);
	@override late final _Translations$prayer$es prayer = _Translations$prayer$es._(_root);
	@override late final _Translations$sending$es sending = _Translations$sending$es._(_root);
	@override late final _Translations$streak$es streak = _Translations$streak$es._(_root);
	@override late final _Translations$shortcuts$es shortcuts = _Translations$shortcuts$es._(_root);
	@override late final _Translations$blocking$es blocking = _Translations$blocking$es._(_root);
	@override late final _Translations$verses$es verses = _Translations$verses$es._(_root);
	@override late final _Translations$bible$es bible = _Translations$bible$es._(_root);
	@override late final _Translations$profilePhoto$es profilePhoto = _Translations$profilePhoto$es._(_root);
	@override late final _Translations$disciples$es disciples = _Translations$disciples$es._(_root);
	@override late final _Translations$weekStory$es weekStory = _Translations$weekStory$es._(_root);
	@override late final _Translations$yearStory$es yearStory = _Translations$yearStory$es._(_root);
	@override late final _Translations$seekFirst$es seekFirst = _Translations$seekFirst$es._(_root);
	@override late final _Translations$documents$es documents = _Translations$documents$es._(_root);
	@override late final _Translations$biblePlan$es biblePlan = _Translations$biblePlan$es._(_root);
	@override late final _Translations$teachings$es teachings = _Translations$teachings$es._(_root);
	@override late final _Translations$memorize$es memorize = _Translations$memorize$es._(_root);
	@override late final _Translations$souls$es souls = _Translations$souls$es._(_root);
	@override late final _Translations$fasts$es fasts = _Translations$fasts$es._(_root);
	@override late final _Translations$received$es received = _Translations$received$es._(_root);
	@override late final _Translations$update$es update = _Translations$update$es._(_root);
}

// Path: app
class _Translations$app$es extends Translations$app$fr {
	_Translations$app$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get name => 'CMFI Connect';
	@override String get tagline => 'Crecer juntos, cada día.';
	@override String get languageName => 'Español';
}

// Path: common
class _Translations$common$es extends Translations$common$fr {
	_Translations$common$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get retry => 'Reintentar';
	@override String get cancel => 'Cancelar';
	@override String get save => 'Guardar';
	@override String get close => 'Cerrar';
	@override String get back => 'Volver';
	@override String get soon => 'Pronto';
	@override String get optional => '(opcional)';
	@override String get and => 'y';
	@override String get loading => 'Cargando…';
	@override String get done => 'OK';
	@override String get rangeStart => 'Desde';
	@override String get rangeEnd => 'Hasta';
}

// Path: errors
class _Translations$errors$es extends Translations$errors$fr {
	_Translations$errors$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get network => 'Sin conexión a internet. Revisa tu red y vuelve a intentarlo.';
	@override String get unauthorized => 'Tu sesión ha expirado. Vuelve a iniciar sesión.';
	@override String get invalidCredentials => 'Número de teléfono o contraseña incorrectos.';
	@override String get badRequest => 'Algunos datos no son válidos.';
	@override String get conflict => 'Este elemento ya existe.';
	@override String get notFound => 'Elemento no encontrado.';
	@override String get server => 'El servidor tuvo un problema. Vuelve a intentarlo en un momento.';
	@override String get unknown => 'Se produjo un error. Vuelve a intentarlo.';
	@override String get forbidden => 'No tienes permiso para hacer esto.';
	@override String get eventFull => 'Ya no quedan plazas para este evento.';
	@override String get registrationClosed => 'Las inscripciones para este evento están cerradas.';
	@override String get mediaTooLarge => 'Esta imagen es demasiado pesada (8 MB como máximo).';
	@override String get mediaUnsupported => 'Elige una imagen JPEG o PNG.';
	@override String get notParticipant => 'Únete primero a este motivo para contar tus proclamaciones.';
	@override String get importunityClosed => 'Este motivo está cerrado: ya no cuenta proclamaciones.';
	@override String get usernameNotFound => 'Nadie tiene este nombre de usuario. Revisa la ortografía.';
	@override String get ownerCannotLeave => 'Tú creaste este motivo: elimínalo en lugar de dejarlo.';
	@override String get tooManyPeople => 'Tus listas están llenas (500 personas como máximo).';
	@override String get avatarInvalid => 'Esta foto no se puede usar. Elige otra.';
	@override String get reportsNotShared => 'Este miembro ya no comparte sus informes.';
	@override String get invalidPhone => 'Este número no se reconoce. Añade el prefijo del país (+237…).';
	@override String get providerUnavailable => 'Este operador no acepta este pago por ahora.';
	@override String get amountOutOfBounds => 'Este importe supera lo que acepta el operador.';
	@override String get alreadyPaid => 'Tu inscripción ya está pagada.';
	@override String get paymentsDisabled => 'El pago con dinero móvil aún no está disponible.';
	@override String get paymentRequired => 'Este evento es de pago: paga tu inscripción con dinero móvil.';
	@override String get paidRegistration => 'Inscripción pagada: contacta con los organizadores para anularla.';
	@override String get eventHasPayments => 'Hay miembros que pagaron: primero reembolsa sus pagos desde el sitio de administración.';
	@override String get peoplePaid => 'El número de personas de una inscripción pagada ya no puede cambiar.';
}

// Path: validation
class _Translations$validation$es extends Translations$validation$fr {
	_Translations$validation$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get required => 'Este campo es obligatorio';
	@override String get passwordTooShort => 'Al menos 6 caracteres';
	@override String get invalidPhone => 'Número de teléfono no válido';
	@override String get invalidEmail => 'Correo electrónico no válido';
	@override String get invalidCode => 'Solo letras y números, sin espacios';
}

// Path: welcome
class _Translations$welcome$es extends Translations$welcome$fr {
	_Translations$welcome$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override late final _Translations$welcome$seek$es seek = _Translations$welcome$seek$es._(_root);
	@override late final _Translations$welcome$worship$es worship = _Translations$welcome$worship$es._(_root);
	@override late final _Translations$welcome$community$es community = _Translations$welcome$community$es._(_root);
	@override String step({required Object current, required Object total}) => 'Pantalla ${current} de ${total}';
	@override String streak({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: '${n} día con Dios',
		other: '${n} días con Dios',
	);
	@override late final _Translations$welcome$sample$es sample = _Translations$welcome$sample$es._(_root);
	@override String get createAccount => 'Crear mi cuenta';
	@override String get haveAccount => 'Ya tengo una cuenta';
}

// Path: auth
class _Translations$auth$es extends Translations$auth$fr {
	_Translations$auth$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get phone => 'Teléfono';
	@override String dialCode({required Object code}) => 'Código de país: ${code}';
	@override String get password => 'Contraseña';
	@override String get showPassword => 'Mostrar la contraseña';
	@override String get hidePassword => 'Ocultar la contraseña';
	@override late final _Translations$auth$login$es login = _Translations$auth$login$es._(_root);
	@override late final _Translations$auth$register$es register = _Translations$auth$register$es._(_root);
	@override late final _Translations$auth$church$es church = _Translations$auth$church$es._(_root);
	@override late final _Translations$auth$forgot$es forgot = _Translations$auth$forgot$es._(_root);
	@override late final _Translations$auth$biometric$es biometric = _Translations$auth$biometric$es._(_root);
}

// Path: countries
class _Translations$countries$es extends Translations$countries$fr {
	_Translations$countries$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get dialCodeTitle => 'Código de país';
	@override String get title => 'Tu país';
	@override String get search => 'Buscar un país o un código';
	@override String get none => 'Ningún país coincide';
	@override String get change => 'Cambiar de país';
}

// Path: nav
class _Translations$nav$es extends Translations$nav$fr {
	_Translations$nav$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get home => 'Inicio';
	@override String get reports => 'Informe';
	@override String get hymns => 'Himnos';
	@override String get prayer => 'Oración';
	@override String get bible => 'Biblia';
}

// Path: home
class _Translations$home$es extends Translations$home$fr {
	_Translations$home$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String greeting({required Object name}) => 'Hola, ${name}';
	@override String get greetingNoName => 'Hola';
	@override String get profile => 'Mi perfil';
	@override String progress({required Object filled, required Object total}) => '${filled} de ${total}';
	@override String get progressLabel => 'elementos completados';
	@override String get goals => 'objetivos';
	@override String get weekTitle => 'Tu semana';
	@override String get community => 'Actualmente en la CMCI';
	@override String get eventsTitle => 'Eventos';
	@override String get hymnsTitle => 'Himnos';
	@override String get hymnsOpen => 'Abrir el himnario';
	@override String get continueMyReport => 'Continuar mi informe';
	@override String get startMyReport => 'Empezar mi informe';
	@override String get items => 'elementos';
	@override String get goalsTitle => 'Objetivos';
	@override String get retreatsTitle => 'Retiros';
	@override String retreatsValue({required Object n}) => '${n} de 4';
	@override String get streakTitle => 'Racha';
	@override String get resume => 'Retomar';
	@override String hymnNumber({required Object number}) => 'Himno n.º ${number}';
	@override String get seeAll => 'Ver todo';
	@override String get retreatsDone => 'Los 4 retiros del día están hechos';
	@override String days({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: '${n} día',
		other: '${n} días',
	);
	@override String get hideNumbers => 'Ocultar mis cifras';
	@override String get showNumbers => 'Mostrar mis cifras';
	@override String get numbersHidden => 'oculto';
	@override String daysShort({required Object n}) => '${n} d';
	@override String get prayTogether => 'Orar juntos';
	@override String invitedBy({required Object name}) => '${name} te invita a orar';
	@override String get soulsTitle => 'Almas que volver a contactar';
	@override String get listenTitle => 'Para escuchar';
	@override String soulsText({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: '${n} persona hoy',
		other: '${n} personas hoy',
	);
}

// Path: reports
class _Translations$reports$es extends Translations$reports$fr {
	_Translations$reports$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Informe diario';
	@override String get myItems => 'Mis elementos';
	@override late final _Translations$reports$tabs$es tabs = _Translations$reports$tabs$es._(_root);
	@override String get pickDay => 'Elegir el día';
	@override String filled({required Object filled, required Object total}) => '${filled} de ${total} completados';
	@override String get statusSaved => 'Guardado';
	@override String get statusModified => 'Sin guardar';
	@override String get standard => 'Estándar';
	@override String get personal => 'Mis elementos';
	@override String get createItem => 'Crear un elemento';
	@override String add({required Object label}) => 'Añadir ${label}';
	@override String get note => 'Nota del día';
	@override String get noteHint => 'Un versículo, un motivo de gratitud…';
	@override String get save => 'Guardar el día';
	@override String get saved => 'Día guardado';
	@override late final _Translations$reports$measure$es measure = _Translations$reports$measure$es._(_root);
	@override String times({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: '${n} vez',
		other: '${n} veces',
	);
	@override late final _Translations$reports$sheet$es sheet = _Translations$reports$sheet$es._(_root);
	@override late final _Translations$reports$history$es history = _Translations$reports$history$es._(_root);
	@override late final _Translations$reports$summary$es summary = _Translations$reports$summary$es._(_root);
	@override String get noItems => 'Por ahora no hay elementos que completar.';
	@override String get statusPending => 'Aún no enviado';
	@override String get savedOffline => 'Sin conexión: el día se guarda en el teléfono y se enviará en cuanto sea posible.';
	@override String pendingBanner({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: '${n} día espera conexión para enviarse',
		other: '${n} días esperan conexión para enviarse',
	);
	@override String get export => 'Exportar mi informe';
	@override String goal({required Object value}) => 'Objetivo: ${value}';
	@override String get goalReached => 'Objetivo alcanzado';
	@override String get dayGoals => 'Objetivos del día';
	@override String goalsReached({required Object reached, required Object total}) => 'Alcanzados: ${reached} de ${total}';
	@override late final _Translations$reports$standardItems$es standardItems = _Translations$reports$standardItems$es._(_root);
	@override late final _Translations$reports$units$es units = _Translations$reports$units$es._(_root);
	@override late final _Translations$reports$timer$es timer = _Translations$reports$timer$es._(_root);
}

// Path: reminder
class _Translations$reminder$es extends Translations$reminder$fr {
	_Translations$reminder$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Tu informe del día';
	@override String get body => 'Tómate un minuto para anotar tu lectura, tu oración… antes de que termine el día.';
	@override String get channel => 'Recordatorio del informe';
	@override String get settings => 'Recordatorio nocturno';
	@override String get off => 'Desactivado';
	@override String get switchLabel => 'Recordarme completar mi día';
	@override String get switchHint => 'Solo si el día aún no está completado.';
	@override String get time => 'Hora del recordatorio';
	@override String get offerTitle => '¿Un recordatorio cada noche?';
	@override String get offerText => 'Si tu día aún no está completado, la app te lo recuerda a la hora que elijas. Nada si ya lo hiciste.';
	@override String get offerAccept => 'Activar el recordatorio';
	@override String get offerLater => 'Más tarde';
	@override String enabled({required Object time}) => 'Recordatorio activado a las ${time}';
	@override String get denied => 'Las notificaciones están bloqueadas para CMFI Connect. Permítelas en los ajustes del teléfono.';
}

// Path: export
class _Translations$export$es extends Translations$export$fr {
	_Translations$export$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Exportar';
	@override String get period => 'Período';
	@override String get thisWeek => 'Esta semana';
	@override String get lastWeek => 'La semana pasada';
	@override String get thisMonth => 'Este mes';
	@override String get lastMonth => 'El mes pasado';
	@override String get thisYear => 'Este año';
	@override String get custom => 'Otras fechas';
	@override String get customPick => 'Elegir las fechas';
	@override String get format => 'Formato';
	@override String get pdf => 'PDF';
	@override String get pdfHint => 'Un documento para enviar o imprimir';
	@override String get csv => 'Hoja de cálculo';
	@override String get csvHint => 'Un archivo CSV para Excel o Google Sheets';
	@override String get text => 'Mensaje';
	@override String get textHint => 'Un resumen para pegar en WhatsApp';
	@override String get button => 'Exportar';
	@override String get shareButton => 'Compartir';
	@override String preview({required num filled, required Object total, required Object items}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(filled,
		one: '${filled} día completado de ${total} · ${items}',
		other: '${filled} días completados de ${total} · ${items}',
	);
	@override String previewItems({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: '${n} elemento',
		other: '${n} elementos',
	);
	@override String get empty => 'No hay informes en este período.';
	@override String get tooLong => 'Elige 366 días como máximo.';
	@override String get fileName => 'informe-diario';
	@override String subject({required Object period}) => 'Mi informe, ${period}';
	@override late final _Translations$export$doc$es doc = _Translations$export$doc$es._(_root);
}

// Path: items
class _Translations$items$es extends Translations$items$fr {
	_Translations$items$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Mis elementos';
	@override String get standardSection => 'Estándar · para todos';
	@override String get personalSection => 'Mis elementos personales';
	@override String get emptyPersonal => 'Aún no tienes elementos personales.';
	@override String get archive => 'Archivar';
	@override String archiveTitle({required Object code}) => '¿Archivar ${code}?';
	@override String get archiveText => 'Ya no aparecerá en tu informe. Sus cifras se quedan en tu historial.';
	@override String archived({required Object code}) => '${code} archivado';
	@override String get create => 'Crear un elemento';
	@override String get footnote => 'Un elemento archivado ya no aparece en tu informe, pero sus cifras se quedan en tu historial.';
	@override late final _Translations$items$measure$es measure = _Translations$items$measure$es._(_root);
	@override String get goalAdd => 'Añadir un objetivo';
	@override String goal({required Object value}) => 'Objetivo: ${value} al día';
	@override String get goalTitle => 'Objetivo diario';
	@override String get goalHint => 'Lo que te propones cada día. Se queda en tu teléfono.';
	@override String get goalRemove => 'Quitar';
	@override String get goalSaved => 'Objetivo guardado';
	@override String get goalRemoved => 'Objetivo quitado';
}

// Path: newItem
class _Translations$newItem$es extends Translations$newItem$fr {
	_Translations$newItem$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Nuevo elemento';
	@override String get code => 'Código';
	@override String get label => 'Nombre';
	@override String get help => 'Letras y números, 20 como máximo. El código de un elemento estándar (LB, PS…) no está disponible.';
	@override String get measures => 'Lo que mides';
	@override String get quantity => 'Una cantidad';
	@override String get quantityHint => 'Capítulos, páginas, personas…';
	@override String get unit => 'Unidad que aparece después del número';
	@override String get unitHint => 'personas';
	@override String get duration => 'Una duración';
	@override String get durationHint => 'En horas y minutos';
	@override String get noMeasure => 'Elige al menos una medida: una cantidad, una duración o ambas.';
	@override String get preview => 'Vista previa en tu informe';
	@override String get previewCode => 'CÓDIGO';
	@override String get previewLabel => 'Nombre del elemento';
	@override String get submit => 'Crear el elemento';
	@override String created({required Object code}) => '${code} se ha creado.';
	@override String get codeTaken => 'Este código ya está en uso, por un elemento estándar o por uno de tus elementos (aunque esté archivado).';
	@override String get codeHint => 'EVG';
	@override String get labelHint => 'Evangelización';
}

// Path: more
class _Translations$more$es extends Translations$more$fr {
	_Translations$more$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Más';
	@override String get editProfile => 'Editar mi perfil';
	@override String get community => 'Comunidad';
	@override String get events => 'Eventos';
	@override String get reports => 'Informe diario';
	@override String get myItems => 'Mis elementos';
	@override String get app => 'Aplicación';
	@override String get language => 'Idioma';
	@override String get appearance => 'Apariencia';
	@override String get themeSystem => 'Automático';
	@override String get themeSystemHint => 'En automático, la app sigue el modo claro u oscuro del teléfono.';
	@override String get themeLight => 'Claro';
	@override String get themeDark => 'Oscuro';
	@override String get logout => 'Cerrar sesión';
	@override String get account => 'Cuenta';
	@override String get languageTitle => 'Idioma de la aplicación';
	@override String get completeProfile => 'Añade tu nombre';
	@override String get accompaniment => 'Acompañamiento';
	@override String get exportReport => 'Exportar mi informe';
	@override String get logoutPendingTitle => 'Días aún no enviados';
	@override String logoutPendingText({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: '${n} día guardado sin conexión aún no se ha enviado. Si cierras sesión ahora, se perderá.',
		other: '${n} días guardados sin conexión aún no se han enviado. Si cierras sesión ahora, se perderán.',
	);
	@override String get logoutAnyway => 'Cerrar sesión';
	@override String get admin => 'Administración';
	@override String get staff => 'Equipo y roles';
	@override String get manageEvents => 'Eventos';
	@override String get disciples => 'Mis discípulos';
	@override String version({required Object version}) => 'Versión ${version}';
	@override String copyright({required Object year}) => '© ${year} Comunidad Misionera Cristiana Internacional. Todos los derechos reservados.';
}

// Path: authorities
class _Translations$authorities$es extends Translations$authorities$fr {
	_Translations$authorities$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Mis autoridades espirituales';
	@override String get intro => 'Las personas que te acompañan en tu caminar con Dios: tu discipulador y tus otros líderes.';
	@override String get discipleMaker => 'Discipulador';
	@override String discipleMakerOf({required Object name}) => 'Discipulador: ${name}';
	@override String get noDiscipleMaker => 'Aún no tienes discipulador';
	@override String get others => 'Otras autoridades';
	@override String get empty => 'Aún no has añadido a nadie.';
	@override String get add => 'Añadir una autoridad';
	@override String get remove => 'Quitar';
	@override String removeTitle({required Object name}) => '¿Quitar a ${name}?';
	@override String removeText({required Object name}) => '${name} ya no formará parte de tus autoridades espirituales.';
	@override String removed({required Object name}) => '${name} ya no forma parte de tus autoridades.';
	@override String count({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		zero: 'Nadie por ahora',
		one: '${n} persona',
		other: '${n} personas',
	);
	@override late final _Translations$authorities$form$es form = _Translations$authorities$form$es._(_root);
	@override String get statusPending => 'Pendiente';
	@override String get statusDeclined => 'Rechazada';
	@override String pendingHelp({required Object name}) => 'Sus datos de contacto aparecerán cuando ${name} acepte.';
	@override String get requests => 'Solicitudes recibidas';
	@override String get requestDiscipleMaker => 'te pide que seas su discipulador';
	@override String get requestAuthority => 'te pide tu acompañamiento';
	@override String get accept => 'Aceptar';
	@override String get decline => 'Rechazar';
	@override String acceptedRequest({required Object name}) => 'Ahora acompañas a ${name}.';
	@override String declinedRequest({required Object name}) => 'Solicitud de ${name} rechazada.';
	@override String requestsCount({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: '${n} solicitud por revisar',
		other: '${n} solicitudes por revisar',
	);
	@override late final _Translations$authorities$sharing$es sharing = _Translations$authorities$sharing$es._(_root);
}

// Path: members
class _Translations$members$es extends Translations$members$fr {
	_Translations$members$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get username => 'Nombre de usuario';
	@override String get usernameHint => 'nombre.apellido';
	@override String get usernameHelp => 'Así te encontrarán los demás miembros.';
	@override String get usernameChecking => 'Comprobando…';
	@override String usernameFree({required Object username}) => '@${username} está disponible';
	@override String get usernameCurrent => 'Es tu nombre de usuario actual';
	@override String get usernameTaken => 'Este nombre de usuario ya está en uso.';
	@override String get usernameInvalid => 'De 3 a 30 caracteres: letras, números, «.» y «_», sin empezar ni terminar con un signo.';
	@override String get usernameReserved => 'Este nombre de usuario está reservado.';
	@override String usernameSaved({required Object username}) => 'Nombre de usuario guardado: @${username}';
	@override late final _Translations$members$deleteAccount$es deleteAccount = _Translations$members$deleteAccount$es._(_root);
}

// Path: admin
class _Translations$admin$es extends Translations$admin$fr {
	_Translations$admin$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Equipo y roles';
	@override String get intro => 'Los admins gestionan lo que comparte toda la comunidad. Solo un superadmin da o quita un rol.';
	@override String get roleUser => 'Miembro';
	@override String get roleAdmin => 'Admin';
	@override String get roleSuperadmin => 'Superadmin';
	@override String get giveRole => 'Dar un rol';
	@override String get you => 'tú';
	@override String roleFor({required Object username}) => 'Rol de @${username}';
	@override String roleChanged({required Object username, required Object role}) => '@${username}: ${role}';
	@override String get memberUsername => 'Nombre de usuario del miembro';
	@override String get empty => 'Aún no hay ningún admin.';
}

// Path: hymns
class _Translations$hymns$es extends Translations$hymns$fr {
	_Translations$hymns$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get searchHint => 'Número, título o letra';
	@override String get openNumber => 'Ir a un número';
	@override late final _Translations$hymns$tabs$es tabs = _Translations$hymns$tabs$es._(_root);
	@override String get chooseBook => 'Elegir el himnario';
	@override String count({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: '${n} himno',
		other: '${n} himnos',
	);
	@override String number({required Object number}) => 'N.º ${number}';
	@override String get emptyFavorites => 'Toca la estrella de un himno para encontrarlo aquí.';
	@override String get emptyRecent => 'Los himnos que abras aparecerán aquí.';
	@override String noResult({required Object query}) => 'Ningún himno coincide con «${query}».';
	@override String get otherBooks => 'En los otros himnarios';
	@override String get upToDate => 'Los himnarios están al día.';
	@override String get updated => 'Los himnarios se han actualizado.';
	@override String get chorus => 'Coro';
	@override String chorusNumber({required Object label}) => 'Coro ${label}';
	@override String verse({required Object label}) => 'Estrofa ${label}';
	@override String times({required Object n}) => '×${n}';
	@override String get loadFailed => 'No se pudieron abrir los himnarios.';
	@override late final _Translations$hymns$reader$es reader = _Translations$hymns$reader$es._(_root);
	@override late final _Translations$hymns$projection$es projection = _Translations$hymns$projection$es._(_root);
	@override late final _Translations$hymns$pad$es pad = _Translations$hymns$pad$es._(_root);
}

// Path: comingSoon
class _Translations$comingSoon$es extends Translations$comingSoon$fr {
	_Translations$comingSoon$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get badge => 'Próximamente';
	@override String get backHome => 'Volver al inicio';
}

// Path: events
class _Translations$events$es extends Translations$events$fr {
	_Translations$events$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Eventos';
	@override String get featured => 'Destacado';
	@override String get upcoming => 'Próximos';
	@override String get past => 'Ediciones anteriores';
	@override String get emptyTitle => 'No hay eventos próximos';
	@override String get emptyText => 'Las conferencias y los encuentros de toda la comunidad aparecerán aquí, con su programa.';
	@override String get manage => 'Gestionar los eventos';
	@override String get next => 'Próximo evento';
	@override String get seeAll => 'Todos los eventos';
	@override String get homeText => 'Los encuentros de la comunidad, su programa y sus novedades.';
	@override String get today => 'Hoy';
	@override String get tomorrow => 'Mañana';
	@override String inDays({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: 'En ${n} día',
		other: 'En ${n} días',
	);
	@override String daysLeft({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		other: 'Faltan ${n} días',
	);
	@override String get onNow => 'En curso';
	@override String get over => 'Terminado';
	@override String get cancelled => 'Cancelado';
	@override String get draft => 'Borrador';
	@override String get registered => 'Inscrito';
	@override String get stateOpen => 'Inscripciones abiertas';
	@override String get stateClosed => 'Inscripciones cerradas';
	@override String get stateFull => 'Completo';
	@override String registrations({required num n, required Object count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		zero: 'Sé el primero en inscribirte',
		one: '${count} inscrito',
		other: '${count} inscritos',
	);
	@override String people({required num n, required Object count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: '${count} persona',
		other: '${count} personas',
	);
	@override String placesLeft({required num n, required Object count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		zero: 'no quedan plazas',
		one: '${count} plaza disponible',
		other: '${count} plazas disponibles',
	);
	@override String oneDay({required Object start, required Object end}) => 'De ${start} a ${end}';
	@override String severalDays({required Object startDay, required Object start, required Object endDay, required Object end}) => 'Apertura el ${startDay} a las ${start}, clausura el ${endDay} a las ${end}';
	@override String venueTime({required Object place}) => 'hora de ${place}';
	@override String get addToCalendar => 'Añadir al calendario';
	@override String get share => 'Compartir';
	@override String get directions => 'Cómo llegar';
	@override String get viewPoster => 'Ver el cartel';
	@override late final _Translations$events$tabs$es tabs = _Translations$events$tabs$es._(_root);
	@override String get noProgram => 'El programa se publicará pronto.';
	@override String get noNews => 'Aún no hay novedades de este evento.';
	@override String get pinned => 'Fijado';
	@override String get now => 'Ahora mismo';
	@override String hymn({required Object number}) => 'Himno ${number}';
	@override String get about => 'Acerca de';
	@override String get fees => 'Aportación';
	@override String deadline({required Object date}) => 'Inscripciones hasta el ${date}';
	@override String get contact => 'Contacto';
	@override String call({required Object name}) => 'Llamar a ${name}';
	@override String get otherEditions => 'Las otras ediciones';
	@override String get cancelledBanner => 'Este evento está cancelado.';
	@override String get calendarFailed => 'No se pudo abrir el calendario del teléfono.';
	@override String get linkFailed => 'No se pudo abrir este enlace.';
	@override String shareText({required Object title, required Object dates, required Object place}) => '${title}\n${dates} · ${place}\nInscríbete en la app CMFI Connect.';
	@override String get full => 'Ya no quedan plazas para este evento.';
	@override String get closed => 'Las inscripciones para este evento están cerradas.';
	@override late final _Translations$events$register$es register = _Translations$events$register$es._(_root);
	@override late final _Translations$events$reminder$es reminder = _Translations$events$reminder$es._(_root);
	@override late final _Translations$events$admin$es admin = _Translations$events$admin$es._(_root);
	@override String upcomingCount({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: '${n} evento próximo',
		other: '${n} eventos próximos',
	);
	@override String slide({required Object current, required Object total}) => 'Evento ${current} de ${total}';
	@override late final _Translations$events$pay$es pay = _Translations$events$pay$es._(_root);
}

// Path: notifications
class _Translations$notifications$es extends Translations$notifications$fr {
	_Translations$notifications$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Notificaciones';
	@override String get channel => 'Anuncios de la comunidad';
	@override String get empty => 'Aún no hay notificaciones';
	@override String get emptyHint => 'Los anuncios de la comunidad llegarán aquí.';
	@override String unreadLabel({required Object title}) => 'Sin leer: ${title}';
	@override String documents({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: '${n} documento PDF',
		other: '${n} documentos PDF',
	);
	@override String unread({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: '${n} sin leer',
		other: '${n} sin leer',
	);
	@override String image({required Object n}) => 'Imagen ${n}';
	@override String get document => 'Documento PDF';
	@override String documentSize({required Object kb}) => '${kb} KB';
}

// Path: premium
class _Translations$premium$es extends Translations$premium$fr {
	_Translations$premium$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get name => 'CMFI Connect Premium';
	@override String get pill => 'Premium';
	@override String get subtitle => 'Avanza en tu camino con Dios y apoya la obra.';
	@override String get widgetTitle => 'El widget de la pantalla de inicio';
	@override String get widgetText => 'Tu informe del día y tus objetivos, sin abrir la app.';
	@override String get statsTitle => 'Tus objetivos durante el año';
	@override String get statsText => 'El balance del año y la evolución de tus objetivos, semana tras semana.';
	@override String get supportTitle => 'Apoyas la obra';
	@override String get supportText => 'Tu suscripción mantiene la app para toda la comunidad.';
	@override String get annual => 'Anual';
	@override String get lifetime => 'De por vida';
	@override String get monthly => 'Mensual';
	@override String perYear({required Object price}) => '${price} / año';
	@override String once({required Object price}) => '${price} una vez';
	@override String perMonth({required Object price}) => '${price} / mes';
	@override String annualPerMonth({required Object price}) => 'es decir, ${price} al mes';
	@override String get best => 'La más ventajosa';
	@override String trialDays({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: '${n} día de prueba gratis',
		other: '${n} días de prueba gratis',
	);
	@override String trialMonths({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: '${n} mes de prueba gratis',
		other: '${n} meses de prueba gratis',
	);
	@override String get subscribe => 'Suscribirme';
	@override String get startTrial => 'Empezar la prueba gratis';
	@override String get restore => 'Restaurar compras';
	@override String get restored => 'Premium vuelve a estar en este teléfono';
	@override String get nothingToRestore => 'No hay compras Premium para esta cuenta';
	@override String get thanks => '¡Gracias! Premium está activado.';
	@override String get failed => 'La compra no se completó. Inténtalo de nuevo en un momento.';
	@override String get unavailable => 'Las ofertas no están disponibles por ahora.';
	@override String renews({required Object store}) => 'La suscripción se renueva automáticamente. Puedes cancelarla cuando quieras en los ajustes de tu cuenta de ${store}.';
	@override String get terms => 'Condiciones de uso';
	@override String get privacy => 'Privacidad';
	@override String get activeTitle => 'Tienes Premium';
	@override String get activeText => '¡Gracias por apoyar CMFI Connect! El widget y el año de tu balance están abiertos.';
	@override String get staffText => 'Tienes Premium gratis porque formas parte del equipo de CMFI Connect.';
	@override String get moreSubtitle => 'Widget, objetivos del año';
	@override String get moreActive => 'Activo';
	@override String get unlock => 'Desbloquear con Premium';
	@override String trialThen({required Object trial, required Object price}) => '${trial}, luego ${price}';
	@override String savePercent({required Object percent}) => '−${percent}';
	@override String get choose => 'Elige tu plan';
	@override String get cancelAnytime => 'Sin compromiso, cancela cuando quieras';
	@override String get restoreShort => 'Restaurar';
	@override String get termsShort => 'Condiciones';
	@override String get semiannual => 'Semestral';
	@override String perSemester({required Object price}) => '${price} / 6 meses';
	@override String get buyLifetime => 'Comprar de por vida';
	@override String get lifetimeNote => 'De por vida: un solo pago, sin suscripción ni renovación.';
	@override String get manage => 'Gestionar mi suscripción';
	@override String get manageFailed => 'La gestión de la suscripción no se abre. Inténtalo más tarde.';
	@override String get crown => 'Miembro Premium';
}

// Path: homeWidget
class _Translations$homeWidget$es extends Translations$homeWidget$fr {
	_Translations$homeWidget$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Hoy';
	@override String get done => 'Hecho';
	@override String get todo => 'Por rellenar';
	@override String get open => 'Rellenar';
	@override String get locked => 'Activa el widget con Premium';
	@override String get signedOut => 'Inicia sesión en la app';
}

// Path: ministry
class _Translations$ministry$es extends Translations$ministry$fr {
	_Translations$ministry$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Nuestro ministerio';
	@override String get tagline => 'Hasta lo último de la tierra';
	@override String count({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: '${n} nación',
		other: '${n} naciones',
	);
	@override String get fromYaounde => 'Desde Yaundé, el Evangelio va de nación en nación.';
	@override String get dragHint => 'Gira el globo con el dedo, toca una nación.';
	@override String globeLabel({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: 'Globo: ${n} nación donde está presente la obra. La lista de abajo la indica.',
		other: 'Globo: ${n} naciones donde está presente la obra. La lista de abajo las indica todas.',
	);
	@override String get voyage => 'Viaje';
	@override String get pause => 'Pausa';
	@override String get previous => 'Nación anterior';
	@override String get next => 'Nación siguiente';
	@override String number({required Object n}) => 'Nación n.º ${n}';
	@override String since({required Object year}) => 'Desde ${year}';
	@override String get pray => 'Orar';
	@override String prayTitle({required Object country}) => 'Orar por ${country}';
	@override String prayThanks({required Object country}) => 'Da gracias por la obra de Dios en ${country}.';
	@override String prayAssemblies({required Object country}) => 'Ora por las asambleas de ${country} y por sus responsables.';
	@override String prayUnreached({required Object country}) => 'Ora para que quienes aún no han creído en ${country} encuentren a Jesús.';
	@override String get purpose => 'Nuestro propósito';
	@override String get nations => 'Las naciones';
	@override String get search => 'Buscar una nación';
	@override String get none => 'Ninguna nación coincide';
	@override String homeText({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: 'Presente en ${n} nación',
		other: 'Presente en ${n} naciones',
	);
	@override String get nationsSubtitle => 'El globo y el viaje de nación en nación';
	@override String get purposeSubtitle => 'Nuestros tres objetivos';
	@override String get missionaries => 'Nuestros misioneros';
	@override String get missionariesSubtitle => 'Los que el Señor envía a las naciones';
	@override String get heroes => 'Nuestros héroes';
	@override String get heroesSubtitle => 'Aquellos cuya fe nos inspira';
	@override String get founder => 'Nuestro fundador';
	@override String get founderSubtitle => 'El Prof. Zacharias Tanee Fomum';
	@override String get leader => 'Nuestro líder';
	@override String get leaderSubtitle => 'Theodore Andoseh';
	@override String get missionariesEmpty => 'Los retratos de nuestros misioneros llegarán pronto.';
	@override String get heroesEmpty => 'Los retratos de nuestros héroes llegarán pronto.';
	@override String get personGone => 'Este retrato ya no está disponible.';
	@override String photoOf({required Object name}) => 'Foto de ${name}';
	@override String get keyDates => 'Fechas clave';
	@override String get life => 'Su vida';
	@override String get story => 'Su historia';
	@override String goalOf({required Object n, required Object total}) => 'NUESTRO OBJETIVO · ${n}/${total}';
	@override String get previousGoal => 'Objetivo anterior';
	@override String get nextGoal => 'Siguiente objetivo';
	@override Map<String, String> get media => {
		'books': 'Libros',
		'tracts': 'Tratados',
		'magazines': 'Revistas',
		'cds': 'CD',
		'dvds': 'DVD',
		'radio': 'Radio',
		'tv': 'Televisión',
		'internet': 'Internet',
	};
	@override late final _Translations$ministry$goals$es goals = _Translations$ministry$goals$es._(_root);
	@override late final _Translations$ministry$lives$es lives = _Translations$ministry$lives$es._(_root);
}

// Path: prayer
class _Translations$prayer$es extends Translations$prayer$fr {
	_Translations$prayer$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override Map<String, String> get moments => {
		'morning': 'Mañana',
		'noon': 'Mediodía',
		'evening': 'Tarde',
		'night': 'Noche',
	};
	@override Map<String, String> get retreatOf => {
		'morning': 'Retiro de la mañana',
		'noon': 'Retiro del mediodía',
		'evening': 'Retiro de la tarde',
		'night': 'Retiro de la noche',
	};
	@override late final _Translations$prayer$hero$es hero = _Translations$prayer$hero$es._(_root);
	@override late final _Translations$prayer$today$es today = _Translations$prayer$today$es._(_root);
	@override late final _Translations$prayer$routine$es routine = _Translations$prayer$routine$es._(_root);
	@override String get together => 'Orar juntos';
	@override late final _Translations$prayer$reminders$es reminders = _Translations$prayer$reminders$es._(_root);
	@override late final _Translations$prayer$retreat$es retreat = _Translations$prayer$retreat$es._(_root);
	@override late final _Translations$prayer$session$es session = _Translations$prayer$session$es._(_root);
	@override late final _Translations$prayer$done$es done = _Translations$prayer$done$es._(_root);
	@override late final _Translations$prayer$topics$es topics = _Translations$prayer$topics$es._(_root);
	@override late final _Translations$prayer$lists$es lists = _Translations$prayer$lists$es._(_root);
	@override late final _Translations$prayer$importunity$es importunity = _Translations$prayer$importunity$es._(_root);
	@override late final _Translations$prayer$free$es free = _Translations$prayer$free$es._(_root);
}

// Path: sending
class _Translations$sending$es extends Translations$sending$fr {
	_Translations$sending$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Envío a mis autoridades';
	@override String get moreOff => 'Desactivado';
	@override String get intro => 'En el momento elegido, CMFI Connect prepara tu informe del período. Solo tienes que enviarlo a tus autoridades espirituales.';
	@override String get enabled => 'Prepararlo regularmente';
	@override String get rhythm => 'Ritmo';
	@override String get weekly => 'Cada semana';
	@override String get biweekly => 'Cada 2 semanas';
	@override String get monthly => 'Cada mes';
	@override String get day => 'Día';
	@override String get monthlyDay => 'El día 1 de cada mes, para el mes anterior';
	@override String get time => 'Hora';
	@override String get recipients => 'Destinatarios';
	@override String get noAuthorities => 'Primero añade tus autoridades espirituales.';
	@override String get addAuthorities => 'Añadir mis autoridades';
	@override String get viaWhatsApp => 'Por WhatsApp';
	@override String get viaEmail => 'Por e-mail';
	@override String get viaBoth => 'Por WhatsApp o e-mail';
	@override String get viaShare => 'Compartiendo';
	@override String next({required Object date}) => 'Próximo: ${date}';
	@override String get prepareNow => 'Preparar ahora';
	@override String get history => 'Últimos envíos';
	@override String get notificationTitle => 'Tu informe está listo';
	@override String get notificationBody => 'Envíalo a tus autoridades con un toque.';
	@override String get channel => 'Envío del informe';
	@override String get readyTitle => 'Tu informe está listo';
	@override String get preview => 'Vista previa del mensaje';
	@override String greeting({required Object name}) => 'Hola ${name},';
	@override String get whatsApp => 'WhatsApp';
	@override String get email => 'E-mail';
	@override String get sharePdf => 'Compartir el PDF';
	@override String get shareText => 'Compartir el texto';
	@override String get sent => 'Enviado';
	@override String get shared => 'Compartido';
	@override String get noRecipients => 'Elige tus destinatarios en los ajustes, o comparte el PDF.';
	@override String get settings => 'Ajustes';
	@override String get permissionDenied => 'Permite las notificaciones para recibir el aviso a tiempo.';
	@override String get inApp => 'Enviar en la app';
	@override String get viaApp => 'En la app';
	@override String inAppSent({required Object name}) => 'Enviado a ${name} en la app';
	@override String inAppUnavailable({required Object name}) => '${name} no puede recibirlo en la app por ahora.';
	@override String get inAppHistory => 'Enviados en la app';
	@override String get replied => 'Respondido';
	@override String get seen => 'Leído';
	@override String get formerAuthority => 'Antigua autoridad';
	@override String theirReply({required Object text}) => '«${text}»';
}

// Path: streak
class _Translations$streak$es extends Translations$streak$fr {
	_Translations$streak$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String title({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: '¡${n} día seguido!',
		other: '¡${n} días seguidos!',
	);
	@override String cardDays({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: 'día con Dios',
		other: 'días con Dios',
	);
	@override late final _Translations$streak$lines$es lines = _Translations$streak$lines$es._(_root);
	@override String get share => 'Compartir';
	@override String get close => 'Continuar';
}

// Path: shortcuts
class _Translations$shortcuts$es extends Translations$shortcuts$fr {
	_Translations$shortcuts$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get today => 'Llenar mi informe';
	@override String get hymns => 'Himnos';
	@override String get retreat => 'Retiro del momento';
}

// Path: blocking
class _Translations$blocking$es extends Translations$blocking$fr {
	_Translations$blocking$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get report => 'Reportar';
	@override String block({required Object name}) => 'Bloquear a ${name}';
	@override String blockTitle({required Object name}) => '¿Bloquear a ${name}?';
	@override String blockText({required Object name}) => 'Ya no recibirás invitaciones de ${name}. Esta invitación se retira.';
	@override String get blockAction => 'Bloquear';
	@override String blocked({required Object name}) => '${name} ya no podrá invitarte.';
	@override String get reportTitle => 'Reportar esta invitación';
	@override String get reportText => 'Dinos qué pasa: los responsables de la comunidad lo revisarán.';
	@override late final _Translations$blocking$reasons$es reasons = _Translations$blocking$reasons$es._(_root);
	@override String get comment => 'Comentario';
	@override String get commentHint => 'Lo que los responsables deben saber';
	@override String get send => 'Enviar el reporte';
	@override String get reported => 'Gracias, los responsables lo revisarán.';
	@override String get listTitle => 'Miembros bloqueados';
	@override String get intro => 'Sus invitaciones a orar ya no te llegan.';
	@override String get empty => 'No has bloqueado a nadie.';
	@override String get unblock => 'Desbloquear';
	@override String unblocked({required Object name}) => '${name} puede volver a invitarte.';
}

// Path: verses
class _Translations$verses$es extends Translations$verses$fr {
	_Translations$verses$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Versículo del día';
	@override String get share => 'Compartir el versículo';
	@override String get shareImage => 'Compartir la imagen';
	@override String get shareText => 'Compartir el texto';
}

// Path: bible
class _Translations$bible$es extends Translations$bible$fr {
	_Translations$bible$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Biblia';
	@override String get books => 'Libros';
	@override String get oldTestament => 'Antiguo Testamento';
	@override String get newTestament => 'Nuevo Testamento';
	@override String chapters({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: '${n} capítulo',
		other: '${n} capítulos',
	);
	@override String chapter({required Object n}) => 'Capítulo ${n}';
	@override String get version => 'Versión';
	@override String get versions => 'Versión de la Biblia';
	@override String get search => 'Buscar en la Biblia';
	@override String get searchHint => 'Una palabra, o «Juan 3:16»';
	@override String get searchTip => 'Busca una palabra («amor») o ve directamente a un pasaje («Salmos 23», «Juan 3:16»).';
	@override String get searchNone => 'Ningún versículo contiene estas palabras.';
	@override String searchCount({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: '${n} versículo',
		other: '${n} versículos',
	);
	@override String searchLimit({required Object n}) => 'Los primeros ${n} versículos';
	@override String get searchNeedsDownload => 'Para buscar palabras en toda la Biblia, descárgala. Ya puedes escribir un pasaje: «Juan 3:16».';
	@override String open({required Object reference}) => 'Abrir ${reference}';
	@override String get previous => 'Capítulo anterior';
	@override String get next => 'Capítulo siguiente';
	@override String get markRead => 'He leído este capítulo';
	@override String get markedRead => 'Leído hoy';
	@override String get markReadHint => 'Añade 1 capítulo a «Lectura bíblica» en tu informe.';
	@override String addedToReport({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: 'Informe: ${n} capítulo leído hoy',
		other: 'Informe: ${n} capítulos leídos hoy',
	);
	@override String get removedFromReport => 'Quitado de tu informe';
	@override String get noReadingItem => 'Tu informe no tiene el elemento «Lectura bíblica».';
	@override String get download => 'Descargar esta Biblia';
	@override String downloadHelp({required Object size}) => 'Unos ${size} MB, para leer y buscar sin conexión.';
	@override String downloading({required Object percent}) => 'Descargando… ${percent} %';
	@override String get downloaded => 'En tu teléfono';
	@override String downloadDone({required Object version}) => '${version} está en tu teléfono';
	@override String get removeDownload => 'Quitar del teléfono';
	@override String removeDownloadTitle({required Object version}) => '¿Quitar ${version} del teléfono?';
	@override String get removeDownloadText => 'Los capítulos que ya leíste siguen disponibles sin conexión.';
	@override String get offline => 'Este capítulo aún no está en tu teléfono. Vuelve a conectarte, o descarga esta Biblia para leerla sin conexión.';
	@override String get notInVersion => 'Este pasaje no está en esta versión.';
	@override String get marks => 'Mis versículos';
	@override String get favorites => 'Guardados';
	@override String get highlights => 'Resaltados';
	@override String get noFavorites => 'Toca un versículo y luego el marcador para encontrarlo aquí.';
	@override String get noHighlights => 'Toca un versículo y luego un color para resaltarlo.';
	@override String get tapHint => 'Toca un versículo para resaltarlo, guardarlo, copiarlo o compartirlo.';
	@override String highlight({required Object color}) => 'Resaltar en ${color}';
	@override late final _Translations$bible$colors$es colors = _Translations$bible$colors$es._(_root);
	@override String get removeHighlight => 'Quitar el color';
	@override String get addFavorite => 'Guardar en Mis versículos';
	@override String get removeFavorite => 'Quitar de Mis versículos';
	@override String get favoriteAdded => 'Guardado en Mis versículos';
	@override String get favoriteRemoved => 'Quitado de Mis versículos';
	@override String get copy => 'Copiar';
	@override String get copied => 'Copiado';
	@override String get share => 'Compartir';
	@override String get closeSelection => 'Cerrar la selección';
	@override String get display => 'Visualización';
	@override String get jesusInRed => 'Palabras de Jesús en rojo';
	@override String get jesusInRedHelp => 'En las versiones que las indican';
	@override String get remove => 'Quitar';
	@override String get readInBible => 'Leer en la Biblia';
	@override String get concordance => 'Concordancia';
	@override String concordanceOf({required Object word}) => 'Concordancia de «${word}»';
	@override String get concordanceHint => 'Una palabra de la Biblia';
	@override String get concordanceTip => 'Escribe una palabra: la concordancia muestra todos los versículos donde aparece, libro por libro.';
	@override String get concordanceNeedsDownload => 'La concordancia recorre toda la Biblia: descárgala primero.';
	@override String get concordanceNone => 'Esta palabra no está en esta Biblia.';
	@override String get exactWord => 'Esta palabra';
	@override String get startsWith => 'Empieza por…';
	@override String occurrences({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: 'vez',
		other: 'veces',
	);
	@override String inVerses({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: 'en ${n} versículo',
		other: 'en ${n} versículos',
	);
	@override String get spread => 'Dónde aparece esta palabra';
	@override String get forms => 'Formas encontradas';
	@override String bookCount({required Object book, required Object n}) => '${book}: ${n}';
	@override String get allBooks => 'Todos los libros';
	@override String get pickWord => 'Elige una palabra';
	@override String get pickWordHelp => 'La concordancia muestra todos los versículos donde aparece.';
	@override String get more => 'Más opciones';
	@override String get crossReferences => 'Referencias cruzadas';
	@override String crossReferencesOf({required Object passage}) => 'Referencias cruzadas · ${passage}';
	@override String get noCrossReferences => 'Ninguna referencia cruzada para este pasaje.';
	@override String get crossReferencesSource => 'Fuente: OpenBible.info (CC-BY)';
	@override String readOn({required Object site}) => 'Se lee en ${site} (texto protegido)';
	@override String get listen => 'Escuchar este capítulo';
	@override String listeningAt({required Object place, required Object verse}) => '${place} · versículo ${verse}';
	@override String get stopListening => 'Detener la lectura';
}

// Path: profilePhoto
class _Translations$profilePhoto$es extends Translations$profilePhoto$fr {
	_Translations$profilePhoto$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Foto de perfil';
	@override String get add => 'Añadir una foto de perfil';
	@override String get change => 'Cambiar la foto de perfil';
	@override String get seenBy => 'Los demás miembros la ven allí donde aparece tu nombre.';
	@override String get camera => 'Hacer una foto';
	@override String get gallery => 'Elegir de la galería';
	@override String get remove => 'Quitar la foto';
	@override String get cropTitle => 'Recorta tu foto';
	@override String get cropHint => 'Mueve y amplía la foto con los dedos.';
	@override String get use => 'Usar esta foto';
	@override String get unreadable => 'No se puede abrir esta imagen. Elige otra.';
	@override String get saved => 'Tu foto de perfil está guardada.';
	@override String get removed => 'Tu foto de perfil se ha quitado.';
}

// Path: disciples
class _Translations$disciples$es extends Translations$disciples$fr {
	_Translations$disciples$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Mis discípulos';
	@override String get empty => 'Aún no hay discípulos';
	@override String get emptyText => 'Cuando un miembro te elige como hacedor de discípulos o como autoridad y aceptas su solicitud, aparece aquí.';
	@override String count({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: '${n} discípulo',
		other: '${n} discípulos',
	);
	@override String get notShared => 'No comparte sus informes';
	@override String get roleMaker => 'Eres su hacedor de discípulos';
	@override String get roleAuthority => 'Eres una de sus autoridades';
	@override String dayGoals({required Object percent}) => 'Objetivos ${percent} %';
	@override String dayItems({required Object filled, required Object total, required Object percent}) => '${filled} de ${total} elementos · ${percent} %';
	@override String get older => 'Ver los 30 días anteriores';
	@override String get noReports => 'Ningún informe en este periodo.';
	@override String get searchHint => 'Nombre o usuario';
	@override String noMatch({required Object search}) => 'Ningún discípulo coincide con «${search}».';
}

// Path: weekStory
class _Translations$weekStory$es extends Translations$weekStory$fr {
	_Translations$weekStory$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Tu semana con Dios';
	@override String range({required Object from, required Object to}) => 'Del ${from} al ${to}';
	@override String get intro => 'Repasa lo que viviste con el Señor esta semana.';
	@override String get tapHint => 'Toca a la derecha para avanzar, a la izquierda para volver.';
	@override String get faithfulLead => 'Fuiste fiel';
	@override String get emptyLead => 'Una nueva semana te espera';
	@override String days({required num n, required Object total}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: '${n} día\nde ${total}',
		other: '${n} días\nde ${total}',
	);
	@override String streak({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: '${n} día seguido',
		other: '${n} días seguidos',
	);
	@override String streakRecord({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: '${n} día seguido: ¡tu récord!',
		other: '${n} días seguidos: ¡tu récord!',
	);
	@override String get emptyText => 'Llena tu informe cada día: tu próxima semana se escribirá aquí.';
	@override String get prayerLead => 'Oraste';
	@override String retreats({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: '${n} retiro',
		other: '${n} retiros',
	);
	@override String retreatsTime({required Object time}) => 'de 15 minutos · ${time} con el Señor';
	@override String faithfulMoment({required num n, required Object moment}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: 'Tu momento más fiel: ${moment} (${n} vez)',
		other: 'Tu momento más fiel: ${moment} (${n} veces)',
	);
	@override String get noRetreat => 'Ningún retiro esta semana';
	@override String get noRetreatText => 'El retiro del mediodía te espera: 15 minutos con el Señor.';
	@override String get goalsLead => 'Tus objetivos';
	@override String get goalsReached => 'alcanzados en promedio';
	@override String bestDay({required Object day, required Object percent}) => 'Tu mejor día: ${day} · ${percent}';
	@override String get summaryTitle => 'Mi semana con Dios';
	@override String get statDays => 'días llenados';
	@override String statStreak({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: 'día seguido',
		other: 'días seguidos',
	);
	@override String statRetreats({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: 'retiro',
		other: 'retiros',
	);
	@override String get statGoals => 'de objetivos';
	@override String get share => 'Compartir mi semana';
	@override String get homeText => 'Tu fidelidad, tu oración y tus objetivos de la semana.';
	@override String get open => 'Ver mi semana';
	@override String get notificationTitle => 'Tu semana con Dios está lista';
	@override String get notificationBody => 'Repasa tu fidelidad de la semana y compártela.';
	@override String get channel => 'Tu semana con Dios';
	@override String get thisWeek => 'Esta semana';
	@override String get pastWeeks => 'Semanas pasadas';
	@override String weekOf({required Object date}) => 'Semana del ${date}';
	@override String page({required Object current, required Object total}) => '${current} de ${total}';
}

// Path: yearStory
class _Translations$yearStory$es extends Translations$yearStory$fr {
	_Translations$yearStory$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Tu año con Dios';
	@override String since({required Object date}) => 'Desde el ${date}';
	@override String get intro => 'Repasa todo lo que viviste con el Señor este año.';
	@override String get tapHint => 'Toca a la derecha para avanzar, a la izquierda para volver.';
	@override String page({required Object current, required Object total}) => '${current} de ${total}';
	@override String get faithfulLead => 'Fuiste fiel';
	@override String days({required num n, required Object total}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: '${n} día\nde ${total}',
		other: '${n} días\nde ${total}',
	);
	@override String bestStreak({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: 'Tu racha más larga: ${n} día',
		other: 'Tu racha más larga: ${n} días seguidos',
	);
	@override String faithfulMonth({required num n, required Object month}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: 'Tu mes más fiel: ${month} (${n} día)',
		other: 'Tu mes más fiel: ${month} (${n} días)',
	);
	@override String get prayerLead => 'Oraste';
	@override String retreats({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: '${n} retiro',
		other: '${n} retiros',
	);
	@override String retreatsTime({required Object time}) => 'de 15 minutos · ${time} con el Señor';
	@override String prayerAlone({required Object time}) => '${time} de oración personal';
	@override String get prayerAloneText => 'de oración personal con el Señor';
	@override String faithfulMoment({required num n, required Object moment}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: 'Tu momento más fiel: ${moment} (${n} vez)',
		other: 'Tu momento más fiel: ${moment} (${n} veces)',
	);
	@override String get wordLead => 'Leíste la Palabra';
	@override String get memoryLead => 'Guardaste la Palabra en tu corazón';
	@override String chapters({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: '${n} capítulo',
		other: '${n} capítulos',
	);
	@override String bibleShare({required Object percent}) => '${percent} de la Biblia';
	@override String get wholeBible => '¡El equivalente a toda la Biblia!';
	@override String versesKnown({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: 'versículo aprendido de memoria',
		other: 'versículos aprendidos de memoria',
	);
	@override String versesLearning({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: 'versículo en memorización',
		other: 'versículos en memorización',
	);
	@override String get fastLead => 'Ayunaste';
	@override String fastDays({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: '${n} día',
		other: '${n} días',
	);
	@override String get fastText => 'de ayuno delante del Señor';
	@override String fullFasts({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: 'día de ayuno completo',
		other: 'días de ayuno completo',
	);
	@override String partialFasts({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: 'día de ayuno parcial',
		other: 'días de ayuno parcial',
	);
	@override String get goalsLead => 'Tus objetivos';
	@override String get goalsReached => 'alcanzados en promedio';
	@override String bestMonth({required Object month, required Object percent}) => 'Tu mejor mes: ${month} · ${percent}';
	@override String get summaryTitle => 'Mi año con Dios';
	@override String get statDays => 'días llenados';
	@override String statStreak({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: 'día seguido, tu récord',
		other: 'días seguidos, tu récord',
	);
	@override String statRetreats({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: 'retiro',
		other: 'retiros',
	);
	@override String get statPrayer => 'de oración personal';
	@override String statChapters({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: 'capítulo leído',
		other: 'capítulos leídos',
	);
	@override String statFasts({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: 'día de ayuno',
		other: 'días de ayuno',
	);
	@override String get statGoals => 'de objetivos';
	@override String get emptyText => 'Llena tu informe cada día: tu año se escribirá aquí.';
	@override String get share => 'Compartir mi año';
	@override String homeText({required Object year}) => 'Tu fidelidad, tu oración, la Palabra: repasa todo lo que viviste con Dios en ${year}.';
	@override String get open => 'Ver mi año';
	@override String get notificationTitle => 'Tu año con Dios está listo';
	@override String notificationBody({required Object year}) => 'Repasa todo lo que viviste con el Señor en ${year} y compártelo.';
	@override String get channel => 'Tu año con Dios';
	@override String get moreTitle => 'Mi año con Dios';
	@override String moreSoFar({required Object year}) => '${year} hasta ahora';
	@override String moreDone({required Object year}) => 'Todo el año ${year}';
}

// Path: seekFirst
class _Translations$seekFirst$es extends Translations$seekFirst$fr {
	_Translations$seekFirst$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Busca primero a Dios';
	@override String get verse => 'Mas buscad primeramente el reino de Dios y su justicia, y todas estas cosas os serán añadidas.';
	@override String get verseRef => 'Mateo 6:33';
	@override String get intro => 'Cada día, las apps que elijas quedan cerradas hasta que guardes tu informe. Empieza tu día con Dios; lo demás viene después.';
	@override String get enable => 'Activar';
	@override String get apps => 'Apps que se cierran';
	@override String get appsNone => 'Ninguna app elegida';
	@override String appCount({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: '${n} app',
		other: '${n} apps',
	);
	@override String categoryCount({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: '${n} categoría',
		other: '${n} categorías',
	);
	@override String siteCount({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: '${n} sitio',
		other: '${n} sitios',
	);
	@override String get start => 'Cerradas desde';
	@override String get pauses => 'Pausas de 5 minutos';
	@override String get pausesText => '3 al día, para una urgencia';
	@override String pausesLeft({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		zero: 'Ninguna pausa más hoy',
		one: 'Queda ${n} pausa hoy',
		other: 'Quedan ${n} pausas hoy',
	);
	@override String get todayOpen => 'Hoy tus apps están abiertas: buscaste primero a Dios.';
	@override String get todayLocked => 'Tus apps siguen cerradas hasta tu informe de hoy.';
	@override String todayBefore({required Object time}) => 'Tus apps se cerrarán a las ${time} si tu informe aún no está guardado.';
	@override String get fillReport => 'Llenar mi informe';
	@override String get denied => 'Sin acceso a Tiempo en pantalla, CMFI Connect no puede cerrar apps. Puedes permitirlo en Ajustes › Tiempo en pantalla.';
	@override String get noApps => 'Elige al menos una app que quede cerrada.';
	@override String get unsupported => 'Pronto disponible en este teléfono.';
	@override String moreOn({required Object time}) => 'Desde las ${time}, hasta tu informe';
	@override String get moreOff => 'Cerrar apps hasta que tu informe esté hecho';
	@override String get privacy => 'CMFI Connect nunca ve las apps que eliges: tu iPhone las guarda para sí.';
	@override late final _Translations$seekFirst$shield$es shield = _Translations$seekFirst$shield$es._(_root);
	@override String get permissionsAndroid => 'Para cerrar tus apps, CMFI Connect necesita dos permisos, que activarás en los ajustes que se van a abrir: «Acceso a datos de uso» (saber qué app está abierta) y «Mostrar sobre otras apps» (mostrar la pantalla Busca primero a Dios). Nada sale de tu teléfono.';
	@override String get permissionsContinue => 'Continuar';
	@override String get deniedAndroid => 'Sin estos dos permisos, CMFI Connect no puede cerrar apps. Puedes activarlos en Ajustes › Aplicaciones › Acceso especial.';
	@override String get privacyAndroid => 'Las apps que eliges se quedan en tu teléfono: CMFI Connect nunca las envía.';
}

// Path: documents
class _Translations$documents$es extends Translations$documents$fr {
	_Translations$documents$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Nuestros documentos';
	@override String get subtitle => 'Enseñanzas, reglamentos, formularios…';
	@override String get moreSubtitle => 'La biblioteca de la comunidad';
	@override String get search => 'Buscar un documento';
	@override String get all => 'Todos';
	@override String get empty => 'Aún no hay documentos. Los documentos que publique la comunidad aparecerán aquí.';
	@override String get none => 'Ningún documento coincide con tu búsqueda.';
	@override String sizeKb({required Object n}) => '${n} KB';
	@override String sizeMb({required Object n}) => '${n} MB';
	@override String get pdf => 'PDF';
	@override String get word => 'Word';
	@override String get open => 'Abrir el documento';
	@override String get download => 'Descargar';
	@override String count({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: '${n} documento',
		other: '${n} documentos',
	);
	@override String get more => 'Ver más';
}

// Path: biblePlan
class _Translations$biblePlan$es extends Translations$biblePlan$fr {
	_Translations$biblePlan$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Plan de lectura';
	@override String get duration => 'Duración';
	@override String get months3 => '3 meses';
	@override String get months6 => '6 meses';
	@override String get year => '1 año';
	@override String get custom => 'Otra';
	@override String unitMonths({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: 'mes',
		other: 'meses',
	);
	@override String get unitYear => 'año';
	@override String days({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: '${n} día',
		other: '${n} días',
	);
	@override String get scope => 'Qué lees';
	@override Map<String, String> get scopes => {
		'bible': 'Toda la Biblia',
		'newTestament': 'El Nuevo Testamento',
		'oldTestament': 'El Antiguo Testamento',
		'psalmsProverbs': 'Salmos y Proverbios',
	};
	@override String chaptersShort({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: '${n} cap.',
		other: '${n} cap.',
	);
	@override String get oldTestament => 'Antiguo Testamento';
	@override String get newTestament => 'Nuevo Testamento';
	@override String get order => 'Orden';
	@override Map<String, String> get orders => {
		'canonical': 'Libro por libro',
		'parallel': 'AT + NT cada día',
	};
	@override String get reminder => 'Recordatorio diario';
	@override String get reminderAt => 'Hora del recordatorio';
	@override String summary({required Object chapters, required Object days, required Object perDay}) => '${chapters} capítulos en ${days} días, unos ${perDay} al día';
	@override String chapterCount({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: '${n} capítulo',
		other: '${n} capítulos',
	);
	@override String inDays({required Object days}) => 'en ${days}';
	@override String perDayAbout({required Object perDay}) => 'unos ${perDay} al día';
	@override String endsOn({required Object date}) => 'Termina el ${date}';
	@override String startsOn({required Object date}) => 'El plan empieza el ${date}.';
	@override String get start => 'Empezar el plan';
	@override String dayOf({required Object day, required Object total}) => 'Día ${day} de ${total}';
	@override String get today => 'Lectura del día';
	@override String get todayDone => 'Lectura del día hecha. ¡Bravo!';
	@override String get read => 'Leer';
	@override String behind({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: '${n} día de retraso',
		other: '${n} días de retraso',
	);
	@override String get catchUp => 'Toca aquí para ver los capítulos atrasados.';
	@override String get catchUpShort => 'ponerse al día';
	@override String chaptersRead({required Object read, required Object total}) => '${read} de ${total} capítulos';
	@override String get late => 'Atrasados';
	@override String get upcoming => 'Próximos';
	@override String dayNumber({required Object n}) => 'Día ${n}';
	@override String get finished => '¡Plan terminado! Lo leíste todo.';
	@override String get stop => 'Detener el plan';
	@override String get stopTitle => '¿Detener este plan?';
	@override String get stopText => 'Se borrará tu progreso en este plan. Los capítulos contados en tus informes se quedan.';
	@override String get reminderTitle => 'Tu lectura del día';
	@override String get reminderChannel => 'Plan de lectura';
	@override String get homeTitle => 'Lectura del día';
	@override String check({required Object chapter}) => 'Marcar ${chapter} como leído';
	@override String uncheck({required Object chapter}) => '${chapter}: leído';
	@override String get listen => 'Escuchar la lectura de hoy';
}

// Path: teachings
class _Translations$teachings$es extends Translations$teachings$fr {
	_Translations$teachings$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Enseñanzas';
	@override String get subtitle => 'Escucha la Palabra estés donde estés';
	@override String get search => 'Buscar un mensaje, un predicador…';
	@override String get all => 'Todos';
	@override String get downloadedChip => 'Descargados';
	@override String count({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: '${n} mensaje',
		other: '${n} mensajes',
	);
	@override String get empty => 'Aún no hay enseñanzas.';
	@override String get none => 'Ninguna enseñanza coincide.';
	@override String get noneDownloaded => 'Ningún mensaje descargado. Toca la nube de un mensaje para escucharlo sin red.';
	@override String get more => 'Ver más';
	@override String get offline => 'Sin red: estos son los mensajes guardados en tu teléfono.';
	@override String get play => 'Escuchar';
	@override String get pause => 'Pausa';
	@override String get heard => 'Escuchado';
	@override String get download => 'Descargar para escuchar sin red';
	@override String get downloaded => 'Guardado en tu teléfono';
	@override String get removed => 'Quitado del teléfono';
	@override String get cancelDownload => 'Detener la descarga';
	@override String get removeDownload => 'Quitar del teléfono';
	@override String get back15 => 'Retroceder 15 segundos';
	@override String get forward15 => 'Avanzar 15 segundos';
	@override String speed({required Object speed}) => 'Velocidad ${speed}';
	@override String recordedOn({required Object date}) => 'Mensaje del ${date}';
	@override String get moreSubtitle => 'Predicaciones y enseñanzas para escuchar';
	@override String get closePlayer => 'Cerrar el reproductor';
}

// Path: memorize
class _Translations$memorize$es extends Translations$memorize$fr {
	_Translations$memorize$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Memorización';
	@override String get subtitle => 'Guarda la Palabra en tu corazón';
	@override String get toReview => 'Por repasar';
	@override String get learning => 'Aprendiendo';
	@override String get known => 'Sabidos';
	@override String reviewCount({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: 'Repasar ${n} versículo',
		other: 'Repasar ${n} versículos',
	);
	@override String get nothingDue => 'Nada que repasar hoy.';
	@override String nextOn({required Object date}) => 'Próximo repaso: ${date}.';
	@override String get tomorrow => 'mañana';
	@override String get reminder => 'Recordatorio de repaso';
	@override String get reminderAt => 'Hora del recordatorio';
	@override String get myVerses => 'Mis versículos';
	@override String get howToAdd => 'Para añadir uno: en la Biblia, toca un versículo y luego el cerebro de la barra.';
	@override String get empty => 'Aún no hay versículos para memorizar.';
	@override String get openBible => 'Abrir la Biblia';
	@override String get late => 'Atrasado';
	@override String get today => 'Hoy';
	@override String dueIn({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: 'En ${n} día',
		other: 'En ${n} días',
	);
	@override Map<String, String> get stages => {
		'fresh': 'Nuevo',
		'learning': 'Aprendiendo',
		'known': 'Sabido',
	};
	@override String stats({required Object stage, required Object lapses}) => '${stage} · olvidado ${lapses} veces';
	@override String get reviewNow => 'Repasar ahora';
	@override String get remove => 'Quitar';
	@override String get removeTitle => '¿Quitar este versículo?';
	@override String get removeText => 'Se borrará su progreso.';
	@override String get removed => 'Versículo quitado';
	@override String progress({required Object done, required Object total}) => '${done} / ${total}';
	@override String get show => 'Ver el versículo';
	@override Map<String, String> get hints => {
		'full': 'Texto',
		'gaps': 'Huecos',
		'initials': 'Iniciales',
		'none': 'Nada',
	};
	@override String get recite => 'Recita el versículo y luego comprueba.';
	@override Map<String, String> get grades => {
		'again': 'Otra vez',
		'hard': 'Difícil',
		'good': 'Bien',
		'easy': 'Fácil',
	};
	@override String get now => 'Enseguida';
	@override String later({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: '${n} día',
		other: '${n} días',
	);
	@override String get doneTitle => '¡Repaso terminado!';
	@override String doneText({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: 'Repasaste ${n} versículo. ¡Que la Palabra more en ti!',
		other: 'Repasaste ${n} versículos. ¡Que la Palabra more en ti!',
	);
	@override String get back => 'Volver';
	@override String get reminderTitle => 'Tus versículos por repasar';
	@override String reminderBody({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: '${n} versículo te espera hoy.',
		other: '${n} versículos te esperan hoy.',
	);
	@override String get reminderChannel => 'Memorización';
	@override String get homeTitle => 'Versículos por repasar';
	@override String homeText({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: '${n} versículo te espera',
		other: '${n} versículos te esperan',
	);
	@override String get menu => 'Memorizar versículos';
	@override String get memorize => 'Memorizar';
	@override String get added => 'Añadido a tus versículos para memorizar';
	@override String get already => 'Este pasaje ya está en tus versículos';
}

// Path: souls
class _Translations$souls$es extends Translations$souls$fr {
	_Translations$souls$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Seguimiento de almas';
	@override String get subtitle => '«El que gana almas es sabio.» Proverbios 11:30';
	@override String get search => 'Buscar una persona…';
	@override String get people => 'Personas';
	@override String get received => 'Recibieron a Jesús';
	@override String get toContact => 'Por contactar';
	@override String get all => 'Todas';
	@override Map<String, String> get stages => {
		'met': 'Conocido(a)',
		'interested': 'Interesado(a)',
		'received': 'Recibió a Jesús',
		'followUp': 'En afianzamiento',
		'church': 'Viene a la iglesia',
		'baptized': 'Bautizado(a)',
	};
	@override String get contactSection => 'Por volver a contactar';
	@override String get everyone => 'Todas las personas';
	@override String get contactToday => 'Contactar hoy';
	@override String contactLate({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: 'Con ${n} día de retraso',
		other: 'Con ${n} días de retraso',
	);
	@override String contactOn({required Object date}) => 'Próximo contacto el ${date}';
	@override String get empty => 'Anota aquí a las personas que evangelizas: ora por ellas y acompáñalas hasta la iglesia.';
	@override String get none => 'Nadie coincide.';
	@override String get add => 'Añadir';
	@override String get addTitle => 'Nueva persona';
	@override String get editTitle => 'Editar';
	@override String get name => 'Nombre';
	@override String get nameRequired => 'Escribe su nombre.';
	@override String get phone => 'Teléfono';
	@override String get place => 'Dónde se conocieron';
	@override String get metOn => 'Conocido(a) el';
	@override String get stage => '¿En qué punto está?';
	@override String get firstNote => 'Una nota (opcional)';
	@override String get noteHint => 'Lo que se dijo, motivos de oración…';
	@override String get save => 'Guardar';
	@override String get saved => 'Guardado';
	@override String get call => 'Llamar';
	@override String get whatsApp => 'WhatsApp';
	@override String get sms => 'SMS';
	@override String get edit => 'Editar';
	@override String get delete => 'Eliminar';
	@override String deleteTitle({required Object name}) => '¿Eliminar a ${name}?';
	@override String get deleteText => 'Sus notas se borrarán de tu teléfono.';
	@override String get deleted => 'Eliminado';
	@override String get nextContact => 'Próximo contacto';
	@override String get plan => 'Programar un recordatorio';
	@override String get change => 'Cambiar la fecha';
	@override String get clear => 'Quitar el recordatorio';
	@override String get noContact => 'Ningún recordatorio previsto';
	@override String metAt({required Object date}) => 'Conocido(a) el ${date}';
	@override String get notes => 'Notas';
	@override String get addNote => 'Añadir la nota';
	@override String get noNotes => 'Aún no hay notas.';
	@override String get deleteNote => 'Eliminar la nota';
	@override String get export => 'Exportar (hoja de cálculo)';
	@override late final _Translations$souls$csv$es csv = _Translations$souls$csv$es._(_root);
	@override String lock({required Object method}) => 'Bloquear con ${method}';
	@override String get lockedTitle => 'Tu seguimiento de almas está bloqueado';
	@override String get unlock => 'Desbloquear';
	@override String get unlockReason => 'Abre tu seguimiento de almas';
	@override String get privacy => 'Esta información se queda en tu teléfono: nunca se envía.';
	@override String get reminderTitle => 'Seguimiento de almas';
	@override String reminderBody({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: '${n} persona por contactar hoy.',
		other: '${n} personas por contactar hoy.',
	);
	@override String get reminderChannel => 'Seguimiento de almas';
	@override String get moreSubtitle => 'Las personas que evangelizas';
	@override String get prayToday => 'Hoy, ora por';
	@override String get prayerReminder => 'Recordármelo cada mañana';
	@override String get prayerReminderAt => 'Hora del recordatorio de oración';
	@override String get prayerTitle => 'Ora por un alma';
	@override String get prayerBody => 'Tómate un momento para orar por la persona del día.';
	@override String get prayerChannel => 'Oración por las almas';
}

// Path: fasts
class _Translations$fasts$es extends Translations$fasts$fr {
	_Translations$fasts$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Mis ayunos';
	@override String get intro => 'Apártate para Dios: elige tu ayuno y por qué ayunas. Cada día cumplido cuenta en tu informe.';
	@override String get moreSubtitle => 'Ayuno completo o parcial, contado cada día';
	@override String get kind => 'Tu ayuno';
	@override Map<String, String> get kinds => {
		'full': 'Ayuno completo',
		'partial': 'Ayuno parcial',
	};
	@override Map<String, String> get kindTexts => {
		'full': 'Día y noche, 24 horas al día, desde ahora.',
		'partial': 'Cada día hasta la hora elegida; luego rompes el ayuno.',
	};
	@override String get length => 'Duración';
	@override String days({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: '${n} día',
		other: '${n} días',
	);
	@override String get endEachDay => 'Fin del ayuno cada día';
	@override String get topics => 'Ayuno por';
	@override String get topicHint => 'Un motivo de oración…';
	@override String get addTopic => 'Añadir el motivo';
	@override String get removeTopic => 'Quitar el motivo';
	@override String get history => 'Mis últimos ayunos';
	@override String kept({required Object kept, required Object days}) => '${kept}/${days} días';
	@override String get start => 'Comenzar el ayuno';
	@override String until({required Object date}) => 'Hasta el ${date}';
	@override String hoursLeft({required Object h, required Object m}) => '${h} h ${m}';
	@override String minutesLeft({required Object m}) => '${m} min';
	@override String dayOf({required Object day, required Object total}) => 'Día ${day} de ${total}';
	@override String dayEnds({required Object time}) => 'Este día termina a las ${time}';
	@override String get stop => 'Romper el ayuno';
	@override String get stopTitle => '¿Romper tu ayuno?';
	@override String get stopText => 'Los días ya cumplidos siguen contados. El día en curso no.';
	@override String counted({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: '${n} día de ayuno contado en tu informe',
		other: '${n} días de ayuno contados en tu informe',
	);
	@override String reportNote({required Object item}) => 'Cada día cumplido suma 1 a «${item}» en tu informe.';
	@override Map<String, String> get items => {
		'full': 'Ayuno completo',
		'partial': 'Ayuno parcial',
	};
	@override String dayTitle({required Object day}) => 'Día ${day} de ayuno cumplido';
	@override String get dayBody => 'Cuenta en tu informe. ¡Ánimo, sigue!';
	@override String get endTitle => 'Tu ayuno ha terminado';
	@override String get endBody => 'Que el Señor responda a tus oraciones.';
	@override String get channel => 'Mis ayunos';
	@override String homeTitle({required Object day, required Object total}) => 'Ayuno · día ${day} de ${total}';
	@override String homeText({required Object time}) => 'Este día termina a las ${time}';
}

// Path: received
class _Translations$received$es extends Translations$received$fr {
	_Translations$received$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Informes recibidos';
	@override String get subtitle => 'Enviados por tus discípulos en la app';
	@override String unreadCount({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: '${n} nuevo',
		other: '${n} nuevos',
	);
	@override String get empty => 'Aún no has recibido ningún informe. Cuando un discípulo te envíe el suyo en la app, llegará aquí.';
	@override String day({required Object date}) => 'El ${date}';
	@override String period({required Object from, required Object to}) => 'Del ${from} al ${to}';
	@override String get unread => 'Nuevo';
	@override String yourReply({required Object text}) => 'Tu respuesta: «${text}»';
	@override String get open => 'Ver';
	@override String get encourage => 'Animar';
	@override String get editReply => 'Cambiar';
	@override String encourageTitle({required Object name}) => 'Una palabra para ${name}';
	@override List<String> get suggestions => [
		'¡Qué fidelidad, sigue así!',
		'Oro por ti.',
		'¡Que Dios te fortalezca!',
		'Bravo por tu perseverancia.',
	];
	@override String get hint => 'Escribe tu ánimo…';
	@override String get send => 'Enviar';
	@override String sent({required Object name}) => '${name} recibió tu palabra';
}

// Path: update
class _Translations$update$es extends Translations$update$fr {
	_Translations$update$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get requiredTitle => 'Actualización necesaria';
	@override String get requiredText => 'Esta versión de la aplicación ya no es compatible. Instala la nueva versión para continuar.';
	@override String get availableTitle => 'Nueva versión disponible';
	@override String availableText({required Object version}) => 'La versión ${version} está lista, con mejoras y correcciones.';
	@override String get update => 'Actualizar';
	@override String get later => 'Más tarde';
	@override String versions({required Object installed, required Object target}) => 'Tu versión: ${installed} · Nueva: ${target}';
	@override String get downloading => 'Descargando la actualización…';
	@override String get readyTitle => 'La actualización está lista';
	@override String get readyText => 'Reinicia la aplicación para instalarla. Si no, se instalará cuando salgas de ella.';
	@override String get restart => 'Reiniciar';
	@override String get failed => 'No se pudo abrir la tienda. Inténtalo más tarde.';
	@override String moreButton({required Object version}) => 'Actualizar a la versión ${version}';
}

// Path: welcome.seek
class _Translations$welcome$seek$es extends Translations$welcome$seek$fr {
	_Translations$welcome$seek$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get before => 'Busca primero a ';
	@override String get marked => 'Dios';
	@override String get after => ', cada día';
	@override String get text => 'Anota en pocos segundos tu lectura bíblica, tu oración, tus ayunos… y mira tu progreso semana tras semana.';
}

// Path: welcome.worship
class _Translations$welcome$worship$es extends Translations$welcome$worship$fr {
	_Translations$welcome$worship$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get before => 'Canta y ';
	@override String get marked => 'ora';
	@override String get after => ', estés donde estés';
	@override String get text => 'Encuentra los himnos de la comunidad e intercede cada día por los motivos de oración junto a tus hermanos y hermanas.';
}

// Path: welcome.community
class _Translations$welcome$community$es extends Translations$welcome$community$fr {
	_Translations$welcome$community$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get before => 'Mantente unido a tu ';
	@override String get marked => 'comunidad';
	@override String get after => '';
	@override String get text => 'Los eventos y los anuncios de tu asamblea, en un solo lugar, para que no te pierdas nada.';
}

// Path: welcome.sample
class _Translations$welcome$sample$es extends Translations$welcome$sample$fr {
	_Translations$welcome$sample$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get bibleReading => 'Lectura bíblica';
	@override String get chapters => '10 cap.';
	@override String get prayerAlone => 'Oración a solas';
	@override String get hymn => 'Himno';
	@override String get hymnNumber => 'N.º 12';
	@override String get prayerOfTheDay => 'Motivo de oración del día';
	@override String get prayerTopic => 'Por los exámenes de nuestros jóvenes';
	@override String get praying => '12 personas oran';
	@override String get iPray => 'Oraré';
	@override String get retreat => 'Retiro de jóvenes';
	@override String get announcement => 'Anuncio';
	@override String get announcementText => 'El culto del domingo empieza a las 8:30.';
}

// Path: auth.login
class _Translations$auth$login$es extends Translations$auth$login$fr {
	_Translations$auth$login$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => '¡Hola de nuevo!';
	@override String get subtitle => 'Inicia sesión para retomar tu caminar con Dios y tu comunidad.';
	@override String get welcomeBack => '¡Qué bueno verte!';
	@override String get submit => 'Iniciar sesión';
	@override String get noAccount => '¿Aún no tienes cuenta?';
	@override String get createAccount => 'Crear una cuenta';
}

// Path: auth.register
class _Translations$auth$register$es extends Translations$auth$register$fr {
	_Translations$auth$register$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String step({required Object current, required Object total}) => '${current} / ${total}';
	@override String get title => 'Crea tu cuenta';
	@override String get subtitle => 'Usarás tu número de teléfono para iniciar sesión.';
	@override String get firstName => 'Nombre';
	@override String get lastName => 'Apellido';
	@override String get passwordHelp => 'Mínimo 6 caracteres';
	@override String get email => 'Correo electrónico';
	@override String get submit => 'Continuar';
	@override String get haveAccount => '¿Ya tienes cuenta?';
	@override String get login => 'Iniciar sesión';
	@override String get alreadyUsed => 'Este número o este correo ya tiene una cuenta. Inicia sesión.';
	@override String get emailHint => 'tu@ejemplo.com';
}

// Path: auth.church
class _Translations$auth$church$es extends Translations$auth$church$fr {
	_Translations$auth$church$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Tu iglesia';
	@override String get subtitle => 'Estos datos ayudan a tus líderes a encontrarte. Podrás cambiarlos más tarde.';
	@override String get editTitle => 'Mi perfil';
	@override String get editSubtitle => 'Actualiza tu nombre, tu iglesia y tu asamblea.';
	@override String get country => 'País';
	@override String get countryHint => 'Elige tu país';
	@override String get city => 'Ciudad';
	@override String get cityHint => 'Yaoundé';
	@override String get church => 'Iglesia';
	@override String get churchHint => 'Nombre de tu iglesia';
	@override String get assembly => 'Asamblea';
	@override String get assemblyHint => 'Nombre de tu asamblea';
	@override String get info => '¿Te mudaste o cambiaste de asamblea? Podrás actualizarlo todo desde tu perfil.';
	@override String get submit => 'Terminar';
	@override String get skip => 'Omitir este paso';
	@override String get saved => 'Perfil guardado';
}

// Path: auth.forgot
class _Translations$auth$forgot$es extends Translations$auth$forgot$fr {
	_Translations$auth$forgot$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get link => '¿Olvidaste tu contraseña?';
	@override String get title => 'Contraseña olvidada';
	@override String get phoneText => 'Escribe tu número: te enviamos un código por SMS para elegir una nueva contraseña.';
	@override String get sendCode => 'Recibir el código';
	@override String get codeTitle => 'Escribe el código';
	@override String codeText({required Object phone}) => 'Enviamos un código de 6 cifras al ${phone}.';
	@override String get code => 'Código recibido por SMS';
	@override String get codeInvalid => 'El código tiene 6 cifras';
	@override String get verify => 'Verificar';
	@override String get resend => 'Reenviar el código';
	@override String resendIn({required Object seconds}) => 'Reenviar en ${seconds} s';
	@override String get changeNumber => 'Cambiar de número';
	@override String get passwordTitle => 'Nueva contraseña';
	@override String get passwordText => 'Elige una nueva contraseña para tu cuenta.';
	@override String get submit => 'Guardar e iniciar sesión';
	@override String get done => 'Contraseña cambiada. ¡Qué bueno verte de nuevo!';
	@override String get remembered => '¿La recordaste?';
	@override String get invalidCode => 'Ese código no es correcto.';
	@override String get expired => 'El código caducó. Pide uno nuevo.';
	@override String get tooManyRequests => 'Demasiados intentos. Inténtalo más tarde.';
	@override String get unavailable => 'El restablecimiento no está disponible por ahora.';
	@override String get noAccount => 'Ninguna cuenta usa este número.';
}

// Path: auth.biometric
class _Translations$auth$biometric$es extends Translations$auth$biometric$fr {
	_Translations$auth$biometric$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get faceId => 'Face ID';
	@override String get touchId => 'Touch ID';
	@override String get fingerprint => 'tu huella';
	@override String get face => 'tu rostro';
	@override String signIn({required Object method}) => 'Entrar con ${method}';
	@override String askTitle({required Object method}) => '¿Entrar con ${method}?';
	@override String get askText => 'La próxima vez no tendrás que escribir tu contraseña: queda en la caja fuerte segura de tu teléfono.';
	@override String get enable => 'Activar';
	@override String get later => 'Más tarde';
	@override String get reason => 'Entra en CMFI Connect';
	@override String get enableReason => 'Activa el acceso rápido a CMFI Connect';
	@override String changed({required Object method}) => 'Tu contraseña cambió: entra con tu contraseña y vuelve a activar ${method}.';
	@override String settings({required Object method}) => 'Entrar con ${method}';
	@override String get settingsText => 'Sin escribir tu contraseña';
	@override String get passwordTitle => 'Tu contraseña';
	@override String get passwordLabel => 'Contraseña';
	@override String get confirm => 'Confirmar';
	@override String enabled({required Object method}) => 'Acceso con ${method} activado';
}

// Path: reports.tabs
class _Translations$reports$tabs$es extends Translations$reports$tabs$fr {
	_Translations$reports$tabs$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get today => 'Hoy';
	@override String get history => 'Historial';
	@override String get summary => 'Resumen';
}

// Path: reports.measure
class _Translations$reports$measure$es extends Translations$reports$measure$fr {
	_Translations$reports$measure$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String quantity({required Object unit}) => '${unit}';
	@override String get duration => 'duración';
	@override String both({required Object unit}) => '${unit} y duración';
	@override String get quantityNoUnit => 'cantidad';
	@override String get bothNoUnit => 'cantidad y duración';
}

// Path: reports.sheet
class _Translations$reports$sheet$es extends Translations$reports$sheet$fr {
	_Translations$reports$sheet$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get quantity => 'Cantidad';
	@override String get duration => 'Duración';
	@override String get minus1 => '− 1 min';
	@override String get plus1 => '+ 1 min';
	@override String get removeMinute => 'Quitar un minuto';
	@override String get addMinute => 'Añadir un minuto';
	@override String get holdToRepeat => 'Mantén presionado para ir más rápido';
	@override String get decrease => 'Disminuir';
	@override String get increase => 'Aumentar';
	@override String get clear => 'Borrar';
	@override String get validate => 'Listo';
}

// Path: reports.history
class _Translations$reports$history$es extends Translations$reports$history$fr {
	_Translations$reports$history$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String daysFilled({required Object filled, required Object total}) => '${filled} días completados de ${total}';
	@override String get legendFilled => 'Completado';
	@override String get legendMissing => 'Sin informe';
	@override String get none => 'Sin informe';
	@override String get fill => 'Completar';
	@override String get inProgress => 'En curso';
	@override String get previousMonth => 'Mes anterior';
	@override String get nextMonth => 'Mes siguiente';
	@override String get today => 'hoy';
}

// Path: reports.summary
class _Translations$reports$summary$es extends Translations$reports$summary$fr {
	_Translations$reports$summary$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get week => 'Semana';
	@override String get month => 'Mes';
	@override String get year => 'Año';
	@override String range({required Object from, required Object to}) => 'Del ${from} al ${to}';
	@override String get regularity => 'Constancia';
	@override String get daysFilled => 'días completados';
	@override String missingDays({required num n, required Object days}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: '${n} día sin informe: el ${days}',
		other: '${n} días sin informe: los días ${days}',
	);
	@override String missingCount({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: '${n} día sin informe',
		other: '${n} días sin informe',
	);
	@override String get noMissing => 'No faltó ningún día, ¡bien hecho!';
	@override String perDay({required Object value}) => '${value} por día completado';
	@override String days({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: '${n} día',
		other: '${n} días',
	);
	@override String get notFilled => 'Aún sin completar';
	@override String barsCaption({required Object max}) => 'Por día · barra más alta: ${max}';
	@override String barsCaptionMonthly({required Object max}) => 'Por mes · barra más alta: ${max}';
	@override String get empty => 'No hay informes en este período.';
	@override String goalDays({required num n, required Object total}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: 'Objetivo alcanzado ${n} día de ${total}',
		other: 'Objetivo alcanzado ${n} días de ${total}',
	);
	@override String get share => 'Compartir este resumen';
	@override String get goals => 'Objetivos';
	@override String get goalsAverage => 'Cumplimiento medio de tus objetivos';
	@override String get goalsHint => 'Cada día cuenta, incluso vacío. Hoy cuenta una vez rellenado.';
	@override String get evolution => 'Evolución de tus objetivos';
	@override String get evolutionHint => 'Semana tras semana, en las últimas 12.';
	@override String get premiumYear => 'El año y la evolución de tus objetivos vienen con Premium.';
}

// Path: reports.standardItems
class _Translations$reports$standardItems$es extends Translations$reports$standardItems$fr {
	_Translations$reports$standardItems$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get lb => 'Lectura bíblica';
	@override String get ps => 'Oración personal';
	@override String get rdqad => 'Meditación';
	@override String get pg => 'Oración en grupo';
	@override String get llc => 'Lectura de literatura cristiana';
	@override String get jc => 'Ayuno completo';
	@override String get jp => 'Ayuno parcial';
	@override String get dimes => 'Diezmos';
	@override String get off => 'Ofrendas';
}

// Path: reports.units
class _Translations$reports$units$es extends Translations$reports$units$fr {
	_Translations$reports$units$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override late final _Translations$reports$units$chapters$es chapters = _Translations$reports$units$chapters$es._(_root);
	@override late final _Translations$reports$units$times$es times = _Translations$reports$units$times$es._(_root);
	@override late final _Translations$reports$units$pages$es pages = _Translations$reports$units$pages$es._(_root);
	@override late final _Translations$reports$units$percent$es percent = _Translations$reports$units$percent$es._(_root);
}

// Path: reports.timer
class _Translations$reports$timer$es extends Translations$reports$timer$fr {
	_Translations$reports$timer$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get start => 'Iniciar el cronómetro';
	@override String get running => 'Cronómetro en marcha';
	@override String get startEnd => 'Inicio – fin';
	@override String get from => 'Hora de inicio';
	@override String get to => 'Hora de fin';
	@override String span({required Object from, required Object to}) => 'De ${from} a ${to}';
	@override String get pause => 'Pausar';
	@override String get resume => 'Reanudar';
	@override String get finish => 'Terminar';
	@override String get discard => 'Cancelar el cronómetro';
	@override String get paused => 'En pausa';
	@override String added({required Object time, required Object item}) => '${time} añadidos a «${item}»';
	@override String get noItem => 'El cronómetro se detuvo, pero este elemento ya no está en tu informe.';
	@override String get replaceTitle => '¿Reemplazar el cronómetro?';
	@override String replaceText({required Object item}) => 'Ya hay un cronómetro para «${item}». Se detendrá sin contarse.';
	@override String get replace => 'Reemplazar';
	@override String get channel => 'Cronómetro en marcha';
	@override String get ongoingBody => 'Toca para pausar o terminar';
	@override String get pickButton => 'Iniciar un cronómetro';
	@override String get pickTitle => '¿Qué quieres cronometrar?';
	@override String get pickHint => 'Al terminar, los minutos se suman solos al informe de hoy.';
	@override String get pickEmpty => 'Ningún elemento de tu informe se cuenta en tiempo.';
	@override String todayMinutes({required Object time}) => '${time} hoy';
	@override String get notYet => 'Todavía no hoy';
}

// Path: export.doc
class _Translations$export$doc$es extends Translations$export$doc$fr {
	_Translations$export$doc$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Informe diario';
	@override String get regularity => 'Constancia';
	@override String daysFilled({required num filled, required Object total}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(filled,
		one: '${filled} día completado de ${total}',
		other: '${filled} días completados de ${total}',
	);
	@override String get totals => 'En el período';
	@override String get item => 'Elemento';
	@override String get total => 'Total';
	@override String get days => 'Días';
	@override String get average => 'Promedio / día completado';
	@override String get goal => 'Objetivo alcanzado';
	@override String get detail => 'Día a día';
	@override String get date => 'Fecha';
	@override String get values => 'Completado';
	@override String get note => 'Nota';
	@override String get noReport => 'Sin informe';
	@override String generated({required Object date}) => 'Generado el ${date} con CMFI Connect';
	@override String page({required Object n, required Object total}) => 'Página ${n} / ${total}';
	@override String get filledColumn => 'Informe';
	@override String get yes => 'sí';
	@override String get no => 'no';
	@override String get sentFrom => 'Enviado desde CMFI Connect';
}

// Path: items.measure
class _Translations$items$measure$es extends Translations$items$measure$fr {
	_Translations$items$measure$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String quantity({required Object unit}) => 'Cantidad · ${unit}';
	@override String get quantityNoUnit => 'Cantidad';
	@override String get duration => 'Duración';
	@override String both({required Object unit}) => 'Cantidad (${unit}) y duración';
	@override String get bothNoUnit => 'Cantidad y duración';
}

// Path: authorities.form
class _Translations$authorities$form$es extends Translations$authorities$form$fr {
	_Translations$authorities$form$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Nueva autoridad';
	@override String get emailHint => 'nombre@ejemplo.com';
	@override String get isDiscipleMaker => 'Es mi discipulador';
	@override String get isDiscipleMakerHelp => 'La persona que te acompaña personalmente. Solo tienes uno.';
	@override String discipleMakerTaken({required Object name}) => '${name} ya es tu discipulador. Quítalo de la lista para elegir a otro.';
	@override String get submit => 'Añadir';
	@override String added({required Object name}) => '${name} ahora forma parte de tus autoridades.';
	@override String get searchLabel => 'Su nombre de usuario';
	@override String get searchHint => 'usuario';
	@override String get search => 'Buscar';
	@override String get searchHelp => 'Si la persona usa CMFI Connect, búscala por su nombre de usuario. Recibirá tu solicitud, y sus datos de contacto aparecerán cuando la acepte.';
	@override String notFound({required Object username}) => 'Nadie tiene el nombre de usuario @${username}.';
	@override String get invite => 'Invitarla a unirse a CMFI Connect';
	@override String get inviteText => '¡Hola! Uso CMFI Connect para llevar el registro de mi caminar con Dios, y me gustaría que me acompañaras. Instala la aplicación, crea tu cuenta y luego envíame tu nombre de usuario para que pueda añadirte.';
	@override String inviteMine({required Object username}) => 'Mi nombre de usuario: @${username}';
	@override String get manual => '¿No tiene la aplicación? Introducir sus datos';
	@override String get backToSearch => 'Buscar por nombre de usuario';
	@override String get request => 'Enviar la solicitud';
	@override String requested({required Object name}) => 'Solicitud enviada a ${name}.';
	@override String get alreadyAdded => 'Esta persona ya forma parte de tus autoridades.';
	@override String get makerExists => 'Ya tienes un discipulador.';
	@override String get yourself => 'Es tu propio nombre de usuario.';
	@override String sharingHelp({required Object name}) => '${name} verá tus informes: los elementos rellenados, tu regularidad y tus porcentajes, nunca tu nota. Puedes detenerlo en su ficha.';
}

// Path: authorities.sharing
class _Translations$authorities$sharing$es extends Translations$authorities$sharing$fr {
	_Translations$authorities$sharing$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Compartir mis informes';
	@override String help({required Object name}) => '${name} ve tus informes: los elementos rellenados, tu regularidad y tus porcentajes, nunca tu nota.';
	@override String on({required Object name}) => 'Tus informes se comparten con ${name}.';
	@override String off({required Object name}) => '${name} ya no ve tus informes.';
}

// Path: members.deleteAccount
class _Translations$members$deleteAccount$es extends Translations$members$deleteAccount$fr {
	_Translations$members$deleteAccount$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get button => 'Eliminar mi cuenta';
	@override String get title => 'Eliminar mi cuenta';
	@override String get intro => 'Es definitivo. Tu cuenta y todo lo relacionado con ella se borrará:';
	@override String get itemProfile => 'tu perfil, tu foto, tu nombre de usuario y tu contraseña';
	@override String get itemReports => 'todos tus informes, tus elementos y tus objetivos';
	@override String get itemAuthorities => 'tus autoridades espirituales y las solicitudes recibidas';
	@override String get itemEvents => 'tus inscripciones a eventos';
	@override String get itemPrayer => 'tus listas de oración, tus retiros y tus motivos de importunidad';
	@override String get kept => 'Los eventos, novedades, fotos y motivos de oración que publicaste como admin se quedan para la comunidad, sin tu nombre.';
	@override String get passwordHelp => 'Para confirmar que eres tú.';
	@override String get confirm => 'Eliminar definitivamente';
	@override String get done => 'Tu cuenta ha sido eliminada. ¡Dios te bendiga!';
	@override String get wrongPassword => 'Contraseña incorrecta.';
	@override String get lastSuperadmin => 'Eres el único superadmin: da este rol a otra persona antes de eliminar tu cuenta.';
}

// Path: hymns.tabs
class _Translations$hymns$tabs$es extends Translations$hymns$tabs$fr {
	_Translations$hymns$tabs$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get all => 'Todos';
	@override String get favorites => 'Favoritos';
	@override String get recent => 'Recientes';
}

// Path: hymns.reader
class _Translations$hymns$reader$es extends Translations$hymns$reader$fr {
	_Translations$hymns$reader$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get smaller => 'Reducir el texto';
	@override String get larger => 'Ampliar el texto';
	@override String get display => 'Visualización';
	@override String get textSize => 'Tamaño del texto';
	@override String get typeface => 'Fuente';
	@override String get typefaceAuto => 'Auto';
	@override String get typefaceSans => 'Moderna';
	@override String get typefaceSerif => 'Clásica';
	@override String get typefaceAutoHelp => 'Clásica cuando el texto es grande';
	@override String get background => 'Fondo';
	@override String get themeAuto => 'Auto';
	@override String get themeLight => 'Claro';
	@override String get themeSepia => 'Sepia';
	@override String get themeDark => 'Oscuro';
	@override String get repeatChorus => 'Repetir el coro después de cada estrofa';
	@override String get keepScreenOn => 'Mantener la pantalla encendida';
	@override String get addFavorite => 'Añadir a favoritos';
	@override String get removeFavorite => 'Quitar de favoritos';
	@override String get favoriteAdded => 'Añadido a favoritos';
	@override String get favoriteRemoved => 'Quitado de favoritos';
	@override String get more => 'Más opciones';
	@override String get copy => 'Copiar la letra';
	@override String get copied => 'Letra copiada';
	@override String get project => 'Modo proyección';
	@override String get pinchHint => 'Pellizca la pantalla para agrandar o reducir el texto.';
	@override String get notFound => 'Este himno ya no está en el himnario.';
	@override String get share => 'Compartir la letra';
}

// Path: hymns.projection
class _Translations$hymns$projection$es extends Translations$hymns$projection$fr {
	_Translations$hymns$projection$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get exit => 'Salir del modo proyección';
	@override String get previous => 'Estrofa anterior';
	@override String get next => 'Estrofa siguiente';
	@override String position({required Object current, required Object total}) => '${current} / ${total}';
	@override String get hint => 'Toca a la derecha para avanzar y a la izquierda para volver.';
}

// Path: hymns.pad
class _Translations$hymns$pad$es extends Translations$hymns$pad$fr {
	_Translations$hymns$pad$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Ir al himno';
	@override String get open => 'Abrir';
	@override String get erase => 'Borrar';
	@override String notFound({required Object number}) => 'No hay himno n.º ${number} en este himnario';
	@override String get placeholder => 'Escribe un número';
}

// Path: events.tabs
class _Translations$events$tabs$es extends Translations$events$tabs$fr {
	_Translations$events$tabs$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get program => 'Programa';
	@override String get news => 'Novedades';
	@override String get info => 'Info';
	@override String get photos => 'Fotos';
}

// Path: events.register
class _Translations$events$register$es extends Translations$events$register$fr {
	_Translations$events$register$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get cta => 'Participaré';
	@override String get title => 'Participaré';
	@override String get people => '¿Cuántas personas vendrán?';
	@override String get peopleHint => 'Contándote a ti, con tu familia o tu grupo.';
	@override String get less => 'Una persona menos';
	@override String get more => 'Una persona más';
	@override String get lodging => 'Necesito alojamiento';
	@override String get lodgingHint => 'Los organizadores prevén las plazas.';
	@override String get departure => 'Ciudad de salida';
	@override String get departureHint => 'Ej.: Douala';
	@override String get confirm => 'Confirmar mi inscripción';
	@override String get update => 'Actualizar';
	@override String get cancel => 'Cancelar mi inscripción';
	@override String get done => '¡Listo, estás inscrito! Te lo recordaremos el día antes.';
	@override String get updated => 'Tu inscripción está actualizada.';
	@override String get cancelled => 'Tu inscripción se ha cancelado.';
	@override String get edit => 'Modificar';
	@override String get youAre => 'Estás inscrito';
	@override String get cancelTitle => '¿Cancelar tu inscripción?';
	@override String get cancelText => 'Tu plaza quedará libre para otra persona.';
	@override String get keep => 'Mantener mi plaza';
	@override String get lodgingShort => 'alojamiento';
}

// Path: events.reminder
class _Translations$events$reminder$es extends Translations$events$reminder$fr {
	_Translations$events$reminder$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get channel => 'Recordatorios de eventos';
	@override String tomorrow({required Object title}) => 'Mañana: ${title}';
	@override String soon({required Object title}) => 'En 1 h: ${title}';
}

// Path: events.admin
class _Translations$events$admin$es extends Translations$events$admin$fr {
	_Translations$events$admin$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Gestionar los eventos';
	@override String get create => 'Crear un evento';
	@override String get edit => 'Editar el evento';
	@override String get empty => 'Aún no hay eventos. ¡Crea el primero!';
	@override String get poster => 'Cartel';
	@override String get posterAdd => 'Elegir un cartel';
	@override String get posterChange => 'Cambiar el cartel';
	@override String get posterRemove => 'Quitar el cartel';
	@override String get posterHint => 'Formato vertical 4:5 recomendado (1080 × 1350), JPEG o PNG.';
	@override String get uploading => 'Enviando la imagen…';
	@override String get general => 'El evento';
	@override String get titleField => 'Título';
	@override String get titleHint => 'Ej.: Conferencia anual 2026';
	@override String get titleRequired => 'Ponle un título al evento.';
	@override String get theme => 'Tema';
	@override String get themeHint => 'Ej.: Andar en el Espíritu';
	@override String get verse => 'Versículo del tema';
	@override String get description => 'Presentación';
	@override String get when => 'Fechas';
	@override String get starts => 'Inicio';
	@override String get ends => 'Fin';
	@override String get endsBeforeStart => 'El fin debe ser posterior al inicio.';
	@override String timeZone({required Object zone}) => 'Horario del lugar (${zone}).';
	@override String get where => 'Lugar';
	@override String get venue => 'Lugar';
	@override String get venueHint => 'Ej.: Centro de conferencias de Mvolyé';
	@override String get address => 'Dirección';
	@override String get city => 'Ciudad';
	@override String get country => 'País';
	@override String get mapsUrl => 'Enlace de Google Maps';
	@override String get registration => 'Inscripciones';
	@override String get registrationOpen => 'Inscripciones abiertas';
	@override String get deadline => 'Fecha límite';
	@override String get noDeadline => 'Sin fecha límite';
	@override String get capacity => 'Número de plazas';
	@override String get capacityHint => 'Vacío: sin límite';
	@override String get asksLodging => 'Preguntar quién necesita alojamiento';
	@override String get asksDeparture => 'Preguntar la ciudad de salida';
	@override String get fees => 'Aportación';
	@override String get feesHint => 'Ej.: Entrada libre. Comidas: 2000 FCFA al día.';
	@override String get contact => 'Contacto';
	@override String get contactName => 'Nombre del contacto';
	@override String get contactPhone => 'Teléfono del contacto';
	@override String get visibility => 'Visibilidad';
	@override String get statusDraft => 'Borrador';
	@override String get statusDraftHint => 'Solo lo ven los admins';
	@override String get statusPublished => 'Publicado';
	@override String get statusPublishedHint => 'Lo ve toda la comunidad';
	@override String get statusCancelled => 'Cancelado';
	@override String get statusCancelledHint => 'Se muestra como cancelado, sin inscripción';
	@override String get saved => 'Evento guardado.';
	@override String get menu => 'Gestionar';
	@override String get program => 'Programa';
	@override String get registrants => 'Inscritos';
	@override String get post => 'Publicar una novedad';
	@override String get photos => 'Añadir fotos';
	@override String get nextEdition => 'Preparar la próxima edición';
	@override String get delete => 'Eliminar el evento';
	@override String get deleteTitle => '¿Eliminar este evento?';
	@override String get deleteText => 'También se eliminarán las inscripciones, las novedades y las fotos.';
	@override String get deleteConfirm => 'Eliminar';
	@override String get deleted => 'Evento eliminado.';
	@override String get nextEditionTitle => '¿Preparar la próxima edición?';
	@override String get nextEditionText => 'Se crea un borrador un año después, con el mismo lugar y el mismo programa. Podrás ajustarlo todo antes de publicarlo.';
	@override String get nextEditionConfirm => 'Preparar';
	@override String get nextEditionDone => 'La próxima edición está lista como borrador.';
	@override String get programEmpty => 'Añade los momentos del evento: acogida, cultos, enseñanzas, vigilia…';
	@override String get addSession => 'Añadir un momento';
	@override String get editSession => 'Editar este momento';
	@override String get sessionTitle => 'Título';
	@override String get sessionTitleHint => 'Ej.: Culto de apertura';
	@override String get speaker => 'Orador';
	@override String get place => 'Sala';
	@override String get day => 'Día';
	@override String get from => 'De';
	@override String get to => 'A';
	@override String get hymns => 'Himnos';
	@override String get hymnsHint => 'Números, ej.: 12, 45';
	@override String get removeSession => 'Quitar';
	@override String get saveProgram => 'Guardar el programa';
	@override String get programSaved => 'Programa guardado.';
	@override String get registrantsEmpty => 'Aún no hay nadie inscrito.';
	@override String get totalRegistrations => 'Inscripciones';
	@override String get totalPeople => 'Personas';
	@override String get totalLodging => 'Por alojar';
	@override String get byCity => 'Por ciudad de salida';
	@override String get list => 'Lista';
	@override String get exportCsv => 'Exportar la lista (CSV)';
	@override String get csvHeader => 'Nombre;Usuario;Teléfono;Iglesia;Asamblea;Personas;Alojamiento;Ciudad de salida;Inscrito el';
	@override String get yes => 'sí';
	@override String get no => 'no';
	@override String get postBody => 'Mensaje';
	@override String get postBodyHint => 'Ej.: ¡Las inscripciones están abiertas!';
	@override String get postImage => 'Añadir una imagen';
	@override String get postPinned => 'Fijar arriba';
	@override String get postSend => 'Publicar';
	@override String get postDone => 'Novedad publicada.';
	@override String get postDelete => 'Eliminar esta novedad';
	@override String get postDeleted => 'Novedad eliminada.';
	@override String photosAdded({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: '${n} foto añadida.',
		other: '${n} fotos añadidas.',
	);
	@override String photosSending({required Object done, required Object total}) => 'Enviando las fotos (${done}/${total})…';
	@override String get photoDelete => 'Eliminar esta foto';
	@override String get photoDeleted => 'Foto eliminada.';
	@override String get confirmDelete => 'Eliminar';
	@override String get price => 'Precio por persona (FCFA)';
	@override String get priceHint => 'Vacío: gratis. Se paga con dinero móvil al inscribirse.';
}

// Path: events.pay
class _Translations$events$pay$es extends Translations$events$pay$fr {
	_Translations$events$pay$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Pago con dinero móvil';
	@override String perPerson({required Object price}) => '${price} por persona';
	@override String get total => 'Total a pagar';
	@override String get phone => 'Número de dinero móvil';
	@override String get phoneHint => '+237 6 70 00 00 00';
	@override String get phoneHelp => 'Con el prefijo del país. La solicitud de pago llega a este teléfono.';
	@override String get operator => 'Operador';
	@override String pay({required Object amount}) => 'Pagar ${amount}';
	@override String get waitingTitle => 'Confirma en tu teléfono';
	@override String waitingText({required Object amount}) => 'Llega a tu teléfono una solicitud de ${amount}. Introduce tu PIN de dinero móvil para validarla.';
	@override String get waitingSlow => 'Aún en espera. Tu inscripción se confirmará en cuanto llegue el pago, aunque cierres esta ventana.';
	@override String get close => 'Cerrar';
	@override String get retry => 'Reintentar';
	@override String get done => 'Pago recibido: ¡estás inscrito!';
	@override String get failedTitle => 'El pago no se completó';
	@override String get paidNote => 'Inscripción pagada. Para anularla, contacta con los organizadores: te devolverán el dinero.';
	@override String get peopleLocked => 'El número de personas pagado ya no se puede cambiar.';
	@override late final _Translations$events$pay$failures$es failures = _Translations$events$pay$failures$es._(_root);
	@override String get later => 'Pagaré más tarde';
	@override String toPay({required Object amount}) => 'Por pagar: ${amount}';
	@override String get payNow => 'Pagar';
	@override String get unavailable => 'El pago con dinero móvil aún no está disponible: inscríbete, podrás pagar más tarde.';
	@override String laterDone({required Object amount}) => '¡Estás inscrito! Recuerda pagar ${amount} antes del evento.';
	@override String get paidShort => 'pagado';
}

// Path: ministry.goals
class _Translations$ministry$goals$es extends Translations$ministry$goals$fr {
	_Translations$ministry$goals$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override late final _Translations$ministry$goals$crusade$es crusade = _Translations$ministry$goals$crusade$es._(_root);
	@override late final _Translations$ministry$goals$disciples$es disciples = _Translations$ministry$goals$disciples$es._(_root);
	@override late final _Translations$ministry$goals$revival$es revival = _Translations$ministry$goals$revival$es._(_root);
}

// Path: ministry.lives
class _Translations$ministry$lives$es extends Translations$ministry$lives$fr {
	_Translations$ministry$lives$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override late final _Translations$ministry$lives$founder$es founder = _Translations$ministry$lives$founder$es._(_root);
	@override late final _Translations$ministry$lives$leader$es leader = _Translations$ministry$lives$leader$es._(_root);
}

// Path: prayer.hero
class _Translations$prayer$hero$es extends Translations$prayer$hero$fr {
	_Translations$prayer$hero$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String now({required Object retreat}) => '${retreat} · ahora';
	@override String get title => '15 minutos\ncon el Señor';
	@override Map<String, String> get preview => {
		'morning': 'Da gracias, consagra tu día, tu trabajo, tu familia…',
		'noon': 'Tu asamblea, tus líderes, 5 personas de tu lista, las naciones…',
		'evening': 'Tu vida de oración, tu ministerio, tus colaboradores…',
		'night': 'Los enfermos, el Evangelio en las naciones, la protección durante la noche…',
	};
	@override String get meta => '15 puntos · 1 min cada uno';
	@override String get start => 'Empezar';
	@override String get allDone => 'Hiciste los 4 retiros del día. ¡Que Dios conteste tus oraciones!';
	@override String doneNow({required Object retreat, required Object next}) => '${retreat} hecho. Siguiente: ${next}';
}

// Path: prayer.today
class _Translations$prayer$today$es extends Translations$prayer$today$fr {
	_Translations$prayer$today$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get toPray => 'Por orar';
	@override String week({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		zero: 'Ningún retiro esta semana',
		one: '${n} retiro esta semana',
		other: '${n} retiros esta semana',
	);
}

// Path: prayer.routine
class _Translations$prayer$routine$es extends Translations$prayer$routine$fr {
	_Translations$prayer$routine$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Tu rutina del día';
	@override String count({required Object done}) => '${done} de 4';
	@override String days({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: '${n} día de 7',
		other: '${n} días de 7',
	);
	@override String week({required Object time}) => '${time} esta semana';
	@override String get done => 'Hecha · 15 min';
	@override String get now => 'Ahora · 15 min';
	@override String get next => 'A continuación · 15 min';
	@override String reminder({required Object time}) => 'Recordatorio a las ${time}';
	@override Map<String, String> get later => {
		'morning': 'Por la mañana · 15 min',
		'noon': 'Al mediodía · 15 min',
		'evening': 'Por la tarde · 15 min',
		'night': 'Por la noche · 15 min',
	};
}

// Path: prayer.reminders
class _Translations$prayer$reminders$es extends Translations$prayer$reminders$fr {
	_Translations$prayer$reminders$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Recordatorios de los retiros';
	@override String get intro => 'Un recordatorio a la hora de cada retiro, solo si aún no lo has hecho.';
	@override String get off => 'Desactivado';
	@override String get channel => 'Retiros de oración';
	@override String get body => '15 minutos con el Señor.';
}

// Path: prayer.retreat
class _Translations$prayer$retreat$es extends Translations$prayer$retreat$fr {
	_Translations$prayer$retreat$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Retiros de 15 minutos';
	@override Map<String, String> get hours => {
		'morning': 'Al despertar',
		'noon': 'Entre las 12:00 y las 14:00',
		'evening': 'Al final de la tarde',
		'night': 'Antes de dormir',
	};
	@override String reminderAt({required Object time}) => 'recordatorio a las ${time}';
	@override String get intro => '15 puntos, un minuto cada uno. Un sonido suave te lleva al siguiente.';
	@override String get done => 'Hecho hoy';
	@override String get start => 'Empezar · 15 min';
	@override String get selfPaced => 'Leer a mi ritmo, sin temporizador';
	@override late final _Translations$prayer$retreat$hints$es hints = _Translations$prayer$retreat$hints$es._(_root);
}

// Path: prayer.session
class _Translations$prayer$session$es extends Translations$prayer$session$fr {
	_Translations$prayer$session$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String point({required Object n}) => 'Punto ${n} de 15';
	@override String get remaining => 'restantes';
	@override String get paused => 'en pausa';
	@override String inYourList({required Object list}) => 'En tu lista · ${list}';
	@override String get tomorrow => 'Mañana, los siguientes.';
	@override String get footer => 'Pantalla encendida · un sonido suave cada minuto';
	@override String get previous => 'Punto anterior';
	@override String get next => 'Punto siguiente';
	@override String get pause => 'Pausa';
	@override String get resume => 'Reanudar';
	@override String get soundOn => 'Sonido activado';
	@override String get soundOff => 'Sonido desactivado';
	@override String get finish => 'Terminar el retiro';
	@override String get quitTitle => '¿Detener el retiro?';
	@override String get quitText => 'No se contará en tu día.';
	@override String get quit => 'Detener';
	@override String get keepPraying => 'Seguir orando';
	@override String get voiceOff => 'Leer en voz alta';
	@override String get voiceOn => 'Lectura en voz alta activada';
}

// Path: prayer.done
class _Translations$prayer$done$es extends Translations$prayer$done$fr {
	_Translations$prayer$done$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String title({required Object retreat}) => '${retreat} terminado';
	@override String get text => '15 minutos con el Señor.\nÉl escuchó cada una de tus oraciones.';
	@override String get report => 'Añadido a tu informe';
	@override String reportDetail({required Object added, required Object total}) => 'Oración a solas: +${added} min · ${total} min hoy';
	@override String get undo => 'Deshacer';
	@override String get undone => 'Retiro quitado de tu día.';
	@override String get today => 'Hoy';
	@override String count({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: '${n} retiro de 4',
		other: '${n} retiros de 4',
	);
	@override String get verse => '«Orad sin cesar.»';
	@override String get reference => '1 Tesalonicenses 5:17';
	@override String get finish => 'Terminar';
	@override String get hymn => 'Cantar un himno';
}

// Path: prayer.topics
class _Translations$prayer$topics$es extends Translations$prayer$topics$fr {
	_Translations$prayer$topics$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Motivos de la comunidad';
	@override String get all => 'Ver todo';
	@override String get empty => 'No hay motivos por ahora. Los líderes publicarán los próximos aquí.';
	@override Map<String, String> get categories => {
		'church': 'Iglesia',
		'nations': 'Naciones',
		'sick': 'Enfermos',
		'event': 'Evento',
		'fasting': 'Ayuno',
		'other': 'Motivo',
	};
	@override String until({required Object date}) => 'hasta el ${date}';
	@override String get archive => 'Motivos anteriores';
	@override String get archiveEmpty => 'No hay motivos anteriores.';
	@override String get current => 'En este momento';
	@override String documentSize({required Object kb}) => '${kb} KB';
	@override String get download => 'Descargar el PDF';
	@override String get noDocument => 'Sin PDF';
	@override String get openDocument => 'Abrir el PDF';
}

// Path: prayer.lists
class _Translations$prayer$lists$es extends Translations$prayer$lists$fr {
	_Translations$prayer$lists$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Mis listas de oración';
	@override String get private => 'Solo para ti';
	@override Map<String, String> get names => {
		'unbelievers': 'Aún no creyentes',
		'believers': 'Creyentes',
		'backsliders': 'Descarriados',
		'coworkers': 'Colaboradores',
	};
	@override Map<String, String> get uses => {
		'unbelievers': 'En el retiro del mediodía oras cada día por 10 personas de esta lista (5 + 5), por turnos.',
		'believers': 'En el retiro del mediodía oras cada día por 5 personas de esta lista, por turnos.',
		'backsliders': 'En el retiro del mediodía oras cada día por 5 personas de esta lista, por turnos.',
		'coworkers': 'En el retiro de la tarde oras cada día por 10 de tus colaboradores (5 + 5), por turnos.',
	};
	@override String get privateNote => 'Solo tú puedes verla.';
	@override String count({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		zero: 'Nadie',
		one: '${n} persona',
		other: '${n} personas',
	);
	@override String get empty => 'Nadie por ahora. Añade a las personas por las que oras.';
	@override String get add => 'Añadir una persona';
	@override String get prayedToday => 'Hoy';
	@override String get next => 'Próximamente';
	@override Map<String, String> get answeredTitle => {
		'unbelievers': 'Creyeron en el Señor',
		'believers': 'Oraciones contestadas',
		'backsliders': 'Volvieron al Señor',
		'coworkers': 'Oraciones contestadas',
	};
	@override late final _Translations$prayer$lists$answeredOn$es answeredOn = _Translations$prayer$lists$answeredOn$es._(_root);
	@override Map<String, String> get markAnswered => {
		'unbelievers': '¡Creyó en el Señor!',
		'believers': 'Oración contestada',
		'backsliders': '¡Volvió al Señor!',
		'coworkers': 'Oración contestada',
	};
	@override String get answeredToast => '¡Gloria a Dios!';
	@override String get putBack => 'Devolver a la lista';
	@override String answeredBanner({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: '${n} oración contestada este mes',
		other: '${n} oraciones contestadas este mes',
	);
	@override String lastAnswered({required Object name, required Object what}) => '${name}: ${what}';
	@override late final _Translations$prayer$lists$sheet$es sheet = _Translations$prayer$lists$sheet$es._(_root);
	@override String get addShort => 'Añadir';
}

// Path: prayer.importunity
class _Translations$prayer$importunity$es extends Translations$prayer$importunity$fr {
	_Translations$prayer$importunity$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Motivos de importunidad';
	@override String get newTopic => 'Nuevo motivo';
	@override String get intro => 'Un motivo que se presenta al Señor sin cansarse, hasta recibir la respuesta. Fija un número de proclamaciones e invita a tus hermanos y hermanas a orar contigo.';
	@override String invitedBy({required Object name}) => '${name} te invita a orar';
	@override String get join => 'Me uno a la oración';
	@override String get decline => 'Ahora no';
	@override String get joined => 'Ahora oras por este motivo.';
	@override String progress({required Object total, required Object goal}) => '${total} de ${goal}';
	@override String total({required num n, required Object count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: '${count} proclamación',
		other: '${count} proclamaciones',
	);
	@override String get reached => '¡Objetivo alcanzado!';
	@override String get closed => 'Cerrado';
	@override String participants({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: '${n} ora',
		other: '${n} oran',
	);
	@override String mine({required Object n}) => 'Tú: ${n}';
	@override String get tapHint => 'Toca en cada proclamación';
	@override String get addMany => 'Añadir una cantidad';
	@override String get addManyTitle => '¿Cuántas proclamaciones?';
	@override String get addManyLabel => 'Proclamaciones';
	@override String get add => 'Añadir';
	@override String pending({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: '${n} pendiente de envío',
		other: '${n} pendientes de envío',
	);
	@override String get invite => 'Invitar';
	@override String get members => 'Quienes oran';
	@override String waiting({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: '${n} invitación pendiente',
		other: '${n} invitaciones pendientes',
	);
	@override String get edit => 'Editar';
	@override String get close => 'Cerrar el motivo';
	@override String get reopen => 'Reabrir el motivo';
	@override String get delete => 'Eliminar el motivo';
	@override String get deleteTitle => '¿Eliminar este motivo?';
	@override String get deleteText => 'Desaparecerá para todos los que oran contigo.';
	@override String get leave => 'Dejar este motivo';
	@override String get leaveTitle => '¿Dejar este motivo?';
	@override String get leaveText => 'Tus proclamaciones se quedan en el total.';
	@override late final _Translations$prayer$importunity$form$es form = _Translations$prayer$importunity$form$es._(_root);
	@override late final _Translations$prayer$importunity$inviteSheet$es inviteSheet = _Translations$prayer$importunity$inviteSheet$es._(_root);
	@override String get eyebrow => 'Tema de importunidad';
	@override String get proclaim => 'Proclamar';
	@override String get timer => 'Cronometrar mi oración';
	@override String get timeLabel => 'Tiempo de oración por este motivo';
	@override String mineTime({required Object n, required Object time}) => 'Tú: ${n} · ${time} de oración';
	@override String get timerNote => 'El tiempo se suma a «Oración personal» en tu informe.';
}

// Path: prayer.free
class _Translations$prayer$free$es extends Translations$prayer$free$fr {
	_Translations$prayer$free$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Orar libremente';
	@override String get text => 'Sin retiro: tu tiempo cuenta en «Oración personal».';
	@override String get start => 'Cronometrar';
	@override String get running => 'Oración personal en curso';
}

// Path: streak.lines
class _Translations$streak$lines$es extends Translations$streak$lines$fr {
	_Translations$streak$lines$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get week => 'Una semana entera con el Señor, día tras día. ¡Bravo, sigue así!';
	@override String get month => '¡Un mes de fidelidad! Lo que siembras cada día da fruto.';
	@override String get hundred => '¡Cien días con Dios! Tu perseverancia es un hermoso testimonio.';
	@override String get year => '¡Un año entero con Dios! Gloria a Él por tu fidelidad.';
}

// Path: blocking.reasons
class _Translations$blocking$reasons$es extends Translations$blocking$reasons$fr {
	_Translations$blocking$reasons$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get spam => 'No deseado';
	@override String get offensive => 'Contenido chocante u ofensivo';
	@override String get other => 'Otro';
}

// Path: bible.colors
class _Translations$bible$colors$es extends Translations$bible$colors$fr {
	_Translations$bible$colors$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get yellow => 'amarillo';
	@override String get green => 'verde';
	@override String get blue => 'azul';
	@override String get pink => 'rosa';
}

// Path: seekFirst.shield
class _Translations$seekFirst$shield$es extends Translations$seekFirst$shield$fr {
	_Translations$seekFirst$shield$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Busca primero a Dios';
	@override String subtitle({required Object app}) => '${app} sigue cerrada hasta tu informe de hoy.';
	@override String get thisApp => 'Esta app';
	@override String get fill => 'Llenar mi informe';
	@override String pause({required Object n}) => 'Pausa de 5 min (${n}/3)';
	@override String get notificationTitle => 'Busca primero a Dios';
	@override String get notificationBody => 'Toca aquí para llenar tu informe.';
	@override String get serviceBody => 'Tus apps se cierran cada día hasta tu informe.';
}

// Path: souls.csv
class _Translations$souls$csv$es extends Translations$souls$csv$fr {
	_Translations$souls$csv$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get name => 'Nombre';
	@override String get phone => 'Teléfono';
	@override String get place => 'Lugar';
	@override String get metOn => 'Conocido el';
	@override String get stage => 'Etapa';
	@override String get next => 'Próximo contacto';
	@override String get notes => 'Notas';
}

// Path: reports.units.chapters
class _Translations$reports$units$chapters$es extends Translations$reports$units$chapters$fr {
	_Translations$reports$units$chapters$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get name => 'Número de capítulos';
	@override String get label => 'capítulos';
	@override String get symbol => 'capítulos';
	@override String count({required num n, required Object value}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: '${value} capítulo',
		other: '${value} capítulos',
	);
}

// Path: reports.units.times
class _Translations$reports$units$times$es extends Translations$reports$units$times$fr {
	_Translations$reports$units$times$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get name => 'Número de veces';
	@override String get label => 'veces';
	@override String get symbol => 'veces';
	@override String count({required num n, required Object value}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: '${value} vez',
		other: '${value} veces',
	);
}

// Path: reports.units.pages
class _Translations$reports$units$pages$es extends Translations$reports$units$pages$fr {
	_Translations$reports$units$pages$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get name => 'Número de páginas';
	@override String get label => 'páginas';
	@override String get symbol => 'páginas';
	@override String count({required num n, required Object value}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: '${value} página',
		other: '${value} páginas',
	);
}

// Path: reports.units.percent
class _Translations$reports$units$percent$es extends Translations$reports$units$percent$fr {
	_Translations$reports$units$percent$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get name => 'Porcentaje';
	@override String get label => 'porcentaje';
	@override String get symbol => '%';
	@override String count({required Object value}) => '${value} %';
}

// Path: events.pay.failures
class _Translations$events$pay$failures$es extends Translations$events$pay$failures$fr {
	_Translations$events$pay$failures$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get insufficientBalance => 'El saldo de esta cuenta de dinero móvil es insuficiente.';
	@override String get payerNotFound => 'Este número no tiene cuenta de dinero móvil con este operador.';
	@override String get limitReached => 'Esta cuenta de dinero móvil ha alcanzado su límite.';
	@override String get notApproved => 'El pago no se validó: PIN no introducido o rechazado.';
	@override String get unavailable => 'El operador no está disponible ahora. Inténtalo más tarde.';
	@override String get generic => 'El pago falló. Inténtalo de nuevo o usa otro número.';
	@override String get sandbox => 'En modo de prueba solo se aceptan los números de prueba de KPay: usa, por ejemplo, el 6 53 45 67 89.';
}

// Path: ministry.goals.crusade
class _Translations$ministry$goals$crusade$es extends Translations$ministry$goals$crusade$fr {
	_Translations$ministry$goals$crusade$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'La cruzada evangelística a toda criatura';
	@override String get text => 'Predicar el evangelio a cada persona que viva en nuestra generación, de modo que 10 mil millones de personas sean alcanzadas con el evangelio predicado en el poder del Espíritu Santo, usando todos los medios de comunicación (nuestros libros, tratados, revistas, CD, DVD, nuestra radio, nuestra televisión e Internet) de la manera más urgente posible.';
	@override String get reached => 'personas alcanzadas por el evangelio';
}

// Path: ministry.goals.disciples
class _Translations$ministry$goals$disciples$es extends Translations$ministry$goals$disciples$fr {
	_Translations$ministry$goals$disciples$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'La formación de discípulos';
	@override String get text => 'Llevar a 1000 millones de personas en 250 naciones a conocer a Jesucristo como Señor y Salvador, que sean hechas discípulos para obedecerle en todo y organizadas para reunirse en 25 millones de iglesias en casas de aquí al año 2065.';
	@override String get people => 'discípulos';
	@override String get nations => 'naciones';
	@override String get churches => 'iglesias en casas';
	@override String by({required Object year}) => 'para ${year}';
}

// Path: ministry.goals.revival
class _Translations$ministry$goals$revival$es extends Translations$ministry$goals$revival$fr {
	_Translations$ministry$goals$revival$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Precipitar el avivamiento global';
	@override String get text => 'Cooperar con Dios mediante el ayuno y la intercesión por el avivamiento mundial que rasgará los cielos, sacudirá la tierra y glorificará a Cristo en nuestra generación, para precipitar el inminente regreso de nuestro Señor Jesucristo desde el cielo al encuentro de su Esposa preparada.';
	@override String get fasting => 'Ayuno';
	@override String get intercession => 'Intercesión';
	@override String get pray => 'Orar ahora';
}

// Path: ministry.lives.founder
class _Translations$ministry$lives$founder$es extends Translations$ministry$lives$founder$fr {
	_Translations$ministry$lives$founder$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get name => 'Prof. Zacharias Tanee Fomum';
	@override String get line => '1945 – 2009 · Fundador de la CMCI';
	@override List<String> get facts => [
		'fundación de la CMCI',
		'libros escritos',
		'naciones visitadas',
	];
	@override List<String> get dates => [
		'Nace el 20 de junio en Camerún, en una familia presbiteriana.',
		'Entrega su vida a Jesucristo el 13 de junio, al leer un tratado.',
		'Se entrega por completo al Señor el 1 de octubre, en Sierra Leona.',
		'Es lleno del Espíritu Santo el 24 de octubre, tras siete días de oración.',
		'Funda la CMCI en Yaundé el 12 de mayo.',
		'Recibe el doctorado en ciencias de la Universidad de Durham.',
		'Parte con el Señor el 14 de marzo.',
	];
	@override List<String> get story => [
		'Zacharias Tanee Fomum nació el 20 de junio de 1945 en Camerún, en una familia presbiteriana originaria de Batibo, en el noroeste del país. Siendo todavía escolar, entregó su vida a Jesucristo el 13 de junio de 1956, al leer un tratado titulado «Alguien murió por ti».',
		'Siendo estudiante en el Fourah Bay College, en Sierra Leona, se entregó sin reservas al Señor y a su servicio el 1 de octubre de 1966. El 24 de octubre de 1970, al final de siete días de oración y ayuno, fue lleno del Espíritu Santo. Desde entonces, la oración fue el centro de su vida.',
		'Doctor en química orgánica por la Universidad Makerere, en Uganda, enseñó en la Universidad de Yaundé, donde llegó a ser profesor. Dirigió un centenar de tesis y memorias, y en 2005 la Universidad de Durham, en Gran Bretaña, le otorgó un doctorado en ciencias por el conjunto de su obra.',
		'El 12 de mayo de 1975, en Yaundé, fundó la Comunidad Misionera Cristiana Internacional: un movimiento para ganar almas, hacer discípulos, plantar iglesias y enviar misioneros. Hizo más de 700 viajes misioneros en Camerún y más de 500 a más de 70 naciones, en seis continentes.',
		'Pasaba cada día largas horas a solas con Dios, dirigió muchas cruzadas, asedios y marchas de oración, y ayunó a menudo. Escribió más de 150 libros sobre la oración, el ayuno, la santidad, el discipulado y la misión, leídos en muchos idiomas.',
		'Con su esposa, Prisca Zei Fomum, servidora de Dios entre los niños, tuvo siete hijos, todos comprometidos en la obra del Evangelio. Juntos vivían con sencillez para dar al Evangelio la mayor parte de sus ingresos.',
		'Partió a la presencia del Señor el 14 de marzo de 2009 y fue sepultado en Yaundé el 21 de marzo. La obra que fundó continúa entre las naciones.',
	];
}

// Path: ministry.lives.leader
class _Translations$ministry$lives$leader$es extends Translations$ministry$lives$leader$fr {
	_Translations$ministry$lives$leader$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get name => 'Theodore Andoseh';
	@override String get line => 'Líder de la CMCI desde 2009';
	@override List<String> get facts => [
		'iglesias plantadas',
		'años en Nigeria',
		'al frente de la CMCI',
	];
	@override List<String> get dates => [
		'Entrega su vida a Jesucristo bajo la predicación del Prof. Fomum.',
		'Es consagrado obispo en Yaundé.',
		'Parte como misionero a Nigeria con su esposa, Adela.',
		'Asume la dirección de la CMCI.',
		'Trae los mensajes de la 3.ª Convención Mundial a miembros de 93 naciones.',
	];
	@override List<String> get story => [
		'Theodore Andoseh entregó su vida a Jesucristo en 1978, al escuchar predicar al Prof. Zacharias Tanee Fomum, que llegó a ser su padre espiritual y lo formó como discípulo.',
		'Primero sirvió a su lado: como asistente de laboratorio en la Universidad de Yaundé, y luego como su asistente personal y secretario particular. En esos años publicó el primer tratado del avivamiento, «Dios habla al hombre que quiere oír», e inició la primera cadena de oración de Yaundé.',
		'Como misionero nacional, plantó más de cincuenta iglesias en Camerún. Fue consagrado obispo en Yaundé en 1989.',
		'En 1994 partió como misionero a Nigeria con su esposa, Adela. Allí sirvieron durante catorce años.',
		'Desde 2009, cuando el Prof. Fomum partió con el Señor, dirige la CMCI entre las naciones. En diciembre de 2019, en Koume, cerca de Bertoua, trajo los mensajes de la tercera Convención Mundial a miembros llegados de 93 naciones. También es autor de varios libros sobre el servicio a Dios y la edificación de la Iglesia.',
	];
}

// Path: prayer.retreat.hints
class _Translations$prayer$retreat$hints$es extends Translations$prayer$retreat$hints$fr {
	_Translations$prayer$retreat$hints$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String assembly({required Object name}) => 'Tu asamblea: ${name}';
	@override String get assemblyMissing => 'Añade tu asamblea en tu perfil';
	@override String authorities({required Object names}) => 'Tus autoridades: ${names}';
	@override String get authoritiesMissing => 'Añade tus autoridades espirituales en «Más»';
	@override String list({required Object list}) => 'Mis listas · ${list}';
	@override String listEmpty({required Object list}) => 'Tu lista «${list}» está vacía: añade nombres';
	@override String nation({required Object name}) => 'Hoy: ${name}';
	@override String myCountry({required Object name}) => 'Tu país: ${name}';
	@override String get hymn => 'Abrir los himnos';
}

// Path: prayer.lists.answeredOn
class _Translations$prayer$lists$answeredOn$es extends Translations$prayer$lists$answeredOn$fr {
	_Translations$prayer$lists$answeredOn$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String unbelievers({required Object date}) => 'Creyó en el Señor el ${date}';
	@override String believers({required Object date}) => 'Contestada el ${date}';
	@override String backsliders({required Object date}) => 'Volvió el ${date}';
	@override String coworkers({required Object date}) => 'Contestada el ${date}';
}

// Path: prayer.lists.sheet
class _Translations$prayer$lists$sheet$es extends Translations$prayer$lists$sheet$fr {
	_Translations$prayer$lists$sheet$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get addTitle => 'Añadir una persona';
	@override String get editTitle => 'Editar';
	@override String get name => 'Nombre';
	@override String get namePlaceholder => 'Pablo M.';
	@override String get note => 'Nota';
	@override String get notePlaceholder => 'Colega, vecino, prima…';
	@override String get list => 'Lista';
	@override String get save => 'Guardar';
	@override String get remove => 'Quitar de la lista';
	@override String removeTitle({required Object name}) => '¿Quitar a ${name}?';
	@override String get removeText => 'Ya no orarás por esta persona en tus retiros.';
}

// Path: prayer.importunity.form
class _Translations$prayer$importunity$form$es extends Translations$prayer$importunity$form$fr {
	_Translations$prayer$importunity$form$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get newTitle => 'Nuevo motivo de importunidad';
	@override String get editTitle => 'Editar el motivo';
	@override String get subject => 'Motivo';
	@override String get subjectPlaceholder => 'Señor, salva a Pablo';
	@override String get description => 'Detalles';
	@override String get descriptionPlaceholder => 'Por quién, por qué…';
	@override String get goal => 'Objetivo';
	@override String get goalHint => 'El número de proclamaciones por alcanzar juntos. Déjalo vacío para contar sin objetivo.';
	@override String get goalPlaceholder => '10.000';
	@override String get create => 'Crear';
	@override String get save => 'Guardar';
}

// Path: prayer.importunity.inviteSheet
class _Translations$prayer$importunity$inviteSheet$es extends Translations$prayer$importunity$inviteSheet$fr {
	_Translations$prayer$importunity$inviteSheet$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Invitar a orar';
	@override String get family => 'Mi familia espiritual';
	@override String familyText({required num n, required Object name}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: '${name} y sus discípulos: ${n} persona',
		other: '${name} y sus discípulos: ${n} personas',
	);
	@override String get familyMissing => 'Vincula a tu discipulador en «Mis autoridades espirituales» para invitar a tu familia espiritual.';
	@override String get byUsername => 'Por nombre de usuario';
	@override String get usernameLabel => 'Nombre de usuario';
	@override String get addUsername => 'Añadir';
	@override String get send => 'Enviar las invitaciones';
	@override String sent({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		zero: 'Ya estaban invitados.',
		one: '${n} invitación enviada',
		other: '${n} invitaciones enviadas',
	);
}

/// The flat map containing all translations for locale <es>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsEs {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'app.name' => 'CMFI Connect',
			'app.tagline' => 'Crecer juntos, cada día.',
			'app.languageName' => 'Español',
			'common.retry' => 'Reintentar',
			'common.cancel' => 'Cancelar',
			'common.save' => 'Guardar',
			'common.close' => 'Cerrar',
			'common.back' => 'Volver',
			'common.soon' => 'Pronto',
			'common.optional' => '(opcional)',
			'common.and' => 'y',
			'common.loading' => 'Cargando…',
			'common.done' => 'OK',
			'common.rangeStart' => 'Desde',
			'common.rangeEnd' => 'Hasta',
			'errors.network' => 'Sin conexión a internet. Revisa tu red y vuelve a intentarlo.',
			'errors.unauthorized' => 'Tu sesión ha expirado. Vuelve a iniciar sesión.',
			'errors.invalidCredentials' => 'Número de teléfono o contraseña incorrectos.',
			'errors.badRequest' => 'Algunos datos no son válidos.',
			'errors.conflict' => 'Este elemento ya existe.',
			'errors.notFound' => 'Elemento no encontrado.',
			'errors.server' => 'El servidor tuvo un problema. Vuelve a intentarlo en un momento.',
			'errors.unknown' => 'Se produjo un error. Vuelve a intentarlo.',
			'errors.forbidden' => 'No tienes permiso para hacer esto.',
			'errors.eventFull' => 'Ya no quedan plazas para este evento.',
			'errors.registrationClosed' => 'Las inscripciones para este evento están cerradas.',
			'errors.mediaTooLarge' => 'Esta imagen es demasiado pesada (8 MB como máximo).',
			'errors.mediaUnsupported' => 'Elige una imagen JPEG o PNG.',
			'errors.notParticipant' => 'Únete primero a este motivo para contar tus proclamaciones.',
			'errors.importunityClosed' => 'Este motivo está cerrado: ya no cuenta proclamaciones.',
			'errors.usernameNotFound' => 'Nadie tiene este nombre de usuario. Revisa la ortografía.',
			'errors.ownerCannotLeave' => 'Tú creaste este motivo: elimínalo en lugar de dejarlo.',
			'errors.tooManyPeople' => 'Tus listas están llenas (500 personas como máximo).',
			'errors.avatarInvalid' => 'Esta foto no se puede usar. Elige otra.',
			'errors.reportsNotShared' => 'Este miembro ya no comparte sus informes.',
			'errors.invalidPhone' => 'Este número no se reconoce. Añade el prefijo del país (+237…).',
			'errors.providerUnavailable' => 'Este operador no acepta este pago por ahora.',
			'errors.amountOutOfBounds' => 'Este importe supera lo que acepta el operador.',
			'errors.alreadyPaid' => 'Tu inscripción ya está pagada.',
			'errors.paymentsDisabled' => 'El pago con dinero móvil aún no está disponible.',
			'errors.paymentRequired' => 'Este evento es de pago: paga tu inscripción con dinero móvil.',
			'errors.paidRegistration' => 'Inscripción pagada: contacta con los organizadores para anularla.',
			'errors.eventHasPayments' => 'Hay miembros que pagaron: primero reembolsa sus pagos desde el sitio de administración.',
			'errors.peoplePaid' => 'El número de personas de una inscripción pagada ya no puede cambiar.',
			'validation.required' => 'Este campo es obligatorio',
			'validation.passwordTooShort' => 'Al menos 6 caracteres',
			'validation.invalidPhone' => 'Número de teléfono no válido',
			'validation.invalidEmail' => 'Correo electrónico no válido',
			'validation.invalidCode' => 'Solo letras y números, sin espacios',
			'welcome.seek.before' => 'Busca primero a ',
			'welcome.seek.marked' => 'Dios',
			'welcome.seek.after' => ', cada día',
			'welcome.seek.text' => 'Anota en pocos segundos tu lectura bíblica, tu oración, tus ayunos… y mira tu progreso semana tras semana.',
			'welcome.worship.before' => 'Canta y ',
			'welcome.worship.marked' => 'ora',
			'welcome.worship.after' => ', estés donde estés',
			'welcome.worship.text' => 'Encuentra los himnos de la comunidad e intercede cada día por los motivos de oración junto a tus hermanos y hermanas.',
			'welcome.community.before' => 'Mantente unido a tu ',
			'welcome.community.marked' => 'comunidad',
			'welcome.community.after' => '',
			'welcome.community.text' => 'Los eventos y los anuncios de tu asamblea, en un solo lugar, para que no te pierdas nada.',
			'welcome.step' => ({required Object current, required Object total}) => 'Pantalla ${current} de ${total}',
			'welcome.streak' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, one: '${n} día con Dios', other: '${n} días con Dios', ), 
			'welcome.sample.bibleReading' => 'Lectura bíblica',
			'welcome.sample.chapters' => '10 cap.',
			'welcome.sample.prayerAlone' => 'Oración a solas',
			'welcome.sample.hymn' => 'Himno',
			'welcome.sample.hymnNumber' => 'N.º 12',
			'welcome.sample.prayerOfTheDay' => 'Motivo de oración del día',
			'welcome.sample.prayerTopic' => 'Por los exámenes de nuestros jóvenes',
			'welcome.sample.praying' => '12 personas oran',
			'welcome.sample.iPray' => 'Oraré',
			'welcome.sample.retreat' => 'Retiro de jóvenes',
			'welcome.sample.announcement' => 'Anuncio',
			'welcome.sample.announcementText' => 'El culto del domingo empieza a las 8:30.',
			'welcome.createAccount' => 'Crear mi cuenta',
			'welcome.haveAccount' => 'Ya tengo una cuenta',
			'auth.phone' => 'Teléfono',
			'auth.dialCode' => ({required Object code}) => 'Código de país: ${code}',
			'auth.password' => 'Contraseña',
			'auth.showPassword' => 'Mostrar la contraseña',
			'auth.hidePassword' => 'Ocultar la contraseña',
			'auth.login.title' => '¡Hola de nuevo!',
			'auth.login.subtitle' => 'Inicia sesión para retomar tu caminar con Dios y tu comunidad.',
			'auth.login.welcomeBack' => '¡Qué bueno verte!',
			'auth.login.submit' => 'Iniciar sesión',
			'auth.login.noAccount' => '¿Aún no tienes cuenta?',
			'auth.login.createAccount' => 'Crear una cuenta',
			'auth.register.step' => ({required Object current, required Object total}) => '${current} / ${total}',
			'auth.register.title' => 'Crea tu cuenta',
			'auth.register.subtitle' => 'Usarás tu número de teléfono para iniciar sesión.',
			'auth.register.firstName' => 'Nombre',
			'auth.register.lastName' => 'Apellido',
			'auth.register.passwordHelp' => 'Mínimo 6 caracteres',
			'auth.register.email' => 'Correo electrónico',
			'auth.register.submit' => 'Continuar',
			'auth.register.haveAccount' => '¿Ya tienes cuenta?',
			'auth.register.login' => 'Iniciar sesión',
			'auth.register.alreadyUsed' => 'Este número o este correo ya tiene una cuenta. Inicia sesión.',
			'auth.register.emailHint' => 'tu@ejemplo.com',
			'auth.church.title' => 'Tu iglesia',
			'auth.church.subtitle' => 'Estos datos ayudan a tus líderes a encontrarte. Podrás cambiarlos más tarde.',
			'auth.church.editTitle' => 'Mi perfil',
			'auth.church.editSubtitle' => 'Actualiza tu nombre, tu iglesia y tu asamblea.',
			'auth.church.country' => 'País',
			'auth.church.countryHint' => 'Elige tu país',
			'auth.church.city' => 'Ciudad',
			'auth.church.cityHint' => 'Yaoundé',
			'auth.church.church' => 'Iglesia',
			'auth.church.churchHint' => 'Nombre de tu iglesia',
			'auth.church.assembly' => 'Asamblea',
			'auth.church.assemblyHint' => 'Nombre de tu asamblea',
			'auth.church.info' => '¿Te mudaste o cambiaste de asamblea? Podrás actualizarlo todo desde tu perfil.',
			'auth.church.submit' => 'Terminar',
			'auth.church.skip' => 'Omitir este paso',
			'auth.church.saved' => 'Perfil guardado',
			'auth.forgot.link' => '¿Olvidaste tu contraseña?',
			'auth.forgot.title' => 'Contraseña olvidada',
			'auth.forgot.phoneText' => 'Escribe tu número: te enviamos un código por SMS para elegir una nueva contraseña.',
			'auth.forgot.sendCode' => 'Recibir el código',
			'auth.forgot.codeTitle' => 'Escribe el código',
			'auth.forgot.codeText' => ({required Object phone}) => 'Enviamos un código de 6 cifras al ${phone}.',
			'auth.forgot.code' => 'Código recibido por SMS',
			'auth.forgot.codeInvalid' => 'El código tiene 6 cifras',
			'auth.forgot.verify' => 'Verificar',
			'auth.forgot.resend' => 'Reenviar el código',
			'auth.forgot.resendIn' => ({required Object seconds}) => 'Reenviar en ${seconds} s',
			'auth.forgot.changeNumber' => 'Cambiar de número',
			'auth.forgot.passwordTitle' => 'Nueva contraseña',
			'auth.forgot.passwordText' => 'Elige una nueva contraseña para tu cuenta.',
			'auth.forgot.submit' => 'Guardar e iniciar sesión',
			'auth.forgot.done' => 'Contraseña cambiada. ¡Qué bueno verte de nuevo!',
			'auth.forgot.remembered' => '¿La recordaste?',
			'auth.forgot.invalidCode' => 'Ese código no es correcto.',
			'auth.forgot.expired' => 'El código caducó. Pide uno nuevo.',
			'auth.forgot.tooManyRequests' => 'Demasiados intentos. Inténtalo más tarde.',
			'auth.forgot.unavailable' => 'El restablecimiento no está disponible por ahora.',
			'auth.forgot.noAccount' => 'Ninguna cuenta usa este número.',
			'auth.biometric.faceId' => 'Face ID',
			'auth.biometric.touchId' => 'Touch ID',
			'auth.biometric.fingerprint' => 'tu huella',
			'auth.biometric.face' => 'tu rostro',
			'auth.biometric.signIn' => ({required Object method}) => 'Entrar con ${method}',
			'auth.biometric.askTitle' => ({required Object method}) => '¿Entrar con ${method}?',
			'auth.biometric.askText' => 'La próxima vez no tendrás que escribir tu contraseña: queda en la caja fuerte segura de tu teléfono.',
			'auth.biometric.enable' => 'Activar',
			'auth.biometric.later' => 'Más tarde',
			'auth.biometric.reason' => 'Entra en CMFI Connect',
			'auth.biometric.enableReason' => 'Activa el acceso rápido a CMFI Connect',
			'auth.biometric.changed' => ({required Object method}) => 'Tu contraseña cambió: entra con tu contraseña y vuelve a activar ${method}.',
			'auth.biometric.settings' => ({required Object method}) => 'Entrar con ${method}',
			'auth.biometric.settingsText' => 'Sin escribir tu contraseña',
			'auth.biometric.passwordTitle' => 'Tu contraseña',
			'auth.biometric.passwordLabel' => 'Contraseña',
			'auth.biometric.confirm' => 'Confirmar',
			'auth.biometric.enabled' => ({required Object method}) => 'Acceso con ${method} activado',
			'countries.dialCodeTitle' => 'Código de país',
			'countries.title' => 'Tu país',
			'countries.search' => 'Buscar un país o un código',
			'countries.none' => 'Ningún país coincide',
			'countries.change' => 'Cambiar de país',
			'nav.home' => 'Inicio',
			'nav.reports' => 'Informe',
			'nav.hymns' => 'Himnos',
			'nav.prayer' => 'Oración',
			'nav.bible' => 'Biblia',
			'home.greeting' => ({required Object name}) => 'Hola, ${name}',
			'home.greetingNoName' => 'Hola',
			'home.profile' => 'Mi perfil',
			'home.progress' => ({required Object filled, required Object total}) => '${filled} de ${total}',
			'home.progressLabel' => 'elementos completados',
			'home.goals' => 'objetivos',
			'home.weekTitle' => 'Tu semana',
			'home.community' => 'Actualmente en la CMCI',
			'home.eventsTitle' => 'Eventos',
			'home.hymnsTitle' => 'Himnos',
			'home.hymnsOpen' => 'Abrir el himnario',
			'home.continueMyReport' => 'Continuar mi informe',
			'home.startMyReport' => 'Empezar mi informe',
			'home.items' => 'elementos',
			'home.goalsTitle' => 'Objetivos',
			'home.retreatsTitle' => 'Retiros',
			'home.retreatsValue' => ({required Object n}) => '${n} de 4',
			'home.streakTitle' => 'Racha',
			'home.resume' => 'Retomar',
			'home.hymnNumber' => ({required Object number}) => 'Himno n.º ${number}',
			'home.seeAll' => 'Ver todo',
			'home.retreatsDone' => 'Los 4 retiros del día están hechos',
			'home.days' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, one: '${n} día', other: '${n} días', ), 
			'home.hideNumbers' => 'Ocultar mis cifras',
			'home.showNumbers' => 'Mostrar mis cifras',
			'home.numbersHidden' => 'oculto',
			'home.daysShort' => ({required Object n}) => '${n} d',
			'home.prayTogether' => 'Orar juntos',
			'home.invitedBy' => ({required Object name}) => '${name} te invita a orar',
			'home.soulsTitle' => 'Almas que volver a contactar',
			'home.listenTitle' => 'Para escuchar',
			'home.soulsText' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, one: '${n} persona hoy', other: '${n} personas hoy', ), 
			'reports.title' => 'Informe diario',
			'reports.myItems' => 'Mis elementos',
			'reports.tabs.today' => 'Hoy',
			'reports.tabs.history' => 'Historial',
			'reports.tabs.summary' => 'Resumen',
			'reports.pickDay' => 'Elegir el día',
			'reports.filled' => ({required Object filled, required Object total}) => '${filled} de ${total} completados',
			'reports.statusSaved' => 'Guardado',
			'reports.statusModified' => 'Sin guardar',
			'reports.standard' => 'Estándar',
			'reports.personal' => 'Mis elementos',
			'reports.createItem' => 'Crear un elemento',
			'reports.add' => ({required Object label}) => 'Añadir ${label}',
			'reports.note' => 'Nota del día',
			'reports.noteHint' => 'Un versículo, un motivo de gratitud…',
			'reports.save' => 'Guardar el día',
			'reports.saved' => 'Día guardado',
			'reports.measure.quantity' => ({required Object unit}) => '${unit}',
			'reports.measure.duration' => 'duración',
			'reports.measure.both' => ({required Object unit}) => '${unit} y duración',
			'reports.measure.quantityNoUnit' => 'cantidad',
			'reports.measure.bothNoUnit' => 'cantidad y duración',
			'reports.times' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, one: '${n} vez', other: '${n} veces', ), 
			'reports.sheet.quantity' => 'Cantidad',
			'reports.sheet.duration' => 'Duración',
			'reports.sheet.minus1' => '− 1 min',
			'reports.sheet.plus1' => '+ 1 min',
			'reports.sheet.removeMinute' => 'Quitar un minuto',
			'reports.sheet.addMinute' => 'Añadir un minuto',
			'reports.sheet.holdToRepeat' => 'Mantén presionado para ir más rápido',
			'reports.sheet.decrease' => 'Disminuir',
			'reports.sheet.increase' => 'Aumentar',
			'reports.sheet.clear' => 'Borrar',
			'reports.sheet.validate' => 'Listo',
			'reports.history.daysFilled' => ({required Object filled, required Object total}) => '${filled} días completados de ${total}',
			'reports.history.legendFilled' => 'Completado',
			'reports.history.legendMissing' => 'Sin informe',
			'reports.history.none' => 'Sin informe',
			'reports.history.fill' => 'Completar',
			'reports.history.inProgress' => 'En curso',
			'reports.history.previousMonth' => 'Mes anterior',
			'reports.history.nextMonth' => 'Mes siguiente',
			'reports.history.today' => 'hoy',
			'reports.summary.week' => 'Semana',
			'reports.summary.month' => 'Mes',
			'reports.summary.year' => 'Año',
			'reports.summary.range' => ({required Object from, required Object to}) => 'Del ${from} al ${to}',
			'reports.summary.regularity' => 'Constancia',
			'reports.summary.daysFilled' => 'días completados',
			'reports.summary.missingDays' => ({required num n, required Object days}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, one: '${n} día sin informe: el ${days}', other: '${n} días sin informe: los días ${days}', ), 
			'reports.summary.missingCount' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, one: '${n} día sin informe', other: '${n} días sin informe', ), 
			'reports.summary.noMissing' => 'No faltó ningún día, ¡bien hecho!',
			'reports.summary.perDay' => ({required Object value}) => '${value} por día completado',
			'reports.summary.days' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, one: '${n} día', other: '${n} días', ), 
			'reports.summary.notFilled' => 'Aún sin completar',
			'reports.summary.barsCaption' => ({required Object max}) => 'Por día · barra más alta: ${max}',
			'reports.summary.barsCaptionMonthly' => ({required Object max}) => 'Por mes · barra más alta: ${max}',
			'reports.summary.empty' => 'No hay informes en este período.',
			'reports.summary.goalDays' => ({required num n, required Object total}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, one: 'Objetivo alcanzado ${n} día de ${total}', other: 'Objetivo alcanzado ${n} días de ${total}', ), 
			'reports.summary.share' => 'Compartir este resumen',
			'reports.summary.goals' => 'Objetivos',
			'reports.summary.goalsAverage' => 'Cumplimiento medio de tus objetivos',
			'reports.summary.goalsHint' => 'Cada día cuenta, incluso vacío. Hoy cuenta una vez rellenado.',
			'reports.summary.evolution' => 'Evolución de tus objetivos',
			'reports.summary.evolutionHint' => 'Semana tras semana, en las últimas 12.',
			'reports.summary.premiumYear' => 'El año y la evolución de tus objetivos vienen con Premium.',
			'reports.noItems' => 'Por ahora no hay elementos que completar.',
			'reports.statusPending' => 'Aún no enviado',
			'reports.savedOffline' => 'Sin conexión: el día se guarda en el teléfono y se enviará en cuanto sea posible.',
			'reports.pendingBanner' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, one: '${n} día espera conexión para enviarse', other: '${n} días esperan conexión para enviarse', ), 
			'reports.export' => 'Exportar mi informe',
			'reports.goal' => ({required Object value}) => 'Objetivo: ${value}',
			'reports.goalReached' => 'Objetivo alcanzado',
			'reports.dayGoals' => 'Objetivos del día',
			'reports.goalsReached' => ({required Object reached, required Object total}) => 'Alcanzados: ${reached} de ${total}',
			'reports.standardItems.lb' => 'Lectura bíblica',
			'reports.standardItems.ps' => 'Oración personal',
			'reports.standardItems.rdqad' => 'Meditación',
			'reports.standardItems.pg' => 'Oración en grupo',
			'reports.standardItems.llc' => 'Lectura de literatura cristiana',
			'reports.standardItems.jc' => 'Ayuno completo',
			'reports.standardItems.jp' => 'Ayuno parcial',
			'reports.standardItems.dimes' => 'Diezmos',
			'reports.standardItems.off' => 'Ofrendas',
			'reports.units.chapters.name' => 'Número de capítulos',
			'reports.units.chapters.label' => 'capítulos',
			'reports.units.chapters.symbol' => 'capítulos',
			'reports.units.chapters.count' => ({required num n, required Object value}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, one: '${value} capítulo', other: '${value} capítulos', ), 
			'reports.units.times.name' => 'Número de veces',
			'reports.units.times.label' => 'veces',
			'reports.units.times.symbol' => 'veces',
			'reports.units.times.count' => ({required num n, required Object value}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, one: '${value} vez', other: '${value} veces', ), 
			'reports.units.pages.name' => 'Número de páginas',
			'reports.units.pages.label' => 'páginas',
			'reports.units.pages.symbol' => 'páginas',
			'reports.units.pages.count' => ({required num n, required Object value}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, one: '${value} página', other: '${value} páginas', ), 
			'reports.units.percent.name' => 'Porcentaje',
			'reports.units.percent.label' => 'porcentaje',
			'reports.units.percent.symbol' => '%',
			'reports.units.percent.count' => ({required Object value}) => '${value} %',
			'reports.timer.start' => 'Iniciar el cronómetro',
			'reports.timer.running' => 'Cronómetro en marcha',
			'reports.timer.startEnd' => 'Inicio – fin',
			'reports.timer.from' => 'Hora de inicio',
			'reports.timer.to' => 'Hora de fin',
			'reports.timer.span' => ({required Object from, required Object to}) => 'De ${from} a ${to}',
			'reports.timer.pause' => 'Pausar',
			'reports.timer.resume' => 'Reanudar',
			'reports.timer.finish' => 'Terminar',
			'reports.timer.discard' => 'Cancelar el cronómetro',
			'reports.timer.paused' => 'En pausa',
			'reports.timer.added' => ({required Object time, required Object item}) => '${time} añadidos a «${item}»',
			'reports.timer.noItem' => 'El cronómetro se detuvo, pero este elemento ya no está en tu informe.',
			'reports.timer.replaceTitle' => '¿Reemplazar el cronómetro?',
			'reports.timer.replaceText' => ({required Object item}) => 'Ya hay un cronómetro para «${item}». Se detendrá sin contarse.',
			'reports.timer.replace' => 'Reemplazar',
			'reports.timer.channel' => 'Cronómetro en marcha',
			'reports.timer.ongoingBody' => 'Toca para pausar o terminar',
			'reports.timer.pickButton' => 'Iniciar un cronómetro',
			'reports.timer.pickTitle' => '¿Qué quieres cronometrar?',
			'reports.timer.pickHint' => 'Al terminar, los minutos se suman solos al informe de hoy.',
			'reports.timer.pickEmpty' => 'Ningún elemento de tu informe se cuenta en tiempo.',
			'reports.timer.todayMinutes' => ({required Object time}) => '${time} hoy',
			'reports.timer.notYet' => 'Todavía no hoy',
			'reminder.title' => 'Tu informe del día',
			'reminder.body' => 'Tómate un minuto para anotar tu lectura, tu oración… antes de que termine el día.',
			'reminder.channel' => 'Recordatorio del informe',
			'reminder.settings' => 'Recordatorio nocturno',
			'reminder.off' => 'Desactivado',
			'reminder.switchLabel' => 'Recordarme completar mi día',
			'reminder.switchHint' => 'Solo si el día aún no está completado.',
			'reminder.time' => 'Hora del recordatorio',
			'reminder.offerTitle' => '¿Un recordatorio cada noche?',
			'reminder.offerText' => 'Si tu día aún no está completado, la app te lo recuerda a la hora que elijas. Nada si ya lo hiciste.',
			'reminder.offerAccept' => 'Activar el recordatorio',
			'reminder.offerLater' => 'Más tarde',
			'reminder.enabled' => ({required Object time}) => 'Recordatorio activado a las ${time}',
			'reminder.denied' => 'Las notificaciones están bloqueadas para CMFI Connect. Permítelas en los ajustes del teléfono.',
			'export.title' => 'Exportar',
			'export.period' => 'Período',
			'export.thisWeek' => 'Esta semana',
			'export.lastWeek' => 'La semana pasada',
			'export.thisMonth' => 'Este mes',
			'export.lastMonth' => 'El mes pasado',
			'export.thisYear' => 'Este año',
			'export.custom' => 'Otras fechas',
			'export.customPick' => 'Elegir las fechas',
			'export.format' => 'Formato',
			'export.pdf' => 'PDF',
			'export.pdfHint' => 'Un documento para enviar o imprimir',
			'export.csv' => 'Hoja de cálculo',
			'export.csvHint' => 'Un archivo CSV para Excel o Google Sheets',
			'export.text' => 'Mensaje',
			'export.textHint' => 'Un resumen para pegar en WhatsApp',
			'export.button' => 'Exportar',
			'export.shareButton' => 'Compartir',
			'export.preview' => ({required num filled, required Object total, required Object items}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(filled, one: '${filled} día completado de ${total} · ${items}', other: '${filled} días completados de ${total} · ${items}', ), 
			'export.previewItems' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, one: '${n} elemento', other: '${n} elementos', ), 
			'export.empty' => 'No hay informes en este período.',
			'export.tooLong' => 'Elige 366 días como máximo.',
			'export.fileName' => 'informe-diario',
			'export.subject' => ({required Object period}) => 'Mi informe, ${period}',
			'export.doc.title' => 'Informe diario',
			'export.doc.regularity' => 'Constancia',
			'export.doc.daysFilled' => ({required num filled, required Object total}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(filled, one: '${filled} día completado de ${total}', other: '${filled} días completados de ${total}', ), 
			'export.doc.totals' => 'En el período',
			'export.doc.item' => 'Elemento',
			'export.doc.total' => 'Total',
			'export.doc.days' => 'Días',
			'export.doc.average' => 'Promedio / día completado',
			'export.doc.goal' => 'Objetivo alcanzado',
			'export.doc.detail' => 'Día a día',
			'export.doc.date' => 'Fecha',
			'export.doc.values' => 'Completado',
			'export.doc.note' => 'Nota',
			'export.doc.noReport' => 'Sin informe',
			'export.doc.generated' => ({required Object date}) => 'Generado el ${date} con CMFI Connect',
			'export.doc.page' => ({required Object n, required Object total}) => 'Página ${n} / ${total}',
			'export.doc.filledColumn' => 'Informe',
			'export.doc.yes' => 'sí',
			'export.doc.no' => 'no',
			'export.doc.sentFrom' => 'Enviado desde CMFI Connect',
			'items.title' => 'Mis elementos',
			'items.standardSection' => 'Estándar · para todos',
			'items.personalSection' => 'Mis elementos personales',
			'items.emptyPersonal' => 'Aún no tienes elementos personales.',
			'items.archive' => 'Archivar',
			'items.archiveTitle' => ({required Object code}) => '¿Archivar ${code}?',
			'items.archiveText' => 'Ya no aparecerá en tu informe. Sus cifras se quedan en tu historial.',
			'items.archived' => ({required Object code}) => '${code} archivado',
			'items.create' => 'Crear un elemento',
			'items.footnote' => 'Un elemento archivado ya no aparece en tu informe, pero sus cifras se quedan en tu historial.',
			'items.measure.quantity' => ({required Object unit}) => 'Cantidad · ${unit}',
			'items.measure.quantityNoUnit' => 'Cantidad',
			'items.measure.duration' => 'Duración',
			'items.measure.both' => ({required Object unit}) => 'Cantidad (${unit}) y duración',
			'items.measure.bothNoUnit' => 'Cantidad y duración',
			'items.goalAdd' => 'Añadir un objetivo',
			'items.goal' => ({required Object value}) => 'Objetivo: ${value} al día',
			'items.goalTitle' => 'Objetivo diario',
			'items.goalHint' => 'Lo que te propones cada día. Se queda en tu teléfono.',
			'items.goalRemove' => 'Quitar',
			'items.goalSaved' => 'Objetivo guardado',
			'items.goalRemoved' => 'Objetivo quitado',
			'newItem.title' => 'Nuevo elemento',
			'newItem.code' => 'Código',
			'newItem.label' => 'Nombre',
			'newItem.help' => 'Letras y números, 20 como máximo. El código de un elemento estándar (LB, PS…) no está disponible.',
			'newItem.measures' => 'Lo que mides',
			'newItem.quantity' => 'Una cantidad',
			'newItem.quantityHint' => 'Capítulos, páginas, personas…',
			'newItem.unit' => 'Unidad que aparece después del número',
			'newItem.unitHint' => 'personas',
			'newItem.duration' => 'Una duración',
			'newItem.durationHint' => 'En horas y minutos',
			'newItem.noMeasure' => 'Elige al menos una medida: una cantidad, una duración o ambas.',
			'newItem.preview' => 'Vista previa en tu informe',
			'newItem.previewCode' => 'CÓDIGO',
			'newItem.previewLabel' => 'Nombre del elemento',
			'newItem.submit' => 'Crear el elemento',
			'newItem.created' => ({required Object code}) => '${code} se ha creado.',
			'newItem.codeTaken' => 'Este código ya está en uso, por un elemento estándar o por uno de tus elementos (aunque esté archivado).',
			'newItem.codeHint' => 'EVG',
			'newItem.labelHint' => 'Evangelización',
			'more.title' => 'Más',
			'more.editProfile' => 'Editar mi perfil',
			'more.community' => 'Comunidad',
			'more.events' => 'Eventos',
			'more.reports' => 'Informe diario',
			'more.myItems' => 'Mis elementos',
			'more.app' => 'Aplicación',
			'more.language' => 'Idioma',
			'more.appearance' => 'Apariencia',
			'more.themeSystem' => 'Automático',
			'more.themeSystemHint' => 'En automático, la app sigue el modo claro u oscuro del teléfono.',
			'more.themeLight' => 'Claro',
			'more.themeDark' => 'Oscuro',
			'more.logout' => 'Cerrar sesión',
			'more.account' => 'Cuenta',
			'more.languageTitle' => 'Idioma de la aplicación',
			'more.completeProfile' => 'Añade tu nombre',
			'more.accompaniment' => 'Acompañamiento',
			'more.exportReport' => 'Exportar mi informe',
			'more.logoutPendingTitle' => 'Días aún no enviados',
			'more.logoutPendingText' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, one: '${n} día guardado sin conexión aún no se ha enviado. Si cierras sesión ahora, se perderá.', other: '${n} días guardados sin conexión aún no se han enviado. Si cierras sesión ahora, se perderán.', ), 
			'more.logoutAnyway' => 'Cerrar sesión',
			'more.admin' => 'Administración',
			'more.staff' => 'Equipo y roles',
			'more.manageEvents' => 'Eventos',
			'more.disciples' => 'Mis discípulos',
			'more.version' => ({required Object version}) => 'Versión ${version}',
			'more.copyright' => ({required Object year}) => '© ${year} Comunidad Misionera Cristiana Internacional. Todos los derechos reservados.',
			'authorities.title' => 'Mis autoridades espirituales',
			'authorities.intro' => 'Las personas que te acompañan en tu caminar con Dios: tu discipulador y tus otros líderes.',
			'authorities.discipleMaker' => 'Discipulador',
			'authorities.discipleMakerOf' => ({required Object name}) => 'Discipulador: ${name}',
			'authorities.noDiscipleMaker' => 'Aún no tienes discipulador',
			'authorities.others' => 'Otras autoridades',
			'authorities.empty' => 'Aún no has añadido a nadie.',
			'authorities.add' => 'Añadir una autoridad',
			'authorities.remove' => 'Quitar',
			'authorities.removeTitle' => ({required Object name}) => '¿Quitar a ${name}?',
			'authorities.removeText' => ({required Object name}) => '${name} ya no formará parte de tus autoridades espirituales.',
			'authorities.removed' => ({required Object name}) => '${name} ya no forma parte de tus autoridades.',
			'authorities.count' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, zero: 'Nadie por ahora', one: '${n} persona', other: '${n} personas', ), 
			'authorities.form.title' => 'Nueva autoridad',
			'authorities.form.emailHint' => 'nombre@ejemplo.com',
			'authorities.form.isDiscipleMaker' => 'Es mi discipulador',
			'authorities.form.isDiscipleMakerHelp' => 'La persona que te acompaña personalmente. Solo tienes uno.',
			'authorities.form.discipleMakerTaken' => ({required Object name}) => '${name} ya es tu discipulador. Quítalo de la lista para elegir a otro.',
			'authorities.form.submit' => 'Añadir',
			'authorities.form.added' => ({required Object name}) => '${name} ahora forma parte de tus autoridades.',
			'authorities.form.searchLabel' => 'Su nombre de usuario',
			'authorities.form.searchHint' => 'usuario',
			'authorities.form.search' => 'Buscar',
			'authorities.form.searchHelp' => 'Si la persona usa CMFI Connect, búscala por su nombre de usuario. Recibirá tu solicitud, y sus datos de contacto aparecerán cuando la acepte.',
			'authorities.form.notFound' => ({required Object username}) => 'Nadie tiene el nombre de usuario @${username}.',
			'authorities.form.invite' => 'Invitarla a unirse a CMFI Connect',
			'authorities.form.inviteText' => '¡Hola! Uso CMFI Connect para llevar el registro de mi caminar con Dios, y me gustaría que me acompañaras. Instala la aplicación, crea tu cuenta y luego envíame tu nombre de usuario para que pueda añadirte.',
			'authorities.form.inviteMine' => ({required Object username}) => 'Mi nombre de usuario: @${username}',
			'authorities.form.manual' => '¿No tiene la aplicación? Introducir sus datos',
			'authorities.form.backToSearch' => 'Buscar por nombre de usuario',
			'authorities.form.request' => 'Enviar la solicitud',
			'authorities.form.requested' => ({required Object name}) => 'Solicitud enviada a ${name}.',
			'authorities.form.alreadyAdded' => 'Esta persona ya forma parte de tus autoridades.',
			'authorities.form.makerExists' => 'Ya tienes un discipulador.',
			'authorities.form.yourself' => 'Es tu propio nombre de usuario.',
			'authorities.form.sharingHelp' => ({required Object name}) => '${name} verá tus informes: los elementos rellenados, tu regularidad y tus porcentajes, nunca tu nota. Puedes detenerlo en su ficha.',
			'authorities.statusPending' => 'Pendiente',
			'authorities.statusDeclined' => 'Rechazada',
			'authorities.pendingHelp' => ({required Object name}) => 'Sus datos de contacto aparecerán cuando ${name} acepte.',
			'authorities.requests' => 'Solicitudes recibidas',
			'authorities.requestDiscipleMaker' => 'te pide que seas su discipulador',
			'authorities.requestAuthority' => 'te pide tu acompañamiento',
			'authorities.accept' => 'Aceptar',
			'authorities.decline' => 'Rechazar',
			'authorities.acceptedRequest' => ({required Object name}) => 'Ahora acompañas a ${name}.',
			'authorities.declinedRequest' => ({required Object name}) => 'Solicitud de ${name} rechazada.',
			'authorities.requestsCount' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, one: '${n} solicitud por revisar', other: '${n} solicitudes por revisar', ), 
			'authorities.sharing.title' => 'Compartir mis informes',
			'authorities.sharing.help' => ({required Object name}) => '${name} ve tus informes: los elementos rellenados, tu regularidad y tus porcentajes, nunca tu nota.',
			'authorities.sharing.on' => ({required Object name}) => 'Tus informes se comparten con ${name}.',
			'authorities.sharing.off' => ({required Object name}) => '${name} ya no ve tus informes.',
			'members.username' => 'Nombre de usuario',
			'members.usernameHint' => 'nombre.apellido',
			'members.usernameHelp' => 'Así te encontrarán los demás miembros.',
			'members.usernameChecking' => 'Comprobando…',
			'members.usernameFree' => ({required Object username}) => '@${username} está disponible',
			'members.usernameCurrent' => 'Es tu nombre de usuario actual',
			'members.usernameTaken' => 'Este nombre de usuario ya está en uso.',
			'members.usernameInvalid' => 'De 3 a 30 caracteres: letras, números, «.» y «_», sin empezar ni terminar con un signo.',
			'members.usernameReserved' => 'Este nombre de usuario está reservado.',
			'members.usernameSaved' => ({required Object username}) => 'Nombre de usuario guardado: @${username}',
			'members.deleteAccount.button' => 'Eliminar mi cuenta',
			_ => null,
		} ?? switch (path) {
			'members.deleteAccount.title' => 'Eliminar mi cuenta',
			'members.deleteAccount.intro' => 'Es definitivo. Tu cuenta y todo lo relacionado con ella se borrará:',
			'members.deleteAccount.itemProfile' => 'tu perfil, tu foto, tu nombre de usuario y tu contraseña',
			'members.deleteAccount.itemReports' => 'todos tus informes, tus elementos y tus objetivos',
			'members.deleteAccount.itemAuthorities' => 'tus autoridades espirituales y las solicitudes recibidas',
			'members.deleteAccount.itemEvents' => 'tus inscripciones a eventos',
			'members.deleteAccount.itemPrayer' => 'tus listas de oración, tus retiros y tus motivos de importunidad',
			'members.deleteAccount.kept' => 'Los eventos, novedades, fotos y motivos de oración que publicaste como admin se quedan para la comunidad, sin tu nombre.',
			'members.deleteAccount.passwordHelp' => 'Para confirmar que eres tú.',
			'members.deleteAccount.confirm' => 'Eliminar definitivamente',
			'members.deleteAccount.done' => 'Tu cuenta ha sido eliminada. ¡Dios te bendiga!',
			'members.deleteAccount.wrongPassword' => 'Contraseña incorrecta.',
			'members.deleteAccount.lastSuperadmin' => 'Eres el único superadmin: da este rol a otra persona antes de eliminar tu cuenta.',
			'admin.title' => 'Equipo y roles',
			'admin.intro' => 'Los admins gestionan lo que comparte toda la comunidad. Solo un superadmin da o quita un rol.',
			'admin.roleUser' => 'Miembro',
			'admin.roleAdmin' => 'Admin',
			'admin.roleSuperadmin' => 'Superadmin',
			'admin.giveRole' => 'Dar un rol',
			'admin.you' => 'tú',
			'admin.roleFor' => ({required Object username}) => 'Rol de @${username}',
			'admin.roleChanged' => ({required Object username, required Object role}) => '@${username}: ${role}',
			'admin.memberUsername' => 'Nombre de usuario del miembro',
			'admin.empty' => 'Aún no hay ningún admin.',
			'hymns.searchHint' => 'Número, título o letra',
			'hymns.openNumber' => 'Ir a un número',
			'hymns.tabs.all' => 'Todos',
			'hymns.tabs.favorites' => 'Favoritos',
			'hymns.tabs.recent' => 'Recientes',
			'hymns.chooseBook' => 'Elegir el himnario',
			'hymns.count' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, one: '${n} himno', other: '${n} himnos', ), 
			'hymns.number' => ({required Object number}) => 'N.º ${number}',
			'hymns.emptyFavorites' => 'Toca la estrella de un himno para encontrarlo aquí.',
			'hymns.emptyRecent' => 'Los himnos que abras aparecerán aquí.',
			'hymns.noResult' => ({required Object query}) => 'Ningún himno coincide con «${query}».',
			'hymns.otherBooks' => 'En los otros himnarios',
			'hymns.upToDate' => 'Los himnarios están al día.',
			'hymns.updated' => 'Los himnarios se han actualizado.',
			'hymns.chorus' => 'Coro',
			'hymns.chorusNumber' => ({required Object label}) => 'Coro ${label}',
			'hymns.verse' => ({required Object label}) => 'Estrofa ${label}',
			'hymns.times' => ({required Object n}) => '×${n}',
			'hymns.loadFailed' => 'No se pudieron abrir los himnarios.',
			'hymns.reader.smaller' => 'Reducir el texto',
			'hymns.reader.larger' => 'Ampliar el texto',
			'hymns.reader.display' => 'Visualización',
			'hymns.reader.textSize' => 'Tamaño del texto',
			'hymns.reader.typeface' => 'Fuente',
			'hymns.reader.typefaceAuto' => 'Auto',
			'hymns.reader.typefaceSans' => 'Moderna',
			'hymns.reader.typefaceSerif' => 'Clásica',
			'hymns.reader.typefaceAutoHelp' => 'Clásica cuando el texto es grande',
			'hymns.reader.background' => 'Fondo',
			'hymns.reader.themeAuto' => 'Auto',
			'hymns.reader.themeLight' => 'Claro',
			'hymns.reader.themeSepia' => 'Sepia',
			'hymns.reader.themeDark' => 'Oscuro',
			'hymns.reader.repeatChorus' => 'Repetir el coro después de cada estrofa',
			'hymns.reader.keepScreenOn' => 'Mantener la pantalla encendida',
			'hymns.reader.addFavorite' => 'Añadir a favoritos',
			'hymns.reader.removeFavorite' => 'Quitar de favoritos',
			'hymns.reader.favoriteAdded' => 'Añadido a favoritos',
			'hymns.reader.favoriteRemoved' => 'Quitado de favoritos',
			'hymns.reader.more' => 'Más opciones',
			'hymns.reader.copy' => 'Copiar la letra',
			'hymns.reader.copied' => 'Letra copiada',
			'hymns.reader.project' => 'Modo proyección',
			'hymns.reader.pinchHint' => 'Pellizca la pantalla para agrandar o reducir el texto.',
			'hymns.reader.notFound' => 'Este himno ya no está en el himnario.',
			'hymns.reader.share' => 'Compartir la letra',
			'hymns.projection.exit' => 'Salir del modo proyección',
			'hymns.projection.previous' => 'Estrofa anterior',
			'hymns.projection.next' => 'Estrofa siguiente',
			'hymns.projection.position' => ({required Object current, required Object total}) => '${current} / ${total}',
			'hymns.projection.hint' => 'Toca a la derecha para avanzar y a la izquierda para volver.',
			'hymns.pad.title' => 'Ir al himno',
			'hymns.pad.open' => 'Abrir',
			'hymns.pad.erase' => 'Borrar',
			'hymns.pad.notFound' => ({required Object number}) => 'No hay himno n.º ${number} en este himnario',
			'hymns.pad.placeholder' => 'Escribe un número',
			'comingSoon.badge' => 'Próximamente',
			'comingSoon.backHome' => 'Volver al inicio',
			'events.title' => 'Eventos',
			'events.featured' => 'Destacado',
			'events.upcoming' => 'Próximos',
			'events.past' => 'Ediciones anteriores',
			'events.emptyTitle' => 'No hay eventos próximos',
			'events.emptyText' => 'Las conferencias y los encuentros de toda la comunidad aparecerán aquí, con su programa.',
			'events.manage' => 'Gestionar los eventos',
			'events.next' => 'Próximo evento',
			'events.seeAll' => 'Todos los eventos',
			'events.homeText' => 'Los encuentros de la comunidad, su programa y sus novedades.',
			'events.today' => 'Hoy',
			'events.tomorrow' => 'Mañana',
			'events.inDays' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, one: 'En ${n} día', other: 'En ${n} días', ), 
			'events.daysLeft' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, other: 'Faltan ${n} días', ), 
			'events.onNow' => 'En curso',
			'events.over' => 'Terminado',
			'events.cancelled' => 'Cancelado',
			'events.draft' => 'Borrador',
			'events.registered' => 'Inscrito',
			'events.stateOpen' => 'Inscripciones abiertas',
			'events.stateClosed' => 'Inscripciones cerradas',
			'events.stateFull' => 'Completo',
			'events.registrations' => ({required num n, required Object count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, zero: 'Sé el primero en inscribirte', one: '${count} inscrito', other: '${count} inscritos', ), 
			'events.people' => ({required num n, required Object count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, one: '${count} persona', other: '${count} personas', ), 
			'events.placesLeft' => ({required num n, required Object count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, zero: 'no quedan plazas', one: '${count} plaza disponible', other: '${count} plazas disponibles', ), 
			'events.oneDay' => ({required Object start, required Object end}) => 'De ${start} a ${end}',
			'events.severalDays' => ({required Object startDay, required Object start, required Object endDay, required Object end}) => 'Apertura el ${startDay} a las ${start}, clausura el ${endDay} a las ${end}',
			'events.venueTime' => ({required Object place}) => 'hora de ${place}',
			'events.addToCalendar' => 'Añadir al calendario',
			'events.share' => 'Compartir',
			'events.directions' => 'Cómo llegar',
			'events.viewPoster' => 'Ver el cartel',
			'events.tabs.program' => 'Programa',
			'events.tabs.news' => 'Novedades',
			'events.tabs.info' => 'Info',
			'events.tabs.photos' => 'Fotos',
			'events.noProgram' => 'El programa se publicará pronto.',
			'events.noNews' => 'Aún no hay novedades de este evento.',
			'events.pinned' => 'Fijado',
			'events.now' => 'Ahora mismo',
			'events.hymn' => ({required Object number}) => 'Himno ${number}',
			'events.about' => 'Acerca de',
			'events.fees' => 'Aportación',
			'events.deadline' => ({required Object date}) => 'Inscripciones hasta el ${date}',
			'events.contact' => 'Contacto',
			'events.call' => ({required Object name}) => 'Llamar a ${name}',
			'events.otherEditions' => 'Las otras ediciones',
			'events.cancelledBanner' => 'Este evento está cancelado.',
			'events.calendarFailed' => 'No se pudo abrir el calendario del teléfono.',
			'events.linkFailed' => 'No se pudo abrir este enlace.',
			'events.shareText' => ({required Object title, required Object dates, required Object place}) => '${title}\n${dates} · ${place}\nInscríbete en la app CMFI Connect.',
			'events.full' => 'Ya no quedan plazas para este evento.',
			'events.closed' => 'Las inscripciones para este evento están cerradas.',
			'events.register.cta' => 'Participaré',
			'events.register.title' => 'Participaré',
			'events.register.people' => '¿Cuántas personas vendrán?',
			'events.register.peopleHint' => 'Contándote a ti, con tu familia o tu grupo.',
			'events.register.less' => 'Una persona menos',
			'events.register.more' => 'Una persona más',
			'events.register.lodging' => 'Necesito alojamiento',
			'events.register.lodgingHint' => 'Los organizadores prevén las plazas.',
			'events.register.departure' => 'Ciudad de salida',
			'events.register.departureHint' => 'Ej.: Douala',
			'events.register.confirm' => 'Confirmar mi inscripción',
			'events.register.update' => 'Actualizar',
			'events.register.cancel' => 'Cancelar mi inscripción',
			'events.register.done' => '¡Listo, estás inscrito! Te lo recordaremos el día antes.',
			'events.register.updated' => 'Tu inscripción está actualizada.',
			'events.register.cancelled' => 'Tu inscripción se ha cancelado.',
			'events.register.edit' => 'Modificar',
			'events.register.youAre' => 'Estás inscrito',
			'events.register.cancelTitle' => '¿Cancelar tu inscripción?',
			'events.register.cancelText' => 'Tu plaza quedará libre para otra persona.',
			'events.register.keep' => 'Mantener mi plaza',
			'events.register.lodgingShort' => 'alojamiento',
			'events.reminder.channel' => 'Recordatorios de eventos',
			'events.reminder.tomorrow' => ({required Object title}) => 'Mañana: ${title}',
			'events.reminder.soon' => ({required Object title}) => 'En 1 h: ${title}',
			'events.admin.title' => 'Gestionar los eventos',
			'events.admin.create' => 'Crear un evento',
			'events.admin.edit' => 'Editar el evento',
			'events.admin.empty' => 'Aún no hay eventos. ¡Crea el primero!',
			'events.admin.poster' => 'Cartel',
			'events.admin.posterAdd' => 'Elegir un cartel',
			'events.admin.posterChange' => 'Cambiar el cartel',
			'events.admin.posterRemove' => 'Quitar el cartel',
			'events.admin.posterHint' => 'Formato vertical 4:5 recomendado (1080 × 1350), JPEG o PNG.',
			'events.admin.uploading' => 'Enviando la imagen…',
			'events.admin.general' => 'El evento',
			'events.admin.titleField' => 'Título',
			'events.admin.titleHint' => 'Ej.: Conferencia anual 2026',
			'events.admin.titleRequired' => 'Ponle un título al evento.',
			'events.admin.theme' => 'Tema',
			'events.admin.themeHint' => 'Ej.: Andar en el Espíritu',
			'events.admin.verse' => 'Versículo del tema',
			'events.admin.description' => 'Presentación',
			'events.admin.when' => 'Fechas',
			'events.admin.starts' => 'Inicio',
			'events.admin.ends' => 'Fin',
			'events.admin.endsBeforeStart' => 'El fin debe ser posterior al inicio.',
			'events.admin.timeZone' => ({required Object zone}) => 'Horario del lugar (${zone}).',
			'events.admin.where' => 'Lugar',
			'events.admin.venue' => 'Lugar',
			'events.admin.venueHint' => 'Ej.: Centro de conferencias de Mvolyé',
			'events.admin.address' => 'Dirección',
			'events.admin.city' => 'Ciudad',
			'events.admin.country' => 'País',
			'events.admin.mapsUrl' => 'Enlace de Google Maps',
			'events.admin.registration' => 'Inscripciones',
			'events.admin.registrationOpen' => 'Inscripciones abiertas',
			'events.admin.deadline' => 'Fecha límite',
			'events.admin.noDeadline' => 'Sin fecha límite',
			'events.admin.capacity' => 'Número de plazas',
			'events.admin.capacityHint' => 'Vacío: sin límite',
			'events.admin.asksLodging' => 'Preguntar quién necesita alojamiento',
			'events.admin.asksDeparture' => 'Preguntar la ciudad de salida',
			'events.admin.fees' => 'Aportación',
			'events.admin.feesHint' => 'Ej.: Entrada libre. Comidas: 2000 FCFA al día.',
			'events.admin.contact' => 'Contacto',
			'events.admin.contactName' => 'Nombre del contacto',
			'events.admin.contactPhone' => 'Teléfono del contacto',
			'events.admin.visibility' => 'Visibilidad',
			'events.admin.statusDraft' => 'Borrador',
			'events.admin.statusDraftHint' => 'Solo lo ven los admins',
			'events.admin.statusPublished' => 'Publicado',
			'events.admin.statusPublishedHint' => 'Lo ve toda la comunidad',
			'events.admin.statusCancelled' => 'Cancelado',
			'events.admin.statusCancelledHint' => 'Se muestra como cancelado, sin inscripción',
			'events.admin.saved' => 'Evento guardado.',
			'events.admin.menu' => 'Gestionar',
			'events.admin.program' => 'Programa',
			'events.admin.registrants' => 'Inscritos',
			'events.admin.post' => 'Publicar una novedad',
			'events.admin.photos' => 'Añadir fotos',
			'events.admin.nextEdition' => 'Preparar la próxima edición',
			'events.admin.delete' => 'Eliminar el evento',
			'events.admin.deleteTitle' => '¿Eliminar este evento?',
			'events.admin.deleteText' => 'También se eliminarán las inscripciones, las novedades y las fotos.',
			'events.admin.deleteConfirm' => 'Eliminar',
			'events.admin.deleted' => 'Evento eliminado.',
			'events.admin.nextEditionTitle' => '¿Preparar la próxima edición?',
			'events.admin.nextEditionText' => 'Se crea un borrador un año después, con el mismo lugar y el mismo programa. Podrás ajustarlo todo antes de publicarlo.',
			'events.admin.nextEditionConfirm' => 'Preparar',
			'events.admin.nextEditionDone' => 'La próxima edición está lista como borrador.',
			'events.admin.programEmpty' => 'Añade los momentos del evento: acogida, cultos, enseñanzas, vigilia…',
			'events.admin.addSession' => 'Añadir un momento',
			'events.admin.editSession' => 'Editar este momento',
			'events.admin.sessionTitle' => 'Título',
			'events.admin.sessionTitleHint' => 'Ej.: Culto de apertura',
			'events.admin.speaker' => 'Orador',
			'events.admin.place' => 'Sala',
			'events.admin.day' => 'Día',
			'events.admin.from' => 'De',
			'events.admin.to' => 'A',
			'events.admin.hymns' => 'Himnos',
			'events.admin.hymnsHint' => 'Números, ej.: 12, 45',
			'events.admin.removeSession' => 'Quitar',
			'events.admin.saveProgram' => 'Guardar el programa',
			'events.admin.programSaved' => 'Programa guardado.',
			'events.admin.registrantsEmpty' => 'Aún no hay nadie inscrito.',
			'events.admin.totalRegistrations' => 'Inscripciones',
			'events.admin.totalPeople' => 'Personas',
			'events.admin.totalLodging' => 'Por alojar',
			'events.admin.byCity' => 'Por ciudad de salida',
			'events.admin.list' => 'Lista',
			'events.admin.exportCsv' => 'Exportar la lista (CSV)',
			'events.admin.csvHeader' => 'Nombre;Usuario;Teléfono;Iglesia;Asamblea;Personas;Alojamiento;Ciudad de salida;Inscrito el',
			'events.admin.yes' => 'sí',
			'events.admin.no' => 'no',
			'events.admin.postBody' => 'Mensaje',
			'events.admin.postBodyHint' => 'Ej.: ¡Las inscripciones están abiertas!',
			'events.admin.postImage' => 'Añadir una imagen',
			'events.admin.postPinned' => 'Fijar arriba',
			'events.admin.postSend' => 'Publicar',
			'events.admin.postDone' => 'Novedad publicada.',
			'events.admin.postDelete' => 'Eliminar esta novedad',
			'events.admin.postDeleted' => 'Novedad eliminada.',
			'events.admin.photosAdded' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, one: '${n} foto añadida.', other: '${n} fotos añadidas.', ), 
			'events.admin.photosSending' => ({required Object done, required Object total}) => 'Enviando las fotos (${done}/${total})…',
			'events.admin.photoDelete' => 'Eliminar esta foto',
			'events.admin.photoDeleted' => 'Foto eliminada.',
			'events.admin.confirmDelete' => 'Eliminar',
			'events.admin.price' => 'Precio por persona (FCFA)',
			'events.admin.priceHint' => 'Vacío: gratis. Se paga con dinero móvil al inscribirse.',
			'events.upcomingCount' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, one: '${n} evento próximo', other: '${n} eventos próximos', ), 
			'events.slide' => ({required Object current, required Object total}) => 'Evento ${current} de ${total}',
			'events.pay.title' => 'Pago con dinero móvil',
			'events.pay.perPerson' => ({required Object price}) => '${price} por persona',
			'events.pay.total' => 'Total a pagar',
			'events.pay.phone' => 'Número de dinero móvil',
			'events.pay.phoneHint' => '+237 6 70 00 00 00',
			'events.pay.phoneHelp' => 'Con el prefijo del país. La solicitud de pago llega a este teléfono.',
			'events.pay.operator' => 'Operador',
			'events.pay.pay' => ({required Object amount}) => 'Pagar ${amount}',
			'events.pay.waitingTitle' => 'Confirma en tu teléfono',
			'events.pay.waitingText' => ({required Object amount}) => 'Llega a tu teléfono una solicitud de ${amount}. Introduce tu PIN de dinero móvil para validarla.',
			'events.pay.waitingSlow' => 'Aún en espera. Tu inscripción se confirmará en cuanto llegue el pago, aunque cierres esta ventana.',
			'events.pay.close' => 'Cerrar',
			'events.pay.retry' => 'Reintentar',
			'events.pay.done' => 'Pago recibido: ¡estás inscrito!',
			'events.pay.failedTitle' => 'El pago no se completó',
			'events.pay.paidNote' => 'Inscripción pagada. Para anularla, contacta con los organizadores: te devolverán el dinero.',
			'events.pay.peopleLocked' => 'El número de personas pagado ya no se puede cambiar.',
			'events.pay.failures.insufficientBalance' => 'El saldo de esta cuenta de dinero móvil es insuficiente.',
			'events.pay.failures.payerNotFound' => 'Este número no tiene cuenta de dinero móvil con este operador.',
			'events.pay.failures.limitReached' => 'Esta cuenta de dinero móvil ha alcanzado su límite.',
			'events.pay.failures.notApproved' => 'El pago no se validó: PIN no introducido o rechazado.',
			'events.pay.failures.unavailable' => 'El operador no está disponible ahora. Inténtalo más tarde.',
			'events.pay.failures.generic' => 'El pago falló. Inténtalo de nuevo o usa otro número.',
			'events.pay.failures.sandbox' => 'En modo de prueba solo se aceptan los números de prueba de KPay: usa, por ejemplo, el 6 53 45 67 89.',
			'events.pay.later' => 'Pagaré más tarde',
			'events.pay.toPay' => ({required Object amount}) => 'Por pagar: ${amount}',
			'events.pay.payNow' => 'Pagar',
			'events.pay.unavailable' => 'El pago con dinero móvil aún no está disponible: inscríbete, podrás pagar más tarde.',
			'events.pay.laterDone' => ({required Object amount}) => '¡Estás inscrito! Recuerda pagar ${amount} antes del evento.',
			'events.pay.paidShort' => 'pagado',
			'notifications.title' => 'Notificaciones',
			'notifications.channel' => 'Anuncios de la comunidad',
			'notifications.empty' => 'Aún no hay notificaciones',
			'notifications.emptyHint' => 'Los anuncios de la comunidad llegarán aquí.',
			'notifications.unreadLabel' => ({required Object title}) => 'Sin leer: ${title}',
			'notifications.documents' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, one: '${n} documento PDF', other: '${n} documentos PDF', ), 
			'notifications.unread' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, one: '${n} sin leer', other: '${n} sin leer', ), 
			'notifications.image' => ({required Object n}) => 'Imagen ${n}',
			'notifications.document' => 'Documento PDF',
			'notifications.documentSize' => ({required Object kb}) => '${kb} KB',
			'premium.name' => 'CMFI Connect Premium',
			'premium.pill' => 'Premium',
			'premium.subtitle' => 'Avanza en tu camino con Dios y apoya la obra.',
			'premium.widgetTitle' => 'El widget de la pantalla de inicio',
			'premium.widgetText' => 'Tu informe del día y tus objetivos, sin abrir la app.',
			'premium.statsTitle' => 'Tus objetivos durante el año',
			'premium.statsText' => 'El balance del año y la evolución de tus objetivos, semana tras semana.',
			'premium.supportTitle' => 'Apoyas la obra',
			'premium.supportText' => 'Tu suscripción mantiene la app para toda la comunidad.',
			'premium.annual' => 'Anual',
			'premium.lifetime' => 'De por vida',
			'premium.monthly' => 'Mensual',
			'premium.perYear' => ({required Object price}) => '${price} / año',
			'premium.once' => ({required Object price}) => '${price} una vez',
			'premium.perMonth' => ({required Object price}) => '${price} / mes',
			'premium.annualPerMonth' => ({required Object price}) => 'es decir, ${price} al mes',
			'premium.best' => 'La más ventajosa',
			'premium.trialDays' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, one: '${n} día de prueba gratis', other: '${n} días de prueba gratis', ), 
			'premium.trialMonths' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, one: '${n} mes de prueba gratis', other: '${n} meses de prueba gratis', ), 
			'premium.subscribe' => 'Suscribirme',
			'premium.startTrial' => 'Empezar la prueba gratis',
			'premium.restore' => 'Restaurar compras',
			'premium.restored' => 'Premium vuelve a estar en este teléfono',
			'premium.nothingToRestore' => 'No hay compras Premium para esta cuenta',
			'premium.thanks' => '¡Gracias! Premium está activado.',
			'premium.failed' => 'La compra no se completó. Inténtalo de nuevo en un momento.',
			'premium.unavailable' => 'Las ofertas no están disponibles por ahora.',
			'premium.renews' => ({required Object store}) => 'La suscripción se renueva automáticamente. Puedes cancelarla cuando quieras en los ajustes de tu cuenta de ${store}.',
			'premium.terms' => 'Condiciones de uso',
			'premium.privacy' => 'Privacidad',
			'premium.activeTitle' => 'Tienes Premium',
			'premium.activeText' => '¡Gracias por apoyar CMFI Connect! El widget y el año de tu balance están abiertos.',
			'premium.staffText' => 'Tienes Premium gratis porque formas parte del equipo de CMFI Connect.',
			'premium.moreSubtitle' => 'Widget, objetivos del año',
			'premium.moreActive' => 'Activo',
			'premium.unlock' => 'Desbloquear con Premium',
			'premium.trialThen' => ({required Object trial, required Object price}) => '${trial}, luego ${price}',
			'premium.savePercent' => ({required Object percent}) => '−${percent}',
			'premium.choose' => 'Elige tu plan',
			'premium.cancelAnytime' => 'Sin compromiso, cancela cuando quieras',
			'premium.restoreShort' => 'Restaurar',
			'premium.termsShort' => 'Condiciones',
			'premium.semiannual' => 'Semestral',
			'premium.perSemester' => ({required Object price}) => '${price} / 6 meses',
			'premium.buyLifetime' => 'Comprar de por vida',
			'premium.lifetimeNote' => 'De por vida: un solo pago, sin suscripción ni renovación.',
			'premium.manage' => 'Gestionar mi suscripción',
			'premium.manageFailed' => 'La gestión de la suscripción no se abre. Inténtalo más tarde.',
			'premium.crown' => 'Miembro Premium',
			'homeWidget.title' => 'Hoy',
			'homeWidget.done' => 'Hecho',
			'homeWidget.todo' => 'Por rellenar',
			'homeWidget.open' => 'Rellenar',
			'homeWidget.locked' => 'Activa el widget con Premium',
			'homeWidget.signedOut' => 'Inicia sesión en la app',
			'ministry.title' => 'Nuestro ministerio',
			'ministry.tagline' => 'Hasta lo último de la tierra',
			'ministry.count' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, one: '${n} nación', other: '${n} naciones', ), 
			'ministry.fromYaounde' => 'Desde Yaundé, el Evangelio va de nación en nación.',
			'ministry.dragHint' => 'Gira el globo con el dedo, toca una nación.',
			'ministry.globeLabel' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, one: 'Globo: ${n} nación donde está presente la obra. La lista de abajo la indica.', other: 'Globo: ${n} naciones donde está presente la obra. La lista de abajo las indica todas.', ), 
			'ministry.voyage' => 'Viaje',
			'ministry.pause' => 'Pausa',
			'ministry.previous' => 'Nación anterior',
			'ministry.next' => 'Nación siguiente',
			'ministry.number' => ({required Object n}) => 'Nación n.º ${n}',
			'ministry.since' => ({required Object year}) => 'Desde ${year}',
			'ministry.pray' => 'Orar',
			'ministry.prayTitle' => ({required Object country}) => 'Orar por ${country}',
			'ministry.prayThanks' => ({required Object country}) => 'Da gracias por la obra de Dios en ${country}.',
			'ministry.prayAssemblies' => ({required Object country}) => 'Ora por las asambleas de ${country} y por sus responsables.',
			'ministry.prayUnreached' => ({required Object country}) => 'Ora para que quienes aún no han creído en ${country} encuentren a Jesús.',
			'ministry.purpose' => 'Nuestro propósito',
			'ministry.nations' => 'Las naciones',
			'ministry.search' => 'Buscar una nación',
			'ministry.none' => 'Ninguna nación coincide',
			'ministry.homeText' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, one: 'Presente en ${n} nación', other: 'Presente en ${n} naciones', ), 
			'ministry.nationsSubtitle' => 'El globo y el viaje de nación en nación',
			'ministry.purposeSubtitle' => 'Nuestros tres objetivos',
			'ministry.missionaries' => 'Nuestros misioneros',
			'ministry.missionariesSubtitle' => 'Los que el Señor envía a las naciones',
			'ministry.heroes' => 'Nuestros héroes',
			'ministry.heroesSubtitle' => 'Aquellos cuya fe nos inspira',
			'ministry.founder' => 'Nuestro fundador',
			'ministry.founderSubtitle' => 'El Prof. Zacharias Tanee Fomum',
			'ministry.leader' => 'Nuestro líder',
			'ministry.leaderSubtitle' => 'Theodore Andoseh',
			'ministry.missionariesEmpty' => 'Los retratos de nuestros misioneros llegarán pronto.',
			'ministry.heroesEmpty' => 'Los retratos de nuestros héroes llegarán pronto.',
			'ministry.personGone' => 'Este retrato ya no está disponible.',
			'ministry.photoOf' => ({required Object name}) => 'Foto de ${name}',
			'ministry.keyDates' => 'Fechas clave',
			'ministry.life' => 'Su vida',
			'ministry.story' => 'Su historia',
			'ministry.goalOf' => ({required Object n, required Object total}) => 'NUESTRO OBJETIVO · ${n}/${total}',
			'ministry.previousGoal' => 'Objetivo anterior',
			'ministry.nextGoal' => 'Siguiente objetivo',
			'ministry.media.books' => 'Libros',
			'ministry.media.tracts' => 'Tratados',
			'ministry.media.magazines' => 'Revistas',
			'ministry.media.cds' => 'CD',
			'ministry.media.dvds' => 'DVD',
			'ministry.media.radio' => 'Radio',
			'ministry.media.tv' => 'Televisión',
			'ministry.media.internet' => 'Internet',
			'ministry.goals.crusade.title' => 'La cruzada evangelística a toda criatura',
			'ministry.goals.crusade.text' => 'Predicar el evangelio a cada persona que viva en nuestra generación, de modo que 10 mil millones de personas sean alcanzadas con el evangelio predicado en el poder del Espíritu Santo, usando todos los medios de comunicación (nuestros libros, tratados, revistas, CD, DVD, nuestra radio, nuestra televisión e Internet) de la manera más urgente posible.',
			'ministry.goals.crusade.reached' => 'personas alcanzadas por el evangelio',
			'ministry.goals.disciples.title' => 'La formación de discípulos',
			'ministry.goals.disciples.text' => 'Llevar a 1000 millones de personas en 250 naciones a conocer a Jesucristo como Señor y Salvador, que sean hechas discípulos para obedecerle en todo y organizadas para reunirse en 25 millones de iglesias en casas de aquí al año 2065.',
			'ministry.goals.disciples.people' => 'discípulos',
			'ministry.goals.disciples.nations' => 'naciones',
			'ministry.goals.disciples.churches' => 'iglesias en casas',
			'ministry.goals.disciples.by' => ({required Object year}) => 'para ${year}',
			'ministry.goals.revival.title' => 'Precipitar el avivamiento global',
			'ministry.goals.revival.text' => 'Cooperar con Dios mediante el ayuno y la intercesión por el avivamiento mundial que rasgará los cielos, sacudirá la tierra y glorificará a Cristo en nuestra generación, para precipitar el inminente regreso de nuestro Señor Jesucristo desde el cielo al encuentro de su Esposa preparada.',
			'ministry.goals.revival.fasting' => 'Ayuno',
			'ministry.goals.revival.intercession' => 'Intercesión',
			'ministry.goals.revival.pray' => 'Orar ahora',
			'ministry.lives.founder.name' => 'Prof. Zacharias Tanee Fomum',
			'ministry.lives.founder.line' => '1945 – 2009 · Fundador de la CMCI',
			'ministry.lives.founder.facts.0' => 'fundación de la CMCI',
			'ministry.lives.founder.facts.1' => 'libros escritos',
			'ministry.lives.founder.facts.2' => 'naciones visitadas',
			'ministry.lives.founder.dates.0' => 'Nace el 20 de junio en Camerún, en una familia presbiteriana.',
			'ministry.lives.founder.dates.1' => 'Entrega su vida a Jesucristo el 13 de junio, al leer un tratado.',
			'ministry.lives.founder.dates.2' => 'Se entrega por completo al Señor el 1 de octubre, en Sierra Leona.',
			'ministry.lives.founder.dates.3' => 'Es lleno del Espíritu Santo el 24 de octubre, tras siete días de oración.',
			'ministry.lives.founder.dates.4' => 'Funda la CMCI en Yaundé el 12 de mayo.',
			'ministry.lives.founder.dates.5' => 'Recibe el doctorado en ciencias de la Universidad de Durham.',
			'ministry.lives.founder.dates.6' => 'Parte con el Señor el 14 de marzo.',
			'ministry.lives.founder.story.0' => 'Zacharias Tanee Fomum nació el 20 de junio de 1945 en Camerún, en una familia presbiteriana originaria de Batibo, en el noroeste del país. Siendo todavía escolar, entregó su vida a Jesucristo el 13 de junio de 1956, al leer un tratado titulado «Alguien murió por ti».',
			'ministry.lives.founder.story.1' => 'Siendo estudiante en el Fourah Bay College, en Sierra Leona, se entregó sin reservas al Señor y a su servicio el 1 de octubre de 1966. El 24 de octubre de 1970, al final de siete días de oración y ayuno, fue lleno del Espíritu Santo. Desde entonces, la oración fue el centro de su vida.',
			'ministry.lives.founder.story.2' => 'Doctor en química orgánica por la Universidad Makerere, en Uganda, enseñó en la Universidad de Yaundé, donde llegó a ser profesor. Dirigió un centenar de tesis y memorias, y en 2005 la Universidad de Durham, en Gran Bretaña, le otorgó un doctorado en ciencias por el conjunto de su obra.',
			'ministry.lives.founder.story.3' => 'El 12 de mayo de 1975, en Yaundé, fundó la Comunidad Misionera Cristiana Internacional: un movimiento para ganar almas, hacer discípulos, plantar iglesias y enviar misioneros. Hizo más de 700 viajes misioneros en Camerún y más de 500 a más de 70 naciones, en seis continentes.',
			'ministry.lives.founder.story.4' => 'Pasaba cada día largas horas a solas con Dios, dirigió muchas cruzadas, asedios y marchas de oración, y ayunó a menudo. Escribió más de 150 libros sobre la oración, el ayuno, la santidad, el discipulado y la misión, leídos en muchos idiomas.',
			'ministry.lives.founder.story.5' => 'Con su esposa, Prisca Zei Fomum, servidora de Dios entre los niños, tuvo siete hijos, todos comprometidos en la obra del Evangelio. Juntos vivían con sencillez para dar al Evangelio la mayor parte de sus ingresos.',
			'ministry.lives.founder.story.6' => 'Partió a la presencia del Señor el 14 de marzo de 2009 y fue sepultado en Yaundé el 21 de marzo. La obra que fundó continúa entre las naciones.',
			'ministry.lives.leader.name' => 'Theodore Andoseh',
			'ministry.lives.leader.line' => 'Líder de la CMCI desde 2009',
			'ministry.lives.leader.facts.0' => 'iglesias plantadas',
			'ministry.lives.leader.facts.1' => 'años en Nigeria',
			'ministry.lives.leader.facts.2' => 'al frente de la CMCI',
			'ministry.lives.leader.dates.0' => 'Entrega su vida a Jesucristo bajo la predicación del Prof. Fomum.',
			'ministry.lives.leader.dates.1' => 'Es consagrado obispo en Yaundé.',
			'ministry.lives.leader.dates.2' => 'Parte como misionero a Nigeria con su esposa, Adela.',
			'ministry.lives.leader.dates.3' => 'Asume la dirección de la CMCI.',
			'ministry.lives.leader.dates.4' => 'Trae los mensajes de la 3.ª Convención Mundial a miembros de 93 naciones.',
			'ministry.lives.leader.story.0' => 'Theodore Andoseh entregó su vida a Jesucristo en 1978, al escuchar predicar al Prof. Zacharias Tanee Fomum, que llegó a ser su padre espiritual y lo formó como discípulo.',
			'ministry.lives.leader.story.1' => 'Primero sirvió a su lado: como asistente de laboratorio en la Universidad de Yaundé, y luego como su asistente personal y secretario particular. En esos años publicó el primer tratado del avivamiento, «Dios habla al hombre que quiere oír», e inició la primera cadena de oración de Yaundé.',
			'ministry.lives.leader.story.2' => 'Como misionero nacional, plantó más de cincuenta iglesias en Camerún. Fue consagrado obispo en Yaundé en 1989.',
			'ministry.lives.leader.story.3' => 'En 1994 partió como misionero a Nigeria con su esposa, Adela. Allí sirvieron durante catorce años.',
			'ministry.lives.leader.story.4' => 'Desde 2009, cuando el Prof. Fomum partió con el Señor, dirige la CMCI entre las naciones. En diciembre de 2019, en Koume, cerca de Bertoua, trajo los mensajes de la tercera Convención Mundial a miembros llegados de 93 naciones. También es autor de varios libros sobre el servicio a Dios y la edificación de la Iglesia.',
			'prayer.moments.morning' => 'Mañana',
			'prayer.moments.noon' => 'Mediodía',
			'prayer.moments.evening' => 'Tarde',
			'prayer.moments.night' => 'Noche',
			'prayer.retreatOf.morning' => 'Retiro de la mañana',
			'prayer.retreatOf.noon' => 'Retiro del mediodía',
			'prayer.retreatOf.evening' => 'Retiro de la tarde',
			'prayer.retreatOf.night' => 'Retiro de la noche',
			'prayer.hero.now' => ({required Object retreat}) => '${retreat} · ahora',
			'prayer.hero.title' => '15 minutos\ncon el Señor',
			'prayer.hero.preview.morning' => 'Da gracias, consagra tu día, tu trabajo, tu familia…',
			'prayer.hero.preview.noon' => 'Tu asamblea, tus líderes, 5 personas de tu lista, las naciones…',
			'prayer.hero.preview.evening' => 'Tu vida de oración, tu ministerio, tus colaboradores…',
			'prayer.hero.preview.night' => 'Los enfermos, el Evangelio en las naciones, la protección durante la noche…',
			'prayer.hero.meta' => '15 puntos · 1 min cada uno',
			'prayer.hero.start' => 'Empezar',
			'prayer.hero.allDone' => 'Hiciste los 4 retiros del día. ¡Que Dios conteste tus oraciones!',
			'prayer.hero.doneNow' => ({required Object retreat, required Object next}) => '${retreat} hecho. Siguiente: ${next}',
			'prayer.today.toPray' => 'Por orar',
			'prayer.today.week' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, zero: 'Ningún retiro esta semana', one: '${n} retiro esta semana', other: '${n} retiros esta semana', ), 
			'prayer.routine.title' => 'Tu rutina del día',
			'prayer.routine.count' => ({required Object done}) => '${done} de 4',
			'prayer.routine.days' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, one: '${n} día de 7', other: '${n} días de 7', ), 
			'prayer.routine.week' => ({required Object time}) => '${time} esta semana',
			'prayer.routine.done' => 'Hecha · 15 min',
			'prayer.routine.now' => 'Ahora · 15 min',
			'prayer.routine.next' => 'A continuación · 15 min',
			'prayer.routine.reminder' => ({required Object time}) => 'Recordatorio a las ${time}',
			'prayer.routine.later.morning' => 'Por la mañana · 15 min',
			'prayer.routine.later.noon' => 'Al mediodía · 15 min',
			'prayer.routine.later.evening' => 'Por la tarde · 15 min',
			'prayer.routine.later.night' => 'Por la noche · 15 min',
			'prayer.together' => 'Orar juntos',
			'prayer.reminders.title' => 'Recordatorios de los retiros',
			'prayer.reminders.intro' => 'Un recordatorio a la hora de cada retiro, solo si aún no lo has hecho.',
			'prayer.reminders.off' => 'Desactivado',
			'prayer.reminders.channel' => 'Retiros de oración',
			'prayer.reminders.body' => '15 minutos con el Señor.',
			'prayer.retreat.title' => 'Retiros de 15 minutos',
			'prayer.retreat.hours.morning' => 'Al despertar',
			'prayer.retreat.hours.noon' => 'Entre las 12:00 y las 14:00',
			'prayer.retreat.hours.evening' => 'Al final de la tarde',
			'prayer.retreat.hours.night' => 'Antes de dormir',
			'prayer.retreat.reminderAt' => ({required Object time}) => 'recordatorio a las ${time}',
			'prayer.retreat.intro' => '15 puntos, un minuto cada uno. Un sonido suave te lleva al siguiente.',
			'prayer.retreat.done' => 'Hecho hoy',
			'prayer.retreat.start' => 'Empezar · 15 min',
			'prayer.retreat.selfPaced' => 'Leer a mi ritmo, sin temporizador',
			'prayer.retreat.hints.assembly' => ({required Object name}) => 'Tu asamblea: ${name}',
			'prayer.retreat.hints.assemblyMissing' => 'Añade tu asamblea en tu perfil',
			'prayer.retreat.hints.authorities' => ({required Object names}) => 'Tus autoridades: ${names}',
			_ => null,
		} ?? switch (path) {
			'prayer.retreat.hints.authoritiesMissing' => 'Añade tus autoridades espirituales en «Más»',
			'prayer.retreat.hints.list' => ({required Object list}) => 'Mis listas · ${list}',
			'prayer.retreat.hints.listEmpty' => ({required Object list}) => 'Tu lista «${list}» está vacía: añade nombres',
			'prayer.retreat.hints.nation' => ({required Object name}) => 'Hoy: ${name}',
			'prayer.retreat.hints.myCountry' => ({required Object name}) => 'Tu país: ${name}',
			'prayer.retreat.hints.hymn' => 'Abrir los himnos',
			'prayer.session.point' => ({required Object n}) => 'Punto ${n} de 15',
			'prayer.session.remaining' => 'restantes',
			'prayer.session.paused' => 'en pausa',
			'prayer.session.inYourList' => ({required Object list}) => 'En tu lista · ${list}',
			'prayer.session.tomorrow' => 'Mañana, los siguientes.',
			'prayer.session.footer' => 'Pantalla encendida · un sonido suave cada minuto',
			'prayer.session.previous' => 'Punto anterior',
			'prayer.session.next' => 'Punto siguiente',
			'prayer.session.pause' => 'Pausa',
			'prayer.session.resume' => 'Reanudar',
			'prayer.session.soundOn' => 'Sonido activado',
			'prayer.session.soundOff' => 'Sonido desactivado',
			'prayer.session.finish' => 'Terminar el retiro',
			'prayer.session.quitTitle' => '¿Detener el retiro?',
			'prayer.session.quitText' => 'No se contará en tu día.',
			'prayer.session.quit' => 'Detener',
			'prayer.session.keepPraying' => 'Seguir orando',
			'prayer.session.voiceOff' => 'Leer en voz alta',
			'prayer.session.voiceOn' => 'Lectura en voz alta activada',
			'prayer.done.title' => ({required Object retreat}) => '${retreat} terminado',
			'prayer.done.text' => '15 minutos con el Señor.\nÉl escuchó cada una de tus oraciones.',
			'prayer.done.report' => 'Añadido a tu informe',
			'prayer.done.reportDetail' => ({required Object added, required Object total}) => 'Oración a solas: +${added} min · ${total} min hoy',
			'prayer.done.undo' => 'Deshacer',
			'prayer.done.undone' => 'Retiro quitado de tu día.',
			'prayer.done.today' => 'Hoy',
			'prayer.done.count' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, one: '${n} retiro de 4', other: '${n} retiros de 4', ), 
			'prayer.done.verse' => '«Orad sin cesar.»',
			'prayer.done.reference' => '1 Tesalonicenses 5:17',
			'prayer.done.finish' => 'Terminar',
			'prayer.done.hymn' => 'Cantar un himno',
			'prayer.topics.title' => 'Motivos de la comunidad',
			'prayer.topics.all' => 'Ver todo',
			'prayer.topics.empty' => 'No hay motivos por ahora. Los líderes publicarán los próximos aquí.',
			'prayer.topics.categories.church' => 'Iglesia',
			'prayer.topics.categories.nations' => 'Naciones',
			'prayer.topics.categories.sick' => 'Enfermos',
			'prayer.topics.categories.event' => 'Evento',
			'prayer.topics.categories.fasting' => 'Ayuno',
			'prayer.topics.categories.other' => 'Motivo',
			'prayer.topics.until' => ({required Object date}) => 'hasta el ${date}',
			'prayer.topics.archive' => 'Motivos anteriores',
			'prayer.topics.archiveEmpty' => 'No hay motivos anteriores.',
			'prayer.topics.current' => 'En este momento',
			'prayer.topics.documentSize' => ({required Object kb}) => '${kb} KB',
			'prayer.topics.download' => 'Descargar el PDF',
			'prayer.topics.noDocument' => 'Sin PDF',
			'prayer.topics.openDocument' => 'Abrir el PDF',
			'prayer.lists.title' => 'Mis listas de oración',
			'prayer.lists.private' => 'Solo para ti',
			'prayer.lists.names.unbelievers' => 'Aún no creyentes',
			'prayer.lists.names.believers' => 'Creyentes',
			'prayer.lists.names.backsliders' => 'Descarriados',
			'prayer.lists.names.coworkers' => 'Colaboradores',
			'prayer.lists.uses.unbelievers' => 'En el retiro del mediodía oras cada día por 10 personas de esta lista (5 + 5), por turnos.',
			'prayer.lists.uses.believers' => 'En el retiro del mediodía oras cada día por 5 personas de esta lista, por turnos.',
			'prayer.lists.uses.backsliders' => 'En el retiro del mediodía oras cada día por 5 personas de esta lista, por turnos.',
			'prayer.lists.uses.coworkers' => 'En el retiro de la tarde oras cada día por 10 de tus colaboradores (5 + 5), por turnos.',
			'prayer.lists.privateNote' => 'Solo tú puedes verla.',
			'prayer.lists.count' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, zero: 'Nadie', one: '${n} persona', other: '${n} personas', ), 
			'prayer.lists.empty' => 'Nadie por ahora. Añade a las personas por las que oras.',
			'prayer.lists.add' => 'Añadir una persona',
			'prayer.lists.prayedToday' => 'Hoy',
			'prayer.lists.next' => 'Próximamente',
			'prayer.lists.answeredTitle.unbelievers' => 'Creyeron en el Señor',
			'prayer.lists.answeredTitle.believers' => 'Oraciones contestadas',
			'prayer.lists.answeredTitle.backsliders' => 'Volvieron al Señor',
			'prayer.lists.answeredTitle.coworkers' => 'Oraciones contestadas',
			'prayer.lists.answeredOn.unbelievers' => ({required Object date}) => 'Creyó en el Señor el ${date}',
			'prayer.lists.answeredOn.believers' => ({required Object date}) => 'Contestada el ${date}',
			'prayer.lists.answeredOn.backsliders' => ({required Object date}) => 'Volvió el ${date}',
			'prayer.lists.answeredOn.coworkers' => ({required Object date}) => 'Contestada el ${date}',
			'prayer.lists.markAnswered.unbelievers' => '¡Creyó en el Señor!',
			'prayer.lists.markAnswered.believers' => 'Oración contestada',
			'prayer.lists.markAnswered.backsliders' => '¡Volvió al Señor!',
			'prayer.lists.markAnswered.coworkers' => 'Oración contestada',
			'prayer.lists.answeredToast' => '¡Gloria a Dios!',
			'prayer.lists.putBack' => 'Devolver a la lista',
			'prayer.lists.answeredBanner' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, one: '${n} oración contestada este mes', other: '${n} oraciones contestadas este mes', ), 
			'prayer.lists.lastAnswered' => ({required Object name, required Object what}) => '${name}: ${what}',
			'prayer.lists.sheet.addTitle' => 'Añadir una persona',
			'prayer.lists.sheet.editTitle' => 'Editar',
			'prayer.lists.sheet.name' => 'Nombre',
			'prayer.lists.sheet.namePlaceholder' => 'Pablo M.',
			'prayer.lists.sheet.note' => 'Nota',
			'prayer.lists.sheet.notePlaceholder' => 'Colega, vecino, prima…',
			'prayer.lists.sheet.list' => 'Lista',
			'prayer.lists.sheet.save' => 'Guardar',
			'prayer.lists.sheet.remove' => 'Quitar de la lista',
			'prayer.lists.sheet.removeTitle' => ({required Object name}) => '¿Quitar a ${name}?',
			'prayer.lists.sheet.removeText' => 'Ya no orarás por esta persona en tus retiros.',
			'prayer.lists.addShort' => 'Añadir',
			'prayer.importunity.title' => 'Motivos de importunidad',
			'prayer.importunity.newTopic' => 'Nuevo motivo',
			'prayer.importunity.intro' => 'Un motivo que se presenta al Señor sin cansarse, hasta recibir la respuesta. Fija un número de proclamaciones e invita a tus hermanos y hermanas a orar contigo.',
			'prayer.importunity.invitedBy' => ({required Object name}) => '${name} te invita a orar',
			'prayer.importunity.join' => 'Me uno a la oración',
			'prayer.importunity.decline' => 'Ahora no',
			'prayer.importunity.joined' => 'Ahora oras por este motivo.',
			'prayer.importunity.progress' => ({required Object total, required Object goal}) => '${total} de ${goal}',
			'prayer.importunity.total' => ({required num n, required Object count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, one: '${count} proclamación', other: '${count} proclamaciones', ), 
			'prayer.importunity.reached' => '¡Objetivo alcanzado!',
			'prayer.importunity.closed' => 'Cerrado',
			'prayer.importunity.participants' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, one: '${n} ora', other: '${n} oran', ), 
			'prayer.importunity.mine' => ({required Object n}) => 'Tú: ${n}',
			'prayer.importunity.tapHint' => 'Toca en cada proclamación',
			'prayer.importunity.addMany' => 'Añadir una cantidad',
			'prayer.importunity.addManyTitle' => '¿Cuántas proclamaciones?',
			'prayer.importunity.addManyLabel' => 'Proclamaciones',
			'prayer.importunity.add' => 'Añadir',
			'prayer.importunity.pending' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, one: '${n} pendiente de envío', other: '${n} pendientes de envío', ), 
			'prayer.importunity.invite' => 'Invitar',
			'prayer.importunity.members' => 'Quienes oran',
			'prayer.importunity.waiting' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, one: '${n} invitación pendiente', other: '${n} invitaciones pendientes', ), 
			'prayer.importunity.edit' => 'Editar',
			'prayer.importunity.close' => 'Cerrar el motivo',
			'prayer.importunity.reopen' => 'Reabrir el motivo',
			'prayer.importunity.delete' => 'Eliminar el motivo',
			'prayer.importunity.deleteTitle' => '¿Eliminar este motivo?',
			'prayer.importunity.deleteText' => 'Desaparecerá para todos los que oran contigo.',
			'prayer.importunity.leave' => 'Dejar este motivo',
			'prayer.importunity.leaveTitle' => '¿Dejar este motivo?',
			'prayer.importunity.leaveText' => 'Tus proclamaciones se quedan en el total.',
			'prayer.importunity.form.newTitle' => 'Nuevo motivo de importunidad',
			'prayer.importunity.form.editTitle' => 'Editar el motivo',
			'prayer.importunity.form.subject' => 'Motivo',
			'prayer.importunity.form.subjectPlaceholder' => 'Señor, salva a Pablo',
			'prayer.importunity.form.description' => 'Detalles',
			'prayer.importunity.form.descriptionPlaceholder' => 'Por quién, por qué…',
			'prayer.importunity.form.goal' => 'Objetivo',
			'prayer.importunity.form.goalHint' => 'El número de proclamaciones por alcanzar juntos. Déjalo vacío para contar sin objetivo.',
			'prayer.importunity.form.goalPlaceholder' => '10.000',
			'prayer.importunity.form.create' => 'Crear',
			'prayer.importunity.form.save' => 'Guardar',
			'prayer.importunity.inviteSheet.title' => 'Invitar a orar',
			'prayer.importunity.inviteSheet.family' => 'Mi familia espiritual',
			'prayer.importunity.inviteSheet.familyText' => ({required num n, required Object name}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, one: '${name} y sus discípulos: ${n} persona', other: '${name} y sus discípulos: ${n} personas', ), 
			'prayer.importunity.inviteSheet.familyMissing' => 'Vincula a tu discipulador en «Mis autoridades espirituales» para invitar a tu familia espiritual.',
			'prayer.importunity.inviteSheet.byUsername' => 'Por nombre de usuario',
			'prayer.importunity.inviteSheet.usernameLabel' => 'Nombre de usuario',
			'prayer.importunity.inviteSheet.addUsername' => 'Añadir',
			'prayer.importunity.inviteSheet.send' => 'Enviar las invitaciones',
			'prayer.importunity.inviteSheet.sent' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, zero: 'Ya estaban invitados.', one: '${n} invitación enviada', other: '${n} invitaciones enviadas', ), 
			'prayer.importunity.eyebrow' => 'Tema de importunidad',
			'prayer.importunity.proclaim' => 'Proclamar',
			'prayer.importunity.timer' => 'Cronometrar mi oración',
			'prayer.importunity.timeLabel' => 'Tiempo de oración por este motivo',
			'prayer.importunity.mineTime' => ({required Object n, required Object time}) => 'Tú: ${n} · ${time} de oración',
			'prayer.importunity.timerNote' => 'El tiempo se suma a «Oración personal» en tu informe.',
			'prayer.free.title' => 'Orar libremente',
			'prayer.free.text' => 'Sin retiro: tu tiempo cuenta en «Oración personal».',
			'prayer.free.start' => 'Cronometrar',
			'prayer.free.running' => 'Oración personal en curso',
			'sending.title' => 'Envío a mis autoridades',
			'sending.moreOff' => 'Desactivado',
			'sending.intro' => 'En el momento elegido, CMFI Connect prepara tu informe del período. Solo tienes que enviarlo a tus autoridades espirituales.',
			'sending.enabled' => 'Prepararlo regularmente',
			'sending.rhythm' => 'Ritmo',
			'sending.weekly' => 'Cada semana',
			'sending.biweekly' => 'Cada 2 semanas',
			'sending.monthly' => 'Cada mes',
			'sending.day' => 'Día',
			'sending.monthlyDay' => 'El día 1 de cada mes, para el mes anterior',
			'sending.time' => 'Hora',
			'sending.recipients' => 'Destinatarios',
			'sending.noAuthorities' => 'Primero añade tus autoridades espirituales.',
			'sending.addAuthorities' => 'Añadir mis autoridades',
			'sending.viaWhatsApp' => 'Por WhatsApp',
			'sending.viaEmail' => 'Por e-mail',
			'sending.viaBoth' => 'Por WhatsApp o e-mail',
			'sending.viaShare' => 'Compartiendo',
			'sending.next' => ({required Object date}) => 'Próximo: ${date}',
			'sending.prepareNow' => 'Preparar ahora',
			'sending.history' => 'Últimos envíos',
			'sending.notificationTitle' => 'Tu informe está listo',
			'sending.notificationBody' => 'Envíalo a tus autoridades con un toque.',
			'sending.channel' => 'Envío del informe',
			'sending.readyTitle' => 'Tu informe está listo',
			'sending.preview' => 'Vista previa del mensaje',
			'sending.greeting' => ({required Object name}) => 'Hola ${name},',
			'sending.whatsApp' => 'WhatsApp',
			'sending.email' => 'E-mail',
			'sending.sharePdf' => 'Compartir el PDF',
			'sending.shareText' => 'Compartir el texto',
			'sending.sent' => 'Enviado',
			'sending.shared' => 'Compartido',
			'sending.noRecipients' => 'Elige tus destinatarios en los ajustes, o comparte el PDF.',
			'sending.settings' => 'Ajustes',
			'sending.permissionDenied' => 'Permite las notificaciones para recibir el aviso a tiempo.',
			'sending.inApp' => 'Enviar en la app',
			'sending.viaApp' => 'En la app',
			'sending.inAppSent' => ({required Object name}) => 'Enviado a ${name} en la app',
			'sending.inAppUnavailable' => ({required Object name}) => '${name} no puede recibirlo en la app por ahora.',
			'sending.inAppHistory' => 'Enviados en la app',
			'sending.replied' => 'Respondido',
			'sending.seen' => 'Leído',
			'sending.formerAuthority' => 'Antigua autoridad',
			'sending.theirReply' => ({required Object text}) => '«${text}»',
			'streak.title' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, one: '¡${n} día seguido!', other: '¡${n} días seguidos!', ), 
			'streak.cardDays' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, one: 'día con Dios', other: 'días con Dios', ), 
			'streak.lines.week' => 'Una semana entera con el Señor, día tras día. ¡Bravo, sigue así!',
			'streak.lines.month' => '¡Un mes de fidelidad! Lo que siembras cada día da fruto.',
			'streak.lines.hundred' => '¡Cien días con Dios! Tu perseverancia es un hermoso testimonio.',
			'streak.lines.year' => '¡Un año entero con Dios! Gloria a Él por tu fidelidad.',
			'streak.share' => 'Compartir',
			'streak.close' => 'Continuar',
			'shortcuts.today' => 'Llenar mi informe',
			'shortcuts.hymns' => 'Himnos',
			'shortcuts.retreat' => 'Retiro del momento',
			'blocking.report' => 'Reportar',
			'blocking.block' => ({required Object name}) => 'Bloquear a ${name}',
			'blocking.blockTitle' => ({required Object name}) => '¿Bloquear a ${name}?',
			'blocking.blockText' => ({required Object name}) => 'Ya no recibirás invitaciones de ${name}. Esta invitación se retira.',
			'blocking.blockAction' => 'Bloquear',
			'blocking.blocked' => ({required Object name}) => '${name} ya no podrá invitarte.',
			'blocking.reportTitle' => 'Reportar esta invitación',
			'blocking.reportText' => 'Dinos qué pasa: los responsables de la comunidad lo revisarán.',
			'blocking.reasons.spam' => 'No deseado',
			'blocking.reasons.offensive' => 'Contenido chocante u ofensivo',
			'blocking.reasons.other' => 'Otro',
			'blocking.comment' => 'Comentario',
			'blocking.commentHint' => 'Lo que los responsables deben saber',
			'blocking.send' => 'Enviar el reporte',
			'blocking.reported' => 'Gracias, los responsables lo revisarán.',
			'blocking.listTitle' => 'Miembros bloqueados',
			'blocking.intro' => 'Sus invitaciones a orar ya no te llegan.',
			'blocking.empty' => 'No has bloqueado a nadie.',
			'blocking.unblock' => 'Desbloquear',
			'blocking.unblocked' => ({required Object name}) => '${name} puede volver a invitarte.',
			'verses.title' => 'Versículo del día',
			'verses.share' => 'Compartir el versículo',
			'verses.shareImage' => 'Compartir la imagen',
			'verses.shareText' => 'Compartir el texto',
			'bible.title' => 'Biblia',
			'bible.books' => 'Libros',
			'bible.oldTestament' => 'Antiguo Testamento',
			'bible.newTestament' => 'Nuevo Testamento',
			'bible.chapters' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, one: '${n} capítulo', other: '${n} capítulos', ), 
			'bible.chapter' => ({required Object n}) => 'Capítulo ${n}',
			'bible.version' => 'Versión',
			'bible.versions' => 'Versión de la Biblia',
			'bible.search' => 'Buscar en la Biblia',
			'bible.searchHint' => 'Una palabra, o «Juan 3:16»',
			'bible.searchTip' => 'Busca una palabra («amor») o ve directamente a un pasaje («Salmos 23», «Juan 3:16»).',
			'bible.searchNone' => 'Ningún versículo contiene estas palabras.',
			'bible.searchCount' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, one: '${n} versículo', other: '${n} versículos', ), 
			'bible.searchLimit' => ({required Object n}) => 'Los primeros ${n} versículos',
			'bible.searchNeedsDownload' => 'Para buscar palabras en toda la Biblia, descárgala. Ya puedes escribir un pasaje: «Juan 3:16».',
			'bible.open' => ({required Object reference}) => 'Abrir ${reference}',
			'bible.previous' => 'Capítulo anterior',
			'bible.next' => 'Capítulo siguiente',
			'bible.markRead' => 'He leído este capítulo',
			'bible.markedRead' => 'Leído hoy',
			'bible.markReadHint' => 'Añade 1 capítulo a «Lectura bíblica» en tu informe.',
			'bible.addedToReport' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, one: 'Informe: ${n} capítulo leído hoy', other: 'Informe: ${n} capítulos leídos hoy', ), 
			'bible.removedFromReport' => 'Quitado de tu informe',
			'bible.noReadingItem' => 'Tu informe no tiene el elemento «Lectura bíblica».',
			'bible.download' => 'Descargar esta Biblia',
			'bible.downloadHelp' => ({required Object size}) => 'Unos ${size} MB, para leer y buscar sin conexión.',
			'bible.downloading' => ({required Object percent}) => 'Descargando… ${percent} %',
			'bible.downloaded' => 'En tu teléfono',
			'bible.downloadDone' => ({required Object version}) => '${version} está en tu teléfono',
			'bible.removeDownload' => 'Quitar del teléfono',
			'bible.removeDownloadTitle' => ({required Object version}) => '¿Quitar ${version} del teléfono?',
			'bible.removeDownloadText' => 'Los capítulos que ya leíste siguen disponibles sin conexión.',
			'bible.offline' => 'Este capítulo aún no está en tu teléfono. Vuelve a conectarte, o descarga esta Biblia para leerla sin conexión.',
			'bible.notInVersion' => 'Este pasaje no está en esta versión.',
			'bible.marks' => 'Mis versículos',
			'bible.favorites' => 'Guardados',
			'bible.highlights' => 'Resaltados',
			'bible.noFavorites' => 'Toca un versículo y luego el marcador para encontrarlo aquí.',
			'bible.noHighlights' => 'Toca un versículo y luego un color para resaltarlo.',
			'bible.tapHint' => 'Toca un versículo para resaltarlo, guardarlo, copiarlo o compartirlo.',
			'bible.highlight' => ({required Object color}) => 'Resaltar en ${color}',
			'bible.colors.yellow' => 'amarillo',
			'bible.colors.green' => 'verde',
			'bible.colors.blue' => 'azul',
			'bible.colors.pink' => 'rosa',
			'bible.removeHighlight' => 'Quitar el color',
			'bible.addFavorite' => 'Guardar en Mis versículos',
			'bible.removeFavorite' => 'Quitar de Mis versículos',
			'bible.favoriteAdded' => 'Guardado en Mis versículos',
			'bible.favoriteRemoved' => 'Quitado de Mis versículos',
			'bible.copy' => 'Copiar',
			'bible.copied' => 'Copiado',
			'bible.share' => 'Compartir',
			'bible.closeSelection' => 'Cerrar la selección',
			'bible.display' => 'Visualización',
			'bible.jesusInRed' => 'Palabras de Jesús en rojo',
			'bible.jesusInRedHelp' => 'En las versiones que las indican',
			'bible.remove' => 'Quitar',
			'bible.readInBible' => 'Leer en la Biblia',
			'bible.concordance' => 'Concordancia',
			'bible.concordanceOf' => ({required Object word}) => 'Concordancia de «${word}»',
			'bible.concordanceHint' => 'Una palabra de la Biblia',
			'bible.concordanceTip' => 'Escribe una palabra: la concordancia muestra todos los versículos donde aparece, libro por libro.',
			'bible.concordanceNeedsDownload' => 'La concordancia recorre toda la Biblia: descárgala primero.',
			'bible.concordanceNone' => 'Esta palabra no está en esta Biblia.',
			'bible.exactWord' => 'Esta palabra',
			'bible.startsWith' => 'Empieza por…',
			'bible.occurrences' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, one: 'vez', other: 'veces', ), 
			'bible.inVerses' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, one: 'en ${n} versículo', other: 'en ${n} versículos', ), 
			'bible.spread' => 'Dónde aparece esta palabra',
			'bible.forms' => 'Formas encontradas',
			'bible.bookCount' => ({required Object book, required Object n}) => '${book}: ${n}',
			'bible.allBooks' => 'Todos los libros',
			'bible.pickWord' => 'Elige una palabra',
			'bible.pickWordHelp' => 'La concordancia muestra todos los versículos donde aparece.',
			'bible.more' => 'Más opciones',
			'bible.crossReferences' => 'Referencias cruzadas',
			'bible.crossReferencesOf' => ({required Object passage}) => 'Referencias cruzadas · ${passage}',
			'bible.noCrossReferences' => 'Ninguna referencia cruzada para este pasaje.',
			'bible.crossReferencesSource' => 'Fuente: OpenBible.info (CC-BY)',
			'bible.readOn' => ({required Object site}) => 'Se lee en ${site} (texto protegido)',
			'bible.listen' => 'Escuchar este capítulo',
			'bible.listeningAt' => ({required Object place, required Object verse}) => '${place} · versículo ${verse}',
			'bible.stopListening' => 'Detener la lectura',
			'profilePhoto.title' => 'Foto de perfil',
			'profilePhoto.add' => 'Añadir una foto de perfil',
			'profilePhoto.change' => 'Cambiar la foto de perfil',
			'profilePhoto.seenBy' => 'Los demás miembros la ven allí donde aparece tu nombre.',
			'profilePhoto.camera' => 'Hacer una foto',
			'profilePhoto.gallery' => 'Elegir de la galería',
			'profilePhoto.remove' => 'Quitar la foto',
			'profilePhoto.cropTitle' => 'Recorta tu foto',
			'profilePhoto.cropHint' => 'Mueve y amplía la foto con los dedos.',
			'profilePhoto.use' => 'Usar esta foto',
			'profilePhoto.unreadable' => 'No se puede abrir esta imagen. Elige otra.',
			'profilePhoto.saved' => 'Tu foto de perfil está guardada.',
			'profilePhoto.removed' => 'Tu foto de perfil se ha quitado.',
			'disciples.title' => 'Mis discípulos',
			'disciples.empty' => 'Aún no hay discípulos',
			'disciples.emptyText' => 'Cuando un miembro te elige como hacedor de discípulos o como autoridad y aceptas su solicitud, aparece aquí.',
			'disciples.count' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, one: '${n} discípulo', other: '${n} discípulos', ), 
			'disciples.notShared' => 'No comparte sus informes',
			'disciples.roleMaker' => 'Eres su hacedor de discípulos',
			'disciples.roleAuthority' => 'Eres una de sus autoridades',
			'disciples.dayGoals' => ({required Object percent}) => 'Objetivos ${percent} %',
			'disciples.dayItems' => ({required Object filled, required Object total, required Object percent}) => '${filled} de ${total} elementos · ${percent} %',
			'disciples.older' => 'Ver los 30 días anteriores',
			'disciples.noReports' => 'Ningún informe en este periodo.',
			'disciples.searchHint' => 'Nombre o usuario',
			'disciples.noMatch' => ({required Object search}) => 'Ningún discípulo coincide con «${search}».',
			'weekStory.title' => 'Tu semana con Dios',
			'weekStory.range' => ({required Object from, required Object to}) => 'Del ${from} al ${to}',
			'weekStory.intro' => 'Repasa lo que viviste con el Señor esta semana.',
			'weekStory.tapHint' => 'Toca a la derecha para avanzar, a la izquierda para volver.',
			'weekStory.faithfulLead' => 'Fuiste fiel',
			'weekStory.emptyLead' => 'Una nueva semana te espera',
			'weekStory.days' => ({required num n, required Object total}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, one: '${n} día\nde ${total}', other: '${n} días\nde ${total}', ), 
			'weekStory.streak' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, one: '${n} día seguido', other: '${n} días seguidos', ), 
			'weekStory.streakRecord' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, one: '${n} día seguido: ¡tu récord!', other: '${n} días seguidos: ¡tu récord!', ), 
			'weekStory.emptyText' => 'Llena tu informe cada día: tu próxima semana se escribirá aquí.',
			'weekStory.prayerLead' => 'Oraste',
			'weekStory.retreats' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, one: '${n} retiro', other: '${n} retiros', ), 
			'weekStory.retreatsTime' => ({required Object time}) => 'de 15 minutos · ${time} con el Señor',
			'weekStory.faithfulMoment' => ({required num n, required Object moment}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, one: 'Tu momento más fiel: ${moment} (${n} vez)', other: 'Tu momento más fiel: ${moment} (${n} veces)', ), 
			'weekStory.noRetreat' => 'Ningún retiro esta semana',
			'weekStory.noRetreatText' => 'El retiro del mediodía te espera: 15 minutos con el Señor.',
			'weekStory.goalsLead' => 'Tus objetivos',
			'weekStory.goalsReached' => 'alcanzados en promedio',
			'weekStory.bestDay' => ({required Object day, required Object percent}) => 'Tu mejor día: ${day} · ${percent}',
			'weekStory.summaryTitle' => 'Mi semana con Dios',
			'weekStory.statDays' => 'días llenados',
			'weekStory.statStreak' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, one: 'día seguido', other: 'días seguidos', ), 
			'weekStory.statRetreats' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, one: 'retiro', other: 'retiros', ), 
			'weekStory.statGoals' => 'de objetivos',
			'weekStory.share' => 'Compartir mi semana',
			'weekStory.homeText' => 'Tu fidelidad, tu oración y tus objetivos de la semana.',
			'weekStory.open' => 'Ver mi semana',
			'weekStory.notificationTitle' => 'Tu semana con Dios está lista',
			'weekStory.notificationBody' => 'Repasa tu fidelidad de la semana y compártela.',
			'weekStory.channel' => 'Tu semana con Dios',
			'weekStory.thisWeek' => 'Esta semana',
			'weekStory.pastWeeks' => 'Semanas pasadas',
			'weekStory.weekOf' => ({required Object date}) => 'Semana del ${date}',
			'weekStory.page' => ({required Object current, required Object total}) => '${current} de ${total}',
			'yearStory.title' => 'Tu año con Dios',
			'yearStory.since' => ({required Object date}) => 'Desde el ${date}',
			'yearStory.intro' => 'Repasa todo lo que viviste con el Señor este año.',
			'yearStory.tapHint' => 'Toca a la derecha para avanzar, a la izquierda para volver.',
			'yearStory.page' => ({required Object current, required Object total}) => '${current} de ${total}',
			'yearStory.faithfulLead' => 'Fuiste fiel',
			'yearStory.days' => ({required num n, required Object total}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, one: '${n} día\nde ${total}', other: '${n} días\nde ${total}', ), 
			'yearStory.bestStreak' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, one: 'Tu racha más larga: ${n} día', other: 'Tu racha más larga: ${n} días seguidos', ), 
			'yearStory.faithfulMonth' => ({required num n, required Object month}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, one: 'Tu mes más fiel: ${month} (${n} día)', other: 'Tu mes más fiel: ${month} (${n} días)', ), 
			'yearStory.prayerLead' => 'Oraste',
			'yearStory.retreats' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, one: '${n} retiro', other: '${n} retiros', ), 
			'yearStory.retreatsTime' => ({required Object time}) => 'de 15 minutos · ${time} con el Señor',
			'yearStory.prayerAlone' => ({required Object time}) => '${time} de oración personal',
			'yearStory.prayerAloneText' => 'de oración personal con el Señor',
			'yearStory.faithfulMoment' => ({required num n, required Object moment}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, one: 'Tu momento más fiel: ${moment} (${n} vez)', other: 'Tu momento más fiel: ${moment} (${n} veces)', ), 
			'yearStory.wordLead' => 'Leíste la Palabra',
			'yearStory.memoryLead' => 'Guardaste la Palabra en tu corazón',
			'yearStory.chapters' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, one: '${n} capítulo', other: '${n} capítulos', ), 
			'yearStory.bibleShare' => ({required Object percent}) => '${percent} de la Biblia',
			'yearStory.wholeBible' => '¡El equivalente a toda la Biblia!',
			'yearStory.versesKnown' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, one: 'versículo aprendido de memoria', other: 'versículos aprendidos de memoria', ), 
			'yearStory.versesLearning' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, one: 'versículo en memorización', other: 'versículos en memorización', ), 
			'yearStory.fastLead' => 'Ayunaste',
			'yearStory.fastDays' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, one: '${n} día', other: '${n} días', ), 
			'yearStory.fastText' => 'de ayuno delante del Señor',
			'yearStory.fullFasts' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, one: 'día de ayuno completo', other: 'días de ayuno completo', ), 
			'yearStory.partialFasts' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, one: 'día de ayuno parcial', other: 'días de ayuno parcial', ), 
			'yearStory.goalsLead' => 'Tus objetivos',
			'yearStory.goalsReached' => 'alcanzados en promedio',
			'yearStory.bestMonth' => ({required Object month, required Object percent}) => 'Tu mejor mes: ${month} · ${percent}',
			'yearStory.summaryTitle' => 'Mi año con Dios',
			'yearStory.statDays' => 'días llenados',
			'yearStory.statStreak' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, one: 'día seguido, tu récord', other: 'días seguidos, tu récord', ), 
			'yearStory.statRetreats' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, one: 'retiro', other: 'retiros', ), 
			'yearStory.statPrayer' => 'de oración personal',
			'yearStory.statChapters' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, one: 'capítulo leído', other: 'capítulos leídos', ), 
			'yearStory.statFasts' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, one: 'día de ayuno', other: 'días de ayuno', ), 
			'yearStory.statGoals' => 'de objetivos',
			'yearStory.emptyText' => 'Llena tu informe cada día: tu año se escribirá aquí.',
			'yearStory.share' => 'Compartir mi año',
			'yearStory.homeText' => ({required Object year}) => 'Tu fidelidad, tu oración, la Palabra: repasa todo lo que viviste con Dios en ${year}.',
			'yearStory.open' => 'Ver mi año',
			'yearStory.notificationTitle' => 'Tu año con Dios está listo',
			'yearStory.notificationBody' => ({required Object year}) => 'Repasa todo lo que viviste con el Señor en ${year} y compártelo.',
			'yearStory.channel' => 'Tu año con Dios',
			'yearStory.moreTitle' => 'Mi año con Dios',
			'yearStory.moreSoFar' => ({required Object year}) => '${year} hasta ahora',
			'yearStory.moreDone' => ({required Object year}) => 'Todo el año ${year}',
			'seekFirst.title' => 'Busca primero a Dios',
			'seekFirst.verse' => 'Mas buscad primeramente el reino de Dios y su justicia, y todas estas cosas os serán añadidas.',
			'seekFirst.verseRef' => 'Mateo 6:33',
			'seekFirst.intro' => 'Cada día, las apps que elijas quedan cerradas hasta que guardes tu informe. Empieza tu día con Dios; lo demás viene después.',
			'seekFirst.enable' => 'Activar',
			'seekFirst.apps' => 'Apps que se cierran',
			'seekFirst.appsNone' => 'Ninguna app elegida',
			'seekFirst.appCount' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, one: '${n} app', other: '${n} apps', ), 
			'seekFirst.categoryCount' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, one: '${n} categoría', other: '${n} categorías', ), 
			'seekFirst.siteCount' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, one: '${n} sitio', other: '${n} sitios', ), 
			'seekFirst.start' => 'Cerradas desde',
			'seekFirst.pauses' => 'Pausas de 5 minutos',
			'seekFirst.pausesText' => '3 al día, para una urgencia',
			'seekFirst.pausesLeft' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, zero: 'Ninguna pausa más hoy', one: 'Queda ${n} pausa hoy', other: 'Quedan ${n} pausas hoy', ), 
			'seekFirst.todayOpen' => 'Hoy tus apps están abiertas: buscaste primero a Dios.',
			'seekFirst.todayLocked' => 'Tus apps siguen cerradas hasta tu informe de hoy.',
			'seekFirst.todayBefore' => ({required Object time}) => 'Tus apps se cerrarán a las ${time} si tu informe aún no está guardado.',
			'seekFirst.fillReport' => 'Llenar mi informe',
			'seekFirst.denied' => 'Sin acceso a Tiempo en pantalla, CMFI Connect no puede cerrar apps. Puedes permitirlo en Ajustes › Tiempo en pantalla.',
			'seekFirst.noApps' => 'Elige al menos una app que quede cerrada.',
			'seekFirst.unsupported' => 'Pronto disponible en este teléfono.',
			'seekFirst.moreOn' => ({required Object time}) => 'Desde las ${time}, hasta tu informe',
			'seekFirst.moreOff' => 'Cerrar apps hasta que tu informe esté hecho',
			'seekFirst.privacy' => 'CMFI Connect nunca ve las apps que eliges: tu iPhone las guarda para sí.',
			'seekFirst.shield.title' => 'Busca primero a Dios',
			'seekFirst.shield.subtitle' => ({required Object app}) => '${app} sigue cerrada hasta tu informe de hoy.',
			'seekFirst.shield.thisApp' => 'Esta app',
			'seekFirst.shield.fill' => 'Llenar mi informe',
			'seekFirst.shield.pause' => ({required Object n}) => 'Pausa de 5 min (${n}/3)',
			'seekFirst.shield.notificationTitle' => 'Busca primero a Dios',
			'seekFirst.shield.notificationBody' => 'Toca aquí para llenar tu informe.',
			'seekFirst.shield.serviceBody' => 'Tus apps se cierran cada día hasta tu informe.',
			'seekFirst.permissionsAndroid' => 'Para cerrar tus apps, CMFI Connect necesita dos permisos, que activarás en los ajustes que se van a abrir: «Acceso a datos de uso» (saber qué app está abierta) y «Mostrar sobre otras apps» (mostrar la pantalla Busca primero a Dios). Nada sale de tu teléfono.',
			'seekFirst.permissionsContinue' => 'Continuar',
			'seekFirst.deniedAndroid' => 'Sin estos dos permisos, CMFI Connect no puede cerrar apps. Puedes activarlos en Ajustes › Aplicaciones › Acceso especial.',
			'seekFirst.privacyAndroid' => 'Las apps que eliges se quedan en tu teléfono: CMFI Connect nunca las envía.',
			'documents.title' => 'Nuestros documentos',
			'documents.subtitle' => 'Enseñanzas, reglamentos, formularios…',
			'documents.moreSubtitle' => 'La biblioteca de la comunidad',
			'documents.search' => 'Buscar un documento',
			'documents.all' => 'Todos',
			'documents.empty' => 'Aún no hay documentos. Los documentos que publique la comunidad aparecerán aquí.',
			'documents.none' => 'Ningún documento coincide con tu búsqueda.',
			'documents.sizeKb' => ({required Object n}) => '${n} KB',
			'documents.sizeMb' => ({required Object n}) => '${n} MB',
			'documents.pdf' => 'PDF',
			'documents.word' => 'Word',
			'documents.open' => 'Abrir el documento',
			'documents.download' => 'Descargar',
			'documents.count' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, one: '${n} documento', other: '${n} documentos', ), 
			'documents.more' => 'Ver más',
			'biblePlan.title' => 'Plan de lectura',
			'biblePlan.duration' => 'Duración',
			'biblePlan.months3' => '3 meses',
			'biblePlan.months6' => '6 meses',
			'biblePlan.year' => '1 año',
			'biblePlan.custom' => 'Otra',
			'biblePlan.unitMonths' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, one: 'mes', other: 'meses', ), 
			'biblePlan.unitYear' => 'año',
			'biblePlan.days' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, one: '${n} día', other: '${n} días', ), 
			'biblePlan.scope' => 'Qué lees',
			'biblePlan.scopes.bible' => 'Toda la Biblia',
			'biblePlan.scopes.newTestament' => 'El Nuevo Testamento',
			'biblePlan.scopes.oldTestament' => 'El Antiguo Testamento',
			'biblePlan.scopes.psalmsProverbs' => 'Salmos y Proverbios',
			'biblePlan.chaptersShort' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, one: '${n} cap.', other: '${n} cap.', ), 
			'biblePlan.oldTestament' => 'Antiguo Testamento',
			'biblePlan.newTestament' => 'Nuevo Testamento',
			'biblePlan.order' => 'Orden',
			'biblePlan.orders.canonical' => 'Libro por libro',
			'biblePlan.orders.parallel' => 'AT + NT cada día',
			'biblePlan.reminder' => 'Recordatorio diario',
			'biblePlan.reminderAt' => 'Hora del recordatorio',
			'biblePlan.summary' => ({required Object chapters, required Object days, required Object perDay}) => '${chapters} capítulos en ${days} días, unos ${perDay} al día',
			'biblePlan.chapterCount' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, one: '${n} capítulo', other: '${n} capítulos', ), 
			'biblePlan.inDays' => ({required Object days}) => 'en ${days}',
			'biblePlan.perDayAbout' => ({required Object perDay}) => 'unos ${perDay} al día',
			'biblePlan.endsOn' => ({required Object date}) => 'Termina el ${date}',
			'biblePlan.startsOn' => ({required Object date}) => 'El plan empieza el ${date}.',
			'biblePlan.start' => 'Empezar el plan',
			'biblePlan.dayOf' => ({required Object day, required Object total}) => 'Día ${day} de ${total}',
			_ => null,
		} ?? switch (path) {
			'biblePlan.today' => 'Lectura del día',
			'biblePlan.todayDone' => 'Lectura del día hecha. ¡Bravo!',
			'biblePlan.read' => 'Leer',
			'biblePlan.behind' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, one: '${n} día de retraso', other: '${n} días de retraso', ), 
			'biblePlan.catchUp' => 'Toca aquí para ver los capítulos atrasados.',
			'biblePlan.catchUpShort' => 'ponerse al día',
			'biblePlan.chaptersRead' => ({required Object read, required Object total}) => '${read} de ${total} capítulos',
			'biblePlan.late' => 'Atrasados',
			'biblePlan.upcoming' => 'Próximos',
			'biblePlan.dayNumber' => ({required Object n}) => 'Día ${n}',
			'biblePlan.finished' => '¡Plan terminado! Lo leíste todo.',
			'biblePlan.stop' => 'Detener el plan',
			'biblePlan.stopTitle' => '¿Detener este plan?',
			'biblePlan.stopText' => 'Se borrará tu progreso en este plan. Los capítulos contados en tus informes se quedan.',
			'biblePlan.reminderTitle' => 'Tu lectura del día',
			'biblePlan.reminderChannel' => 'Plan de lectura',
			'biblePlan.homeTitle' => 'Lectura del día',
			'biblePlan.check' => ({required Object chapter}) => 'Marcar ${chapter} como leído',
			'biblePlan.uncheck' => ({required Object chapter}) => '${chapter}: leído',
			'biblePlan.listen' => 'Escuchar la lectura de hoy',
			'teachings.title' => 'Enseñanzas',
			'teachings.subtitle' => 'Escucha la Palabra estés donde estés',
			'teachings.search' => 'Buscar un mensaje, un predicador…',
			'teachings.all' => 'Todos',
			'teachings.downloadedChip' => 'Descargados',
			'teachings.count' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, one: '${n} mensaje', other: '${n} mensajes', ), 
			'teachings.empty' => 'Aún no hay enseñanzas.',
			'teachings.none' => 'Ninguna enseñanza coincide.',
			'teachings.noneDownloaded' => 'Ningún mensaje descargado. Toca la nube de un mensaje para escucharlo sin red.',
			'teachings.more' => 'Ver más',
			'teachings.offline' => 'Sin red: estos son los mensajes guardados en tu teléfono.',
			'teachings.play' => 'Escuchar',
			'teachings.pause' => 'Pausa',
			'teachings.heard' => 'Escuchado',
			'teachings.download' => 'Descargar para escuchar sin red',
			'teachings.downloaded' => 'Guardado en tu teléfono',
			'teachings.removed' => 'Quitado del teléfono',
			'teachings.cancelDownload' => 'Detener la descarga',
			'teachings.removeDownload' => 'Quitar del teléfono',
			'teachings.back15' => 'Retroceder 15 segundos',
			'teachings.forward15' => 'Avanzar 15 segundos',
			'teachings.speed' => ({required Object speed}) => 'Velocidad ${speed}',
			'teachings.recordedOn' => ({required Object date}) => 'Mensaje del ${date}',
			'teachings.moreSubtitle' => 'Predicaciones y enseñanzas para escuchar',
			'teachings.closePlayer' => 'Cerrar el reproductor',
			'memorize.title' => 'Memorización',
			'memorize.subtitle' => 'Guarda la Palabra en tu corazón',
			'memorize.toReview' => 'Por repasar',
			'memorize.learning' => 'Aprendiendo',
			'memorize.known' => 'Sabidos',
			'memorize.reviewCount' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, one: 'Repasar ${n} versículo', other: 'Repasar ${n} versículos', ), 
			'memorize.nothingDue' => 'Nada que repasar hoy.',
			'memorize.nextOn' => ({required Object date}) => 'Próximo repaso: ${date}.',
			'memorize.tomorrow' => 'mañana',
			'memorize.reminder' => 'Recordatorio de repaso',
			'memorize.reminderAt' => 'Hora del recordatorio',
			'memorize.myVerses' => 'Mis versículos',
			'memorize.howToAdd' => 'Para añadir uno: en la Biblia, toca un versículo y luego el cerebro de la barra.',
			'memorize.empty' => 'Aún no hay versículos para memorizar.',
			'memorize.openBible' => 'Abrir la Biblia',
			'memorize.late' => 'Atrasado',
			'memorize.today' => 'Hoy',
			'memorize.dueIn' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, one: 'En ${n} día', other: 'En ${n} días', ), 
			'memorize.stages.fresh' => 'Nuevo',
			'memorize.stages.learning' => 'Aprendiendo',
			'memorize.stages.known' => 'Sabido',
			'memorize.stats' => ({required Object stage, required Object lapses}) => '${stage} · olvidado ${lapses} veces',
			'memorize.reviewNow' => 'Repasar ahora',
			'memorize.remove' => 'Quitar',
			'memorize.removeTitle' => '¿Quitar este versículo?',
			'memorize.removeText' => 'Se borrará su progreso.',
			'memorize.removed' => 'Versículo quitado',
			'memorize.progress' => ({required Object done, required Object total}) => '${done} / ${total}',
			'memorize.show' => 'Ver el versículo',
			'memorize.hints.full' => 'Texto',
			'memorize.hints.gaps' => 'Huecos',
			'memorize.hints.initials' => 'Iniciales',
			'memorize.hints.none' => 'Nada',
			'memorize.recite' => 'Recita el versículo y luego comprueba.',
			'memorize.grades.again' => 'Otra vez',
			'memorize.grades.hard' => 'Difícil',
			'memorize.grades.good' => 'Bien',
			'memorize.grades.easy' => 'Fácil',
			'memorize.now' => 'Enseguida',
			'memorize.later' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, one: '${n} día', other: '${n} días', ), 
			'memorize.doneTitle' => '¡Repaso terminado!',
			'memorize.doneText' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, one: 'Repasaste ${n} versículo. ¡Que la Palabra more en ti!', other: 'Repasaste ${n} versículos. ¡Que la Palabra more en ti!', ), 
			'memorize.back' => 'Volver',
			'memorize.reminderTitle' => 'Tus versículos por repasar',
			'memorize.reminderBody' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, one: '${n} versículo te espera hoy.', other: '${n} versículos te esperan hoy.', ), 
			'memorize.reminderChannel' => 'Memorización',
			'memorize.homeTitle' => 'Versículos por repasar',
			'memorize.homeText' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, one: '${n} versículo te espera', other: '${n} versículos te esperan', ), 
			'memorize.menu' => 'Memorizar versículos',
			'memorize.memorize' => 'Memorizar',
			'memorize.added' => 'Añadido a tus versículos para memorizar',
			'memorize.already' => 'Este pasaje ya está en tus versículos',
			'souls.title' => 'Seguimiento de almas',
			'souls.subtitle' => '«El que gana almas es sabio.» Proverbios 11:30',
			'souls.search' => 'Buscar una persona…',
			'souls.people' => 'Personas',
			'souls.received' => 'Recibieron a Jesús',
			'souls.toContact' => 'Por contactar',
			'souls.all' => 'Todas',
			'souls.stages.met' => 'Conocido(a)',
			'souls.stages.interested' => 'Interesado(a)',
			'souls.stages.received' => 'Recibió a Jesús',
			'souls.stages.followUp' => 'En afianzamiento',
			'souls.stages.church' => 'Viene a la iglesia',
			'souls.stages.baptized' => 'Bautizado(a)',
			'souls.contactSection' => 'Por volver a contactar',
			'souls.everyone' => 'Todas las personas',
			'souls.contactToday' => 'Contactar hoy',
			'souls.contactLate' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, one: 'Con ${n} día de retraso', other: 'Con ${n} días de retraso', ), 
			'souls.contactOn' => ({required Object date}) => 'Próximo contacto el ${date}',
			'souls.empty' => 'Anota aquí a las personas que evangelizas: ora por ellas y acompáñalas hasta la iglesia.',
			'souls.none' => 'Nadie coincide.',
			'souls.add' => 'Añadir',
			'souls.addTitle' => 'Nueva persona',
			'souls.editTitle' => 'Editar',
			'souls.name' => 'Nombre',
			'souls.nameRequired' => 'Escribe su nombre.',
			'souls.phone' => 'Teléfono',
			'souls.place' => 'Dónde se conocieron',
			'souls.metOn' => 'Conocido(a) el',
			'souls.stage' => '¿En qué punto está?',
			'souls.firstNote' => 'Una nota (opcional)',
			'souls.noteHint' => 'Lo que se dijo, motivos de oración…',
			'souls.save' => 'Guardar',
			'souls.saved' => 'Guardado',
			'souls.call' => 'Llamar',
			'souls.whatsApp' => 'WhatsApp',
			'souls.sms' => 'SMS',
			'souls.edit' => 'Editar',
			'souls.delete' => 'Eliminar',
			'souls.deleteTitle' => ({required Object name}) => '¿Eliminar a ${name}?',
			'souls.deleteText' => 'Sus notas se borrarán de tu teléfono.',
			'souls.deleted' => 'Eliminado',
			'souls.nextContact' => 'Próximo contacto',
			'souls.plan' => 'Programar un recordatorio',
			'souls.change' => 'Cambiar la fecha',
			'souls.clear' => 'Quitar el recordatorio',
			'souls.noContact' => 'Ningún recordatorio previsto',
			'souls.metAt' => ({required Object date}) => 'Conocido(a) el ${date}',
			'souls.notes' => 'Notas',
			'souls.addNote' => 'Añadir la nota',
			'souls.noNotes' => 'Aún no hay notas.',
			'souls.deleteNote' => 'Eliminar la nota',
			'souls.export' => 'Exportar (hoja de cálculo)',
			'souls.csv.name' => 'Nombre',
			'souls.csv.phone' => 'Teléfono',
			'souls.csv.place' => 'Lugar',
			'souls.csv.metOn' => 'Conocido el',
			'souls.csv.stage' => 'Etapa',
			'souls.csv.next' => 'Próximo contacto',
			'souls.csv.notes' => 'Notas',
			'souls.lock' => ({required Object method}) => 'Bloquear con ${method}',
			'souls.lockedTitle' => 'Tu seguimiento de almas está bloqueado',
			'souls.unlock' => 'Desbloquear',
			'souls.unlockReason' => 'Abre tu seguimiento de almas',
			'souls.privacy' => 'Esta información se queda en tu teléfono: nunca se envía.',
			'souls.reminderTitle' => 'Seguimiento de almas',
			'souls.reminderBody' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, one: '${n} persona por contactar hoy.', other: '${n} personas por contactar hoy.', ), 
			'souls.reminderChannel' => 'Seguimiento de almas',
			'souls.moreSubtitle' => 'Las personas que evangelizas',
			'souls.prayToday' => 'Hoy, ora por',
			'souls.prayerReminder' => 'Recordármelo cada mañana',
			'souls.prayerReminderAt' => 'Hora del recordatorio de oración',
			'souls.prayerTitle' => 'Ora por un alma',
			'souls.prayerBody' => 'Tómate un momento para orar por la persona del día.',
			'souls.prayerChannel' => 'Oración por las almas',
			'fasts.title' => 'Mis ayunos',
			'fasts.intro' => 'Apártate para Dios: elige tu ayuno y por qué ayunas. Cada día cumplido cuenta en tu informe.',
			'fasts.moreSubtitle' => 'Ayuno completo o parcial, contado cada día',
			'fasts.kind' => 'Tu ayuno',
			'fasts.kinds.full' => 'Ayuno completo',
			'fasts.kinds.partial' => 'Ayuno parcial',
			'fasts.kindTexts.full' => 'Día y noche, 24 horas al día, desde ahora.',
			'fasts.kindTexts.partial' => 'Cada día hasta la hora elegida; luego rompes el ayuno.',
			'fasts.length' => 'Duración',
			'fasts.days' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, one: '${n} día', other: '${n} días', ), 
			'fasts.endEachDay' => 'Fin del ayuno cada día',
			'fasts.topics' => 'Ayuno por',
			'fasts.topicHint' => 'Un motivo de oración…',
			'fasts.addTopic' => 'Añadir el motivo',
			'fasts.removeTopic' => 'Quitar el motivo',
			'fasts.history' => 'Mis últimos ayunos',
			'fasts.kept' => ({required Object kept, required Object days}) => '${kept}/${days} días',
			'fasts.start' => 'Comenzar el ayuno',
			'fasts.until' => ({required Object date}) => 'Hasta el ${date}',
			'fasts.hoursLeft' => ({required Object h, required Object m}) => '${h} h ${m}',
			'fasts.minutesLeft' => ({required Object m}) => '${m} min',
			'fasts.dayOf' => ({required Object day, required Object total}) => 'Día ${day} de ${total}',
			'fasts.dayEnds' => ({required Object time}) => 'Este día termina a las ${time}',
			'fasts.stop' => 'Romper el ayuno',
			'fasts.stopTitle' => '¿Romper tu ayuno?',
			'fasts.stopText' => 'Los días ya cumplidos siguen contados. El día en curso no.',
			'fasts.counted' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, one: '${n} día de ayuno contado en tu informe', other: '${n} días de ayuno contados en tu informe', ), 
			'fasts.reportNote' => ({required Object item}) => 'Cada día cumplido suma 1 a «${item}» en tu informe.',
			'fasts.items.full' => 'Ayuno completo',
			'fasts.items.partial' => 'Ayuno parcial',
			'fasts.dayTitle' => ({required Object day}) => 'Día ${day} de ayuno cumplido',
			'fasts.dayBody' => 'Cuenta en tu informe. ¡Ánimo, sigue!',
			'fasts.endTitle' => 'Tu ayuno ha terminado',
			'fasts.endBody' => 'Que el Señor responda a tus oraciones.',
			'fasts.channel' => 'Mis ayunos',
			'fasts.homeTitle' => ({required Object day, required Object total}) => 'Ayuno · día ${day} de ${total}',
			'fasts.homeText' => ({required Object time}) => 'Este día termina a las ${time}',
			'received.title' => 'Informes recibidos',
			'received.subtitle' => 'Enviados por tus discípulos en la app',
			'received.unreadCount' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, one: '${n} nuevo', other: '${n} nuevos', ), 
			'received.empty' => 'Aún no has recibido ningún informe. Cuando un discípulo te envíe el suyo en la app, llegará aquí.',
			'received.day' => ({required Object date}) => 'El ${date}',
			'received.period' => ({required Object from, required Object to}) => 'Del ${from} al ${to}',
			'received.unread' => 'Nuevo',
			'received.yourReply' => ({required Object text}) => 'Tu respuesta: «${text}»',
			'received.open' => 'Ver',
			'received.encourage' => 'Animar',
			'received.editReply' => 'Cambiar',
			'received.encourageTitle' => ({required Object name}) => 'Una palabra para ${name}',
			'received.suggestions.0' => '¡Qué fidelidad, sigue así!',
			'received.suggestions.1' => 'Oro por ti.',
			'received.suggestions.2' => '¡Que Dios te fortalezca!',
			'received.suggestions.3' => 'Bravo por tu perseverancia.',
			'received.hint' => 'Escribe tu ánimo…',
			'received.send' => 'Enviar',
			'received.sent' => ({required Object name}) => '${name} recibió tu palabra',
			'update.requiredTitle' => 'Actualización necesaria',
			'update.requiredText' => 'Esta versión de la aplicación ya no es compatible. Instala la nueva versión para continuar.',
			'update.availableTitle' => 'Nueva versión disponible',
			'update.availableText' => ({required Object version}) => 'La versión ${version} está lista, con mejoras y correcciones.',
			'update.update' => 'Actualizar',
			'update.later' => 'Más tarde',
			'update.versions' => ({required Object installed, required Object target}) => 'Tu versión: ${installed} · Nueva: ${target}',
			'update.downloading' => 'Descargando la actualización…',
			'update.readyTitle' => 'La actualización está lista',
			'update.readyText' => 'Reinicia la aplicación para instalarla. Si no, se instalará cuando salgas de ella.',
			'update.restart' => 'Reiniciar',
			'update.failed' => 'No se pudo abrir la tienda. Inténtalo más tarde.',
			'update.moreButton' => ({required Object version}) => 'Actualizar a la versión ${version}',
			_ => null,
		};
	}
}
