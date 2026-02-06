import 'package:equatable/equatable.dart';

/// Events for {{feature_name.pascalCase()}}Bloc.
sealed class {{feature_name.pascalCase()}}Event extends Equatable {
  const {{feature_name.pascalCase()}}Event();

  @override
  List<Object> get props => [];
}

/// Triggered when the feature is started/initialized.
final class {{feature_name.pascalCase()}}Started extends {{feature_name.pascalCase()}}Event {
  const {{feature_name.pascalCase()}}Started();
}

/// Triggered to refresh data.
final class {{feature_name.pascalCase()}}Refreshed extends {{feature_name.pascalCase()}}Event {
  const {{feature_name.pascalCase()}}Refreshed();
}

/// Triggered to reset state.
final class {{feature_name.pascalCase()}}Reset extends {{feature_name.pascalCase()}}Event {
  const {{feature_name.pascalCase()}}Reset();
}

// TODO: Add more events as needed
