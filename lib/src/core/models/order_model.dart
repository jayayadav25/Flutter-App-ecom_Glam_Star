class OrderModel {
  final String id;
  final String userId;
  final double totalAmount;
  final String status;
  final String deliveryStatus;
  final String paymentMethod;
  final DateTime createdAt;
  final Map<String, dynamic> address;
  final List<Map<String, dynamic>> items;

  OrderModel({
    required this.id,
    required this.userId,
    required this.totalAmount,
    required this.status,
    required this.deliveryStatus,
    required this.paymentMethod,
    required this.createdAt,
    required this.address,
    required this.items,
  });

  factory OrderModel.fromMap(Map<String, dynamic> map, String id) {
    return OrderModel(
      id: id,
      userId: map['userId']?.toString() ?? '',
      totalAmount: (map['totalAmount'] ?? 0).toDouble(),
      status: map['status']?.toString() ?? 'Placed',
      deliveryStatus:
      map['deliveryStatus']?.toString() ?? 'Placed',
      paymentMethod:
      map['paymentMethod']?.toString() ?? 'Cash on Delivery',
      createdAt: map['createdAt'] != null
          ? (map['createdAt'] as dynamic).toDate()
          : DateTime.now(),
      address: Map<String, dynamic>.from(map['address'] ?? {}),
      items: List<Map<String, dynamic>>.from(map['items'] ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'totalAmount': totalAmount,
      'status': status,
      'deliveryStatus': deliveryStatus,
      'paymentMethod': paymentMethod,
      'createdAt': createdAt,
      'address': address,
      'items': items,
    };
  }
}
