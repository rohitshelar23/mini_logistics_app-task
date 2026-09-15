import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'login_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile',
            style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Column(
          children: [
            // User Header Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: QuickMoveColors.borderLight),
              ),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 28,
                    backgroundColor: QuickMoveColors.primaryNavy,
                    child: Icon(Icons.person, color: Colors.white, size: 30),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Text('Jayant Solao',
                                style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
                            const SizedBox(width: 6),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: QuickMoveColors.amberWarningLight,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: const Text('🏆 Gold Tier',
                                  style: TextStyle(
                                      color: QuickMoveColors.amberWarning,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w700)),
                            )
                          ],
                        ),
                        const SizedBox(height: 2),
                        const Text('+91 8010348087 • Verified',
                            style: TextStyle(fontSize: 12, color: QuickMoveColors.emeraldGreen, fontWeight: FontWeight.w600)),
                        const Text('jayant.solao@royalswebtech.com',
                            style: TextStyle(fontSize: 12, color: QuickMoveColors.textSecondary)),
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 14),

            // Metrics Row
            Row(
              children: const [
                _ProfileMetricCard(label: 'Completed Trips', value: '12'),
                SizedBox(width: 10),
                _ProfileMetricCard(label: 'Pending Dues', value: '₹0'),
                SizedBox(width: 10),
                _ProfileMetricCard(label: 'Shipper Rating', value: '4.9 ★'),
              ],
            ),
            const SizedBox(height: 14),

            // QuickMove Cash Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: QuickMoveColors.borderLight),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('QUICKMOVE CASH',
                          style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: QuickMoveColors.textMuted)),
                      Text('₹450',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: QuickMoveColors.primaryNavy)),
                    ],
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(110, 36),
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                    ),
                    onPressed: () {},
                    child: const Text('+ Add Money', style: TextStyle(fontSize: 12)),
                  )
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Settings & Preferences List
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: QuickMoveColors.borderLight),
              ),
              child: Column(
                children: const [
                  _SettingsListTile(icon: Icons.bookmark_border, title: 'Saved Locations', subtitle: '3 Saved Addresses'),
                  Divider(height: 1),
                  _SettingsListTile(icon: Icons.shield_outlined, title: 'Goods Transit Shield', subtitle: '₹50k Active Insurance'),
                  Divider(height: 1),
                  _SettingsListTile(icon: Icons.receipt_long_outlined, title: 'Business & GST Profile', subtitle: 'Input ITC Claim 18%'),
                  Divider(height: 1),
                  _SettingsListTile(icon: Icons.notifications_none, title: 'Dispatch Updates & Alerts', subtitle: 'SMS & WhatsApp'),
                  Divider(height: 1),
                  _SettingsListTile(icon: Icons.support_agent, title: 'Help & 24/7 Fleet Desk', subtitle: 'Emergency SOS & Claims'),
                  Divider(height: 1),
                  _SettingsListTile(icon: Icons.info_outline, title: 'About QuickMove', subtitle: 'v1.4.0 • Android Internal Demo'),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Sign Out CTA
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                minimumSize: const Size.fromHeight(48),
                foregroundColor: QuickMoveColors.redDanger,
                side: const BorderSide(color: QuickMoveColors.redDanger),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              ),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                  (route) => false,
                );
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.logout, size: 18),
                  SizedBox(width: 8),
                  Text('Sign Out from QuickMove', style: TextStyle(fontWeight: FontWeight.w700)),
                ],
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

class _ProfileMetricCard extends StatelessWidget {
  final String label;
  final String value;
  const _ProfileMetricCard({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: QuickMoveColors.borderLight),
        ),
        child: Column(
          children: [
            Text(value, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
            const SizedBox(height: 2),
            Text(label,
                style: const TextStyle(fontSize: 10, color: QuickMoveColors.textSecondary),
                textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}

class _SettingsListTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _SettingsListTile({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: QuickMoveColors.primaryNavy, size: 22),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13)),
      subtitle: Text(subtitle, style: const TextStyle(fontSize: 11, color: QuickMoveColors.textSecondary)),
      trailing: const Icon(Icons.arrow_forward_ios, size: 14, color: QuickMoveColors.textMuted),
      onTap: () {},
    );
  }
}
