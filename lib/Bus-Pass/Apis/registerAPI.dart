// ignore_for_file: file_names

import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class RegisterAPI {
  static const String passengerRegisterUrl =
      'http://busspass.somee.com/api/Auth/PassengerRegister';
  static const String driverRegisterUrl =
      'http://busspass.somee.com/api/Auth/DriverRegister';

  Future<bool> register(String fullName, String username, String password,
      String email, String phoneNumber, String role) async {
    try {
      Map<String, dynamic> requestBody = {
        'fullName': fullName,
        'username': username,
        'passwordHash': password,
        'email': email,
        'phoneNumber': phoneNumber,
      };

      String apiUrl =
          role == 'driver' ? driverRegisterUrl : passengerRegisterUrl;

      final response = await http.post(
        Uri.parse(apiUrl),
        body: jsonEncode(requestBody),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Registration successful!');
        return true; // Return true for successful registration
      } else {
        final errorResponse = jsonDecode(response.body);
        throw Exception(errorResponse['message']);
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error during registration: $e');
      }
      return false; // Return false if there's an error during registration
    }
  }
}
