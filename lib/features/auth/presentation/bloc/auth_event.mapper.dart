// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'auth_event.dart';

class AuthEventMapper extends ClassMapperBase<AuthEvent> {
  AuthEventMapper._();

  static AuthEventMapper? _instance;
  static AuthEventMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AuthEventMapper._());
      AuthEmailChangedMapper.ensureInitialized();
      AuthPasswordChangedMapper.ensureInitialized();
      AuthNameChangedMapper.ensureInitialized();
      AuthTogglePasswordVisibilityMapper.ensureInitialized();
      AuthEmailUnfocusedMapper.ensureInitialized();
      AuthPasswordUnfocusedMapper.ensureInitialized();
      AuthNameUnfocusedMapper.ensureInitialized();
      AuthEmailSubmittedMapper.ensureInitialized();
      AuthLoginSubmittedMapper.ensureInitialized();
      AuthRegisterSubmittedMapper.ensureInitialized();
      AuthLogoutRequestedMapper.ensureInitialized();
      AuthUserChangedMapper.ensureInitialized();
      AuthWatchStartedMapper.ensureInitialized();
      AuthGetCurrentUserMapper.ensureInitialized();
      AuthSessionWatchStartedMapper.ensureInitialized();
      AuthSessionExpiredMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'AuthEvent';

  @override
  final MappableFields<AuthEvent> fields = const {};

  static AuthEvent _instantiate(DecodingData data) {
    throw MapperException.missingConstructor('AuthEvent');
  }

  @override
  final Function instantiate = _instantiate;

  static AuthEvent fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<AuthEvent>(map);
  }

  static AuthEvent fromJson(String json) {
    return ensureInitialized().decodeJson<AuthEvent>(json);
  }
}

mixin AuthEventMappable {
  String toJson();
  Map<String, dynamic> toMap();
  AuthEventCopyWith<AuthEvent, AuthEvent, AuthEvent> get copyWith;
}

abstract class AuthEventCopyWith<$R, $In extends AuthEvent, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call();
  AuthEventCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class AuthEmailChangedMapper extends ClassMapperBase<AuthEmailChanged> {
  AuthEmailChangedMapper._();

  static AuthEmailChangedMapper? _instance;
  static AuthEmailChangedMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AuthEmailChangedMapper._());
      AuthEventMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'AuthEmailChanged';

  static String _$email(AuthEmailChanged v) => v.email;
  static const Field<AuthEmailChanged, String> _f$email = Field(
    'email',
    _$email,
  );

  @override
  final MappableFields<AuthEmailChanged> fields = const {#email: _f$email};

  static AuthEmailChanged _instantiate(DecodingData data) {
    return AuthEmailChanged(data.dec(_f$email));
  }

  @override
  final Function instantiate = _instantiate;

  static AuthEmailChanged fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<AuthEmailChanged>(map);
  }

  static AuthEmailChanged fromJson(String json) {
    return ensureInitialized().decodeJson<AuthEmailChanged>(json);
  }
}

mixin AuthEmailChangedMappable {
  String toJson() {
    return AuthEmailChangedMapper.ensureInitialized()
        .encodeJson<AuthEmailChanged>(this as AuthEmailChanged);
  }

  Map<String, dynamic> toMap() {
    return AuthEmailChangedMapper.ensureInitialized()
        .encodeMap<AuthEmailChanged>(this as AuthEmailChanged);
  }

  AuthEmailChangedCopyWith<AuthEmailChanged, AuthEmailChanged, AuthEmailChanged>
  get copyWith =>
      _AuthEmailChangedCopyWithImpl<AuthEmailChanged, AuthEmailChanged>(
        this as AuthEmailChanged,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return AuthEmailChangedMapper.ensureInitialized().stringifyValue(
      this as AuthEmailChanged,
    );
  }

  @override
  bool operator ==(Object other) {
    return AuthEmailChangedMapper.ensureInitialized().equalsValue(
      this as AuthEmailChanged,
      other,
    );
  }

  @override
  int get hashCode {
    return AuthEmailChangedMapper.ensureInitialized().hashValue(
      this as AuthEmailChanged,
    );
  }
}

