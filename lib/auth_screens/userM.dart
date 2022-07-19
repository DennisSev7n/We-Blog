import 'package:firebase_auth/firebase_auth.dart';

class User {
  String username, user_id, email;
  User({required this.username, required this.user_id, required this.email});
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        username: json['username'],
        user_id: json['user_id'],
        email: json['email']);
  }
}