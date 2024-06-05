import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BookService extends StatelessWidget {
  const BookService({super.key});

  Future<bool> bookTrip(int passengerId, int tripId, int amountPaid) async {
    String apiUrl = 'http://busspass.somee.com/api/Booking/BookTrip';
    try {
      Map<String, dynamic> requestBody = {
        'passengerId': passengerId,
        'tripId': tripId,
        'amountPaid': amountPaid,
        'seatsBooked': 1,
      };

      final response = await http.post(
        Uri.parse(apiUrl),
        body: jsonEncode(requestBody),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        },
      );
      if (kDebugMode) {
        print(jsonEncode(requestBody));
      }
      if (kDebugMode) {
        print(jsonDecode(response.body));
      }
      if (response.statusCode == 200 || response.statusCode == 201) {
        var responseData = jsonDecode(response.body);

        if (responseData != null) {
          if (kDebugMode) {
            print('Registration successful!');
          }
          return true; // Return true for successful registration
        } else {
          if (kDebugMode) {
            print('Invalid response data');
          }
          return false; // Return false if response data is invalid
        }
      } else {
        if (kDebugMode) {
          print('Registration failed with status code: ${response.statusCode}');
        }
        if (kDebugMode) {
          print('Response body: ${response.body}');
        }
        return false; // Return false for registration failure
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error during registration: $e');
      }
      return false; // Return false if there's an error during registration
    }
  }

  @override
  Widget build(BuildContext context) {
    throw UnimplementedError();
  }
}
