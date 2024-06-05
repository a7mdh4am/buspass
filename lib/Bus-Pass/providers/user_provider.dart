import 'package:flutter/foundation.dart';
import 'package:buss_pass/Bus-Pass/Apis/loginAPI.dart';
import 'package:buss_pass/Bus-Pass/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider extends ChangeNotifier {
  User _user = User.empty();

  User get user => _user;

  set user(User newUser) {
    _user = newUser;
    notifyListeners();
  }

  Future<void> login(String username, String password) async {
    try {
      User user = await LoginApi().login(username, password);

      if (isValidToken(user.authToken)) {
        this.user = user;
      } else {
        throw Exception('Invalid user or token');
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
    prefs.clear();
    user = User.empty();
  }

  bool isValidToken(String? token) {
    return token != null && token.isNotEmpty;
  }

  void updateUserInformation({
    required String fullName,
    required String email,
    required String phoneNumber,
  }) {
    user = user.copyWith(
      fullName: fullName,
      email: email,
      phoneNumber: phoneNumber,
    );
  }
}
