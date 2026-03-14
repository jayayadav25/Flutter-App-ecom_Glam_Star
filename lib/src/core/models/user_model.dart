import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String name;
  final String email;
  final String? profilePic;
  final String? phone;
  final DateTime? createdAt;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    this.profilePic,
    this.phone,
    this.createdAt,
  });

  factory UserModel.fromMap(Map<String, dynamic> map, String uid) {
    return UserModel(
      uid: uid,
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      profilePic: map['profilePic'],
      phone: map['phone'],
      createdAt: map['createdAt'] != null
          ? (map['createdAt'] as Timestamp).toDate()
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'profilePic': profilePic,
      'phone': phone,
      'createdAt': createdAt,
    };
  }
}
