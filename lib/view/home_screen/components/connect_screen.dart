import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../const/color.dart';
import '../../../widgets/custom_inter_text.dart';

class ConnectScreen extends StatelessWidget {
  const ConnectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(

        centerTitle: true,
        toolbarHeight: 80.h,
        backgroundColor: backgroundColor,
        automaticallyImplyLeading: false,
        title: InterCustomText(
          text: 'Connect',
          fontsize: 30,
          textColor: blackColor,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // You can use an image or icon for the "Coming Soon" feature
              Icon(
                Icons.access_time,
                size: 100,
                color: Colors.grey,
              ),
              const SizedBox(height: 20),
              const InterCustomText(
            text:     'This Feature is Coming Soon!',
                fontsize: 20,
                fontWeight: FontWeight.w600,textColor:primaryColor,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              const InterCustomText(
              text:   'We are working hard to bring this feature to you. Stay tuned!',
               fontsize: 18,
                fontWeight: FontWeight.w500,textColor: Colors.black,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),

            ],
          ),
        ),
      ),
    );
  }
}
