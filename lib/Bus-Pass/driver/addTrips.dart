import 'package:buss_pass/Bus-Pass/Apis/station_service.dart';
import 'package:buss_pass/Bus-Pass/profile/widgets/dateForrmat.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';
import '../providers/driver_provider.dart';
import 'package:buss_pass/Bus-Pass/home/widgets/trip_body.dart';

class AddTripPage extends StatefulWidget {
  const AddTripPage({super.key});

  @override
  _AddTripPageState createState() => _AddTripPageState();
}

class _AddTripPageState extends State<AddTripPage> {
  final _formKey = GlobalKey<FormState>();
  int fromStationId = 0;
  int toStationId = 0;
  DateTime? departureTime;
  int availableSeats = 0;
  double price = 0.0;
  List<TripBody> trips = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchTrips();
  }

  Future<void> _fetchTrips() async {
    try {
      final stationService = StationService();
      final fetchedTrips = await stationService.fetchTrips();
      setState(() {
        trips = fetchedTrips;
        isLoading = false;
      });
    } catch (error) {
      _showErrorDialog('An error occurred!', 'Failed to load stations data.');
    }
  }

  InputDecoration _inputDecoration(String labelText) {
    return InputDecoration(
      labelText: labelText,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: const BorderSide(
          color: Colors.grey,
          width: 1.0,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: const BorderSide(
          color: Color.fromRGBO(39, 66, 129, 1),
          width: 2.0,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: const BorderSide(
          color: Colors.red,
          width: 2.0,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: const BorderSide(
          color: Colors.red,
          width: 2.0,
        ),
      ),
    );
  }

  Future<void> _submitData() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();

    try {
      final driverProvider =
          Provider.of<DriverProvider>(context, listen: false);
      final url = Uri.parse('http://busspass.somee.com/api/Trip');
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          "fromStationId": fromStationId,
          "toStationId": toStationId,
          "departureTime": departureTime?.toIso8601String(),
          "availableSeats": availableSeats,
          "price": price,
          "driverId": driverProvider.driver.id,
          "busPlate": driverProvider.driver.email,
        }),
      );

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Trip added successfully!')),
        );
        //Navigator.pop(context);
      } else {
        throw Exception('Failed to add the trip.');
      }
    } catch (error) {
      _showErrorDialog(
          'An error occurred!', 'Failed to add the trip. Please try again.');
    }
  }

  void _showErrorDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: const Text('Okay'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          ),
        ],
      ),
    );
  }

  Future<void> _pickDateTime() async {
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );

    if (date != null) {
      TimeOfDay? time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(DateTime.now()),
      );

      if (time != null) {
        setState(() {
          departureTime =
              DateTime(date.year, date.month, date.day, time.hour, time.minute);
        });
      }
    }
  }

  Widget _buildTextFormField({
    required String label,
    required Function(String?) onSaved,
    required String? Function(String?)? validator,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      decoration: _inputDecoration(label),
      keyboardType: keyboardType,
      onSaved: onSaved,
      validator: validator,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(241, 241, 241, 1),
      appBar: AppBar(
          leading: null,
          title: const Text('Add Trip'),
          titleTextStyle: const TextStyle(
            color: Color.fromRGBO(39, 66, 129, 1),
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
          backgroundColor: const Color.fromRGBO(241, 241, 241, 1)),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    DropdownButtonFormField<int>(
                      decoration: _inputDecoration('From Station'),
                      items: trips.map((trip) {
                        return DropdownMenuItem<int>(
                          value: int.parse(trip.id!),
                          child: Text(trip.name!),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          fromStationId = value!;
                        });
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'Please select a station';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    DropdownButtonFormField<int>(
                      decoration: _inputDecoration('To Station'),
                      items: trips.map((trip) {
                        return DropdownMenuItem<int>(
                          value: int.parse(trip.id!),
                          child: Text(trip.name!),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          toStationId = value!;
                        });
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'Please select a station';
                        }
                        if (value == fromStationId) {
                          return 'From and To stations cannot be the same';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    _buildTextFormField(
                      label: 'Available Seats',
                      keyboardType: TextInputType.number,
                      onSaved: (value) => availableSeats = int.parse(value!),
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            int.tryParse(value) == null ||
                            int.parse(value) <= 0) {
                          return 'Please enter the number of available seats';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    _buildTextFormField(
                      label: 'Price',
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      onSaved: (value) => price = double.parse(value!),
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            double.tryParse(value) == null ||
                            double.parse(value) < 0) {
                          return 'Please enter a valid price';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    ListTile(
                      title: Text(departureTime == null
                          ? 'Choose Trip Date'
                          : 'Date: ${Date().formatDate(departureTime.toString())}'),
                      trailing: const Icon(Icons.calendar_today),
                      onTap: _pickDateTime,
                    ),
                    const SizedBox(height: 30),
                    Row(
                      children: [
                        const SizedBox(width: 80),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(8.0),
                            fixedSize: const Size(200.0, 50),
                            textStyle: const TextStyle(fontSize: 18),
                            backgroundColor:
                                const Color.fromRGBO(39, 66, 129, 1),
                            foregroundColor: Colors.white,
                            elevation: 15,
                            alignment: Alignment.center,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          onPressed: _submitData,
                          child: const Text('Create Trip'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
