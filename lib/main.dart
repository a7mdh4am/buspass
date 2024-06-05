import 'package:buss_pass/Bus-Pass/services/firebaseNotifications.dart';
import 'package:buss_pass/Bus-Pass/splash_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:buss_pass/Bus-Pass/providers/driver_provider.dart';
import 'package:buss_pass/Bus-Pass/providers/trip_provider.dart';
import 'package:buss_pass/Bus-Pass/providers/user_provider.dart';
import 'package:device_preview/device_preview.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase and FCM
  await FirebaseNotification().initialize();

  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => UserProvider()),
          ChangeNotifierProvider(create: (context) => DriverProvider()),
          ChangeNotifierProvider(create: (context) => TripProvider()),
        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      home: const SplashScreen(),
    );
  }
}
