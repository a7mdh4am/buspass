import 'package:buss_pass/Bus-Pass/profile/profile_screen.dart';
import 'package:flutter/material.dart';

import 'home/home_screen.dart';
import 'location/location_screen.dart';

class ButtonNavigationBar extends StatefulWidget {
  const ButtonNavigationBar({super.key});

  @override
  _ButtonNavigationBarState createState() => _ButtonNavigationBarState();
}

class _ButtonNavigationBarState extends State<ButtonNavigationBar> {
  int _currentIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentIndex);
  }

  void _onPressed(int index) {
    setState(() {
      _currentIndex = index;
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  void _onPageChanged(int index) {
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
          PageView(
            controller: _pageController,
            onPageChanged: _onPageChanged,
            children: const [
              HomeScreen(),
              LocationScreen(),
              ProfileScreen(),
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
