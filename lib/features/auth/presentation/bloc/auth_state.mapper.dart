// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'auth_state.dart';

class AuthStateMapper extends ClassMapperBase<AuthState> {
  AuthStateMapper._();

  static AuthStateMapper? _instance;
  static AuthStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AuthStateMapper._());
      AuthInitialMapper.ensureInitialized();
      UnauthenticatedMapper.ensureInitialized();
      RegistrationRequiredMapper.ensureInitialized();
      LoginRequiredMapper.ensureInitialized();
      AuthenticatedMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'AuthState';

  @override
  final MappableFields<AuthState> fields = const {};

  static AuthState _instantiate(DecodingData data) {
    throw MapperException.missingConstructor('AuthState');
  }

  @override
  final Function instantiate = _instantiate;

  static AuthState fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<AuthState>(map);
  }

  static AuthState fromJson(String json) {
    return ensureInitialized().decodeJson<AuthState>(json);
  }
}

mixin AuthStateMappable {
  String toJson();
  Map<String, dynamic> toMap();
  AuthStateCopyWith<AuthState, AuthState, AuthState> get copyWith;
}

abstract class AuthStateCopyWith<$R, $In extends AuthState, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call();
  AuthStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class AuthInitialMapper extends ClassMapperBase<AuthInitial> {
  AuthInitialMapper._();

  static AuthInitialMapper? _instance;
  static AuthInitialMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AuthInitialMapper._());
      AuthStateMapper.ensureInitialized();
      FieldValidationStateMapper.ensureInitialized();
      ErrorModelMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'AuthInitial';

  static EmailAddress _$email(AuthInitial v) => v.email;
  static const Field<AuthInitial, EmailAddress> _f$email =
      Field('email', _$email);
  static bool _$isSubmitting(AuthInitial v) => v.isSubmitting;
  static const Field<AuthInitial, bool> _f$isSubmitting =
      Field('isSubmitting', _$isSubmitting);
  static FieldValidationState _$validation(AuthInitial v) => v.validation;
  static const Field<AuthInitial, FieldValidationState> _f$validation =
      Field('validation', _$validation);
  static ErrorModel? _$error(AuthInitial v) => v.error;
  static const Field<AuthInitial, ErrorModel> _f$error =
      Field('error', _$error, opt: true);

  @override
  final MappableFields<AuthInitial> fields = const {
    #email: _f$email,
    #isSubmitting: _f$isSubmitting,
    #validation: _f$validation,
    #error: _f$error,
  };

  static AuthInitial _instantiate(DecodingData data) {
    return AuthInitial(
        email: data.dec(_f$email),
        isSubmitting: data.dec(_f$isSubmitting),
        validation: data.dec(_f$validation),
        error: data.dec(_f$error));
  }

  @override
  final Function instantiate = _instantiate;

  static AuthInitial fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<AuthInitial>(map);
  }

  static AuthInitial fromJson(String json) {
    return ensureInitialized().decodeJson<AuthInitial>(json);
  }
}

mixin AuthInitialMappable {
  String toJson() {
    return AuthInitialMapper.ensureInitialized()
        .encodeJson<AuthInitial>(this as AuthInitial);
  }

  Map<String, dynamic> toMap() {
    return AuthInitialMapper.ensureInitialized()
        .encodeMap<AuthInitial>(this as AuthInitial);
  }

  AuthInitialCopyWith<AuthInitial, AuthInitial, AuthInitial> get copyWith =>
      _AuthInitialCopyWithImpl<AuthInitial, AuthInitial>(
          this as AuthInitial, $identity, $identity);
  @override
  String toString() {
    return AuthInitialMapper.ensureInitialized()
        .stringifyValue(this as AuthInitial);
  }

  @override
  bool operator ==(Object other) {
    return AuthInitialMapper.ensureInitialized()
        .equalsValue(this as AuthInitial, other);
  }

  @override
  int get hashCode {
    return AuthInitialMapper.ensureInitialized().hashValue(this as AuthInitial);
  }
}

