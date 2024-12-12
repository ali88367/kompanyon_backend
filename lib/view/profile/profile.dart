import 'dart:io';
import 'package:flutter/material.dart';
import 'package:kompanyon_app/const/color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kompanyon_app/const/image.dart';
import 'package:kompanyon_app/controller/login_controller.dart';
import 'package:kompanyon_app/view/Auth/signup_screen.dart';
import 'package:kompanyon_app/view/profile/account_settings.dart';
import 'package:kompanyon_app/view/profile/change_password.dart';
import 'package:kompanyon_app/view/profile/edit_profile.dart';
import 'package:kompanyon_app/widgets/custom_button.dart';
import 'package:kompanyon_app/widgets/custom_inter_text.dart';
import 'package:kompanyon_app/widgets/custom_textfield.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';
import '../../controller/user_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _upSlideAnimation;
  late Animation<Offset> _slideAnimation;
  final UserController userController = Get.put(UserController());
  final LoginController login = Get.put(LoginController());

  bool isselected = false;
  bool _isDarkMode = false;

  @override
  void initState() {
    super.initState();
    userController.getUserData();
    _loadTheme(); // Load theme from SharedPreferences on init

    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );
    _upSlideAnimation =
        Tween<Offset>(begin: const Offset(0.0, 1.0), end: Offset.zero)
            .animate(_controller);
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutExpo,
    ));

    _controller.forward(); // Start the animation
  }

  Future<void> _loadTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _isDarkMode = prefs.getBool('isDarkMode') ?? false;
    });
  }

  Future<void> _saveTheme(bool isDarkMode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', isDarkMode);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: _isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: Scaffold(
        backgroundColor: _isDarkMode ? Colors.black : backgroundColor, // Apply theme color
        appBar: AppBar(
          // centerTitle: true,
          backgroundColor: _isDarkMode ? Colors.black : backgroundColor, // Apply theme color
          automaticallyImplyLeading: false,
          title: SlideTransition(
              position: _upSlideAnimation,
              child: InterCustomText(
                fontWeight: FontWeight.w600,
                fontsize: 26,
                text: 'My Profile',
                textColor: _isDarkMode ? Colors.white : primaryColor, // Apply theme color
              )),
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(1.0),
            child: Divider(
              color: greyColor,
              thickness: 0.2,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: SlideTransition(
              position: _slideAnimation,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20.h,
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    alignment: Alignment.center,
                    width: double.infinity,
                    color: _isDarkMode ? Colors.black : Colors.white, // Apply theme color
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          AnimatedSwitcher(
                            duration: const Duration(milliseconds: 300),
                            transitionBuilder:
                                (Widget child, Animation<double> animation) {
                              return FadeTransition(
                                opacity: animation,
                                child: child,
                              );
                            },
                            child: Obx(() {
                              return Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: userController.profileImageUrl.value.isNotEmpty
                                        ? NetworkImage(userController.profileImageUrl.value)
                                        : const AssetImage(AppImages.profilePic) as ImageProvider, // Fallback to static image if no URL
                                  ),
                                ),
                              );
                            }),
                          ),
                          const SizedBox(
                            width: 18,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Obx(() {
                                return InterCustomText(
                                  text: userController.userName.value,
                                  textColor: _isDarkMode ? Colors.white : secondaryText, // Apply theme color
                                  fontWeight: FontWeight.w500,
                                  fontsize: 20,
                                );
                              }),
                              const SizedBox(
                                height: 2,
                              ),
                              Obx(() {
                                return InterCustomText(
                                  text: userController.userEmail.value,
                                  textColor: _isDarkMode ? Colors.white : secondaryText, // Apply theme color
                                  fontWeight: FontWeight.w500,
                                  fontsize: 14,
                                );
                              }),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  // SizedBox(
                  //   height: 12.h,
                  // ),
                  // GestureDetector(
                  //   onTap: _selectImage,
                  //   child: InterCustomText(
                  //     text: 'Edit profile image',
                  //     textColor: primaryColor,
                  //   ),
                  // ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: InterCustomText(
                        text: 'My Account Information',
                        textColor: _isDarkMode ? Colors.white : secondaryText, // Apply theme color
                        fontsize: 14.sp,
                        fontWeight: FontWeight.w500,
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ChangePassword(email:userController.userEmail.value,)),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      alignment: Alignment.centerLeft,
                      width: double.infinity,
                      height: 60.h,
                      decoration: BoxDecoration(color: _isDarkMode ? Colors.black : Colors.white), // Apply theme color
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InterCustomText(
                            fontsize: 16,
                            text: 'Change Password',
                            textColor: _isDarkMode ? Colors.white : primaryColor, // Apply theme color
                          ),
                          Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: _isDarkMode ? Colors.white : secondaryText, // Apply theme color
                          )
                        ],
                      ),
                    ),
                  ),
                  const Divider(
                    height: 0,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const EditProfile()),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      alignment: Alignment.centerLeft,
                      width: double.infinity,
                      height: 60.h,
                      decoration: BoxDecoration(color: _isDarkMode ? Colors.black : Colors.white), // Apply theme color
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InterCustomText(
                            fontsize: 16,
                            text: 'Edit Profile',
                            textColor: _isDarkMode ? Colors.white : primaryColor, // Apply theme color
                          ),
                          Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: _isDarkMode ? Colors.white : secondaryText, // Apply theme color
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: InterCustomText(
                        text: 'Support',
                        textColor: _isDarkMode ? Colors.white : secondaryText, // Apply theme color
                        fontsize: 14.sp,
                        fontWeight: FontWeight.w500,
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    alignment: Alignment.centerLeft,
                    width: double.infinity,
                    decoration: BoxDecoration(color: _isDarkMode ? Colors.black : Colors.white), // Apply theme color
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20.h,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const AccountSettings()),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InterCustomText(
                                  fontsize: 16,
                                  text: 'Account Settings',
                                  textColor: _isDarkMode ? Colors.white : primaryColor, // Apply theme color
                                ),
                                Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  color: _isDarkMode ? Colors.white : secondaryText, // Apply theme color
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        const Divider(
                          height: 0,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 15.h, horizontal: 10.w),
                          decoration: BoxDecoration(color: _isDarkMode ? Colors.black : backgroundColor), // Apply theme color
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _isDarkMode = false;
                                      _saveTheme(false);
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: !_isDarkMode
                                            ? primaryColor
                                            : Colors.white,
                                        borderRadius: BorderRadius.circular(12)),
                                    padding: EdgeInsets.symmetric(vertical: 15.h),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.light_mode,
                                          color: !_isDarkMode
                                              ? Colors.white
                                              : primaryText,
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        InterCustomText(
                                          text: 'Light',
                                          textColor: !_isDarkMode
                                              ? Colors.white
                                              : primaryText,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _isDarkMode = true;
                                      _saveTheme(true);
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: _isDarkMode
                                            ? primaryColor
                                            : Colors.white,
                                        borderRadius: BorderRadius.circular(12)),
                                    padding: EdgeInsets.symmetric(vertical: 15.h),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.dark_mode,
                                          color: _isDarkMode
                                              ? Colors.white
                                              : primaryText,
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        InterCustomText(
                                          text: 'Dark',
                                          textColor: _isDarkMode
                                              ? Colors.white
                                              : primaryText,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: FadeTransition(
                      opacity: _fadeAnimation,
                      child: SlideTransition(
                          position: _slideAnimation,
                          child: GestureDetector(
                            onTap: () {
                              login.logOut();
                            },
                            child: Container(
                              width: 90,
                              height: 36,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: secondarybackgroundColor,
                                  borderRadius: BorderRadius.circular(12)),
                              child: InterCustomText(
                                text: 'Log Out',
                                textColor: secondaryText,
                              ),
                            ),
                          )),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedField(
      String label,
      String hint,
      TextInputType keyboardType,
      FocusNode focusNode,
      ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: InterCustomText(
            text: label,
            textColor: primaryColor,
            fontsize: 20.sp,
            textAlign: TextAlign.start,
          ),
        ),
        const SizedBox(height: 10),
        FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: InputField(
              hint: hint,
              keyboard: keyboardType,
              focusNode: focusNode,
            ),
          ),
        ),
      ],
    );
  }
}