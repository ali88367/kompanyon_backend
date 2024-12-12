import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kompanyon_app/const/color.dart';
import 'package:kompanyon_app/const/image.dart';
import 'package:kompanyon_app/widgets/custom_inter_text.dart';
import 'package:kompanyon_app/widgets/custom_search.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _upSlideAnimation;
  late Animation<Offset> _rightSlideAnimation;
  late Animation<Offset> _slideAnimation;

  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _rightSlideAnimation =
        Tween<Offset>(begin: Offset(-2.0, 1.0), end: Offset.zero)
            .animate(_controller);
    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );
    _upSlideAnimation = Tween<Offset>(begin: Offset(0.0, 2.0), end: Offset.zero)
        .animate(_controller);
    _slideAnimation = Tween<Offset>(
      begin: Offset(0, 0.2),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutExpo,
    ));

    _controller.forward(); // Start the animation
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  final List<Map<String, String>> items = [
    {
      'Category': 'Leadership',
      'title': 'Setting Clear Intentions',
      'duration': '2 min'
    },
    {
      'Category': 'Leadership',
      'title': 'Visualization for Deep Work',
      'duration': '4 min'
    },
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

  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();

      },
      child: Scaffold(
          backgroundColor: backgroundColor,
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: backgroundColor,
            automaticallyImplyLeading: false,
            title: SlideTransition(
                position: _upSlideAnimation,
                child: const InterCustomText(
                  text: 'Search',
                  textColor: primaryColor,
                )),
            bottom: const PreferredSize(
              preferredSize: Size.fromHeight(1.0),
              child: Divider(
                color: greyColor,
                thickness: 0.2,
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 20.h,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 30.w,
                    ),
                    SlideTransition(
                      position: _rightSlideAnimation,
                      child: CustomSearch(focusNode: searchFocusNode),
                    ),
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
                            width: 30.w,
                          ),
                        ],
                      ),
                      Divider(
                        color: containerBorder,
                      )
                    ],
                  ),
                ),
                FadeTransition(
                  opacity: _fadeAnimation,

                  child: ListView.builder(
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
                                  text: items[index]['Category'] ?? "",
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
                ),
              ],
            ),
          )
      ),
    );
  }
}
