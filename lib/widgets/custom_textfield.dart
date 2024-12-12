import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kompanyon_app/const/color.dart';

class InputField extends StatelessWidget {
  final FocusNode? focusNode;
  final int maxlines;
  final String? label;
  final contentPadding;
  final String hint;
  // final String preIcon;
  // final FocusNode inputFocus;
  final TextEditingController? controller;
  final FormFieldValidator<String?>? validator;
  // final VoidCallback onComplete;
  final TextStyle hintStyle;
  final TextStyle inputTextStyle;
  final TextInputType keyboard;
  final Color? cursorColor;
  final bool readOnly;

  const InputField(
      {super.key,
        this.label,
      required this.hint,
      // required this.preIcon,
      // required this.inputFocus,
      // required this.onComplete,
      required this.keyboard,
      this.hintStyle =
          const TextStyle(color: Color(0xff828282), fontWeight: FontWeight.w400,fontSize: 14),
      this.inputTextStyle = const TextStyle(color: Colors.black),
      this.controller,
      this.cursorColor,
      this.validator,
      this.readOnly = false,
      this.contentPadding,
      this.maxlines = 1,
      this.focusNode});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: focusNode,

      maxLines: maxlines,
      readOnly: readOnly,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: controller,
      keyboardType: keyboard,
      validator: validator,
      // focusNode: inputFocus,
      textInputAction: TextInputAction.next,
      // onEditingComplete: onComplete,
      style: inputTextStyle,
      cursorColor: cursorColor,
      textAlign: TextAlign.start,
      decoration: InputDecoration(
        alignLabelWithHint: true,

        filled: true,
         fillColor:  whiteColor,
        hintText: hint,
        hintStyle: hintStyle,
        labelText:label,
        labelStyle: TextStyle(color: primaryColor),
        // prefixIcon: Padding(
        //   padding: const EdgeInsets.all(15.0),
        //   child: SvgPicture.asset(preIcon),
        // ),

        contentPadding: contentPadding,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.r),
          borderSide: const BorderSide(color: primaryColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.r),
          borderSide: const BorderSide(color: primaryColor),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.r),
          borderSide: const BorderSide(color:primaryColor),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: primaryColor),
          borderRadius: BorderRadius.circular(15.r),
        ),
      ),
    );
  }
}
