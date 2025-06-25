import 'package:flutter/material.dart';

// Make sure to import the unified navigation files
import '../widgets/nav_bar.dart';
import '../widgets/topnavbar.dart';

// A class to hold the app's color palette for consistency.
class AppColors {
  static const Color background = Color(0xFFF4F4F4);
  static const Color headerGreen = Color(0xFFE3F0E2);
  static const Color primaryText = Color(0xFF0F2C45);
  static const Color secondaryText = Color(0xFF5A6B7B);
  static const Color buttonGreen = Color(0xFF4C7F45);
  static const Color accentGreen = Color(0xFF3B8E7D);
}

class PlantDetailScreen extends StatelessWidget {
  const PlantDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(),
          SliverToBoxAdapter(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(35),
                  topRight: Radius.circular(35),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Overview",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                            color: AppColors.primaryText)),
                    const SizedBox(height: 20),
                    _buildOverviewSection(),
                    const SizedBox(height: 30),
                    const Text("About",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                            color: AppColors.primaryText)),
                    const SizedBox(height: 12),
                    const Text(
                      "Le Ficus elastica, souvent appelé Arbre de Tarzan pour sa robustesse et ses grandes feuilles, est une plante d'intérieur populaire. Il prospère avec une lumière vive mais indirecte et nécessite un sol bien drainé pour éviter la pourriture des racines.",
                      style: TextStyle(
                          color: AppColors.secondaryText,
                          fontSize: 16,
                          height: 1.5),
                    ),
                    const SizedBox(height: 30),
                    const Text("Fiche Technique",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                            color: AppColors.primaryText)),
                    const SizedBox(height: 20),
                    _buildInfoTable(), // The beautiful table you requested
                  ],
                ),
              ),
            ),
          ),
        ],
      ),

      // --- REPLACED WITH UNIFIED FAB ---
      floatingActionButton: const CommonGradientFab(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      // --- REPLACED WITH UNIFIED BOTTOM NAV BAR ---
      bottomNavigationBar: const CommonBottomNavBar(
        activeIndex: 2, // Set appropriate active index for plant detail screen
      ),
    );
  }

  /// The top App Bar with the plant image and overlaid info.
  SliverAppBar _buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 400.0,
      backgroundColor: AppColors.headerGreen,
      elevation: 0,
      pinned: true,

      // --- REPLACED WITH UNIFIED TOP NAV BAR STYLE ---
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CircleAvatar(
          backgroundColor: AppColors.buttonGreen,
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              // Handle back navigation
              print('Back button pressed');
            },
          ),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: () {
              // Handle report button tap
              print('Signaler button tapped');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.buttonGreen,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child:
                const Text("Signaler", style: TextStyle(color: Colors.white)),
          ),
        ),
      ],

      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            // Plant Image
            Image.asset(
              'assets/images/tarzan.png', // Make sure you have this image in your assets
              fit: BoxFit.cover,
            ),
            // Faded overlay for better text readability
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.headerGreen, Colors.transparent],
                  begin: Alignment.centerLeft,
                  end: Alignment.center,
                  stops: [0.8, 4.0],
                ),
              ),
            ),
            // Plant information text
            Positioned(
              top: 70,
              left: 10,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Arbre de Tarzan",
                      style: TextStyle(
                          fontSize: 27,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryText)),
                  const SizedBox(height: 20),
                  _buildInfoLabel("NOM SCI", "Ficus elastica"),
                  const SizedBox(height: 15),
                  _buildInfoLabel("ORIGINE", "El Hamma, Alger"),
                  const SizedBox(height: 15),
                  _buildInfoLabel("LOCATION", ""),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      'assets/images/map_placeholder.png', // Placeholder map image
                      width: 150,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// A helper widget for the small info labels in the header.
  Widget _buildInfoLabel(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: TextStyle(
                fontSize: 14,
                color: AppColors.secondaryText,
                fontWeight: FontWeight.bold)),
        Text(value,
            style: TextStyle(
                fontSize: 18,
                color: AppColors.primaryText,
                fontWeight: FontWeight.w600)),
      ],
    );
  }

  /// Builds the horizontal overview section for Light, Temp, Water.
  Widget _buildOverviewSection() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _OverviewItem(
            icon: Icons.wb_sunny_outlined,
            label: "LUMIÈRE",
            value: "Vive, Indirecte"),
        _OverviewItem(
            icon: Icons.thermostat_outlined,
            label: "TEMPÉRATURE",
            value: "18-24°C"),
        _OverviewItem(
            icon: Icons.water_drop_outlined,
            label: "ARROSAGE",
            value: "Modéré"),
      ],
    );
  }

  /// The styled information table.
  Widget _buildInfoTable() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Column(
        children: [
          _InfoTableRow(icon: Icons.grass, label: "Famille", value: "Moraceae"),
          Divider(height: 24),
          _InfoTableRow(
              icon: Icons.landscape,
              label: "Type de Sol",
              value: "Riche et drainé"),
          Divider(height: 24),
          _InfoTableRow(
              icon: Icons.opacity, label: "Humidité", value: "Élevée (60%+)"),
          Divider(height: 24),
          _InfoTableRow(
              icon: Icons.warning_amber_rounded,
              label: "Toxicité",
              value: "Toxique (animaux)"),
        ],
      ),
    );
  }
}

/// A reusable widget for an item in the Overview section.
class _OverviewItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const _OverviewItem(
      {required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: AppColors.accentGreen, size: 32),
        const SizedBox(height: 8),
        Text(label,
            style: TextStyle(color: AppColors.secondaryText, fontSize: 12)),
        const SizedBox(height: 4),
        Text(value,
            style: const TextStyle(
                color: AppColors.primaryText,
                fontWeight: FontWeight.bold,
                fontSize: 16)),
      ],
    );
  }
}

/// A reusable widget for a row in the "Fiche Technique" table.
class _InfoTableRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const _InfoTableRow(
      {required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: AppColors.accentGreen, size: 24),
        const SizedBox(width: 16),
        Text(label,
            style:
                const TextStyle(color: AppColors.secondaryText, fontSize: 16)),
        const Spacer(),
        Text(value,
            style: const TextStyle(
                color: AppColors.primaryText,
                fontWeight: FontWeight.bold,
                fontSize: 16)),
      ],
    );
  }
}
