// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'error_model.dart';

class ErrorModelMapper extends ClassMapperBase<ErrorModel> {
  ErrorModelMapper._();

  static ErrorModelMapper? _instance;
  static ErrorModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ErrorModelMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'ErrorModel';

  static Failure _$failure(ErrorModel v) => v.failure;
  static const Field<ErrorModel, Failure> _f$failure =
      Field('failure', _$failure);
  static bool _$isRetryable(ErrorModel v) => v.isRetryable;
  static const Field<ErrorModel, bool> _f$isRetryable =
      Field('isRetryable', _$isRetryable);

  @override
  final MappableFields<ErrorModel> fields = const {
    #failure: _f$failure,
    #isRetryable: _f$isRetryable,
  };

  static ErrorModel _instantiate(DecodingData data) {
    return ErrorModel(
        failure: data.dec(_f$failure), isRetryable: data.dec(_f$isRetryable));
  }

  @override
  final Function instantiate = _instantiate;

  static ErrorModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ErrorModel>(map);
  }

  static ErrorModel fromJson(String json) {
    return ensureInitialized().decodeJson<ErrorModel>(json);
  }
}

mixin ErrorModelMappable {
  String toJson() {
    return ErrorModelMapper.ensureInitialized()
        .encodeJson<ErrorModel>(this as ErrorModel);
  }

  Map<String, dynamic> toMap() {
    return ErrorModelMapper.ensureInitialized()
        .encodeMap<ErrorModel>(this as ErrorModel);
  }

  ErrorModelCopyWith<ErrorModel, ErrorModel, ErrorModel> get copyWith =>
      _ErrorModelCopyWithImpl<ErrorModel, ErrorModel>(
          this as ErrorModel, $identity, $identity);
  @override
  String toString() {
    return ErrorModelMapper.ensureInitialized()
        .stringifyValue(this as ErrorModel);
  }

  @override
  bool operator ==(Object other) {
    return ErrorModelMapper.ensureInitialized()
        .equalsValue(this as ErrorModel, other);
  }

  @override
  int get hashCode {
    return ErrorModelMapper.ensureInitialized().hashValue(this as ErrorModel);
  }
}

extension ErrorModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ErrorModel, $Out> {
  ErrorModelCopyWith<$R, ErrorModel, $Out> get $asErrorModel =>
      $base.as((v, t, t2) => _ErrorModelCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class ErrorModelCopyWith<$R, $In extends ErrorModel, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({Failure? failure, bool? isRetryable});
  ErrorModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _ErrorModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ErrorModel, $Out>
    implements ErrorModelCopyWith<$R, ErrorModel, $Out> {
  _ErrorModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ErrorModel> $mapper =
      ErrorModelMapper.ensureInitialized();
  @override
  $R call({Failure? failure, bool? isRetryable}) => $apply(FieldCopyWithData({
        if (failure != null) #failure: failure,
        if (isRetryable != null) #isRetryable: isRetryable
      }));
  @override
  ErrorModel $make(CopyWithData data) => ErrorModel(
      failure: data.get(#failure, or: $value.failure),
      isRetryable: data.get(#isRetryable, or: $value.isRetryable));

  @override
  ErrorModelCopyWith<$R2, ErrorModel, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _ErrorModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
