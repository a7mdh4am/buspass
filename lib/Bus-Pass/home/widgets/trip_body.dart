import 'package:flutter/material.dart';

class TripBody extends StatelessWidget {
  final String? name;
  final String? id;

  const TripBody({
    super.key,
    required this.name,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Container(
          width: screenWidth * 0.8,
          height: screenHeight * 0.15,
          decoration: BoxDecoration(
            color: Colors.white, // Set the background color
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 20,
                height: screenHeight * 0.15,
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(255, 115, 92, 1),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    bottomLeft: Radius.circular(8),
                  ),
                ),
              ),
              SizedBox(
                width: screenWidth * 0.05,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name ?? '', // Display name
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: Color.fromRGBO(12, 12, 12, 1),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    id ?? '', // Display ID
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: Color.fromRGBO(12, 12, 12, 1),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          right: 10,
          top: 20,
          child: Container(
            width: screenWidth * 0.4,
            height: screenHeight * 0.1,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/small-bus.png'),
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
