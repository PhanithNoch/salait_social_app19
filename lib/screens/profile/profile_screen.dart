import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../constant/constant.dart';
import '../../controllers/profile/profile_controller.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final _controller = Get.put(ProfileController());
    return Scaffold(
      body: GetBuilder<ProfileController>(builder: (_) {
        if (_controller.isLoading)
          return Center(
            child: CircularProgressIndicator(),
          );
        final user = _controller.profile!.user;
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 67,
                child: CircleAvatar(
                  radius: 65,
                  backgroundImage: NetworkImage(
                      "${kBaseUrl}/" + user!.profilePic! ??
                          "https://via.placeholder.com/150"),
                ),
              ),
              TextButton(onPressed: () {}, child: Text("Edit Profile")),
              ListTile(
                title: Text("${user.name}"),
              ),
              ListTile(
                title: Text("${user.email}"),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () {},
                        child: Text("Logout"),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
