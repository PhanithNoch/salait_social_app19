import 'package:dio/dio.dart';
import 'dart:io';

import 'package:get_storage/get_storage.dart';
import 'package:salait_social_app/data/models/create_post_model.dart';

import '../models/login_res_model.dart';
import '../models/user_res_model.dart';

class NetworkProvider {
  final dio = Dio();
  final box = GetStorage();
  // String baseUrl = "http://localhost:8000/api";
  // String baseUrl = "http://10.0.2.2:8000/api";
  String baseUrl = "http://localhost:8000/api";

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

  Future<LoginResModel> login({
    required String email,
    required String password,
    File? profile,
  }) async {
    var _formData = FormData.fromMap({
      "email": email,
      "password": password,
    });
    final response = await dio.post(
      "$baseUrl/login",
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
      return LoginResModel.fromJson(response.data);
    } else {
      throw Exception("Failed to register user");
    }
  }

  /// get current user logged in

  Future<UserResModel> getCurrentUserLoggedIn() async {
    final response = await dio.get(
      "$baseUrl/me",
      options: Options(
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer ${box.read("token")}",
        },
        followRedirects: false,
        validateStatus: (status) {
          return status! < 500;
        },
      ),
    );
    print(response.data);
    if (response.statusCode == 200) {
      return UserResModel.fromJson(response.data);
    } else {
      throw Exception("Failed to register user");
    }
  }

  Future<bool> createPost({
    required String caption,
    File? photo,
  }) async {
    var _formData = FormData.fromMap({
      "caption": caption,
      "image": photo != null ? await MultipartFile.fromFile(photo.path) : null,
    });
    final response = await dio.post(
      "$baseUrl/create-post",
      data: _formData,
      options: Options(
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer ${box.read("token")}",
        },
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
      throw Exception("Failed to create post");
    }
  }

  Future<PostResModel> fetchPost() async {
    final response = await dio.get(
      "$baseUrl/posts",
      options: Options(
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer ${box.read("token")}",
        },
        followRedirects: false,
        validateStatus: (status) {
          return status! < 500;
        },
      ),
    );
    print(response.data);
    if (response.statusCode == 200) {
      return PostResModel.fromJson(response.data);
    } else {
      throw Exception("Failed to register user");
    }
  }
}
