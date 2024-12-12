import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kompanyon_app/const/color.dart';
import 'package:kompanyon_app/controller/login_controller.dart';
import 'package:kompanyon_app/view/nav_bar/nav_bar.dart';

final LoginController login = Get.put(LoginController());

class SignupController extends GetxController {
  var selectedRole = ''.obs;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController retypasswordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  var isselectedsignup = "Signup".obs;

  Future<void> handleSignUp(File? profileImage) async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final confirmPassword = retypasswordController.text.trim();
    final name = nameController.text.trim();

    if (password != confirmPassword) {
      print('Passwords do not match');
      Get.snackbar('Error', "Passwords do not match",
          backgroundColor: whiteColor, colorText: Colors.black);
      return;
    }

    try {
      login.isLoading.value = true;

      UserCredential userCredential =
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;


      if (user != null) {
        String? profileImageUrl;

        if (profileImage != null) {
          // Upload profile image to Firebase Storage
          profileImageUrl = await uploadProfileImage(user.uid, profileImage);
        }
        await _firestore.collection('userDetails').doc(user.uid).set({
          'name': name,
          'email': email,
          'password': password,
          'createAt': Timestamp.now(),
          'profileImageUrl': profileImageUrl,
          'role': selectedRole.value,
          'uid': user.uid,

        });

        Get.to(BottomBar());
        Get.snackbar('Success', 'Login Success',
            backgroundColor: whiteColor, colorText: Colors.black);
        print('User signed up: ${user.email}');
        emailController.clear();
        passwordController.clear();
        retypasswordController.clear();
        nameController.clear();
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        Get.back();
        Get.snackbar(
            "Error", "The email address is already in use by another account.",
            backgroundColor: whiteColor, colorText: Colors.black);
      } else {
        Get.back();
        print('error auth $e');
        Get.snackbar("Error", e.code,
            backgroundColor: whiteColor, colorText: Colors.black);
      }
    } finally {
      login.isLoading.value = false;
    }
  }
  Future<String> uploadProfileImage(String userId, File profileImage) async {
    try {
      Reference storageRef = _storage.ref().child('profileImages/$userId.jpg');
      UploadTask uploadTask = storageRef.putFile(profileImage);

      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print('Error uploading profile image: $e');
      return '';
    }
  }
}


