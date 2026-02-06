import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:starter_app/core/domain/base/domain_event.dart';
import 'package:starter_app/core/domain/base/event_dispatcher.dart';
import 'package:starter_app/core/presentation/models/error_model.dart';
import 'package:starter_app/features/auth/domain/events/auth_events.dart';
import 'package:starter_app/features/profile/application/usecases/get_profile.dart';
import 'package:starter_app/features/profile/presentation/bloc/profile_event.dart';
import 'package:starter_app/features/profile/presentation/bloc/profile_state.dart';

@injectable
class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc(
    this._getProfile,
    this._eventDispatcher,
  ) : super(const ProfileInitial()) {
    on<ProfileEvent>((event, emit) async {
      await switch (event) {
        GetMyProfile() => _onGetMyProfile(emit),
        ProfileReset() => _onReset(emit),
      };
    });

    _setupEventListeners();
  }

  final GetProfile _getProfile;
  final IEventDispatcher _eventDispatcher;
  StreamSubscription<DomainEvent>? _eventSubscription;

  /// Listen to cross-feature domain events.
  /// Auto-triggers profile fetch on login/registration/session restore.
  void _setupEventListeners() {
    _eventSubscription = _eventDispatcher.on<AuthDomainEvent>().listen((event) {
      final profileEvent = switch (event) {
        UserRegistered() ||
        UserLoggedIn() ||
        UserSessionRestored() => const GetMyProfile(),
        UserLoggedOut() => const ProfileReset(),
      };

      add(profileEvent);
    });
  }

  Future<void> _onReset(Emitter<ProfileState> emit) async {
    emit(const ProfileInitial());
  }

  Future<void> _onGetMyProfile(Emitter<ProfileState> emit) async {
    emit(const ProfileLoading());
    final result = await _getProfile();
    result.fold(
      (failure) => emit(ProfileError(ErrorModel.fromFailure(failure))),
      (profile) => emit(ProfileLoaded(profile)),
    );
  }

  @override
  Future<void> close() async {
    await _eventSubscription?.cancel();
    return super.close();
  }
}
