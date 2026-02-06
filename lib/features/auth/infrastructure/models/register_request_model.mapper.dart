// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'register_request_model.dart';

class RegisterRequestModelMapper extends ClassMapperBase<RegisterRequestModel> {
  RegisterRequestModelMapper._();

  static RegisterRequestModelMapper? _instance;
  static RegisterRequestModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = RegisterRequestModelMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'RegisterRequestModel';

  static String _$email(RegisterRequestModel v) => v.email;
  static const Field<RegisterRequestModel, String> _f$email = Field(
    'email',
    _$email,
  );
  static String _$password(RegisterRequestModel v) => v.password;
  static const Field<RegisterRequestModel, String> _f$password = Field(
    'password',
    _$password,
  );
  static String _$name(RegisterRequestModel v) => v.name;
  static const Field<RegisterRequestModel, String> _f$name = Field(
    'name',
    _$name,
  );

  @override
  final MappableFields<RegisterRequestModel> fields = const {
    #email: _f$email,
    #password: _f$password,
    #name: _f$name,
  };

  static RegisterRequestModel _instantiate(DecodingData data) {
    return RegisterRequestModel(
      email: data.dec(_f$email),
      password: data.dec(_f$password),
      name: data.dec(_f$name),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static RegisterRequestModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<RegisterRequestModel>(map);
  }

  static RegisterRequestModel fromJson(String json) {
    return ensureInitialized().decodeJson<RegisterRequestModel>(json);
  }
}

mixin RegisterRequestModelMappable {
  String toJson() {
    return RegisterRequestModelMapper.ensureInitialized()
        .encodeJson<RegisterRequestModel>(this as RegisterRequestModel);
  }

  Map<String, dynamic> toMap() {
    return RegisterRequestModelMapper.ensureInitialized()
        .encodeMap<RegisterRequestModel>(this as RegisterRequestModel);
  }

  RegisterRequestModelCopyWith<
    RegisterRequestModel,
    RegisterRequestModel,
    RegisterRequestModel
  >
  get copyWith =>
      _RegisterRequestModelCopyWithImpl<
        RegisterRequestModel,
        RegisterRequestModel
      >(this as RegisterRequestModel, $identity, $identity);
  @override
  String toString() {
    return RegisterRequestModelMapper.ensureInitialized().stringifyValue(
      this as RegisterRequestModel,
    );
  }

  @override
  bool operator ==(Object other) {
    return RegisterRequestModelMapper.ensureInitialized().equalsValue(
      this as RegisterRequestModel,
      other,
    );
  }

  @override
  int get hashCode {
    return RegisterRequestModelMapper.ensureInitialized().hashValue(
      this as RegisterRequestModel,
    );
  }
}

extension RegisterRequestModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, RegisterRequestModel, $Out> {
  RegisterRequestModelCopyWith<$R, RegisterRequestModel, $Out>
  get $asRegisterRequestModel => $base.as(
    (v, t, t2) => _RegisterRequestModelCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class RegisterRequestModelCopyWith<
  $R,
  $In extends RegisterRequestModel,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? email, String? password, String? name});
  RegisterRequestModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _RegisterRequestModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, RegisterRequestModel, $Out>
    implements RegisterRequestModelCopyWith<$R, RegisterRequestModel, $Out> {
  _RegisterRequestModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<RegisterRequestModel> $mapper =
      RegisterRequestModelMapper.ensureInitialized();
  @override
  $R call({String? email, String? password, String? name}) => $apply(
    FieldCopyWithData({
      if (email != null) #email: email,
      if (password != null) #password: password,
      if (name != null) #name: name,
    }),
  );
  @override
  RegisterRequestModel $make(CopyWithData data) => RegisterRequestModel(
    email: data.get(#email, or: $value.email),
    password: data.get(#password, or: $value.password),
    name: data.get(#name, or: $value.name),
  );

  @override
  RegisterRequestModelCopyWith<$R2, RegisterRequestModel, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _RegisterRequestModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

