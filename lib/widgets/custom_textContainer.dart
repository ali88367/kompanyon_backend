import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // For sizing
import 'package:google_fonts/google_fonts.dart';
import 'package:kompanyon_app/const/color.dart'; // If you're using Google Fonts

class CustomTextContainer extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color;
  final Color textColor;
  final double fontSize;
  final FontWeight fontWeight;

  CustomTextContainer({
    required this.text,
    required this.onPressed,
    this.color = greyColor1,
    this.textColor = Colors.black,
    this.fontSize = 16.0,
    this.fontWeight = FontWeight.w500,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 343.w, // Adjust to your needs
      height: 50.h, // Adjust to your needs
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        color: color,
      ),
      child: TextButton(
        onPressed: onPressed,
        child: Center(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              textStyle: TextStyle(
                color: textColor,
                fontWeight: fontWeight,
                fontSize: fontSize.sp,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
