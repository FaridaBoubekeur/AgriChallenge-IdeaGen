import 'dart:async';
import 'package:flutter/material.dart';
import 'entretien.dart';
import 'login.dart';

// ==========================================================
//               THE LOGO SPLASH SCREEN
// ==========================================================
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // After 2 seconds, it will navigate to the HomePage
    Timer(const Duration(seconds: 3, milliseconds: 30), () {
      // pushReplacement removes the splash screen from the navigation stack
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const LoginPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Your logo from the assets folder
            Image.asset(
              'assets/images/logo.png', // Ensure this path is correct
              height: 150,
            ),

            // Your App Name
            const Text(
              'Hamma Botanica',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 31, 133, 33),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
