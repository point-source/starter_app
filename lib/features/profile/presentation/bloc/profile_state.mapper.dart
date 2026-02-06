// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'profile_state.dart';

class ProfileStateMapper extends ClassMapperBase<ProfileState> {
  ProfileStateMapper._();

  static ProfileStateMapper? _instance;
  static ProfileStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ProfileStateMapper._());
      ProfileInitialMapper.ensureInitialized();
      ProfileLoadingMapper.ensureInitialized();
      ProfileLoadedMapper.ensureInitialized();
      ProfileErrorMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ProfileState';

  @override
  final MappableFields<ProfileState> fields = const {};

  static ProfileState _instantiate(DecodingData data) {
    throw MapperException.missingConstructor('ProfileState');
  }

  @override
  final Function instantiate = _instantiate;

  static ProfileState fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ProfileState>(map);
  }

  static ProfileState fromJson(String json) {
    return ensureInitialized().decodeJson<ProfileState>(json);
  }
}

mixin ProfileStateMappable {
  String toJson();
  Map<String, dynamic> toMap();
  ProfileStateCopyWith<ProfileState, ProfileState, ProfileState> get copyWith;
}

abstract class ProfileStateCopyWith<$R, $In extends ProfileState, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call();
  ProfileStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class ProfileInitialMapper extends ClassMapperBase<ProfileInitial> {
  ProfileInitialMapper._();

  static ProfileInitialMapper? _instance;
  static ProfileInitialMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ProfileInitialMapper._());
      ProfileStateMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ProfileInitial';

  @override
  final MappableFields<ProfileInitial> fields = const {};

  static ProfileInitial _instantiate(DecodingData data) {
    return ProfileInitial();
  }

  @override
  final Function instantiate = _instantiate;

  static ProfileInitial fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ProfileInitial>(map);
  }

  static ProfileInitial fromJson(String json) {
    return ensureInitialized().decodeJson<ProfileInitial>(json);
  }
}

mixin ProfileInitialMappable {
  String toJson() {
    return ProfileInitialMapper.ensureInitialized()
        .encodeJson<ProfileInitial>(this as ProfileInitial);
  }

  Map<String, dynamic> toMap() {
    return ProfileInitialMapper.ensureInitialized()
        .encodeMap<ProfileInitial>(this as ProfileInitial);
  }

  ProfileInitialCopyWith<ProfileInitial, ProfileInitial, ProfileInitial>
      get copyWith =>
          _ProfileInitialCopyWithImpl<ProfileInitial, ProfileInitial>(
              this as ProfileInitial, $identity, $identity);
  @override
  String toString() {
    return ProfileInitialMapper.ensureInitialized()
        .stringifyValue(this as ProfileInitial);
  }

  @override
  bool operator ==(Object other) {
    return ProfileInitialMapper.ensureInitialized()
        .equalsValue(this as ProfileInitial, other);
  }

  @override
  int get hashCode {
    return ProfileInitialMapper.ensureInitialized()
        .hashValue(this as ProfileInitial);
  }
}

