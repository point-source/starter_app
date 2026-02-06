import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:starter_app/core/presentation/failure_message/email_failure_mapper.dart';
import 'package:starter_app/core/presentation/failure_message/failure_mapper_registry.dart';
import 'package:starter_app/core/presentation/failure_message/infrastructure_failure_mapper.dart';
import 'package:starter_app/core/presentation/failure_message/name_failure_mapper.dart';
import 'package:starter_app/core/presentation/failure_message/password_failure_mapper.dart';
import 'package:starter_app/core/presentation/services/failure_message_service.dart';
import 'package:starter_app/core/theme/app_theme.dart';
import 'package:starter_app/core/di/providers/logging_providers.dart';

part 'presentation_providers.g.dart';

@Riverpod(keepAlive: true)
AppTheme appTheme(AppThemeRef ref) {
  return const AppTheme();
}

@Riverpod(keepAlive: true)
FailureMapperRegistry failureMapperRegistry(FailureMapperRegistryRef ref) {
  return FailureMapperRegistry();
}

@Riverpod(keepAlive: true)
InfrastructureFailureMapper infrastructureFailureMapper(InfrastructureFailureMapperRef ref) {
  final mapper = InfrastructureFailureMapper();
  ref.watch(failureMapperRegistryProvider).register(mapper, highPriority: false);
  return mapper;
}

@Riverpod(keepAlive: true)
PasswordFailureMapper passwordFailureMapper(PasswordFailureMapperRef ref) {
  final mapper = PasswordFailureMapper();
  ref.watch(failureMapperRegistryProvider).register(mapper, highPriority: false);
  return mapper;
}

@Riverpod(keepAlive: true)
EmailFailureMapper emailFailureMapper(EmailFailureMapperRef ref) {
  final mapper = EmailFailureMapper();
  ref.watch(failureMapperRegistryProvider).register(mapper, highPriority: false);
  return mapper;
}

@Riverpod(keepAlive: true)
NameFailureMapper nameFailureMapper(NameFailureMapperRef ref) {
  final mapper = NameFailureMapper();
  ref.watch(failureMapperRegistryProvider).register(mapper, highPriority: false);
  return mapper;
}

@Riverpod(keepAlive: true)
FailureMessageService failureMessageService(FailureMessageServiceRef ref) {
  final registry = ref.watch(failureMapperRegistryProvider);
  final logger = ref.watch(appLoggerProvider);

  // Ensure core mappers are registered
  ref.watch(infrastructureFailureMapperProvider);
  ref.watch(passwordFailureMapperProvider);
  ref.watch(emailFailureMapperProvider);
  ref.watch(nameFailureMapperProvider);

  return FailureMessageService(registry, logger);
}
