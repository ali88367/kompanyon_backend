import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class BottomBarController extends GetxController {
  late PersistentTabController controller;

  // SearchUsersViewModel searchUserViewModel =  Get.put(SearchUsersViewModel());
  RxInt navbarIndex = 0.obs;

  navigateTo(int index) {
    controller.jumpToTab(index);
  }

  @override
  void onInit() {
    super.onInit();
    controller = PersistentTabController(initialIndex: 0);
  }
}
