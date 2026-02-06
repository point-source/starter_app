// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'auth_response_model.dart';

class AuthResponseModelMapper extends ClassMapperBase<AuthResponseModel> {
  AuthResponseModelMapper._();

  static AuthResponseModelMapper? _instance;
  static AuthResponseModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AuthResponseModelMapper._());
      UserModelMapper.ensureInitialized();
      AuthTokensModelMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'AuthResponseModel';

  static UserModel _$user(AuthResponseModel v) => v.user;
  static const Field<AuthResponseModel, UserModel> _f$user =
      Field('user', _$user);
  static AuthTokensModel _$tokens(AuthResponseModel v) => v.tokens;
  static const Field<AuthResponseModel, AuthTokensModel> _f$tokens =
      Field('tokens', _$tokens);

  @override
  final MappableFields<AuthResponseModel> fields = const {
    #user: _f$user,
    #tokens: _f$tokens,
  };

  static AuthResponseModel _instantiate(DecodingData data) {
    return AuthResponseModel(
        user: data.dec(_f$user), tokens: data.dec(_f$tokens));
  }

  @override
  final Function instantiate = _instantiate;

  static AuthResponseModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<AuthResponseModel>(map);
  }

  static AuthResponseModel fromJson(String json) {
    return ensureInitialized().decodeJson<AuthResponseModel>(json);
  }
}

mixin AuthResponseModelMappable {
  String toJson() {
    return AuthResponseModelMapper.ensureInitialized()
        .encodeJson<AuthResponseModel>(this as AuthResponseModel);
  }

  Map<String, dynamic> toMap() {
    return AuthResponseModelMapper.ensureInitialized()
        .encodeMap<AuthResponseModel>(this as AuthResponseModel);
  }

  AuthResponseModelCopyWith<AuthResponseModel, AuthResponseModel,
          AuthResponseModel>
      get copyWith =>
          _AuthResponseModelCopyWithImpl<AuthResponseModel, AuthResponseModel>(
              this as AuthResponseModel, $identity, $identity);
  @override
  String toString() {
    return AuthResponseModelMapper.ensureInitialized()
        .stringifyValue(this as AuthResponseModel);
  }

  @override
  bool operator ==(Object other) {
    return AuthResponseModelMapper.ensureInitialized()
        .equalsValue(this as AuthResponseModel, other);
  }

  @override
  int get hashCode {
    return AuthResponseModelMapper.ensureInitialized()
        .hashValue(this as AuthResponseModel);
  }
}

extension AuthResponseModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, AuthResponseModel, $Out> {
  AuthResponseModelCopyWith<$R, AuthResponseModel, $Out>
      get $asAuthResponseModel => $base
          .as((v, t, t2) => _AuthResponseModelCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class AuthResponseModelCopyWith<$R, $In extends AuthResponseModel,
    $Out> implements ClassCopyWith<$R, $In, $Out> {
  UserModelCopyWith<$R, UserModel, UserModel> get user;
  AuthTokensModelCopyWith<$R, AuthTokensModel, AuthTokensModel> get tokens;
  $R call({UserModel? user, AuthTokensModel? tokens});
  AuthResponseModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _AuthResponseModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, AuthResponseModel, $Out>
    implements AuthResponseModelCopyWith<$R, AuthResponseModel, $Out> {
  _AuthResponseModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<AuthResponseModel> $mapper =
      AuthResponseModelMapper.ensureInitialized();
  @override
  UserModelCopyWith<$R, UserModel, UserModel> get user =>
      $value.user.copyWith.$chain((v) => call(user: v));
  @override
  AuthTokensModelCopyWith<$R, AuthTokensModel, AuthTokensModel> get tokens =>
      $value.tokens.copyWith.$chain((v) => call(tokens: v));
  @override
  $R call({UserModel? user, AuthTokensModel? tokens}) =>
      $apply(FieldCopyWithData({
        if (user != null) #user: user,
        if (tokens != null) #tokens: tokens
      }));
  @override
  AuthResponseModel $make(CopyWithData data) => AuthResponseModel(
      user: data.get(#user, or: $value.user),
      tokens: data.get(#tokens, or: $value.tokens));

  @override
  AuthResponseModelCopyWith<$R2, AuthResponseModel, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _AuthResponseModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
