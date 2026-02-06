// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'field_validation_state.dart';

class FieldValidationStateMapper extends ClassMapperBase<FieldValidationState> {
  FieldValidationStateMapper._();

  static FieldValidationStateMapper? _instance;
  static FieldValidationStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = FieldValidationStateMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'FieldValidationState';

  static bool _$emailTouched(FieldValidationState v) => v.emailTouched;
  static const Field<FieldValidationState, bool> _f$emailTouched =
      Field('emailTouched', _$emailTouched, opt: true, def: false);
  static bool _$passwordTouched(FieldValidationState v) => v.passwordTouched;
  static const Field<FieldValidationState, bool> _f$passwordTouched =
      Field('passwordTouched', _$passwordTouched, opt: true, def: false);
  static bool _$nameTouched(FieldValidationState v) => v.nameTouched;
  static const Field<FieldValidationState, bool> _f$nameTouched =
      Field('nameTouched', _$nameTouched, opt: true, def: false);

  @override
  final MappableFields<FieldValidationState> fields = const {
    #emailTouched: _f$emailTouched,
    #passwordTouched: _f$passwordTouched,
    #nameTouched: _f$nameTouched,
  };

  static FieldValidationState _instantiate(DecodingData data) {
    return FieldValidationState(
        emailTouched: data.dec(_f$emailTouched),
        passwordTouched: data.dec(_f$passwordTouched),
        nameTouched: data.dec(_f$nameTouched));
  }

  @override
  final Function instantiate = _instantiate;

  static FieldValidationState fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<FieldValidationState>(map);
  }

  static FieldValidationState fromJson(String json) {
    return ensureInitialized().decodeJson<FieldValidationState>(json);
  }
}

mixin FieldValidationStateMappable {
  String toJson() {
    return FieldValidationStateMapper.ensureInitialized()
        .encodeJson<FieldValidationState>(this as FieldValidationState);
  }

  Map<String, dynamic> toMap() {
    return FieldValidationStateMapper.ensureInitialized()
        .encodeMap<FieldValidationState>(this as FieldValidationState);
  }

  FieldValidationStateCopyWith<FieldValidationState, FieldValidationState,
      FieldValidationState> get copyWith => _FieldValidationStateCopyWithImpl<
          FieldValidationState, FieldValidationState>(
      this as FieldValidationState, $identity, $identity);
  @override
  String toString() {
    return FieldValidationStateMapper.ensureInitialized()
        .stringifyValue(this as FieldValidationState);
  }

  @override
  bool operator ==(Object other) {
    return FieldValidationStateMapper.ensureInitialized()
        .equalsValue(this as FieldValidationState, other);
  }

  @override
  int get hashCode {
    return FieldValidationStateMapper.ensureInitialized()
        .hashValue(this as FieldValidationState);
  }
}

extension FieldValidationStateValueCopy<$R, $Out>
    on ObjectCopyWith<$R, FieldValidationState, $Out> {
  FieldValidationStateCopyWith<$R, FieldValidationState, $Out>
      get $asFieldValidationState => $base.as(
          (v, t, t2) => _FieldValidationStateCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class FieldValidationStateCopyWith<
    $R,
    $In extends FieldValidationState,
    $Out> implements ClassCopyWith<$R, $In, $Out> {
  $R call({bool? emailTouched, bool? passwordTouched, bool? nameTouched});
  FieldValidationStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _FieldValidationStateCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, FieldValidationState, $Out>
    implements FieldValidationStateCopyWith<$R, FieldValidationState, $Out> {
  _FieldValidationStateCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<FieldValidationState> $mapper =
      FieldValidationStateMapper.ensureInitialized();
  @override
  $R call({bool? emailTouched, bool? passwordTouched, bool? nameTouched}) =>
      $apply(FieldCopyWithData({
        if (emailTouched != null) #emailTouched: emailTouched,
        if (passwordTouched != null) #passwordTouched: passwordTouched,
        if (nameTouched != null) #nameTouched: nameTouched
      }));
  @override
  FieldValidationState $make(CopyWithData data) => FieldValidationState(
      emailTouched: data.get(#emailTouched, or: $value.emailTouched),
      passwordTouched: data.get(#passwordTouched, or: $value.passwordTouched),
      nameTouched: data.get(#nameTouched, or: $value.nameTouched));

  @override
  FieldValidationStateCopyWith<$R2, FieldValidationState, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _FieldValidationStateCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
