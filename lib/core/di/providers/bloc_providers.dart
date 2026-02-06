import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:starter_app/core/di/providers/logging_providers.dart';
import 'package:starter_app/core/presentation/bloc/app_bloc_observer.dart';
import 'package:starter_app/core/presentation/bloc/locale_cubit.dart';
import 'package:starter_app/core/presentation/bloc/theme_cubit.dart';
import 'package:starter_app/core/types/app_locale.dart';
import 'package:starter_app/core/types/app_theme_mode.dart';

part 'bloc_providers.g.dart';

@Riverpod(keepAlive: true)
BlocObserver blocObserver(BlocObserverRef ref) {
  final logger = ref.watch(appLoggerProvider);
  return AppBlocObserver(logger);
}

@Riverpod(keepAlive: true)
ThemeCubit themeCubit(ThemeCubitRef ref) {
  final cubit = ThemeCubit(AppThemeMode.system);
  ref.onDispose(() => cubit.close());
  return cubit;
}

@Riverpod(keepAlive: true)
LocaleCubit localeCubit(LocaleCubitRef ref) {
  final cubit = LocaleCubit(AppLocale.en);
  ref.onDispose(() => cubit.close());
  return cubit;
}
