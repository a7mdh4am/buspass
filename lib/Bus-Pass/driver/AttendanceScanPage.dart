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
  bool _isProcessing = false;

  @override
  void dispose() {
    _qrViewController?.dispose();
    super.dispose();
  }

  Future<void> _applyAttendance(String qrCodeData) async {
    setState(() {
      _isProcessing = true;
    });
    try {
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
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Passenger Attended!')),
        );
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to apply attendance')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    } finally {
      setState(() {
        _isProcessing = false;
      });
      _qrViewController?.resumeCamera();
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
                  if (!_isProcessing) {
                    setState(() {
                      _qrCodeData = scanData.code!;
                    });
                    _qrViewController?.pauseCamera();
                    _applyAttendance(_qrCodeData);
                  }
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Scanned QR Code Data: $_qrCodeData'),
          ),
        ],
      ),
    );
  }
}
