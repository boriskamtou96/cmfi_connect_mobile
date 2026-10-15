import '../i18n/strings.g.dart';
import 'app_exception.dart';

/// The translated message to show for any error caught by the UI (AsyncError, SnackBar...).
String userMessageFor(Object error, Translations t) => switch (error) {
  NetworkException() => t.errors.network,
  UnauthorizedException() => t.errors.unauthorized,
  ApiException(code: 'INVALID_CREDENTIALS') => t.errors.invalidCredentials,
  ApiException(code: 'CONFLICT') => t.errors.conflict,
  ApiException(code: 'USERNAME_TAKEN') => t.members.usernameTaken,
  ApiException(code: 'USERNAME_INVALID') => t.members.usernameInvalid,
  ApiException(code: 'USERNAME_RESERVED') => t.members.usernameReserved,
  ApiException(code: 'AUTHORITY_EXISTS') => t.authorities.form.alreadyAdded,
  ApiException(code: 'DISCIPLE_MAKER_EXISTS') => t.authorities.form.makerExists,
  ApiException(code: 'EVENT_FULL') => t.errors.eventFull,
  ApiException(code: 'REGISTRATION_CLOSED') => t.errors.registrationClosed,
  ApiException(code: 'MEDIA_TOO_LARGE') => t.errors.mediaTooLarge,
  ApiException(code: 'MEDIA_UNSUPPORTED') => t.errors.mediaUnsupported,
  ApiException(code: 'AVATAR_INVALID') => t.errors.avatarInvalid,
  ApiException(code: 'REPORTS_NOT_SHARED') => t.errors.reportsNotShared,
  ApiException(code: 'LAST_SUPERADMIN') =>
    t.members.deleteAccount.lastSuperadmin,
  ApiException(code: 'NOT_PARTICIPANT') => t.errors.notParticipant,
  ApiException(code: 'IMPORTUNITY_CLOSED') => t.errors.importunityClosed,
  ApiException(code: 'USERNAME_NOT_FOUND') => t.errors.usernameNotFound,
  ApiException(code: 'OWNER_CANNOT_LEAVE') => t.errors.ownerCannotLeave,
  ApiException(code: 'TOO_MANY_PEOPLE') => t.errors.tooManyPeople,
  ApiException(code: 'FORBIDDEN') => t.errors.forbidden,
  ApiException(code: 'NOT_FOUND') => t.errors.notFound,
  ApiException(status: >= 500) => t.errors.server,
  ApiException() => t.errors.badRequest,
  _ => t.errors.unknown,
};
