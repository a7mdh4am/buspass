import 'dart:async';

import 'package:buss_pass/Bus-Pass/auth/sign_up_screen.dart';
import 'package:buss_pass/Bus-Pass/navigationbar.dart';
import 'package:buss_pass/Bus-Pass/services/NavigationBarDriver.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:buss_pass/Bus-Pass/providers/driver_provider.dart';
import 'package:buss_pass/Bus-Pass/providers/user_provider.dart';
import 'package:buss_pass/Bus-Pass/auth/forgot_password_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _obscureText = true;
  bool _isLoading = false;
  String dropdownValue = 'Please select your role';

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        title: const Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'Sign in',
                  style: TextStyle(
                    color: Color(0xff2A4CA3),
                    fontWeight: FontWeight.w500,
                    fontSize: 30,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 40),
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'Please log in into your account',
                  style: TextStyle(fontSize: 15),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'User Name',
                    suffixIcon: Icon(Icons.person),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: TextField(
                  obscureText: _obscureText,
                  controller: passwordController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: 'Password',
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureText ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: _togglePasswordVisibility,
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: Center(
                  child: DropdownButton<String>(
                    value: dropdownValue,
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownValue = newValue!;
                      });
                    },
                    dropdownColor: Colors.white,
                    items: <String>[
                      'Please select your role',
                      'Continue as Passenger',
                      'Continue as Driver'
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Container(
                          child: Text(value),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ForgotPasswordScreen(),
                    ),
                  );
                },
                child: const Text('Forgot Password'),
              ),
              Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                margin: const EdgeInsets.only(top: 50), // Space Between Button
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all<Color>(
                      const Color(0xff274281),
                    ),
                  ),
                  onPressed: _isLoading ||
                          dropdownValue == 'Please select your role'
                      ? null
                      : () {
                          setState(() {
                            _isLoading = true;
                          });

                          FutureOr<Null> handleError(dynamic error) async {
                            setState(() {
                              _isLoading = false;
                            });

                            if (error.toString().contains('401')) {
                              _showErrorDialog('Wrong username or password!');
                            } else if (error.toString().contains('404')) {
                              _showErrorDialog(
                                  'There is no user with this data!');
                            } else if (error.toString().contains('500')) {
                              _showErrorDialog(
                                  'The username or password is Incorrect!');
                            } else {
                              _showErrorDialog('An error occurred: $error');
                            }
                          }

                          if (dropdownValue == 'Continue as Driver') {
                            final driverProvider = Provider.of<DriverProvider>(
                                context,
                                listen: false);
                            driverProvider
                                .login(nameController.text,
                                    passwordController.text)
                                .then((_) {
                              setState(() {
                                _isLoading = false;
                              });
                              if (driverProvider.driver.authToken != null &&
                                  driverProvider.driver.authToken!.isNotEmpty) {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const DriverNavigationBar(),
                                  ),
                                );
                              } else {
                                _showErrorDialog(
                                    'Invalid access token or authentication failed.');
                              }
                            }).catchError(handleError);
                          } else {
                            final userProvider = Provider.of<UserProvider>(
                                context,
                                listen: false);
                            userProvider
                                .login(nameController.text,
                                    passwordController.text)
                                .then((_) {
                              setState(() {
                                _isLoading = false;
                              });
                              if (userProvider.user.authToken != null &&
                                  userProvider.user.authToken!.isNotEmpty) {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const ButtonNavigationBar(),
                                  ),
                                );
                              } else {
                                _showErrorDialog(
                                    'Invalid access token or authentication failed.');
                              }
                            }).catchError(handleError);
                          }
                        },
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          'Sign In',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('New customer?'),
                  TextButton(
                    child: const Text(
                      'Create new account',
                      style: TextStyle(fontSize: 15, color: Color(0xff4280EF)),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignUpScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
