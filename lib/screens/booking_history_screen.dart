import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../models/booking.dart';
import '../viewmodels/booking_view_model.dart';
import 'booking_detail_screen.dart';

class BookingHistoryScreen extends StatefulWidget {
  const BookingHistoryScreen({super.key});

  @override
  State<BookingHistoryScreen> createState() =>
      _BookingHistoryScreenState();
}

class _BookingHistoryScreenState
    extends State<BookingHistoryScreen> {
@override
void initState() {
  super.initState();

  WidgetsBinding.instance.addPostFrameCallback((_) {
    if (!mounted) return;

    context.read<BookingViewModel>().loadBookings();
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking History'),
      ),

      body: Consumer<BookingViewModel>(
        builder: (context, vm, child) {
          if (vm.bookings.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.history,
                    size: 60,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 15),
                  Text(
                    'No bookings found',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: vm.bookings.length,
            itemBuilder: (context, index) {
              final Booking booking = vm.bookings[index];

              DateTime date;

              try {
                date = DateTime.parse(
                  booking.dateTime,
                );
              } catch (_) {
                date = DateTime.now();
              }

              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(15),
                  leading: const CircleAvatar(
                    child: Icon(Icons.local_shipping),
                  ),
                  title: Text(
                    booking.bookingId,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      '${booking.vehicleType}\n'
                      '${booking.pickup} → ${booking.drop}\n'
                      '${DateFormat('dd MMM, hh:mm a').format(date)}',
                    ),
                  ),
                  isThreeLine: true,
                  trailing: Column(
                    mainAxisAlignment:
                        MainAxisAlignment.center,
                    crossAxisAlignment:
                        CrossAxisAlignment.end,
                    children: [
                      Text(
                        '₹${booking.fare.toStringAsFixed(0)}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        booking.status,
                        style: const TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            BookingDetailScreen(
                          booking: booking,
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
