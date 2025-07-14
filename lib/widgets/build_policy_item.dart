import 'package:flutter/material.dart';

Widget buildPolicyItem(Size screenSize, String imagePath, String text) {
  return Padding(
    padding: EdgeInsets.only(bottom: screenSize.height * 0.025),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: Image.asset(
            imagePath,
            width: screenSize.width * 0.06,
            height: screenSize.width * 0.06,
            fit: BoxFit.contain,
          ),
        ),
        SizedBox(width: screenSize.width * 0.03),
        Expanded(
          flex: 9,
          child: Text(
            text,
            style: TextStyle(
              fontSize: screenSize.width * 0.038,
              color: Colors.black87,
            ),
          ),
        ),
      ],
    ),
  );
}
