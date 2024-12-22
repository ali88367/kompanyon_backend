import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:kompanyon_app/widgets/custom_search.dart';
import 'package:path_provider/path_provider.dart';
import 'package:get/get.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kompanyon_app/const/color.dart';
import 'package:kompanyon_app/const/image.dart';
import 'package:kompanyon_app/widgets/custom_inter_text.dart';
import 'package:audioplayers/audioplayers.dart';

import '../../../audio_controller.dart';

class HearScreen extends StatefulWidget {
  const HearScreen({super.key});

  @override
  State<HearScreen> createState() => _HearScreenState();
}

class _HearScreenState extends State<HearScreen>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  final AudioPlayer audioPlayer = AudioPlayer();
  late AnimationController _controller;
  late Animation<Offset> _upSlideAnimation;
  late Animation<double> _opacityAnimation;
  late Animation<Offset> _rightSlideAnimation;
  String? playingUrl; // URL of the currently playing audio
  final FocusNode searchFocusNode = FocusNode();
  final AudioController audioController = Get.put(AudioController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _opacityAnimation = Tween<double>(begin: 0, end: 1).animate(_controller);
    _upSlideAnimation = Tween<Offset>(begin: Offset(0.0, 2.0), end: Offset.zero)
        .animate(_controller);
    _rightSlideAnimation =
        Tween<Offset>(begin: Offset(-2.0, 1.0), end: Offset.zero)
            .animate(_controller);
    _controller.forward();
  }

  Future<void> uploadAudioFilesToFirebase() async {
    final List<Map<String, String>> items = [
      {
        'Category': 'Leadership',
        'title': 'Setting Clear Intentions',
        'duration': '2 min',
        'file': 'kompanyon-audio.mp3',
      },
      {
        'Category': 'Leadership',
        'title': 'Visualization for Deep Work',
        'duration': '4 min',
        'file': 'CONFLICT AVOIDANCE MASTER.mp3',
      },
      {
        'Category': 'Leadership',
        'title': 'LISTENING WITH EMPATHY MASTER',
        'duration': '4 min',
        'file': 'LISTENING WITH EMPATHY MASTER.mp3',
      },
      {
        'Category': 'Leadership',
        'title': 'TEAM COLLABORATION MEDITATION MASTER',
        'duration': '3 min',
        'file': 'TEAM COLLABORATION MEDITATION MASTER.mp3',
      },
    ];

    try {
      for (var item in items) {
        String assetFileName = item['file']!;
        print("Uploading: $assetFileName");

        // Load file from assets
        final byteData = await rootBundle.load('assets/$assetFileName');
        print("Loaded file: $assetFileName");

        // Save file temporarily
        final tempDir = await getTemporaryDirectory();
        final tempFile = File('${tempDir.path}/$assetFileName');
        await tempFile.writeAsBytes(byteData.buffer.asUint8List());
        print("Saved file to temporary directory: ${tempFile.path}");

        // Upload to Firebase Storage
        final storageRef = FirebaseStorage.instance.ref('audio/$assetFileName');
        await storageRef.putFile(tempFile);
        final downloadUrl = await storageRef.getDownloadURL();
        print("Uploaded to Firebase Storage: $downloadUrl");

        // Save metadata in Firestore
        await FirebaseFirestore.instance.collection('audio_files').add({
          'Category': item['Category'],
          'title': item['title'],
          'duration': item['duration'],
          'url': downloadUrl,
        });
        print("Metadata saved to Firestore for: ${item['title']}");
      }
    } catch (e) {
      print("Error uploading audio files: $e");
    }
  }

  Future<void> playAudio(String url) async {
    try {
      if (playingUrl == url) {
        await audioPlayer.pause();
        setState(() {
          playingUrl = null;
        });
      } else {
        await audioPlayer.play(UrlSource(url));
        setState(() {
          playingUrl = url;
        });
      }
    } catch (e) {
      print("An error occurred while playing audio: $e");
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.paused || state == AppLifecycleState.inactive) {
      // Stop the audio when the app is not active
      audioController.stopAudio();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    audioController.onClose(); // Ensure the audio stops
    Get.delete<AudioController>();
    audioPlayer.dispose();
    _controller.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: backgroundColor,
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              SlideTransition(
                position: _upSlideAnimation,
                child: const InterCustomText(
                  text: 'Hear',
                  textColor: primaryColor,
                ),
              ),

            ],
          ),
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(1.0),
            child: Divider(
              color: greyColor,
              thickness: 0.2,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 20.h,
              ),
              // ElevatedButton(
              //   onPressed: () async {
              //     await uploadAudioFilesToFirebase();
              //   },
              //   child: const Text("Upload Audio Files"),
              // ),
              SlideTransition(
                position: _rightSlideAnimation,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 16.w,
                    ),
                    CustomSearch(focusNode: searchFocusNode),
                  ],
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 37.w),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text('Category'),
                        SizedBox(
                          width: 20.w,
                        ),
                        Text('Title'),
                        Spacer(),
                        Text('Length'),
                        SizedBox(
                          width: 46.w,
                        ),
                      ],
                    ),
                    Divider(
                      color: containerBorder,
                    )
                  ],
                ),
              ),
              FadeTransition(
                opacity: _opacityAnimation,
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('audio_files')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return const Center(
                        child: Text("No audio files found"),
                      );
                    }

                    final audioFiles = snapshot.data!.docs;

                    return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: audioFiles.length,
                      itemBuilder: (context, index) {
                        final data =
                            audioFiles[index].data() as Map<String, dynamic>;
                        final title = data['title'] ?? 'Untitled';
                        final duration = data['duration'] ?? 'Unknown';
                        final category = data['Category'] ?? 'Uncategorized';
                        final url = data['url'] ?? '';

                        final isPlaying = playingUrl == url;

                        return Padding(
                          padding: EdgeInsets.only(left: 37.w, top: 5.h),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InterCustomText(
                                    overflow: TextOverflow.ellipsis,
                                    text: category,
                                    fontsize: 12.sp,
                                    textColor: blackColor.withOpacity(0.90),
                                  ),
                                  SizedBox(width: 22),
                                  Expanded(
                                    child: InterCustomText(
                                      overflow: TextOverflow.ellipsis,
                                      text: title,
                                      fontsize: 14.sp,
                                      textColor: blackColor,
                                    ),
                                  ),
                                  SizedBox(width: 16),
                                  Container(
                                    width: 48.w,
                                    height: 28.h,
                                    decoration: BoxDecoration(
                                      border:
                                          Border.all(color: containerBorder),
                                      borderRadius: BorderRadius.circular(8.r),
                                    ),
                                    child: Center(
                                      child: InterCustomText(
                                        text: duration,
                                        fontsize: 12.sp,
                                        textColor: blackColor,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 12.w),
                                  GestureDetector(
                                    onTap: () {
                                      audioController.playPauseAudio(url);
                                    },
                                    child: Obx(() {
                                      final isPlaying =
                                          audioController.playingUrl.value ==
                                              url;
                                      return Icon(isPlaying
                                          ? Icons.pause
                                          : Icons.play_arrow);
                                    }),
                                  ),
                                  SizedBox(width: 12.w),
                                ],
                              ),
                              if (index != audioFiles.length - 1)
                                Divider(
                                  color: containerBorder,
                                )
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
