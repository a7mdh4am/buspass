import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:buss_pass/Bus-Pass/home/widgets/trip_body.dart';
import 'package:buss_pass/Bus-Pass/home/widgets/trip_details_body.dart';

class TripDetailsBySearch extends StatefulWidget {
  final TripBody? trip;
  final int toStationId;
  final int fromStationId;
  final String toStationName;
  final String fromStationName;

  const TripDetailsBySearch({
    Key? key,
    this.trip,
    required this.toStationId,
    required this.fromStationId,
    required this.toStationName,
    required this.fromStationName,
  }) : super(key: key);

  @override
  State<TripDetailsBySearch> createState() => _TripDetailsBySearchState();
}

class _TripDetailsBySearchState extends State<TripDetailsBySearch> {
  late List<TripDetailsBody> trips = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchTripDetailsBySearch();
  }

  Future<void> fetchTripDetailsBySearch() async {
    setState(() {
      isLoading = true;
    });

    String apiUrl =
        'http://busspass.somee.com/api/Trip/GetTripFromStationToStation/${widget.fromStationId}/${widget.toStationId}';

    try {
      var response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        List<dynamic> responseData = jsonDecode(response.body);
        setState(() {
          trips = responseData
              .map((data) => TripDetailsBody.fromJson(data))
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
      onRefresh: fetchTripDetailsBySearch,
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(39, 66, 129, 1),
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              )
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
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 40,
                                  ),
                                  Text(
                                    widget.fromStationName,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 24,
                                      color: Color.fromRGBO(255, 255, 255, 1),
                                    ),
                                  ),
                                  const Icon(
                                    Icons
                                        .arrow_downward, // Use a valid icon from the Icons class
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                  // SizedBox(
                                  //   height: 20,
                                  // ),
                                  Text(
                                    widget.toStationName,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 24,
                                      color: Color.fromRGBO(255, 255, 255, 1),
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
                  ],
                ),
              ),
      ),
    );
  }
}
