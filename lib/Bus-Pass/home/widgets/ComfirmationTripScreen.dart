import 'package:flutter/material.dart';
import 'package:buss_pass/Bus-Pass/home/widgets/UpperReceiptPaint.dart';
import 'package:buss_pass/Bus-Pass/home/widgets/trip_details_body.dart';
import 'package:buss_pass/Bus-Pass/profile/widgets/bookNow.dart';

class ComfirmationTripScreen extends StatefulWidget {
  final TripDetailsBody tripDetailsBodies;

  const ComfirmationTripScreen({
    Key? key,
    required this.tripDetailsBodies,
  }) : super(key: key);

  @override
  _ComfirmationTripScreenState createState() => _ComfirmationTripScreenState();
}

class _ComfirmationTripScreenState extends State<ComfirmationTripScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(39, 66, 129, 1),
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
            size: 20,
          ),
        ),
        title: const Text(
          "Comfirmation Screen",
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color.fromRGBO(39, 66, 129, 1),
        toolbarHeight: 45,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          double screenWidth = constraints.maxWidth;
          double screenHeight = constraints.maxHeight;
          double padding = screenWidth * 0.05;
          double fontSize = screenWidth * 0.05;
          double titleFontSize = screenWidth * 0.06;

          return Padding(
            padding: EdgeInsets.all(padding),
            child: CustomPaint(
              painter: UpperReceiptPaint(),
              child: Padding(
                padding: EdgeInsets.all(padding),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            'assets/images/sanda_logo.png',
                            width: screenWidth * 0.1,
                            height: screenWidth * 0.1,
                          ),
                        ),
                        SizedBox(width: screenWidth * 0.02),
                        Text(
                          'Sanda Travels',
                          style: TextStyle(
                            fontSize: titleFontSize,
                            color: const Color.fromRGBO(125, 10, 10, 1),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Driver',
                                  style: TextStyle(
                                    fontSize: fontSize,
                                    color: Colors.grey,
                                  ),
                                ),
                                SizedBox(height: screenHeight * 0.01),
                                Text(
                                  widget.tripDetailsBodies.driverName!,
                                  style: TextStyle(
                                    fontSize: fontSize,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: screenWidth * 0.15,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Price',
                                  style: TextStyle(
                                    fontSize: fontSize,
                                    color: Colors.grey,
                                  ),
                                ),
                                SizedBox(height: screenHeight * 0.01),
                                Text(
                                  widget.tripDetailsBodies.price.toString(),
                                  style: TextStyle(
                                    fontSize: fontSize,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.03),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'From',
                          style: TextStyle(
                            fontSize: fontSize,
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        Text(
                          widget.tripDetailsBodies.fromStationName!,
                          style: TextStyle(
                            fontSize: fontSize,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.03),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'To',
                          style: TextStyle(
                            fontSize: fontSize,
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        Text(
                          widget.tripDetailsBodies.toStationName!,
                          style: TextStyle(
                            fontSize: fontSize,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.03),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Date',
                          style: TextStyle(
                            fontSize: fontSize,
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(width: screenWidth * 0.05),
                        Text(
                          widget.tripDetailsBodies.date!,
                          style: TextStyle(
                            fontSize: fontSize,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.03),
                    BookNowButton(
                      screenWidth: screenWidth,
                      screenHeight: screenHeight,
                      tripId: widget.tripDetailsBodies.ID,
                      seatsBooked: 1,
                      amountPaid: widget.tripDetailsBodies.price,
                      tripDetailsBodies: widget.tripDetailsBodies,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
