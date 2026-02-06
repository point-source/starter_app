import 'package:dart_mappable/dart_mappable.dart';
import 'package:starter_app/core/types/types.dart';

import 'package:starter_app/features/auth/domain/entities/auth_credentials.dart';

part 'login_request_model.mapper.dart';

/// Data transfer object for login requests.
///
/// Converts domain credentials to JSON for API requests.
///
/// ## Usage
/// ```dart
/// final model = LoginRequestModel.fromDomain(credentials);
/// final json = model.toJson();
/// await dio.post('/auth/login', data: json);
/// ```
@MappableClass()
class LoginRequestModel with LoginRequestModelMappable {
  /// User email address.
  final String email;

  /// User password.
  final String password;

  /// Creates a [LoginRequestModel].
  const LoginRequestModel({
    required this.email,
    required this.password,
  });

  /// Creates model from JSON map (rarely used).
  static LoginRequestModel fromJson(Json json) =>
      LoginRequestModelMapper.fromMap(json);

  /// Creates model from domain credentials.
  factory LoginRequestModel.fromDomain(AuthCredentials credentials) {
    return LoginRequestModel(
      email: credentials.emailValue,
      password: credentials.passwordValue,
    );
  }
}
