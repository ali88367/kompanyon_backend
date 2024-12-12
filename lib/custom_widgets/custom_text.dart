import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class h1 extends StatelessWidget {
  final String text;
  final Color color;
  final double fontSize;
  final FontWeight fontWeight;

  const h1({
    required this.text,
    this.color = const Color.fromRGBO(0, 0, 0, 1), // Default color (black)
    this.fontSize = 36.0, // Default font size
    this.fontWeight = FontWeight.w600, // Default font weight
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Text(
        text,
        textAlign: TextAlign.center, // Center text alignment
        style: GoogleFonts.inter(
          color: color,
          fontSize: fontSize.sp, // Use ScreenUtil for responsive font size
          fontWeight: fontWeight,
        ),
      ),
    );
  }
}

class h2 extends StatelessWidget {
  final String text;
  final Color color;
  final double fontSize;
  final FontWeight fontWeight;

  const h2({
    required this.text,
    this.color = const Color.fromRGBO(0, 0, 0, 1), // Default color (black)
    this.fontSize = 24.0, // Default font size
    this.fontWeight = FontWeight.w100, // Default font weight
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Text(
        text,
        textAlign: TextAlign.center, // Center text alignment
        style: GoogleFonts.inter(
          color: color,
          fontSize: fontSize.sp, // Use ScreenUtil for responsive font size
          fontWeight: fontWeight,
        ),
      ),
    );
  }
}
