import 'package:buss_pass/Bus-Pass/Apis/station_service.dart';
import 'package:buss_pass/Bus-Pass/home/trip_details_by_search.dart';
import 'package:buss_pass/Bus-Pass/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:buss_pass/Bus-Pass/home/widgets/trip_body.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<TripBody> allTrips = [];
  bool isLoading = true;
  String errorMessage = '';
  int fromStationId = 0;
  int toStationId = 0;
  String fromStationName = '';
  String toStationName = '';
  String greeting = '';

  @override
  void initState() {
    super.initState();
    _setGreeting();
    fetchTripsData();
  }

  void _setGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      setState(() {
        greeting = "Good Morning,";
      });
    } else if (hour < 18) {
      setState(() {
        greeting = "Good Afternoon,";
      });
    } else {
      setState(() {
        greeting = "Good Evening,";
      });
    }
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

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final userProvider = Provider.of<UserProvider>(context);
    final user = userProvider.user;

    return Scaffold(
      backgroundColor: const Color.fromRGBO(39, 66, 129, 1),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Greeting section
            Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: SizedBox(
                width: double.infinity,
                height: 200,
                child: Stack(
                  children: [
                    Positioned(
                      top: 80,
                      left: 30,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            greeting,
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 20,
                              color: Colors.white70,
                            ),
                          ),
                          Text(
                            user.fullName,
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 24,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'Where will you go?',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 20,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Positioned(
                      top: 50,
                      right: 45,
                      child: CircleAvatar(
                        backgroundImage: AssetImage('assets/images/avatar.jpg'),
                        radius: 30,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
            if (isLoading)
              const Center(
                  child: CircularProgressIndicator(color: Colors.white))
            else if (errorMessage.isNotEmpty)
              Center(
                  child: Text(errorMessage,
                      style: const TextStyle(color: Colors.white)))
            else
              Container(
                width: screenWidth,
                height: screenHeight / 1.45,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                  color: Color.fromRGBO(241, 241, 241, 1),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      // Dropdown selection for stations
                      Container(
                        height: 200,
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(30)),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(children: [
                            SizedBox(
                              height: 18,
                            ),
                            DropdownButtonFormField<int>(
                              dropdownColor: Colors.white,
                              decoration: InputDecoration(
                                labelText: 'From',
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
                              ),
                              items: allTrips.map((trip) {
                                return DropdownMenuItem<int>(
                                  value: int.parse(trip.id!),
                                  child: Text(trip.name!),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  fromStationId = value!;
                                  fromStationName = allTrips
                                      .firstWhere((trip) =>
                                          int.parse(trip.id!) == value)
                                      .name!;
                                });
                              },
                              validator: (value) {
                                if (value == null) {
                                  return 'Please select a station';
                                }
                                if (value == toStationId) {
                                  return 'From and To stations cannot be the same';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),
                            DropdownButtonFormField<int>(
                              dropdownColor: Colors.white,
                              decoration: InputDecoration(
                                labelText: 'To',
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
                              ),
                              items: allTrips.map((trip) {
                                return DropdownMenuItem<int>(
                                  value: int.parse(trip.id!),
                                  child: Text(trip.name!),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  toStationId = value!;
                                  toStationName = allTrips
                                      .firstWhere((trip) =>
                                          int.parse(trip.id!) == value)
                                      .name!;
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
                          ]),
                        ),
                      ),
                      const SizedBox(height: 20),
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
                          if (fromStationId == 0 || toStationId == 0) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Please select both stations'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          } else {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => TripDetailsBySearch(
                                  fromStationId: fromStationId,
                                  toStationId: toStationId,
                                  fromStationName: fromStationName,
                                  toStationName: toStationName,
                                ),
                              ),
                            );
                          }
                        },
                        child: const Text('Search!'),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
