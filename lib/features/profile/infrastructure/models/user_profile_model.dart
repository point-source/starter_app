import 'package:dart_mappable/dart_mappable.dart';
import 'package:starter_app/core/domain/value_objects/name.dart';
import 'package:starter_app/core/types/types.dart';
import 'package:starter_app/features/auth/domain/entities/user_id.dart';
import 'package:starter_app/features/profile/domain/entities/profile_id.dart';
import 'package:starter_app/features/profile/domain/entities/user_profile.dart';

part 'user_profile_model.mapper.dart';

/// Data transfer object for [UserProfile].
@MappableClass()
class UserProfileModel with UserProfileModelMappable {
  /// Profile ID.
  final String id;

  /// User ID.
  final String userId;

  /// Display name.
  final String displayName;

  /// Avatar URL.
  final String? avatarUrl;

  /// Creates a [UserProfileModel].
  const UserProfileModel({
    required this.id,
    required this.userId,
    required this.displayName,
    this.avatarUrl,
  });

  /// Creates model from JSON map.
  static UserProfileModel fromJson(Json json) =>
      UserProfileModelMapper.fromMap(json);

  /// Creates model from domain entity.
  factory UserProfileModel.fromDomain(UserProfile profile) {
    return UserProfileModel(
      id: profile.id.value.value,
      userId: profile.userId.value.value,
      displayName: profile.displayName.getOrCrash(),
    );
  }

  /// Converts model to domain entity.
  UserProfile toDomain() {
    return UserProfile(
      id: ProfileId.fromString(id),
      userId: UserId.fromString(userId),
      displayName: Name.fromTrustedSource(displayName),
    );
  }
}
