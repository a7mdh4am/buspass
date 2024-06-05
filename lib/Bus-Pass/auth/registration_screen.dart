// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'sign_up_screen.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  String name = "";

  Widget buildSignInButton(String text, String hexColor, String socialIcon) {
    return Container(
      margin: const EdgeInsets.only(top: 20.0),
      width: 300,
      height: 40,
      decoration: BoxDecoration(
        color: Color(int.parse('0xff$hexColor')),
        borderRadius: BorderRadius.circular(50.0),
      ),
      child: Container(
        margin: const EdgeInsets.only(left: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SvgPicture.asset(
              socialIcon,
              width: 20, // Adjust size as needed
              height: 20,
            ),
            Expanded(
              child: Center(
                child: Text(
                  text,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSignUpButton(String text, String hexColor, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(top: 20.0),
        width: 300,
        height: 40,
        decoration: BoxDecoration(
          color: Color(int.parse('0xff$hexColor')),
          borderRadius: BorderRadius.circular(50.0),
        ),
        child: Align(
          alignment: Alignment.center,
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white, // Change the color here
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PageView(
          children: [
            Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 50.0),
                  width: 400,
                  height: 200,
                  child: Image.asset('assets/images/splash-bus.png'),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 150.0),
                  width: 300,
                  height: 40,
                  decoration: BoxDecoration(
                    color: const Color(0xffC6432D),
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  child: Align(
                      alignment: Alignment.center,
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignUpScreen(),
                            ),
                          );
                        },
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(color: Colors.white),
                        ),
                      )),
                ),
              ],
            ),
            const Column(
              children: [
                Text('Hello, Flutter!'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
