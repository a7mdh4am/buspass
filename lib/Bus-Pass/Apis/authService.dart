// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:jwt_decoder/jwt_decoder.dart';

// class AuthService {
//   // Method to get the access token and role from shared preferences
//   static Future<Map<String, dynamic>> getAccessTokenAndRole() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String accessToken = prefs.getString('access_token') ?? '';
//     String role = prefs.getString('role') ?? '';
//     return {'access_token': accessToken, 'role': role};
//   }

//   // Method to set the access token and role in shared preferences
//   static Future<void> setAccessTokenAndRole(
//       String accessToken, String role) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setString('access_token', accessToken);
//     await prefs.setString('role', role);
//   }

//   // Method to decode the access token and get filtered user data
//   static Map<String, dynamic>? getUserDataFromToken(String accessToken) {
//     Map<String, dynamic> userData = JwtDecoder.decode(accessToken);
//     Map<String, dynamic> filteredData = {
//       'username': userData['sub'],
//       'email': userData['email']
//       'name': userData['name']
//       'password': userData['email']

//     };
//     return filteredData;
//   }

//   static getAccessToken() {}
// }
