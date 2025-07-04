import 'package:aarati_app/view/second_onboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardFirst extends StatelessWidget {
  const OnboardFirst({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow.shade100,
      body: Center(
        child: GestureDetector(
          onTap: () => Get.to(OnboardSecond()),
          child: Image.asset(
            'assets/onboard1.png',
            fit: BoxFit.fill,
            width: double.infinity,
            height: double.infinity,
          ),
        ),
      ),
    );
  }
}
