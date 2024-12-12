import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:kompanyon_app/Spalsh%20Screen/splash_screen.dart';
import 'package:kompanyon_app/const/color.dart';
import 'package:kompanyon_app/controller/signup_contoller.dart';
import 'package:kompanyon_app/view/Auth/signup_screen.dart';
import 'package:kompanyon_app/view/nav_bar/nav_bar.dart';


class LoginController extends GetxController {
  RxBool isLoading = false.obs;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final SignupController signupController = Get.put(SignupController());
  final TextEditingController passwordController1 = TextEditingController();
  final TextEditingController emailController1 = TextEditingController();

  // Login function
  Future<void> login() async {
    try {
      isLoading.value = true;
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: emailController1.text.trim(),
        password: passwordController1.text.trim(),
      );
      // User successfully logged in
      User? user = userCredential.user;
      if (user != null) {
        Get.to(BottomBar());
        Get.snackbar("Success", "Login Success",
            backgroundColor: whiteColor, colorText: Colors.black);
        print('User logged in: ${user.email}');
      }
      emailController1.clear();
      passwordController1.clear();
      isLoading.value = false;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Get.snackbar("Error", "No user found for that email.",
            backgroundColor: whiteColor, colorText: Colors.black);
      } else if (e.code == 'invalid-credential') {
        Get.snackbar(
          "Error",
          "Incorrect password.",
          backgroundColor: whiteColor,
          colorText: Colors.black,
        );
        isLoading.value = false;
      } else {
        Get.snackbar("Error", "Login failed. Error code: ${e.code}",
            backgroundColor: whiteColor, colorText: Colors.black);
      }
      print('Error during login: ${e.message}');
    } finally {
      isLoading.value = false;
    }
  }

  // Logout function

  Future<void> logOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      FirebaseMessaging.instance.deleteToken();
      signupController.isselectedsignup.value = "Signin";

      Get.snackbar('Success', 'You have been logout',
          backgroundColor: whiteColor, colorText: Colors.black);
      Get.offAll(Signup());
    } catch (e) {
      print('Error Logout Failed $e');
    }
  }


}
