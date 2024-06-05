import 'package:buss_pass/Bus-Pass/navigationbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PaymentConfirmationScreen extends StatelessWidget {
  const PaymentConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                width: screenWidth,
                height: screenHeight * 0.08,
                color: const Color.fromRGBO(255, 115, 92, 1),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 20,
                    ),
                    Text(
                      "Payment confirmation",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                    Icon(
                      Icons.more_vert,
                      color: Colors.white,
                      size: 20,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: screenHeight * 0.03,
            ),
            Center(
              child: SvgPicture.asset(
                'assets/icons/progress bar.svg',
                width: 40, // Adjust size as needed
                height: 40,
              ),
            ),
            SizedBox(
              height: screenHeight * 0.1,
            ),
            Center(
              child: SvgPicture.asset(
                'assets/icons/Frame 13.svg',
                width: screenWidth * 0.7, // Adjust size as needed
                height: screenHeight * 0.3,
              ),
            ),
            SizedBox(
              height: screenHeight * 0.03,
            ),
            Center(
              child: InkWell(
                onTap: () {
                  /////////////////////////////
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ButtonNavigationBar(),
                      ));
                },
                child: Container(
                  width: screenWidth * 0.4,
                  height: screenHeight * 0.06,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: const Color.fromRGBO(255, 115, 92, 1),
                  ),
                  child: const Center(
                    child: Text(
                      "Done",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 20,
                        color: Color.fromRGBO(255, 255, 255, 1),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
