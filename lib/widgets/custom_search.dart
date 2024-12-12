import 'package:flutter/material.dart';
import 'package:kompanyon_app/const/color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomSearch extends StatelessWidget {
  final FocusNode focusNode;

  const CustomSearch({Key? key, required this.focusNode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Unfocus the text field when tapping outside
        FocusScope.of(context).unfocus();
      },
      child: SizedBox(
        width: 310.w,
        // height: 45.h,
        // padding: EdgeInsets.symmetric(horizontal: 4.w),
        // decoration: BoxDecoration(
        //   color: Colors.white,
        //   borderRadius: BorderRadius.circular(12.r),
        //   border: Border.all(color: containerBorder, width: 1),
        // ),
        child: TextField(

          focusNode: focusNode,
          // textAlign: TextAlign.start,
          decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
             contentPadding: EdgeInsets.symmetric(),
            prefixIcon: Icon(
              Icons.search,
              color: primaryColor,
              size: 20.sp,
            ),
            hintText: 'Search',
            hintStyle: TextStyle(
              color: Colors.grey,
              fontSize: 16.0.sp,
            ),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r),borderSide: BorderSide.none),
              focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r),borderSide: BorderSide(color: containerBorder)),
          ),
        ),
      ),
    );
  }
}
