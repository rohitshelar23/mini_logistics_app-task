import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'otp_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _phoneController =
      TextEditingController(text: "");
  final bool _isValid = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Bar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: QuickMoveColors.accentOrange,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(Icons.local_shipping,
                            color: Colors.white, size: 20),
                      ),
                      const SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('QuickMove',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(fontWeight: FontWeight.w800)),
                          const Text('Urban Intra-City Logistics',
                              style: TextStyle(
                                  fontSize: 11,
                                  color: QuickMoveColors.textSecondary)),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: QuickMoveColors.emeraldGreenLight,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text('• Live Fleet',
                        style: TextStyle(
                            color: QuickMoveColors.emeraldGreen,
                            fontWeight: FontWeight.w700,
                            fontSize: 12)),
                  )
                ],
              ),
              const SizedBox(height: 20),

              // Hero Marketing Banner
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  color: QuickMoveColors.primaryNavy,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text('⚡ Instant Vehicle Match',
                          style: TextStyle(
                              color: Colors.white70,
                              fontSize: 11,
                              fontWeight: FontWeight.w600)),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Move anything across town in minutes',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Fast, reliable mini-trucks, three-wheelers, and parcel couriers at upfront pricing.',
                      style: TextStyle(color: Colors.white60, fontSize: 13),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        _StatItem(label: 'Pickup ETA', value: '~12 min'),
                        _StatItem(label: 'Max Payload', value: '2.5 Ton'),
                        _StatItem(label: 'Base Fare', value: '₹149'),
                      ],
                    )
                  ],
                ),
              ),

              const SizedBox(height: 28),

              // Input Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Enter your phone number',
                      style: Theme.of(context).textTheme.titleLarge),
                  const Text('OTP LOGIN',
                      style: TextStyle(
                          color: QuickMoveColors.accentOrange,
                          fontWeight: FontWeight.w700,
                          fontSize: 11)),
                ],
              ),
              const SizedBox(height: 6),
              Text('We\'ll send a 6-digit one-time passcode for secure access.',
                  style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: 16),

              Container(
                decoration: BoxDecoration(
                  color: QuickMoveColors.surfaceSubtle,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: _isValid
                        ? QuickMoveColors.borderLight
                        : Colors.redAccent,
                  ),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Row(
                  children: [
                    const Text('🇮🇳 +91',
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 15)),
                    const SizedBox(width: 8),
                    const Text('|',
                        style: TextStyle(color: QuickMoveColors.borderLight)),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        maxLength: 10,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          counterText: '',
                          hintText: 'Enter 10-digit number',
                        ),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: QuickMoveColors.emeraldGreenLight,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: const [
                    Icon(Icons.check_circle,
                        color: QuickMoveColors.emeraldGreen, size: 16),
                    SizedBox(width: 8),
                    Text('Valid mobile format. Ready for fast OTP.',
                        style: TextStyle(
                            color: QuickMoveColors.emeraldGreen,
                            fontSize: 12,
                            fontWeight: FontWeight.w600)),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // Submit CTA
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          OtpScreen(phoneNumber: _phoneController.text),
                    ),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text('Get OTP & Continue'),
                    SizedBox(width: 8),
                    Icon(Icons.arrow_forward_rounded, size: 20),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              const Center(
                child: Text('INTERNAL DEMO BUILD v1.4.0',
                    style: TextStyle(
                        fontSize: 11,
                        color: QuickMoveColors.textMuted,
                        letterSpacing: 1)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String label;
  final String value;
  const _StatItem({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(value,
            style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: 16)),
        Text(label,
            style: const TextStyle(color: Colors.white54, fontSize: 11)),
      ],
    );
  }
}
