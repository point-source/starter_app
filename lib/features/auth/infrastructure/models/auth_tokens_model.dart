import 'package:dart_mappable/dart_mappable.dart';
import 'package:starter_app/core/types/types.dart';

import 'package:starter_app/features/auth/domain/value_objects/auth_token.dart';
import 'package:starter_app/features/auth/domain/value_objects/refresh_token.dart';

part 'auth_tokens_model.mapper.dart';

/// Data transfer object for authentication tokens.
///
/// Handles JSON serialization for token pairs returned by auth endpoints.
/// Used in login, register, and refresh token responses.
///
/// ## Usage
/// ```dart
/// // From API response
/// final model = AuthTokensModel.fromJson(json);
/// final accessToken = model.toAccessToken();
/// final refreshToken = model.toRefreshToken();
/// ```
@MappableClass()
class AuthTokensModel with AuthTokensModelMappable {
  /// The access token.
  final String accessToken;

  /// The refresh token.
  final String refreshToken;

  /// Creates an [AuthTokensModel].
  const AuthTokensModel({
    required this.accessToken,
    required this.refreshToken,
  });

  /// Creates model from JSON map.
  static AuthTokensModel fromJson(Json json) =>
      AuthTokensModelMapper.fromMap(json);

  /// Converts access token to domain value object.
  ///
  /// Uses `fromTrustedSource` since token comes from authenticated API.
  AuthToken toAccessToken() {
    return AuthToken.fromTrustedSource(accessToken);
  }

  /// Converts refresh token to domain value object.
  ///
  /// Uses `fromTrustedSource` since token comes from authenticated API.
  RefreshToken toRefreshToken() {
    return RefreshToken.fromTrustedSource(refreshToken);
  }
}
