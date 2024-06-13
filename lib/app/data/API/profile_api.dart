import 'package:dio/dio.dart';
import 'package:pm_2_absensi/app/data/api_client.dart';

class ProfileApi extends ApiClient {
  Future<Response> getProfile({required String accesstoken}) async {
    try {
      var response = await dio.get(
        '$baseUrl/user',
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
          headers: {
            'Authorization': 'Bearer $accesstoken',
          },
        ),
      );
      return response;
    } on DioException catch (e) {
      return e.response!;
    }
  }

  Future<Response> changePassword({
    required String accesstoken,
    required String email,
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      var response = await dio.post(
        '$baseUrl/change-password',
        data: {
          'email': email,
          'current_password': currentPassword,
          'new_password': newPassword,
        },
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
          headers: {
            'Authorization': 'Bearer $accesstoken',
          },
        ),
      );
      return response;
    } on DioException catch (e) {
      return e.response!;
    }
  }
}