extension ProfileInitialValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ProfileInitial, $Out> {
  ProfileInitialCopyWith<$R, ProfileInitial, $Out> get $asProfileInitial =>
      $base.as((v, t, t2) => _ProfileInitialCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class ProfileInitialCopyWith<$R, $In extends ProfileInitial, $Out>
    implements ProfileStateCopyWith<$R, $In, $Out> {
  @override
  $R call();
  ProfileInitialCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _ProfileInitialCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ProfileInitial, $Out>
    implements ProfileInitialCopyWith<$R, ProfileInitial, $Out> {
  _ProfileInitialCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ProfileInitial> $mapper =
      ProfileInitialMapper.ensureInitialized();
  @override
  $R call() => $apply(FieldCopyWithData({}));
  @override
  ProfileInitial $make(CopyWithData data) => ProfileInitial();

  @override
  ProfileInitialCopyWith<$R2, ProfileInitial, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _ProfileInitialCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class ProfileLoadingMapper extends ClassMapperBase<ProfileLoading> {
  ProfileLoadingMapper._();

  static ProfileLoadingMapper? _instance;
  static ProfileLoadingMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ProfileLoadingMapper._());
      ProfileStateMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ProfileLoading';

  @override
  final MappableFields<ProfileLoading> fields = const {};

  static ProfileLoading _instantiate(DecodingData data) {
    return ProfileLoading();
  }

  @override
  final Function instantiate = _instantiate;

  static ProfileLoading fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ProfileLoading>(map);
  }

  static ProfileLoading fromJson(String json) {
    return ensureInitialized().decodeJson<ProfileLoading>(json);
  }
}

mixin ProfileLoadingMappable {
  String toJson() {
    return ProfileLoadingMapper.ensureInitialized()
        .encodeJson<ProfileLoading>(this as ProfileLoading);
  }

  Map<String, dynamic> toMap() {
    return ProfileLoadingMapper.ensureInitialized()
        .encodeMap<ProfileLoading>(this as ProfileLoading);
  }

  ProfileLoadingCopyWith<ProfileLoading, ProfileLoading, ProfileLoading>
      get copyWith =>
          _ProfileLoadingCopyWithImpl<ProfileLoading, ProfileLoading>(
              this as ProfileLoading, $identity, $identity);
  @override
  String toString() {
    return ProfileLoadingMapper.ensureInitialized()
        .stringifyValue(this as ProfileLoading);
  }

  @override
  bool operator ==(Object other) {
    return ProfileLoadingMapper.ensureInitialized()
        .equalsValue(this as ProfileLoading, other);
  }

  @override
  int get hashCode {
    return ProfileLoadingMapper.ensureInitialized()
        .hashValue(this as ProfileLoading);
  }
}

extension ProfileLoadingValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ProfileLoading, $Out> {
  ProfileLoadingCopyWith<$R, ProfileLoading, $Out> get $asProfileLoading =>
      $base.as((v, t, t2) => _ProfileLoadingCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class ProfileLoadingCopyWith<$R, $In extends ProfileLoading, $Out>
    implements ProfileStateCopyWith<$R, $In, $Out> {
  @override
  $R call();
  ProfileLoadingCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _ProfileLoadingCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ProfileLoading, $Out>
    implements ProfileLoadingCopyWith<$R, ProfileLoading, $Out> {
  _ProfileLoadingCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ProfileLoading> $mapper =
      ProfileLoadingMapper.ensureInitialized();
  @override
  $R call() => $apply(FieldCopyWithData({}));
  @override
  ProfileLoading $make(CopyWithData data) => ProfileLoading();

  @override
  ProfileLoadingCopyWith<$R2, ProfileLoading, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _ProfileLoadingCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class ProfileLoadedMapper extends ClassMapperBase<ProfileLoaded> {
  ProfileLoadedMapper._();

  static ProfileLoadedMapper? _instance;
  static ProfileLoadedMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ProfileLoadedMapper._());
      ProfileStateMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ProfileLoaded';

  static UserProfile _$profile(ProfileLoaded v) => v.profile;
  static const Field<ProfileLoaded, UserProfile> _f$profile =
      Field('profile', _$profile);

  @override
  final MappableFields<ProfileLoaded> fields = const {
    #profile: _f$profile,
  };

  static ProfileLoaded _instantiate(DecodingData data) {
    return ProfileLoaded(data.dec(_f$profile));
  }

  @override
  final Function instantiate = _instantiate;

  static ProfileLoaded fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ProfileLoaded>(map);
  }

  static ProfileLoaded fromJson(String json) {
    return ensureInitialized().decodeJson<ProfileLoaded>(json);
  }
}

mixin ProfileLoadedMappable {
  String toJson() {
    return ProfileLoadedMapper.ensureInitialized()
        .encodeJson<ProfileLoaded>(this as ProfileLoaded);
  }

  Map<String, dynamic> toMap() {
    return ProfileLoadedMapper.ensureInitialized()
        .encodeMap<ProfileLoaded>(this as ProfileLoaded);
  }

  ProfileLoadedCopyWith<ProfileLoaded, ProfileLoaded, ProfileLoaded>
      get copyWith => _ProfileLoadedCopyWithImpl<ProfileLoaded, ProfileLoaded>(
          this as ProfileLoaded, $identity, $identity);
  @override
  String toString() {
    return ProfileLoadedMapper.ensureInitialized()
        .stringifyValue(this as ProfileLoaded);
  }

  @override
  bool operator ==(Object other) {
    return ProfileLoadedMapper.ensureInitialized()
        .equalsValue(this as ProfileLoaded, other);
  }

  @override
  int get hashCode {
    return ProfileLoadedMapper.ensureInitialized()
        .hashValue(this as ProfileLoaded);
  }
}

extension ProfileLoadedValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ProfileLoaded, $Out> {
  ProfileLoadedCopyWith<$R, ProfileLoaded, $Out> get $asProfileLoaded =>
      $base.as((v, t, t2) => _ProfileLoadedCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class ProfileLoadedCopyWith<$R, $In extends ProfileLoaded, $Out>
    implements ProfileStateCopyWith<$R, $In, $Out> {
  @override
  $R call({UserProfile? profile});
  ProfileLoadedCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _ProfileLoadedCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ProfileLoaded, $Out>
    implements ProfileLoadedCopyWith<$R, ProfileLoaded, $Out> {
  _ProfileLoadedCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ProfileLoaded> $mapper =
      ProfileLoadedMapper.ensureInitialized();
  @override
  $R call({UserProfile? profile}) =>
      $apply(FieldCopyWithData({if (profile != null) #profile: profile}));
  @override
  ProfileLoaded $make(CopyWithData data) =>
      ProfileLoaded(data.get(#profile, or: $value.profile));

  @override
  ProfileLoadedCopyWith<$R2, ProfileLoaded, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _ProfileLoadedCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class ProfileErrorMapper extends ClassMapperBase<ProfileError> {
  ProfileErrorMapper._();

  static ProfileErrorMapper? _instance;
  static ProfileErrorMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ProfileErrorMapper._());
      ProfileStateMapper.ensureInitialized();
      ErrorModelMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ProfileError';

  static ErrorModel _$error(ProfileError v) => v.error;
  static const Field<ProfileError, ErrorModel> _f$error =
      Field('error', _$error);

  @override
  final MappableFields<ProfileError> fields = const {
    #error: _f$error,
  };

  static ProfileError _instantiate(DecodingData data) {
    return ProfileError(data.dec(_f$error));
  }

  @override
  final Function instantiate = _instantiate;

  static ProfileError fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ProfileError>(map);
  }

  static ProfileError fromJson(String json) {
    return ensureInitialized().decodeJson<ProfileError>(json);
  }
}

mixin ProfileErrorMappable {
  String toJson() {
    return ProfileErrorMapper.ensureInitialized()
        .encodeJson<ProfileError>(this as ProfileError);
  }

  Map<String, dynamic> toMap() {
    return ProfileErrorMapper.ensureInitialized()
        .encodeMap<ProfileError>(this as ProfileError);
  }

  ProfileErrorCopyWith<ProfileError, ProfileError, ProfileError> get copyWith =>
      _ProfileErrorCopyWithImpl<ProfileError, ProfileError>(
          this as ProfileError, $identity, $identity);
  @override
  String toString() {
    return ProfileErrorMapper.ensureInitialized()
        .stringifyValue(this as ProfileError);
  }

  @override
  bool operator ==(Object other) {
    return ProfileErrorMapper.ensureInitialized()
        .equalsValue(this as ProfileError, other);
  }

  @override
  int get hashCode {
    return ProfileErrorMapper.ensureInitialized()
        .hashValue(this as ProfileError);
  }
}

extension ProfileErrorValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ProfileError, $Out> {
  ProfileErrorCopyWith<$R, ProfileError, $Out> get $asProfileError =>
      $base.as((v, t, t2) => _ProfileErrorCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class ProfileErrorCopyWith<$R, $In extends ProfileError, $Out>
    implements ProfileStateCopyWith<$R, $In, $Out> {
  ErrorModelCopyWith<$R, ErrorModel, ErrorModel> get error;
  @override
  $R call({ErrorModel? error});
  ProfileErrorCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _ProfileErrorCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ProfileError, $Out>
    implements ProfileErrorCopyWith<$R, ProfileError, $Out> {
  _ProfileErrorCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ProfileError> $mapper =
      ProfileErrorMapper.ensureInitialized();
  @override
  ErrorModelCopyWith<$R, ErrorModel, ErrorModel> get error =>
      $value.error.copyWith.$chain((v) => call(error: v));
  @override
  $R call({ErrorModel? error}) =>
      $apply(FieldCopyWithData({if (error != null) #error: error}));
  @override
  ProfileError $make(CopyWithData data) =>
      ProfileError(data.get(#error, or: $value.error));

  @override
  ProfileErrorCopyWith<$R2, ProfileError, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _ProfileErrorCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
