import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'home_screen.dart';

class LiveTrackingScreen extends StatelessWidget {
  const LiveTrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tracking',
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
              color: QuickMoveColors.redDangerLight,
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Row(
              children: [
                Icon(Icons.emergency, color: QuickMoveColors.redDanger, size: 14),
                SizedBox(width: 4),
                Text('SOS',
                    style: TextStyle(
                        color: QuickMoveColors.redDanger,
                        fontWeight: FontWeight.w800,
                        fontSize: 11)),
              ],
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Column(
          children: [
            // Map Container Simulation
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.blue.shade100),
              ),
              child: Stack(
                children: [
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.map, size: 48, color: Colors.blue),
                        SizedBox(height: 6),
                        Text('Live GPS Route Telemetry',
                            style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w700, fontSize: 12)),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 12,
                    left: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.navigation, color: QuickMoveColors.accentOrange, size: 14),
                          SizedBox(width: 6),
                          Text('Arriving in 4 mins (1.4 km)',
                              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 11)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Start Trip PIN Card
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: QuickMoveColors.primaryNavy,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('START TRIP PIN',
                          style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: Colors.white60)),
                      Text('Share with driver upon arrival',
                          style: TextStyle(fontSize: 11, color: Colors.white70)),
                    ],
                  ),
                  Text('6842',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 2,
                          color: QuickMoveColors.accentOrange)),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Timeline Progress
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: QuickMoveColors.borderLight),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('Delivery Progress',
                      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
                  SizedBox(height: 12),
                  _TimelineNode(
                    title: 'Searching for Driver',
                    subtitle: 'Matched optimal fleet partner',
                    time: '09:38 AM',
                    isDone: true,
                  ),
                  _TimelineNode(
                    title: 'Driver Assigned',
                    subtitle: 'Heading toward your pickup bay (4 mins)',
                    time: '09:41 AM',
                    isActive: true,
                  ),
                  _TimelineNode(
                    title: 'Goods Picked Up',
                    subtitle: 'Driver verifies quantity & ties down cargo',
                    time: 'Pending OTP',
                  ),
                  _TimelineNode(
                    title: 'Goods Delivered',
                    subtitle: 'Recipient signature & photo confirmation',
                    time: '--:--',
                    isLast: true,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),

            // Driver Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: QuickMoveColors.borderLight),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 22,
                        backgroundColor: QuickMoveColors.primaryNavy,
                        child: Icon(Icons.person, color: Colors.white),
                      ),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Ramesh Kumar ★ 4.89',
                                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
                            Text('Tata Ace • White • KA-04-EX-8821',
                                style: TextStyle(fontSize: 12, color: QuickMoveColors.textSecondary)),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.call, color: QuickMoveColors.emeraldGreen),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.chat_bubble_outline, color: QuickMoveColors.primaryNavy),
                      ),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                  (route) => false,
                );
              },
              child: const Text('Back to Home Dashboard',
                  style: TextStyle(color: QuickMoveColors.textSecondary, fontWeight: FontWeight.w700)),
            )
          ],
        ),
      ),
    );
  }
}

class _TimelineNode extends StatelessWidget {
  final String title;
  final String subtitle;
  final String time;
  final bool isDone;
  final bool isActive;
  final bool isLast;

  const _TimelineNode({
    required this.title,
    required this.subtitle,
    required this.time,
    this.isDone = false,
    this.isActive = false,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    Color iconColor = QuickMoveColors.textMuted;
    if (isDone) iconColor = QuickMoveColors.emeraldGreen;
    if (isActive) iconColor = QuickMoveColors.accentOrange;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Icon(
              isDone ? Icons.check_circle : (isActive ? Icons.radio_button_checked : Icons.circle_outlined),
              color: iconColor,
              size: 18,
            ),
            if (!isLast)
              Container(
                width: 2,
                height: 32,
                color: isDone ? QuickMoveColors.emeraldGreen : QuickMoveColors.borderLight,
              ),
          ],
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(title,
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 13,
                          color: isActive ? QuickMoveColors.accentOrange : QuickMoveColors.textPrimary)),
                  Text(time,
                      style: const TextStyle(fontSize: 11, color: QuickMoveColors.textSecondary)),
                ],
              ),
              Text(subtitle,
                  style: const TextStyle(fontSize: 11, color: QuickMoveColors.textSecondary)),
              const SizedBox(height: 8),
            ],
          ),
        )
      ],
    );
  }
}
