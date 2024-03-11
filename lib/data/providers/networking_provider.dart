import 'package:dio/dio.dart';
import 'dart:io';

import 'package:get_storage/get_storage.dart';

class NetworkProvider {
  final dio = Dio();
  final box = GetStorage();
  // String baseUrl = "http://localhost:8000/api";
  String baseUrl = "http://10.0.2.2:8000/api";

  Future<bool> registerUser({
    required String name,
    required String email,
    required String password,
    File? profile,
  }) async {
    var _formData = FormData.fromMap({
      "name": name,
      "email": email,
      "password": password,
      "image":
          profile != null ? await MultipartFile.fromFile(profile.path) : null,
    });
    final response = await dio.post(
      "$baseUrl/register",
      data: _formData,
      options: Options(
        headers: {"Accept": "application/json"},
        followRedirects: false,
        validateStatus: (status) {
          return status! < 500;
        },
      ),
    );
    print(response.data);
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception("Failed to register user");
    }
  }
}
