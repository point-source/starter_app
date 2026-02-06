// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'auth_ws_event_model.dart';

class AuthWsEventModelMapper extends ClassMapperBase<AuthWsEventModel> {
  AuthWsEventModelMapper._();

  static AuthWsEventModelMapper? _instance;
  static AuthWsEventModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AuthWsEventModelMapper._());
      UserModelMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'AuthWsEventModel';

  static String _$event(AuthWsEventModel v) => v.event;
  static const Field<AuthWsEventModel, String> _f$event =
      Field('event', _$event);
  static UserModel? _$data(AuthWsEventModel v) => v.data;
  static const Field<AuthWsEventModel, UserModel> _f$data =
      Field('data', _$data, opt: true);
  static DateTime? _$timestamp(AuthWsEventModel v) => v.timestamp;
  static const Field<AuthWsEventModel, DateTime> _f$timestamp =
      Field('timestamp', _$timestamp, opt: true);

  @override
  final MappableFields<AuthWsEventModel> fields = const {
    #event: _f$event,
    #data: _f$data,
    #timestamp: _f$timestamp,
  };

  static AuthWsEventModel _instantiate(DecodingData data) {
    return AuthWsEventModel(
        event: data.dec(_f$event),
        data: data.dec(_f$data),
        timestamp: data.dec(_f$timestamp));
  }

  @override
  final Function instantiate = _instantiate;

  static AuthWsEventModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<AuthWsEventModel>(map);
  }

  static AuthWsEventModel fromJson(String json) {
    return ensureInitialized().decodeJson<AuthWsEventModel>(json);
  }
}

mixin AuthWsEventModelMappable {
  String toJson() {
    return AuthWsEventModelMapper.ensureInitialized()
        .encodeJson<AuthWsEventModel>(this as AuthWsEventModel);
  }

  Map<String, dynamic> toMap() {
    return AuthWsEventModelMapper.ensureInitialized()
        .encodeMap<AuthWsEventModel>(this as AuthWsEventModel);
  }

  AuthWsEventModelCopyWith<AuthWsEventModel, AuthWsEventModel, AuthWsEventModel>
      get copyWith =>
          _AuthWsEventModelCopyWithImpl<AuthWsEventModel, AuthWsEventModel>(
              this as AuthWsEventModel, $identity, $identity);
  @override
  String toString() {
    return AuthWsEventModelMapper.ensureInitialized()
        .stringifyValue(this as AuthWsEventModel);
  }

  @override
  bool operator ==(Object other) {
    return AuthWsEventModelMapper.ensureInitialized()
        .equalsValue(this as AuthWsEventModel, other);
  }

  @override
  int get hashCode {
    return AuthWsEventModelMapper.ensureInitialized()
        .hashValue(this as AuthWsEventModel);
  }
}

extension AuthWsEventModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, AuthWsEventModel, $Out> {
  AuthWsEventModelCopyWith<$R, AuthWsEventModel, $Out>
      get $asAuthWsEventModel => $base
          .as((v, t, t2) => _AuthWsEventModelCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class AuthWsEventModelCopyWith<$R, $In extends AuthWsEventModel, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  UserModelCopyWith<$R, UserModel, UserModel>? get data;
  $R call({String? event, UserModel? data, DateTime? timestamp});
  AuthWsEventModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _AuthWsEventModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, AuthWsEventModel, $Out>
    implements AuthWsEventModelCopyWith<$R, AuthWsEventModel, $Out> {
  _AuthWsEventModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<AuthWsEventModel> $mapper =
      AuthWsEventModelMapper.ensureInitialized();
  @override
  UserModelCopyWith<$R, UserModel, UserModel>? get data =>
      $value.data?.copyWith.$chain((v) => call(data: v));
  @override
  $R call({String? event, Object? data = $none, Object? timestamp = $none}) =>
      $apply(FieldCopyWithData({
        if (event != null) #event: event,
        if (data != $none) #data: data,
        if (timestamp != $none) #timestamp: timestamp
      }));
  @override
  AuthWsEventModel $make(CopyWithData data) => AuthWsEventModel(
      event: data.get(#event, or: $value.event),
      data: data.get(#data, or: $value.data),
      timestamp: data.get(#timestamp, or: $value.timestamp));

  @override
  AuthWsEventModelCopyWith<$R2, AuthWsEventModel, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _AuthWsEventModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
