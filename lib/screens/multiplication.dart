import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

// Make sure to import the new unified navigation files
import '../widgets/nav_bar.dart';
import '../widgets/topnavbar.dart';

// --- ADD IMPORTS FOR YOUR NEW SCREENS ---
import 'reception_lots_screen.dart';
import 'gestion_production_screen.dart';
import 'controle_serres_screen.dart';
import 'suivi_analyse_screen.dart';

// Define AppColors to match the style of the original image
class AppColors {
  static const Color background = Color(0xFFF6F8FA);
  static const Color primaryText = Color(0xFF2D3748);
  static const Color secondaryText = Color(0xFF718096);
  static const Color buttonGreen = Color(0xFF68A55B);
  static const Color cardBg = Colors.white;
  static const Color primaryGreen = Color(0xFF38A169);
  static const Color primaryYellow = Color(0xFFD69E2E);
  static const Color iconTint = Color(0xFF4A5568);
}

class SophianeHomeScreen extends StatelessWidget {
  const SophianeHomeScreen({super.key});

  // --- HELPER METHOD FOR NAVIGATION ---
  void _navigateTo(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CommonTopNavBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Bonjour Sophiane",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryText,
                ),
              ),
              const SizedBox(height: 20),
              _buildSummaryCard(),
              const SizedBox(height: 30),
              const Text(
                "Que voulez-vous faire?",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryText,
                ),
              ),
              const SizedBox(height: 20),
              // Pass the context to the grid builder
              _buildActionGrid(context),
            ],
          ),
        ),
      ),
      floatingActionButton: const CommonGradientFab(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: const CommonBottomNavBar(
        activeIndex: 1,
      ),
    );
  }

  // ... (keep _buildSummaryCard, _buildProgressRow, _buildStatRow as they are) ...

  // -- MODIFIED --
  Widget _buildActionGrid(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 15,
      mainAxisSpacing: 15,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        _buildActionCard(
          iconData: Icons.input,
          title: "RÉCEPTION DES LOTS",
          iconColor: const Color(0xFFD69E2E), // Yellow
          onTap: () => _navigateTo(context, const ReceptionLotsScreen()),
        ),
        _buildActionCard(
          iconData: Icons.eco,
          title: "GESTION PRODUCTION",
          iconColor: const Color(0xFF38A169), // Green
          onTap: () => _navigateTo(context, const GestionProductionScreen()),
        ),
        _buildActionCard(
          iconData: Icons.settings_suggest,
          title: "CONTRÔLE SERRES",
          iconColor: const Color(0xFF3182CE), // Blue
          onTap: () => _navigateTo(context, const ControleSerresScreen()),
        ),
        _buildActionCard(
          iconData: Icons.bar_chart,
          title: "SUIVI & ANALYSE",
          iconColor: const Color(0xFF805AD5), // Purple
          onTap: () => _navigateTo(context, const SuiviAnalyseScreen()),
        ),
      ],
    );
  }

  // -- MODIFIED --
  Widget _buildActionCard({
    required IconData iconData,
    required String title,
    required Color iconColor,
    required VoidCallback onTap, // Add this onTap callback
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.08),
            spreadRadius: 1,
            blurRadius: 10,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap, // Use the passed onTap function
          borderRadius: BorderRadius.circular(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: iconColor.withOpacity(0.15),
                child: Icon(
                  iconData,
                  size: 30,
                  color: iconColor,
                ),
              ),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: AppColors.primaryText,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  // Paste the unchanged methods here
  Widget _buildSummaryCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("STATISTIQUES DE PRODUCTION",
              style: TextStyle(
                  color: AppColors.secondaryText,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.8)),
          const SizedBox(height: 20),
          _buildProgressRow(
            percent: 0.85,
            label: "Taux de germination",
            value: "85%",
            color: AppColors.primaryGreen,
          ),
          const SizedBox(height: 20),
          _buildProgressRow(
            percent: 0.72,
            label: "Taux de reprise (boutures)",
            value: "72%",
            color: AppColors.primaryGreen,
          ),
          const SizedBox(height: 20),
          _buildStatRow(
            icon: Icons.timer_outlined,
            label: "Temps de production moyen",
            value: "42 Jours",
            color: AppColors.primaryYellow,
          )
        ],
      ),
    );
  }

  Widget _buildProgressRow({
    required double percent,
    required String label,
    required String value,
    required Color color,
  }) {
    return Row(
      children: [
        CircularPercentIndicator(
          radius: 24.0,
          lineWidth: 5.0,
          percent: percent,
          center: Text(
            "${(percent * 100).toInt()}%",
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 10,
                color: AppColors.primaryText),
          ),
          progressColor: color,
          backgroundColor: Colors.grey.shade200,
          circularStrokeCap: CircularStrokeCap.round,
        ),
        const SizedBox(width: 15),
        Expanded(
          child: Text(
            label,
            style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.primaryText),
          ),
        ),
        Text(
          value,
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: color),
        ),
      ],
    );
  }

  Widget _buildStatRow({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Row(
      children: [
        CircleAvatar(
          radius: 24,
          backgroundColor: color.withOpacity(0.1),
          child: Icon(icon, color: color, size: 24),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: Text(
            label,
            style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.primaryText),
          ),
        ),
        Text(
          value,
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: color),
        ),
      ],
    );
  }
}
