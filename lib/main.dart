import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:salait_social_app/screens/login_screen.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:salait_social_app/screens/main_screen.dart';
import 'bindings/network_binding.dart';
import 'dependency_injection.dart';

void main() async {
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final _networkController = Get.put(NetworkBinding(), permanent: true);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        textTheme: GoogleFonts.outfitTextTheme(),
      ),
      home: MainScreen(),
    );
  }
}
