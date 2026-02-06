import 'package:equatable/equatable.dart';
import 'package:starter_app/core/presentation/models/error_model.dart';
import 'package:starter_app/features/{{feature_name.snakeCase()}}/domain/entities/{{feature_name.snakeCase()}}.dart';

/// States for {{feature_name.pascalCase()}}Bloc.
sealed class {{feature_name.pascalCase()}}State extends Equatable {
  const {{feature_name.pascalCase()}}State();

  @override
  List<Object?> get props => [];
}

/// Initial state before any action.
final class {{feature_name.pascalCase()}}Initial extends {{feature_name.pascalCase()}}State {
  const {{feature_name.pascalCase()}}Initial();
}

/// Loading state while fetching data.
final class {{feature_name.pascalCase()}}Loading extends {{feature_name.pascalCase()}}State {
  const {{feature_name.pascalCase()}}Loading();
}

/// Success state with loaded data.
final class {{feature_name.pascalCase()}}Loaded extends {{feature_name.pascalCase()}}State {
  const {{feature_name.pascalCase()}}Loaded(this.items);

  final List<{{feature_name.pascalCase()}}> items;

  @override
  List<Object> get props => [items];
}

/// Error state with error model.
final class {{feature_name.pascalCase()}}Error extends {{feature_name.pascalCase()}}State {
  const {{feature_name.pascalCase()}}Error(this.error);

  final ErrorModel error;

  @override
  List<Object> get props => [error];
}
