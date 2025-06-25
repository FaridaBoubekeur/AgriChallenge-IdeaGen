import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'multiplication.dart'; // To access AppColors

class SuiviAnalyseScreen extends StatelessWidget {
  const SuiviAnalyseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Suivi & Analyse',
            style: TextStyle(color: AppColors.primaryText)),
        backgroundColor: AppColors.background,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.primaryText),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Performance Mensuelle",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryText,
              ),
            ),
            const SizedBox(height: 20),
            _buildStatCard(
              title: "Taux de réussite global",
              value: "78%",
              icon: Icons.trending_up,
              color: AppColors.primaryGreen,
            ),
            _buildStatCard(
              title: "Lots terminés ce mois",
              value: "12",
              icon: Icons.check_box_outlined,
              color: const Color(0xFF3182CE),
            ),
            _buildStatCard(
              title: "Pertes enregistrées",
              value: "231 unités",
              icon: Icons.trending_down,
              color: Colors.red.shade400,
            ),
            const SizedBox(height: 25),
            const Text(
              "Réussite par type de propagation",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryText,
              ),
            ),
            const SizedBox(height: 15),
            _buildLinearProgress("Graines", 0.85),
            _buildLinearProgress("Boutures", 0.72),
            _buildLinearProgress("Marcottage", 0.91),
            _buildLinearProgress("Greffage", 0.65),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      elevation: 1,
      shadowColor: Colors.black.withOpacity(0.05),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withOpacity(0.1),
          child: Icon(icon, color: color),
        ),
        title: Text(title,
            style: const TextStyle(
                fontWeight: FontWeight.w600, color: AppColors.primaryText)),
        trailing: Text(value,
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: color)),
      ),
    );
  }

  Widget _buildLinearProgress(String label, double percent) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
          const SizedBox(height: 8),
          LinearPercentIndicator(
            animation: true,
            lineHeight: 14.0,
            percent: percent,
            center: Text(
              "${(percent * 100).toInt()}%",
              style: const TextStyle(
                  fontSize: 10,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            barRadius: const Radius.circular(7),
            progressColor: AppColors.primaryGreen,
            backgroundColor: Colors.grey.shade200,
          ),
        ],
      ),
    );
  }
}
