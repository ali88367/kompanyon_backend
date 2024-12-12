import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kompanyon_app/view/nav_bar/nav_bar.dart';
import '../../const/color.dart';
import '../../custom_widgets/custom_container.dart';
import '../../custom_widgets/custom_text.dart';
import '../../widgets/custom_inter_text.dart';
import 'Article_and_resources.dart';
import 'Guided_visualization.dart';
import 'Neuroplasticity_screen.dart';
import 'Workshop&webinars.dart';

class Leadership extends StatefulWidget {
  const Leadership({super.key});

  @override
  State<Leadership> createState() => _LeadershipState();
}

class _LeadershipState extends State<Leadership>   with SingleTickerProviderStateMixin{
  final List<String> containerTexts = [
    'Guided Visualizations',
    'Neuroplasticity',
    'Articles & Resources',
    'Workshops & Webinars'
  ];
  late AnimationController _controller;
  late Animation<Offset> _upSlideAnimation;
  late Animation<double> _opacityAnimation;
  late Animation<Offset> _rightSlideAnimation;
  @override

  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _opacityAnimation = Tween<double>(begin: 0, end: 1).animate(_controller);

    // Slide in from below for list items
    _upSlideAnimation = Tween<Offset>(begin: Offset(0.0, 2.0), end: Offset.zero)
        .animate(_controller);

    _rightSlideAnimation =
        Tween<Offset>(begin: Offset(-2.0, 1.0), end: Offset.zero)
            .animate(_controller);

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  final List<Widget> navigationRoutes = [
    GuidedVisualization(),
    NeuroplasticityScreen(),
    ArticleAndResources(),
    Workshop_webinars()
  ];

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
                SizedBox(height: 40.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FadeTransition(
                      opacity: _opacityAnimation,
                      child: SlideTransition(
                          position: _upSlideAnimation,
                          child: InterCustomText(text: 'Leadership', textColor: primaryColor,fontsize: 36.sp,textAlign: TextAlign.center,)),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child:  SlideTransition(
                          position: _rightSlideAnimation,
                          child: InterCustomText(text: 'Elevate your leadership\npotential and inspire\nexcellence.',
                            textColor: primaryColor,textAlign: TextAlign.center,fontsize: 24.sp,),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SlideTransition(
                    position: _upSlideAnimation,
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
                        return GestureDetector(
                          onTap: () {
                            Get.to(navigationRoutes[index]);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                             color: primaryColor
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
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(height: 30,),
                GestureDetector(
                  onTap: () {
                    Get.offAll(BottomBar());

                  },
                  child: FadeTransition(
                      opacity: _opacityAnimation,
                      child: CustomContainer(text: 'Back',)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
