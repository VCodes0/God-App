import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShareScreen extends StatelessWidget {
  const ShareScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bgImgUrl =
        'https://images.unsplash.com/photo-1470770841072-f978cf4d019e';
    final mq = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.network(
              bgImgUrl,
              fit: BoxFit.cover,
              color: Colors.black.withValues(alpha: 0.5),
              colorBlendMode: BlendMode.darken,
            ),
          ),

          // Content
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: mq.width * 0.08),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.lock_outline_rounded,
                    color: Colors.white,
                    size: mq.width * 0.2,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'This functionality can’t be provided by us.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: mq.width * 0.05,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Coming Soon!',
                    style: TextStyle(
                      fontSize: mq.width * 0.045,
                      color: Colors.orangeAccent,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Close button
          Positioned(
            left: mq.width * 0.44,
            bottom: mq.height * 0.2,
            child: IconButton(
              icon: CircleAvatar(
                child: const Icon(Icons.close, color: Colors.black, size: 30),
              ),
              onPressed: () => Get.back(),
            ),
          ),
        ],
      ),
    );
  }
}
