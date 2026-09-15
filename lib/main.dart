import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'theme/app_theme.dart';
import 'screens/login_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  runApp(const QuickMoveApp());
}

class QuickMoveApp extends StatelessWidget {
  const QuickMoveApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QuickMove Logistics',
      debugShowCheckedModeBanner: false,
      theme: QuickMoveTheme.lightTheme,
      home: const LoginScreen(),
    );
  }
}

