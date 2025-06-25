import 'package:flutter/material.dart';

// This is a placeholder for your AppColors.
// Make sure you have your color definitions correctly set up.
class AppColors {
  static const Color background = Color(0xFFF7F8FA);
  static const Color primaryText = Color(0xFF1D2939);
  static const Color secondaryText = Color(0xFF667085);
  static const Color buttonGreen = Color(0xFF12B76A);
  static const Color cardBg = Colors.white;
  static const Color primaryGreen = Color(0xFF12B76A);
}

class ControleSerresScreen extends StatelessWidget {
  const ControleSerresScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          'Contrôle des Serres',
          style: TextStyle(
            color: AppColors.primaryText,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColors.background,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.primaryText),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Chip(
              label: const Text('En Direct',
                  style: TextStyle(color: Colors.white, fontSize: 12)),
              backgroundColor: AppColors.buttonGreen,
              avatar: const Icon(Icons.circle, color: Colors.white, size: 10),
              padding: const EdgeInsets.symmetric(horizontal: 8),
              labelPadding: const EdgeInsets.only(left: 4, right: 2),
            ),
          ),
        ],
      ),
      body: GridView.count(
        padding: const EdgeInsets.all(16),
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.9, // Adjust aspect ratio for better height
        children: [
          _buildSensorCard(
            title: 'Température',
            valueWidget: _buildValueText('24.5°C'),
            status: 'Optimal',
            icon: Icons.thermostat,
            color: Colors.orange,
          ),
          _buildSensorCard(
            title: 'Humidité',
            valueWidget: _buildValueText('68%'),
            status: 'Optimal',
            icon: Icons.water_drop_outlined,
            color: const Color(0xFF3182CE), // Blue
          ),
          _buildSensorCard(
            title: 'Luminosité',
            valueWidget: _buildValueText('12 kLux'),
            status: 'Optimal',
            icon: Icons.lightbulb_outline,
            color: Colors.amber.shade600,
          ),
          _buildSensorCard(
            title: 'Humidité Sol',
            valueWidget: _buildValueText('55%'),
            status: 'Arrosage...',
            // Using `spa_outlined` as it looks more like the plant icon
            icon: Icons.spa_outlined,
            color: Colors.brown.shade400,
          ),
          _buildSensorCard(
            title: 'Ventilation',
            // Special widget for two-line value
            valueWidget: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'ACTIVE',
                  style: TextStyle(
                    color: AppColors.primaryText,
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                    height: 1.1,
                  ),
                ),
                Text(
                  'Niveau 2',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            status: '', // Status is part of the value widget here
            icon: Icons.air,
            color: Colors.grey.shade600,
          ),
          _buildSensorCard(
            title: 'Niveau CO₂',
            valueWidget: _buildValueText('450 ppm'),
            status: 'Élevé',
            icon: Icons.cloud_outlined,
            color: AppColors.primaryGreen,
          ),
        ],
      ),
    );
  }

  // Helper to create the standard large text widget for values
  Widget _buildValueText(String value) {
    return Text(
      value,
      style: const TextStyle(
        color: AppColors.primaryText,
        fontWeight: FontWeight.bold,
        fontSize: 32,
      ),
    );
  }

  /// A card widget where the icon is centered and the value is at the bottom.
  Widget _buildSensorCard({
    required String title,
    required Widget valueWidget, // Now accepts a widget for more flexibility
    required String status,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.08),
            spreadRadius: 2,
            blurRadius: 12,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top section: Title
          Text(
            title,
            style: const TextStyle(
              color: AppColors.secondaryText,
              fontWeight: FontWeight.w600,
            ),
          ),

          // Middle section: This expands to fill available space,
          // centering the icon within it. THIS IS THE KEY CHANGE.
          Expanded(
            child: Center(
              child: Icon(icon, color: color, size: 48), // Made icon larger
            ),
          ),

          // Bottom section: The value and status widgets are placed here
          valueWidget,
          if (status.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Text(
                status,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
