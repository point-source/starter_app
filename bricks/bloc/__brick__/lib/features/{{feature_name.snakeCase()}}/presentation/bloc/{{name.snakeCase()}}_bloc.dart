import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
// import 'package:starter_app/core/presentation/models/error_model.dart';
import 'package:starter_app/features/{{feature_name.snakeCase()}}/presentation/bloc/{{name.snakeCase()}}_event.dart';
import 'package:starter_app/features/{{feature_name.snakeCase()}}/presentation/bloc/{{name.snakeCase()}}_state.dart';

/// BLoC for {{name.titleCase()}}.
///
/// Handles UI state and delegates business logic to use cases.
/// Follows ADR-002 (flutter_bloc for state management).
@injectable
class {{name.pascalCase()}}Bloc extends Bloc<{{name.pascalCase()}}Event, {{name.pascalCase()}}State> {
  {{name.pascalCase()}}Bloc(
    // TODO: Inject use cases
  ) : super(const {{name.pascalCase()}}Initial()) {
    on<{{name.pascalCase()}}Event>((event, emit) async {
      await switch (event) {
        {{name.pascalCase()}}Started() => _onStarted(emit),
        {{name.pascalCase()}}Refreshed() => _onRefreshed(emit),
        {{name.pascalCase()}}Reset() => _onReset(emit),
      };
    });
  }

  // TODO: Add use case dependencies

  Future<void> _onStarted(Emitter<{{name.pascalCase()}}State> emit) async {
    emit(const {{name.pascalCase()}}Loading());

    // TODO: Call use case and handle result
    // final result = await _useCase();
    // result.fold(
    //   (failure) => emit({{name.pascalCase()}}Error(ErrorModel.fromFailure(failure))),
    //   (data) => emit({{name.pascalCase()}}Loaded(data: data)),
    // );

    // Placeholder - replace with actual implementation
    emit(const {{name.pascalCase()}}Loaded());
  }

  Future<void> _onRefreshed(Emitter<{{name.pascalCase()}}State> emit) async {
    await _onStarted(emit);
  }

  Future<void> _onReset(Emitter<{{name.pascalCase()}}State> emit) async {
    emit(const {{name.pascalCase()}}Initial());
  }
}
