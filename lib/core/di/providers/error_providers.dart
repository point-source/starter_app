import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:starter_app/core/application/application_environment.dart';
import 'package:starter_app/core/di/providers/environment_providers.dart';
import 'package:starter_app/core/domain/ports/i_data_filter.dart';
import 'package:starter_app/core/domain/ports/i_error_reporter.dart';
import 'package:starter_app/core/error/reporters/no_op_error_reporter.dart';
import 'package:starter_app/core/error/reporters/sentry_error_reporter.dart';
import 'package:starter_app/core/error/sensitive_data_filter.dart';

part 'error_providers.g.dart';

@Riverpod(keepAlive: true)
IDataFilter dataFilter(DataFilterRef ref) {
  return const SensitiveDataFilter();
}

@Riverpod(keepAlive: true)
IErrorReporter errorReporter(ErrorReporterRef ref) {
  final env = ref.watch(appEnvironmentProvider);
  if (env == AppEnvironment.development) {
    return const NoOpErrorReporter();
  } else {
    final filter = ref.watch(dataFilterProvider);
    return SentryErrorReporter(filter);
  }
}
