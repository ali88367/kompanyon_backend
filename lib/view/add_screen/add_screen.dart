import 'package:flutter/material.dart';
import 'package:kompanyon_app/const/color.dart';
import 'package:kompanyon_app/widgets/custom_inter_text.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _upSlideAnimation;
  late Animation<double> _opacityAnimation;
  late Animation<Offset> _rightSlideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _opacityAnimation = Tween<double>(begin: 0, end: 1).animate(_controller);

    // Slide in from below for list items
    _upSlideAnimation = Tween<Offset>(begin: Offset(0.0, 2.0), end: Offset.zero)
        .animate(_controller);

    _rightSlideAnimation =
        Tween<Offset>(begin: Offset(-2.0, 1.0), end: Offset.zero)
            .animate(_controller);

    _controller.forward();
  }

  final FocusNode searchFocusNode = FocusNode();

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
        centerTitle: true,
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(0.2),
          child: Divider(
            color: Colors.grey,
            thickness: 0.5,
          ),
        ),
        backgroundColor: backgroundColor,
        automaticallyImplyLeading: false,
        title: SlideTransition(
          position: _upSlideAnimation,
          child: InterCustomText(
            text: 'Add Screen',
            textColor: primaryColor,
          ),
        ),
      ),
      body: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Center(child: Text('Add Screen'))],
      ),
    );
  }
}
