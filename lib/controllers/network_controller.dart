import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkController extends GetxController {
  final Connectivity _connectivity = Connectivity();
  RxBool isConnected = true.obs;

  @override
  void onInit() {
    _connectivity.onConnectivityChanged.listen(_updateConnectionState);
    super.onInit();
  }

  void _updateConnectionState(ConnectivityResult connectivityResult) {
    print("ConnectivityResult: $connectivityResult");
    if (connectivityResult == ConnectivityResult.none) {
      isConnected(false);
      Get.rawSnackbar(
          overlayBlur: 1,
          barBlur: 1,
          overlayColor: Colors.black.withOpacity(0.5),
          messageText: const Text('PLEASE CONNECT TO THE INTERNET',
              style: TextStyle(color: Colors.white, fontSize: 14)),
          isDismissible: false,
          duration: const Duration(days: 1),
          backgroundColor: Colors.red[400]!,
          icon: const Icon(
            Icons.wifi_off,
            color: Colors.white,
            size: 35,
          ),
          margin: EdgeInsets.zero,
          snackStyle: SnackStyle.GROUNDED);
    } else {
      isConnected(true);
      Get.closeAllSnackbars();
    }
  }
}
