import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:kompanyon_app/Spalsh%20Screen/splash_screen.dart';
import 'package:kompanyon_app/const/color.dart';
import 'package:kompanyon_app/controller/signup_contoller.dart';
import 'package:kompanyon_app/view/Auth/signup_screen.dart';
import 'package:kompanyon_app/view/nav_bar/nav_bar.dart';


// class LoginController extends GetxController {
//   RxBool isLoading = false.obs;
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final SignupController signupController = Get.put(SignupController());
//   final TextEditingController passwordController1 = TextEditingController();
//   final TextEditingController emailController1 = TextEditingController();
//
//   // Login function
//   Future<void> login() async {
//     try {
//       isLoading.value = true;
//       UserCredential userCredential = await _auth.signInWithEmailAndPassword(
//         email: emailController1.text.trim(),
//         password: passwordController1.text.trim(),
//       );
//       // User successfully logged in
//       User? user = userCredential.user;
//       if (user != null) {
//         Get.to(BottomBar());
//         Get.snackbar("Success", "Login Success",
//             backgroundColor: whiteColor, colorText: Colors.black);
//         print('User logged in: ${user.email}');
//       }
//       emailController1.clear();
//       passwordController1.clear();
//       isLoading.value = false;
//     } on FirebaseAuthException catch (e) {
//       if (e.code == 'user-not-found') {
//         Get.snackbar("Error", "No user found for that email.",
//             backgroundColor: whiteColor, colorText: Colors.black);
//       } else if (e.code == 'invalid-credential') {
//         Get.snackbar(
//           "Error",
//           "Incorrect password.",
//           backgroundColor: whiteColor,
//           colorText: Colors.black,
//         );
//         isLoading.value = false;
//       } else {
//         Get.snackbar("Error", "Login failed. Error code: ${e.code}",
//             backgroundColor: whiteColor, colorText: Colors.black);
//       }
//       print('Error during login: ${e.message}');
//     } finally {
//       isLoading.value = false;
//     }
//   }
//
//   // Logout function
//
//   Future<void> logOut() async {
//     try {
//       await FirebaseAuth.instance.signOut();
//       FirebaseMessaging.instance.deleteToken();
//       signupController.isselectedsignup.value = "Signin";
//
//       Get.snackbar('Success', 'You have been logout',
//           backgroundColor: whiteColor, colorText: Colors.black);
//       Get.offAll(Signup());
//     } catch (e) {
//       print('Error Logout Failed $e');
//     }
//   }
//
//
// }


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

  // Login function with email verification
  // Future<void> login() async {
  //   try {
  //     isLoading.value = true;
  //
  //     // Attempt to sign in with email and password
  //     UserCredential userCredential = await _auth.signInWithEmailAndPassword(
  //       email: emailController1.text.trim(),
  //       password: passwordController1.text.trim(),
  //     );
  //
  //     // Check if user exists
  //     User? user = userCredential.user;
  //     if (user != null) {
  //       // Check if the email is verified
  //       if (user.emailVerified) {
  //         Get.to(BottomBar());
  //         Get.snackbar("Success", "Login Successful",
  //             backgroundColor: whiteColor, colorText: Colors.black);
  //         print('User logged in: ${user.email}');
  //       } else {
  //         // Send verification email if not verified
  //         await user.sendEmailVerification();
  //         Get.snackbar(
  //           "Email Verification",
  //           "Verification email has been sent. Please verify your email and come back to login.",
  //           backgroundColor: whiteColor,
  //           colorText: Colors.black,
  //         );
  //
  //         print("Verification email sent to: ${user.email}");
  //
  //         // Launch Gmail
  //         launchGmail();
  //
  //         // Start polling to check if the email is verified
  //         pollForVerification(user);
  //       }
  //     }
  //
  //     emailController1.clear();
  //     passwordController1.clear();
  //     isLoading.value = false;
  //   } on FirebaseAuthException catch (e) {
  //     if (e.code == 'user-not-found') {
  //       Get.snackbar("Error", "No user found for that email.",
  //           backgroundColor: whiteColor, colorText: Colors.black);
  //     } else if (e.code == 'wrong-password') {
  //       Get.snackbar(
  //         "Error",
  //         "Incorrect password.",
  //         backgroundColor: whiteColor,
  //         colorText: Colors.black,
  //       );
  //     } else {
  //       Get.snackbar("Error", "Login failed. Error code: ${e.code}",
  //           backgroundColor: whiteColor, colorText: Colors.black);
  //     }
  //     print('Error during login: ${e.message}');
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }
  Future<void> login() async {
    try {
      isLoading.value = true;

      // Attempt to sign in with email and password
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: emailController1.text.trim(),
        password: passwordController1.text.trim(),
      );

      // Check if user exists
      User? user = userCredential.user;
      if (user != null) {
        // Check if the email is verified
        if (user.emailVerified) {
          Get.to(BottomBar());
          Get.snackbar("Success", "Login Successful",
              backgroundColor: whiteColor, colorText: Colors.black);
          print('User logged in: ${user.email}');
        } else {
          // Send verification email if not verified
          await user.sendEmailVerification();
          Get.snackbar(
            "Email Verification",
            "Verification email has been sent. Please verify your email and come back to login.",
            backgroundColor: whiteColor,
            colorText: Colors.black,
          );

          print("Verification email sent to: ${user.email}");
        }
      }

      // Do not clear controllers here to retain the entered details
      isLoading.value = false;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Get.snackbar("Error", "No user found for that email.",
            backgroundColor: whiteColor, colorText: Colors.black);
      } else if (e.code == 'wrong-password') {
        Get.snackbar(
          "Error",
          "Incorrect password.",
          backgroundColor: whiteColor,
          colorText: Colors.black,
        );
      } else {
        Get.snackbar("Error", "Login failed. Error code: ${e.code}",
            backgroundColor: whiteColor, colorText: Colors.black);
      }
      print('Error during login: ${e.message}');
    } finally {
      isLoading.value = false;
    }
  }

  // Function to launch Gmail app

  // Function to poll for email verification status
  Future<void> pollForVerification(User user) async {
    Timer.periodic(const Duration(seconds: 5), (timer) async {
      await user.reload(); // Refresh user data
      if (user.emailVerified) {
        timer.cancel(); // Stop polling
        Get.to(BottomBar());
        Get.snackbar("Success", "Email verified! Login Successful.",
            backgroundColor: whiteColor, colorText: Colors.black);
      }
    });
  }

  // Logout function
  Future<void> logOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      FirebaseMessaging.instance.deleteToken();
      signupController.isselectedsignup.value = "Signin";

      Get.snackbar('Success', 'You have been logged out',
          backgroundColor: whiteColor, colorText: Colors.black);
      Get.offAll(Signup());
    } catch (e) {
      print('Error Logout Failed $e');
    }
  }
}
