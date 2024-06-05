// trip.dart

class Trip {
  final int? id;
  final int? fromLongitude;
  final int? fromLatitude;
  final int? fromStationId;
  final String? fromStationName;
  final int? toStationId;
  final String? toStationName;
  final DateTime? departureTime;
  final int? availableSeats;
  final double? price;
  final int? driverId;
  final String? driverName;
  final String? busPlate;
  final String? lineCode;

  Trip({
    required this.id,
    required this.fromLongitude,
    required this.fromLatitude,
    required this.fromStationId,
    required this.fromStationName,
    required this.toStationId,
    required this.toStationName,
    required this.departureTime,
    required this.availableSeats,
    required this.price,
    required this.driverId,
    required this.driverName,
    required this.busPlate,
    required this.lineCode,
  });

  factory Trip.fromJson(Map<String, dynamic> json) {
    return Trip(
      id: json['id'],
      fromLongitude: json['fromLongitude'],
      fromLatitude: json['fromLatitude'],
      fromStationId: json['fromStationId'],
      fromStationName: json['fromStationName'],
      toStationId: json['toStationId'],
      toStationName: json['toStationName'],
      departureTime: DateTime.parse(json['departureTime']),
      availableSeats: json['availableSeats'],
      price: json['price'].toDouble(),
      driverId: json['driverId'],
      driverName: json['driverName'],
      busPlate: json['busPlate'],
      lineCode: json['lineCode'],
    );
  }
}
