import 'package:flutter/material.dart';
import 'package:buss_pass/Bus-Pass/home/widgets/ReceiptPaint.dart';

class Receiptscreen extends StatefulWidget {
  final String? driverName;
  final String? price;
  final String? bookingTime;
  final String? startingStop;
  final String? endingStop;
  final String? ticketId;
  final int tripId;
  final Image qrCodeImage;

  const Receiptscreen({
    Key? key,
    required this.driverName,
    required this.price,
    required this.bookingTime,
    required this.startingStop,
    required this.endingStop,
    required this.ticketId,
    required this.tripId,
    required this.qrCodeImage,
  }) : super(key: key);

  @override
  _ReceiptscreenState createState() => _ReceiptscreenState();
}

class _ReceiptscreenState extends State<Receiptscreen> {
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
          "Receipt Screen",
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
          double padding = screenWidth * 0.05;
          double fontSize = screenWidth * 0.05;
          double titleFontSize = screenWidth * 0.06;
          double qrCodeSize = screenWidth * 0.4;

          return Padding(
            padding: EdgeInsets.all(padding),
            child: Center(
              child: CustomPaint(
                painter: ReceiptPainter(),
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
                      SizedBox(height: padding),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
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
                              SizedBox(height: padding * 0.5),
                              Text(
                                widget.driverName!,
                                style: TextStyle(
                                  fontSize: fontSize,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: screenWidth * 0.15),
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
                              SizedBox(height: padding * 0.5),
                              Text(
                                widget.price!,
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
                      SizedBox(height: padding),
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
                          SizedBox(height: padding * 0.5),
                          Text(
                            widget.startingStop!,
                            style: TextStyle(
                              fontSize: fontSize,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: padding),
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
                          SizedBox(height: padding * 0.5),
                          Text(
                            widget.endingStop!,
                            style: TextStyle(
                              fontSize: fontSize,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: padding),
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
                            widget.bookingTime!,
                            style: TextStyle(
                              fontSize: fontSize,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: padding + 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Text(
                                'Ticket ID',
                                style: TextStyle(
                                  fontSize: fontSize,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                widget.ticketId.toString(),
                                style: TextStyle(
                                  fontSize: titleFontSize + 20,
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: screenWidth * 0.05),
                          SizedBox(
                            width: qrCodeSize,
                            height: qrCodeSize,
                            child: widget.qrCodeImage,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
