import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../const/color.dart';
import '../../custom_widgets/custom_container.dart';
import '../../custom_widgets/custom_text.dart';
import '../../widgets/custom_inter_text.dart';
import 'Articles & resources.dart';
import 'Guided_visualization.dart';
import 'Neuroplasticity.dart';
import 'Workshop & Webinars.dart';

class StressReduction extends StatefulWidget {
  const StressReduction({super.key});

  @override
  State<StressReduction> createState() => _StressReductionState();
}

class _StressReductionState extends State<StressReduction> with SingleTickerProviderStateMixin {
  final List<String> containerTexts3 = [
    '      Guided\nVisualizations',
    'Neuroplasticity',
    'Articles &\nResources',
    'Workshops &\n    Webinars'
  ];

  final List<Widget> navigationRoutes3 = [
    GuidedVisualization3(),
    Neuroplasticity3(),
    Article_and_resources3(),
    Workshop_andWebinars3()
  ];

  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(begin: Offset(0.0, 1.0), end: Offset.zero)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _fadeAnimation = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

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
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 40.h),
            SlideTransition(
              position: _slideAnimation,
              child: FadeTransition(
                opacity: _fadeAnimation,
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
            ),
            SizedBox(height: 10),
            FadeTransition(
              opacity: _fadeAnimation,
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
            SizedBox(height: 10),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SlideTransition(
                  position: _slideAnimation,
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 45.0,
                      mainAxisSpacing: 45.0,
                    ),
                    itemCount: containerTexts3.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          // Navigate to the specific route when a container is tapped
                          Get.to(navigationRoutes3[index]);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: primaryColor, // RGB color with full opacity
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            containerTexts3[index],
                            style: TextStyle(
                              color: Color.fromRGBO(255, 255, 255, 1), // RGB color with full opacity
                              fontSize: 14.0.sp,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.center, // Ensure the text is centered
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),
            FadeTransition(
              opacity: _fadeAnimation,
              child: GestureDetector(
                onTap: () {
                  // Handle back navigation
                  Navigator.pop(context);
                },
                child: CustomContainer(text: 'Back'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
