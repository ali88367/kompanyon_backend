import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kompanyon_app/Spalsh%20Screen/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:kompanyon_app/theme.dart';
import 'package:kompanyon_app/view/nav_bar/nav_bar.dart';
import 'User Pathway/uploadAssessment.dart';
import 'firebase_options.dart';
import 'helper/bindings.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ThemeManager.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // await uploadAssessments();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(430, 932),
        builder: (_, child) {
          return GetMaterialApp(
            theme: ThemeManager.currentTheme,
            debugShowCheckedModeBanner: false,
            home: SplashScreen(),
            initialBinding: UserBinding(),
          );
        });
  }
}
