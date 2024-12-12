import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../const/color.dart';
import '../../custom_widgets/custom_box_widget.dart';
import '../../custom_widgets/custom_container.dart';
import '../../custom_widgets/custom_text.dart';
import '../../widgets/custom_inter_text.dart';

class GuidedVisualization extends StatefulWidget {
  const GuidedVisualization({super.key});

  @override
  State<GuidedVisualization> createState() => _GuidedVisualizationState();
}

class _GuidedVisualizationState extends State<GuidedVisualization> with SingleTickerProviderStateMixin {
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
    _slideAnimation = Tween<Offset>(begin: Offset(0.0, 0.1), end: Offset.zero)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInQuad));

    _fadeAnimation = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.elasticOut));

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
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
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
                            fontsize: 24.sp,
                            textAlign: TextAlign.center,
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
                      text1: 'Guided Visualization',
                      text2: 'Guided visualizations in leadership help you envision successful outcomes and strategies, enhancing your decision-making and confidence. By fostering a clear and focused mindset, these exercises empower you to inspire and lead with greater effectiveness and resilience.',
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
      ),
    );
  }
}
