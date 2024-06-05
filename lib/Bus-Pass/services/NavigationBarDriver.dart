import 'package:buss_pass/Bus-Pass/driver/addTrips.dart';
import 'package:buss_pass/Bus-Pass/driver/driver_homepage.dart';
import 'package:buss_pass/Bus-Pass/services/driverProfileScreen.dart';
import 'package:flutter/material.dart';

class DriverNavigationBar extends StatefulWidget {
  const DriverNavigationBar({super.key});

  @override
  _DriverNavigationBarState createState() => _DriverNavigationBarState();
}

class _DriverNavigationBarState extends State<DriverNavigationBar> {
  int _currentIndex = 0;

  void _onPressed(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          IndexedStack(
            index: _currentIndex,
            children: const [
              DriverScreen(),
              AddTripPage(),
              DriverProfileScreen(),
            ],
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Material(
              elevation: 8.0, // Add elevation here
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
              child: Container(
                height: screenHeight * 0.085,
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(255, 255, 255, 1),
                  borderRadius: BorderRadius.all(
                    Radius.circular(40),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      onPressed: () => _onPressed(0),
                      icon: Icon(
                        Icons.home,
                        color: _currentIndex == 0
                            ? const Color.fromRGBO(39, 66, 129, 1)
                            : Colors.grey,
                        size: 30,
                      ),
                    ),
                    IconButton(
                      onPressed: () => _onPressed(1),
                      icon: Icon(
                        Icons.directions_bus,
                        color: _currentIndex == 1
                            ? const Color.fromRGBO(39, 66, 129, 1)
                            : Colors.grey,
                        size: 30,
                      ),
                    ),
                    IconButton(
                      onPressed: () => _onPressed(2),
                      icon: Icon(
                        Icons.person,
                        color: _currentIndex == 2
                            ? const Color.fromRGBO(39, 66, 129, 1)
                            : Colors.grey,
                        size: 30,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
