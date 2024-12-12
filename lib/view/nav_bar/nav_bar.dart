import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kompanyon_app/const/color.dart';
import 'package:kompanyon_app/controller/bottom_bar_controller.dart';
import 'package:kompanyon_app/view/add_screen/add_screen.dart';
import 'package:kompanyon_app/view/home_screen/home_screen.dart';
import 'package:kompanyon_app/view/notification_screen/notification.dart';
import 'package:kompanyon_app/view/profile/profile.dart';
import 'package:kompanyon_app/view/search_screen/search_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

import '../../const/image.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  late List<Color> _iconColors = [];
  BottomBarController bottomVM = Get.put(BottomBarController());

  @override
  void initState() {
    super.initState();
    _iconColors = List<Color>.generate(4, (index) => Colors.grey);
  }

  List<Widget> _buildScreens() {
    return [
      HomeScreen(),
      SearchScreen(),
      AddScreen(),
      NotificationScreen(),
      Profile(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        onPressed: (context) {
          bottomVM.controller.jumpToTab(0);
        },
        // title: "Home",
        icon: Icon(Icons.home_rounded),
        activeColorPrimary: primaryColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        onPressed: (context) async {
          bottomVM.controller.jumpToTab(1);
        },
        // title: "Search",
        icon: Icon(CupertinoIcons.search),
        activeColorPrimary: primaryColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.add_circle),
        // title: "Go Live",
        activeColorPrimary: primaryColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.notifications),
        // title: "Alerts",
        activeColorPrimary: primaryColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        onPressed: (c) {
          bottomVM.controller.jumpToTab(4);
        },
        // title: "Notifications",
        icon: Icon(Icons.person),
        activeColorPrimary: primaryColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: bottomVM.controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      backgroundColor: backgroundColor,
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      // hideNavigationBarWhenKeyboardShows: true,
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: backgroundColor,
      ),
      // popAllScreensOnTapOfSelectedTab: true,
      // popActionScreens: PopActionScreensType.all,
      // itemAnimationProperties: ItemAnimationProperties(
      //   duration: Duration(milliseconds: 200),
      //   curve: Curves.ease,
      // ),
      // screenTransitionAnimation: ScreenTransitionAnimation(
      //   animateTabTransition: true,
      //   curve: Curves.ease,
      //   duration: Duration(milliseconds: 200),
      // ),
      navBarHeight: 70,
      navBarStyle: NavBarStyle.style6,
    );
  }
}

class PlaceholderWidget extends StatelessWidget {
  final Color color;
  final String text;

  const PlaceholderWidget(this.color, this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      child: Center(
        child: Text(
          text,
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
