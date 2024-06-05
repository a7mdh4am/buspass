import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:buss_pass/Bus-Pass/Apis/receipts_service.dart';
import 'package:buss_pass/Bus-Pass/home/widgets/ReceiptScreen.dart';
import 'package:buss_pass/Bus-Pass/profile/widgets/dateForrmat.dart';
import 'package:flutter/material.dart';

class ReceiptsScreen extends StatelessWidget {
  final int passengerId;

  const ReceiptsScreen({
    Key? key,
    required this.passengerId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: ReceiptService.getReceiptsByPassengerId(passengerId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            backgroundColor: Color.fromRGBO(241, 241, 241, 1),
            appBar: AppBar(
              title: const Text(
                "Receipts",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Color.fromRGBO(39, 66, 129, 1),
                ),
              ),
              backgroundColor: Color.fromRGBO(241, 241, 241, 1),
            ),
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          final List<Map<String, dynamic>> tickets = snapshot.data!;
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                "Receipts",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Color.fromRGBO(39, 66, 129, 1),
                ),
              ),
              backgroundColor: Color.fromRGBO(241, 241, 241, 1),
            ),
            body: ListView.builder(
              reverse: true,
              itemCount: tickets.length,
              itemBuilder: (context, index) {
                final ticket = tickets[index];
                return _buildTicketReceipt(
                  context: context,
                  passengerName: ticket['passengerName'],
                  fromStation: ticket['fromStation'],
                  toStation: ticket['toStationStation'],
                  amountPaid: ticket['amountPaid'].toString(),
                  bookingDate: ticket['bookingDate'],
                  ticketId: ticket['id'].toString(),
                  tripId: ticket['tripId'],
                );
              },
            ),
          );
        } else {
          return const Center(child: Text('No data available'));
        }
      },
    );
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
  }) {
    return Container(
      color: Color.fromRGBO(241, 241, 241, 1),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 0),
            _buildTicketInfo(passengerName, fromStation, toStation, amountPaid,
                bookingDate, ticketId),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(8.0),
                fixedSize: const Size(110, 20),
                textStyle: const TextStyle(
                  fontSize: 15,
                ),
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
                    'passengerId': passengerId,
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
                        driverName: 'driverName',
                        ticketId: ticketId,
                        bookingTime: Date().formatDate(bookingDate),
                        qrCodeImage: Image.memory(qrCodeBytes),
                        tripId: tripId,
                      ),
                    ),
                  );
                }
              },
              child: const Text("View Details"),
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
