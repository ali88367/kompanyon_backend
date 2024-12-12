// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:kompanyon_app/const/color.dart';
// import 'package:kompanyon_app/const/image.dart';
// import 'package:kompanyon_app/view/nav_bar/nav_bar.dart';
// import 'package:kompanyon_app/widgets/custom_button.dart';
// import 'package:kompanyon_app/widgets/custom_inter_text.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:kompanyon_app/widgets/custom_textfield.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:get/get.dart';
//
//
// class Login extends StatefulWidget {
//   const Login({super.key});
//
//   @override
//   State<Login> createState() => _LoginState();
// }
//
// class _LoginState extends State<Login> with SingleTickerProviderStateMixin {
//   TextEditingController emailController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();
//
//   // Focus nodes for text fields
//   final FocusNode _emailFocusNode = FocusNode();
//   final FocusNode _passwordFocusNode = FocusNode();
//
//   late AnimationController _controller;
//   late Animation<Offset> _slideAnimation;
//   late Animation<double> _fadeAnimation;
//   late Animation<double> _scaleAnimation;
//   late final Animation<double> _logoAnimation;
//   late final Animation<double> _contentAnimation;
//
//   bool _isLogoInFinalPosition = false;
//
//   bool ishowcontent= false;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       duration: const Duration(milliseconds: 600),
//       vsync: this,
//     );
//
//     _logoAnimation = CurvedAnimation(
//       parent: _controller,
//       curve: Curves.easeInOut,
//     );
//
//     _contentAnimation = CurvedAnimation(
//       parent: _controller,
//       curve: Interval(0.5, 1.0, curve: Curves.easeInOut),
//     );
//
//     _scaleAnimation = Tween<double>(begin: 2.0, end: 1.0).animate(_controller);
//
//     Future.delayed(Duration(milliseconds: 600), () {
//       setState(() {
//         _isLogoInFinalPosition = true;
//       });
//       _controller.forward().then((value) {
//         setState(() {
//           ishowcontent = true;
//         });
//       });
//     });
//   }
//   @override
//   void dispose() {
//     _controller.dispose();
//     // Dispose focus nodes
//     _emailFocusNode.dispose();
//     _passwordFocusNode.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: backgroundColor,
//       body: GestureDetector(
//         onTap: () {
//           // Unfocus all text fields when tapping outside
//           _emailFocusNode.unfocus();
//           _passwordFocusNode.unfocus();
//         },
//         child: Stack(
//           alignment: Alignment.center,
//           children: [
//             if(ishowcontent ==false)
//               AnimatedPositioned(
//                 duration: Duration(milliseconds: 600),
//                 top: _isLogoInFinalPosition ? Get.height * .13 : (Get.height / 2) - 37,
//                 child: ScaleTransition(
//                   scale: _scaleAnimation,
//                   child:Center(
//                     child: Image.asset(AppImages.bglogo,height: 60,width: 60,)
//                   ),
//                 ),
//               ),
//             if(ishowcontent)
//             SingleChildScrollView(
//               child: Center(
//                 child: Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 47.w),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       SizedBox(
//                         height: 129.h,
//                       ),
//                       InterCustomText(
//                         text: 'Kompanyon',
//                         textColor: primaryColor,
//                         fontsize: 24.sp,
//                       ),
//                       SizedBox(
//                         height: 53.h,
//                       ),
//                       InterCustomText(
//                         text: 'Welcome Back!',
//                         textColor: primaryColor,
//                         fontsize: 18.sp,
//                       ),
//                       SizedBox(
//                         height: 3.h,
//                       ),
//                       InterCustomText(
//                         textAlign: TextAlign.center,
//                         text: 'Enter your email and password to get started',
//                         textColor: primaryColor,
//                         fontsize: 14.sp,
//                       ),
//                       SizedBox(
//                         height: 24.h,
//                       ),
//
//                       Column(
//                         children: [
//                           SizedBox(
//                             height: 24.h,
//                           ),
//                           InputField(
//                             contentPadding:
//                             EdgeInsets.symmetric(vertical: 5, horizontal: 10),
//                             hint: 'Password',
//                             keyboard: TextInputType.text,
//                             controller: passwordController,
//                             focusNode: _passwordFocusNode, // Added focusNode
//                           ),
//                           SizedBox(
//                             height: 24.h,
//                           ),
//                           CustomButton(
//                             text: 'Sign-In',
//                             onPressed: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) => NavBar()),
//                               );
//                               print('Sign-In button pressed');
//                             },
//                             width: 327,
//                             height: 52,
//                             borderRadius: 12,
//                             fontSize: 14,
//                             fontWeight: FontWeight.w500,
//                           ),
//                           SizedBox(
//                             height: 24.h,
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Container(
//                                 height: 1.h,
//                                 width: 102.w,
//                                 color: Color(0xffE6E6E6),
//                               ),
//                               SizedBox(
//                                 width: 8.w,
//                               ),
//                               InterCustomText(
//                                 textAlign: TextAlign.center,
//                                 text: 'or continue with',
//                                 textColor: Color(0xff828282),
//                                 fontsize: 14.sp,
//                               ),
//                               SizedBox(
//                                 width: 8.w,
//                               ),
//                               Container(
//                                 height: 1.h,
//                                 width: 102.w,
//                                 color: Color(0xffE6E6E6),
//                               ),
//                             ],
//                           ),
//                           SizedBox(
//                             height: 24.h,
//                           ),
//                           Container(
//                             width: 327.w,
//                             height: 40.h,
//                             decoration: BoxDecoration(
//                               color: primaryColor.withOpacity(0.3),
//                               borderRadius: BorderRadius.circular(8.r),
//                             ),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Image.asset(
//                                   AppImages.googleIcon,
//                                   height: 20.h,
//                                   width: 20.w,
//                                 ),
//                                 SizedBox(
//                                   width: 8.w,
//                                 ),
//                                 Center(
//                                   child: InterCustomText(
//                                     textAlign: TextAlign.center,
//                                     text: 'Google',
//                                     textColor: primaryColor,
//                                     fontsize: 14.sp,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           SizedBox(
//                             height: 24.h,
//                           ),
//                           RichText(
//                             textAlign: TextAlign.center,
//                             text: TextSpan(
//                               text: 'By clicking continue, you agree to our ',
//                               style: GoogleFonts.inter(
//                                 color: Color(0xff828282),
//                                 fontWeight: FontWeight.w400,
//                                 fontSize: 12.sp,
//                               ),
//                               children: [
//                                 TextSpan(
//                                   text: 'Terms of Service',
//                                   style: GoogleFonts.inter(
//                                     color: primaryColor,
//                                     fontWeight: FontWeight.w400,
//                                     fontSize: 12.sp,
//                                   ),
//                                   recognizer: TapGestureRecognizer()
//                                     ..onTap = () {
//                                       // Navigate to the Terms of Service page
//                                     },
//                                 ),
//                                 TextSpan(
//                                   text: ' and ',
//                                   style: GoogleFonts.inter(
//                                     color: Color(0xff828282),
//                                     fontWeight: FontWeight.w400,
//                                     fontSize: 12.sp,
//                                   ),
//                                 ),
//                                 TextSpan(
//                                   text: 'Privacy Policy',
//                                   style: GoogleFonts.inter(
//                                     color: primaryColor,
//                                     fontWeight: FontWeight.w400,
//                                     fontSize: 12.sp,
//                                   ),
//                                   recognizer: TapGestureRecognizer()
//                                     ..onTap = () {
//                                       // Navigate to the Privacy Policy page
//                                     },
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
