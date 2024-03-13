import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:quickalert/quickalert.dart';
import 'package:salait_social_app/data/providers/networking_provider.dart';
import 'package:get/get.dart';
import 'package:salait_social_app/screens/main_screen.dart';
import 'network_controller.dart';

class LoginController extends NetworkController {
  final _provider = NetworkProvider();
  final box = GetStorage();
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  void login({required String email, required String password}) async {
    try {
      final user = await _provider.login(email: email, password: password);
      final token = user.token;
      await box.write('token', token);
      Get.offAll(() => MainScreen());
    } catch (e) {
      if (!Get.isSnackbarOpen) {
        Get.snackbar("Error", e.toString(),
            snackPosition: SnackPosition.BOTTOM);
      }
    }
  }
}
