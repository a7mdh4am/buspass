import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:buss_pass/Bus-Pass/Apis/receipts_service.dart';
import 'package:buss_pass/Bus-Pass/home/widgets/ReceiptScreen.dart';
import 'package:buss_pass/Bus-Pass/profile/widgets/dateForrmat.dart';
import 'package:flutter/material.dart';

class ReceiptsScreen extends StatefulWidget {
  final int passengerId;

  const ReceiptsScreen({
    Key? key,
    required this.passengerId,
  }) : super(key: key);

  @override
  _ReceiptsScreenState createState() => _ReceiptsScreenState();
}

class _ReceiptsScreenState extends State<ReceiptsScreen> {
  String _message = '';

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: ReceiptService.getReceiptsByPassengerId(widget.passengerId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Loading state
          return Scaffold(
            appBar: AppBar(
              title: Text(
                "Receipts",
                style: TextStyle(
                    color: const Color.fromRGBO(39, 66, 129, 1),
                    fontWeight: FontWeight.bold),
              ),
              backgroundColor: Color.fromRGBO(241, 241, 241, 1),
            ),
            body: Container(
                color: Color.fromRGBO(241, 241, 241, 1),
                child: Center(
                    child: CircularProgressIndicator(
                  color: const Color.fromRGBO(39, 66, 129, 1),
                ))),
          );
        } else if (snapshot.hasError) {
          // Error state
          String errorMessage = 'No Receipts Available!';
          if (snapshot.error.runtimeType == NoSuchMethodError) {
            errorMessage = 'Receipts empty';
          }
          return Scaffold(
            appBar: AppBar(
              title: Text(
                "Receipts",
                style: TextStyle(
                    color: const Color.fromRGBO(39, 66, 129, 1),
                    fontWeight: FontWeight.bold),
              ),
              backgroundColor: Color.fromRGBO(241, 241, 241, 1),
            ),
            body: Container(
              color: Color.fromRGBO(241, 241, 241, 1),
              child: Center(
                child: Text(
                  errorMessage,
                  style: TextStyle(color: Colors.black87),
                ),
              ),
            ),
          );
        } else if (snapshot.hasData) {
          // Data available state
          final List<Map<String, dynamic>> tickets = snapshot.data ?? [];
          if (tickets.isEmpty) {
            return Center(child: Text('No receipts available'));
          }
          return Scaffold(
            appBar: AppBar(
              title: Text(
                "Receipts",
                style: TextStyle(
                    color: const Color.fromRGBO(39, 66, 129, 1),
                    fontWeight: FontWeight.bold),
              ),
              backgroundColor: Color.fromRGBO(241, 241, 241, 1),
            ),
            body: ListView.builder(
              itemCount: tickets.length,
              itemBuilder: (context, index) {
                final ticket = tickets[index];
                return _buildTicketReceipt(
                  context: context,
                  passengerName: ticket['passengerName'] ?? 'Unknown',
                  driverName: ticket['driverName'] ?? 'Unknown',
                  driverPhone: ticket['driverNumber'] ?? 'Unknown',
                  fromStation: ticket['fromStation'] ?? 'Unknown',
                  toStation: ticket['toStation'] ?? 'Unknown',
                  amountPaid: ticket['amountPaid']?.toString() ?? '0',
                  bookingDate: ticket['bookingDate'] ?? '',
                  tripTime: ticket['tripTime'] ?? '',
                  ticketId: ticket['id']?.toString() ?? '0',
                  tripId: ticket['tripId'] ?? 0,
                );
              },
            ),
          );
        } else {
          // Empty state
          return Scaffold(
            appBar: AppBar(
              title: Text(
                "Receipts",
                style: TextStyle(
                    color: const Color.fromRGBO(39, 66, 129, 1),
                    fontWeight: FontWeight.bold),
              ),
              backgroundColor: Color.fromRGBO(241, 241, 241, 1),
            ),
            body: Center(child: Text('No data available')),
          );
        }
      },
    );
  }

  Future<void> cancelTrip(int bookingId) async {
    final response = await http.delete(
      Uri.parse(
          'http://busspass.somee.com/api/Booking/CancelBooking/$bookingId'),
    );

    if (response.statusCode == 200) {
      setState(() {
        _message = 'Booking canceled successfully';
      });
    } else {
      setState(() {
        _message = 'Failed to cancel booking: ${response.reasonPhrase}';
      });
    }
  }

  Widget _buildTicketReceipt({
    required BuildContext context,
    required String passengerName,
    required String fromStation,
    required String toStation,
    required String amountPaid,
    required String bookingDate,
    required String ticketId,
    required int tripId,
    required tripTime,
    required driverName,
    required driverPhone,
  }) {
    DateTime TripDateTime = DateTime.parse(tripTime);
    DateTime now = DateTime.now();
    bool canCancel = now.isBefore(TripDateTime.add(Duration(hours: 12)));

    return Container(
      color: Color.fromRGBO(241, 241, 241, 1),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 0),
            _buildTicketInfo(passengerName, fromStation, toStation, amountPaid,
                bookingDate, ticketId, tripTime),
            const SizedBox(height: 20),
            Row(
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(8.0),
                    fixedSize: const Size(110, 20),
                    textStyle: const TextStyle(fontSize: 15),
                    backgroundColor: Color.fromRGBO(39, 66, 129, 1),
                    foregroundColor: Colors.white,
                    elevation: 10,
                    alignment: Alignment.center,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  onPressed: () async {
                    final qrCodeResponse = await http.post(
                      Uri.parse(
                          'http://busspass.somee.com/api/Attendance/generate-qrcodeBase64'),
                      headers: {'Content-Type': 'application/json'},
                      body: jsonEncode({
                        'passengerId': widget.passengerId,
                        'tripId': tripId,
                      }),
                    );

                    if (qrCodeResponse.statusCode == 200) {
                      String base64Image = qrCodeResponse.body.split(',')[1];
                      Uint8List qrCodeBytes = base64.decode(base64Image);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Receiptscreen(
                            price: amountPaid,
                            startingStop: fromStation,
                            endingStop: toStation,
                            driverName: driverName,
                            ticketId: ticketId,
                            bookingTime: Date().formatDate(bookingDate),
                            tripDate: Date().formatDate(tripTime),
                            qrCodeImage: Image.memory(qrCodeBytes),
                            tripId: tripId,
                            driverPhone: driverPhone,
                          ),
                        ),
                      );
                    }
                  },
                  child: const Text("View Details"),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(8.0),
                    fixedSize: const Size(110, 20),
                    textStyle: const TextStyle(fontSize: 15),
                    backgroundColor: Color.fromRGBO(39, 66, 129, 1),
                    foregroundColor: Colors.white,
                    elevation: 10,
                    alignment: Alignment.center,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  onPressed: canCancel
                      ? () async {
                          await cancelTrip(int.parse(ticketId));
                          print(now);
                          print(TripDateTime);
                          // Show a dialog or snackbar with the message
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                backgroundColor: Colors.white,
                                title: Text('Cancel Trip'),
                                content: Text(_message),
                                actions: [
                                  TextButton(
                                    child: Text('OK'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      : null, // Disable button if canCancel is false
                  child: const Text("Cancel Trip"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTicketInfo(
    String passengerName,
    String fromStation,
    String toStation,
    String amountPaid,
    String bookingDate,
    String ticketId,
    tripTime,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Color.fromRGBO(39, 66, 129, 1), width: 2),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInfoRow("Passenger Name", passengerName),
          _buildInfoRow("From Station", fromStation),
          _buildInfoRow("To Station", toStation),
          _buildInfoRow("Amount Paid", "$amountPaid£E"),
          _buildInfoRow("Booking Date", Date().formatDate(bookingDate)),
          _buildInfoRow("Trip Date", Date().formatDate(tripTime)),
          _buildInfoRow("Ticket ID", ticketId),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style:
                  const TextStyle(fontWeight: FontWeight.w400, fontSize: 16)),
          Text(value,
              style:
                  const TextStyle(fontWeight: FontWeight.w400, fontSize: 16)),
        ],
      ),
    );
  }
}
