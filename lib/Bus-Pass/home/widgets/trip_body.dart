import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class TripBody extends StatelessWidget {
  final String? name;
  final String? id;
  final String? location;

  const TripBody({
    super.key,
    required this.name,
    required this.id,
    this.location,
  });

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    void _launchURL() async {
      if (location != null && await canLaunch(location!)) {
        await launch(location!);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not launch URL')),
        );
      }
    }

    return Stack(
      children: [
        Container(
          width: screenWidth * 0.8,
          height: screenHeight * 0.15,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3),
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
                    name ?? '',
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: Color.fromRGBO(12, 12, 12, 1),
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.01,
                  ),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(8.0),
                      minimumSize:
                          const Size(100, 35), // Set a fixed minimum size
                      textStyle: const TextStyle(
                        fontSize: 14, // Adjust the font size as needed
                      ),
                      backgroundColor: const Color.fromRGBO(39, 66, 129, 1),
                      foregroundColor: Colors.white,
                      // elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    icon: const Icon(Icons.location_on,
                        size: 18), // Adjust icon size as needed
                    label: const Text('Location'),
                    onPressed: _launchURL,
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
