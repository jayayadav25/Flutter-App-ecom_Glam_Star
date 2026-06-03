import 'package:cloud_firestore/cloud_firestore.dart';

class AddressModel {
  final String id;
  final String fullName;
  final String phone;
  final String addressLine1;
  final String addressLine2;
  final String landmark;
  final String city;
  final String state;
  final String country;
  final String zipCode;
  final bool isDefault;
  final String addressType;
  final double? latitude;
  final double? longitude;
  final DateTime createdAt;

  AddressModel({
    required this.id,
    required this.fullName,
    required this.phone,
    required this.addressLine1,
    required this.addressLine2,
    required this.landmark,
    required this.city,
    required this.state,
    required this.country,
    required this.zipCode,
    required this.isDefault,
    required this.addressType,
    required this.createdAt,
    this.latitude,
    this.longitude,
  });

  factory AddressModel.fromMap(String id, Map<String, dynamic> map,) {
    return AddressModel(
      id: id,
      fullName: map['fullName'] ?? '',
      phone: map['phone'] ?? '',
      addressLine1: map['addressLine1'] ?? '',
      addressLine2: map['addressLine2'] ?? '',
      landmark: map['landmark'] ?? '',
      city: map['city'] ?? '',
      state: map['state'] ?? '',
      country: map['country'] ?? '',
      zipCode: map['zipCode'] ?? map['pincode'] ?? '',
      isDefault: map['isDefault'] ?? false,
      addressType: map['addressType'] ?? 'Home',
      latitude: map['latitude']?.toDouble(),
      longitude: map['longitude']?.toDouble(),
      createdAt: map['createdAt']
      is Timestamp ? (map['createdAt']
      as Timestamp).toDate() : map['createdAt']
      is String ? DateTime.tryParse(map['createdAt'],) ?? DateTime.now() : DateTime.now(),
    );

  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fullName': fullName,
      'phone': phone,
      'addressLine1': addressLine1,
      'addressLine2': addressLine2,
      'landmark': landmark,
      'city': city,
      'state': state,
      'country': country,
      'zipCode': zipCode,
      'isDefault': isDefault,
      'addressType': addressType,
      'latitude': latitude,
      'longitude': longitude,
      'createdAt': createdAt,
    };
  }
}