import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quickalert/quickalert.dart';
import 'dart:io';

import 'package:salait_social_app/data/providers/networking_provider.dart';
import 'package:salait_social_app/screens/login_screen.dart';

class RegisterController extends GetxController {
  final _provider = NetworkProvider();
  File? profileImg;

  void pickProfileImg() async {
    try {
      final file = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (file != null) {
        profileImg = File(file.path);

        /// convert xFile to file
        update();

        /// called to refresh UI
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  void register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      await _provider.registerUser(
          name: name, email: email, password: password, profile: profileImg);
      QuickAlert.show(
          context: Get.context!,
          type: QuickAlertType.success,
          onConfirmBtnTap: () {
            Get.offAll(() => LoginScreen());
          });
    } catch (e) {
      if (!Get.isSnackbarOpen)
        Get.snackbar("Error", e.toString(),
            snackPosition: SnackPosition.BOTTOM);
    }
  }
}
