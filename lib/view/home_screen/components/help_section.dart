import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kompanyon_app/const/color.dart';

import '../../../widgets/custom_inter_text.dart';

class HelpSection extends StatelessWidget {
  const HelpSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back,
              color: primaryColor,
              size: 35,
            )),
        centerTitle: true,
        toolbarHeight: 80.h,
        backgroundColor: backgroundColor,
        automaticallyImplyLeading: false,
        title: InterCustomText(
          text: 'FAQs',
          fontsize: 30,
          textColor: blackColor,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('help_section')  // Firestore collection name
              .orderBy('created_at', descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            // Show loader while data is loading
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            // Show error message if something went wrong
            if (snapshot.hasError) {
              return const Center(child: Text('Something went wrong'));
            }

            // No data available message
            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Center(child: Text('No FAQs available.'));
            }

            // Get the fetched data
            final faqs = snapshot.data!.docs;

            return ListView.builder(
              itemCount: faqs.length,
              itemBuilder: (context, index) {
                final faq = faqs[index];

                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 6.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0), // Rounded corners
                  ),
                  elevation: 4.0, // Subtle shadow effect
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InterCustomText(
                        text:   faq['question'],
                        fontsize: 18,
                          fontWeight: FontWeight.w600, textColor: primaryColor,
                        ),
                        const SizedBox(height: 10),
                        InterCustomText(
                           text:  faq['answer'],
                    fontsize: 14,

                    fontWeight: FontWeight.w500, textColor: Colors.black,
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
