import 'dart:convert';
import 'dart:typed_data';
import 'package:buss_pass/Bus-Pass/home/widgets/ReceiptScreen.dart';
import 'package:buss_pass/Bus-Pass/home/widgets/trip_details_body.dart';
import 'package:buss_pass/Bus-Pass/profile/widgets/dateForrmat.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class BookNowButton extends StatefulWidget {
  final TripDetailsBody tripDetailsBodies;
  final double screenWidth;
  final double screenHeight;
  final int? tripId;
  final int? seatsBooked;
  final int? amountPaid;

  const BookNowButton({
    Key? key,
    required this.screenWidth,
    required this.screenHeight,
    required this.tripId,
    required this.seatsBooked,
    required this.amountPaid,
    required this.tripDetailsBodies,
  }) : super(key: key);

  @override
  _BookNowButtonState createState() => _BookNowButtonState();
}

class _BookNowButtonState extends State<BookNowButton> {
  bool _isLoading = false;

  Future<void> bookTrip(BuildContext context) async {
    setState(() {
      _isLoading = true;
    });

    const url = 'http://busspass.somee.com/api/Booking/BookTrip';
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final int? passengerId = prefs.getInt('user_Id');

    if (passengerId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User not logged in.')),
      );
      setState(() {
        _isLoading = false;
      });
      return;
    }

    final body = jsonEncode({
      'passengerId': passengerId,
      'tripId': widget.tripId,
      'seatsBooked': widget.seatsBooked,
      'amountPaid': widget.amountPaid,
    });

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: body,
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        final String bookingId = responseData['bookingId'].toString();

        final qrCodeResponse = await http.post(
          Uri.parse(
              'http://busspass.somee.com/api/Attendance/generate-qrcodeBase64'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            'passengerId': passengerId,
            'tripId': widget.tripId,
          }),
        );

        if (qrCodeResponse.statusCode == 200) {
          String base64Image = qrCodeResponse.body.split(',')[1];
          Uint8List qrCodeBytes = base64.decode(base64Image);

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Receiptscreen(
                driverName: widget.tripDetailsBodies.driverName!,
                price: widget.tripDetailsBodies.price.toString(),
                bookingTime: Date().formatDate(widget.tripDetailsBodies.date!),
                startingStop: widget.tripDetailsBodies.fromStationName!,
                endingStop: widget.tripDetailsBodies.toStationName!,
                ticketId: bookingId,
                tripId: widget.tripId!,
                qrCodeImage: Image.memory(qrCodeBytes),
              ),
            ),
          );
        } else {
          throw Exception('Failed to fetch QR code image');
        }
      } else {
        throw Exception(response.body);
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$error')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: _isLoading ? null : () => bookTrip(context),
        child: Container(
          width: widget.screenWidth * 0.5,
          height: widget.screenHeight * 0.08,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.screenHeight * 0.04),
            color: const Color.fromRGBO(125, 10, 10, 1),
          ),
          child: Center(
            child: _isLoading
                ? const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  )
                : Text(
                    "Book Now",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: widget.screenWidth * 0.05,
                      color: Colors.white,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
