class Driver {
  int id;
  String username;
  String fullName;
  String email;
  String phoneNumber;
  double passengerLat;
  double passengerLong;
  String? authToken; // Make authToken nullable

  Driver({
    required this.id,
    required this.username,
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.passengerLat,
    required this.passengerLong,
    this.authToken, // Optional parameter for authToken
  });

  factory Driver.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      throw ArgumentError('Invalid JSON');
    }

    return Driver(
      id: json['id'] ?? 0,
      username: json['username'] ?? '',
      fullName: json['fullName'] ?? '',
      email: json['email'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      passengerLat: json['passengerLat']?.toDoubleOrNull() ?? 0.0,
      passengerLong: json['passengerLong']?.toDoubleOrNull() ?? 0.0,
      authToken: json['authToken'], // Parse authToken from JSON
    );
  }

  static Driver empty() {
    return Driver(
      id: 0,
      username: '',
      fullName: '',
      email: '',
      phoneNumber: '',
      passengerLat: 0.0,
      passengerLong: 0.0,
      authToken: null, // Set authToken to null for empty User
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'fullName': fullName,
      'email': email,
      'phoneNumber': phoneNumber,
      'passengerLat': passengerLat,
      'passengerLong': passengerLong,
      'authToken': authToken, // Include authToken in JSON
    };
  }
}
