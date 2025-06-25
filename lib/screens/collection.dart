// lib/screens/dashboard_screen.dart
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../main.dart'; // To access AppColors
import '../widgets/action_card.dart'; // Our new reusable widget
import '../widgets/topnavbar.dart'; // Import your new unified navbar
import 'inventory_list_screen.dart';
import 'seed_bank_screen.dart';
import 'mapping_screen.dart';
import 'reports_screen.dart';
import '../widgets/nav_bar.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonTopNavBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                const Text(
                  "Bonjour Nada",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
                ),
                //const SizedBox(height: 20),
                //_buildSummaryCard(),
                const SizedBox(height: 30),
                const Text(
                  "Que voulez-vous faire?",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 20),
                _buildActionGrid(context),
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: const CommonGradientFab(),
      bottomNavigationBar: const CommonBottomNavBar(
        activeIndex: 0, // Dashboard is at index 0
      ),
    );
  }

  // --- WIDGET BUILDERS ---
  Widget _buildActionGrid(BuildContext context) {
    // This helper function creates the card and handles navigation
    void _navigateTo(Widget screen) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => screen),
      );
    }

    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 15,
      mainAxisSpacing: 15,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        ActionCard(
          iconAsset: "assets/icons/recenser.png",
          label: "RECENSER TAXON",
          onTap: () => _navigateTo(const InventoryListScreen()),
        ),
        ActionCard(
          iconAsset: "assets/icons/banque.png",
          label: "GÉRER LA BANQUE",
          onTap: () => _navigateTo(const SeedBankScreen()),
        ),
        ActionCard(
          iconAsset: "assets/icons/carte.png",
          label: "VOIR LA CARTE SIG",
          onTap: () => _navigateTo(const MappingScreen()),
        ),
        ActionCard(
          iconAsset: "assets/icons/reports.png",
          label: "SUIVI & ÉCHANGES",
          onTap: () => _navigateTo(const ReportsScreen()),
        ),
      ],
    );
  }
}
