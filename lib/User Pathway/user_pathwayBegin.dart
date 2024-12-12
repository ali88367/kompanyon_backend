import 'package:flutter/material.dart';
import 'package:kompanyon_app/User%20Pathway/user_pathway1.dart';
import 'package:kompanyon_app/const/color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kompanyon_app/const/image.dart';
import 'package:kompanyon_app/view/nav_bar/nav_bar.dart';
import 'package:kompanyon_app/widgets/custom_button.dart';
import 'package:get/get.dart';

import 'package:kompanyon_app/widgets/custom_inter_text.dart';
import '../custom_widgets/custom_container.dart';

class UserPathwayBegin extends StatefulWidget {
  const UserPathwayBegin({super.key});

  @override
  _UserPathwayBeginState createState() => _UserPathwayBeginState();
}

class _UserPathwayBeginState extends State<UserPathwayBegin>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );
    _slideAnimation = Tween<Offset>(
      begin: Offset(0, 1),
      end: Offset(0, 0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));
    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut,
    ));
    _controller.forward();
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 40.h,
          ),
          GestureDetector(
            onTap: () {
           Navigator.pop(context);
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
          FadeTransition(
            opacity: _fadeAnimation,
            child: SlideTransition(
              position: _slideAnimation,
              child: InterCustomText(
                text: "Let's find your pathway",
                textColor: primaryColor,
                fontsize: 24,
              ),
            ),
          ),
          SizedBox(height: 24.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 27.w),
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: Text(
                  "This brief assessment helps us understand your unique needs and preferences"
                  " to tailor your experience.By completing it,you will gain access to personalized"
                  " recommendations and resources designed to enhance your well-being and productivity."
                  " Your insights give us in providing the most relevant tools and support for your journey.Lets get started and unlock a path to a more fulfilling work-life \n balance!",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20.sp, color: primaryColor),
                ),
              ),
            ),
          ),
          SizedBox(height: 67.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 44.w),
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: CustomButton(
                  text: "Let's Begin",
                  onPressed: () {
                    // Navigate to UserPathway2 with custom transition
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            UserPathway1(), // Your desired next screen
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          // Use your desired transition (slide left with fade)
                          return SlideTransition(
                            position: animation.drive(Tween<Offset>(
                                    begin: const Offset(1.0, 0.0),
                                    end: const Offset(0.0, 0.0))
                                .chain(CurveTween(curve: Curves.easeInOut))),
                            child: FadeTransition(
                              opacity:
                                  animation.drive(Tween(begin: 0.0, end: 1.0)),
                              child: child,
                            ),
                          );
                        },
                      ),
                    );
                  },
                  height: 52.h,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
