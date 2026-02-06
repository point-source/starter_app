// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'profile_event.dart';

class ProfileEventMapper extends ClassMapperBase<ProfileEvent> {
  ProfileEventMapper._();

  static ProfileEventMapper? _instance;
  static ProfileEventMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ProfileEventMapper._());
      GetMyProfileMapper.ensureInitialized();
      ProfileResetMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ProfileEvent';

  @override
  final MappableFields<ProfileEvent> fields = const {};

  static ProfileEvent _instantiate(DecodingData data) {
    throw MapperException.missingConstructor('ProfileEvent');
  }

  @override
  final Function instantiate = _instantiate;

  static ProfileEvent fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ProfileEvent>(map);
  }

  static ProfileEvent fromJson(String json) {
    return ensureInitialized().decodeJson<ProfileEvent>(json);
  }
}

mixin ProfileEventMappable {
  String toJson();
  Map<String, dynamic> toMap();
  ProfileEventCopyWith<ProfileEvent, ProfileEvent, ProfileEvent> get copyWith;
}

abstract class ProfileEventCopyWith<$R, $In extends ProfileEvent, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call();
  ProfileEventCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class GetMyProfileMapper extends ClassMapperBase<GetMyProfile> {
  GetMyProfileMapper._();

  static GetMyProfileMapper? _instance;
  static GetMyProfileMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = GetMyProfileMapper._());
      ProfileEventMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'GetMyProfile';

  @override
  final MappableFields<GetMyProfile> fields = const {};

  static GetMyProfile _instantiate(DecodingData data) {
    return GetMyProfile();
  }

  @override
  final Function instantiate = _instantiate;

  static GetMyProfile fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<GetMyProfile>(map);
  }

  static GetMyProfile fromJson(String json) {
    return ensureInitialized().decodeJson<GetMyProfile>(json);
  }
}

mixin GetMyProfileMappable {
  String toJson() {
    return GetMyProfileMapper.ensureInitialized().encodeJson<GetMyProfile>(
      this as GetMyProfile,
    );
  }

  Map<String, dynamic> toMap() {
    return GetMyProfileMapper.ensureInitialized().encodeMap<GetMyProfile>(
      this as GetMyProfile,
    );
  }

  GetMyProfileCopyWith<GetMyProfile, GetMyProfile, GetMyProfile> get copyWith =>
      _GetMyProfileCopyWithImpl<GetMyProfile, GetMyProfile>(
        this as GetMyProfile,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return GetMyProfileMapper.ensureInitialized().stringifyValue(
      this as GetMyProfile,
    );
  }

  @override
  bool operator ==(Object other) {
    return GetMyProfileMapper.ensureInitialized().equalsValue(
      this as GetMyProfile,
      other,
    );
  }

  @override
  int get hashCode {
    return GetMyProfileMapper.ensureInitialized().hashValue(
      this as GetMyProfile,
    );
  }
}

extension GetMyProfileValueCopy<$R, $Out>
    on ObjectCopyWith<$R, GetMyProfile, $Out> {
  GetMyProfileCopyWith<$R, GetMyProfile, $Out> get $asGetMyProfile =>
      $base.as((v, t, t2) => _GetMyProfileCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class GetMyProfileCopyWith<$R, $In extends GetMyProfile, $Out>
    implements ProfileEventCopyWith<$R, $In, $Out> {
  @override
  $R call();
  GetMyProfileCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _GetMyProfileCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, GetMyProfile, $Out>
    implements GetMyProfileCopyWith<$R, GetMyProfile, $Out> {
  _GetMyProfileCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<GetMyProfile> $mapper =
      GetMyProfileMapper.ensureInitialized();
  @override
  $R call() => $apply(FieldCopyWithData({}));
  @override
  GetMyProfile $make(CopyWithData data) => GetMyProfile();

  @override
  GetMyProfileCopyWith<$R2, GetMyProfile, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _GetMyProfileCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class ProfileResetMapper extends ClassMapperBase<ProfileReset> {
  ProfileResetMapper._();

  static ProfileResetMapper? _instance;
  static ProfileResetMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ProfileResetMapper._());
      ProfileEventMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ProfileReset';

  @override
  final MappableFields<ProfileReset> fields = const {};

  static ProfileReset _instantiate(DecodingData data) {
    return ProfileReset();
  }

  @override
  final Function instantiate = _instantiate;

  static ProfileReset fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ProfileReset>(map);
  }

  static ProfileReset fromJson(String json) {
    return ensureInitialized().decodeJson<ProfileReset>(json);
  }
}

mixin ProfileResetMappable {
  String toJson() {
    return ProfileResetMapper.ensureInitialized().encodeJson<ProfileReset>(
      this as ProfileReset,
    );
  }

  Map<String, dynamic> toMap() {
    return ProfileResetMapper.ensureInitialized().encodeMap<ProfileReset>(
      this as ProfileReset,
    );
  }

  ProfileResetCopyWith<ProfileReset, ProfileReset, ProfileReset> get copyWith =>
      _ProfileResetCopyWithImpl<ProfileReset, ProfileReset>(
        this as ProfileReset,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return ProfileResetMapper.ensureInitialized().stringifyValue(
      this as ProfileReset,
    );
  }

  @override
  bool operator ==(Object other) {
    return ProfileResetMapper.ensureInitialized().equalsValue(
      this as ProfileReset,
      other,
    );
  }

  @override
  int get hashCode {
    return ProfileResetMapper.ensureInitialized().hashValue(
      this as ProfileReset,
    );
  }
}

extension ProfileResetValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ProfileReset, $Out> {
  ProfileResetCopyWith<$R, ProfileReset, $Out> get $asProfileReset =>
      $base.as((v, t, t2) => _ProfileResetCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class ProfileResetCopyWith<$R, $In extends ProfileReset, $Out>
    implements ProfileEventCopyWith<$R, $In, $Out> {
  @override
  $R call();
  ProfileResetCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _ProfileResetCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ProfileReset, $Out>
    implements ProfileResetCopyWith<$R, ProfileReset, $Out> {
  _ProfileResetCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ProfileReset> $mapper =
      ProfileResetMapper.ensureInitialized();
  @override
  $R call() => $apply(FieldCopyWithData({}));
  @override
  ProfileReset $make(CopyWithData data) => ProfileReset();

  @override
  ProfileResetCopyWith<$R2, ProfileReset, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _ProfileResetCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

