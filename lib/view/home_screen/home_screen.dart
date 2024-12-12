import 'dart:async';
import 'package:flutter/material.dart';
import 'package:kompanyon_app/User%20Pathway/uploadAssessment.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:kompanyon_app/clickable_wheel.dart';
import 'package:kompanyon_app/const/color.dart';
import 'package:kompanyon_app/widgets/custom_inter_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _scaleAnimation;
  SharedPreferences? _prefs;
  int _currentIndex = 0;

  final List<String> _affirmations = [
    "You are cultivating mindfulness in your workplace",
    "Your team's well-being is improving every day",
    "You are fostering a culture of resilience and collaboration",
    "Your productivity is enhanced through mindfulness practices",
    "You are creating a positive work environment",
    "Your emotional intelligence is growing stronger",
    "You are reducing stress and increasing focus",
    "Your team dynamics are improving through self-awareness",
    "You are embracing neuroplasticity for personal growth",
    "Your workplace is becoming more harmonious and efficient",
    "You are balancing work and well-being effectively",
    "Your company culture is thriving with mindfulness",
    "You are contributing to a healthier work ecosystem",
    "Your leadership skills are evolving through mindfulness",
    "You are fostering better communication within your team",
    "Your workplace is transforming positively day by day",
    "You are embracing change with a calm and focused mind",
    "Your decision-making is improving through mindfulness practices",
    "You are part of a supportive and mindful work community",
    "Your team's potential is unlocking through collective well-being"
  ];

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: const Offset(0, 0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));
    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut,
    ));
    _controller.forward();

    _loadAffirmationIndex();
  }

  Future<void> _loadAffirmationIndex() async {
    await uploadAssessments();

    _prefs = await SharedPreferences.getInstance();
    _currentIndex = _prefs?.getInt('currentIndex') ?? 0;

    // Load the last saved date
    String? lastShownDate = _prefs?.getString('lastShownDate');
    String todayDate = DateTime.now().toString().split(' ')[0];

    // If it's a new day, increment the index
    if (lastShownDate == null || lastShownDate != todayDate) {
      _incrementAffirmationIndex();
      _prefs?.setString('lastShownDate', todayDate);
    }

    // If all affirmations have been shown, reset the index
    if (_currentIndex >= _affirmations.length) {
      _currentIndex = 0;
      _prefs?.setInt('currentIndex', 0);
    }

    setState(() {});
  }

  void _incrementAffirmationIndex() {
    setState(() {
      _currentIndex = (_currentIndex + 1) % _affirmations.length;
      _prefs?.setInt('currentIndex', _currentIndex);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final homeScreenTitles = [
      'Hear',
      'Learn',
      'Your Pathway',
      'Read',
      'Connect',
      'Help',
    ];
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Column(
        children: [
          SizedBox(height: 86.h),
          FadeTransition(
            opacity: _fadeAnimation,
            child: SlideTransition(
              position: _slideAnimation,
              child: Padding(
                padding: EdgeInsets.only(left: 73.w, right: 86.w),
                child: InterCustomText(
                  textAlign: TextAlign.center,
                  text: _affirmations[_currentIndex], // Display the current affirmation
                  textColor: primaryColor,
                  fontsize: 24.sp,
                ),
              ),
            ),
          ),
          SizedBox(height: 80.h),
          Expanded(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: ClickableWheel(
                  titles: homeScreenTitles,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
