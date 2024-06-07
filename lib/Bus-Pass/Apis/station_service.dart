import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:buss_pass/Bus-Pass/home/widgets/trip_body.dart';

class StationService {
  Future<List<TripBody>> fetchTrips() async {
    final response =
        await http.get(Uri.parse('http://busspass.somee.com/api/Station'));

    if (response.statusCode == 200) {
      List<TripBody> trips = [];
      var data = json.decode(response.body);

      for (var station in data) {
        TripBody trip = TripBody(
          name: station['name'],
          id: station['id'].toString(),
          location: station['location'],
        );
        trips.add(trip);
      }

      return trips;
    } else {
      throw Exception('Failed to load trips data');
    }
  }
}
