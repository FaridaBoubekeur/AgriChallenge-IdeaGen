import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'multiplication.dart'; // To access AppColors

class GestionProductionScreen extends StatelessWidget {
  const GestionProductionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Gestion Production',
            style: TextStyle(color: AppColors.primaryText)),
        backgroundColor: AppColors.background,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.primaryText),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _buildProductionBatch(
            species: 'Quercus ilex',
            stage: 'Germination',
            progress: 0.60,
            days: '15/90 Jours',
            icon: Icons.science_outlined,
            color: AppColors.primaryGreen,
          ),
          _buildProductionBatch(
            species: 'Rosa damascena',
            stage: 'Enracinement',
            progress: 0.85,
            days: '25/30 Jours',
            icon: Icons.eco_outlined,
            color: const Color(0xFF3182CE), // Blue
          ),
          _buildProductionBatch(
            species: 'Ficus carica',
            stage: 'Prêt pour rempotage',
            progress: 1.0,
            days: '45/45 Jours',
            icon: Icons.check_circle_outline,
            color: AppColors.primaryYellow,
          ),
          _buildProductionBatch(
            species: 'Lavandula angustifolia',
            stage: 'Acclimatation',
            progress: 0.30,
            days: '4/14 Jours',
            icon: Icons.wb_sunny_outlined,
            color: const Color(0xFF805AD5), // Purple
          ),
        ],
      ),
    );
  }

  Widget _buildProductionBatch({
    required String species,
    required String stage,
    required double progress,
    required String days,
    required IconData icon,
    required Color color,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 2,
      shadowColor: Colors.black.withOpacity(0.1),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                    backgroundColor: color.withOpacity(0.15),
                    child: Icon(icon, color: color)),
                const SizedBox(width: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(species,
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryText)),
                    Text(stage,
                        style: TextStyle(
                            fontSize: 14,
                            color: color,
                            fontWeight: FontWeight.w600)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                  child: LinearPercentIndicator(
                    lineHeight: 8.0,
                    percent: progress,
                    backgroundColor: Colors.grey.shade200,
                    progressColor: color,
                    barRadius: const Radius.circular(4),
                  ),
                ),
                const SizedBox(width: 15),
                Text(days,
                    style: const TextStyle(
                        color: AppColors.secondaryText,
                        fontWeight: FontWeight.w500)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
