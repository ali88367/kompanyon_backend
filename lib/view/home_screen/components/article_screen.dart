import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../const/color.dart';

class ArticleDetails extends StatefulWidget {
  final Map<String, dynamic> articleData;

  const ArticleDetails({required this.articleData, super.key});

  @override
  State<ArticleDetails> createState() => _ArticleDetailsState();
}

class _ArticleDetailsState extends State<ArticleDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: Text(widget.articleData['title']),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Show the image if available
              if (widget.articleData['imageUrl'] != null)
                Image.network(widget.articleData['imageUrl']),
              SizedBox(height: 16.h),
              // Show the headline
              Text(
                widget.articleData['headline'],
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16.h),
              // Show the full article content
              Text(widget.articleData['content']),
            ],
          ),
        ),
      ),
    );
  }
}