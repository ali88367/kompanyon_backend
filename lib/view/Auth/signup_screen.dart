import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kompanyon_app/const/color.dart';
import 'package:kompanyon_app/const/image.dart';
import 'package:kompanyon_app/controller/login_controller.dart';
import 'package:kompanyon_app/view/home_screen/components/hear_screen.dart';
import 'package:kompanyon_app/view/nav_bar/nav_bar.dart';
import 'package:kompanyon_app/widgets/custom_button.dart';
import 'package:kompanyon_app/widgets/custom_inter_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kompanyon_app/widgets/custom_textfield.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:localstorage/localstorage.dart';
import '../../controller/signup_contoller.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> with SingleTickerProviderStateMixin {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  final LocalStorage storage = localStorage;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  File? _profileImage;
  Future<void> _selectImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  // Controllers for text fields
  final SignupController signupController =
      Get.put(SignupController()); // Initialize the controller
  final LoginController loginController =
      Get.put(LoginController()); // Initialize the controller

  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // Focus nodes for text fields
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _retypePasswordFocusNode = FocusNode();
  final FocusNode _nameFocusNode = FocusNode();
  late AnimationController _controller;
  bool _isLogoInFinalPosition = false;
  late final Animation<double> _scaleAnimation;
  bool ishowcontent = false;
  String? selectedRole;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 2.0, end: 1.0).animate(_controller);

    Future.delayed(const Duration(milliseconds: 600), () {
      setState(() {
        _isLogoInFinalPosition = true;
      });
      _controller.forward().then((value) {
        setState(() {
          ishowcontent = true;
        });
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _retypePasswordFocusNode.dispose();
    _nameFocusNode.dispose();
    super.dispose();
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
  Future<User?> signInWithGoogle(File? profileImage) async {
    try {
      // Trigger the Google Authentication flow
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      // Ensure fcmToken is fetched after the Google sign-in process
      String? fcmToken = await FirebaseMessaging.instance.getToken();

      if (googleUser == null) {
        // User canceled the login
        return null;
      }

      // Obtain the Google authentication details
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      // Create a new credential
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with the Google credentials
      final UserCredential userCredential = await _auth.signInWithCredential(credential);
      final User? user = userCredential.user;

      if (user != null) {
        print("uid: ${user.uid}");

        String? profileImageUrl = user.photoURL; // Use Google profile image URL if available

        if (profileImage == null && profileImageUrl == null) {
          // If the user doesn't have a profile image from Google and no custom image is passed, return
          Get.snackbar('Error', "Profile image is required.",
              backgroundColor: whiteColor, colorText: Colors.black);
          return null;
        }

        if (profileImage != null) {
          // Upload profile image to Firebase Storage
          profileImageUrl = await uploadProfileImage(user.uid, profileImage);
        }

        // Ensure FCM token is not null before saving to Firestore
        if (fcmToken != null) {
          await _firestore.collection('userDetails').doc(user.uid).set(
            {
              'name': user.displayName ?? '',
              'email': user.email,
              'password': '', // No password needed for Google sign-in
              'createAt': Timestamp.now(),
              'profileImageUrl': profileImageUrl,
              'role': 'User',
              'uid': user.uid,
              'fcmToken': fcmToken, // Add the fcmToken here
            },
            SetOptions(merge: true),
          ).then((val) {
            Get.to(BottomBar());
            debugPrint("user doc created");
          });
        } else {
          print("FCM Token is null");
        }
      }

      return user;
    } catch (e) {
      print("Google Sign-In Error: $e");
      return null;
    }
  }

  // Sign out from Google
  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }

  // Check if the user is already signed in
  Future<User?> checkCurrentUser() async {
    final User? user = _auth.currentUser;
    return user;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: GestureDetector(
        onTap: () {
          // Unfocus all text fields when tapping outside
          _emailFocusNode.unfocus();
          _passwordFocusNode.unfocus();
          _retypePasswordFocusNode.unfocus();
        },
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            if (ishowcontent == false)
              AnimatedPositioned(
                duration: const Duration(milliseconds: 600),
                top: _isLogoInFinalPosition
                    ? Get.height * .13
                    : (Get.height / 2) - 37,
                child: ScaleTransition(
                  scale: _scaleAnimation,
                  child: Center(
                    child: Center(
                        child: Image.asset(
                      AppImages.bglogo,
                      height: 60,
                      width: 60,
                    )),
                  ),
                ),
              ),
            if (ishowcontent)
              SingleChildScrollView(
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 42.w),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 160.h),
                        Row(
                          children: [
                            SizedBox(
                                height: 70.h,
                                width: 70.w,
                                child: Image.asset(AppImages.bglogo)),
                            SizedBox(
                              width: 10.w,
                            ),
                            ScaleTransition(
                              scale: _scaleAnimation,
                              child: InterCustomText(
                                text: 'Kompanyon',
                                textColor: primaryColor,
                                fontsize: 30.sp,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 15.h),
                        InterCustomText(
                          text: 'Welcome',
                          textColor: primaryColor,
                          fontsize: 24.sp,
                        ),
                        SizedBox(height: 3.h),
                        InterCustomText(
                          textAlign: TextAlign.center,
                          text: 'Access your account or create a new one below',
                          textColor: primaryColor,
                          fontsize: 14.sp,
                        ),
                        SizedBox(height: 30.h),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                // Handle the onTap event to set isselected
                                setState(() {
                                  signupController.isselectedsignup.value =
                                      "Signup";
                                });
                              },
                              child: Container(
                                width: 90,
                                height: 45,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: signupController.isselectedsignup ==
                                          "Signup"
                                      ? primaryColor
                                      : Colors
                                          .white, // Change color based on isselected
                                ),
                                child: Center(
                                  child: InterCustomText(
                                    textAlign: TextAlign.center,
                                    text: 'Sign up',
                                    textColor:
                                        signupController.isselectedsignup ==
                                                "Signup"
                                            ? Colors.white
                                            : primaryColor,
                                    fontsize: 18.sp,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 10.w),
                            GestureDetector(
                              onTap: () {
                                // Handle the onTap event to set isselected to false
                                setState(() {
                                  signupController.isselectedsignup.value =
                                      "Signin";
                                });
                              },
                              child: Container(
                                width: 90,
                                height: 45,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: signupController.isselectedsignup ==
                                          "Signin"
                                      ? primaryColor
                                      : Colors
                                          .white, // Change color based on isselected
                                ),
                                child: Center(
                                  child: InterCustomText(
                                    textAlign: TextAlign.center,
                                    text: 'Sign in',
                                    textColor:
                                        signupController.isselectedsignup ==
                                                "Signin"
                                            ? Colors.white
                                            : primaryColor,
                                    fontsize: 18.sp,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.h),
                        signupController.isselectedsignup == "Signup"
                            ? Column(
                                children: [
                                  Container(
                                    key: ValueKey<String>(_profileImage?.path ?? 'default'),
                                    width: 100.w,
                                    height: 120.h,
                                    clipBehavior: Clip.hardEdge,
                                    decoration: BoxDecoration(

                                      border: Border.all(color: primaryColor, width: 4),
                                      borderRadius: BorderRadius.circular(12.r),
                                      image: _profileImage != null
                                          ? DecorationImage(
                                        image: FileImage(File(_profileImage!.path)),
                                        fit: BoxFit.cover,
                                      )
                                          : null,
                                    ),
                                    child: _profileImage == null
                                        ? IconButton(
                                      onPressed: _selectImage,
                                      icon: Icon(Icons.add_a_photo, color: primaryColor),
                                    )
                                        : null,
                                  ),

                                  SizedBox(height: 10.h),
                                  InputField(
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 10),
                                    hint: 'Name',
                                    keyboard: TextInputType.name,
                                    controller: signupController.nameController,
                                    focusNode:
                                        _nameFocusNode, // Added focusNode
                                  ),
                                  SizedBox(height: 24.h),
                                  InputField(
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 10),
                                    hint: 'Email',
                                    keyboard: TextInputType.emailAddress,
                                    controller:
                                        signupController.emailController,
                                    focusNode:
                                        _emailFocusNode, // Added focusNode
                                  ),
                                  SizedBox(height: 24.h),
                                  DropdownButtonFormField<String>(
                                    decoration: InputDecoration(
                                      fillColor: Colors.white,
                                      filled: true,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                        vertical: 12.0,
                                        horizontal: 10.0,
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: containerBorder,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12.r)),
                                      border: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: primaryColor,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12.r)),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: primaryColor,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12.r)),
                                    ),
                                    hint: const InterCustomText(
                                      text: '[role]',
                                      textColor: primaryColor,
                                    ),
                                    // Placeholder text
                                    value: selectedRole,
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        selectedRole = newValue;
                                        signupController.selectedRole.value = newValue!;
                                      });
                                    },
                                    items: <String>['Admin', 'User', 'Guest']
                                        .map<DropdownMenuItem<String>>(
                                            (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: InterCustomText(
                                          text: value,
                                          textColor: primaryColor,
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                  SizedBox(height: 24.h),
                                  InputField(
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 10),
                                    hint: 'Password',
                                    keyboard: TextInputType.text,
                                    controller:
                                        signupController.passwordController,
                                    focusNode:
                                        _passwordFocusNode, // Added focusNode
                                  ),
                                  SizedBox(height: 24.h),
                                  InputField(
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 10),
                                    hint: 'Confirm Password',
                                    keyboard: TextInputType.text,
                                    controller:
                                        signupController.retypasswordController,
                                    focusNode:
                                        _retypePasswordFocusNode, // Added focusNode
                                  ),
                                  SizedBox(height: 24.h),
                                  Align(
                                    alignment: Alignment.center,
                                    child: CustomButton(
                                      text: 'Create Account',
                                      onPressed: () {
                                        signupController.handleSignUp(_profileImage);
                                        print('Create Account button pressed');
                                      },
                                      width: 327,
                                      height: 52,
                                      borderRadius: 12,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(height: 24.h),
                                ],
                              )
                            : Column(
                                children: [
                                  InputField(
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 10),
                                    hint: 'Email',
                                    keyboard: TextInputType.text,
                                    controller:
                                        loginController.emailController1,
                                    focusNode:
                                        _emailFocusNode, // Added focusNode
                                  ),
                                  SizedBox(
                                    height: 24.h,
                                  ),
                                  InputField(
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 10),
                                    hint: 'Password',
                                    keyboard: TextInputType.text,
                                    controller:
                                        loginController.passwordController1,
                                    focusNode:
                                        _passwordFocusNode, // Added focusNode
                                  ),
                                  SizedBox(
                                    height: 24.h,
                                  ),
                                  CustomButton(
                                    text: 'Sign-In',
                                    onPressed: () {
                                      loginController.login();

                                      print('Sign-In button pressed');
                                    },
                                    width: 327,
                                    height: 52,
                                    borderRadius: 12,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  InterCustomText(
                                    text: 'Forgot Password?',
                                    textColor: primaryColor,
                                    fontsize: 14.sp,
                                  ),
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      // You can pass the profile image if you have one, or pass null
                                      await signInWithGoogle(null);  // Pass null if no profile image is available at this point
                                    },
                                    child: InterCustomText(
                                      text: 'Sign in with google',
                                      textColor: primaryColor,
                                      fontsize: 14.sp,
                                    ),
                                  )


                                ],
                              ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

}
