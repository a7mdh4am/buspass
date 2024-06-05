import 'package:buss_pass/Bus-Pass/auth/login_screen.dart';
import 'package:buss_pass/Bus-Pass/home/widgets/help.dart';
import 'package:buss_pass/Bus-Pass/home/widgets/privacy.dart';
import 'package:buss_pass/Bus-Pass/home/widgets/receipts_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:buss_pass/Bus-Pass/providers/user_provider.dart';
import 'package:buss_pass/Bus-Pass/model/user_model.dart';
import 'package:buss_pass/Bus-Pass/profile/widgets/edit_profile.dart';
import 'package:buss_pass/Bus-Pass/profile/widgets/elevated_button.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    User user = userProvider.user;

    return Scaffold(
      backgroundColor: const Color.fromRGBO(241, 241, 241, 1),
      body: LayoutBuilder(
        builder: (context, constraints) {
          double screenWidth = constraints.maxWidth;
          double screenHeight = constraints.maxHeight;
          double padding = screenWidth * 0.05;
          double avatarRadius = screenWidth * 0.15;
          double fontSize = screenWidth * 0.05;
          double titleFontSize = screenWidth * 0.06;
          double buttonSpacing = screenHeight * 0.02;

          return SingleChildScrollView(
            padding:
                EdgeInsets.fromLTRB(padding, screenHeight * 0.1, padding, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: screenHeight * 0.02),
                Column(
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage('assets/images/avatar.jpg'),
                      radius: avatarRadius,
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user.fullName,
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: titleFontSize,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          user.email,
                          style: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: fontSize,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          user.phoneNumber,
                          style: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: fontSize,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: buttonSpacing),
                CustomElevatedButton(
                  icon: Icons.person,
                  label: "Edit Profile",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const EditProfileScreen(),
                      ),
                    );
                  },
                ),
                SizedBox(height: buttonSpacing),
                CustomElevatedButton(
                  icon: Icons.help,
                  label: "Help",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const HelpPage()),
                    );
                  },
                ),
                SizedBox(height: buttonSpacing),
                CustomElevatedButton(
                  icon: Icons.privacy_tip,
                  label: "Privacy",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PrivacyPolicyPage()),
                    );
                  },
                ),
                SizedBox(height: buttonSpacing),
                CustomElevatedButton(
                  icon: Icons.receipt,
                  label: "Receipt",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ReceiptsScreen(
                          passengerId: user.id,
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(height: buttonSpacing),
                CustomElevatedButton(
                  icon: Icons.logout,
                  label: "Log Out",
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text("Log Out"),
                          content:
                              const Text("Are you sure you want to log out?"),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context); // Close the dialog
                              },
                              child: const Text("Cancel"),
                            ),
                            TextButton(
                              onPressed: () {
                                userProvider.logout();
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const LoginScreen(),
                                  ),
                                );
                              },
                              child: const Text("Log Out"),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
