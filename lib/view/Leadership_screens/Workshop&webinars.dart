import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../const/color.dart';
import '../../custom_widgets/custom_box_widget.dart';
import '../../custom_widgets/custom_container.dart';
import '../../custom_widgets/custom_text.dart';
import '../../widgets/custom_inter_text.dart';

class Workshop_webinars extends StatefulWidget {
  const Workshop_webinars({super.key});

  @override
  State<Workshop_webinars> createState() => _Workshop_webinarsState();
}

class _Workshop_webinarsState extends State<Workshop_webinars> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;
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

    _slideAnimation = Tween<Offset>(
      begin: Offset(0.0, 0.1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20.h),
            SlideTransition(
              position: _rightSlideAnimation,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InterCustomText(
                    text: 'Leadership',
                    textColor: primaryColor,
                    fontsize: 36.sp,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: SlideTransition(
                position: _rightSlideAnimation,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: InterCustomText(
                        text: 'Elevate your leadership\npotential and inspire\nexcellence.',
                        textColor: primaryColor,
                        textAlign: TextAlign.center,
                        fontsize: 24.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 25.h),
            SlideTransition(
              position: _slideAnimation,
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: CustomBox(
                  text1: 'Workshops & Webinars',
                  text2: 'Leadership workshops and webinars offer interactive learning experiences led by seasoned professionals, designed to develop your leadership capabilities. Engaging in these sessions equips you with practical tools and knowledge to lead with confidence and drive positive organizational change.',
                ),
              ),
            ),
            SizedBox(height: 25.h),
            SlideTransition(
              position: _slideAnimation,
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: GestureDetector(
                  onTap: () {
                    // Handle back navigation
                    Navigator.pop(context);
                  },
                  child: CustomContainer(text: 'Back'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
