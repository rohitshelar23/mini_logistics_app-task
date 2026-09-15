import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'booking_summary_screen.dart';

class CreateBookingScreen extends StatefulWidget {
  const CreateBookingScreen({super.key});

  @override
  State<CreateBookingScreen> createState() => _CreateBookingScreenState();
}

class _CreateBookingScreenState extends State<CreateBookingScreen> {
  int _selectedVehicleIndex = 1; // Mini truck selected
  bool _loadingHelper = true;
  String _selectedCategory = 'Household / Furniture';

  final List<String> _categories = [
    'Household / Furniture',
    'Electronics / Appliances',
    'Cartons & Bags',
    'Commercial Freight'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking Create',
            style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: QuickMoveColors.surfaceSubtle,
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Text('BLR',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12)),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('STEP 1 OF 2',
                style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                    color: QuickMoveColors.accentOrange)),
            Text('Trip & Goods Details',
                style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 22)),
            const SizedBox(height: 16),

            // Route Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: QuickMoveColors.borderLight),
              ),
              child: Column(
                children: [
                  _AddressRow(
                    isPickup: true,
                    title: 'Flat 402, Prestige Ferns, Bellandur',
                    subTitle: 'Rahul (Self) • 98765 43210',
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Divider(),
                  ),
                  _AddressRow(
                    isPickup: false,
                    title: 'Shop 12, 1st Cross, Koramangala 5th Block',
                    subTitle: 'Amit Verma • 98112 33445',
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: QuickMoveColors.surfaceContainer,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Row(
                          children: [
                            Icon(Icons.navigation, size: 16, color: QuickMoveColors.accentOrange),
                            SizedBox(width: 8),
                            Text('8.4 km • 28 mins via Outer Ring Rd',
                                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12)),
                          ],
                        ),
                        Text('View Route',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: QuickMoveColors.accentOrange)),
                      ],
                    ),
                  )
                ],
              ),
            ),

            const SizedBox(height: 24),
            Text('Select Logistics Vehicle', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 12),

            // Vehicle Options
            _SelectVehicleTile(
              title: '2-Wheeler',
              payload: '20 kg',
              price: '₹120',
              eta: '4 mins',
              isSelected: _selectedVehicleIndex == 0,
              onTap: () => setState(() => _selectedVehicleIndex = 0),
            ),
            _SelectVehicleTile(
              title: 'Mini Truck (Tata Ace)',
              payload: '750 kg',
              price: '₹385',
              eta: '6 mins',
              isRecommended: true,
              isSelected: _selectedVehicleIndex == 1,
              onTap: () => setState(() => _selectedVehicleIndex = 1),
            ),
            _SelectVehicleTile(
              title: '8ft Pickup',
              payload: '1200 kg',
              price: '₹620',
              eta: '12 mins',
              isSelected: _selectedVehicleIndex == 2,
              onTap: () => setState(() => _selectedVehicleIndex = 2),
            ),

            const SizedBox(height: 20),
            Text('Goods Category', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              children: _categories.map((cat) {
                final isSel = _selectedCategory == cat;
                return ChoiceChip(
                  label: Text(cat),
                  selected: isSel,
                  onSelected: (selected) => setState(() => _selectedCategory = cat),
                  selectedColor: QuickMoveColors.primaryNavy,
                  labelStyle: TextStyle(
                    color: isSel ? Colors.white : QuickMoveColors.textPrimary,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 16),
            // Driver Loading Helper Add-on
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: QuickMoveColors.borderLight),
              ),
              child: Row(
                children: [
                  const Icon(Icons.handshake_outlined, color: QuickMoveColors.accentOrange),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Driver Loading Helper (+₹150)',
                            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
                        Text('Helper assists driver with loading & ground transit',
                            style: TextStyle(fontSize: 11, color: QuickMoveColors.textSecondary)),
                      ],
                    ),
                  ),
                  Switch(
                    value: _loadingHelper,
                    activeColor: QuickMoveColors.accentOrange,
                    onChanged: (val) => setState(() => _loadingHelper = val),
                  )
                ],
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: QuickMoveColors.borderLight)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text('ESTIMATED FARE',
                    style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: QuickMoveColors.textMuted)),
                Text('Tolls & GST incl.',
                    style: TextStyle(fontSize: 11, color: QuickMoveColors.emeraldGreen, fontWeight: FontWeight.w700)),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text('₹535',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: QuickMoveColors.primaryNavy)),
                Text('(₹385 + ₹150 Helper)',
                    style: TextStyle(fontSize: 12, color: QuickMoveColors.textSecondary)),
              ],
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const BookingSummaryScreen()),
                );
              },
              child: const Text('Review Booking →'),
            )
          ],
        ),
      ),
    );
  }
}

class _AddressRow extends StatelessWidget {
  final bool isPickup;
  final String title;
  final String subTitle;
  const _AddressRow({required this.isPickup, required this.title, required this.subTitle});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          isPickup ? Icons.radio_button_checked : Icons.location_on,
          color: isPickup ? QuickMoveColors.emeraldGreen : QuickMoveColors.accentOrange,
          size: 20,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(isPickup ? 'PICKUP ADDRESS' : 'DROP ADDRESS',
                  style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: QuickMoveColors.textMuted)),
              Text(title, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13)),
              Text(subTitle, style: const TextStyle(fontSize: 11, color: QuickMoveColors.textSecondary)),
            ],
          ),
        ),
        const Text('Change',
            style: TextStyle(color: QuickMoveColors.accentOrange, fontWeight: FontWeight.w700, fontSize: 12)),
      ],
    );
  }
}

class _SelectVehicleTile extends StatelessWidget {
  final String title;
  final String payload;
  final String price;
  final String eta;
  final bool isSelected;
  final bool isRecommended;
  final VoidCallback onTap;

  const _SelectVehicleTile({
    required this.title,
    required this.payload,
    required this.price,
    required this.eta,
    required this.isSelected,
    this.isRecommended = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? QuickMoveColors.accentOrange : QuickMoveColors.borderLight,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(title, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
                      if (isRecommended) ...[
                        const SizedBox(width: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: QuickMoveColors.accentOrangeLight,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: const Text('RECOMMENDED',
                              style: TextStyle(
                                  color: QuickMoveColors.accentOrangeDark,
                                  fontSize: 9,
                                  fontWeight: FontWeight.w800)),
                        )
                      ]
                    ],
                  ),
                  Text('Capacity: $payload • ETA: $eta',
                      style: const TextStyle(fontSize: 12, color: QuickMoveColors.textSecondary)),
                ],
              ),
            ),
            Text(price,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: QuickMoveColors.primaryNavy)),
            const SizedBox(width: 10),
            Icon(
              isSelected ? Icons.check_circle : Icons.circle_outlined,
              color: isSelected ? QuickMoveColors.accentOrange : QuickMoveColors.borderLight,
            )
          ],
        ),
      ),
    );
  }
}