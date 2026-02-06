import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:starter_app/core/logging/i_app_logger.dart';
import 'package:starter_app/core/logging/loggers/console_logger.dart';

part 'logging_providers.g.dart';

@Riverpod(keepAlive: true)
IAppLogger appLogger(AppLoggerRef ref) {
  return ConsoleLogger();
}
