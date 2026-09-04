import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../viewmodels/booking_view_model.dart';
import 'booking_detail_screen.dart';
import 'create_booking_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      final vm = context.read<BookingViewModel>();

      vm.loadServices();
      vm.loadBookings();
    });
  }

  void _onBottomNavTap(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 1) {
      context.read<BookingViewModel>().loadBookings();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _selectedIndex == 0
              ? 'QuickMove'
              : _selectedIndex == 1
                  ? 'My Bookings'
                  : 'Profile',
        ),
      ),

      body: IndexedStack(
        index: _selectedIndex,
        children: [
          _buildHomeTab(),
          _buildBookingsTab(),
          _buildProfileTab(),
        ],
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onBottomNavTap,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long_outlined),
            activeIcon: Icon(Icons.receipt_long),
            label: 'Bookings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget _buildHomeTab() {
    return Consumer<BookingViewModel>(
      builder: (context, viewModel, child) {
        if (viewModel.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (viewModel.errorMessage != null &&
            viewModel.services.isEmpty) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                viewModel.errorMessage!,
                textAlign: TextAlign.center,
              ),
            ),
          );
        }

        if (viewModel.services.isEmpty) {
          return const Center(
            child: Text(
              'No delivery services available',
            ),
          );
        }

        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Text(
              'Delivery Services',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              'Choose a vehicle for your delivery',
            ),

            const SizedBox(height: 20),

            ...viewModel.services.map(
              (service) {
                return Card(
                  margin: const EdgeInsets.only(
                    bottom: 14,
                  ),
                  child: ListTile(
                    contentPadding:
                        const EdgeInsets.all(16),
                    leading: CircleAvatar(
                      radius: 28,
                      child: Icon(
                        service.name == 'Two-Wheeler'
                            ? Icons.two_wheeler
                            : service.name ==
                                    'Pickup Truck'
                                ? Icons.fire_truck
                                : Icons.local_shipping,
                      ),
                    ),
                    title: Text(
                      service.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Padding(
                      padding:
                          const EdgeInsets.only(top: 8),
                      child: Text(
                        '${service.description}\nFrom ₹${service.baseFare.toInt()}',
                      ),
                    ),
                    isThreeLine: true,
                  ),
                );
              },
            ),

            const SizedBox(height: 15),

            SizedBox(
              height: 52,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          const CreateBookingScreen(),
                    ),
                  );
                },
                icon: const Icon(Icons.add),
                label: const Text(
                  'Create New Booking',
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        );
      },
    );
  }

  Widget _buildBookingsTab() {
    return Consumer<BookingViewModel>(
      builder: (context, viewModel, child) {
        if (viewModel.bookings.isEmpty) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment:
                    MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.receipt_long_outlined,
                    size: 60,
                  ),
                  SizedBox(height: 12),
                  Text(
                    'No bookings yet',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    'Your delivery bookings will appear here.',
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: viewModel.loadBookings,
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: viewModel.bookings.length,
            itemBuilder: (context, index) {
              final booking =
                  viewModel.bookings[index];

              return Card(
                margin:
                    const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  contentPadding:
                      const EdgeInsets.all(16),
                  leading: CircleAvatar(
                    child: Icon(
                      booking.vehicleType ==
                              'Two-Wheeler'
                          ? Icons.two_wheeler
                          : booking.vehicleType ==
                                  'Pickup Truck'
                              ? Icons.fire_truck
                              : Icons.local_shipping,
                    ),
                  ),
                  title: Text(
                    booking.bookingId,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Padding(
                    padding:
                        const EdgeInsets.only(top: 8),
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${booking.pickup} → ${booking.drop}',
                          maxLines: 2,
                          overflow:
                              TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 5),
                        Text(
                          '${booking.vehicleType} • ₹${booking.fare.toStringAsFixed(0)}',
                        ),
                        const SizedBox(height: 5),
                        Text(
                          _formatDate(
                            booking.dateTime,
                          ),
                        ),
                      ],
                    ),
                  ),
                  trailing: _statusChip(
                    booking.status,
                  ),
                  isThreeLine: true,
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
          ),
        );
      },
    );
  }

  Widget _buildProfileTab() {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const SizedBox(height: 20),

        const CircleAvatar(
          radius: 45,
          child: Icon(
            Icons.person,
            size: 50,
          ),
        ),

        const SizedBox(height: 16),

        const Center(
          child: Text(
            'QuickMove User',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        const SizedBox(height: 6),

        const Center(
          child: Text(
            'Delivery made simple',
          ),
        ),

        const SizedBox(height: 30),

        Card(
          child: ListTile(
            leading: const Icon(Icons.local_shipping),
            title: const Text('QuickMove'),
            subtitle: const Text(
              'Mini logistics and delivery app',
            ),
          ),
        ),

        Card(
          child: ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text('App Version'),
            subtitle: const Text('1.0.0'),
          ),
        ),
      ],
    );
  }

  Widget _statusChip(String status) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.grey.shade200,
      ),
      child: Text(
        status,
        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  String _formatDate(String dateTime) {
    try {
      final date = DateTime.parse(dateTime);

      return DateFormat(
        'dd MMM, hh:mm a',
      ).format(date);
    } catch (e) {
      return dateTime;
    }
  }
}