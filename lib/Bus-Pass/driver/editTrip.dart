import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:buss_pass/Bus-Pass/model/trip_model.dart';
import 'package:buss_pass/Bus-Pass/profile/widgets/dateForrmat.dart';

class EditTripPage extends StatefulWidget {
  final Trip trip;

  const EditTripPage({super.key, required this.trip});

  @override
  _EditTripPageState createState() => _EditTripPageState();
}

class _EditTripPageState extends State<EditTripPage> {
  final _formKey = GlobalKey<FormState>();
  late int fromStationId;
  late int toStationId;
  DateTime? departureTime;
  late int availableSeats;
  late double price;

  @override
  void initState() {
    super.initState();
    fromStationId = widget.trip.fromStationId!;
    toStationId = widget.trip.toStationId!;
    departureTime = widget.trip.departureTime;
    availableSeats = widget.trip.availableSeats!;
    price = widget.trip.price!;
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
    try {
      final url =
          Uri.parse('http://busspass.somee.com/api/Trip/${widget.trip.id}');
      final response = await http.put(
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
        }),
      );

      if (response.statusCode == 204) {
        Navigator.pop(context);
      } else {
        throw Exception('Failed to update the trip.');
      }
    } catch (error) {
      _showErrorDialog(
          'An error occurred!', 'Failed to update the trip. Please try again.');
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
      initialDate: departureTime ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );

    if (date != null) {
      TimeOfDay? time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(departureTime ?? DateTime.now()),
      );

      if (time != null) {
        setState(() {
          departureTime =
              DateTime(date.year, date.month, date.day, time.hour, time.minute);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(241, 241, 241, 1),
      appBar: AppBar(
        title: const Text('Edit Trip'),
        titleTextStyle: const TextStyle(
          color: Color.fromRGBO(39, 66, 129, 1),
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
        backgroundColor: const Color.fromRGBO(241, 241, 241, 1),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                initialValue: fromStationId.toString(),
                decoration: _inputDecoration('From Station ID'),
                keyboardType: TextInputType.number,
                onSaved: (value) => fromStationId = int.parse(value!),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a valid station ID';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                initialValue: toStationId.toString(),
                decoration: _inputDecoration('To Station ID'),
                keyboardType: TextInputType.number,
                onSaved: (value) => toStationId = int.parse(value!),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a valid station ID';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                initialValue: availableSeats.toString(),
                decoration: _inputDecoration('Available Seats'),
                keyboardType: TextInputType.number,
                onSaved: (value) => availableSeats = int.parse(value!),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the number of available seats';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                initialValue: price.toString(),
                decoration: _inputDecoration('Price'),
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                onSaved: (value) => price = double.parse(value!),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a price';
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
                      backgroundColor: const Color.fromRGBO(39, 66, 129, 1),
                      foregroundColor: Colors.white,
                      elevation: 15,
                      alignment: Alignment.center,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        _submitData();
                      }
                    },
                    child: const Text('Update Trip'),
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
