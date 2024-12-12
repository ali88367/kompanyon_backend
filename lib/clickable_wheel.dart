import 'package:flutter/material.dart';
import 'package:kompanyon_app/User%20Pathway/text_only.dart';
import 'package:kompanyon_app/User%20Pathway/user_pathway1.dart';
import 'package:kompanyon_app/User%20Pathway/user_pathwayBegin.dart'; // Import UserPathway1
import 'package:kompanyon_app/const/color.dart';
import 'package:kompanyon_app/view/Leadership_screens/Leadership.dart';
import 'package:kompanyon_app/view/home_screen/components/hear_screen.dart';
import 'package:kompanyon_app/view/home_screen/components/read_screen.dart';
import 'package:kompanyon_app/view/home_screen/home_screen.dart';
import 'package:kompanyon_app/view/nav_bar/nav_bar.dart';
import 'package:kompanyon_app/widgets/custom_inter_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ClickableWheel extends StatefulWidget {
  static const double _itemHeight = 45;

  final List<String> titles;

  ClickableWheel({required this.titles});

  @override
  State<ClickableWheel> createState() => _ClickableWheelState();
}

class _ClickableWheelState extends State<ClickableWheel> {
  final _scrollController = FixedExtentScrollController(initialItem: 2); // Start at index 2
  int _selectedIndex = 2; // Default selected index to 2

  // Map titles to screen widgets
  final Map<String, Widget> _screenMap = {
    'Hear': HearScreen(),
    'Learn': Leadership(),
    'Your Pathway': UserPathwayBegin(),
    'Read':ReadScreen(),
    // 'Stress Relief': UserPathway2(),
    // 'Other (please specify)': InputMessage1(),
    // 'Never': Slider3(),
    // "Don't know how to start": UserPathway5(),
    // 'Guided meditation': UserPathway6(),
    // 'Reading': UserPathway7(),
    // 'Short Daily Practices': InputMessage2(),
    // 'Yes': TextOnly(),
    'Focus & Productivity': BottomBar(),
  };

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      final newIndex = _scrollController.selectedItem!;
      if (newIndex != _selectedIndex) {
        setState(() {
          _selectedIndex = newIndex;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 300,
            child: ListWheelScrollView.useDelegate(
              controller: _scrollController,
              itemExtent: ClickableWheel._itemHeight,
              physics: FixedExtentScrollPhysics(),
              perspective: 0.0009,
              onSelectedItemChanged: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              childDelegate: ListWheelChildBuilderDelegate(
                builder: (context, index) => _child(index),
                childCount: widget.titles.length,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _child(int index) {
    final isSelected = index == _selectedIndex;
    final opacity = isSelected ? 0.9 : 0.3;

    return Opacity(
      opacity: opacity,
      child: SizedBox(
        height: ClickableWheel._itemHeight,
        child: Center(
          child: InkWell(
            onTap: () {
              final title = widget.titles[index];
              final screen = _screenMap[title];

              if (screen != null) {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                    screen, // Your target screen
                    transitionsBuilder: (context, animation, secondaryAnimation, child) {
                      // Use your desired transition (slide and fade)
                      return FadeTransition(
                        opacity: animation.drive(Tween(begin: 0.0, end: 1.0)),
                        child: SlideTransition(
                          position: animation.drive(
                              Tween<Offset>(begin: const Offset(-1.0, 0.0), end: const Offset(0.0, 0.0))),
                          child: child,
                        ),
                      );
                    },
                  ),
                );
              }
              setState(() {
                _selectedIndex = index;
              });
            },
            child: Padding(
              padding:  EdgeInsets.symmetric(horizontal: 60.w),
              child: Align(
                alignment: Alignment.centerLeft,
                child: InterCustomText(

                  text: widget.titles[index % widget.titles.length],
                  textColor: primaryColor,
                  fontsize: 28.sp,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
