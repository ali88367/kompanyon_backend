import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../const/color.dart';
import '../../custom_widgets/custom_container.dart';
import '../../custom_widgets/custom_text.dart';
import '../../widgets/custom_inter_text.dart';
import 'custom_box_widget.dart';

class Workshop_andwebinar4 extends StatefulWidget {
  const Workshop_andwebinar4({super.key});

  @override
  State<Workshop_andwebinar4> createState() => _Workshop_andwebinar4State();
}

class _Workshop_andwebinar4State extends State<Workshop_andwebinar4> with SingleTickerProviderStateMixin {
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
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 30.h), // Adjusted spacing
                SlideTransition(
                  position: _rightSlideAnimation,
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
                SizedBox(height: 20.h), // Adjusted spacing
                SlideTransition(
                  position: _rightSlideAnimation,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
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
                SizedBox(height: 20.h), // Adjusted spacing
                SlideTransition(
                  position: _slideAnimation,
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: CustomBox4(
                      text1: 'Workshops & Webinars',
                      text2: 'Workshops and webinars for interpersonal skills offer interactive sessions led by experts, teaching you effective communication and collaboration techniques. By participating in these sessions, you gain hands-on experience and insights that empower you to build stronger, more positive relationships.',
                    ),
                  ),
                ),
                SizedBox(height: 50.h), // Adjusted spacing
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
