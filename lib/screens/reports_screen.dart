// lib/screens/reports_screen.dart
import 'package:flutter/material.dart';
import '../main.dart'; // For AppColors

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TabController is used to coordinate the tab bar and the tab views
    return DefaultTabController(
      length: 2, // We have two tabs: Suivi and Actions
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Rapports & Actions"),
          // The TabBar is placed in the bottom of the AppBar
          bottom: const TabBar(
            indicatorColor: AppColors.darkGreen,
            indicatorWeight: 3.0,
            labelColor: AppColors.darkGreen,
            unselectedLabelColor: AppColors.secondaryText,
            labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            tabs: [
              Tab(text: "SUIVI"),
              Tab(text: "ACTIONS"),
            ],
          ),
        ),
        body: TabBarView(
          // The content for each tab is defined here
          children: [
            _buildSuiviTab(context),
            _buildActionsTab(context),
          ],
        ),
      ),
    );
  }

  // --- TAB 1: SUIVI (Monitoring & Logs) ---
  Widget _buildSuiviTab(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle(
              "Suivi Sanitaire", "État de santé des collections."),
          _buildStatusCard(
            icon: Icons.healing_outlined,
            iconColor: Colors.orange,
            title: "Alerte: Mildiou sur Quercus",
            subtitle: "Lot B-12, actions urgentes requises.",
            tag: "Urgent",
          ),
          _buildStatusCard(
            icon: Icons.check_circle_outline,
            iconColor: AppColors.lightGreen,
            title: "Rapport d'Octobre 2023",
            subtitle: "Aucune anomalie majeure détectée.",
            tag: "Normal",
          ),
          const SizedBox(height: 30),
          _buildSectionTitle("Échanges Inter-Jardins",
              "Mouvements avec d'autres institutions."),
          _buildStatusCard(
            icon: Icons.swap_horiz,
            iconColor: Colors.blueAccent,
            title: "Demande du Jardin Majorelle",
            subtitle: "5x lots de 'Lavandula stoechas' en attente.",
            tag: "En Attente",
          ),
          _buildStatusCard(
            icon: Icons.call_made_outlined,
            iconColor: AppColors.darkGreen,
            title: "Envoi vers Kew Gardens",
            subtitle: "3x lots de 'Phoenix dactylifera'.",
            tag: "Complété",
          ),
          const SizedBox(height: 30),
          _buildSectionTitle(
              "Échanges Intra-Jardin", "Mouvements entre zones du jardin."),
          _buildStatusCard(
            icon: Icons.sync_alt,
            iconColor: AppColors.secondaryText,
            title: "Transfert vers Serre n°5",
            subtitle: "Déplacement de 'Cycas revoluta' pour hivernage.",
            tag: "Programmé",
          ),
        ],
      ),
    );
  }

  // --- TAB 2: ACTIONS (Forms) ---
  Widget _buildActionsTab(BuildContext context) {
    // This is where users initiate new actions (the forms)
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle("Formulaires de Mouvement",
              "Créer une nouvelle opération de transfert ou d'ajout."),
          _buildActionCard(
              context: context,
              icon: Icons.add_circle_outline,
              title: "Ajouter à la banque",
              subtitle:
                  "Enregistrer une nouvelle collecte de graines ou de spores.",
              onTap: () {
                // TODO: Navigate to the 'Add to Bank' form
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("Navigation vers le formulaire d'ajout...")));
              }),
          _buildActionCard(
              context: context,
              icon: Icons.north_east_outlined, // Icon for moving out
              title: "Transférer (Intra-Jardin)",
              subtitle:
                  "Déplacer un taxon d'une zone à une autre dans le jardin.",
              onTap: () {
                // TODO: Navigate to the 'Intra-Garden Transfer' form
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text(
                        "Navigation vers le formulaire de transfert interne...")));
              }),
          _buildActionCard(
              context: context,
              icon: Icons.public_outlined, // Icon for external exchange
              title: "Nouvel Échange (Inter-Jardin)",
              subtitle:
                  "Initier un échange de matériel avec un autre jardin botanique.",
              onTap: () {
                // TODO: Navigate to the 'Inter-Garden Exchange' form
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text(
                        "Navigation vers le formulaire d'échange externe...")));
              }),
        ],
      ),
    );
  }

  // --- Reusable Widgets for this Screen ---

  Widget _buildSectionTitle(String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryText),
          ),
          Text(
            subtitle,
            style:
                const TextStyle(fontSize: 14, color: AppColors.secondaryText),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required String tag,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 1.5,
      shadowColor: Colors.black.withOpacity(0.05),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Icon(icon, color: iconColor, size: 30),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 16)),
                  const SizedBox(height: 2),
                  Text(subtitle,
                      style: const TextStyle(
                          color: AppColors.secondaryText, fontSize: 14)),
                ],
              ),
            ),
            const SizedBox(width: 10),
            Text(tag,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.secondaryText)),
          ],
        ),
      ),
    );
  }

  Widget _buildActionCard({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Card(
          margin: const EdgeInsets.only(bottom: 16),
          color: AppColors.cardBg,
          elevation: 2.0,
          shadowColor: AppColors.darkGreen.withOpacity(0.1),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor: AppColors.darkGreen.withOpacity(0.1),
                  child: Icon(icon, size: 28, color: AppColors.darkGreen),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title,
                          style: const TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      Text(subtitle,
                          style: const TextStyle(
                              color: AppColors.secondaryText,
                              fontSize: 14,
                              height: 1.2)),
                    ],
                  ),
                ),
                const Icon(Icons.arrow_forward_ios,
                    color: AppColors.secondaryText, size: 18),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
