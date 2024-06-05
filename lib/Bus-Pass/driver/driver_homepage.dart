import 'package:buss_pass/Bus-Pass/driver/TripDetailsScreen.dart';
import 'package:buss_pass/Bus-Pass/home/widgets/ticket_paint.dart';
import 'package:buss_pass/Bus-Pass/profile/widgets/dateForrmat.dart';
import 'package:buss_pass/Bus-Pass/providers/trip_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/driver_provider.dart';

class DriverScreen extends StatefulWidget {
  const DriverScreen({super.key});

  @override
  _DriverScreenState createState() => _DriverScreenState();
}

class _DriverScreenState extends State<DriverScreen> {
  late Future<void> _tripsFuture;
  String greeting = '';

  @override
  void initState() {
    super.initState();
    _setGreeting();
    _tripsFuture = _fetchTrips();
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

  Future<void> _fetchTrips() async {
    final tripProvider = Provider.of<TripProvider>(context, listen: false);
    final driverProvider = Provider.of<DriverProvider>(context, listen: false);
    await tripProvider.fetchTripsByDriverId(driverProvider.driver.id);
  }

  @override
  Widget build(BuildContext context) {
    final driverProvider = Provider.of<DriverProvider>(context);
    final tripProvider = Provider.of<TripProvider>(context);

    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;

    return RefreshIndicator(
      color: const Color.fromRGBO(39, 66, 129, 1),
      onRefresh: () {
        setState(() {
          _tripsFuture = _fetchTrips();
        });
        return _tripsFuture;
      },
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(39, 66, 129, 1),
        body: FutureBuilder(
          future: _tripsFuture,
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Loading',
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(height: 10),
                    CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              return const Center(
                child: Text(
                  'Error fetching trips!',
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
              );
            } else {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: screenHeight * 0.02),
                      child: SizedBox(
                        width: double.infinity,
                        height: screenHeight * 0.25,
                        child: Stack(
                          children: [
                            Positioned(
                              top: screenHeight * 0.1,
                              left: screenWidth * 0.1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    greeting,
                                    style: TextStyle(
                                      fontSize: screenWidth * 0.05,
                                      color: Colors.white70,
                                    ),
                                  ),
                                  Text(
                                    '${driverProvider.driver.fullName}!',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: screenWidth * 0.08,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(bottom: screenHeight * 0.1),
                      decoration: const BoxDecoration(
                        color: Color.fromRGBO(241, 241, 241, 1),
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(50),
                          topLeft: Radius.circular(50),
                        ),
                      ),
                      child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: tripProvider.trips.length,
                        itemBuilder: (ctx, index) {
                          final trip = tripProvider.trips[index];
                          return Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: screenHeight * 0.025,
                              horizontal: screenWidth * 0.05,
                            ),
                            child: GestureDetector(
                              onTap: () async {
                                bool shouldRefresh = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        TripDetailsScreen(trip: trip),
                                  ),
                                );
                                if (shouldRefresh == true) {
                                  setState(() {
                                    _tripsFuture = _fetchTrips();
                                  });
                                }
                              },
                              child: CustomPaint(
                                painter: TicketPainter(),
                                child: Container(
                                  margin: EdgeInsets.all(screenWidth * 0.02),
                                  padding: EdgeInsets.all(screenWidth * 0.003),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                                height: screenHeight * 0.01),
                                            Text(
                                              'From',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: screenWidth * 0.04,
                                              ),
                                            ),
                                            Text(
                                              trip.fromStationName!,
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontWeight: FontWeight.bold,
                                                fontSize: screenWidth * 0.04,
                                              ),
                                            ),
                                            SizedBox(
                                                height: screenHeight * 0.01),
                                            Text(
                                              'To',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: screenWidth * 0.04,
                                              ),
                                            ),
                                            Text(
                                              trip.toStationName.toString(),
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontWeight: FontWeight.bold,
                                                fontSize: screenWidth * 0.04,
                                              ),
                                            ),
                                            SizedBox(
                                                height: screenHeight * 0.01),
                                            Row(
                                              children: [
                                                Text(
                                                  'Available Seats ',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize:
                                                        screenWidth * 0.04,
                                                  ),
                                                ),
                                                Text(
                                                  trip.availableSeats
                                                      .toString(),
                                                  style: TextStyle(
                                                    color: Colors.red,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize:
                                                        screenWidth * 0.04,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                                height: screenHeight * 0.01),
                                            Row(
                                              children: [
                                                Text(
                                                  'Starts AT ',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize:
                                                        screenWidth * 0.04,
                                                  ),
                                                ),
                                                Text(
                                                  Date().formatDate(trip
                                                      .departureTime
                                                      .toString()),
                                                  style: TextStyle(
                                                    color: Colors.red,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize:
                                                        screenWidth * 0.04,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(width: screenWidth * 0.1),
                                      Column(
                                        children: [
                                          SizedBox(height: screenHeight * 0.04),
                                          const Text('TicketID'),
                                          Text(
                                            trip.id.toString(),
                                            style: TextStyle(
                                              fontSize: screenWidth * 0.12,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.red,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        width: screenWidth * 0.06,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