extension AuthInitialValueCopy<$R, $Out>
    on ObjectCopyWith<$R, AuthInitial, $Out> {
  AuthInitialCopyWith<$R, AuthInitial, $Out> get $asAuthInitial =>
      $base.as((v, t, t2) => _AuthInitialCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class AuthInitialCopyWith<$R, $In extends AuthInitial, $Out>
    implements AuthStateCopyWith<$R, $In, $Out> {
  FieldValidationStateCopyWith<$R, FieldValidationState, FieldValidationState>
      get validation;
  ErrorModelCopyWith<$R, ErrorModel, ErrorModel>? get error;
  @override
  $R call(
      {EmailAddress? email,
      bool? isSubmitting,
      FieldValidationState? validation,
      ErrorModel? error});
  AuthInitialCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _AuthInitialCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, AuthInitial, $Out>
    implements AuthInitialCopyWith<$R, AuthInitial, $Out> {
  _AuthInitialCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<AuthInitial> $mapper =
      AuthInitialMapper.ensureInitialized();
  @override
  FieldValidationStateCopyWith<$R, FieldValidationState, FieldValidationState>
      get validation =>
          $value.validation.copyWith.$chain((v) => call(validation: v));
  @override
  ErrorModelCopyWith<$R, ErrorModel, ErrorModel>? get error =>
      $value.error?.copyWith.$chain((v) => call(error: v));
  @override
  $R call(
          {EmailAddress? email,
          bool? isSubmitting,
          FieldValidationState? validation,
          Object? error = $none}) =>
      $apply(FieldCopyWithData({
        if (email != null) #email: email,
        if (isSubmitting != null) #isSubmitting: isSubmitting,
        if (validation != null) #validation: validation,
        if (error != $none) #error: error
      }));
  @override
  AuthInitial $make(CopyWithData data) => AuthInitial(
      email: data.get(#email, or: $value.email),
      isSubmitting: data.get(#isSubmitting, or: $value.isSubmitting),
      validation: data.get(#validation, or: $value.validation),
      error: data.get(#error, or: $value.error));

  @override
  AuthInitialCopyWith<$R2, AuthInitial, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _AuthInitialCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class UnauthenticatedMapper extends ClassMapperBase<Unauthenticated> {
  UnauthenticatedMapper._();

  static UnauthenticatedMapper? _instance;
  static UnauthenticatedMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = UnauthenticatedMapper._());
      AuthStateMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'Unauthenticated';

  @override
  final MappableFields<Unauthenticated> fields = const {};

  static Unauthenticated _instantiate(DecodingData data) {
    return Unauthenticated();
  }

  @override
  final Function instantiate = _instantiate;

  static Unauthenticated fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Unauthenticated>(map);
  }

  static Unauthenticated fromJson(String json) {
    return ensureInitialized().decodeJson<Unauthenticated>(json);
  }
}

mixin UnauthenticatedMappable {
  String toJson() {
    return UnauthenticatedMapper.ensureInitialized()
        .encodeJson<Unauthenticated>(this as Unauthenticated);
  }

  Map<String, dynamic> toMap() {
    return UnauthenticatedMapper.ensureInitialized()
        .encodeMap<Unauthenticated>(this as Unauthenticated);
  }

  UnauthenticatedCopyWith<Unauthenticated, Unauthenticated, Unauthenticated>
      get copyWith =>
          _UnauthenticatedCopyWithImpl<Unauthenticated, Unauthenticated>(
              this as Unauthenticated, $identity, $identity);
  @override
  String toString() {
    return UnauthenticatedMapper.ensureInitialized()
        .stringifyValue(this as Unauthenticated);
  }

  @override
  bool operator ==(Object other) {
    return UnauthenticatedMapper.ensureInitialized()
        .equalsValue(this as Unauthenticated, other);
  }

  @override
  int get hashCode {
    return UnauthenticatedMapper.ensureInitialized()
        .hashValue(this as Unauthenticated);
  }
}

extension UnauthenticatedValueCopy<$R, $Out>
    on ObjectCopyWith<$R, Unauthenticated, $Out> {
  UnauthenticatedCopyWith<$R, Unauthenticated, $Out> get $asUnauthenticated =>
      $base.as((v, t, t2) => _UnauthenticatedCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class UnauthenticatedCopyWith<$R, $In extends Unauthenticated, $Out>
    implements AuthStateCopyWith<$R, $In, $Out> {
  @override
  $R call();
  UnauthenticatedCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _UnauthenticatedCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, Unauthenticated, $Out>
    implements UnauthenticatedCopyWith<$R, Unauthenticated, $Out> {
  _UnauthenticatedCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Unauthenticated> $mapper =
      UnauthenticatedMapper.ensureInitialized();
  @override
  $R call() => $apply(FieldCopyWithData({}));
  @override
  Unauthenticated $make(CopyWithData data) => Unauthenticated();

  @override
  UnauthenticatedCopyWith<$R2, Unauthenticated, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _UnauthenticatedCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class RegistrationRequiredMapper extends ClassMapperBase<RegistrationRequired> {
  RegistrationRequiredMapper._();

  static RegistrationRequiredMapper? _instance;
  static RegistrationRequiredMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = RegistrationRequiredMapper._());
      AuthStateMapper.ensureInitialized();
      FieldValidationStateMapper.ensureInitialized();
      ErrorModelMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'RegistrationRequired';

  static EmailAddress _$email(RegistrationRequired v) => v.email;
  static const Field<RegistrationRequired, EmailAddress> _f$email =
      Field('email', _$email);
  static Password _$password(RegistrationRequired v) => v.password;
  static const Field<RegistrationRequired, Password> _f$password =
      Field('password', _$password);
  static Name _$name(RegistrationRequired v) => v.name;
  static const Field<RegistrationRequired, Name> _f$name =
      Field('name', _$name);
  static bool _$isSubmitting(RegistrationRequired v) => v.isSubmitting;
  static const Field<RegistrationRequired, bool> _f$isSubmitting =
      Field('isSubmitting', _$isSubmitting);
  static FieldValidationState _$validation(RegistrationRequired v) =>
      v.validation;
  static const Field<RegistrationRequired, FieldValidationState> _f$validation =
      Field('validation', _$validation);
  static bool _$passwordVisible(RegistrationRequired v) => v.passwordVisible;
  static const Field<RegistrationRequired, bool> _f$passwordVisible =
      Field('passwordVisible', _$passwordVisible, opt: true, def: false);
  static ErrorModel? _$error(RegistrationRequired v) => v.error;
  static const Field<RegistrationRequired, ErrorModel> _f$error =
      Field('error', _$error, opt: true);

  @override
  final MappableFields<RegistrationRequired> fields = const {
    #email: _f$email,
    #password: _f$password,
    #name: _f$name,
    #isSubmitting: _f$isSubmitting,
    #validation: _f$validation,
    #passwordVisible: _f$passwordVisible,
    #error: _f$error,
  };

  static RegistrationRequired _instantiate(DecodingData data) {
    return RegistrationRequired(
        email: data.dec(_f$email),
        password: data.dec(_f$password),
        name: data.dec(_f$name),
        isSubmitting: data.dec(_f$isSubmitting),
        validation: data.dec(_f$validation),
        passwordVisible: data.dec(_f$passwordVisible),
        error: data.dec(_f$error));
  }

  @override
  final Function instantiate = _instantiate;

  static RegistrationRequired fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<RegistrationRequired>(map);
  }

  static RegistrationRequired fromJson(String json) {
    return ensureInitialized().decodeJson<RegistrationRequired>(json);
  }
}

mixin RegistrationRequiredMappable {
  String toJson() {
    return RegistrationRequiredMapper.ensureInitialized()
        .encodeJson<RegistrationRequired>(this as RegistrationRequired);
  }

  Map<String, dynamic> toMap() {
    return RegistrationRequiredMapper.ensureInitialized()
        .encodeMap<RegistrationRequired>(this as RegistrationRequired);
  }

  RegistrationRequiredCopyWith<RegistrationRequired, RegistrationRequired,
      RegistrationRequired> get copyWith => _RegistrationRequiredCopyWithImpl<
          RegistrationRequired, RegistrationRequired>(
      this as RegistrationRequired, $identity, $identity);
  @override
  String toString() {
    return RegistrationRequiredMapper.ensureInitialized()
        .stringifyValue(this as RegistrationRequired);
  }

  @override
  bool operator ==(Object other) {
    return RegistrationRequiredMapper.ensureInitialized()
        .equalsValue(this as RegistrationRequired, other);
  }

  @override
  int get hashCode {
    return RegistrationRequiredMapper.ensureInitialized()
        .hashValue(this as RegistrationRequired);
  }
}

extension RegistrationRequiredValueCopy<$R, $Out>
    on ObjectCopyWith<$R, RegistrationRequired, $Out> {
  RegistrationRequiredCopyWith<$R, RegistrationRequired, $Out>
      get $asRegistrationRequired => $base.as(
          (v, t, t2) => _RegistrationRequiredCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class RegistrationRequiredCopyWith<
    $R,
    $In extends RegistrationRequired,
    $Out> implements AuthStateCopyWith<$R, $In, $Out> {
  FieldValidationStateCopyWith<$R, FieldValidationState, FieldValidationState>
      get validation;
  ErrorModelCopyWith<$R, ErrorModel, ErrorModel>? get error;
  @override
  $R call(
      {EmailAddress? email,
      Password? password,
      Name? name,
      bool? isSubmitting,
      FieldValidationState? validation,
      bool? passwordVisible,
      ErrorModel? error});
  RegistrationRequiredCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _RegistrationRequiredCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, RegistrationRequired, $Out>
    implements RegistrationRequiredCopyWith<$R, RegistrationRequired, $Out> {
  _RegistrationRequiredCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<RegistrationRequired> $mapper =
      RegistrationRequiredMapper.ensureInitialized();
  @override
  FieldValidationStateCopyWith<$R, FieldValidationState, FieldValidationState>
      get validation =>
          $value.validation.copyWith.$chain((v) => call(validation: v));
  @override
  ErrorModelCopyWith<$R, ErrorModel, ErrorModel>? get error =>
      $value.error?.copyWith.$chain((v) => call(error: v));
  @override
  $R call(
          {EmailAddress? email,
          Password? password,
          Name? name,
          bool? isSubmitting,
          FieldValidationState? validation,
          bool? passwordVisible,
          Object? error = $none}) =>
      $apply(FieldCopyWithData({
        if (email != null) #email: email,
        if (password != null) #password: password,
        if (name != null) #name: name,
        if (isSubmitting != null) #isSubmitting: isSubmitting,
        if (validation != null) #validation: validation,
        if (passwordVisible != null) #passwordVisible: passwordVisible,
        if (error != $none) #error: error
      }));
  @override
  RegistrationRequired $make(CopyWithData data) => RegistrationRequired(
      email: data.get(#email, or: $value.email),
      password: data.get(#password, or: $value.password),
      name: data.get(#name, or: $value.name),
      isSubmitting: data.get(#isSubmitting, or: $value.isSubmitting),
      validation: data.get(#validation, or: $value.validation),
      passwordVisible: data.get(#passwordVisible, or: $value.passwordVisible),
      error: data.get(#error, or: $value.error));

  @override
  RegistrationRequiredCopyWith<$R2, RegistrationRequired, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _RegistrationRequiredCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class LoginRequiredMapper extends ClassMapperBase<LoginRequired> {
  LoginRequiredMapper._();

  static LoginRequiredMapper? _instance;
  static LoginRequiredMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = LoginRequiredMapper._());
      AuthStateMapper.ensureInitialized();
      FieldValidationStateMapper.ensureInitialized();
      ErrorModelMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'LoginRequired';

  static EmailAddress _$email(LoginRequired v) => v.email;
  static const Field<LoginRequired, EmailAddress> _f$email =
      Field('email', _$email);
  static Password _$password(LoginRequired v) => v.password;
  static const Field<LoginRequired, Password> _f$password =
      Field('password', _$password);
  static bool _$isSubmitting(LoginRequired v) => v.isSubmitting;
  static const Field<LoginRequired, bool> _f$isSubmitting =
      Field('isSubmitting', _$isSubmitting);
  static FieldValidationState _$validation(LoginRequired v) => v.validation;
  static const Field<LoginRequired, FieldValidationState> _f$validation =
      Field('validation', _$validation);
  static bool _$passwordVisible(LoginRequired v) => v.passwordVisible;
  static const Field<LoginRequired, bool> _f$passwordVisible =
      Field('passwordVisible', _$passwordVisible, opt: true, def: false);
  static ErrorModel? _$error(LoginRequired v) => v.error;
  static const Field<LoginRequired, ErrorModel> _f$error =
      Field('error', _$error, opt: true);

  @override
  final MappableFields<LoginRequired> fields = const {
    #email: _f$email,
    #password: _f$password,
    #isSubmitting: _f$isSubmitting,
    #validation: _f$validation,
    #passwordVisible: _f$passwordVisible,
    #error: _f$error,
  };

  static LoginRequired _instantiate(DecodingData data) {
    return LoginRequired(
        email: data.dec(_f$email),
        password: data.dec(_f$password),
        isSubmitting: data.dec(_f$isSubmitting),
        validation: data.dec(_f$validation),
        passwordVisible: data.dec(_f$passwordVisible),
        error: data.dec(_f$error));
  }

  @override
  final Function instantiate = _instantiate;

  static LoginRequired fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<LoginRequired>(map);
  }

  static LoginRequired fromJson(String json) {
    return ensureInitialized().decodeJson<LoginRequired>(json);
  }
}

mixin LoginRequiredMappable {
  String toJson() {
    return LoginRequiredMapper.ensureInitialized()
        .encodeJson<LoginRequired>(this as LoginRequired);
  }

  Map<String, dynamic> toMap() {
    return LoginRequiredMapper.ensureInitialized()
        .encodeMap<LoginRequired>(this as LoginRequired);
  }

  LoginRequiredCopyWith<LoginRequired, LoginRequired, LoginRequired>
      get copyWith => _LoginRequiredCopyWithImpl<LoginRequired, LoginRequired>(
          this as LoginRequired, $identity, $identity);
  @override
  String toString() {
    return LoginRequiredMapper.ensureInitialized()
        .stringifyValue(this as LoginRequired);
  }

  @override
  bool operator ==(Object other) {
    return LoginRequiredMapper.ensureInitialized()
        .equalsValue(this as LoginRequired, other);
  }

  @override
  int get hashCode {
    return LoginRequiredMapper.ensureInitialized()
        .hashValue(this as LoginRequired);
  }
}

extension LoginRequiredValueCopy<$R, $Out>
    on ObjectCopyWith<$R, LoginRequired, $Out> {
  LoginRequiredCopyWith<$R, LoginRequired, $Out> get $asLoginRequired =>
      $base.as((v, t, t2) => _LoginRequiredCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class LoginRequiredCopyWith<$R, $In extends LoginRequired, $Out>
    implements AuthStateCopyWith<$R, $In, $Out> {
  FieldValidationStateCopyWith<$R, FieldValidationState, FieldValidationState>
      get validation;
  ErrorModelCopyWith<$R, ErrorModel, ErrorModel>? get error;
  @override
  $R call(
      {EmailAddress? email,
      Password? password,
      bool? isSubmitting,
      FieldValidationState? validation,
      bool? passwordVisible,
      ErrorModel? error});
  LoginRequiredCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _LoginRequiredCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, LoginRequired, $Out>
    implements LoginRequiredCopyWith<$R, LoginRequired, $Out> {
  _LoginRequiredCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<LoginRequired> $mapper =
      LoginRequiredMapper.ensureInitialized();
  @override
  FieldValidationStateCopyWith<$R, FieldValidationState, FieldValidationState>
      get validation =>
          $value.validation.copyWith.$chain((v) => call(validation: v));
  @override
  ErrorModelCopyWith<$R, ErrorModel, ErrorModel>? get error =>
      $value.error?.copyWith.$chain((v) => call(error: v));
  @override
  $R call(
          {EmailAddress? email,
          Password? password,
          bool? isSubmitting,
          FieldValidationState? validation,
          bool? passwordVisible,
          Object? error = $none}) =>
      $apply(FieldCopyWithData({
        if (email != null) #email: email,
        if (password != null) #password: password,
        if (isSubmitting != null) #isSubmitting: isSubmitting,
        if (validation != null) #validation: validation,
        if (passwordVisible != null) #passwordVisible: passwordVisible,
        if (error != $none) #error: error
      }));
  @override
  LoginRequired $make(CopyWithData data) => LoginRequired(
      email: data.get(#email, or: $value.email),
      password: data.get(#password, or: $value.password),
      isSubmitting: data.get(#isSubmitting, or: $value.isSubmitting),
      validation: data.get(#validation, or: $value.validation),
      passwordVisible: data.get(#passwordVisible, or: $value.passwordVisible),
      error: data.get(#error, or: $value.error));

  @override
  LoginRequiredCopyWith<$R2, LoginRequired, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _LoginRequiredCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class AuthenticatedMapper extends ClassMapperBase<Authenticated> {
  AuthenticatedMapper._();

  static AuthenticatedMapper? _instance;
  static AuthenticatedMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AuthenticatedMapper._());
      AuthStateMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'Authenticated';

  static User _$user(Authenticated v) => v.user;
  static const Field<Authenticated, User> _f$user = Field('user', _$user);

  @override
  final MappableFields<Authenticated> fields = const {
    #user: _f$user,
  };

  static Authenticated _instantiate(DecodingData data) {
    return Authenticated(data.dec(_f$user));
  }

  @override
  final Function instantiate = _instantiate;

  static Authenticated fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Authenticated>(map);
  }

  static Authenticated fromJson(String json) {
    return ensureInitialized().decodeJson<Authenticated>(json);
  }
}

mixin AuthenticatedMappable {
  String toJson() {
    return AuthenticatedMapper.ensureInitialized()
        .encodeJson<Authenticated>(this as Authenticated);
  }

  Map<String, dynamic> toMap() {
    return AuthenticatedMapper.ensureInitialized()
        .encodeMap<Authenticated>(this as Authenticated);
  }

  AuthenticatedCopyWith<Authenticated, Authenticated, Authenticated>
      get copyWith => _AuthenticatedCopyWithImpl<Authenticated, Authenticated>(
          this as Authenticated, $identity, $identity);
  @override
  String toString() {
    return AuthenticatedMapper.ensureInitialized()
        .stringifyValue(this as Authenticated);
  }

  @override
  bool operator ==(Object other) {
    return AuthenticatedMapper.ensureInitialized()
        .equalsValue(this as Authenticated, other);
  }

  @override
  int get hashCode {
    return AuthenticatedMapper.ensureInitialized()
        .hashValue(this as Authenticated);
  }
}

extension AuthenticatedValueCopy<$R, $Out>
    on ObjectCopyWith<$R, Authenticated, $Out> {
  AuthenticatedCopyWith<$R, Authenticated, $Out> get $asAuthenticated =>
      $base.as((v, t, t2) => _AuthenticatedCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class AuthenticatedCopyWith<$R, $In extends Authenticated, $Out>
    implements AuthStateCopyWith<$R, $In, $Out> {
  @override
  $R call({User? user});
  AuthenticatedCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _AuthenticatedCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, Authenticated, $Out>
    implements AuthenticatedCopyWith<$R, Authenticated, $Out> {
  _AuthenticatedCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Authenticated> $mapper =
      AuthenticatedMapper.ensureInitialized();
  @override
  $R call({User? user}) =>
      $apply(FieldCopyWithData({if (user != null) #user: user}));
  @override
  Authenticated $make(CopyWithData data) =>
      Authenticated(data.get(#user, or: $value.user));

  @override
  AuthenticatedCopyWith<$R2, Authenticated, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _AuthenticatedCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
