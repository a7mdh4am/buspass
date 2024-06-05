class Station {
  final int id;
  final String name;
  final String location;
  final double stationLat;
  final double stationLong;

  Station({
    required this.id,
    required this.name,
    required this.location,
    required this.stationLat,
    required this.stationLong,
  });

  factory Station.fromJson(Map<String, dynamic> json) {
    return Station(
      id: json['id'] as int,
      name: json['name'] as String,
      location: json['location'] as String,
      stationLat: (json['stationLat'] as num).toDouble(),
      stationLong: (json['stationLong'] as num).toDouble(),
    );
  }
}
