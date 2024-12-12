import 'package:flutter/material.dart';
import 'package:kompanyon_app/const/color.dart';
import 'package:kompanyon_app/const/image.dart';
import 'package:kompanyon_app/widgets/custom_button.dart';
import 'package:kompanyon_app/widgets/custom_inter_text.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:kompanyon_app/widgets/custom_textfield.dart';

class AccountSettings extends StatefulWidget {
  const AccountSettings({super.key});

  @override
  State<AccountSettings> createState() => _AccountSettingsState();
}

class _AccountSettingsState extends State<AccountSettings> {
  String? selectedRole;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: backgroundColor,
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              color: primaryColor,
              size: 35,
            )),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InterCustomText(
              text: "Account Settings",
              textColor: primaryColor,
              fontsize: 35.sp,
            ),
            InterCustomText(
              text: "Please evaluate your options below",
              textColor: secondaryText,
              fontsize: 14.sp,
            ),
            SizedBox(
              height: 15.h,
            ),
            SettingsRow(
              text: "Getting Started",
            ),
            SettingsRow(
              text: "About Us",
            ),
            SettingsRow(
              text: "Help",
            ),
            SettingsRow(
              text: "Privacy Policy",
            ),
            SettingsRow(
              text: "Terms & Conditions",
            ),
            SizedBox(
              height: 10.h,
            ),
            InterCustomText(
              text: "Follow us on",
              textColor: secondaryText,
              fontsize: 14.sp,
            ),
            SizedBox(
              height: 15.h,
            ),
            Row(
              children: [
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 4.w, vertical: 10.h),
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: Color(0xffE0E3E7), width: 2)),
                  child: Image.asset(
                    AppImages.youtube,
                    color: secondaryText,
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 4.w, vertical: 10.h),
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: Color(0xffE0E3E7), width: 2)),
                  child: Image.asset(
                    AppImages.instagram,
                    color: secondaryText,
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 4.w, vertical: 10.h),
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: Color(0xffE0E3E7), width: 2)),
                  child: Image.asset(
                    AppImages.facebook,
                    color: secondaryText,
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 4.w, vertical: 10.h),
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: Color(0xffE0E3E7), width: 2)),
                  child: Image.asset(
                    AppImages.linkedin,
                    color: secondaryText,
                  ),
                ),
              ],
            ),
            Spacer(),
            InterCustomText(
              text: "App Versions",
              textColor: primaryColor,
              fontsize: 25.sp,
            ),
            InterCustomText(
              text: "v0.0.1",
              textColor: primaryColor,
              fontsize: 14.sp,
            ),
            SizedBox(
              height: 70.h,
            ),
          ],
        ),
      ),
    );
  }
}

class SettingsRow extends StatelessWidget {
  final String text;
  const SettingsRow({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.0.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InterCustomText(
            text: text,
            textColor: primaryColor,
            fontsize: 25.sp,
          ),
          Icon(
            Icons.keyboard_arrow_right_rounded,
            color: primaryColor,
          )
        ],
      ),
    );
  }
}
