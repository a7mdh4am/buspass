class Driver {
  int id;
  String username;
  String fullName;
  String email;
  String phoneNumber;

  String? authToken; // Make authToken nullable

  Driver({
    required this.id,
    required this.username,
    required this.fullName,
    required this.email,
    required this.phoneNumber,
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
      'authToken': authToken, // Include authToken in JSON
    };
  }

  Driver copyWith({
    int? id,
    String? username,
    String? fullName,
    String? email,
    String? phoneNumber,
    String? authToken,
  }) {
    return Driver(
      id: id ?? this.id,
      username: username ?? this.username,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      authToken: authToken ?? this.authToken,
    );
  }
}
