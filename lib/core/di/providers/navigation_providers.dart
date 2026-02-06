import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:starter_app/core/navigation/app_router.dart';
import 'package:starter_app/core/navigation/auth_change_notifier.dart';
import 'package:starter_app/features/auth/di/auth_providers.dart';

part 'navigation_providers.g.dart';

@Riverpod(keepAlive: true)
AuthChangeNotifier authChangeNotifier(AuthChangeNotifierRef ref) {
  final authBloc = ref.watch(authBlocProvider);
  final notifier = AuthChangeNotifier(authBloc);
  ref.onDispose(() => notifier.dispose());
  return notifier;
}

@Riverpod(keepAlive: true)
AppRouter appRouter(AppRouterRef ref) {
  final authChangeNotifier = ref.watch(authChangeNotifierProvider);
  return AppRouter(authChangeNotifier);
}
