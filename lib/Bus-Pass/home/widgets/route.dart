class Route {
  final String name;
  final String departureTime;
  final String destination;

  Route({
    required this.name,
    required this.departureTime,
    required this.destination,
  });

  factory Route.fromJson(Map<String, dynamic> json) {
    return Route(
      name: json['name'],
      departureTime: json['departure_time'],
      destination: json['destination'],
    );
  }
}
