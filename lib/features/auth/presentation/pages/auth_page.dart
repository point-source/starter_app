import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starter_app/core/constants/constants.dart';
import 'package:starter_app/core/navigation/app_router.dart';
import 'package:starter_app/core/presentation/extensions/context_extensions.dart';
import 'package:starter_app/core/presentation/models/error_model.dart';
import 'package:starter_app/core/presentation/responsive/responsive.dart';
import 'package:starter_app/core/presentation/services/failure_message_service.dart';
import 'package:starter_app/core/presentation/widgets/widgets.dart';
import 'package:starter_app/features/auth/l10n/l10n_extensions.dart';
import 'package:starter_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:starter_app/features/auth/presentation/bloc/auth_event.dart';
import 'package:starter_app/features/auth/presentation/bloc/auth_state.dart';

import 'package:starter_app/features/auth/presentation/widgets/email_form.dart';

part '../widgets/login_form.dart';
part '../widgets/register_form.dart';

@RoutePage()
final class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) async {
        final error = switch (state) {
          AuthInitial() => state.error,
          LoginRequired() => state.error,
          RegistrationRequired() => state.error,
          _ => null,
        };

        if (error != null) {
          final messageService = context.read<FailureMessageService>();
          final message = error.getMessage(context, messageService);

          context.showSnackBar(
            message: message,
            action: error.isRetryable
                ? SnackBarAction(
                    label: context.authL10n.retry,
                    onPressed: () => _retryLastAction(context),
                  )
                : null,
          );
          return;
        }

        if (state case Authenticated()) {
          if (context.router.canPop()) {
            context.router.pop(true);
          } else {
            await context.router.replace(const DashboardRoute());
          }
        }
      },
      builder: (context, state) {
        final isSubmitting = switch (state) {
          AuthInitial() => state.isSubmitting,
          LoginRequired() => state.isSubmitting,
          RegistrationRequired() => state.isSubmitting,
          _ => false,
        };

        const emailValueKey = ValueKey('email');
        const loginValueKey = ValueKey('login');
        const registerValueKey = ValueKey('register');
        const loadingValueKey = ValueKey('loading');

        return LoadingOverlay(
          isLoading: isSubmitting,
          child: Scaffold(
            floatingActionButton: Padding(
              padding: PaddingWidgets.allMedium,
              child: TextButton(
                onPressed: () =>
                    context.router.navigate(const DashboardRoute()),
                child: Text(context.authL10n.returnHome),
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            body: AnimatedSwitcher(
              duration: DurationConstants.animationMedium,
              transitionBuilder: (child, animation) {
                return FadeTransition(
                  opacity: animation,
                  child: SlideTransition(
                    position:
                        Tween<Offset>(
                          begin: const Offset(0, 0.1),
                          end: Offset.zero,
                        ).animate(
                          CurvedAnimation(
                            parent: animation,
                            curve: Curves.easeOutCubic,
                          ),
                        ),
                    child: child,
                  ),
                );
              },
              child: switch (state) {
                AuthInitial() => EmailForm(
                  key: emailValueKey,
                  email: state.email,
                  showError: state.validation.emailTouched,
                  onEmailChanged: (email) => context.read<AuthBloc>().add(
                    AuthEmailChanged(email),
                  ),
                  onEmailUnfocused: () => context.read<AuthBloc>().add(
                    const AuthEmailUnfocused(),
                  ),
                  onSubmitted: () => context.read<AuthBloc>().add(
                    const AuthEmailSubmitted(),
                  ),
                ),
                LoginRequired() => _LoginForm(
                  key: loginValueKey,
                  state: state,
                ),
                RegistrationRequired() => _RegisterForm(
                  key: registerValueKey,
                  state: state,
                ),
                _ => const Center(
                  key: loadingValueKey,
                  child: CircularProgressIndicator(),
                ),
              },
            ),
          ),
        );
      },
    );
  }

  /// Retries the last action based on current auth state.
  void _retryLastAction(BuildContext context) {
    final state = context.read<AuthBloc>().state;
    switch (state) {
      case AuthInitial():
        context.read<AuthBloc>().add(const AuthEmailSubmitted());
      case LoginRequired():
        context.read<AuthBloc>().add(const AuthLoginSubmitted());
      case RegistrationRequired():
        context.read<AuthBloc>().add(const AuthRegisterSubmitted());
      case Authenticated():
      case Unauthenticated():
        break;
    }
  }
}
