import 'package:buss_pass/Bus-Pass/home/widgets/ComfirmationTripScreen.dart';
import 'package:buss_pass/Bus-Pass/home/widgets/ticket_paint.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TripDetailsBody extends StatelessWidget {
  final String? driverName;
  final String? driverPhone;
  final String? date;
  final int? price;
  final int? toStationId;
  final String? toStationName;
  final int? fromStationId;
  final String? fromStationName;
  final int? ID;
  final int? seats;

  const TripDetailsBody({
    super.key,
    required this.driverName,
    required this.date,
    required this.price,
    required this.toStationId,
    required this.fromStationId,
    required this.ID,
    required this.seats,
    this.toStationName,
    this.fromStationName,
    this.driverPhone,
  });

  factory TripDetailsBody.fromJson(Map<String, dynamic> json) {
    return TripDetailsBody(
      key: UniqueKey(),
      driverName: json['driverName'] as String?,
      driverPhone: json['driverPhone'] as String ?? '',
      date: json['departureTime'] as String?,
      toStationName: json['toStationName'] as String?,
      fromStationName: json['fromStationName'] as String?,
      price: json['price']?.toInt(),
      toStationId: json['toStationId']?.toInt(),
      fromStationId: json['fromStationId']?.toInt(),
      ID: json['id']?.toInt(),
      seats: json['availableSeats']?.toInt(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ComfirmationTripScreen(
              tripDetailsBodies: this,
            ),
          ),
        );
      },
      child: Stack(
        children: [
          CustomPaint(
            painter: TicketPainter(),
            child: Container(
              padding: const EdgeInsets.all(19.0),
              margin: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    driverName!,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24.0,
                      color: Color.fromRGBO(0, 0, 0, 1),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      const Icon(Icons.location_on),
                      const SizedBox(width: 10),
                      Text(
                        fromStationName!,
                        style: const TextStyle(
                          fontSize: 18.0,
                          color: Color.fromRGBO(71, 85, 123, 1),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      const Icon(Icons.my_location),
                      const SizedBox(width: 10),
                      Text(
                        toStationName!,
                        style: const TextStyle(
                          fontSize: 18.0,
                          color: Color.fromRGBO(71, 85, 123, 1),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            right: 15,
            top: 40,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  DateFormat('dd MMM ').format(DateTime.parse(date!)),
                  style: const TextStyle(
                    fontSize: 18.0,
                    color: Colors.black,
                  ),
                ),
                Text(
                  DateFormat('hh:mm a').format(DateTime.parse(date!)),
                  style: const TextStyle(
                    fontSize: 18.0,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 3),
                Row(
                  children: [
                    const SizedBox(
                      width: 100,
                    ),
                    Text(
                      price.toString(),
                      style: const TextStyle(
                        fontSize: 35.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                    Column(
                      children: [
                        SizedBox(
                          height: 9,
                        ),
                        Text(
                          '£E',
                          style: const TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.event_seat_sharp),
                    const SizedBox(width: 10),
                    Text(
                      seats != null ? '$seats' : 'Unknown',
                      style: const TextStyle(
                        fontSize: 18.0,
                        color: Color.fromRGBO(71, 85, 123, 1),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
