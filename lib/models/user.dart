import 'dart:convert';

class User {
  final String fullname;
  final String username;
  final String email;
  final String password;
  final String token;
  final String type;
  final String id;
  final String pin;
  User({
    required this.fullname,
    required this.username,
    required this.email,
    required this.password,
    required this.token,
    required this.type,
    required this.id,
    required this.pin,
  });

  Map<String, dynamic> toMap() {
    return {
      'fullname': fullname,
      'username': username,
      'email': email,
      'password': password,
      'token': token,
      'type': type,
      'id': id,
      'pin': pin,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      fullname: map['fullname'] ?? '',
      username: map['username'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      token: map['token'] ?? '',
      type: map['type'] ?? '',
      id: map['_id'] ?? '',
      pin: map['pin'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));
}
