import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/register_controller.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});
  final formkey = GlobalKey<FormState>();
  final _nameController = TextEditingController(text: "Test");
  final _emailController = TextEditingController(text: "tester22@gmail.com");
  final _passwordController = TextEditingController(text: "11112222");

  @override
  Widget build(BuildContext context) {
    final _controller = Get.put(RegisterController());
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        body: SafeArea(
          child: GetBuilder<RegisterController>(builder: (_) {
            return Form(
              key: formkey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        _controller.profileImg != null
                            ? CircleAvatar(
                                radius: 70,
                                backgroundImage:
                                    FileImage(_controller.profileImg!))
                            : const CircleAvatar(
                                radius: 70,
                              ),
                        Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.5),
                                shape: BoxShape.circle,
                              ),
                              child: IconButton(
                                onPressed: _controller.pickProfileImg,
                                icon: Icon(Icons.camera_alt_rounded),
                              ),
                            ))
                      ],
                    ),
                    TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        label: Text("Name"),
                      ),
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return "Please enter your Name";
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        label: Text("Email"),
                      ),
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return "Please enter your email";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        label: Text("Password"),
                      ),
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return "Please enter your password";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              if (formkey.currentState!.validate()) {
                                final name = _nameController.text;
                                final email = _emailController.text;
                                final password = _passwordController.text;
                                _controller.register(
                                    name: name,
                                    email: email,
                                    password: password);
                              }
                            },
                            child: Text("Register"),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Already have an account"),
                        TextButton(
                            onPressed: () {
                              Get.back();
                            },
                            child: Text("Login"))
                      ],
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
