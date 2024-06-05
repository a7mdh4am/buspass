class User {
  int id;
  String username;
  String fullName;
  String email;
  String phoneNumber;
  double passengerLat;
  double passengerLong;
  String? authToken;

  User({
    required this.id,
    required this.username,
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.passengerLat,
    required this.passengerLong,
    this.authToken,
  });

  factory User.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      throw ArgumentError('Invalid JSON');
    }

    return User(
      id: json['id'] ?? 0,
      username: json['username'] ?? '',
      fullName: json['fullName'] ?? '',
      email: json['email'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      passengerLat: json['passengerLat']?.toDoubleOrNull() ?? 0.0,
      passengerLong: json['passengerLong']?.toDoubleOrNull() ?? 0.0,
      authToken: json['authToken'],
    );
  }

  static User empty() {
    return User(
      id: 0,
      username: '',
      fullName: '',
      email: '',
      phoneNumber: '',
      passengerLat: 0.0,
      passengerLong: 0.0,
      authToken: null,
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
      'authToken': authToken,
    };
  }

  User copyWith({
    int? id,
    String? username,
    String? fullName,
    String? email,
    String? phoneNumber,
    double? passengerLat,
    double? passengerLong,
    String? authToken,
  }) {
    return User(
      id: id ?? this.id,
      username: username ?? this.username,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      passengerLat: passengerLat ?? this.passengerLat,
      passengerLong: passengerLong ?? this.passengerLong,
      authToken: authToken ?? this.authToken,
    );
  }
}
