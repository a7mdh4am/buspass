import 'dart:convert';
import 'package:buss_pass/Bus-Pass/model/trip_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TripAttendanceScreen extends StatefulWidget {
  final int? tripId;

  const TripAttendanceScreen({
    Key? key,
    required this.tripId,
    required Trip trip,
  }) : super(key: key);

  @override
  _TripAttendanceScreenState createState() => _TripAttendanceScreenState();
}

class _TripAttendanceScreenState extends State<TripAttendanceScreen> {
  List<Map<String, dynamic>> _attendanceData = [];

  @override
  void initState() {
    super.initState();
    if (widget.tripId != null) {
      fetchAttendanceData();
    }
  }

  Future<void> fetchAttendanceData() async {
    final url = Uri.parse(
        'http://busspass.somee.com/api/Attendance/trip-attendance/${widget.tripId}');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body);
      setState(() {
        _attendanceData = responseData.cast<Map<String, dynamic>>();
      });
    } else {
      throw Exception('Failed to load attendance data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(241, 241, 241, 1),
      appBar: AppBar(
        title: const Text('Trip Attendance'),
        backgroundColor: const Color.fromRGBO(241, 241, 241, 1),
        titleTextStyle: const TextStyle(
          color: Color.fromRGBO(39, 66, 129, 1),
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: _attendanceData.isEmpty
          ? Center(
              child: _attendanceData.isNotEmpty
                  ? CircularProgressIndicator()
                  : Text('No attendance data available'),
            )
          : ListView.builder(
              itemCount: _attendanceData.length,
              itemBuilder: (context, index) {
                final attendance = _attendanceData[index];
                return ListTile(
                  title:
                      Text('Passenger: ${attendance['passenger']['fullName']}'),
                  subtitle: Text('Attended at: ${attendance['attendDate']}'),
                );
              },
            ),
    );
  }
}
