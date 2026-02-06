import 'package:dart_mappable/dart_mappable.dart';
import 'package:starter_app/core/domain/value_objects/value_objects.dart';
import 'package:starter_app/core/types/types.dart';

import 'package:starter_app/features/auth/domain/entities/auth_credentials.dart';

part 'register_request_model.mapper.dart';

/// Data transfer object for registration requests.
///
/// Converts domain credentials and name to JSON for API requests.
@MappableClass()
class RegisterRequestModel with RegisterRequestModelMappable {
  /// Creates a [RegisterRequestModel].
  const RegisterRequestModel({
    required this.email,
    required this.password,
    required this.name,
  });

  /// Creates model from domain credentials.
  factory RegisterRequestModel.fromDomain(
    AuthCredentials credentials,
    Name name,
  ) {
    return RegisterRequestModel(
      email: credentials.emailValue,
      password: credentials.passwordValue,
      name: name.getOrCrash(),
    );
  }

  /// User email address.
  final String email;

  /// User password.
  final String password;

  /// User display name.
  final String name;

  /// Creates model from JSON map (rarely used).
  static RegisterRequestModel fromJson(Json json) =>
      RegisterRequestModelMapper.fromMap(json);
}
