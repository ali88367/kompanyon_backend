import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kompanyon_app/const/color.dart';
import 'package:kompanyon_app/controller/bottom_bar_controller.dart';
import 'package:kompanyon_app/view/add_screen/add_screen.dart';
import 'package:kompanyon_app/view/home_screen/home_screen.dart';
import 'package:kompanyon_app/view/notification_screen/notification.dart';
import 'package:kompanyon_app/view/profile/profile.dart';
import 'package:kompanyon_app/view/search_screen/search_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

import '../../audio_controller.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_inter_text.dart';
import '../../widgets/custom_textfield.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  late List<Color> _iconColors = [];
  BottomBarController bottomVM = Get.put(BottomBarController());
  final AudioController audioController = Get.put(AudioController()); // Your audio controller

  @override
  void initState() {
    super.initState();
    _iconColors = List<Color>.generate(4, (index) => Colors.grey);
  }

  List<Widget> _buildScreens() {
    return [
      HomeScreen(),
      SearchScreen(),
      Container(),
      NotificationScreen(),
      Profile(),
    ];
  }


  void _showReflectionDialog() {
    final _feelingController = TextEditingController();
    final _gratitudeController = TextEditingController();
    final _meditationController = TextEditingController();
    String? selectedMood;
    String? selectedMeditation;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: backgroundColor,
          title: InterCustomText(text: 'Daily Reflection', textColor: primaryColor),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InterCustomText(textColor: primaryColor, text: 'How are you Feeling Today?', fontsize: 18.sp),
                SizedBox(height: 10.h),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 10.0),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: containerBorder),
                        borderRadius: BorderRadius.circular(12.r)),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: primaryColor),
                        borderRadius: BorderRadius.circular(12.r)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: primaryColor),
                        borderRadius: BorderRadius.circular(12.r)),
                  ),
                  hint: InterCustomText(text: 'Current Mood', textColor: primaryColor),
                  value: selectedMood,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedMood = newValue;
                    });
                  },
                  items: <String>['Happy', 'Moderate', 'Sad'].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: InterCustomText(text: value, textColor: primaryColor),
                    );
                  }).toList(),
                ),
                SizedBox(height: 10.h),
                InterCustomText(textColor: primaryColor, text: 'Write 3 blessings for which you are grateful.', fontsize: 18.sp),
                SizedBox(height: 10.h),
                InputField(
                  hint: "",
                  keyboard: TextInputType.name,
                  label: "",
                  controller: _gratitudeController,
                ),
                SizedBox(height: 10.h),
                InterCustomText(textColor: primaryColor, text: 'Which activities improve your mood?', fontsize: 18.sp),
                SizedBox(height: 10.h),
                InputField(
                  hint: "",
                  keyboard: TextInputType.name,
                  label: "",
                  controller: _feelingController,
                ),
                SizedBox(height: 10.h),
                InterCustomText(text: 'How do you prefer to meditate?', textColor: primaryColor, fontsize: 18.sp),
                SizedBox(height: 10.h),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 10.0),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: containerBorder),
                        borderRadius: BorderRadius.circular(12.r)),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: primaryColor),
                        borderRadius: BorderRadius.circular(12.r)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: primaryColor),
                        borderRadius: BorderRadius.circular(12.r)),
                  ),
                  hint: InterCustomText(text: 'Meditation Style', textColor: primaryColor),
                  value: selectedMeditation,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedMeditation = newValue;
                    });
                  },
                  items: <String>['Reading', 'Listening', 'Writing'].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: InterCustomText(text: value, textColor: primaryColor),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          actions: [
            CustomButton(
              height: 52.h,
              text: 'Submit',
              onPressed: () async {
                final feeling = _feelingController.text;
                final gratitude = _gratitudeController.text;
                final meditation = _meditationController.text;

                // Get the current user's UID
                final userId = FirebaseAuth.instance.currentUser?.uid;

                if (userId == null) {
                  // Handle case where user is not logged in
                  print('User not logged in');
                  return;
                }

                // Prepare data to save in Firestore
                final reflectionData = {
                  'uid': userId,  // Add user ID to the reflection data
                  'mood': selectedMood,
                  'feeling': feeling,
                  'gratitude': gratitude,
                  'meditation': selectedMeditation,
                  'timestamp': FieldValue.serverTimestamp(), // Adds a timestamp
                };

                // Save data to Firestore
                try {
                  await FirebaseFirestore.instance
                      .collection('reflections')
                      .add(reflectionData);

                  // Close the dialog
                  Navigator.of(context).pop();

                  // Show the Snackbar
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Added successfully!'),
                      backgroundColor: primaryColor,
                      duration: Duration(seconds: 2),
                    ),
                  );
                } catch (e) {
                  print('Error adding reflection: $e');
                  // Handle error, e.g., show an error message
                }
              },
            ),
          ],
        );
      },
    );
  }


  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        onPressed: (context) {
          // Stop audio when switching tab
          audioController.stopAudio();
          bottomVM.controller.jumpToTab(0);
        },
        icon: Icon(Icons.home_rounded),
        activeColorPrimary: primaryColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        onPressed: (context) {
          // Stop audio when switching tab
          audioController.stopAudio();
          bottomVM.controller.jumpToTab(1);
        },
        icon: Icon(CupertinoIcons.search),
        activeColorPrimary: primaryColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        onPressed: (context) {
          _showReflectionDialog();
        },
        icon: Icon(Icons.add_circle),
        activeColorPrimary: primaryColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.notifications),
        activeColorPrimary: primaryColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        onPressed: (c) {
          // Stop audio when switching tab
          audioController.stopAudio();
          bottomVM.controller.jumpToTab(4);
        },
        icon: Icon(Icons.person),
        activeColorPrimary: primaryColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: bottomVM.controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      backgroundColor: backgroundColor,
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: backgroundColor,
      ),
      navBarHeight: 70,
      navBarStyle: NavBarStyle.style6,
    );
  }
}
