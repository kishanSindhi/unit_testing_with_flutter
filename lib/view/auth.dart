import 'package:auth_test/controller/auth_controlle.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthScreen extends StatelessWidget {
  AuthScreen({super.key});
  final controller = AuthController(FirebaseAuth.instance);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: controller.emailController,
            decoration: const InputDecoration(
              hintText: 'Email',
            ),
          ),
          TextField(
            controller: controller.passwordController,
            decoration: const InputDecoration(
              hintText: 'Password',
            ),
          ),
          ElevatedButton(
            onPressed: controller.logInWithEmailAndPassword,
            child: const Text(
              'Login',
            ),
          ),
          ElevatedButton(
            onPressed: controller.signUpWithEmailAndPassword,
            child: const Text('Signup'),
          ),
        ],
      ).paddingAll(20),
      // body: GetBuilder<AuthController>(builder: (c) {
      //   if (controller.isLoading) {
      //     return const Center(
      //       child: CircularProgressIndicator(),
      //     );
      //   } else {
      //     return
      //   }
      // }),
    );
  }
}
