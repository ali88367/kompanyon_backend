import 'package:get/get.dart';
import 'package:kompanyon_app/controller/login_controller.dart';
import 'package:kompanyon_app/controller/signup_contoller.dart';
import 'package:kompanyon_app/controller/user_controller.dart';

class UserBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(LoginController());
    Get.put(SignupController());
    Get.put(UserController());


  }
}
