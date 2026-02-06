import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:starter_app/core/application/application_environment.dart';

part 'environment_providers.g.dart';

@Riverpod(keepAlive: true)
AppEnvironment appEnvironment(AppEnvironmentRef ref) {
  return AppEnvironment.current;
}
