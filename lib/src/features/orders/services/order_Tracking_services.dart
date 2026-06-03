class TrackingService {

  static List<String> generateTrackingSteps(String status,) {

    final allSteps = [
      'Placed',
      'Packed',
      'Shipped',
      'Out for Delivery',
      'Delivered',
    ];

    final currentIndex = allSteps.indexOf(status);
    return allSteps.sublist(0, currentIndex + 1,);
  }
}