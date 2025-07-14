import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Terms Of Use/terms_of_use_screen.dart';

class OnboardThird extends StatelessWidget {
  const OnboardThird({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow.shade100,
      body: Center(
        child: GestureDetector(
          onTap: () => Get.to(() => TermsOfUseScreen()),
          child: Image.asset(
            'assets/onboard3.png',
            fit: BoxFit.fill,
            width: double.infinity,
            height: double.infinity,
          ),
        ),
      ),
    );
  }
}
