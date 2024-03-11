import 'package:salait_social_app/controllers/network_controller.dart';
import 'package:get/get.dart';

class DependencyInjection {
  static void init() {
    Get.put(() => NetworkController(), permanent: true);
  }
}
