import 'dart:convert';

import 'package:get/get.dart';

import '../../data/models/create_post_model.dart';
import '../../data/providers/networking_provider.dart';

class PostController extends GetxController {
  PostResModel? post;
  final _provider = NetworkProvider();
  bool isLoading = false;
  @override
  void onInit() {
    fetchPost();
    print("PostController onInit() called.");
    super.onInit();
  }

  void updateState(bool state) {
    isLoading = state;
    update();
  }

  void fetchPost() async {
    try {
      updateState(true);
      post = await _provider.fetchPost();
      print("posts ${jsonEncode(post)}");
      updateState(false);
    } catch (e) {
      updateState(false);
      if (!Get.isSnackbarOpen) {
        Get.snackbar("Error", e.toString());
      }
    }
  }
}
