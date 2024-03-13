import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salait_social_app/screens/app_settings/setting_screen.dart';
import 'package:salait_social_app/screens/posts/post_screen.dart';
import 'package:salait_social_app/screens/profile/profile_screen.dart';

import '../controllers/main_controller.dart';

class MainScreen extends StatelessWidget {
  final screens = [
    PostScreen(),
    ProfileScreen(),
    SettingScreen(),
  ];
  MainScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final _controller = Get.put(MainController());
    return GetBuilder<MainController>(builder: (context) {
      return Scaffold(
        appBar: _controller.isShowAppbar
            ? AppBar(
                title: Text("Main Screen"),
              )
            : null,
        body: screens[_controller.currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          onTap: _controller.changeIndex,
          currentIndex: _controller.currentIndex,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "Profile",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: "Settings",
            ),
          ],
        ),
      );
    });
  }
}
