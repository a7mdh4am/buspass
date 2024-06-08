import 'dart:convert';
import 'package:buss_pass/Bus-Pass/providers/driver_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditDriverProfileScreen extends StatefulWidget {
  const EditDriverProfileScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _EditDriverProfileScreenState createState() =>
      _EditDriverProfileScreenState();
}

class _EditDriverProfileScreenState extends State<EditDriverProfileScreen> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> updateProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? id = prefs.getInt('user_Id').toString();
    String apiUrl = 'http://busspass.somee.com/api/Driver/$id';

    Map<String, dynamic> profileData = {
      'fullName': fullNameController.text,
      'email': emailController.text,
      'phoneNumber': phoneController.text,
      'username': usernameController.text,
      'passwordHash': passwordController.text,
    };

    try {
      final response = await http.put(
        Uri.parse(apiUrl),
        body: json.encode(profileData),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 204) {
        Navigator.pop(context);
      } else {
        print('Failed to update profile: ${response.body}');
      }
    } catch (error) {
      print('Error updating profile: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Edit Profile'),
      // ),
      body: Container(
        color: const Color.fromRGBO(241, 241, 241, 1),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 70, 20, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text(
                    'Edit Profile',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(39, 66, 129, 1),
                    ),
                  ),
                ],
              ),
              TextField(
                controller: fullNameController,
                decoration: const InputDecoration(labelText: 'Full Name'),
              ),
              TextField(
                controller: usernameController,
                decoration: const InputDecoration(labelText: 'Username'),
              ),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              TextField(
                controller: passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),
              TextField(
                controller: phoneController,
                decoration: const InputDecoration(labelText: 'Phone Number'),
              ),
              const SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(8.0),
                      fixedSize: const Size(170, 50),
                      textStyle: const TextStyle(
                        fontSize: 18,
                      ),
                      backgroundColor: const Color.fromRGBO(39, 66, 129, 1),
                      foregroundColor: Colors.white,
                      elevation: 10,
                      alignment: Alignment.centerLeft,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    icon: const Icon(Icons.save),
                    label: const Text('Save Changes'),
                    onPressed: () {
                      Provider.of<DriverProvider>(context, listen: false)
                          .updateDriverInformation(
                              email: emailController.text,
                              fullName: fullNameController.text,
                              phoneNumber: phoneController.text);
                      // Call the method to update profile
                      updateProfile();
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

  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.dispose();
  }
}
