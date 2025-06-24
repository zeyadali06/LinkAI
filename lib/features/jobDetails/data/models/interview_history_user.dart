class User {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String mobileNumber;
  final String username;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.mobileNumber,
    required this.username,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? json['_id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      mobileNumber: json['mobileNumber'],
      username: json['username'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'mobileNumber': mobileNumber,
      'username': username,
    };
  }
}
