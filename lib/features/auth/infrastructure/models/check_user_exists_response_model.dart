import 'package:dart_mappable/dart_mappable.dart';
import 'package:starter_app/core/types/types.dart';

part 'check_user_exists_response_model.mapper.dart';

/// Data transfer object for check user exists responses.
@MappableClass()
class CheckUserExistsResponseModel with CheckUserExistsResponseModelMappable {
  /// Creates a [CheckUserExistsResponseModel].
  const CheckUserExistsResponseModel({
    required this.exists,
  });

  /// Whether the user exists.
  final bool exists;

  /// Creates model from JSON map.
  static CheckUserExistsResponseModel fromJson(Json json) =>
      CheckUserExistsResponseModelMapper.fromMap(json);
}
