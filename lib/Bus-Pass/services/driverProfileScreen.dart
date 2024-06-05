import 'package:buss_pass/Bus-Pass/auth/login_screen.dart';
import 'package:buss_pass/Bus-Pass/home/widgets/help.dart';
import 'package:buss_pass/Bus-Pass/home/widgets/privacy.dart';
import 'package:buss_pass/Bus-Pass/model/driver_model.dart';
import 'package:buss_pass/Bus-Pass/providers/driver_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:buss_pass/Bus-Pass/profile/widgets/elevated_button.dart';

class DriverProfileScreen extends StatelessWidget {
  const DriverProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final driverProvider = Provider.of<DriverProvider>(context);
    Driver driver = driverProvider.driver;

    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;

    return Scaffold(
      backgroundColor: const Color.fromRGBO(241, 241, 241, 1),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(
          screenWidth * 0.02,
          screenHeight * 0.1,
          screenWidth * 0.02,
          0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
            Column(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage('assets/images/avatar.jpg'),
                  radius: screenWidth * 0.1,
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: screenHeight * 0.02,
                    ),
                    Text(
                      driver.fullName,
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: screenWidth * 0.05,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      driver.email,
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: screenWidth * 0.04,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            CustomElevatedButton(
              icon: Icons.person,
              label: "Edit Profile",
              onPressed: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => const EditDriverProfileScreen(),
                //   ),
                // );
              },
            ),
            const SizedBox(height: 10),
            CustomElevatedButton(
              icon: Icons.help,
              label: "Help",
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const HelpPage()));
              },
            ),
            const SizedBox(height: 10),
            CustomElevatedButton(
              icon: Icons.privacy_tip,
              label: "Privacy",
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PrivacyPolicyPage()));
              },
            ),
            const SizedBox(height: 10),
            CustomElevatedButton(
              icon: Icons.logout,
              label: "Log Out",
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text("Log Out"),
                      content: const Text("Are you sure you want to log out?"),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context); // Close the dialog
                          },
                          child: const Text("Cancel"),
                        ),
                        TextButton(
                          onPressed: () {
                            driverProvider.logout();
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
      ),
    );
  }
}
