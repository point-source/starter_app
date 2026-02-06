import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starter_app/core/presentation/models/error_model.dart';
import 'package:starter_app/core/presentation/services/failure_message_service.dart';
import 'package:starter_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:starter_app/features/auth/presentation/bloc/auth_state.dart';
import 'package:starter_app/features/profile/l10n/l10n_extensions.dart';
import 'package:starter_app/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:starter_app/features/profile/presentation/bloc/profile_state.dart';
import 'package:starter_app/features/profile/presentation/widgets/login_button.dart';
import 'package:starter_app/features/profile/presentation/widgets/profile_content.dart';

/// Profile page with language and theme settings.
@RoutePage()
final class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.profileL10n;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.appBarTitle)),
      body: Center(
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, authState) {
            return switch (authState) {
              Authenticated() => const _ProfileView(),
              _ => const LoginButton(),
            };
          },
        ),
      ),
    );
  }
}

final class _ProfileView extends StatelessWidget {
  const _ProfileView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        return switch (state) {
          ProfileInitial() => const SizedBox.shrink(),
          ProfileLoading() => const CircularProgressIndicator(),
          ProfileError() => Text(
            state.error.getMessage(
              context,
              context.read<FailureMessageService>(),
            ),
            textAlign: TextAlign.center,
          ),
          ProfileLoaded(profile: final profile) => ProfileContent(
            profile: profile,
          ),
        };
      },
    );
  }
}
