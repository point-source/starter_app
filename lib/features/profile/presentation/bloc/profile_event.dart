import 'package:equatable/equatable.dart';

sealed class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object?> get props => [];
}

final class GetMyProfile extends ProfileEvent {
  const GetMyProfile();
}

final class ProfileReset extends ProfileEvent {
  const ProfileReset();
}
