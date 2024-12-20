import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kompanyon_app/const/color.dart';
import 'package:kompanyon_app/widgets/custom_button.dart';
import '../../../widgets/custom_inter_text.dart';

class ChallengePage extends StatelessWidget {
  const ChallengePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize the controller using Get.put to make it available throughout the widget tree
    final ChallengeController controller = Get.put(ChallengeController());

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
          text: 'Challenges',
          fontsize: 30,
          textColor: blackColor,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('Challenges_section')
              .orderBy('created_at', descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return const Center(child: Text('Something went wrong'));
            }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Center(child: Text('No challenges available.'));
            }

            final challenges = snapshot.data!.docs;

            return ListView.builder(
              itemCount: challenges.length,
              itemBuilder: (context, index) {
                final challenge = challenges[index];
                final challengeId = challenge.id;  // Get the document ID

                // Bind the challenge completion status to a reactive state in the controller
                controller.updateChallengeCompletion(challengeId, challenge['completed']);

                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(color: primaryColor.withOpacity(0.2), width: 1),
                  ),
                  elevation: 5, // Add shadow to make the card stand out
                  child: Padding(
                    padding: const EdgeInsets.all(20), // Increased padding for a spacious feel
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title with enhanced styling
                        InterCustomText(
                          text: challenge['title'],
                          fontWeight: FontWeight.w600,
                          fontsize: 22.sp,
                          textColor: primaryColor,
                        ),
                        const SizedBox(height: 12),

                        // Description with better font styling
                        Text(
                          challenge['description'],
                          style: TextStyle(
                            fontSize: 16.sp,  // Adjusted font size for better readability
                            fontWeight: FontWeight.w400,
                            color: Colors.black.withOpacity(0.7), // Softer text color
                            height: 1.5,  // Line height for better spacing
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Display completion status and button
                        Obx(() {
                          return controller.isChallengeCompleted[challengeId] == true
                              ? Container(
                            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                            decoration: BoxDecoration(
                              color: Colors.green.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              'You have completed today\'s challenge!',
                              style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                                fontSize: 16.sp,
                              ),
                            ),
                          )
                              : CustomButton(
                            height: 40.h,
                            width: 180.w,
                            text: 'Mark as Complete',
                            onPressed: () => controller.markChallengeComplete(challengeId),
                          );
                        })
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


class ChallengeController extends GetxController {
  // Store challenge completion statuses for each challenge ID
  RxMap<String, bool> isChallengeCompleted = <String, bool>{}.obs;

  // Get the current user ID
  String get userId => FirebaseAuth.instance.currentUser?.uid ?? '';

  // Update the challenge completion status locally and save it to Firestore
  Future<void> updateChallengeCompletion(String challengeId, bool isCompleted) async {
    if (userId.isEmpty) return;

    isChallengeCompleted[challengeId] = isCompleted;

    try {
      // Create or update the document in 'challenges_completed' collection
      await FirebaseFirestore.instance.collection('challenges_completed').doc(userId).set(
        {
          challengeId: isCompleted,
        },
        SetOptions(merge: true),  // Merge to update without overwriting existing data
      );
    } catch (e) {
      print("Error updating Firestore: $e");
    }
  }

  // Mark challenge as complete and update Firestore
  Future<void> markChallengeComplete(String challengeId) async {
    if (userId.isEmpty) return;

    // Update the reactive state to reflect the completion
    isChallengeCompleted[challengeId] = true;

    try {
      // Save the completion status in Firestore under the 'challenges_completed' collection
      await FirebaseFirestore.instance.collection('challenges_completed').doc(userId).set(
        {
          challengeId: true,
        },
        SetOptions(merge: true),  // Merge to avoid overwriting other data
      );
    } catch (e) {
      print("Error marking challenge as complete in Firestore: $e");
    }
  }

  // Load completion status for each challenge from Firestore
  Future<void> loadCompletionStatus() async {
    if (userId.isEmpty) return;

    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection('challenges_completed').doc(userId).get();

      if (snapshot.exists) {
        // Load all challenge completion statuses
        Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
        isChallengeCompleted.value = Map.from(data);
      }
    } catch (e) {
      print("Error loading completion status from Firestore: $e");
    }
  }
}