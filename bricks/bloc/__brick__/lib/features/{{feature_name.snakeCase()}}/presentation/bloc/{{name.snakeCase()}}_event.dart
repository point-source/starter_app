import 'package:equatable/equatable.dart';

/// Events for {{name.pascalCase()}}Bloc.
sealed class {{name.pascalCase()}}Event extends Equatable {
  const {{name.pascalCase()}}Event();

  @override
  List<Object> get props => [];
}

/// Triggered when started/initialized.
final class {{name.pascalCase()}}Started extends {{name.pascalCase()}}Event {
  const {{name.pascalCase()}}Started();
}

/// Triggered to refresh data.
final class {{name.pascalCase()}}Refreshed extends {{name.pascalCase()}}Event {
  const {{name.pascalCase()}}Refreshed();
}

/// Triggered to reset state.
final class {{name.pascalCase()}}Reset extends {{name.pascalCase()}}Event {
  const {{name.pascalCase()}}Reset();
}

// TODO: Add more events as needed
