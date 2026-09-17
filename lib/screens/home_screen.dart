import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../models/app_models.dart';
import 'create_booking_screen.dart';
import 'booking_history_screen.dart';
import 'profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _bottomNavIndex = 0;

  String _userName = 'User';

  @override
  void initState() {
    super.initState();
    _loadUserName();
  }

  Future<void> _loadUserName() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) return;

    try {
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      if (!mounted) return;

      if (doc.exists) {
        final data = doc.data();

        setState(() {
          _userName = data?['name']?.toString() ?? 'User';
        });
      }
    } catch (e) {
      debugPrint('Error loading user name: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Location Bar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        color: QuickMoveColors.accentOrange,
                        size: 22,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'Nagpur',
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(fontSize: 16),
                      ),
                      const Icon(Icons.keyboard_arrow_down, size: 20),
                    ],
                  ),
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: QuickMoveColors.primaryNavy,
                    child: const Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Firebase user name
              Text(
                'Good Evening, $_userName 👋',
                style: Theme.of(context)
                    .textTheme
                    .displayLarge
                    ?.copyWith(fontSize: 22),
              ),

              const Text(
                'Nagpur, Maharashtra',
                style: TextStyle(
                  fontSize: 13,
                  color: QuickMoveColors.textSecondary,
                ),
              ),

              const SizedBox(height: 16),

              // Prominent Where to Move Goods Card
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Where to move goods?',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              color: QuickMoveColors.surfaceContainer,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Text(
                              'Instant Dispatch',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: QuickMoveColors.primaryNavy,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),

                      const _LocationField(
                        icon: Icons.radio_button_checked,
                        iconColor: QuickMoveColors.emeraldGreen,
                        label: 'PICKUP POINT',
                        value: 'Green Glen Layout, Bellandur',
                      ),

                      const Divider(height: 24),

                      const _LocationField(
                        icon: Icons.call_made,
                        iconColor: QuickMoveColors.accentOrange,
                        label: 'DROP POINT',
                        value: 'Koramangala 4th Block, 80ft Road',
                      ),

                      const SizedBox(height: 16),

                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const CreateBookingScreen(),
                            ),
                          );
                        },
                        child: const Text(
                          'Book a Delivery Now from ₹49',
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Choose Your Fleet',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const Text(
                    'FASTEST ETA',
                    style: TextStyle(
                      color: QuickMoveColors.accentOrange,
                      fontWeight: FontWeight.w700,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // Available Vehicles
              ...kAvailableVehicles.map(
                (vehicle) => _VehicleListCard(vehicle: vehicle),
              ),

              const SizedBox(height: 16),

              // Recent Booking Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Recent Booking',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const BookingHistoryScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      'View All',
                      style: TextStyle(
                        color: QuickMoveColors.accentOrange,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              const _RecentBookingSummaryCard(),

              const SizedBox(height: 16),
            ],
          ),
        ),
      ),

      bottomNavigationBar: NavigationBar(
        selectedIndex: _bottomNavIndex,
        onDestinationSelected: (idx) {
          setState(() => _bottomNavIndex = idx);

          if (idx == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const BookingHistoryScreen(),
              ),
            );
          } else if (idx == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ProfileScreen(),
              ),
            );
          }
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.local_shipping_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.inventory_2_outlined),
            label: 'Bookings',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class _LocationField extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label;
  final String value;

  const _LocationField({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: iconColor,
          size: 20,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  color: QuickMoveColors.textMuted,
                ),
              ),
              Text(
                value,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
        const Icon(
          Icons.edit_outlined,
          size: 18,
          color: QuickMoveColors.textMuted,
        ),
      ],
    );
  }
}

class _VehicleListCard extends StatelessWidget {
  final VehicleOption vehicle;

  const _VehicleListCard({
    required this.vehicle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: vehicle.isRecommended
              ? QuickMoveColors.accentOrange
              : QuickMoveColors.borderLight,
          width: vehicle.isRecommended ? 1.5 : 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: QuickMoveColors.surfaceSubtle,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              vehicle.type == VehicleType.twoWheeler
                  ? Icons.two_wheeler
                  : Icons.local_shipping,
              color: QuickMoveColors.primaryNavy,
              size: 24,
            ),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      vehicle.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: QuickMoveColors.surfaceContainer,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        vehicle.tag,
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: QuickMoveColors.primaryNavy,
                        ),
                      ),
                    ),
                  ],
                ),

                Text(
                  '${vehicle.capacity} • ${vehicle.dimensions}',
                  style: const TextStyle(
                    fontSize: 12,
                    color: QuickMoveColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'From ₹${vehicle.basePrice}',
                style: const TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 15,
                  color: QuickMoveColors.primaryNavy,
                ),
              ),
              Text(
                '⚡ ${vehicle.etaMinutes} mins',
                style: const TextStyle(
                  fontSize: 11,
                  color: QuickMoveColors.accentOrange,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _RecentBookingSummaryCard extends StatelessWidget {
  const _RecentBookingSummaryCard();

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return const SizedBox.shrink();
    }

    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance
          .collection('bookings')
          .where('userId', isEqualTo: user.uid)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: CircularProgressIndicator(
                color: QuickMoveColors.accentOrange,
              ),
            ),
          );
        }

        if (snapshot.hasError) {
          return const Text(
            'Unable to load recent booking.',
            style: TextStyle(
              color: QuickMoveColors.textSecondary,
            ),
          );
        }

        final bookings = snapshot.data?.docs ?? [];

        if (bookings.isEmpty) {
          return Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: QuickMoveColors.borderLight,
              ),
            ),
            child: const Column(
              children: [
                Icon(
                  Icons.local_shipping_outlined,
                  size: 32,
                  color: QuickMoveColors.textMuted,
                ),
                SizedBox(height: 8),
                Text(
                  'No bookings yet',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Your recent booking will appear here.',
                  style: TextStyle(
                    fontSize: 12,
                    color: QuickMoveColors.textSecondary,
                  ),
                ),
              ],
            ),
          );
        }

        // Find the newest booking locally.
        final sortedBookings = [...bookings];

        sortedBookings.sort((a, b) {
          final aTime = a.data()['createdAt'];
          final bTime = b.data()['createdAt'];

          if (aTime is Timestamp && bTime is Timestamp) {
            return bTime.compareTo(aTime);
          }

          return 0;
        });

        final booking = sortedBookings.first.data();

        final vehicleType =
            booking['vehicleType']?.toString() ?? 'Delivery';

        final price = booking['price'];

        final status =
            booking['status']?.toString() ?? 'Pending';

        String priceText;

        if (price is num) {
          priceText = '₹${price.toStringAsFixed(0)}';
        } else {
          priceText = '₹0';
        }

        final createdAt = booking['createdAt'];

        String dateText = 'Recently';

        if (createdAt is Timestamp) {
          final date = createdAt.toDate();

          dateText =
              '${date.day}/${date.month}/${date.year} • '
              '${date.hour.toString().padLeft(2, '0')}:'
              '${date.minute.toString().padLeft(2, '0')}';
        }

        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: QuickMoveColors.borderLight,
            ),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      vehicleType,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Text(
                    priceText,
                    style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 6),

              Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      dateText,
                      style: const TextStyle(
                        fontSize: 12,
                        color:
                            QuickMoveColors.textSecondary,
                      ),
                    ),
                  ),
                  Text(
                    status,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: status.toLowerCase() ==
                              'completed'
                          ? QuickMoveColors.emeraldGreen
                          : QuickMoveColors.accentOrange,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}