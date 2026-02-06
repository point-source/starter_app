import 'package:dart_mappable/dart_mappable.dart';
import 'package:starter_app/core/types/types.dart';
import 'package:starter_app/features/{{feature_name.snakeCase()}}/domain/entities/{{feature_name.snakeCase()}}.dart';
import 'package:starter_app/features/{{feature_name.snakeCase()}}/domain/entities/{{feature_name.snakeCase()}}_id.dart';

part '{{feature_name.snakeCase()}}_model.mapper.dart';

/// Data transfer object for [{{feature_name.pascalCase()}}].
///
/// Uses dart_mappable for JSON serialization.
/// Models are in infrastructure layer - they handle serialization.
@MappableClass()
class {{feature_name.pascalCase()}}Model with {{feature_name.pascalCase()}}ModelMappable {
  const {{feature_name.pascalCase()}}Model({
    required this.id,
    // TODO: Add model properties matching API response
  });

  final String id;

  factory {{feature_name.pascalCase()}}Model.fromJson(Map<String, dynamic> json) =>
      {{feature_name.pascalCase()}}ModelMapper.fromMap(json);

  factory {{feature_name.pascalCase()}}Model.fromDomain({{feature_name.pascalCase()}} entity) {
    return {{feature_name.pascalCase()}}Model(
      id: entity.id.value.value,
      // TODO: Map entity properties to model
    );
  }

  /// Converts this model to a domain entity.
  {{feature_name.pascalCase()}} toDomain() {
    return {{feature_name.pascalCase()}}(
      id: {{feature_name.pascalCase()}}Id.fromString(id),
      // TODO: Map model properties to entity
    );
  }
}
