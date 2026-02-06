// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'auth_tokens_model.dart';

class AuthTokensModelMapper extends ClassMapperBase<AuthTokensModel> {
  AuthTokensModelMapper._();

  static AuthTokensModelMapper? _instance;
  static AuthTokensModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AuthTokensModelMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'AuthTokensModel';

  static String _$accessToken(AuthTokensModel v) => v.accessToken;
  static const Field<AuthTokensModel, String> _f$accessToken =
      Field('accessToken', _$accessToken);
  static String _$refreshToken(AuthTokensModel v) => v.refreshToken;
  static const Field<AuthTokensModel, String> _f$refreshToken =
      Field('refreshToken', _$refreshToken);

  @override
  final MappableFields<AuthTokensModel> fields = const {
    #accessToken: _f$accessToken,
    #refreshToken: _f$refreshToken,
  };

  static AuthTokensModel _instantiate(DecodingData data) {
    return AuthTokensModel(
        accessToken: data.dec(_f$accessToken),
        refreshToken: data.dec(_f$refreshToken));
  }

  @override
  final Function instantiate = _instantiate;

  static AuthTokensModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<AuthTokensModel>(map);
  }

  static AuthTokensModel fromJson(String json) {
    return ensureInitialized().decodeJson<AuthTokensModel>(json);
  }
}

mixin AuthTokensModelMappable {
  String toJson() {
    return AuthTokensModelMapper.ensureInitialized()
        .encodeJson<AuthTokensModel>(this as AuthTokensModel);
  }

  Map<String, dynamic> toMap() {
    return AuthTokensModelMapper.ensureInitialized()
        .encodeMap<AuthTokensModel>(this as AuthTokensModel);
  }

  AuthTokensModelCopyWith<AuthTokensModel, AuthTokensModel, AuthTokensModel>
      get copyWith =>
          _AuthTokensModelCopyWithImpl<AuthTokensModel, AuthTokensModel>(
              this as AuthTokensModel, $identity, $identity);
  @override
  String toString() {
    return AuthTokensModelMapper.ensureInitialized()
        .stringifyValue(this as AuthTokensModel);
  }

  @override
  bool operator ==(Object other) {
    return AuthTokensModelMapper.ensureInitialized()
        .equalsValue(this as AuthTokensModel, other);
  }

  @override
  int get hashCode {
    return AuthTokensModelMapper.ensureInitialized()
        .hashValue(this as AuthTokensModel);
  }
}

extension AuthTokensModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, AuthTokensModel, $Out> {
  AuthTokensModelCopyWith<$R, AuthTokensModel, $Out> get $asAuthTokensModel =>
      $base.as((v, t, t2) => _AuthTokensModelCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class AuthTokensModelCopyWith<$R, $In extends AuthTokensModel, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? accessToken, String? refreshToken});
  AuthTokensModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _AuthTokensModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, AuthTokensModel, $Out>
    implements AuthTokensModelCopyWith<$R, AuthTokensModel, $Out> {
  _AuthTokensModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<AuthTokensModel> $mapper =
      AuthTokensModelMapper.ensureInitialized();
  @override
  $R call({String? accessToken, String? refreshToken}) =>
      $apply(FieldCopyWithData({
        if (accessToken != null) #accessToken: accessToken,
        if (refreshToken != null) #refreshToken: refreshToken
      }));
  @override
  AuthTokensModel $make(CopyWithData data) => AuthTokensModel(
      accessToken: data.get(#accessToken, or: $value.accessToken),
      refreshToken: data.get(#refreshToken, or: $value.refreshToken));

  @override
  AuthTokensModelCopyWith<$R2, AuthTokensModel, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _AuthTokensModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
