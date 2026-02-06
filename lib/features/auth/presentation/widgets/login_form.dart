part of '../pages/auth_page.dart';

final class _LoginForm extends StatelessWidget {
  const _LoginForm({required this.state, super.key});
  final LoginRequired state;

  @override
  Widget build(BuildContext context) {
    return ResponsiveContainer(
      maxWidth: ContentWidthConstants.form,
      child: ResponsivePadding(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(context.authL10n.welcomeBack(state.email.getOrCrash())),
            const ResponsiveVerticalGap(),
            PasswordTextField(
              password: state.password,
              showError: state.validation.passwordTouched,
              obscureText: !state.passwordVisible,
              onToggleVisibility: () => context.read<AuthBloc>().add(
                const AuthTogglePasswordVisibility(),
              ),
              label: context.authL10n.passwordLabel,
              onChanged: (password) => context.read<AuthBloc>().add(
                AuthPasswordChanged(password),
              ),
              onEditingComplete: () => context.read<AuthBloc>().add(
                const AuthPasswordUnfocused(),
              ),
              onSubmitted: (password) => context.read<AuthBloc>().add(
                const AuthLoginSubmitted(),
              ),
            ),
            const ResponsiveVerticalGap(),
            ElevatedButton(
              onPressed: () => context.read<AuthBloc>().add(
                const AuthLoginSubmitted(),
              ),
              child: Text(context.authL10n.login),
            ),
            const ResponsiveVerticalGap(),
            TextButton(
              onPressed: () => context.read<AuthBloc>().add(
                const AuthEmailChanged(''),
              ),
              child: Text(context.authL10n.differentEmail),
            ),
          ],
        ),
      ),
    );
  }
}
