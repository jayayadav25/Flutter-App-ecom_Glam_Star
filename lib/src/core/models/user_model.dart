import 'address_model.dart';

class UserModel {
  final String uid;
  final String name;
  final String email;
  final String? phone;
  final String? profileImage;
  final bool notificationsEnabled;
  final bool darkModeEnabled;
  final int loyaltyPoints;
  final bool isPremium;
  final List<AddressModel> addresses;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    this.phone,
    this.profileImage,
    required this.notificationsEnabled,
    required this.darkModeEnabled,
    required this.loyaltyPoints,
    required this.isPremium,
    required this.addresses,
  });

  factory UserModel.fromMap(Map<String, dynamic> map, String uid,) {
    return UserModel(
      uid: uid,
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'],
      profileImage: map['profileImage'],
      notificationsEnabled:
      map['notificationsEnabled'] ?? true,
      darkModeEnabled:
      map['darkModeEnabled'] ?? false,
      loyaltyPoints:
      map['loyaltyPoints'] ?? 0,
      isPremium:
      map['isPremium'] ?? false,
      addresses:
      (map['addresses'] as List<dynamic>?)?.map((e) => AddressModel.fromMap(
          e['id'] ?? '',
          Map<String, dynamic>.from(e),
        ),
      )
          .toList() ??
          [],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'profileImage': profileImage,
      'notificationsEnabled': notificationsEnabled,
      'darkModeEnabled': darkModeEnabled,
      'loyaltyPoints': loyaltyPoints,
      'isPremium': isPremium,
      'addresses': addresses.map((e) => e.toMap()).toList(),
    };
  }
}