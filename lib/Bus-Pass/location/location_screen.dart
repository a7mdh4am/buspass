import 'package:buss_pass/Bus-Pass/Apis/station_service.dart';
import 'package:flutter/material.dart';
import 'package:buss_pass/Bus-Pass/home/widgets/trip_body.dart';
import 'package:buss_pass/Bus-Pass/home/trip_details.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  List<TripBody> allTrips = [];
  List<TripBody> displayedTrips = [];
  final TextEditingController searchController = TextEditingController();
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    fetchTripsData();
  }

  Future<void> fetchTripsData() async {
    setState(() {
      isLoading = true;
      errorMessage = '';
    });

    try {
      StationService tripService = StationService();
      List<TripBody> trips = await tripService.fetchTrips();
      setState(() {
        allTrips = trips;
        displayedTrips = trips;
      });
    } catch (e) {
      setState(() {
        errorMessage = 'Error fetching trips: $e';
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void filterTrips(String query) {
    setState(() {
      if (query.isEmpty) {
        displayedTrips = allTrips;
      } else {
        displayedTrips = allTrips.where((trip) {
          final nameLower = trip.name?.toLowerCase() ?? '';
          final idLower = trip.id?.toLowerCase() ?? '';
          final queryLower = query.toLowerCase();
          return nameLower.contains(queryLower) || idLower.contains(queryLower);
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color.fromRGBO(39, 66, 129, 1),
      body: RefreshIndicator(
        onRefresh: fetchTripsData,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 70.0),
                  child: Container(
                    width: screenWidth * 0.8,
                    height: screenHeight * 0.05,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: TextField(
                      controller: searchController,
                      onChanged: filterTrips,
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration.collapsed(
                        hintText: 'Where will you go?',
                        hintStyle: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Colors.black38,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              if (isLoading)
                const Center(
                    child: CircularProgressIndicator(color: Colors.white))
              else if (errorMessage.isNotEmpty)
                Center(child: Text(errorMessage))
              else
                Container(
                  width: screenWidth,
                  height: displayedTrips.length < 4
                      ? screenHeight * 0.8
                      : screenHeight / 7 + (displayedTrips.length * 135),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50),
                    ),
                    color: Color.fromRGBO(241, 241, 241, 1),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 30.0),
                    child: displayedTrips.isEmpty
                        ? const Center(child: Text('No trips available'))
                        : Column(
                            children: [
                              ...displayedTrips.map((trip) {
                                return Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => TripDetails(
                                              trip: trip,
                                              toStationId: int.parse(trip.id!),
                                            ),
                                          ),
                                        );
                                      },
                                      child: SizedBox(
                                        width: screenWidth - 16,
                                        height: 125,
                                        child: trip,
                                      ),
                                    ),
                                    const SizedBox(
                                        height:
                                            10), // Adjust spacing between trips
                                  ],
                                );
                              }).toList(),
                              const SizedBox(
                                  height: 65), // Extra padding at the bottom
                            ],
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
