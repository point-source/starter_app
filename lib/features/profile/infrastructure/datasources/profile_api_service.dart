import 'package:chopper/chopper.dart';
import 'package:starter_app/features/profile/infrastructure/datasources/profile_endpoints.dart';

part 'profile_api_service.chopper.dart';

@ChopperApi(baseUrl: ProfileEndpoints.profileBasePath)
abstract class ProfileApiService extends ChopperService {
    static ProfileApiService create(ChopperClient client) =>
      _$ProfileApiService(client);

  @GET(path: ProfileEndpoints.me)
  Future<Response<Map<String, dynamic>>> getMyProfile();
}
