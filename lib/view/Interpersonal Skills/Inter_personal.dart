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

class InterPersonal extends StatefulWidget {
  const InterPersonal({super.key});

  @override
  State<InterPersonal> createState() => _InterPersonalState();
}

class _InterPersonalState extends State<InterPersonal> with SingleTickerProviderStateMixin {
  final List<String> containerTexts = [
    'Guided Visualizations',
    'Neuroplasticity',
    'Articles & Resources',
    'Workshops & Webinars'
  ];

  final List<Widget> navigationRoutes = [
    GuidedVisualization4(),
    Neuroplasticity4(),
    Aritcles_and_resources4(),
    Workshop_andwebinar4()
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
                      text: 'Interpersonal\nSkills',
                      textColor: primaryColor,
                      fontsize: 36.sp,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: InterCustomText(
                        text: 'Enhance your communication and collaboration skills for stronger relationships.',
                        textColor: primaryColor,
                        textAlign: TextAlign.center,
                        fontsize: 24.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: GridView.builder(
                  shrinkWrap: true, // Ensure the GridView doesn't take up infinite height
                  physics: NeverScrollableScrollPhysics(), // Disable internal scrolling
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 45.0,
                    mainAxisSpacing: 45.0,
                  ),
                  itemCount: containerTexts.length,
                  itemBuilder: (context, index) {
                    return SlideTransition(
                      position: _slideAnimation,
                      child: FadeTransition(
                        opacity: _fadeAnimation,
                        child: GestureDetector(
                          onTap: () {
                            Get.to(navigationRoutes[index]);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: primaryColor,
                            ),
                            alignment: Alignment.center,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                containerTexts[index],
                                style: TextStyle(
                                  color: Color.fromRGBO(255, 255, 255, 1),
                                  fontSize: 14.0.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            SizedBox(height: 30),
            FadeTransition(
              opacity: _fadeAnimation,
              child: GestureDetector(
                onTap: () {
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
