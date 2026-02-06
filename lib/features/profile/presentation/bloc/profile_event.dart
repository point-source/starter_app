import 'package:dart_mappable/dart_mappable.dart';

part 'profile_event.mapper.dart';

@MappableClass()
sealed class ProfileEvent with ProfileEventMappable {
  const ProfileEvent();
}

@MappableClass()
final class GetMyProfile extends ProfileEvent with GetMyProfileMappable {
  const GetMyProfile();
}

@MappableClass()
final class ProfileReset extends ProfileEvent with ProfileResetMappable {
  const ProfileReset();
}
