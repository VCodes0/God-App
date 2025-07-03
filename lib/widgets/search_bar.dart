import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.orange.shade200), // Blue border
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: TextField(
        decoration: InputDecoration(
          icon: Icon(
            CupertinoIcons.search,
            color: Colors.orange,
          ), // Search icon
          hintText: 'Search aarti, wallpapers',
          border: InputBorder.none,
          suffixIcon: Icon(Icons.mic_none), // Mic icon on the right
        ),
      ),
    );
  }
}
