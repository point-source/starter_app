import 'package:dart_mappable/dart_mappable.dart';
import 'package:starter_app/core/domain/value_objects/email_address.dart';
import 'package:starter_app/core/types/types.dart';

part 'check_user_exists_request_model.mapper.dart';

/// Data transfer object for check user exists requests.
@MappableClass()
class CheckUserExistsRequestModel with CheckUserExistsRequestModelMappable {
  /// User email address to check.
  final String email;

  /// Creates a [CheckUserExistsRequestModel].
  const CheckUserExistsRequestModel({
    required this.email,
  });

  /// Creates model from JSON map (rarely used).
  static CheckUserExistsRequestModel fromJson(Json json) =>
      CheckUserExistsRequestModelMapper.fromMap(json);

  /// Creates model from domain email.
  factory CheckUserExistsRequestModel.fromDomain(EmailAddress email) {
    return CheckUserExistsRequestModel(
      email: email.getOrCrash(),
    );
  }
}
