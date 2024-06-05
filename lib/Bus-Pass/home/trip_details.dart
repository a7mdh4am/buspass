import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:buss_pass/Bus-Pass/home/widgets/trip_body.dart';
import 'package:buss_pass/Bus-Pass/home/widgets/trip_details_body.dart';

class TripDetails extends StatefulWidget {
  final TripBody? trip;
  final int toStationId;

  const TripDetails({super.key, this.trip, required this.toStationId});

  @override
  State<TripDetails> createState() => _TripDetailsState();
}

class _TripDetailsState extends State<TripDetails> {
  late List<TripDetailsBody> trips = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchTripDetails();
  }

  Future<void> fetchTripDetails() async {
    setState(() {
      isLoading = true;
    });

    String apiUrl = 'http://busspass.somee.com/api/Trip';

    try {
      var response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        List<dynamic> responseData = jsonDecode(response.body);
        setState(() {
          trips = responseData
              .map((data) => TripDetailsBody.fromJson(data))
              .where((trip) =>
                  trip.toStationId == widget.toStationId ||
                  trip.fromStationId == widget.toStationId)
              .toList();
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load trip details');
      }
    } catch (error) {
      if (kDebugMode) {
        print('Error fetching trip details: $error');
      }
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return RefreshIndicator(
      onRefresh: fetchTripDetails,
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(39, 66, 129, 1),
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(
                color: Colors.white,
              ))
            : SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 50.0),
                      child: SizedBox(
                        width: double.infinity,
                        height: screenHeight * 0.25,
                        child: Stack(
                          children: [
                            Positioned(
                              top: 20,
                              left: 15,
                              child: InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    child: const Icon(
                                      Icons.arrow_back_ios,
                                      color: Colors.white,
                                      size: 25,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Center(
                              child: Text(
                                widget.trip?.name ?? "",
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 24,
                                  color: Color.fromRGBO(255, 255, 255, 1),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: screenWidth * 2,
                      height: trips.length < 3
                          ? screenHeight * 0.685
                          : screenHeight / 7 + (trips.length * 226.0),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50),
                        ),
                        color: Color.fromRGBO(241, 241, 241, 1),
                      ),
                      child: SizedBox(
                        child: trips.isEmpty
                            ? const Center(child: Text('No trips available'))
                            : ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount: trips.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(20),
                                    child: trips[index],
                                  );
                                },
                              ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
