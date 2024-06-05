import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:http/http.dart' as http;

class AttendancePage extends StatefulWidget {
  @override
  _AttendancePageState createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  final GlobalKey _qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? _qrViewController;
  String _qrCodeData = '';

  @override
  void dispose() {
    _qrViewController?.dispose();
    super.dispose();
  }

  Future<void> _applyAttendance(String qrCodeData) async {
    var data = qrCodeData.split('_');
    var passengerId = int.parse(data[0].split(':')[1]);
    var tripId = int.parse(data[1].split(':')[1]);

    var apiUrl = 'http://busspass.somee.com/api/Attendance/apply-attendance';
    var response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'passengerId': passengerId, 'tripId': tripId}),
    );

    if (response.statusCode == 200) {
      // Passenger has reserved this trip
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Passenger Attended!')),
      );
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to apply attendance')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Attendance')),
      body: Column(
        children: <Widget>[
          Expanded(
            child: QRView(
              key: _qrKey,
              onQRViewCreated: (controller) {
                setState(() {
                  _qrViewController = controller;
                });
                controller.scannedDataStream.listen((scanData) {
                  setState(() {
                    _qrCodeData = scanData.code!;
                  });
                  _applyAttendance(_qrCodeData);
                });
              },
            ),
          ),
          Text('Scanned QR Code Data: $_qrCodeData'),
        ],
      ),
    );
  }
}
