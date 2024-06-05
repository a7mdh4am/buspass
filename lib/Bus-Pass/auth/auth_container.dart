import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:buss_pass/Bus-Pass/auth/login_screen.dart';
import 'package:buss_pass/Bus-Pass/home/home_screen.dart';

class AuthContainer extends StatefulWidget {
  const AuthContainer({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AuthContainerState createState() => _AuthContainerState();
}

class _AuthContainerState extends State<AuthContainer> {
  String? token; // Use nullable string to handle initial state properly
  bool isLoading = true; // Use isLoading flag to manage async loading state
  @override
  void initState() {
    super.initState();
    checkToken(); // Call checkToken() in initState to load token initially
  }

  Future<void> checkToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      token = prefs.getString('access_token');
      isLoading = false; // Update isLoading once token check is complete
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      // Show loading indicator while checking for token
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      if (token == null) {
        if (kDebugMode) {
          print(token);
        }
        // If token is null, navigate to login screen
        return const LoginScreen();
      } else {
        // If token is present, navigate to home screen
        return const HomeScreen();
      }
    }
  }
}
