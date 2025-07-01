import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'view/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: CupertinoColors.white,
        appBarTheme: AppBarTheme(
          centerTitle: true,
          backgroundColor: CupertinoColors.transparent,
        ),
      ),
      title: 'Aarti App',
      home: const SplashScreen(),
    );
  }
}
