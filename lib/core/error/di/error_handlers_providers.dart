import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:starter_app/core/error/exception_handler.dart';

part 'error_handlers_providers.g.dart';

@Riverpod(keepAlive: true)
ExceptionHandler exceptionHandler(ExceptionHandlerRef ref) {
  return const ExceptionHandler();
}
