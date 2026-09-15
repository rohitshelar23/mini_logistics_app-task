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
                      const Icon(Icons.location_on,
                          color: QuickMoveColors.accentOrange, size: 22),
                      const SizedBox(width: 6),
                      Text('Bengaluru',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(fontSize: 16)),
                      const Icon(Icons.keyboard_arrow_down, size: 20),
                    ],
                  ),
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: QuickMoveColors.primaryNavy,
                    child: const Icon(Icons.person, color: Colors.white),
                  )
                ],
              ),
              const SizedBox(height: 16),

              Text('Good Evening, Jayant 👋',
                  style: Theme.of(context)
                      .textTheme
                      .displayLarge
                      ?.copyWith(fontSize: 22)),
              const Text('Nagpur, Maharashtra',
                  style: TextStyle(
                      fontSize: 13, color: QuickMoveColors.textSecondary)),
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
                          Text('Where to move goods?',
                              style: Theme.of(context).textTheme.titleMedium),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: QuickMoveColors.surfaceContainer,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Text('Instant Dispatch',
                                style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: QuickMoveColors.primaryNavy)),
                          )
                        ],
                      ),
                      const SizedBox(height: 16),
                      _LocationField(
                        icon: Icons.radio_button_checked,
                        iconColor: QuickMoveColors.emeraldGreen,
                        label: 'PICKUP POINT',
                        value: 'Green Glen Layout, Bellandur',
                      ),
                      const Divider(height: 24),
                      _LocationField(
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
                                    const CreateBookingScreen()),
                          );
                        },
                        child: const Text('Book a Delivery Now from ₹49'),
                      )
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Choose Your Fleet',
                      style: Theme.of(context).textTheme.titleLarge),
                  const Text('FASTEST ETA',
                      style: TextStyle(
                          color: QuickMoveColors.accentOrange,
                          fontWeight: FontWeight.w700,
                          fontSize: 11)),
                ],
              ),
              const SizedBox(height: 12),

              // Available Vehicles
              ...kAvailableVehicles
                  .map((vehicle) => _VehicleListCard(vehicle: vehicle)),

              const SizedBox(height: 16),
              // Recent Booking Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Recent Booking',
                      style: Theme.of(context).textTheme.titleLarge),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const BookingHistoryScreen()),
                      );
                    },
                    child: const Text('View All',
                        style: TextStyle(
                            color: QuickMoveColors.accentOrange,
                            fontWeight: FontWeight.w700)),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              _RecentBookingSummaryCard(),
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
                  builder: (context) => const BookingHistoryScreen()),
            );
          } else if (idx == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ProfileScreen()),
            );
          }
        },
        destinations: const [
          NavigationDestination(
              icon: Icon(Icons.local_shipping_outlined), label: 'Home'),
          NavigationDestination(
              icon: Icon(Icons.inventory_2_outlined), label: 'Bookings'),
          NavigationDestination(
              icon: Icon(Icons.person_outline), label: 'Profile'),
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
        Icon(icon, color: iconColor, size: 20),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label,
                  style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: QuickMoveColors.textMuted)),
              Text(value,
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 14)),
            ],
          ),
        ),
        const Icon(Icons.edit_outlined,
            size: 18, color: QuickMoveColors.textMuted),
      ],
    );
  }
}

class _VehicleListCard extends StatelessWidget {
  final VehicleOption vehicle;
  const _VehicleListCard({required this.vehicle});

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
                    Text(vehicle.title,
                        style: const TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 15)),
                    const SizedBox(width: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: QuickMoveColors.surfaceContainer,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(vehicle.tag,
                          style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              color: QuickMoveColors.primaryNavy)),
                    )
                  ],
                ),
                Text('${vehicle.capacity} • ${vehicle.dimensions}',
                    style: const TextStyle(
                        fontSize: 12, color: QuickMoveColors.textSecondary)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('From ₹${vehicle.basePrice}',
                  style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 15,
                      color: QuickMoveColors.primaryNavy)),
              Text('⚡ ${vehicle.etaMinutes} mins',
                  style: const TextStyle(
                      fontSize: 11,
                      color: QuickMoveColors.accentOrange,
                      fontWeight: FontWeight.w700)),
            ],
          )
        ],
      ),
    );
  }
}

class _RecentBookingSummaryCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: QuickMoveColors.borderLight),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text('Tata Ace Delivery',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
              Text('₹342',
                  style: TextStyle(fontWeight: FontWeight.w800, fontSize: 15)),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text('Delivered yesterday • 4:20 PM',
                  style: TextStyle(
                      fontSize: 12, color: QuickMoveColors.textSecondary)),
              Text('Completed',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: QuickMoveColors.emeraldGreen)),
            ],
          ),
        ],
      ),
    );
  }
}
