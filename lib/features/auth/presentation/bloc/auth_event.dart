import 'package:equatable/equatable.dart';
import 'package:starter_app/features/auth/domain/entities/user.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

final class AuthEmailChanged extends AuthEvent {
  const AuthEmailChanged(this.email);
  final String email;

  @override
  List<Object?> get props => [email];
}

final class AuthPasswordChanged extends AuthEvent {
  const AuthPasswordChanged(this.password);
  final String password;

  @override
  List<Object?> get props => [password];
}

final class AuthNameChanged extends AuthEvent {
  const AuthNameChanged(this.name);
  final String name;

  @override
  List<Object?> get props => [name];
}

final class AuthTogglePasswordVisibility extends AuthEvent {
  const AuthTogglePasswordVisibility();
}

final class AuthEmailUnfocused extends AuthEvent {
  const AuthEmailUnfocused();
}

final class AuthPasswordUnfocused extends AuthEvent {
  const AuthPasswordUnfocused();
}

final class AuthNameUnfocused extends AuthEvent {
  const AuthNameUnfocused();
}

final class AuthEmailSubmitted extends AuthEvent {
  const AuthEmailSubmitted();
}

final class AuthLoginSubmitted extends AuthEvent {
  const AuthLoginSubmitted();
}

final class AuthRegisterSubmitted extends AuthEvent {
  const AuthRegisterSubmitted();
}

final class AuthLogoutRequested extends AuthEvent {
  const AuthLogoutRequested();
}

final class AuthUserChanged extends AuthEvent {
  const AuthUserChanged(this.user);
  final User? user;

  @override
  List<Object?> get props => [user];
}

final class AuthWatchStarted extends AuthEvent {
  const AuthWatchStarted();
}

final class AuthGetCurrentUser extends AuthEvent {
  const AuthGetCurrentUser();
}

final class AuthSessionWatchStarted extends AuthEvent {
  const AuthSessionWatchStarted();
}

final class AuthSessionExpired extends AuthEvent {
  const AuthSessionExpired();
}
