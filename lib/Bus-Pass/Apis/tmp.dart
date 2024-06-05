// import 'package:flutter/material.dart';
// import 'package:buss_pass/Bus-Pass/Apis/authService.dart';

// class AuthServiceScreen extends StatefulWidget {
//   @override
//   _AuthServiceScreenState createState() => _AuthServiceScreenState();
// }

// class _AuthServiceScreenState extends State<AuthServiceScreen> {
//   String? _accessToken;
//   String? _role; // Added role
//   Map<String, dynamic>? _userData;

//   @override
//   void initState() {
//     super.initState();
//     _loadAuthData();
//   }

//   // Method to load the access token and role from shared preferences
//   void _loadAuthData() async {
//     Map<String, dynamic> authData = await AuthService.getAccessTokenAndRole();
//     setState(() {
//       _accessToken = authData['access_token'];
//       _role = authData['role'];
//       if (_accessToken != null) {
//         _userData = AuthService.getUserDataFromToken(_accessToken!);
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Authentication Service'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text(
//               'Access Token:',
//               style: TextStyle(fontSize: 20.0),
//             ),
//             Text(
//               _accessToken ?? 'No access token found',
//               style: TextStyle(fontSize: 16.0),
//             ),
//             SizedBox(height: 20.0),
//             Text(
//               'Role:', // Displaying role
//               style: TextStyle(fontSize: 20.0),
//             ),
//             Text(
//               _role ?? 'No role found',
//               style: TextStyle(fontSize: 16.0),
//             ),
//             SizedBox(height: 20.0),
//             Text(
//               'User Data:',
//               style: TextStyle(fontSize: 20.0),
//             ),
//             _userData != null
//                 ? Column(
//                     children: _userData!.entries
//                         .map((entry) => Text('${entry.key}: ${entry.value}'))
//                         .toList(),
//                   )
//                 : Text('No user data found'),
//           ],
//         ),
//       ),
//     );
//   }
// }

// void main() {
//   runApp(MaterialApp(
//     home: AuthServiceScreen(),
//   ));
// }
