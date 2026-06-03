class OrderRequestModel {
  final String userId;
  final List<Map<String, dynamic>> items;
  final Map<String, dynamic> address;
  final String paymentMethod;
  final double total;

  OrderRequestModel({
    required this.userId,
    required this.items,
    required this.address,
    required this.paymentMethod,
    required this.total,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'items': items,
      'address': address,
      'paymentMethod': paymentMethod,
      'total': total,
    };
  }
}