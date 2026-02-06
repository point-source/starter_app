import 'package:dart_mappable/dart_mappable.dart';
import 'package:starter_app/core/domain/value_objects/email_address.dart';
import 'package:starter_app/core/types/types.dart';
import 'package:starter_app/features/auth/domain/entities/user.dart';
import 'package:starter_app/features/auth/domain/entities/user_id.dart';

part 'user_model.mapper.dart';

/// Data transfer object for [User] entity.
///
/// Handles JSON serialization/deserialization for API communication.
/// Maps between JSON (infrastructure layer) and domain entities.
///
/// ## Usage
/// ```dart
/// // From API response
/// final model = UserModel.fromJson(json);
/// final user = model.toDomain();
///
/// // To API request (rarely needed for User)
/// final json = UserModel.fromDomain(user).toJson();
/// ```
@MappableClass()
class UserModel with UserModelMappable {
  /// User ID.
  final String id;

  /// User email address.
  final String email;

  /// Creates a [UserModel].
  const UserModel({
    required this.id,
    required this.email,
  });

  /// Creates model from JSON map.
  static UserModel fromJson(Json json) => UserModelMapper.fromMap(json);

  /// Creates model from domain entity.
  factory UserModel.fromDomain(User user) {
    return UserModel(
      id: user.id.value.value,
      email: user.email.getOrCrash(),
    );
  }

  /// Converts model to domain entity.
  ///
  /// Uses `fromString`/`fromTrustedSource` constructors since data comes
  /// from authenticated backend API (already validated server-side).
  User toDomain() {
    return User(
      id: UserId.fromString(id),
      email: EmailAddress.fromTrustedSource(email),
    );
  }
}
