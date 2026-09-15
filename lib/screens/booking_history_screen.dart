import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../models/app_models.dart';
import 'live_tracking_screen.dart';

class BookingHistoryScreen extends StatefulWidget {
  const BookingHistoryScreen({super.key});

  @override
  State<BookingHistoryScreen> createState() => _BookingHistoryScreenState();
}

class _BookingHistoryScreenState extends State<BookingHistoryScreen> {
  int _tabIndex = 0;

  final List<BookingItem> _bookings = const [
    BookingItem(
      id: '#QM-89241',
      title: 'Priority Haul',
      vehicleName: 'Tata Ace (750 kg)',
      vehicleNumber: 'KA 01 AH 4492',
      pickupAddress: 'Bellandur EcoSpace Gate 2',
      dropAddress: 'Koramangala 4th Block, 80ft Road',
      itemsDescription: 'Office Furniture (2 Desks)',
      amount: 410,
      dateTime: 'Live In-Transit',
      status: 'Active',
      eta: 'ETA 14 Mins',
    ),
    BookingItem(
      id: '#QM-88102',
      title: 'Standard Freight',
      vehicleName: 'Tata Ace Mini Truck',
      vehicleNumber: 'KA 04 EX 8821',
      pickupAddress: 'HSR Layout Sector 2',
      dropAddress: 'Indiranagar 100ft Road',
      itemsDescription: '2 Items • Dining Table & 4 Chairs',
      amount: 342,
      dateTime: 'Yesterday, 14 Oct • 4:20 PM',
      status: 'Delivered',
    ),
    BookingItem(
      id: '#QM-87430',
      title: 'Fast Courier',
      vehicleName: 'Two-Wheeler Bike',
      vehicleNumber: 'KA 03 HM 2901',
      pickupAddress: 'Whitefield Main Rd, ITPL',
      dropAddress: 'Marathahalli Bridge Junction',
      itemsDescription: 'Urgent Legal Document Envelope',
      amount: 89,
      dateTime: '10 Oct • 11:15 AM',
      status: 'Delivered',
    ),
    BookingItem(
      id: '#QM-86915',
      title: 'Cargo Delivery',
      vehicleName: 'Tata Ace',
      vehicleNumber: 'KA 05 MN 1102',
      pickupAddress: 'Peenya Industrial Area Stage 2',
      dropAddress: 'Electronic City Phase 1 Logistics Hub',
      itemsDescription: 'Hardware components & tools',
      amount: 620,
      dateTime: '04 Oct • 09:30 AM',
      status: 'Cancelled',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking History',
            style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          // Filter Tabs
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                _FilterTab(title: 'All', count: 12, isSelected: _tabIndex == 0, onTap: () => setState(() => _tabIndex = 0)),
                _FilterTab(title: 'Active', count: 1, isSelected: _tabIndex == 1, onTap: () => setState(() => _tabIndex = 1)),
                _FilterTab(title: 'Completed', count: 8, isSelected: _tabIndex == 2, onTap: () => setState(() => _tabIndex = 2)),
                _FilterTab(title: 'Cancelled', count: 3, isSelected: _tabIndex == 3, onTap: () => setState(() => _tabIndex = 3)),
              ],
            ),
          ),
          const SizedBox(height: 8),

          // Booking List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              itemCount: _bookings.length,
              itemBuilder: (context, index) {
                final item = _bookings[index];
                return _BookingCard(item: item);
              },
            ),
          )
        ],
      ),
    );
  }
}

class _FilterTab extends StatelessWidget {
  final String title;
  final int count;
  final bool isSelected;
  final VoidCallback onTap;

  const _FilterTab({
    required this.title,
    required this.count,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? QuickMoveColors.primaryNavy : QuickMoveColors.surfaceWhite,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? QuickMoveColors.primaryNavy : QuickMoveColors.borderLight,
          ),
        ),
        child: Row(
          children: [
            Text(title,
                style: TextStyle(
                  color: isSelected ? Colors.white : QuickMoveColors.textPrimary,
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                )),
            const SizedBox(width: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: isSelected ? QuickMoveColors.accentOrange : QuickMoveColors.surfaceSubtle,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text('$count',
                  style: TextStyle(
                    color: isSelected ? Colors.white : QuickMoveColors.textSecondary,
                    fontWeight: FontWeight.w700,
                    fontSize: 11,
                  )),
            )
          ],
        ),
      ),
    );
  }
}

class _BookingCard extends StatelessWidget {
  final BookingItem item;
  const _BookingCard({required this.item});

  @override
  Widget build(BuildContext context) {
    final bool isActive = item.status == 'Active';
    final bool isCancelled = item.status == 'Cancelled';

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: isActive ? QuickMoveColors.accentOrange : QuickMoveColors.borderLight,
          width: isActive ? 1.5 : 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('${item.id} • ${item.vehicleName}',
                  style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: isActive
                      ? QuickMoveColors.accentOrangeLight
                      : (isCancelled ? QuickMoveColors.redDangerLight : QuickMoveColors.emeraldGreenLight),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  isActive ? (item.eta ?? 'Live') : item.status,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: isActive
                        ? QuickMoveColors.accentOrangeDark
                        : (isCancelled ? QuickMoveColors.redDanger : QuickMoveColors.emeraldGreen),
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Icon(Icons.circle, color: QuickMoveColors.emeraldGreen, size: 10),
              const SizedBox(width: 8),
              Expanded(
                child: Text(item.pickupAddress,
                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                    overflow: TextOverflow.ellipsis),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              const Icon(Icons.circle, color: QuickMoveColors.accentOrange, size: 10),
              const SizedBox(width: 8),
              Expanded(
                child: Text(item.dropAddress,
                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                    overflow: TextOverflow.ellipsis),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.itemsDescription,
                      style: const TextStyle(fontSize: 11, color: QuickMoveColors.textSecondary)),
                  Text('₹${item.amount}',
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w800, color: QuickMoveColors.primaryNavy)),
                ],
              ),
              if (isActive)
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(120, 36),
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const LiveTrackingScreen()),
                    );
                  },
                  child: const Text('Track Live →', style: TextStyle(fontSize: 12)),
                )
              else
                OutlinedButton(
                  onPressed: () {},
                  child: const Text('Re-book', style: TextStyle(fontSize: 12)),
                ),
            ],
          )
        ],
      ),
    );
  }
}