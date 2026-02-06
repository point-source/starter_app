// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'user_profile_model.dart';

class UserProfileModelMapper extends ClassMapperBase<UserProfileModel> {
  UserProfileModelMapper._();

  static UserProfileModelMapper? _instance;
  static UserProfileModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = UserProfileModelMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'UserProfileModel';

  static String _$id(UserProfileModel v) => v.id;
  static const Field<UserProfileModel, String> _f$id = Field('id', _$id);
  static String _$userId(UserProfileModel v) => v.userId;
  static const Field<UserProfileModel, String> _f$userId =
      Field('userId', _$userId);
  static String _$displayName(UserProfileModel v) => v.displayName;
  static const Field<UserProfileModel, String> _f$displayName =
      Field('displayName', _$displayName);
  static String? _$avatarUrl(UserProfileModel v) => v.avatarUrl;
  static const Field<UserProfileModel, String> _f$avatarUrl =
      Field('avatarUrl', _$avatarUrl, opt: true);

  @override
  final MappableFields<UserProfileModel> fields = const {
    #id: _f$id,
    #userId: _f$userId,
    #displayName: _f$displayName,
    #avatarUrl: _f$avatarUrl,
  };

  static UserProfileModel _instantiate(DecodingData data) {
    return UserProfileModel(
        id: data.dec(_f$id),
        userId: data.dec(_f$userId),
        displayName: data.dec(_f$displayName),
        avatarUrl: data.dec(_f$avatarUrl));
  }

  @override
  final Function instantiate = _instantiate;

  static UserProfileModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<UserProfileModel>(map);
  }

  static UserProfileModel fromJson(String json) {
    return ensureInitialized().decodeJson<UserProfileModel>(json);
  }
}

mixin UserProfileModelMappable {
  String toJson() {
    return UserProfileModelMapper.ensureInitialized()
        .encodeJson<UserProfileModel>(this as UserProfileModel);
  }

  Map<String, dynamic> toMap() {
    return UserProfileModelMapper.ensureInitialized()
        .encodeMap<UserProfileModel>(this as UserProfileModel);
  }

  UserProfileModelCopyWith<UserProfileModel, UserProfileModel, UserProfileModel>
      get copyWith =>
          _UserProfileModelCopyWithImpl<UserProfileModel, UserProfileModel>(
              this as UserProfileModel, $identity, $identity);
  @override
  String toString() {
    return UserProfileModelMapper.ensureInitialized()
        .stringifyValue(this as UserProfileModel);
  }

  @override
  bool operator ==(Object other) {
    return UserProfileModelMapper.ensureInitialized()
        .equalsValue(this as UserProfileModel, other);
  }

  @override
  int get hashCode {
    return UserProfileModelMapper.ensureInitialized()
        .hashValue(this as UserProfileModel);
  }
}

extension UserProfileModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, UserProfileModel, $Out> {
  UserProfileModelCopyWith<$R, UserProfileModel, $Out>
      get $asUserProfileModel => $base
          .as((v, t, t2) => _UserProfileModelCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class UserProfileModelCopyWith<$R, $In extends UserProfileModel, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? id, String? userId, String? displayName, String? avatarUrl});
  UserProfileModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _UserProfileModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, UserProfileModel, $Out>
    implements UserProfileModelCopyWith<$R, UserProfileModel, $Out> {
  _UserProfileModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<UserProfileModel> $mapper =
      UserProfileModelMapper.ensureInitialized();
  @override
  $R call(
          {String? id,
          String? userId,
          String? displayName,
          Object? avatarUrl = $none}) =>
      $apply(FieldCopyWithData({
        if (id != null) #id: id,
        if (userId != null) #userId: userId,
        if (displayName != null) #displayName: displayName,
        if (avatarUrl != $none) #avatarUrl: avatarUrl
      }));
  @override
  UserProfileModel $make(CopyWithData data) => UserProfileModel(
      id: data.get(#id, or: $value.id),
      userId: data.get(#userId, or: $value.userId),
      displayName: data.get(#displayName, or: $value.displayName),
      avatarUrl: data.get(#avatarUrl, or: $value.avatarUrl));

  @override
  UserProfileModelCopyWith<$R2, UserProfileModel, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _UserProfileModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
