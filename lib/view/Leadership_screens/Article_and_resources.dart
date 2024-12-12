import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kompanyon_app/widgets/custom_inter_text.dart';
import '../../const/color.dart';
import '../../custom_widgets/custom_box_widget.dart';
import '../../custom_widgets/custom_container.dart';
import '../../custom_widgets/custom_text.dart';

class ArticleAndResources extends StatefulWidget {
  const ArticleAndResources({super.key});

  @override
  State<ArticleAndResources> createState() => _ArticleAndResourcesState();
}

class _ArticleAndResourcesState extends State<ArticleAndResources> with SingleTickerProviderStateMixin {
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
                    text: 'Leadership',
                    textColor: primaryColor,
                    fontsize: 36.sp,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
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
                  text1: 'Articles & Resources',
                  text2: 'Leadership articles and resources provide valuable insights and strategies from industry experts to enhance your leadership skills. By staying informed and continuously learning, you can implement proven techniques to effectively guide and inspire your team.',
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
    );
  }
}
