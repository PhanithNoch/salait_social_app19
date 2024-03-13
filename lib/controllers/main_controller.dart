import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:salait_social_app/screens/login_screen.dart';

class MainController extends GetxController {
  final box = GetStorage();
  var currentIndex = 0;
  bool isShowAppbar = false;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onReady() {
    isAuth();
    super.onReady();
  }

  void isAuth() {
    if (box.read("token") != null) {
    } else {
      Get.offAll(() => LoginScreen());
    }
  }

  void changeIndex(int index) {
    currentIndex = index;
    update(); // refresh UI
  }
}
