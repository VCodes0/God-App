import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/custom_next_button.dart';
import 'get_started_screen.dart';

class PermissionsScreen extends StatefulWidget {
  const PermissionsScreen({super.key});

  @override
  State<PermissionsScreen> createState() => _PermissionsScreenState();
}

class _PermissionsScreenState extends State<PermissionsScreen> {
  bool isContactsEnabled = true;
  bool isMediaEnabled = false;

  @override
  Widget build(BuildContext context) {
    final Size screen = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFFFDF5F1),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screen.width * 0.06,
            vertical: screen.height * 0.025,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  "Required Permission",
                  style: TextStyle(
                    color: Colors.brown[800],
                    fontSize: screen.width * 0.05,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: screen.height * 0.015),
              Center(
                child: Text(
                  "Grant permission for these apps to access\nfeatures on your device.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: screen.width * 0.038,
                  ),
                ),
              ),
              SizedBox(height: screen.height * 0.03),

              /// CONTACTS PERMISSION
              _buildPermissionTile(
                screen,
                iconPath: "assets/contact.png",
                title: "Contacts",
                subtitle: "Allow access to your phone’s contacts list.",
                value: isContactsEnabled,
                onChanged: (val) {
                  setState(() {
                    isContactsEnabled = val;
                  });
                },
              ),

              SizedBox(height: screen.height * 0.02),

              /// MEDIA PERMISSION
              _buildPermissionTile(
                screen,
                iconPath: "assets/folder.png",
                title: "Photos/Media/File",
                subtitle: "Allow access to Photos, Videos and Media Files.",
                value: isMediaEnabled,
                onChanged: (val) {
                  setState(() {
                    isMediaEnabled = val;
                  });
                },
              ),

              SizedBox(height: screen.height * 0.08),

              /// CONTINUE BUTTON
              Center(
                child: InkWell(
                  onTap: () => Get.to(GetStartedScreen()),
                  child: CustomNxtButton(text: "Continue"),
                ),
              ),

              SizedBox(height: screen.height * 0.17),

              /// AD SPACE
              Container(
                height: screen.height * 0.18,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: BorderRadius.circular(12),
                ),
                alignment: Alignment.center,
                child: Text(
                  "AD",
                  style: TextStyle(
                    fontSize: screen.width * 0.045,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPermissionTile(
    Size screen, {
    required String iconPath,
    required String title,
    required String subtitle,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return Container(
      padding: EdgeInsets.all(screen.width * 0.04),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.deepOrangeAccent, width: 1),
        color: Colors.white,
      ),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Image.asset(
              iconPath,
              width: screen.width * 0.08,
              height: screen.width * 0.1,
            ),
          ),
          SizedBox(width: screen.width * 0.04),
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: screen.width * 0.042,
                  ),
                ),
                SizedBox(height: screen.height * 0.005),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: screen.width * 0.034,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: Colors.orange,
            inactiveThumbColor: Colors.grey,
          ),
        ],
      ),
    );
  }
}
