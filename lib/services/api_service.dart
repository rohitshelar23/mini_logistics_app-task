import 'dart:math';

import '../models/delivery_service.dart';

class ApiService {
  Future<List<DeliveryService>> getDeliveryServices() async {
    await Future.delayed(
      const Duration(seconds: 1),
    );

    return [
      DeliveryService(
        name: 'Two-Wheeler',
        description: 'For small packages and quick deliveries',
        baseFare: 40,
        perKm: 10,
        icon: 'bike',
      ),
      DeliveryService(
        name: 'Mini Truck',
        description: 'Suitable for medium size packages',
        baseFare: 80,
        perKm: 15,
        icon: 'truck',
      ),
      DeliveryService(
        name: 'Pickup Truck',
        description: 'For large and heavy packages',
        baseFare: 120,
        perKm: 20,
        icon: 'pickup',
      ),
    ];
  }

  Future<Map<String, String>> assignDriver() async {
    await Future.delayed(
      const Duration(seconds: 2),
    );

    final drivers = [
      {
        'driverName': 'Amit Patil',
        'vehicleNumber': 'MH 12 AB 1234',
        'arrivalTime': '8 mins',
      },
      {
        'driverName': 'Rahul More',
        'vehicleNumber': 'MH 12 CD 5678',
        'arrivalTime': '6 mins',
      },
      {
        'driverName': 'Sagar Jadhav',
        'vehicleNumber': 'MH 12 EF 9012',
        'arrivalTime': '10 mins',
      },
      {
        'driverName': 'Akash Shinde',
        'vehicleNumber': 'MH 14 GH 3456',
        'arrivalTime': '7 mins',
      },
    ];

    final random = Random();
    return drivers[random.nextInt(drivers.length)];
  }

  Future<double> estimateDistance(
    String pickup,
    String drop,
  ) async {
    await Future.delayed(
      const Duration(seconds: 1),
    );

    // Mock distance calculation.
    // In a real application, this would come from a
    // maps/routing API using the pickup and drop locations.
    final value =
        (pickup.length + drop.length) % 20;

    return (value + 5).toDouble();
  }
}