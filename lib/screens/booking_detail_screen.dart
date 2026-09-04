import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/booking.dart';
import '../viewmodels/booking_view_model.dart';

class BookingDetailScreen extends StatelessWidget {
  final Booking booking;

  const BookingDetailScreen({
    super.key,
    required this.booking,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking Details'),
      ),
      body: Consumer<BookingViewModel>(
        builder: (context, vm, child) {
          Booking currentBooking = booking;

          // Get the latest version of this booking
          // from SQLite through the ViewModel.
          for (final item in vm.bookings) {
            if (item.bookingId == booking.bookingId) {
              currentBooking = item;
              break;
            }
          }

          final statuses = [
            'Searching for Driver',
            'Driver Assigned',
            'Picked Up',
            'Delivered',
          ];

          final currentIndex =
              statuses.indexOf(currentBooking.status);

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Booking ID
                Text(
                  'Booking ID',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 14,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  currentBooking.bookingId,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 24),

                // Trip Details
                const Text(
                  'Trip Details',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.location_on,
                              size: 22,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Pickup',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    currentBooking.pickup,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 20),

                        Row(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.flag,
                              size: 22,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Drop',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    currentBooking.drop,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Vehicle and package details
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        _detailRow(
                          'Vehicle',
                          currentBooking.vehicleType,
                        ),

                        const Divider(),

                        _detailRow(
                          'Package',
                          currentBooking.packageDescription,
                        ),

                        const Divider(),

                        _detailRow(
                          'Fare',
                          '₹${currentBooking.fare.toStringAsFixed(0)}',
                        ),

                        const Divider(),

                        _detailRow(
                          'Date & Time',
                          currentBooking.dateTime,
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // Booking Status
                const Text(
                  'Booking Status',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 12),

                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: List.generate(
                        statuses.length,
                        (index) {
                          final isCompleted =
                              index <= currentIndex;

                          final isCurrent =
                              index == currentIndex;

                          return Row(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  CircleAvatar(
                                    radius: 14,
                                    child: Icon(
                                      isCompleted
                                          ? Icons.check
                                          : Icons.circle_outlined,
                                      size: 16,
                                    ),
                                  ),

                                  if (index !=
                                      statuses.length - 1)
                                    const SizedBox(
                                      width: 2,
                                      height: 40,
                                    ),
                                ],
                              ),

                              const SizedBox(width: 12),

                              Expanded(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(
                                    top: 4,
                                  ),
                                  child: Text(
                                    statuses[index],
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: isCurrent
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // Driver Details
                const Text(
                  'Driver Details',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                Card(
                  child: ListTile(
                    leading: const CircleAvatar(
                      child: Icon(Icons.person),
                    ),
                    title: Text(
                      currentBooking.status ==
                              'Searching for Driver'
                          ? 'Searching for driver...'
                          : currentBooking.driverName,
                    ),
                    subtitle: Text(
                      currentBooking.status ==
                              'Searching for Driver'
                          ? 'Please wait while we find a driver'
                          : '${currentBooking.vehicleNumber}\n'
                              'ETA: ${currentBooking.arrivalTime}',
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // Searching state
                if (currentBooking.status ==
                    'Searching for Driver')
                  const Center(
                    child: Column(
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(height: 12),
                        Text(
                          'Finding a driver...',
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  )

                // Update status button
                else if (currentBooking.status != 'Delivered')
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        final nextStatus =
                            vm.getNextStatus(
                          currentBooking.status,
                        );

                        await vm.updateStatus(
                          currentBooking.bookingId,
                          nextStatus,
                        );
                      },
                      child: Text(
                        'Update Status → '
                        '${vm.getNextStatus(currentBooking.status)}',
                      ),
                    ),
                  )

                // Delivered state
                else
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.grey.shade300,
                      ),
                    ),
                    child: const Row(
                      mainAxisAlignment:
                          MainAxisAlignment.center,
                      children: [
                        Icon(Icons.check_circle),
                        SizedBox(width: 8),
                        Text(
                          'Delivery Completed',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _detailRow(
    String title,
    String value,
  ) {
    return Row(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 90,
          child: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          child: Text(value),
        ),
      ],
    );
  }
}