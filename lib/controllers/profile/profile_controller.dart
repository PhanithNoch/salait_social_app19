import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salait_social_app/data/providers/networking_provider.dart';

import '../../data/models/user_res_model.dart';

class ProfileController extends GetxController {
  final _provider = NetworkProvider();
  UserResModel? profile;
  bool isLoading = false;
  @override
  void onInit() {
    getProfile();
    // TODO: implement onInit
    super.onInit();
  }

  void updateState(bool state) {
    isLoading = state;
    update();
  }

  void getProfile() async {
    try {
      updateState(true);
      var user = await _provider.getCurrentUserLoggedIn();
      profile = user;
      print("response: $user");
      updateState(false);
    } catch (e) {
      updateState(false);
      print(e);
      if (!Get.isSnackbarOpen) {
        Get.snackbar("Error", "Error in fetching profile");
      }
    }
  }
}
