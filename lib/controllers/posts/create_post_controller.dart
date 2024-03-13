import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quickalert/quickalert.dart';

import '../../data/providers/networking_provider.dart';

class CreatePostController extends GetxController {
  File? photo;
  final _provider = NetworkProvider();
  final caption = TextEditingController();

  void pickImage() async {
    try {
      final file = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (file != null) {
        photo = File(file.path);

        /// convert xFile to file
        update();

        /// called to refresh UI
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  void createPost() async {
    try {
      if (caption.text.isEmpty) {
        if (!Get.isSnackbarOpen) Get.snackbar("Error", "Caption is required");
      }
      await _provider.createPost(photo: photo, caption: caption.text);
      QuickAlert.show(
          context: Get.context!,
          type: QuickAlertType.success,
          title: "Success",
          text: "Post created successfully",
          onConfirmBtnTap: () {
            Get.back();
            Get.back(result: true);
          });
    } catch (e) {
      if (!Get.isSnackbarOpen) Get.snackbar("Error", e.toString());
    }
  }
}
