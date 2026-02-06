import 'package:dart_mappable/dart_mappable.dart';
import 'package:starter_app/core/types/types.dart';

import 'package:starter_app/features/auth/infrastructure/models/auth_tokens_model.dart';
import 'package:starter_app/features/auth/infrastructure/models/user_model.dart';

part 'auth_response_model.mapper.dart';

/// Data transfer object for authentication responses.
///
/// Combines user data with authentication tokens.
/// Returned by login and register endpoints.
///
/// ## Usage
/// ```dart
/// // From API response
/// final model = AuthResponseModel.fromJson(json);
/// final user = model.user.toDomain();
/// final accessToken = model.tokens.toAccessToken();
/// final refreshToken = model.tokens.toRefreshToken();
/// ```
@MappableClass()
class AuthResponseModel with AuthResponseModelMappable {
  /// The authenticated user.
  final UserModel user;

  /// Authentication tokens.
  final AuthTokensModel tokens;

  /// Creates an [AuthResponseModel].
  const AuthResponseModel({
    required this.user,
    required this.tokens,
  });

  /// Creates model from JSON map.
  static AuthResponseModel fromJson(Json json) =>
      AuthResponseModelMapper.fromMap(json);
}
