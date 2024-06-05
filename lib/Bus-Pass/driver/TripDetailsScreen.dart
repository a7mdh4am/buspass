import 'package:buss_pass/Bus-Pass/driver/TripAttendanceScreen.dart';
import 'package:flutter/material.dart';
import 'package:buss_pass/Bus-Pass/driver/editTrip.dart';
import 'package:buss_pass/Bus-Pass/driver/AttendanceScanPage.dart';
import 'package:buss_pass/Bus-Pass/model/trip_model.dart';
import 'package:buss_pass/Bus-Pass/services/deleteTrip.dart';
import 'package:buss_pass/Bus-Pass/profile/widgets/dateForrmat.dart';

class TripDetailsScreen extends StatelessWidget {
  final Trip trip;

  const TripDetailsScreen({Key? key, required this.trip}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color.fromRGBO(241, 241, 241, 1),
      appBar: AppBar(
        title: const Text('Trip Details'),
        backgroundColor: const Color.fromRGBO(241, 241, 241, 1),
        titleTextStyle: const TextStyle(
          color: Color.fromRGBO(39, 66, 129, 1),
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Trip ID: ${trip.id}',
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Text(
                'Start Station: ${trip.fromStationId}',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 8),
              Text(
                'End Station: ${trip.toStationId}',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 8),
              Text(
                'Available Seats: ${trip.availableSeats}',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 8),
              Text(
                'Starts At: ${Date().formatDate(trip.departureTime.toString())}',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 8),
              Text(
                'Price: ${trip.price}',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 50),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditTripPage(trip: trip),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(8.0),
                  minimumSize: Size(screenWidth * 0.5, 50),
                  textStyle: const TextStyle(fontSize: 18),
                  backgroundColor: const Color.fromRGBO(39, 66, 129, 1),
                  foregroundColor: Colors.white,
                  elevation: 15,
                  alignment: Alignment.center,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: const Text('Edit Trip'),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TripAttendanceScreen(
                        trip: trip,
                        tripId: trip.id,
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(8.0),
                  minimumSize: Size(screenWidth * 0.5, 50),
                  textStyle: const TextStyle(fontSize: 18),
                  backgroundColor: const Color.fromRGBO(39, 66, 129, 1),
                  foregroundColor: Colors.white,
                  elevation: 15,
                  alignment: Alignment.center,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: const Text('Trip Attendance'),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AttendancePage(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(8.0),
                  minimumSize: Size(screenWidth * 0.5, 50),
                  textStyle: const TextStyle(fontSize: 18),
                  backgroundColor: const Color.fromRGBO(39, 66, 129, 1),
                  foregroundColor: Colors.white,
                  elevation: 15,
                  alignment: Alignment.center,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: const Text('Apply Attendance'),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () async {
                  final bool? deleteConfirmed = await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text("Delete Trip"),
                        content:
                            const Text("Are you sure you want to delete trip?"),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context, false);
                            },
                            child: const Text("Cancel"),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context, true);
                            },
                            child: const Text("Delete"),
                          ),
                        ],
                      );
                    },
                  );
                  if (deleteConfirmed ?? false) {
                    await DeleteTrip().deleteTrip(trip.id.toString());
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Trip Deleted!')),
                    );
                    Navigator.pop(context);
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(8.0),
                  minimumSize: Size(screenWidth * 0.5, 50),
                  textStyle: const TextStyle(fontSize: 18),
                  backgroundColor: const Color.fromRGBO(39, 66, 129, 1),
                  foregroundColor: Colors.white,
                  elevation: 15,
                  alignment: Alignment.center,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: const Text('Delete Trip'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
