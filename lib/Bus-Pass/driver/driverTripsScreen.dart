import 'package:buss_pass/Bus-Pass/providers/driver_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/trip_provider.dart';

class DriverTripsScreen extends StatelessWidget {
  const DriverTripsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final driverProvider = Provider.of<DriverProvider>(context);
    final tripProvider = Provider.of<TripProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Driver Trips'),
      ),
      body: FutureBuilder(
        future: tripProvider.fetchTripsByDriverId(driverProvider.driver.id),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error fetching trips'));
          } else {
            return ListView.builder(
              itemCount: tripProvider.trips.length,
              itemBuilder: (ctx, index) {
                final trip = tripProvider.trips[index];
                return Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    title: Text(trip.id.toString()),
                    subtitle: Text(
                        'Departure: ${trip.departureTime}\nArrival: ${trip.departureTime}\nAvailable Seats: ${trip.availableSeats}\nPrice: ${trip.price}\nStart Station: ${trip.fromStationId}\nEnd Station: ${trip.toStationId}'),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
