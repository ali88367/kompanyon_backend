import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:google_fonts/google_fonts.dart';

import '../../const/color.dart';


class CustomBox5 extends StatelessWidget {
  final String text1;
  final String text2;

  const CustomBox5({
    super.key,
    required this.text1,
    required this.text2,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Container(
        decoration: BoxDecoration(
          color: Color.fromRGBO(210, 207, 201, 0.25), // 25% opacity
          borderRadius: BorderRadius.circular(33),
        ),
        padding: EdgeInsets.all(30.0.w), // Responsive padding
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              text1,
              style: GoogleFonts.inter(
                textStyle: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 24.0.sp, // Responsive font size
                  height: 33.6 / 24, // Line height divided by font size
                  color: Colors.black,
                ),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8.0.h), // Responsive spacing
            Text(
              text2,
              style: GoogleFonts.inter(
                textStyle: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 16.0.sp, // Responsive font size
                  height: 22.4 / 16, // Line height divided by font size
                  color: Colors.black,
                ),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 25.0.h), // Responsive spacing
            GestureDetector(
              // onTap: () {
              //   Get.to(StressReduction()); // Replace 'NewScreen' with your target screen
              // },
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                height: 32.0.h, // Responsive height
                width: 168.0.w, // Responsive width
                child: Text(
                  'Start',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.0.sp, // Responsive font size
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
