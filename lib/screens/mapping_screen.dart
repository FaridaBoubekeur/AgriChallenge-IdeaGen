// lib/screens/mapping_screen.dart
import 'package:flutter/material.dart';
import 'dart:ui';
import '../main.dart'; // For AppColors

class MappingScreen extends StatelessWidget {
  const MappingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, // Makes body go behind AppBar
      appBar: AppBar(
        backgroundColor: Colors.transparent, // Transparent AppBar
        elevation: 0,
        title: const Text("Cartographie SIG",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                shadows: [Shadow(blurRadius: 10)])),
        iconTheme: const IconThemeData(
            color: Colors.white, shadows: [Shadow(blurRadius: 10)]),
      ),
      body: Stack(
        children: [
          // Background Map Image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/map_placeholder.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Gradient Overlay for readability
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.black.withOpacity(0.5), Colors.transparent],
                begin: Alignment.topCenter,
                end: Alignment.center,
              ),
            ),
          ),
          // Placeholder Markers
          _buildMapMarker(top: 150, left: 100, label: "Zone A: Palmiers"),
          _buildMapMarker(top: 300, left: 200, label: "Zone B: Ficus"),
          _buildMapMarker(top: 450, left: 80, label: "Serre n°5"),
        ],
      ),
    );
  }

  Widget _buildMapMarker(
      {required double top, required double left, required String label}) {
    return Positioned(
      top: top,
      left: left,
      child: Column(
        children: [
          Text(label,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  shadows: [Shadow(blurRadius: 5)])),
          const Icon(Icons.location_on,
              color: Colors.redAccent,
              size: 40,
              shadows: [Shadow(blurRadius: 5)]),
        ],
      ),
    );
  }
}
