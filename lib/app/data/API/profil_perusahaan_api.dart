import 'package:dio/dio.dart';
import 'package:pm_2_absensi/app/data/api_client.dart';

class ProfilePerusahaanApi extends ApiClient {
  Future<Response> getProfilPerusahaan({required String accesstoken}) async {
    try {
      var response = await dio.get(
        '$baseUrl/pegawai/profil_perusahaan/1',
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
