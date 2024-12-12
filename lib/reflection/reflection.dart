import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kompanyon_app/const/color.dart';
import 'package:kompanyon_app/custom_widgets/custom_container.dart';

import '../widgets/custom_button.dart';
import '../widgets/custom_textfield.dart';



class Reflection extends StatefulWidget {
  @override
  _ReflectionState createState() => _ReflectionState();
}

class _ReflectionState extends State<Reflection> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 40.0.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 270.h),
            Center(
              child: Text(
                'How did you demonstrate leadership in your\ninteractions this week?',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24.sp,height: 1,color: primaryColor),
              ),
            ),
            SizedBox(height: 40.h),

            InputField(
              maxlines: 5,
              contentPadding:
              EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              hint: 'Type your answer here',
              keyboard: TextInputType.text,

            ),
            SizedBox(height: 135.h),
            CustomButton(
                height: 58.h,
                text: "Save", onPressed: (){
             Navigator.pop(context);
            }
            ),
            SizedBox(height: 93,),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: CustomContainer(text: 'Back'),
            ),
          ],
        ),
      ),

    );
  }
}
