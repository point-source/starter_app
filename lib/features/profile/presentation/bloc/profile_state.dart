import 'package:dart_mappable/dart_mappable.dart';
import 'package:starter_app/core/presentation/models/error_model.dart';
import 'package:starter_app/features/profile/domain/entities/user_profile.dart';

part 'profile_state.mapper.dart';

@MappableClass()
sealed class ProfileState with ProfileStateMappable {
  const ProfileState();
}

@MappableClass()
final class ProfileInitial extends ProfileState with ProfileInitialMappable {
  const ProfileInitial();
}

@MappableClass()
final class ProfileLoading extends ProfileState with ProfileLoadingMappable {
  const ProfileLoading();
}

@MappableClass()
final class ProfileLoaded extends ProfileState with ProfileLoadedMappable {
  const ProfileLoaded(this.profile);
  final UserProfile profile;
}

@MappableClass()
final class ProfileError extends ProfileState with ProfileErrorMappable {
  const ProfileError(this.error);
  final ErrorModel error;
}
