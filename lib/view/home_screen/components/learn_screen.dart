import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kompanyon_app/const/color.dart';
import 'package:kompanyon_app/const/image.dart';
import 'package:kompanyon_app/widgets/custom_inter_text.dart';

class LearnScreen extends StatefulWidget {
  const LearnScreen({super.key});

  @override
  State<LearnScreen> createState() => _LearnScreenState();
}

class _LearnScreenState extends State<LearnScreen> {
  final List<Map<String, String>> items = [
    {'Category': 'Leadership', 'title': 'Setting Clear Intentions', 'duration': '2 min'},
    {'Category': 'Leadership', 'title': 'Visualization for Deep Work', 'duration': '4 min'},
    {
      'Category': 'Leadership',
      'title': 'Upcoming Webinar: Leaders...',
      'duration': '4 min'
    },
    {
      'Category': 'Leadership',
      'title': 'Reflection: Your Pathway',
      'duration': '3 min'
    },
  ];
  final FocusNode searchFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          toolbarHeight: 80,
          backgroundColor: whiteColor,
          automaticallyImplyLeading: false,
          title: InterCustomText(
            text: 'Learn',
            textColor: blackColor,

          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [

              Row(
                children: [
                  SizedBox(
                    width: 16.w,
                  ),
                  Container(
                    width: 295.w,
                    height: 40.h,
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(color: containerBorder, width: 1),
                      // boxShadow: [
                      //   BoxShadow(
                      //     color: Colors.grey.withOpacity(0.2),
                      //     spreadRadius: 2,
                      //     blurRadius: 5,
                      //     offset: Offset(0, 2), // changes position of shadow
                      //   ),
                      // ],
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.search,
                          color: Colors.grey,
                          size: 30,
                        ),
                        hintText: 'Search',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 8.w,
                  ),
                  Image.asset(
                    AppImages.FilterIcon,
                    width: 40.w,
                    height: 40.h,
                  )
                ],
              ),
              SizedBox(
                height: 30.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 37.w),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text('Category'),
                        SizedBox(
                          width: 20.w,
                        ),
                        Text('Title'),
                        Spacer(),
                        Text('Length'),
                        SizedBox(
                          width: 35.w,
                        ),
                      ],
                    ),
                    Divider(
                      color: containerBorder,
                    )
                  ],
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(left: 37.w, top: 5.h),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InterCustomText(
                              overflow: TextOverflow.ellipsis,
                              text: items[index]['Category']??"",

                              fontsize: 12.sp,
                              textColor: blackColor.withOpacity(0.90),
                            ),
                            SizedBox(width: 22),
                            Expanded(
                              child: InterCustomText(
                                overflow: TextOverflow.ellipsis,
                                text: items[index]['title']!,

                                fontsize: 14.sp,
                                textColor: blackColor,
                              ),
                            ),
                            SizedBox(width: 16),
                            Container(
                              width: 48.w,
                              height: 28.h,
                              // padding: EdgeInsets.all(4.0),
                              decoration: BoxDecoration(
                                border: Border.all(color: containerBorder),
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: Center(
                                  child: InterCustomText(
                                    text: items[index]['duration']!,

                                    fontsize: 12.sp,
                                    textColor: blackColor,
                                  )),
                            ),
                            SizedBox(width: 36.w),
                          ],
                        ),
                        if (index != items.length - 1)
                          Divider(
                            color: containerBorder,
                          )
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ));
  }
}
