import 'package:buss_pass/Bus-Pass/auth/login_screen.dart';
import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Color.fromRGBO(34, 34, 34, 1),
            size: 16,
          ),
        ),
        title: const Text(
          "Back",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: Color.fromRGBO(34, 34, 34, 1),
          ),
        ),
      ),
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Forgot password?",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 42,
                    color: Color.fromRGBO(45, 92, 200, 1),
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.08,
                ),
                const Text(
                  "Enter your email for the\nverification process,\nwe will send code to your email",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 24,
                    color: Color.fromRGBO(44, 44, 44, 1),
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.08,
                ),
                const Text(
                  "Email",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 24,
                    color: Color.fromRGBO(44, 44, 44, 1),
                  ),
                ),
                Form(
                  child: Column(
                    children: [
                      Container(
                        width: screenWidth * 0.9,
                        height: screenHeight * 0.08,
                        color: const Color.fromRGBO(255, 255, 255, 1),
                        child: TextFormField(
                          controller: emailController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Type something longer here...',
                            labelStyle: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(
                        height: screenHeight * 0.02,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginScreen(),
                            ),
                          );
                        },
                        child: Container(
                          width: screenWidth * 0.8,
                          height: screenHeight * 0.08,
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(39, 66, 129, 1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Center(
                            child: Text(
                              'Continue',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  color: Color.fromRGBO(255, 255, 255, 1)),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
