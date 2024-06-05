import 'package:flutter/foundation.dart';
import 'package:buss_pass/Bus-Pass/Apis/loginAPI.dart';
import 'package:buss_pass/Bus-Pass/model/driver_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DriverProvider extends ChangeNotifier {
  Driver _driver = Driver.empty();

  Driver get driver => _driver;

  set driver(Driver newDriver) {
    _driver = newDriver;
    notifyListeners();
  }

  Future<void> login(String username, String password) async {
    try {
      Driver driver = await LoginApi().loginDriver(username, password);

      if (isValidToken(driver.authToken)) {
        this.driver = driver;
        await _saveDriverRole(); // Save the role locally
      } else {
        throw Exception('Invalid driver or token');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Login failed: $e');
      }
      throw Exception('Login failed: $e');
    }
  }

  void logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    if (kDebugMode) {
      print('Logged out. Access token: ${prefs.getString('access_token')}');
    }
    driver = Driver.empty();
  }

  bool isValidToken(String? token) {
    return token != null && token.isNotEmpty;
  }

  Future<void> _saveDriverRole() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_role', 'driver');
  }

  Future<String?> getDriverRole() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('user_role');
  }
}
