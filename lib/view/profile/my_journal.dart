import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kompanyon_app/const/color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kompanyon_app/widgets/custom_inter_text.dart';

class ReflectionResponsesPage extends StatelessWidget {
  const ReflectionResponsesPage({Key? key}) : super(key: key);

  Stream<QuerySnapshot> _fetchReflections() {
    return FirebaseFirestore.instance
        .collection('reflections')
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: InterCustomText(
          text: 'Reflection Responses',
          textColor: primaryColor,
          fontsize: 24.sp,
        ),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _fetchReflections(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(
              child: InterCustomText(
                text: 'No responses found',
                textColor: primaryColor,
                fontsize: 20.sp,
              ),
            );
          }

          return ListView.builder(
            padding: EdgeInsets.all(16.0),
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              final data = snapshot.data!.docs[index];
              final mood = data['mood'] ?? 'N/A';
              final feeling = data['feeling'] ?? 'N/A';
              final gratitude = data['gratitude'] ?? 'N/A';
              final meditation = data['meditation'] ?? 'N/A';
              final timestamp = (data['timestamp'] as Timestamp?)?.toDate();

              return Card(
                margin: EdgeInsets.symmetric(vertical: 8.h),
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  side: BorderSide(color: primaryColor, width: 1),
                ),
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InterCustomText(
                        text: 'Mood: $mood',
                        textColor: primaryColor,
                        fontsize: 18.sp,
                      ),
                      SizedBox(height: 8.h),
                      InterCustomText(
                        text: 'Feeling: $feeling',
                        textColor: primaryColor,
                        fontsize: 18.sp,
                      ),
                      SizedBox(height: 8.h),
                      InterCustomText(
                        text: 'Gratitude: $gratitude',
                        textColor: primaryColor,
                        fontsize: 18.sp,
                      ),
                      SizedBox(height: 8.h),
                      InterCustomText(
                        text: 'Meditation Preference: $meditation',
                        textColor: primaryColor,
                        fontsize: 18.sp,
                      ),
                      if (timestamp != null) ...[
                        SizedBox(height: 8.h),
                        Text(
                          'Date: ${timestamp.toLocal()}',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 16.sp,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
