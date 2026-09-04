import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/booking.dart';
import '../viewmodels/booking_view_model.dart';
import 'booking_detail_screen.dart';

class BookingSummaryScreen extends StatelessWidget {
  final String pickup;
  final String drop;
  final String packageDescription;
  final double distance;

  const BookingSummaryScreen({
    super.key,
    required this.pickup,
    required this.drop,
    required this.packageDescription,
    required this.distance,
  });

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<BookingViewModel>();
    final service = vm.selectedService;

    final fare = vm.calculateFare(distance);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking Summary'),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Review your booking',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 25),

            _row('Pickup', pickup),
            _row('Drop', drop),
            _row(
              'Vehicle',
              service?.name ?? '-',
            ),
            _row(
              'Package',
              packageDescription,
            ),
            _row(
              'Distance',
              '$distance KM',
            ),

            const Divider(height: 30),

            _row(
              'Estimated Fare',
              '₹${fare.toStringAsFixed(0)}',
              bold: true,
            ),

            const Spacer(),

            Consumer<BookingViewModel>(
              builder: (context, vm, child) {
                return SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: vm.isLoading
                        ? null
                        : () async {
                            final Booking? booking =
                                await vm.createBooking(
                              pickup: pickup,
                              drop: drop,
                              packageDescription:
                                  packageDescription,
                              distance: distance,
                            );

                            if (booking != null &&
                                context.mounted) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      BookingDetailScreen(
                                    booking: booking,
                                  ),
                                ),
                              );
                            }
                          },
                    child: vm.isLoading
                        ? const CircularProgressIndicator()
                        : const Text(
                            'Confirm Booking',
                          ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _row(
    String title,
    String value, {
    bool bold = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.grey,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontWeight:
                    bold ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
