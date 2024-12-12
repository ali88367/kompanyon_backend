import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../const/color.dart';
import '../../custom_widgets/custom_container.dart';
import '../../custom_widgets/custom_text.dart';
import '../../widgets/custom_inter_text.dart';
import 'custom_box_widget.dart';

class Article_and_resources3 extends StatefulWidget {
  const Article_and_resources3({super.key});

  @override
  State<Article_and_resources3> createState() => _Article_and_resources3State();
}

class _Article_and_resources3State extends State<Article_and_resources3> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;late Animation<Offset> _rightSlideAnimation;

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
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 40.h),
              SlideTransition(
                position: _rightSlideAnimation,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InterCustomText(
                      text: 'Stress\nReduction',
                      fontsize: 36.sp,
                      textColor: primaryColor,
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
                          text: 'Reduce stress and enhance well-being with proven techniques and strategies.',
                          fontsize: 24.sp,
                          textColor: primaryColor,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              SlideTransition(
                position: _slideAnimation,
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: CustomBox3(
                    text1: 'Articles & Resources',
                    text2: 'Articles and resources for stress reduction provide expert insights and practical tips on managing stress and improving mental well-being. By staying informed and learning new strategies, you can better handle stress and maintain a balanced, healthy lifestyle.',
                  ),
                ),
              ),
              SizedBox(height: 35.h),
              SlideTransition(
                position: _slideAnimation,
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: CustomContainer(text: 'Back'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
