import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InterCustomText extends StatelessWidget {
  final String text;
  final int? maxLines;
  final TextOverflow? overflow;
  final Color textColor;
  final double? fontsize;
  final double? height;
  final TextAlign? textAlign;
  final FontWeight? fontWeight; // Added fontWeight parameter

  const InterCustomText({
    super.key,
    required this.text,
    required this.textColor,
    this.fontsize,
    this.height,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.fontWeight =FontWeight.w400, // Added fontWeight parameter
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: overflow,
      maxLines: maxLines,
      textAlign: textAlign,
      style: GoogleFonts.asul(
        textStyle: TextStyle(
          fontStyle: FontStyle.italic,
          color: textColor,
          fontSize: fontsize,
          fontWeight: fontWeight, // Used fontWeight parameter
          height: height,
        ),
      ),
    );
  }
}
