// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'check_user_exists_request_model.dart';

class CheckUserExistsRequestModelMapper
    extends ClassMapperBase<CheckUserExistsRequestModel> {
  CheckUserExistsRequestModelMapper._();

  static CheckUserExistsRequestModelMapper? _instance;
  static CheckUserExistsRequestModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals
          .use(_instance = CheckUserExistsRequestModelMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'CheckUserExistsRequestModel';

  static String _$email(CheckUserExistsRequestModel v) => v.email;
  static const Field<CheckUserExistsRequestModel, String> _f$email =
      Field('email', _$email);

  @override
  final MappableFields<CheckUserExistsRequestModel> fields = const {
    #email: _f$email,
  };

  static CheckUserExistsRequestModel _instantiate(DecodingData data) {
    return CheckUserExistsRequestModel(email: data.dec(_f$email));
  }

  @override
  final Function instantiate = _instantiate;

  static CheckUserExistsRequestModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<CheckUserExistsRequestModel>(map);
  }

  static CheckUserExistsRequestModel fromJson(String json) {
    return ensureInitialized().decodeJson<CheckUserExistsRequestModel>(json);
  }
}

mixin CheckUserExistsRequestModelMappable {
  String toJson() {
    return CheckUserExistsRequestModelMapper.ensureInitialized()
        .encodeJson<CheckUserExistsRequestModel>(
            this as CheckUserExistsRequestModel);
  }

  Map<String, dynamic> toMap() {
    return CheckUserExistsRequestModelMapper.ensureInitialized()
        .encodeMap<CheckUserExistsRequestModel>(
            this as CheckUserExistsRequestModel);
  }

  CheckUserExistsRequestModelCopyWith<CheckUserExistsRequestModel,
          CheckUserExistsRequestModel, CheckUserExistsRequestModel>
      get copyWith => _CheckUserExistsRequestModelCopyWithImpl<
              CheckUserExistsRequestModel, CheckUserExistsRequestModel>(
          this as CheckUserExistsRequestModel, $identity, $identity);
  @override
  String toString() {
    return CheckUserExistsRequestModelMapper.ensureInitialized()
        .stringifyValue(this as CheckUserExistsRequestModel);
  }

  @override
  bool operator ==(Object other) {
    return CheckUserExistsRequestModelMapper.ensureInitialized()
        .equalsValue(this as CheckUserExistsRequestModel, other);
  }

  @override
  int get hashCode {
    return CheckUserExistsRequestModelMapper.ensureInitialized()
        .hashValue(this as CheckUserExistsRequestModel);
  }
}

extension CheckUserExistsRequestModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, CheckUserExistsRequestModel, $Out> {
  CheckUserExistsRequestModelCopyWith<$R, CheckUserExistsRequestModel, $Out>
      get $asCheckUserExistsRequestModel => $base.as((v, t, t2) =>
          _CheckUserExistsRequestModelCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class CheckUserExistsRequestModelCopyWith<
    $R,
    $In extends CheckUserExistsRequestModel,
    $Out> implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? email});
  CheckUserExistsRequestModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _CheckUserExistsRequestModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, CheckUserExistsRequestModel, $Out>
    implements
        CheckUserExistsRequestModelCopyWith<$R, CheckUserExistsRequestModel,
            $Out> {
  _CheckUserExistsRequestModelCopyWithImpl(
      super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<CheckUserExistsRequestModel> $mapper =
      CheckUserExistsRequestModelMapper.ensureInitialized();
  @override
  $R call({String? email}) =>
      $apply(FieldCopyWithData({if (email != null) #email: email}));
  @override
  CheckUserExistsRequestModel $make(CopyWithData data) =>
      CheckUserExistsRequestModel(email: data.get(#email, or: $value.email));

  @override
  CheckUserExistsRequestModelCopyWith<$R2, CheckUserExistsRequestModel, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _CheckUserExistsRequestModelCopyWithImpl<$R2, $Out2>(
              $value, $cast, t);
}
