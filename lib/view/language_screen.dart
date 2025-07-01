import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/custom_next_button.dart';
import 'first_onboard.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  final flags = [
    "https://media.gettyimages.com/id/1479691052/vector/american-usa-flag-vector.jpg?s=612x612&w=0&k=20&c=LWJMKuvpr62x5I4fT3hRHc-qJr4voyVBBbTDESEwhuc=",
    "https://media.gettyimages.com/id/472317739/vector/flag-of-india.jpg?s=612x612&w=0&k=20&c=ejlQRX4C_Mb40wz1JQcB5vKYcOKlfRtry2W6UcX6mlo=",
    "https://media.gettyimages.com/id/1129861222/photo/spain.jpg?s=612x612&w=0&k=20&c=AbhnVcLHUCo1HxMk09A9ccu4s4qS1qPR-N7n_XYjXFY=",
    "https://media.gettyimages.com/id/657672390/vector/flag-of-france.jpg?s=612x612&w=0&k=20&c=VY7IIA5kGgMNL_G_Uio7BV8vuH30HUk_jYezBDrpees=",
    "https://media.gettyimages.com/id/176430982/vector/flag-of-the-brazil.jpg?s=612x612&w=0&k=20&c=dAwPAmV91dkqzDxyN35GHMwvHZvJjVykV5O-SdGlnE4=",
    "https://media.gettyimages.com/id/1947695917/photo/flag-of-south-korea.jpg?s=612x612&w=0&k=20&c=Xoje8rkhBnjMSqfjZzOPRSHuDG1ihI0KjEkrx3AYcnU=",
    "https://media.gettyimages.com/id/1443112626/photo/russian-flag-design.jpg?s=612x612&w=0&k=20&c=Aqr0QIRNg43LT9tZLMsHeX-1PzJ1CQZKfTF7j-bDJtI=",
  ];

  final flagName = const [
    "English",
    "हिंदी",
    "Español",
    "Français",
    "Portuguese",
    "한국인",
    "Русcкий",
  ];

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final padding = size.width * 0.04; // 4% horizontal padding
    final verticalSpacing = size.height * 0.02; // 2% vertical spacing
    final flagSize = size.width * 0.1; // 10% of screen width for flag icon

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(title: const Text("Select Language")),
      body: Container(
        width: size.width,
        height: size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFFF3E0), Color(0xFFFFF8E1)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: padding,
          vertical: verticalSpacing * 2,
        ),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: flags.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(
                        vertical: verticalSpacing * 0.5,
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: padding,
                        vertical: verticalSpacing * 0.8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: selectedIndex == index
                              ? Colors.orange
                              : Colors.grey.shade300,
                          width: 1.5,
                        ),
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              flags[index],
                              width: flagSize,
                              height: flagSize,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: padding),
                          Expanded(
                            child: Text(
                              flagName[index],
                              style: TextStyle(
                                fontSize: size.width * 0.045, // responsive font
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Icon(
                            selectedIndex == index
                                ? Icons.radio_button_checked
                                : Icons.radio_button_off,
                            color: Colors.orange,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: verticalSpacing * 2),
            GestureDetector(
              onTap: () => Get.to(OnboardFirst()),
              child: CustomNextButton(text: 'Next'),
            ),
            SizedBox(height: verticalSpacing * 2),
          ],
        ),
      ),
    );
  }
}
