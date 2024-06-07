import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:buss_pass/Bus-Pass/Apis/appData.dart';
import 'package:buss_pass/Bus-Pass/model/driver_model.dart';
import 'package:buss_pass/Bus-Pass/model/user_model.dart';

class LoginApi {
  static const String PassengerLoginUrl =
      'http://www.busspass.somee.com/api/auth/PassengerLogin';
  static const String DriverLoginUrl =
      'http://busspass.somee.com/api/Auth/DriverLogin';

  Future<User> login(String username, String password) async {
    try {
      final response = await http.post(
        Uri.parse(PassengerLoginUrl),
        body: jsonEncode({'username': username, 'password': password}),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);

        if (responseData != null && responseData['access_token'] != null) {
          return await _processUserData(responseData, username, password);
        } else {
          throw Exception('Invalid response data: access_token missing');
        }
      } else {
        throw Exception(
            'Login failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error during login: $e');
      }
      throw Exception('Login failed: $e');
    }
  }

  Future<User> _processUserData(Map<String, dynamic> responseData,
      String username, String password) async {
    String authToken = responseData['access_token'];
    int userId = responseData['user_Id'];

    await _saveUserDataToPrefs(
        authToken, userId, username, password, 'passenger');

    try {
      var data =
          await appDatas().dataSet(userId); // Await the result of dataSet
      // Parse JSON data
      Map<String, dynamic>? userData;
      if (data != null) {
        userData = jsonDecode(data);
      }

      return User(
        id: userId,
        username: userData?['username'] ?? '', // Access data from parsed JSON
        authToken: authToken,
        fullName: userData?['fullName'] ?? '',
        email: userData?['email'] ?? '',
        phoneNumber: userData?['phoneNumber'] ?? '',
        passengerLat:
            (userData?['passengerLat'] ?? 0).toDouble(), // Cast to double
        passengerLong:
            (userData?['passengerLong'] ?? 0).toDouble(), // Cast to double
      );
    } catch (e) {
      if (kDebugMode) {
        print('Error processing user data: $e');
      }
      throw Exception('Failed to process user data: $e');
    }
  }

  Future<void> _saveUserDataToPrefs(String authToken, int userId,
      String username, String password, String role) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('access_token', authToken);
    await prefs.setInt('user_Id', userId);
    await prefs.setString('username', username);
    await prefs.setString('password', password);
    await prefs.setString('role', role); // Save user role
  }

  Future<String?> getAuthToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('access_token');
  }

  Future<Driver> loginDriver(String username, String password) async {
    try {
      final response = await http.post(
        Uri.parse(DriverLoginUrl),
        body: jsonEncode({'username': username, 'password': password}),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);

        if (responseData != null && responseData['access_token'] != null) {
          return await _processDriverData(responseData, username, password);
        } else {
          throw Exception('Invalid response data: access_token missing');
        }
      } else {
        throw Exception(
            'Login failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error during driver login: $e');
      }
      throw Exception('Login failed: $e');
    }
  }

  Future<Driver> _processDriverData(Map<String, dynamic> responseData,
      String username, String password) async {
    String authToken = responseData['access_token'];
    int userId = responseData['user_Id'];

    await _saveUserDataToPrefs(authToken, userId, username, password, 'driver');

    return Driver(
      id: userId,
      username: responseData['user_name'] ?? '', // Access data from parsed JSON
      authToken: authToken,
      fullName: responseData['fullname'] ?? '',
      email: responseData['email'] ?? '',
      phoneNumber: responseData['phoneNumber'] ?? '',
    );
  }
}
