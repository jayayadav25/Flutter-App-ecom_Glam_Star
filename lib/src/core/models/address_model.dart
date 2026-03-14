class AddressModel {
  final String id;
  final String name;
  final String phone;
  final String house;
  final String city;
  final String pincode;
  final bool isDefault;

  AddressModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.house,
    required this.city,
    required this.pincode,
    required this.isDefault,
  });

  factory AddressModel.fromMap(
      String id,
      Map<String, dynamic> map,
      ) {
    return AddressModel(
      id: id,
      name: map['name'] ?? '',
      phone: map['phone'] ?? '',
      house: map['house'] ?? '',
      city: map['city'] ?? '',
      pincode: map['pincode'] ?? '',
      isDefault: map['isDefault'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phone': phone,
      'house': house,
      'city': city,
      'pincode': pincode,
      'isDefault': isDefault,
    };
  }
}
