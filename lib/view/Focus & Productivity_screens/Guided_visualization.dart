import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../const/color.dart';
import '../../custom_widgets/custom_container.dart';
import '../../custom_widgets/custom_text.dart';
import '../../widgets/custom_inter_text.dart';
import 'custom_box_widget.dart';

class GuidedVisualization2 extends StatefulWidget {
  const GuidedVisualization2({super.key});

  @override
  State<GuidedVisualization2> createState() => _GuidedVisualization2State();
}

class _GuidedVisualization2State extends State<GuidedVisualization2> with SingleTickerProviderStateMixin {
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
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SlideTransition(
                  position: _rightSlideAnimation,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InterCustomText(
                        text: 'Focus &\nProductivity',
                        textColor: primaryColor,
                        fontsize: 36.sp,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 40.h), // Adjusted spacing
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: SlideTransition(
                    position: _rightSlideAnimation,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: InterCustomText(
                            text: 'Enhance your productivity and sharpen your focus to achieve peak performance.',
                            textColor: primaryColor,
                            fontsize: 24.sp,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20.h), // Adjusted spacing
                SlideTransition(
                  position: _slideAnimation,
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: CustomBox2(
                      text1: 'Guided Visualization',
                      text2: 'Guided visualizations for focus and productivity help you clear mental clutter and visualize your path to achieving key goals, enhancing your concentration and efficiency. By fostering a focused and energized mindset, these exercises empower you to maximize your productivity and achieve peak performance.',
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                SlideTransition(
                  position: _slideAnimation,
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: CustomContainer(text: 'Back'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
