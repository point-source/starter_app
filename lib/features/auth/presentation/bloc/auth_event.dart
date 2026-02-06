import 'package:dart_mappable/dart_mappable.dart';
import 'package:starter_app/features/auth/domain/entities/user.dart';

part 'auth_event.mapper.dart';

@MappableClass()
sealed class AuthEvent with AuthEventMappable {
  const AuthEvent();
}

@MappableClass()
final class AuthEmailChanged extends AuthEvent with AuthEmailChangedMappable {
  const AuthEmailChanged(this.email);
  final String email;
}

@MappableClass()
final class AuthPasswordChanged extends AuthEvent
    with AuthPasswordChangedMappable {
  const AuthPasswordChanged(this.password);
  final String password;
}

@MappableClass()
final class AuthNameChanged extends AuthEvent with AuthNameChangedMappable {
  const AuthNameChanged(this.name);
  final String name;
}

@MappableClass()
final class AuthTogglePasswordVisibility extends AuthEvent
    with AuthTogglePasswordVisibilityMappable {
  const AuthTogglePasswordVisibility();
}

@MappableClass()
final class AuthEmailUnfocused extends AuthEvent
    with AuthEmailUnfocusedMappable {
  const AuthEmailUnfocused();
}

@MappableClass()
final class AuthPasswordUnfocused extends AuthEvent
    with AuthPasswordUnfocusedMappable {
  const AuthPasswordUnfocused();
}

@MappableClass()
final class AuthNameUnfocused extends AuthEvent with AuthNameUnfocusedMappable {
  const AuthNameUnfocused();
}

@MappableClass()
final class AuthEmailSubmitted extends AuthEvent
    with AuthEmailSubmittedMappable {
  const AuthEmailSubmitted();
}

@MappableClass()
final class AuthLoginSubmitted extends AuthEvent
    with AuthLoginSubmittedMappable {
  const AuthLoginSubmitted();
}

@MappableClass()
final class AuthRegisterSubmitted extends AuthEvent
    with AuthRegisterSubmittedMappable {
  const AuthRegisterSubmitted();
}

@MappableClass()
final class AuthLogoutRequested extends AuthEvent
    with AuthLogoutRequestedMappable {
  const AuthLogoutRequested();
}

@MappableClass()
final class AuthUserChanged extends AuthEvent with AuthUserChangedMappable {
  const AuthUserChanged(this.user);
  final User? user;
}

@MappableClass()
final class AuthWatchStarted extends AuthEvent with AuthWatchStartedMappable {
  const AuthWatchStarted();
}

@MappableClass()
final class AuthGetCurrentUser extends AuthEvent
    with AuthGetCurrentUserMappable {
  const AuthGetCurrentUser();
}

@MappableClass()
final class AuthSessionWatchStarted extends AuthEvent
    with AuthSessionWatchStartedMappable {
  const AuthSessionWatchStarted();
}

@MappableClass()
final class AuthSessionExpired extends AuthEvent
    with AuthSessionExpiredMappable {
  const AuthSessionExpired();
}
