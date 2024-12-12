import 'package:flutter/material.dart';
import 'package:kompanyon_app/const/color.dart';
import 'package:kompanyon_app/view/transition_screen/transition_two.dart';
import 'package:kompanyon_app/widgets/custom_inter_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../const/image.dart';

class TransitionOne extends StatefulWidget {
  const TransitionOne({super.key});

  @override
  _TransitionOneState createState() => _TransitionOneState();
}

class _TransitionOneState extends State<TransitionOne>
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

    // Navigate to the next screen after 2 seconds

     _navigateToNextScreen();
  }

  _navigateToNextScreen() async {
    await Future.delayed(Duration(seconds: 2), () {});
    Navigator.of(context).pushReplacement(_createRoute());
  }

  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => TransitionOTwo(),
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
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SlideTransition(
              position: _rightSlideAnimation,
              child: Image.asset(
                AppImages.bgName,
              ),
            ),
            // SlideTransition(
            //   position: _rightSlideAnimation,
            //   child: InterCustomText(
            //     text: 'Welcome to\nKompanyon',
            //     textColor: primaryColor,
            //
            //     fontsize: 28.sp,
            //   ),
            // ),
            SizedBox(
              height: 85.h,
            ),
            SlideTransition(
              position: _rightSlideAnimation,
              child: InterCustomText(
                textAlign: TextAlign.center,
                text: 'Let’s start with creating\nyour profile',
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
