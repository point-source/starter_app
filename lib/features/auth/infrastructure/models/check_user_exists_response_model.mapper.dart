// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'check_user_exists_response_model.dart';

class CheckUserExistsResponseModelMapper
    extends ClassMapperBase<CheckUserExistsResponseModel> {
  CheckUserExistsResponseModelMapper._();

  static CheckUserExistsResponseModelMapper? _instance;
  static CheckUserExistsResponseModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(
        _instance = CheckUserExistsResponseModelMapper._(),
      );
    }
    return _instance!;
  }

  @override
  final String id = 'CheckUserExistsResponseModel';

  static bool _$exists(CheckUserExistsResponseModel v) => v.exists;
  static const Field<CheckUserExistsResponseModel, bool> _f$exists = Field(
    'exists',
    _$exists,
  );

  @override
  final MappableFields<CheckUserExistsResponseModel> fields = const {
    #exists: _f$exists,
  };

  static CheckUserExistsResponseModel _instantiate(DecodingData data) {
    return CheckUserExistsResponseModel(exists: data.dec(_f$exists));
  }

  @override
  final Function instantiate = _instantiate;

  static CheckUserExistsResponseModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<CheckUserExistsResponseModel>(map);
  }

  static CheckUserExistsResponseModel fromJson(String json) {
    return ensureInitialized().decodeJson<CheckUserExistsResponseModel>(json);
  }
}

mixin CheckUserExistsResponseModelMappable {
  String toJson() {
    return CheckUserExistsResponseModelMapper.ensureInitialized()
        .encodeJson<CheckUserExistsResponseModel>(
          this as CheckUserExistsResponseModel,
        );
  }

  Map<String, dynamic> toMap() {
    return CheckUserExistsResponseModelMapper.ensureInitialized()
        .encodeMap<CheckUserExistsResponseModel>(
          this as CheckUserExistsResponseModel,
        );
  }

  CheckUserExistsResponseModelCopyWith<
    CheckUserExistsResponseModel,
    CheckUserExistsResponseModel,
    CheckUserExistsResponseModel
  >
  get copyWith =>
      _CheckUserExistsResponseModelCopyWithImpl<
        CheckUserExistsResponseModel,
        CheckUserExistsResponseModel
      >(this as CheckUserExistsResponseModel, $identity, $identity);
  @override
  String toString() {
    return CheckUserExistsResponseModelMapper.ensureInitialized()
        .stringifyValue(this as CheckUserExistsResponseModel);
  }

  @override
  bool operator ==(Object other) {
    return CheckUserExistsResponseModelMapper.ensureInitialized().equalsValue(
      this as CheckUserExistsResponseModel,
      other,
    );
  }

  @override
  int get hashCode {
    return CheckUserExistsResponseModelMapper.ensureInitialized().hashValue(
      this as CheckUserExistsResponseModel,
    );
  }
}

extension CheckUserExistsResponseModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, CheckUserExistsResponseModel, $Out> {
  CheckUserExistsResponseModelCopyWith<$R, CheckUserExistsResponseModel, $Out>
  get $asCheckUserExistsResponseModel => $base.as(
    (v, t, t2) => _CheckUserExistsResponseModelCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class CheckUserExistsResponseModelCopyWith<
  $R,
  $In extends CheckUserExistsResponseModel,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({bool? exists});
  CheckUserExistsResponseModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _CheckUserExistsResponseModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, CheckUserExistsResponseModel, $Out>
    implements
        CheckUserExistsResponseModelCopyWith<
          $R,
          CheckUserExistsResponseModel,
          $Out
        > {
  _CheckUserExistsResponseModelCopyWithImpl(
    super.value,
    super.then,
    super.then2,
  );

  @override
  late final ClassMapperBase<CheckUserExistsResponseModel> $mapper =
      CheckUserExistsResponseModelMapper.ensureInitialized();
  @override
  $R call({bool? exists}) =>
      $apply(FieldCopyWithData({if (exists != null) #exists: exists}));
  @override
  CheckUserExistsResponseModel $make(CopyWithData data) =>
      CheckUserExistsResponseModel(
        exists: data.get(#exists, or: $value.exists),
      );

  @override
  CheckUserExistsResponseModelCopyWith<$R2, CheckUserExistsResponseModel, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _CheckUserExistsResponseModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

