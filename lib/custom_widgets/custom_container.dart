import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kompanyon_app/const/color.dart';

class CustomContainer extends StatelessWidget {
  final String text;

  const CustomContainer({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          height: 32.h,
          width: 142.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Color.fromRGBO(210, 207, 201, 1), // RGB color with full opacity

          ),
          alignment: Alignment.center,
          child: Text(
            text,
            style: GoogleFonts.inter(
              textStyle: TextStyle(
                color: primaryColor, // RGB color with full opacity
                fontSize: 16.0.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
