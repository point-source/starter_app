import 'package:equatable/equatable.dart';
import 'package:starter_app/core/presentation/models/error_model.dart';

/// States for {{name.pascalCase()}}Bloc.
sealed class {{name.pascalCase()}}State extends Equatable {
  const {{name.pascalCase()}}State();

  @override
  List<Object?> get props => [];
}

/// Initial state before any action.
final class {{name.pascalCase()}}Initial extends {{name.pascalCase()}}State {
  const {{name.pascalCase()}}Initial();
}

/// Loading state while fetching data.
final class {{name.pascalCase()}}Loading extends {{name.pascalCase()}}State {
  const {{name.pascalCase()}}Loading();
}

/// Success state with loaded data.
final class {{name.pascalCase()}}Loaded extends {{name.pascalCase()}}State {
  const {{name.pascalCase()}}Loaded({
    // TODO: Add state properties
  });

  @override
  List<Object> get props => [];
}

/// Error state with error model.
final class {{name.pascalCase()}}Error extends {{name.pascalCase()}}State {
  const {{name.pascalCase()}}Error(this.error);

  final ErrorModel error;

  @override
  List<Object> get props => [error];
}
