// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'login_request_model.dart';

class LoginRequestModelMapper extends ClassMapperBase<LoginRequestModel> {
  LoginRequestModelMapper._();

  static LoginRequestModelMapper? _instance;
  static LoginRequestModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = LoginRequestModelMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'LoginRequestModel';

  static String _$email(LoginRequestModel v) => v.email;
  static const Field<LoginRequestModel, String> _f$email =
      Field('email', _$email);
  static String _$password(LoginRequestModel v) => v.password;
  static const Field<LoginRequestModel, String> _f$password =
      Field('password', _$password);

  @override
  final MappableFields<LoginRequestModel> fields = const {
    #email: _f$email,
    #password: _f$password,
  };

  static LoginRequestModel _instantiate(DecodingData data) {
    return LoginRequestModel(
        email: data.dec(_f$email), password: data.dec(_f$password));
  }

  @override
  final Function instantiate = _instantiate;

  static LoginRequestModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<LoginRequestModel>(map);
  }

  static LoginRequestModel fromJson(String json) {
    return ensureInitialized().decodeJson<LoginRequestModel>(json);
  }
}

mixin LoginRequestModelMappable {
  String toJson() {
    return LoginRequestModelMapper.ensureInitialized()
        .encodeJson<LoginRequestModel>(this as LoginRequestModel);
  }

  Map<String, dynamic> toMap() {
    return LoginRequestModelMapper.ensureInitialized()
        .encodeMap<LoginRequestModel>(this as LoginRequestModel);
  }

  LoginRequestModelCopyWith<LoginRequestModel, LoginRequestModel,
          LoginRequestModel>
      get copyWith =>
          _LoginRequestModelCopyWithImpl<LoginRequestModel, LoginRequestModel>(
              this as LoginRequestModel, $identity, $identity);
  @override
  String toString() {
    return LoginRequestModelMapper.ensureInitialized()
        .stringifyValue(this as LoginRequestModel);
  }

  @override
  bool operator ==(Object other) {
    return LoginRequestModelMapper.ensureInitialized()
        .equalsValue(this as LoginRequestModel, other);
  }

  @override
  int get hashCode {
    return LoginRequestModelMapper.ensureInitialized()
        .hashValue(this as LoginRequestModel);
  }
}

extension LoginRequestModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, LoginRequestModel, $Out> {
  LoginRequestModelCopyWith<$R, LoginRequestModel, $Out>
      get $asLoginRequestModel => $base
          .as((v, t, t2) => _LoginRequestModelCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class LoginRequestModelCopyWith<$R, $In extends LoginRequestModel,
    $Out> implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? email, String? password});
  LoginRequestModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _LoginRequestModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, LoginRequestModel, $Out>
    implements LoginRequestModelCopyWith<$R, LoginRequestModel, $Out> {
  _LoginRequestModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<LoginRequestModel> $mapper =
      LoginRequestModelMapper.ensureInitialized();
  @override
  $R call({String? email, String? password}) => $apply(FieldCopyWithData({
        if (email != null) #email: email,
        if (password != null) #password: password
      }));
  @override
  LoginRequestModel $make(CopyWithData data) => LoginRequestModel(
      email: data.get(#email, or: $value.email),
      password: data.get(#password, or: $value.password));

  @override
  LoginRequestModelCopyWith<$R2, LoginRequestModel, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _LoginRequestModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
