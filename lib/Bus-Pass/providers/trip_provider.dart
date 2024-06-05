import 'package:buss_pass/Bus-Pass/model/trip_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TripProvider with ChangeNotifier {
  static const _apiUrl = 'http://busspass.somee.com/api/Trip';

  List<Trip> _trips = [];

  Future<void> fetchTrips() async {
    try {
      final response = await http.get(Uri.parse(_apiUrl));
      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body);
        _trips = responseData.map((data) => Trip.fromJson(data)).toList();
        notifyListeners();
      } else {
        throw Exception(
            'Failed to fetch trips. Status code: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Error fetching trips: $error');
    }
  }

  Future<void> fetchTripsByDriverId(int driverId) async {
    try {
      final response = await http.get(Uri.parse(_apiUrl));
      if (response.statusCode == 200) {
        final data = json.decode(response.body) as List;
        _trips = data
            .map((tripJson) => Trip.fromJson(tripJson))
            .where((trip) => trip.driverId == driverId)
            .toList();
        // notifyListeners();
      } else {
        print('object');
        throw Exception(
            'Failed to load trips. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching trips by driver ID: $error');
      throw Exception('Error fetching trips by driver ID: $error');
    }
  }

  List<Trip> get trips => _trips;
}
