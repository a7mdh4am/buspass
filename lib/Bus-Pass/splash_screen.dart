import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:buss_pass/Bus-Pass/auth/login_screen.dart';
import 'package:buss_pass/Bus-Pass/providers/driver_provider.dart';
import 'package:buss_pass/Bus-Pass/providers/user_provider.dart';
import 'package:buss_pass/Bus-Pass/navigationbar.dart';
import 'package:buss_pass/Bus-Pass/services/NavigationBarDriver.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? accessToken = prefs.getString('access_token');
      String? username = prefs.getString('username');
      String? password = prefs.getString('password');

      if (accessToken == null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginScreen(),
          ),
        );
      } else {
        String? role = prefs.getString('role');
        try {
          if (role == 'driver') {
            final driverProvider = Provider.of<DriverProvider>(
              context,
              listen: false,
            );
            await driverProvider.login(username!, password!);
            if (driverProvider.driver.authToken != null &&
                driverProvider.driver.authToken!.isNotEmpty) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const DriverNavigationBar(),
                ),
              );
            }
          } else {
            final userProvider = Provider.of<UserProvider>(
              context,
              listen: false,
            );
            await userProvider.login(username!, password!);
            if (userProvider.user.authToken != null &&
                userProvider.user.authToken!.isNotEmpty) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const ButtonNavigationBar(),
                ),
              );
            }
          }
        } catch (e) {
          // Handle login error
          print('Login error: $e');
          // Navigate to login screen
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const LoginScreen(),
            ),
          );
        }
      }
    });

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: 400,
              height: 200,
              margin: const EdgeInsets.all(7),
              alignment: Alignment.center,
              child: RichText(
                text: const TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Bus',
                      style: TextStyle(
                        color: Color(0xFF243665),
                        fontFamily: 'poppins',
                        fontSize: 50,
                      ),
                    ),
                    TextSpan(
                      text: ' Pass',
                      style: TextStyle(
                        color: Color(0xFFFF735C),
                        fontFamily: 'poppins',
                        fontSize: 50,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 30),
              child: Column(
                children: [
                  Image.asset(
                    "assets/images/splash-bus.png",
                    fit: BoxFit.cover,
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 25),
                    alignment: Alignment.center,
                    child: const Text(
                      'Quick & Easy\n'
                      'to Travel anywhere\n'
                      '& anytime',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF243665),
                        fontFamily: 'Mulish',
                        fontSize: 30,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
