import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../const/color.dart';
import '../../custom_widgets/custom_container.dart';
import '../../custom_widgets/custom_text.dart';
import '../../widgets/custom_inter_text.dart';
import 'custom_box_widget.dart';

class NeuroplasticityScreen2 extends StatefulWidget {
  const NeuroplasticityScreen2({super.key});

  @override
  State<NeuroplasticityScreen2> createState() => _NeuroplasticityScreenState();
}

class _NeuroplasticityScreenState extends State<NeuroplasticityScreen2> with SingleTickerProviderStateMixin {
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
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
                      text1: 'Neuroplasticity',
                      text2: 'Neuroplasticity exercises for focus and productivity train your brain to develop stronger neural connections, enhancing your ability to concentrate and perform tasks efficiently. By regularly engaging in these exercises, you build the mental agility and resilience needed to maintain high productivity levels and achieve your goals.',
                    ),
                  ),
                ),
                SizedBox(height: 30.h), // Adjusted spacing
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
        ),
      ),
    );
  }
}
