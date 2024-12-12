import 'package:flutter/material.dart';
import 'package:kompanyon_app/const/color.dart';
import 'package:kompanyon_app/view/Auth/signup_screen.dart';
import 'package:kompanyon_app/widgets/custom_inter_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../const/image.dart';

class TransitionOThree extends StatefulWidget {
  const TransitionOThree({super.key});

  @override
  State<TransitionOThree> createState() => _TransitionOThreeState();
}

class _TransitionOThreeState extends State<TransitionOThree>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _rightSlideAnimation;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _rightSlideAnimation =
        Tween<Offset>(begin: Offset(-2.0, 1.0), end: Offset.zero)
            .animate(_controller);
    // _animation = CurvedAnimation(
    //   parent: _controller,
    //   curve: Curves.linearToEaseOut,
    // );

    _controller.forward();
     _navigateToNextScreen();

    // Navigate to the next screen after 2 seconds
  }

  _navigateToNextScreen() async {
    await Future.delayed(Duration(seconds: 2), () {});
    Navigator.of(context).pushReplacement(_createRoute());
  }

  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => Signup(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var tween = Tween(begin: 0.0, end: 1.0);
        return FadeTransition(
          opacity: animation.drive(tween),
          child: child,
        );
      },
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
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SlideTransition(
              position: _rightSlideAnimation,
              child: Image.asset(
                AppImages.bgName,
              ),
            ),
            SizedBox(
              height: 85.h,
            ),
            SlideTransition(
              position: _rightSlideAnimation,
              child: InterCustomText(
                textAlign: TextAlign.center,
                text:
                    'Transforming Workplaces, One\nMindful Moment at a Time',
                textColor: primaryColor,
                fontsize: 24.sp,
              ),
            ),
            SizedBox(
              height: 15.h,
            )
          ],
        ),
      ),
    );
  }
}
