import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
// import 'package:starter_app/core/presentation/models/error_model.dart';
import 'package:starter_app/features/{{feature_name.snakeCase()}}/presentation/bloc/{{feature_name.snakeCase()}}_event.dart';
import 'package:starter_app/features/{{feature_name.snakeCase()}}/presentation/bloc/{{feature_name.snakeCase()}}_state.dart';
// TODO: Import use cases
// import 'package:starter_app/features/{{feature_name.snakeCase()}}/application/usecases/get_all_{{feature_name.snakeCase()}}s.dart';

/// BLoC for {{feature_name.pascalCase()}} feature.
///
/// Handles UI state and delegates business logic to use cases.
/// Follows ADR-002 (flutter_bloc for state management).
@injectable
class {{feature_name.pascalCase()}}Bloc extends Bloc<{{feature_name.pascalCase()}}Event, {{feature_name.pascalCase()}}State> {
  {{feature_name.pascalCase()}}Bloc(
    // TODO: Inject use cases
    // this._getAll,
  ) : super(const {{feature_name.pascalCase()}}Initial()) {
    on<{{feature_name.pascalCase()}}Event>((event, emit) async {
      await switch (event) {
        {{feature_name.pascalCase()}}Started() => _onStarted(emit),
        {{feature_name.pascalCase()}}Refreshed() => _onRefreshed(emit),
        {{feature_name.pascalCase()}}Reset() => _onReset(emit),
      };
    });
  }

  // TODO: Add use case dependencies
  // final GetAll{{feature_name.pascalCase()}}s _getAll;

  Future<void> _onStarted(Emitter<{{feature_name.pascalCase()}}State> emit) async {
    emit(const {{feature_name.pascalCase()}}Loading());

    // TODO: Call use case and handle result
    // final result = await _getAll();
    // result.fold(
    //   (failure) => emit({{feature_name.pascalCase()}}Error(ErrorModel.fromFailure(failure))),
    //   (items) => emit({{feature_name.pascalCase()}}Loaded(items)),
    // );

    // Placeholder - replace with actual implementation
    emit(const {{feature_name.pascalCase()}}Loaded([]));
  }

  Future<void> _onRefreshed(Emitter<{{feature_name.pascalCase()}}State> emit) async {
    // Optionally show loading or keep current state
    await _onStarted(emit);
  }

  Future<void> _onReset(Emitter<{{feature_name.pascalCase()}}State> emit) async {
    emit(const {{feature_name.pascalCase()}}Initial());
  }
}
