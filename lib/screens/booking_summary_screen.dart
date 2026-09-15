import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'live_tracking_screen.dart';

class BookingSummaryScreen extends StatelessWidget {
  const BookingSummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking Summary',
            style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Corridor banner
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: QuickMoveColors.primaryNavy,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('• LIVE FAST CORRIDOR',
                      style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w700)),
                  Text('8.4 km • 28 min',
                      style: TextStyle(color: Colors.white70, fontSize: 11, fontWeight: FontWeight.w600)),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Route Card
            _SummarySectionCard(
              title: 'Transit Route',
              badge: 'DIRECT EXPRESS',
              children: const [
                _SummaryLocationItem(
                  isPickup: true,
                  name: 'Flat 402, Prestige Ferns, Bellandur',
                  contact: 'Rahul Sharma (Sender) • +91 98765 43210',
                ),
                SizedBox(height: 12),
                _SummaryLocationItem(
                  isPickup: false,
                  name: 'Shop 12, Koramangala 5th Block',
                  contact: 'Amit Verma (Receiver) • +91 98112 33445',
                ),
              ],
            ),
            const SizedBox(height: 14),

            // Vehicle & Freight Card
            _SummarySectionCard(
              title: 'Vehicle & Freight',
              badge: '750 kg Max',
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text('Mini Truck (Tata Ace)',
                        style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
                    Text('KA 01 EK 8832',
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: QuickMoveColors.textSecondary)),
                  ],
                ),
                const SizedBox(height: 4),
                const Text('Household / Furniture • 2 cartons, 1 study desk, 1 chair',
                    style: TextStyle(fontSize: 12, color: QuickMoveColors.textSecondary)),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: QuickMoveColors.accentOrangeLight,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('1 Driver Helper Included',
                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: QuickMoveColors.accentOrangeDark)),
                      Text('+₹150',
                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: QuickMoveColors.accentOrangeDark)),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(height: 14),

            // Fare Breakdown
            _SummarySectionCard(
              title: 'Fare Estimate',
              badge: 'Guaranteed Price',
              children: const [
                _FareLine(label: 'Base Fare (First 2.0 km)', amount: '₹199'),
                _FareLine(label: 'Distance Fee (6.4 km @ ₹18/km)', amount: '₹115'),
                _FareLine(label: 'Loading Assistant (1 Person)', amount: '₹150'),
                _FareLine(label: 'Platform & Cargo Safety Shield', amount: '₹15'),
                _FareLine(label: 'Taxes & GST (5%)', amount: '₹24'),
                Divider(height: 20),
                _FareLine(label: 'Subtotal', amount: '₹503', isBold: true),
                _FareLine(label: 'Discount (QUICK50 applied)', amount: '-₹50', isDiscount: true),
                Divider(height: 20),
                _FareLine(label: 'Total Amount Payable', amount: '₹453', isGrandTotal: true),
              ],
            ),
            const SizedBox(height: 14),

            // Payment Methods
            _SummarySectionCard(
              title: 'Payment Method',
              badge: 'Change',
              children: [
                _PaymentOption(
                  icon: Icons.account_balance_wallet,
                  title: 'UPI (Google Pay / PhonePe)',
                  subtitle: 'Instant zero-touch confirmation',
                  isSelected: true,
                ),
                const SizedBox(height: 8),
                _PaymentOption(
                  icon: Icons.money,
                  title: 'Pay on Delivery (Cash / UPI)',
                  subtitle: 'Handover settlement with driver',
                  isSelected: false,
                ),
              ],
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
        child: Row(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('FINAL PAYABLE',
                    style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: QuickMoveColors.textMuted)),
                Text('₹453',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: QuickMoveColors.primaryNavy)),
              ],
            ),
            const SizedBox(width: 16),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LiveTrackingScreen()),
                  );
                },
                child: const Text('Confirm & Dispatch 🔒'),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _SummarySectionCard extends StatelessWidget {
  final String title;
  final String badge;
  final List<Widget> children;
  const _SummarySectionCard({required this.title, required this.badge, required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: QuickMoveColors.borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: QuickMoveColors.surfaceSubtle,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(badge,
                    style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: QuickMoveColors.textSecondary)),
              )
            ],
          ),
          const SizedBox(height: 12),
          ...children,
        ],
      ),
    );
  }
}

class _SummaryLocationItem extends StatelessWidget {
  final bool isPickup;
  final String name;
  final String contact;
  const _SummaryLocationItem({required this.isPickup, required this.name, required this.contact});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          isPickup ? Icons.radio_button_checked : Icons.location_on,
          color: isPickup ? QuickMoveColors.emeraldGreen : QuickMoveColors.accentOrange,
          size: 18,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13)),
              Text(contact, style: const TextStyle(fontSize: 11, color: QuickMoveColors.textSecondary)),
            ],
          ),
        )
      ],
    );
  }
}

class _FareLine extends StatelessWidget {
  final String label;
  final String amount;
  final bool isBold;
  final bool isDiscount;
  final bool isGrandTotal;

  const _FareLine({
    required this.label,
    required this.amount,
    this.isBold = false,
    this.isDiscount = false,
    this.isGrandTotal = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: TextStyle(
                fontSize: isGrandTotal ? 14 : 12,
                fontWeight: (isBold || isGrandTotal) ? FontWeight.w700 : FontWeight.w400,
                color: isDiscount ? QuickMoveColors.accentOrange : QuickMoveColors.textPrimary,
              )),
          Text(amount,
              style: TextStyle(
                fontSize: isGrandTotal ? 16 : 12,
                fontWeight: (isBold || isGrandTotal) ? FontWeight.w800 : FontWeight.w600,
                color: isDiscount
                    ? QuickMoveColors.accentOrange
                    : (isGrandTotal ? QuickMoveColors.primaryNavy : QuickMoveColors.textPrimary),
              )),
        ],
      ),
    );
  }
}

class _PaymentOption extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool isSelected;

  const _PaymentOption({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isSelected ? QuickMoveColors.surfaceContainer : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isSelected ? QuickMoveColors.accentOrange : QuickMoveColors.borderLight,
        ),
      ),
      child: Row(
        children: [
          Icon(icon, color: QuickMoveColors.primaryNavy, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13)),
                Text(subtitle, style: const TextStyle(fontSize: 11, color: QuickMoveColors.textSecondary)),
              ],
            ),
          ),
          Icon(
            isSelected ? Icons.check_circle : Icons.circle_outlined,
            color: isSelected ? QuickMoveColors.accentOrange : QuickMoveColors.textMuted,
            size: 20,
          )
        ],
      ),
    );
  }
}
