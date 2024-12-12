import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kompanyon_app/const/color.dart';
import 'package:kompanyon_app/const/image.dart';

import 'package:kompanyon_app/widgets/custom_inter_text.dart';

import 'article_screen.dart';

class ReadScreen extends StatefulWidget {
  const ReadScreen({super.key});

  @override
  State<ReadScreen> createState() => _ReadScreenState();
}

class _ReadScreenState extends State<ReadScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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
            text: 'Articles',
            fontsize: 30,
            textColor: blackColor,
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: StreamBuilder<QuerySnapshot>(
                  stream: _firestore
                      .collection('articles')
                      .orderBy('timestamp', descending: true)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return const Text('Error fetching articles');
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    final articles = snapshot.data!.docs;
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: articles.length,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final articleData =
                        articles[index].data() as Map<String, dynamic>;
                        return GestureDetector(
                          onTap: () {

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ArticleDetails(articleData: articleData,
                                  //  articleData: articleData,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            margin: EdgeInsets.only(bottom: 20.h),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16.r),
                              color: whiteColor,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (articleData['imageUrl'] != null)
                                  ClipRRect(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(16.r),
                                      topRight: Radius.circular(16.r),
                                    ),
                                    child: Image.network(
                                      articleData['imageUrl'],
                                      height: 200.h,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                Padding(
                                  padding:
                                  const EdgeInsets.all(16.0).r,
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      InterCustomText(
                                        text: articleData['title'],
                                        textColor: blackColor,

                                        fontWeight: FontWeight.bold,
                                      ),
                                      SizedBox(height: 8.h),
                                      InterCustomText(
                                        text: articleData['headline'],
                                        textColor: blackColor,

                                        fontWeight: FontWeight.w500,
                                      ),
                                      SizedBox(height: 8.h),
                                      // Show the first 3 lines of the content
                                      InterCustomText(
                                        text: articleData['content'],
                                        textColor: blackColor,

                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
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
            ],
          ),
        ));
  }
}