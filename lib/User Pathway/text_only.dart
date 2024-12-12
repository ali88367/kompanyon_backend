import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kompanyon_app/const/color.dart';
import 'package:kompanyon_app/view/home_screen/home_screen.dart';
import 'package:kompanyon_app/view/nav_bar/nav_bar.dart';
import 'package:kompanyon_app/widgets/custom_button.dart';
import 'package:kompanyon_app/widgets/custom_inter_text.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

import '../const/image.dart';

class TextOnly extends StatefulWidget {
  @override
  _TextOnlyState createState() => _TextOnlyState();
}

class _TextOnlyState extends State<TextOnly> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..forward();

    _slideAnimation = Tween<Offset>(
      begin: Offset(-1.0, 0.0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SlideTransition(
        position: _slideAnimation,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 40.h,
            ),
            GestureDetector(
              onTap: () {
          //      Navigator.of(context).push(MaterialPageRoute(builder: (context) => UserPathway9() ));

              },
              child: Align(
                  alignment: Alignment.topLeft,
                  child: Icon(
                    Icons.arrow_back,
                    color: primaryColor,
                    size: 45,
                  )),
            ),
            SizedBox(
              height: 60.h,
            ),
            Center(
              child: InterCustomText(
                height: 1,
                text: 'Based off your responses we\n feel your pathway is best \nsuited for “Beginner Enthusiast”. \nMore details below',
                textAlign: TextAlign.center,
                textColor: primaryColor,
                fontsize: 24.sp,
              ),
            ),
            SizedBox(height: 20.h),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 32.0),
              child: InterCustomText(
                height: 1.8,
                text: '• Characteristics: Indicated you have little to no knowledge of mindfulness. Have never or rarely practiced before.\n'
                    '• Content Focus: Foundational principles of mindfulness, beginner-friendly guided meditations, and introduction to key concepts.\n'
                    '• Features: Simple tracking tools, beginner challenges, and educational content to address misconceptions.',
                textColor: primaryColor,
              ),
            ),
            SizedBox(height: 40.h),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: CustomButton(
                text: "Agree",
                onPressed: () {
                  // Navigate to UserPathway9 with custom transition
                  // Navigator.pushAndRemoveUntil(
                  //   context,
                  //   PageRouteBuilder(
                  //
                  //     pageBuilder: (context, animation, secondaryAnimation) => Scaffold(
                  //       body: BottomBar(), // Use the existing BottomBar here
                  //     ),                      transitionsBuilder: (context, animation, secondaryAnimation, child) {
                  //       return FadeTransition(
                  //         opacity: animation.drive(Tween(begin: 0.0, end: 1.0)),
                  //         child: SlideTransition(
                  //           position: animation.drive(Tween<Offset>(
                  //               begin: const Offset(-1.0, 0.0), end: const Offset(0.0, 0.0))),
                  //           child: child,
                  //         ),
                  //       );
                  //     },
                  //   ),  (Route<dynamic> route) => false, // Remove all previous routes
                  //
                  //
                  // );
                  PersistentNavBarNavigator.pushNewScreen(
                      context,
                      screen: BottomBar(),
                      withNavBar: false,
                      pageTransitionAnimation:
                      PageTransitionAnimation.cupertino,
                      );                },
                height: 58.h,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: CustomButton(
                text: "Disagree",
                onPressed: () {},
                height: 58.h,
              ),
            ),

          ],
        ),
      ),
    );
  }
}