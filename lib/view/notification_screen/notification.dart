import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kompanyon_app/const/color.dart';
import 'package:kompanyon_app/const/image.dart';
import 'package:kompanyon_app/widgets/custom_inter_text.dart';
import 'package:kompanyon_app/widgets/custom_search.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen>
    with SingleTickerProviderStateMixin {
  final List<Map<String, String>> items = [
    {'date': '6/15/24', 'title': 'Pulse Survey', 'duration': '2 min'},
    {'date': '6/15/24', 'title': 'Your Pathway', 'duration': '4 min'},
    {
      'date': '6/15/24',
      'title': 'Upcoming Webinar: Leaders...',
      'duration': '4 min'
    },
    {
      'date': '6/15/24',
      'title': 'Reflection: Your Pathway',
      'duration': '3 min'
    },
  ];

  late AnimationController _controller;
  late Animation<Offset> _upSlideAnimation;
  late Animation<double> _opacityAnimation;
  late Animation<Offset> _rightSlideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _opacityAnimation = Tween<double>(begin: 0, end: 1).animate(_controller);

    // Slide in from below for list items
    _upSlideAnimation = Tween<Offset>(begin: Offset(0.0, 2.0), end: Offset.zero)
        .animate(_controller);

    _rightSlideAnimation =
        Tween<Offset>(begin: Offset(-2.0, 1.0), end: Offset.zero)
            .animate(_controller);

    _controller.forward();
  }
  final FocusNode searchFocusNode = FocusNode();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();

      },
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          centerTitle: true,
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(0.2),
            child: Divider(
              color: Colors.grey,
              thickness: 0.5,
            ),
          ),
          backgroundColor: backgroundColor,
          automaticallyImplyLeading: false,
          title: SlideTransition(
            position: _upSlideAnimation,
            child: InterCustomText(
              text: 'Notifications',
              textColor: primaryColor,
            ),
          ),
        ),
        body: Column(
          children: [
            SizedBox(
              height: 20.h,
            ),
            SlideTransition(
              position: _rightSlideAnimation,
              child: Row(
                children: [
                  SizedBox(
                    width: 30.w,
                  ),
                  CustomSearch(focusNode: searchFocusNode),
                  SizedBox(
                    width: 4.w,
                  ),
                  Image.asset(
                    AppImages.FilterIcon,
                    width: 42.w,
                    height: 42.h,
                  ),
                ],
              ),
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
                      Text('Date'),
                      SizedBox(
                        width: 36.w,
                      ),
                      Text('Title'),
                    ],
                  ),
                  Divider(
                    color: containerBorder,
                  ),
                ],
              ),
            ),
            Expanded(
              child: FadeTransition(
                opacity: _opacityAnimation,
                child: ListView.builder(
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
                                text: items[index]['date']!,
                                fontsize: 12.sp,
                                textColor: primaryColor.withOpacity(0.90),
                              ),
                              SizedBox(width: 22),
                              Expanded(
                                child: InterCustomText(
                                  overflow: TextOverflow.ellipsis,
                                  text: items[index]['title']!,
                                  fontsize: 14.sp,
                                  textColor: primaryColor,
                                ),
                              ),
                              SizedBox(width: 16),
                              Container(
                                width: 48.w,
                                height: 28.h,
                                decoration: BoxDecoration(
                                  border: Border.all(color: containerBorder),
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                                child: Center(
                                    child: InterCustomText(
                                  text: items[index]['duration']!,
                                  fontsize: 12.sp,
                                  textColor: primaryColor,
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
