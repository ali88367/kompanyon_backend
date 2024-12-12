import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:kompanyon_app/view/profile/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserController extends GetxController {
  String? token;
  var userEmail = ''.obs;
  var userName = ''.obs;
  var profileImageUrl = ''.obs;
  var userRole = ''.obs;
  var userDescription = ''.obs;

  @override
  void onInit() {
    super.onInit();
    getUserData();
    getInit();
  }

  Future<void> updateUserData({
    String? name,
    String? role,
    String? description,
    File? imageFile,
  }) async {
    try {
      final userId = FirebaseAuth.instance.currentUser!.uid;
      final userDocRef =
          FirebaseFirestore.instance.collection('userDetails').doc(userId);

      if (imageFile != null) {
        final storageRef = FirebaseStorage.instance
            .ref()
            .child('profile_images')
            .child('$userId.jpg');
        await storageRef.putFile(imageFile);
        final newProfileImageUrl = await storageRef.getDownloadURL();

        // Update Firestore with the new profile image URL
        await userDocRef.set(
            {'profileImageUrl': newProfileImageUrl}, SetOptions(merge: true));
        profileImageUrl.value = newProfileImageUrl; // Update local state
      }

      // Update other user details
      await userDocRef.set({
        'name': name ?? userName.value,
        'role': role ?? userRole.value,
        'uid': userId,
        'description': description ?? userDescription.value,
      }, SetOptions(merge: true));

      userName.value = name ?? userName.value;
      userRole.value = role ?? userRole.value;
      userDescription.value = description ?? userDescription.value; // Update userDescription

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('userDescription', userDescription.value);
    } catch (e) {
      print('Error updating user data: $e');
    }
  }

  Future<void> getDeviceStoreToken() async {
    try {
      if (Platform.isIOS) {
        token = await FirebaseMessaging.instance.getAPNSToken();
        if (FirebaseAuth.instance.currentUser != null) {
          await FirebaseFirestore.instance
              .collection('userDetails')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .set({'fcmToken': token}, SetOptions(merge: true));
        }
      } else if (Platform.isAndroid) {
        token = await FirebaseMessaging.instance.getToken();
        if (FirebaseAuth.instance.currentUser != null) {
          await FirebaseFirestore.instance
              .collection('userDetails')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .set({'fcmToken': token}, SetOptions(merge: true));
        }
      }
    } catch (e) {
      print('Error Storing token');
    }
  }

  Future<void> getUserData() async {
    try {
      if (FirebaseAuth.instance.currentUser != null) {
        final userId = FirebaseAuth.instance.currentUser!.uid;
        var userDoc = await FirebaseFirestore.instance
            .collection('userDetails')
            .doc(userId)
            .get();
        if (userDoc.exists) {
          userEmail.value = userDoc.data()?['email'] ?? '';
          userName.value = userDoc.data()?['name'] ?? '';
          profileImageUrl.value = userDoc.data()?['profileImageUrl'] ?? '';
          userRole.value = userDoc['role'] ?? 'User';
        }
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

  Future<void> uploadProfileImage(File imageFile) async {
    try {
      final userId = FirebaseAuth.instance.currentUser!.uid;
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('profile_images')
          .child('$userId.jpg');
      await storageRef.putFile(imageFile);
      final ProfileImageUrl = await storageRef.getDownloadURL();

      await FirebaseFirestore.instance
          .collection('userDetails')
          .doc(userId)
          .set({'profileImageUrl': profileImageUrl}, SetOptions(merge: true));

      profileImageUrl.value = profileImageUrl as String;
    } catch (e) {
      print('Error uploading profile image: $e');
    }
  }

  Future<void> getInit() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey("userDescription")) {
      userDescription.value = prefs.getString("userDescription")!;
    }
  }
}
