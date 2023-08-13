import 'package:auth_test/misc/logger.dart';
import 'package:auth_test/misc/snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthController {
  AuthController(this.auth) {
    onInit();
  }

  /// here we have taken auth as an required argument because
  /// for we are mocking the firebase auth class and on the other hand
  /// we have to use that code for login and signup also
  final FirebaseAuth auth;

  bool isLoading = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void onInit() async {
    /// do not use navigation in testing it will throw the
    /// ```error test failed with unknown error```

    // logger.w('controller put');
    // auth.authStateChanges().listen((user) {
    //   if (user == null) {
    //     logger.w('auth');
    //     Get.offAll(() => AuthScreen());
    //   } else {
    //     logger.w('home');
    //     Get.offAll(() => HomeScreen());
    //   }
    // });
  }

  User? get currentUser => auth.currentUser;

  Stream<User?> get userStream => auth.authStateChanges();

  Future<String> logInWithEmailAndPassword() async {
    try {
      isLoading = true;

      // if (emailController.text.trim().isEmpty) {
      //   throw 'Please enter email';
      // }
      // if (!emailController.text.trim().isEmail) {
      //   throw 'Please enter valid email';
      // }
      // if (passwordController.text.isEmpty) {
      //   throw 'Please enter valid password';
      // }
      await auth.signInWithEmailAndPassword(
        email: emailController.text.trim().toLowerCase(),
        password: passwordController.text.trim(),
      );
      isLoading = false;

      return 'Success';
    } on FirebaseAuthException catch (e) {
      isLoading = false;

      if (e.code == 'invalid-email') {
        showSnackbar('Auth Error', 'Email do not exist');
        return 'Email do not exist';
      } else if (e.code == 'wrong-password') {
        showSnackbar('Auth Error', 'Wrong password');
        return 'Wrong password';
      } else if (e.code == 'user-disabled') {
        showSnackbar('Auth Error', 'Your account is disabled bu admin');
        return 'Your account is disabled bu admin';
      } else if (e.code == 'user-not-found') {
        showSnackbar('Auth Error', 'No account found with this email.');
        return 'No account found with this email.';
      } else {
        showSnackbar('Auth Error', 'Its not you its us...');
        return 'Its not you its us...';
      }
    } catch (e) {
      isLoading = false;

      logger.e(e.toString());
      showSnackbar('Auth Error', e.toString());
      return e.toString();
    }
  }

  Future<String> signUpWithEmailAndPassword() async {
    try {
      isLoading = true;

      // if (emailController.text.trim().isEmpty) {
      //   throw 'Please enter email';
      // }
      // if (!emailController.text.trim().isEmail) {
      //   throw 'Please enter valid email';
      // }
      // if (passwordController.text.isEmpty) {
      //   throw 'Please enter valid password';
      // }
      await auth.createUserWithEmailAndPassword(
        email: emailController.text.trim().toLowerCase(),
        password: passwordController.text.trim(),
      );
      isLoading = false;

      return 'Success';
    } on FirebaseAuthException catch (e) {
      isLoading = false;

      if (e.code == 'email-already-in-use') {
        showSnackbar('Auth Error', 'Email already exists');
        return 'Email already exists';
      } else if (e.code == 'weak-password') {
        showSnackbar('Auth Error', 'Weak password');
        return 'Weak password';
      } else {
        showSnackbar('Auth Error', 'Its not you its us...');
        return 'Its not you its us...';
      }
    } catch (e) {
      isLoading = false;

      logger.e(e.toString());
      showSnackbar('Auth Error', e.toString());
      return e.toString();
    }
  }
}
