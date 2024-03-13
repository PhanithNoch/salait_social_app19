import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salait_social_app/screens/register_screen.dart';

import '../controllers/login_controller.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final formkey = GlobalKey<FormState>();
  final emailController = TextEditingController(text: "tester22111@gmail.com");
  final passwordController = TextEditingController(text: "11112222");

  @override
  Widget build(BuildContext context) {
    final _controller = Get.put(LoginController());
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        body: SafeArea(
          child: Form(
            key: formkey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Column(
                    children: [
                      Text(
                        'Welcome to login',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 22),
                      ),
                      Text(
                        "Please login to continue",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  TextFormField(
                    controller: emailController,
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
                    controller: passwordController,
                    obscureText: true,
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
                              final email = emailController.text;
                              final password = passwordController.text;

                              _controller.login(
                                  email: email, password: password);
                            }
                          },
                          child: Text("Login"),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an account?"),
                      TextButton(
                          onPressed: () {
                            Get.to(() => RegisterScreen());
                          },
                          child: Text("Register")),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
