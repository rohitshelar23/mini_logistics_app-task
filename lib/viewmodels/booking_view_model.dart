import 'package:flutter/material.dart';

import '../database/database_helper.dart';
import '../models/booking.dart';
import '../models/delivery_service.dart';
import '../services/api_service.dart';

class BookingViewModel extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  final DatabaseHelper _database = DatabaseHelper();

  List<DeliveryService> services = [];
  List<Booking> bookings = [];

  bool isLoading = false;
  String? errorMessage;

  DeliveryService? selectedService;

  // Load available delivery services
  Future<void> loadServices() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      services = await _apiService.getDeliveryServices();
    } catch (e) {
      errorMessage = 'Unable to load delivery services';
    }

    isLoading = false;
    notifyListeners();
  }

  // Load booking history from database
  Future<void> loadBookings() async {
    try {
      bookings = await _database.getBookings();
      notifyListeners();
    } catch (e) {
      errorMessage = 'Unable to load booking history';
      notifyListeners();
    }
  }

  // Select vehicle
  void selectService(DeliveryService service) {
    selectedService = service;
    notifyListeners();
  }

  // Calculate estimated fare
  double calculateFare(double distance) {
    if (selectedService == null) {
      return 0;
    }

    return selectedService!.baseFare +
        (selectedService!.perKm * distance);
  }

  // Create a new booking
  Future<Booking?> createBooking({
    required String pickup,
    required String drop,
    required String packageDescription,
    required double distance,
  }) async {
    if (selectedService == null) {
      errorMessage = 'Please select a vehicle';
      notifyListeners();
      return null;
    }

    try {
      final bookingId =
          'BK${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}';

      final booking = Booking(
        bookingId: bookingId,
        vehicleType: selectedService!.name,
        pickup: pickup,
        drop: drop,
        packageDescription: packageDescription,
        fare: calculateFare(distance),
        status: 'Searching for Driver',
        driverName: 'Finding driver...',
        vehicleNumber: '---',
        arrivalTime: 'Calculating...',
        dateTime: DateTime.now().toString(),
      );

      // Save booking immediately with searching status
      await _database.insertBooking(booking);

      // Refresh history
      await loadBookings();

      // Start driver assignment in background
      _assignDriver(booking);

      return booking;
    } catch (e) {
      errorMessage = 'Unable to create booking';
      notifyListeners();

      return null;
    }
  }

  // Simulate driver assignment
  Future<void> _assignDriver(Booking booking) async {
    try {
      // Keep "Searching for Driver" visible for a few seconds
      await Future.delayed(
        const Duration(seconds: 3),
      );

      // Get driver from mock API
      final driver = await _apiService.assignDriver();

      // Save driver information in SQLite
      await _database.assignDriver(
        bookingId: booking.bookingId,
        driverName: driver['driverName']!,
        vehicleNumber: driver['vehicleNumber']!,
        arrivalTime: driver['arrivalTime']!,
      );

      // Refresh booking list
      await loadBookings();
    } catch (e) {
      errorMessage = 'Unable to assign driver';
      notifyListeners();
    }
  }

  // Update booking status
  Future<void> updateStatus(
    String bookingId,
    String status,
  ) async {
    try {
      await _database.updateBookingStatus(
        bookingId,
        status,
      );

      await loadBookings();
    } catch (e) {
      errorMessage = 'Unable to update booking status';
      notifyListeners();
    }
  }

  // Get next status in the delivery flow
  String getNextStatus(String currentStatus) {
    switch (currentStatus) {
      case 'Searching for Driver':
        return 'Driver Assigned';

      case 'Driver Assigned':
        return 'Picked Up';

      case 'Picked Up':
        return 'Delivered';

      default:
        return 'Delivered';
    }
  }
}