extension AuthEmailChangedValueCopy<$R, $Out>
    on ObjectCopyWith<$R, AuthEmailChanged, $Out> {
  AuthEmailChangedCopyWith<$R, AuthEmailChanged, $Out>
  get $asAuthEmailChanged =>
      $base.as((v, t, t2) => _AuthEmailChangedCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class AuthEmailChangedCopyWith<$R, $In extends AuthEmailChanged, $Out>
    implements AuthEventCopyWith<$R, $In, $Out> {
  @override
  $R call({String? email});
  AuthEmailChangedCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _AuthEmailChangedCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, AuthEmailChanged, $Out>
    implements AuthEmailChangedCopyWith<$R, AuthEmailChanged, $Out> {
  _AuthEmailChangedCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<AuthEmailChanged> $mapper =
      AuthEmailChangedMapper.ensureInitialized();
  @override
  $R call({String? email}) =>
      $apply(FieldCopyWithData({if (email != null) #email: email}));
  @override
  AuthEmailChanged $make(CopyWithData data) =>
      AuthEmailChanged(data.get(#email, or: $value.email));

  @override
  AuthEmailChangedCopyWith<$R2, AuthEmailChanged, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _AuthEmailChangedCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class AuthPasswordChangedMapper extends ClassMapperBase<AuthPasswordChanged> {
  AuthPasswordChangedMapper._();

  static AuthPasswordChangedMapper? _instance;
  static AuthPasswordChangedMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AuthPasswordChangedMapper._());
      AuthEventMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'AuthPasswordChanged';

  static String _$password(AuthPasswordChanged v) => v.password;
  static const Field<AuthPasswordChanged, String> _f$password = Field(
    'password',
    _$password,
  );

  @override
  final MappableFields<AuthPasswordChanged> fields = const {
    #password: _f$password,
  };

  static AuthPasswordChanged _instantiate(DecodingData data) {
    return AuthPasswordChanged(data.dec(_f$password));
  }

  @override
  final Function instantiate = _instantiate;

  static AuthPasswordChanged fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<AuthPasswordChanged>(map);
  }

  static AuthPasswordChanged fromJson(String json) {
    return ensureInitialized().decodeJson<AuthPasswordChanged>(json);
  }
}

mixin AuthPasswordChangedMappable {
  String toJson() {
    return AuthPasswordChangedMapper.ensureInitialized()
        .encodeJson<AuthPasswordChanged>(this as AuthPasswordChanged);
  }

  Map<String, dynamic> toMap() {
    return AuthPasswordChangedMapper.ensureInitialized()
        .encodeMap<AuthPasswordChanged>(this as AuthPasswordChanged);
  }

  AuthPasswordChangedCopyWith<
    AuthPasswordChanged,
    AuthPasswordChanged,
    AuthPasswordChanged
  >
  get copyWith =>
      _AuthPasswordChangedCopyWithImpl<
        AuthPasswordChanged,
        AuthPasswordChanged
      >(this as AuthPasswordChanged, $identity, $identity);
  @override
  String toString() {
    return AuthPasswordChangedMapper.ensureInitialized().stringifyValue(
      this as AuthPasswordChanged,
    );
  }

  @override
  bool operator ==(Object other) {
    return AuthPasswordChangedMapper.ensureInitialized().equalsValue(
      this as AuthPasswordChanged,
      other,
    );
  }

  @override
  int get hashCode {
    return AuthPasswordChangedMapper.ensureInitialized().hashValue(
      this as AuthPasswordChanged,
    );
  }
}

extension AuthPasswordChangedValueCopy<$R, $Out>
    on ObjectCopyWith<$R, AuthPasswordChanged, $Out> {
  AuthPasswordChangedCopyWith<$R, AuthPasswordChanged, $Out>
  get $asAuthPasswordChanged => $base.as(
    (v, t, t2) => _AuthPasswordChangedCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class AuthPasswordChangedCopyWith<
  $R,
  $In extends AuthPasswordChanged,
  $Out
>
    implements AuthEventCopyWith<$R, $In, $Out> {
  @override
  $R call({String? password});
  AuthPasswordChangedCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _AuthPasswordChangedCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, AuthPasswordChanged, $Out>
    implements AuthPasswordChangedCopyWith<$R, AuthPasswordChanged, $Out> {
  _AuthPasswordChangedCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<AuthPasswordChanged> $mapper =
      AuthPasswordChangedMapper.ensureInitialized();
  @override
  $R call({String? password}) =>
      $apply(FieldCopyWithData({if (password != null) #password: password}));
  @override
  AuthPasswordChanged $make(CopyWithData data) =>
      AuthPasswordChanged(data.get(#password, or: $value.password));

  @override
  AuthPasswordChangedCopyWith<$R2, AuthPasswordChanged, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _AuthPasswordChangedCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class AuthNameChangedMapper extends ClassMapperBase<AuthNameChanged> {
  AuthNameChangedMapper._();

  static AuthNameChangedMapper? _instance;
  static AuthNameChangedMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AuthNameChangedMapper._());
      AuthEventMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'AuthNameChanged';

  static String _$name(AuthNameChanged v) => v.name;
  static const Field<AuthNameChanged, String> _f$name = Field('name', _$name);

  @override
  final MappableFields<AuthNameChanged> fields = const {#name: _f$name};

  static AuthNameChanged _instantiate(DecodingData data) {
    return AuthNameChanged(data.dec(_f$name));
  }

  @override
  final Function instantiate = _instantiate;

  static AuthNameChanged fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<AuthNameChanged>(map);
  }

  static AuthNameChanged fromJson(String json) {
    return ensureInitialized().decodeJson<AuthNameChanged>(json);
  }
}

mixin AuthNameChangedMappable {
  String toJson() {
    return AuthNameChangedMapper.ensureInitialized()
        .encodeJson<AuthNameChanged>(this as AuthNameChanged);
  }

  Map<String, dynamic> toMap() {
    return AuthNameChangedMapper.ensureInitialized().encodeMap<AuthNameChanged>(
      this as AuthNameChanged,
    );
  }

  AuthNameChangedCopyWith<AuthNameChanged, AuthNameChanged, AuthNameChanged>
  get copyWith =>
      _AuthNameChangedCopyWithImpl<AuthNameChanged, AuthNameChanged>(
        this as AuthNameChanged,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return AuthNameChangedMapper.ensureInitialized().stringifyValue(
      this as AuthNameChanged,
    );
  }

  @override
  bool operator ==(Object other) {
    return AuthNameChangedMapper.ensureInitialized().equalsValue(
      this as AuthNameChanged,
      other,
    );
  }

  @override
  int get hashCode {
    return AuthNameChangedMapper.ensureInitialized().hashValue(
      this as AuthNameChanged,
    );
  }
}

extension AuthNameChangedValueCopy<$R, $Out>
    on ObjectCopyWith<$R, AuthNameChanged, $Out> {
  AuthNameChangedCopyWith<$R, AuthNameChanged, $Out> get $asAuthNameChanged =>
      $base.as((v, t, t2) => _AuthNameChangedCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class AuthNameChangedCopyWith<$R, $In extends AuthNameChanged, $Out>
    implements AuthEventCopyWith<$R, $In, $Out> {
  @override
  $R call({String? name});
  AuthNameChangedCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _AuthNameChangedCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, AuthNameChanged, $Out>
    implements AuthNameChangedCopyWith<$R, AuthNameChanged, $Out> {
  _AuthNameChangedCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<AuthNameChanged> $mapper =
      AuthNameChangedMapper.ensureInitialized();
  @override
  $R call({String? name}) =>
      $apply(FieldCopyWithData({if (name != null) #name: name}));
  @override
  AuthNameChanged $make(CopyWithData data) =>
      AuthNameChanged(data.get(#name, or: $value.name));

  @override
  AuthNameChangedCopyWith<$R2, AuthNameChanged, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _AuthNameChangedCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class AuthTogglePasswordVisibilityMapper
    extends ClassMapperBase<AuthTogglePasswordVisibility> {
  AuthTogglePasswordVisibilityMapper._();

  static AuthTogglePasswordVisibilityMapper? _instance;
  static AuthTogglePasswordVisibilityMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(
        _instance = AuthTogglePasswordVisibilityMapper._(),
      );
      AuthEventMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'AuthTogglePasswordVisibility';

  @override
  final MappableFields<AuthTogglePasswordVisibility> fields = const {};

  static AuthTogglePasswordVisibility _instantiate(DecodingData data) {
    return AuthTogglePasswordVisibility();
  }

  @override
  final Function instantiate = _instantiate;

  static AuthTogglePasswordVisibility fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<AuthTogglePasswordVisibility>(map);
  }

  static AuthTogglePasswordVisibility fromJson(String json) {
    return ensureInitialized().decodeJson<AuthTogglePasswordVisibility>(json);
  }
}

mixin AuthTogglePasswordVisibilityMappable {
  String toJson() {
    return AuthTogglePasswordVisibilityMapper.ensureInitialized()
        .encodeJson<AuthTogglePasswordVisibility>(
          this as AuthTogglePasswordVisibility,
        );
  }

  Map<String, dynamic> toMap() {
    return AuthTogglePasswordVisibilityMapper.ensureInitialized()
        .encodeMap<AuthTogglePasswordVisibility>(
          this as AuthTogglePasswordVisibility,
        );
  }

  AuthTogglePasswordVisibilityCopyWith<
    AuthTogglePasswordVisibility,
    AuthTogglePasswordVisibility,
    AuthTogglePasswordVisibility
  >
  get copyWith =>
      _AuthTogglePasswordVisibilityCopyWithImpl<
        AuthTogglePasswordVisibility,
        AuthTogglePasswordVisibility
      >(this as AuthTogglePasswordVisibility, $identity, $identity);
  @override
  String toString() {
    return AuthTogglePasswordVisibilityMapper.ensureInitialized()
        .stringifyValue(this as AuthTogglePasswordVisibility);
  }

  @override
  bool operator ==(Object other) {
    return AuthTogglePasswordVisibilityMapper.ensureInitialized().equalsValue(
      this as AuthTogglePasswordVisibility,
      other,
    );
  }

  @override
  int get hashCode {
    return AuthTogglePasswordVisibilityMapper.ensureInitialized().hashValue(
      this as AuthTogglePasswordVisibility,
    );
  }
}

extension AuthTogglePasswordVisibilityValueCopy<$R, $Out>
    on ObjectCopyWith<$R, AuthTogglePasswordVisibility, $Out> {
  AuthTogglePasswordVisibilityCopyWith<$R, AuthTogglePasswordVisibility, $Out>
  get $asAuthTogglePasswordVisibility => $base.as(
    (v, t, t2) => _AuthTogglePasswordVisibilityCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class AuthTogglePasswordVisibilityCopyWith<
  $R,
  $In extends AuthTogglePasswordVisibility,
  $Out
>
    implements AuthEventCopyWith<$R, $In, $Out> {
  @override
  $R call();
  AuthTogglePasswordVisibilityCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _AuthTogglePasswordVisibilityCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, AuthTogglePasswordVisibility, $Out>
    implements
        AuthTogglePasswordVisibilityCopyWith<
          $R,
          AuthTogglePasswordVisibility,
          $Out
        > {
  _AuthTogglePasswordVisibilityCopyWithImpl(
    super.value,
    super.then,
    super.then2,
  );

  @override
  late final ClassMapperBase<AuthTogglePasswordVisibility> $mapper =
      AuthTogglePasswordVisibilityMapper.ensureInitialized();
  @override
  $R call() => $apply(FieldCopyWithData({}));
  @override
  AuthTogglePasswordVisibility $make(CopyWithData data) =>
      AuthTogglePasswordVisibility();

  @override
  AuthTogglePasswordVisibilityCopyWith<$R2, AuthTogglePasswordVisibility, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _AuthTogglePasswordVisibilityCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class AuthEmailUnfocusedMapper extends ClassMapperBase<AuthEmailUnfocused> {
  AuthEmailUnfocusedMapper._();

  static AuthEmailUnfocusedMapper? _instance;
  static AuthEmailUnfocusedMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AuthEmailUnfocusedMapper._());
      AuthEventMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'AuthEmailUnfocused';

  @override
  final MappableFields<AuthEmailUnfocused> fields = const {};

  static AuthEmailUnfocused _instantiate(DecodingData data) {
    return AuthEmailUnfocused();
  }

  @override
  final Function instantiate = _instantiate;

  static AuthEmailUnfocused fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<AuthEmailUnfocused>(map);
  }

  static AuthEmailUnfocused fromJson(String json) {
    return ensureInitialized().decodeJson<AuthEmailUnfocused>(json);
  }
}

mixin AuthEmailUnfocusedMappable {
  String toJson() {
    return AuthEmailUnfocusedMapper.ensureInitialized()
        .encodeJson<AuthEmailUnfocused>(this as AuthEmailUnfocused);
  }

  Map<String, dynamic> toMap() {
    return AuthEmailUnfocusedMapper.ensureInitialized()
        .encodeMap<AuthEmailUnfocused>(this as AuthEmailUnfocused);
  }

  AuthEmailUnfocusedCopyWith<
    AuthEmailUnfocused,
    AuthEmailUnfocused,
    AuthEmailUnfocused
  >
  get copyWith =>
      _AuthEmailUnfocusedCopyWithImpl<AuthEmailUnfocused, AuthEmailUnfocused>(
        this as AuthEmailUnfocused,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return AuthEmailUnfocusedMapper.ensureInitialized().stringifyValue(
      this as AuthEmailUnfocused,
    );
  }

  @override
  bool operator ==(Object other) {
    return AuthEmailUnfocusedMapper.ensureInitialized().equalsValue(
      this as AuthEmailUnfocused,
      other,
    );
  }

  @override
  int get hashCode {
    return AuthEmailUnfocusedMapper.ensureInitialized().hashValue(
      this as AuthEmailUnfocused,
    );
  }
}

extension AuthEmailUnfocusedValueCopy<$R, $Out>
    on ObjectCopyWith<$R, AuthEmailUnfocused, $Out> {
  AuthEmailUnfocusedCopyWith<$R, AuthEmailUnfocused, $Out>
  get $asAuthEmailUnfocused => $base.as(
    (v, t, t2) => _AuthEmailUnfocusedCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class AuthEmailUnfocusedCopyWith<
  $R,
  $In extends AuthEmailUnfocused,
  $Out
>
    implements AuthEventCopyWith<$R, $In, $Out> {
  @override
  $R call();
  AuthEmailUnfocusedCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _AuthEmailUnfocusedCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, AuthEmailUnfocused, $Out>
    implements AuthEmailUnfocusedCopyWith<$R, AuthEmailUnfocused, $Out> {
  _AuthEmailUnfocusedCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<AuthEmailUnfocused> $mapper =
      AuthEmailUnfocusedMapper.ensureInitialized();
  @override
  $R call() => $apply(FieldCopyWithData({}));
  @override
  AuthEmailUnfocused $make(CopyWithData data) => AuthEmailUnfocused();

  @override
  AuthEmailUnfocusedCopyWith<$R2, AuthEmailUnfocused, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _AuthEmailUnfocusedCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class AuthPasswordUnfocusedMapper
    extends ClassMapperBase<AuthPasswordUnfocused> {
  AuthPasswordUnfocusedMapper._();

  static AuthPasswordUnfocusedMapper? _instance;
  static AuthPasswordUnfocusedMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AuthPasswordUnfocusedMapper._());
      AuthEventMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'AuthPasswordUnfocused';

  @override
  final MappableFields<AuthPasswordUnfocused> fields = const {};

  static AuthPasswordUnfocused _instantiate(DecodingData data) {
    return AuthPasswordUnfocused();
  }

  @override
  final Function instantiate = _instantiate;

  static AuthPasswordUnfocused fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<AuthPasswordUnfocused>(map);
  }

  static AuthPasswordUnfocused fromJson(String json) {
    return ensureInitialized().decodeJson<AuthPasswordUnfocused>(json);
  }
}

mixin AuthPasswordUnfocusedMappable {
  String toJson() {
    return AuthPasswordUnfocusedMapper.ensureInitialized()
        .encodeJson<AuthPasswordUnfocused>(this as AuthPasswordUnfocused);
  }

  Map<String, dynamic> toMap() {
    return AuthPasswordUnfocusedMapper.ensureInitialized()
        .encodeMap<AuthPasswordUnfocused>(this as AuthPasswordUnfocused);
  }

  AuthPasswordUnfocusedCopyWith<
    AuthPasswordUnfocused,
    AuthPasswordUnfocused,
    AuthPasswordUnfocused
  >
  get copyWith =>
      _AuthPasswordUnfocusedCopyWithImpl<
        AuthPasswordUnfocused,
        AuthPasswordUnfocused
      >(this as AuthPasswordUnfocused, $identity, $identity);
  @override
  String toString() {
    return AuthPasswordUnfocusedMapper.ensureInitialized().stringifyValue(
      this as AuthPasswordUnfocused,
    );
  }

  @override
  bool operator ==(Object other) {
    return AuthPasswordUnfocusedMapper.ensureInitialized().equalsValue(
      this as AuthPasswordUnfocused,
      other,
    );
  }

  @override
  int get hashCode {
    return AuthPasswordUnfocusedMapper.ensureInitialized().hashValue(
      this as AuthPasswordUnfocused,
    );
  }
}

extension AuthPasswordUnfocusedValueCopy<$R, $Out>
    on ObjectCopyWith<$R, AuthPasswordUnfocused, $Out> {
  AuthPasswordUnfocusedCopyWith<$R, AuthPasswordUnfocused, $Out>
  get $asAuthPasswordUnfocused => $base.as(
    (v, t, t2) => _AuthPasswordUnfocusedCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class AuthPasswordUnfocusedCopyWith<
  $R,
  $In extends AuthPasswordUnfocused,
  $Out
>
    implements AuthEventCopyWith<$R, $In, $Out> {
  @override
  $R call();
  AuthPasswordUnfocusedCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _AuthPasswordUnfocusedCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, AuthPasswordUnfocused, $Out>
    implements AuthPasswordUnfocusedCopyWith<$R, AuthPasswordUnfocused, $Out> {
  _AuthPasswordUnfocusedCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<AuthPasswordUnfocused> $mapper =
      AuthPasswordUnfocusedMapper.ensureInitialized();
  @override
  $R call() => $apply(FieldCopyWithData({}));
  @override
  AuthPasswordUnfocused $make(CopyWithData data) => AuthPasswordUnfocused();

  @override
  AuthPasswordUnfocusedCopyWith<$R2, AuthPasswordUnfocused, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _AuthPasswordUnfocusedCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class AuthNameUnfocusedMapper extends ClassMapperBase<AuthNameUnfocused> {
  AuthNameUnfocusedMapper._();

  static AuthNameUnfocusedMapper? _instance;
  static AuthNameUnfocusedMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AuthNameUnfocusedMapper._());
      AuthEventMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'AuthNameUnfocused';

  @override
  final MappableFields<AuthNameUnfocused> fields = const {};

  static AuthNameUnfocused _instantiate(DecodingData data) {
    return AuthNameUnfocused();
  }

  @override
  final Function instantiate = _instantiate;

  static AuthNameUnfocused fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<AuthNameUnfocused>(map);
  }

  static AuthNameUnfocused fromJson(String json) {
    return ensureInitialized().decodeJson<AuthNameUnfocused>(json);
  }
}

mixin AuthNameUnfocusedMappable {
  String toJson() {
    return AuthNameUnfocusedMapper.ensureInitialized()
        .encodeJson<AuthNameUnfocused>(this as AuthNameUnfocused);
  }

  Map<String, dynamic> toMap() {
    return AuthNameUnfocusedMapper.ensureInitialized()
        .encodeMap<AuthNameUnfocused>(this as AuthNameUnfocused);
  }

  AuthNameUnfocusedCopyWith<
    AuthNameUnfocused,
    AuthNameUnfocused,
    AuthNameUnfocused
  >
  get copyWith =>
      _AuthNameUnfocusedCopyWithImpl<AuthNameUnfocused, AuthNameUnfocused>(
        this as AuthNameUnfocused,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return AuthNameUnfocusedMapper.ensureInitialized().stringifyValue(
      this as AuthNameUnfocused,
    );
  }

  @override
  bool operator ==(Object other) {
    return AuthNameUnfocusedMapper.ensureInitialized().equalsValue(
      this as AuthNameUnfocused,
      other,
    );
  }

  @override
  int get hashCode {
    return AuthNameUnfocusedMapper.ensureInitialized().hashValue(
      this as AuthNameUnfocused,
    );
  }
}

extension AuthNameUnfocusedValueCopy<$R, $Out>
    on ObjectCopyWith<$R, AuthNameUnfocused, $Out> {
  AuthNameUnfocusedCopyWith<$R, AuthNameUnfocused, $Out>
  get $asAuthNameUnfocused => $base.as(
    (v, t, t2) => _AuthNameUnfocusedCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class AuthNameUnfocusedCopyWith<
  $R,
  $In extends AuthNameUnfocused,
  $Out
>
    implements AuthEventCopyWith<$R, $In, $Out> {
  @override
  $R call();
  AuthNameUnfocusedCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _AuthNameUnfocusedCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, AuthNameUnfocused, $Out>
    implements AuthNameUnfocusedCopyWith<$R, AuthNameUnfocused, $Out> {
  _AuthNameUnfocusedCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<AuthNameUnfocused> $mapper =
      AuthNameUnfocusedMapper.ensureInitialized();
  @override
  $R call() => $apply(FieldCopyWithData({}));
  @override
  AuthNameUnfocused $make(CopyWithData data) => AuthNameUnfocused();

  @override
  AuthNameUnfocusedCopyWith<$R2, AuthNameUnfocused, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _AuthNameUnfocusedCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class AuthEmailSubmittedMapper extends ClassMapperBase<AuthEmailSubmitted> {
  AuthEmailSubmittedMapper._();

  static AuthEmailSubmittedMapper? _instance;
  static AuthEmailSubmittedMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AuthEmailSubmittedMapper._());
      AuthEventMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'AuthEmailSubmitted';

  @override
  final MappableFields<AuthEmailSubmitted> fields = const {};

  static AuthEmailSubmitted _instantiate(DecodingData data) {
    return AuthEmailSubmitted();
  }

  @override
  final Function instantiate = _instantiate;

  static AuthEmailSubmitted fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<AuthEmailSubmitted>(map);
  }

  static AuthEmailSubmitted fromJson(String json) {
    return ensureInitialized().decodeJson<AuthEmailSubmitted>(json);
  }
}

mixin AuthEmailSubmittedMappable {
  String toJson() {
    return AuthEmailSubmittedMapper.ensureInitialized()
        .encodeJson<AuthEmailSubmitted>(this as AuthEmailSubmitted);
  }

  Map<String, dynamic> toMap() {
    return AuthEmailSubmittedMapper.ensureInitialized()
        .encodeMap<AuthEmailSubmitted>(this as AuthEmailSubmitted);
  }

  AuthEmailSubmittedCopyWith<
    AuthEmailSubmitted,
    AuthEmailSubmitted,
    AuthEmailSubmitted
  >
  get copyWith =>
      _AuthEmailSubmittedCopyWithImpl<AuthEmailSubmitted, AuthEmailSubmitted>(
        this as AuthEmailSubmitted,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return AuthEmailSubmittedMapper.ensureInitialized().stringifyValue(
      this as AuthEmailSubmitted,
    );
  }

  @override
  bool operator ==(Object other) {
    return AuthEmailSubmittedMapper.ensureInitialized().equalsValue(
      this as AuthEmailSubmitted,
      other,
    );
  }

  @override
  int get hashCode {
    return AuthEmailSubmittedMapper.ensureInitialized().hashValue(
      this as AuthEmailSubmitted,
    );
  }
}

extension AuthEmailSubmittedValueCopy<$R, $Out>
    on ObjectCopyWith<$R, AuthEmailSubmitted, $Out> {
  AuthEmailSubmittedCopyWith<$R, AuthEmailSubmitted, $Out>
  get $asAuthEmailSubmitted => $base.as(
    (v, t, t2) => _AuthEmailSubmittedCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class AuthEmailSubmittedCopyWith<
  $R,
  $In extends AuthEmailSubmitted,
  $Out
>
    implements AuthEventCopyWith<$R, $In, $Out> {
  @override
  $R call();
  AuthEmailSubmittedCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _AuthEmailSubmittedCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, AuthEmailSubmitted, $Out>
    implements AuthEmailSubmittedCopyWith<$R, AuthEmailSubmitted, $Out> {
  _AuthEmailSubmittedCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<AuthEmailSubmitted> $mapper =
      AuthEmailSubmittedMapper.ensureInitialized();
  @override
  $R call() => $apply(FieldCopyWithData({}));
  @override
  AuthEmailSubmitted $make(CopyWithData data) => AuthEmailSubmitted();

  @override
  AuthEmailSubmittedCopyWith<$R2, AuthEmailSubmitted, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _AuthEmailSubmittedCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class AuthLoginSubmittedMapper extends ClassMapperBase<AuthLoginSubmitted> {
  AuthLoginSubmittedMapper._();

  static AuthLoginSubmittedMapper? _instance;
  static AuthLoginSubmittedMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AuthLoginSubmittedMapper._());
      AuthEventMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'AuthLoginSubmitted';

  @override
  final MappableFields<AuthLoginSubmitted> fields = const {};

  static AuthLoginSubmitted _instantiate(DecodingData data) {
    return AuthLoginSubmitted();
  }

  @override
  final Function instantiate = _instantiate;

  static AuthLoginSubmitted fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<AuthLoginSubmitted>(map);
  }

  static AuthLoginSubmitted fromJson(String json) {
    return ensureInitialized().decodeJson<AuthLoginSubmitted>(json);
  }
}

mixin AuthLoginSubmittedMappable {
  String toJson() {
    return AuthLoginSubmittedMapper.ensureInitialized()
        .encodeJson<AuthLoginSubmitted>(this as AuthLoginSubmitted);
  }

  Map<String, dynamic> toMap() {
    return AuthLoginSubmittedMapper.ensureInitialized()
        .encodeMap<AuthLoginSubmitted>(this as AuthLoginSubmitted);
  }

  AuthLoginSubmittedCopyWith<
    AuthLoginSubmitted,
    AuthLoginSubmitted,
    AuthLoginSubmitted
  >
  get copyWith =>
      _AuthLoginSubmittedCopyWithImpl<AuthLoginSubmitted, AuthLoginSubmitted>(
        this as AuthLoginSubmitted,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return AuthLoginSubmittedMapper.ensureInitialized().stringifyValue(
      this as AuthLoginSubmitted,
    );
  }

  @override
  bool operator ==(Object other) {
    return AuthLoginSubmittedMapper.ensureInitialized().equalsValue(
      this as AuthLoginSubmitted,
      other,
    );
  }

  @override
  int get hashCode {
    return AuthLoginSubmittedMapper.ensureInitialized().hashValue(
      this as AuthLoginSubmitted,
    );
  }
}

extension AuthLoginSubmittedValueCopy<$R, $Out>
    on ObjectCopyWith<$R, AuthLoginSubmitted, $Out> {
  AuthLoginSubmittedCopyWith<$R, AuthLoginSubmitted, $Out>
  get $asAuthLoginSubmitted => $base.as(
    (v, t, t2) => _AuthLoginSubmittedCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class AuthLoginSubmittedCopyWith<
  $R,
  $In extends AuthLoginSubmitted,
  $Out
>
    implements AuthEventCopyWith<$R, $In, $Out> {
  @override
  $R call();
  AuthLoginSubmittedCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _AuthLoginSubmittedCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, AuthLoginSubmitted, $Out>
    implements AuthLoginSubmittedCopyWith<$R, AuthLoginSubmitted, $Out> {
  _AuthLoginSubmittedCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<AuthLoginSubmitted> $mapper =
      AuthLoginSubmittedMapper.ensureInitialized();
  @override
  $R call() => $apply(FieldCopyWithData({}));
  @override
  AuthLoginSubmitted $make(CopyWithData data) => AuthLoginSubmitted();

  @override
  AuthLoginSubmittedCopyWith<$R2, AuthLoginSubmitted, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _AuthLoginSubmittedCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class AuthRegisterSubmittedMapper
    extends ClassMapperBase<AuthRegisterSubmitted> {
  AuthRegisterSubmittedMapper._();

  static AuthRegisterSubmittedMapper? _instance;
  static AuthRegisterSubmittedMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AuthRegisterSubmittedMapper._());
      AuthEventMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'AuthRegisterSubmitted';

  @override
  final MappableFields<AuthRegisterSubmitted> fields = const {};

  static AuthRegisterSubmitted _instantiate(DecodingData data) {
    return AuthRegisterSubmitted();
  }

  @override
  final Function instantiate = _instantiate;

  static AuthRegisterSubmitted fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<AuthRegisterSubmitted>(map);
  }

  static AuthRegisterSubmitted fromJson(String json) {
    return ensureInitialized().decodeJson<AuthRegisterSubmitted>(json);
  }
}

mixin AuthRegisterSubmittedMappable {
  String toJson() {
    return AuthRegisterSubmittedMapper.ensureInitialized()
        .encodeJson<AuthRegisterSubmitted>(this as AuthRegisterSubmitted);
  }

  Map<String, dynamic> toMap() {
    return AuthRegisterSubmittedMapper.ensureInitialized()
        .encodeMap<AuthRegisterSubmitted>(this as AuthRegisterSubmitted);
  }

  AuthRegisterSubmittedCopyWith<
    AuthRegisterSubmitted,
    AuthRegisterSubmitted,
    AuthRegisterSubmitted
  >
  get copyWith =>
      _AuthRegisterSubmittedCopyWithImpl<
        AuthRegisterSubmitted,
        AuthRegisterSubmitted
      >(this as AuthRegisterSubmitted, $identity, $identity);
  @override
  String toString() {
    return AuthRegisterSubmittedMapper.ensureInitialized().stringifyValue(
      this as AuthRegisterSubmitted,
    );
  }

  @override
  bool operator ==(Object other) {
    return AuthRegisterSubmittedMapper.ensureInitialized().equalsValue(
      this as AuthRegisterSubmitted,
      other,
    );
  }

  @override
  int get hashCode {
    return AuthRegisterSubmittedMapper.ensureInitialized().hashValue(
      this as AuthRegisterSubmitted,
    );
  }
}

extension AuthRegisterSubmittedValueCopy<$R, $Out>
    on ObjectCopyWith<$R, AuthRegisterSubmitted, $Out> {
  AuthRegisterSubmittedCopyWith<$R, AuthRegisterSubmitted, $Out>
  get $asAuthRegisterSubmitted => $base.as(
    (v, t, t2) => _AuthRegisterSubmittedCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class AuthRegisterSubmittedCopyWith<
  $R,
  $In extends AuthRegisterSubmitted,
  $Out
>
    implements AuthEventCopyWith<$R, $In, $Out> {
  @override
  $R call();
  AuthRegisterSubmittedCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _AuthRegisterSubmittedCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, AuthRegisterSubmitted, $Out>
    implements AuthRegisterSubmittedCopyWith<$R, AuthRegisterSubmitted, $Out> {
  _AuthRegisterSubmittedCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<AuthRegisterSubmitted> $mapper =
      AuthRegisterSubmittedMapper.ensureInitialized();
  @override
  $R call() => $apply(FieldCopyWithData({}));
  @override
  AuthRegisterSubmitted $make(CopyWithData data) => AuthRegisterSubmitted();

  @override
  AuthRegisterSubmittedCopyWith<$R2, AuthRegisterSubmitted, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _AuthRegisterSubmittedCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class AuthLogoutRequestedMapper extends ClassMapperBase<AuthLogoutRequested> {
  AuthLogoutRequestedMapper._();

  static AuthLogoutRequestedMapper? _instance;
  static AuthLogoutRequestedMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AuthLogoutRequestedMapper._());
      AuthEventMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'AuthLogoutRequested';

  @override
  final MappableFields<AuthLogoutRequested> fields = const {};

  static AuthLogoutRequested _instantiate(DecodingData data) {
    return AuthLogoutRequested();
  }

  @override
  final Function instantiate = _instantiate;

  static AuthLogoutRequested fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<AuthLogoutRequested>(map);
  }

  static AuthLogoutRequested fromJson(String json) {
    return ensureInitialized().decodeJson<AuthLogoutRequested>(json);
  }
}

mixin AuthLogoutRequestedMappable {
  String toJson() {
    return AuthLogoutRequestedMapper.ensureInitialized()
        .encodeJson<AuthLogoutRequested>(this as AuthLogoutRequested);
  }

  Map<String, dynamic> toMap() {
    return AuthLogoutRequestedMapper.ensureInitialized()
        .encodeMap<AuthLogoutRequested>(this as AuthLogoutRequested);
  }

  AuthLogoutRequestedCopyWith<
    AuthLogoutRequested,
    AuthLogoutRequested,
    AuthLogoutRequested
  >
  get copyWith =>
      _AuthLogoutRequestedCopyWithImpl<
        AuthLogoutRequested,
        AuthLogoutRequested
      >(this as AuthLogoutRequested, $identity, $identity);
  @override
  String toString() {
    return AuthLogoutRequestedMapper.ensureInitialized().stringifyValue(
      this as AuthLogoutRequested,
    );
  }

  @override
  bool operator ==(Object other) {
    return AuthLogoutRequestedMapper.ensureInitialized().equalsValue(
      this as AuthLogoutRequested,
      other,
    );
  }

  @override
  int get hashCode {
    return AuthLogoutRequestedMapper.ensureInitialized().hashValue(
      this as AuthLogoutRequested,
    );
  }
}

extension AuthLogoutRequestedValueCopy<$R, $Out>
    on ObjectCopyWith<$R, AuthLogoutRequested, $Out> {
  AuthLogoutRequestedCopyWith<$R, AuthLogoutRequested, $Out>
  get $asAuthLogoutRequested => $base.as(
    (v, t, t2) => _AuthLogoutRequestedCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class AuthLogoutRequestedCopyWith<
  $R,
  $In extends AuthLogoutRequested,
  $Out
>
    implements AuthEventCopyWith<$R, $In, $Out> {
  @override
  $R call();
  AuthLogoutRequestedCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _AuthLogoutRequestedCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, AuthLogoutRequested, $Out>
    implements AuthLogoutRequestedCopyWith<$R, AuthLogoutRequested, $Out> {
  _AuthLogoutRequestedCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<AuthLogoutRequested> $mapper =
      AuthLogoutRequestedMapper.ensureInitialized();
  @override
  $R call() => $apply(FieldCopyWithData({}));
  @override
  AuthLogoutRequested $make(CopyWithData data) => AuthLogoutRequested();

  @override
  AuthLogoutRequestedCopyWith<$R2, AuthLogoutRequested, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _AuthLogoutRequestedCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class AuthUserChangedMapper extends ClassMapperBase<AuthUserChanged> {
  AuthUserChangedMapper._();

  static AuthUserChangedMapper? _instance;
  static AuthUserChangedMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AuthUserChangedMapper._());
      AuthEventMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'AuthUserChanged';

  static User? _$user(AuthUserChanged v) => v.user;
  static const Field<AuthUserChanged, User> _f$user = Field('user', _$user);

  @override
  final MappableFields<AuthUserChanged> fields = const {#user: _f$user};

  static AuthUserChanged _instantiate(DecodingData data) {
    return AuthUserChanged(data.dec(_f$user));
  }

  @override
  final Function instantiate = _instantiate;

  static AuthUserChanged fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<AuthUserChanged>(map);
  }

  static AuthUserChanged fromJson(String json) {
    return ensureInitialized().decodeJson<AuthUserChanged>(json);
  }
}

mixin AuthUserChangedMappable {
  String toJson() {
    return AuthUserChangedMapper.ensureInitialized()
        .encodeJson<AuthUserChanged>(this as AuthUserChanged);
  }

  Map<String, dynamic> toMap() {
    return AuthUserChangedMapper.ensureInitialized().encodeMap<AuthUserChanged>(
      this as AuthUserChanged,
    );
  }

  AuthUserChangedCopyWith<AuthUserChanged, AuthUserChanged, AuthUserChanged>
  get copyWith =>
      _AuthUserChangedCopyWithImpl<AuthUserChanged, AuthUserChanged>(
        this as AuthUserChanged,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return AuthUserChangedMapper.ensureInitialized().stringifyValue(
      this as AuthUserChanged,
    );
  }

  @override
  bool operator ==(Object other) {
    return AuthUserChangedMapper.ensureInitialized().equalsValue(
      this as AuthUserChanged,
      other,
    );
  }

  @override
  int get hashCode {
    return AuthUserChangedMapper.ensureInitialized().hashValue(
      this as AuthUserChanged,
    );
  }
}

extension AuthUserChangedValueCopy<$R, $Out>
    on ObjectCopyWith<$R, AuthUserChanged, $Out> {
  AuthUserChangedCopyWith<$R, AuthUserChanged, $Out> get $asAuthUserChanged =>
      $base.as((v, t, t2) => _AuthUserChangedCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class AuthUserChangedCopyWith<$R, $In extends AuthUserChanged, $Out>
    implements AuthEventCopyWith<$R, $In, $Out> {
  @override
  $R call({User? user});
  AuthUserChangedCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _AuthUserChangedCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, AuthUserChanged, $Out>
    implements AuthUserChangedCopyWith<$R, AuthUserChanged, $Out> {
  _AuthUserChangedCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<AuthUserChanged> $mapper =
      AuthUserChangedMapper.ensureInitialized();
  @override
  $R call({Object? user = $none}) =>
      $apply(FieldCopyWithData({if (user != $none) #user: user}));
  @override
  AuthUserChanged $make(CopyWithData data) =>
      AuthUserChanged(data.get(#user, or: $value.user));

  @override
  AuthUserChangedCopyWith<$R2, AuthUserChanged, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _AuthUserChangedCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class AuthWatchStartedMapper extends ClassMapperBase<AuthWatchStarted> {
  AuthWatchStartedMapper._();

  static AuthWatchStartedMapper? _instance;
  static AuthWatchStartedMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AuthWatchStartedMapper._());
      AuthEventMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'AuthWatchStarted';

  @override
  final MappableFields<AuthWatchStarted> fields = const {};

  static AuthWatchStarted _instantiate(DecodingData data) {
    return AuthWatchStarted();
  }

  @override
  final Function instantiate = _instantiate;

  static AuthWatchStarted fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<AuthWatchStarted>(map);
  }

  static AuthWatchStarted fromJson(String json) {
    return ensureInitialized().decodeJson<AuthWatchStarted>(json);
  }
}

mixin AuthWatchStartedMappable {
  String toJson() {
    return AuthWatchStartedMapper.ensureInitialized()
        .encodeJson<AuthWatchStarted>(this as AuthWatchStarted);
  }

  Map<String, dynamic> toMap() {
    return AuthWatchStartedMapper.ensureInitialized()
        .encodeMap<AuthWatchStarted>(this as AuthWatchStarted);
  }

  AuthWatchStartedCopyWith<AuthWatchStarted, AuthWatchStarted, AuthWatchStarted>
  get copyWith =>
      _AuthWatchStartedCopyWithImpl<AuthWatchStarted, AuthWatchStarted>(
        this as AuthWatchStarted,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return AuthWatchStartedMapper.ensureInitialized().stringifyValue(
      this as AuthWatchStarted,
    );
  }

  @override
  bool operator ==(Object other) {
    return AuthWatchStartedMapper.ensureInitialized().equalsValue(
      this as AuthWatchStarted,
      other,
    );
  }

  @override
  int get hashCode {
    return AuthWatchStartedMapper.ensureInitialized().hashValue(
      this as AuthWatchStarted,
    );
  }
}

extension AuthWatchStartedValueCopy<$R, $Out>
    on ObjectCopyWith<$R, AuthWatchStarted, $Out> {
  AuthWatchStartedCopyWith<$R, AuthWatchStarted, $Out>
  get $asAuthWatchStarted =>
      $base.as((v, t, t2) => _AuthWatchStartedCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class AuthWatchStartedCopyWith<$R, $In extends AuthWatchStarted, $Out>
    implements AuthEventCopyWith<$R, $In, $Out> {
  @override
  $R call();
  AuthWatchStartedCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _AuthWatchStartedCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, AuthWatchStarted, $Out>
    implements AuthWatchStartedCopyWith<$R, AuthWatchStarted, $Out> {
  _AuthWatchStartedCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<AuthWatchStarted> $mapper =
      AuthWatchStartedMapper.ensureInitialized();
  @override
  $R call() => $apply(FieldCopyWithData({}));
  @override
  AuthWatchStarted $make(CopyWithData data) => AuthWatchStarted();

  @override
  AuthWatchStartedCopyWith<$R2, AuthWatchStarted, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _AuthWatchStartedCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class AuthGetCurrentUserMapper extends ClassMapperBase<AuthGetCurrentUser> {
  AuthGetCurrentUserMapper._();

  static AuthGetCurrentUserMapper? _instance;
  static AuthGetCurrentUserMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AuthGetCurrentUserMapper._());
      AuthEventMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'AuthGetCurrentUser';

  @override
  final MappableFields<AuthGetCurrentUser> fields = const {};

  static AuthGetCurrentUser _instantiate(DecodingData data) {
    return AuthGetCurrentUser();
  }

  @override
  final Function instantiate = _instantiate;

  static AuthGetCurrentUser fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<AuthGetCurrentUser>(map);
  }

  static AuthGetCurrentUser fromJson(String json) {
    return ensureInitialized().decodeJson<AuthGetCurrentUser>(json);
  }
}

mixin AuthGetCurrentUserMappable {
  String toJson() {
    return AuthGetCurrentUserMapper.ensureInitialized()
        .encodeJson<AuthGetCurrentUser>(this as AuthGetCurrentUser);
  }

  Map<String, dynamic> toMap() {
    return AuthGetCurrentUserMapper.ensureInitialized()
        .encodeMap<AuthGetCurrentUser>(this as AuthGetCurrentUser);
  }

  AuthGetCurrentUserCopyWith<
    AuthGetCurrentUser,
    AuthGetCurrentUser,
    AuthGetCurrentUser
  >
  get copyWith =>
      _AuthGetCurrentUserCopyWithImpl<AuthGetCurrentUser, AuthGetCurrentUser>(
        this as AuthGetCurrentUser,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return AuthGetCurrentUserMapper.ensureInitialized().stringifyValue(
      this as AuthGetCurrentUser,
    );
  }

  @override
  bool operator ==(Object other) {
    return AuthGetCurrentUserMapper.ensureInitialized().equalsValue(
      this as AuthGetCurrentUser,
      other,
    );
  }

  @override
  int get hashCode {
    return AuthGetCurrentUserMapper.ensureInitialized().hashValue(
      this as AuthGetCurrentUser,
    );
  }
}

extension AuthGetCurrentUserValueCopy<$R, $Out>
    on ObjectCopyWith<$R, AuthGetCurrentUser, $Out> {
  AuthGetCurrentUserCopyWith<$R, AuthGetCurrentUser, $Out>
  get $asAuthGetCurrentUser => $base.as(
    (v, t, t2) => _AuthGetCurrentUserCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class AuthGetCurrentUserCopyWith<
  $R,
  $In extends AuthGetCurrentUser,
  $Out
>
    implements AuthEventCopyWith<$R, $In, $Out> {
  @override
  $R call();
  AuthGetCurrentUserCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _AuthGetCurrentUserCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, AuthGetCurrentUser, $Out>
    implements AuthGetCurrentUserCopyWith<$R, AuthGetCurrentUser, $Out> {
  _AuthGetCurrentUserCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<AuthGetCurrentUser> $mapper =
      AuthGetCurrentUserMapper.ensureInitialized();
  @override
  $R call() => $apply(FieldCopyWithData({}));
  @override
  AuthGetCurrentUser $make(CopyWithData data) => AuthGetCurrentUser();

  @override
  AuthGetCurrentUserCopyWith<$R2, AuthGetCurrentUser, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _AuthGetCurrentUserCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class AuthSessionWatchStartedMapper
    extends ClassMapperBase<AuthSessionWatchStarted> {
  AuthSessionWatchStartedMapper._();

  static AuthSessionWatchStartedMapper? _instance;
  static AuthSessionWatchStartedMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(
        _instance = AuthSessionWatchStartedMapper._(),
      );
      AuthEventMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'AuthSessionWatchStarted';

  @override
  final MappableFields<AuthSessionWatchStarted> fields = const {};

  static AuthSessionWatchStarted _instantiate(DecodingData data) {
    return AuthSessionWatchStarted();
  }

  @override
  final Function instantiate = _instantiate;

  static AuthSessionWatchStarted fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<AuthSessionWatchStarted>(map);
  }

  static AuthSessionWatchStarted fromJson(String json) {
    return ensureInitialized().decodeJson<AuthSessionWatchStarted>(json);
  }
}

mixin AuthSessionWatchStartedMappable {
  String toJson() {
    return AuthSessionWatchStartedMapper.ensureInitialized()
        .encodeJson<AuthSessionWatchStarted>(this as AuthSessionWatchStarted);
  }

  Map<String, dynamic> toMap() {
    return AuthSessionWatchStartedMapper.ensureInitialized()
        .encodeMap<AuthSessionWatchStarted>(this as AuthSessionWatchStarted);
  }

  AuthSessionWatchStartedCopyWith<
    AuthSessionWatchStarted,
    AuthSessionWatchStarted,
    AuthSessionWatchStarted
  >
  get copyWith =>
      _AuthSessionWatchStartedCopyWithImpl<
        AuthSessionWatchStarted,
        AuthSessionWatchStarted
      >(this as AuthSessionWatchStarted, $identity, $identity);
  @override
  String toString() {
    return AuthSessionWatchStartedMapper.ensureInitialized().stringifyValue(
      this as AuthSessionWatchStarted,
    );
  }

  @override
  bool operator ==(Object other) {
    return AuthSessionWatchStartedMapper.ensureInitialized().equalsValue(
      this as AuthSessionWatchStarted,
      other,
    );
  }

  @override
  int get hashCode {
    return AuthSessionWatchStartedMapper.ensureInitialized().hashValue(
      this as AuthSessionWatchStarted,
    );
  }
}

extension AuthSessionWatchStartedValueCopy<$R, $Out>
    on ObjectCopyWith<$R, AuthSessionWatchStarted, $Out> {
  AuthSessionWatchStartedCopyWith<$R, AuthSessionWatchStarted, $Out>
  get $asAuthSessionWatchStarted => $base.as(
    (v, t, t2) => _AuthSessionWatchStartedCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class AuthSessionWatchStartedCopyWith<
  $R,
  $In extends AuthSessionWatchStarted,
  $Out
>
    implements AuthEventCopyWith<$R, $In, $Out> {
  @override
  $R call();
  AuthSessionWatchStartedCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _AuthSessionWatchStartedCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, AuthSessionWatchStarted, $Out>
    implements
        AuthSessionWatchStartedCopyWith<$R, AuthSessionWatchStarted, $Out> {
  _AuthSessionWatchStartedCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<AuthSessionWatchStarted> $mapper =
      AuthSessionWatchStartedMapper.ensureInitialized();
  @override
  $R call() => $apply(FieldCopyWithData({}));
  @override
  AuthSessionWatchStarted $make(CopyWithData data) => AuthSessionWatchStarted();

  @override
  AuthSessionWatchStartedCopyWith<$R2, AuthSessionWatchStarted, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _AuthSessionWatchStartedCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class AuthSessionExpiredMapper extends ClassMapperBase<AuthSessionExpired> {
  AuthSessionExpiredMapper._();

  static AuthSessionExpiredMapper? _instance;
  static AuthSessionExpiredMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AuthSessionExpiredMapper._());
      AuthEventMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'AuthSessionExpired';

  @override
  final MappableFields<AuthSessionExpired> fields = const {};

  static AuthSessionExpired _instantiate(DecodingData data) {
    return AuthSessionExpired();
  }

  @override
  final Function instantiate = _instantiate;

  static AuthSessionExpired fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<AuthSessionExpired>(map);
  }

  static AuthSessionExpired fromJson(String json) {
    return ensureInitialized().decodeJson<AuthSessionExpired>(json);
  }
}

mixin AuthSessionExpiredMappable {
  String toJson() {
    return AuthSessionExpiredMapper.ensureInitialized()
        .encodeJson<AuthSessionExpired>(this as AuthSessionExpired);
  }

  Map<String, dynamic> toMap() {
    return AuthSessionExpiredMapper.ensureInitialized()
        .encodeMap<AuthSessionExpired>(this as AuthSessionExpired);
  }

  AuthSessionExpiredCopyWith<
    AuthSessionExpired,
    AuthSessionExpired,
    AuthSessionExpired
  >
  get copyWith =>
      _AuthSessionExpiredCopyWithImpl<AuthSessionExpired, AuthSessionExpired>(
        this as AuthSessionExpired,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return AuthSessionExpiredMapper.ensureInitialized().stringifyValue(
      this as AuthSessionExpired,
    );
  }

  @override
  bool operator ==(Object other) {
    return AuthSessionExpiredMapper.ensureInitialized().equalsValue(
      this as AuthSessionExpired,
      other,
    );
  }

  @override
  int get hashCode {
    return AuthSessionExpiredMapper.ensureInitialized().hashValue(
      this as AuthSessionExpired,
    );
  }
}

extension AuthSessionExpiredValueCopy<$R, $Out>
    on ObjectCopyWith<$R, AuthSessionExpired, $Out> {
  AuthSessionExpiredCopyWith<$R, AuthSessionExpired, $Out>
  get $asAuthSessionExpired => $base.as(
    (v, t, t2) => _AuthSessionExpiredCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class AuthSessionExpiredCopyWith<
  $R,
  $In extends AuthSessionExpired,
  $Out
>
    implements AuthEventCopyWith<$R, $In, $Out> {
  @override
  $R call();
  AuthSessionExpiredCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _AuthSessionExpiredCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, AuthSessionExpired, $Out>
    implements AuthSessionExpiredCopyWith<$R, AuthSessionExpired, $Out> {
  _AuthSessionExpiredCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<AuthSessionExpired> $mapper =
      AuthSessionExpiredMapper.ensureInitialized();
  @override
  $R call() => $apply(FieldCopyWithData({}));
  @override
  AuthSessionExpired $make(CopyWithData data) => AuthSessionExpired();

  @override
  AuthSessionExpiredCopyWith<$R2, AuthSessionExpired, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _AuthSessionExpiredCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

