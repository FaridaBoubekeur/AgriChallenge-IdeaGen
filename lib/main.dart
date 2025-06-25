import 'package:flutter/material.dart';
import 'screens/login.dart';
import 'screens/entretien.dart';
import 'screens/signal_screen.dart';
import 'screens/notification.dart';
import 'screens/irrigation.dart';
import 'screens/chatbot.dart';
import 'screens/collection.dart';
import 'screens/card.dart';
import 'screens/scaner.dart';
import 'screens/logo.dart';

// --- Color Palette for the App ---
class AppColors {
  static const Color scaffoldBg = Color(0xFFF8F9FA);
  static const Color darkGreen = Color(0xFF386641);
  static const Color lightGreen = Color(0xFF6A994E);
  static const Color buttonGreen =
      Color(0xFF6A994E); // Corrected signaler color
  static const Color accentYellow = Color(0xFFF2E8CF);
  static const Color primaryText = Color(0xFF212529);
  static const Color secondaryText = Color(0xFF6c757d);
  static const Color cardBg = Colors.white;
  static const Color bottomNavBg = Color(0xFFF0F3F0);
  static const Color fabColor = Color(0xFF343A40);
}

void main() => runApp(const AlHammaApp());

class AlHammaApp extends StatelessWidget {
  const AlHammaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Al Hamma Garden',
      theme: ThemeData(
        colorSchemeSeed: Colors.white,
        useMaterial3: true,
      ),
      // ---------- OPTION A ----------
      // If you simply want the other page to be the first (no “redirect” at all)
      // uncomment the next line and delete OPTION B.
      // home: const PlantListPage(),

      // ---------- OPTION B ----------
      // Feels more like a redirect: we start on an empty widget then
      // immediately push-replace the target page, so it’s the only one
      // in the back-stack.
      home: const _Redirector(),
    );
  }
}

class _Redirector extends StatefulWidget {
  const _Redirector({super.key});

  @override
  State<_Redirector> createState() => _RedirectorState();
}

class _RedirectorState extends State<_Redirector> {
  @override
  void initState() {
    super.initState();
    // Fire after the first frame so `context` is valid.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => SplashScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    // Swap this for a splash logo if you like.
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
