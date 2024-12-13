import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kompanyon_app/const/color.dart';
import 'package:intl/intl.dart';

import '../../widgets/custom_inter_text.dart';
class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _upSlideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(_controller);
    _slideAnimation = Tween<Offset>(begin: const Offset(0.0, 1.0), end: Offset.zero)
        .animate(_controller);
    _controller.forward();
    _upSlideAnimation =
        Tween<Offset>(begin: const Offset(0.0, 1.0), end: Offset.zero)
            .animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        // centerTitle: true,
        backgroundColor:  backgroundColor, // Apply theme color
        automaticallyImplyLeading: false,
        title: SlideTransition(
            position: _upSlideAnimation,
            child: InterCustomText(
              fontWeight: FontWeight.w600,
              fontsize: 26,
              text: 'Notifications',
              textColor:  primaryColor, // Apply theme color
            )),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Divider(
            color: greyColor,
            thickness: 0.2,
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('notifications').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text('Error fetching notifications.'));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No notifications available.'));
          }

          final notifications = snapshot.data!.docs;

          return ListView.builder(
            itemCount: notifications.length,
            padding: const EdgeInsets.all(16.0),
            itemBuilder: (context, index) {
              final data = notifications[index].data() as Map<String, dynamic>;
              final title = data['title'] ?? 'No Title';
              final message = data['message'] ?? 'No Message';
              final date = data['timestamp'] != null
                  ? DateFormat('dd-MM-yyyy').format(data['timestamp'].toDate())
                  : 'No Date';

              return SlideTransition(
                position: _slideAnimation,
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: Card(
                    margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0), // Rounded corners
                    ),
                    elevation: 4.0, // Subtle shadow effect
                    color: Colors.white, // Card background color
                    child: Padding(
                      padding: const EdgeInsets.all(16.0), // Padding inside the card
                      child: ListTile(
                        contentPadding: EdgeInsets.zero, // Remove extra padding inside ListTile
                        title: Text(
                          title,
                          style: TextStyle(
                            color: primaryColor,
                            fontWeight: FontWeight.bold, // Bold title for emphasis
                            fontSize: 16.0, // Slightly larger font size for the title
                          ),
                        ),
                        subtitle: Text(
                          message,
                          style: TextStyle(
                            color: Colors.black87, // Darker text for the message
                            fontSize: 14.0, // Slightly smaller font size for the message
                          ),
                        ),
                        trailing: Text(
                          date,
                          style: TextStyle(
                            fontSize: 12.0,
                            color: Colors.grey[600], // Slightly darker grey for the date
                          ),
                        ),
                      ),
                    ),
                  )

                ),
              );
            },
          );
        },
      ),
    );
  }
}
