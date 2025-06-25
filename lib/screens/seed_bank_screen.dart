// lib/screens/seed_bank_screen.dart
import 'package:flutter/material.dart';
import '../main.dart'; // For AppColors

class SeedBankScreen extends StatelessWidget {
  const SeedBankScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Banque de Semences"),
          bottom: const TabBar(
            indicatorColor: AppColors.darkGreen,
            labelColor: AppColors.darkGreen,
            unselectedLabelColor: AppColors.secondaryText,
            tabs: [
              Tab(text: "TOUS"),
              Tab(text: "IN-SITU"),
              Tab(text: "COLLECTES"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildSeedList(context), // "TOUS" tab
            _buildSeedList(context, filter: "In-Situ"), // "IN-SITU" tab
            _buildSeedList(context, filter: "Externe"), // "COLLECTES" tab
          ],
        ),
      ),
    );
  }

  Widget _buildSeedList(BuildContext context, {String? filter}) {
    // Dummy data for demonstration
    final allSeeds = [
      {
        "name": "Pinus halepensis",
        "type": "In-Situ",
        "date": "10/2023",
        "id": "SS-23-401"
      },
      {
        "name": "Olea europaea",
        "type": "Externe",
        "date": "09/2023",
        "id": "SS-23-380"
      },
      {
        "name": "Lavandula stoechas",
        "type": "In-Situ",
        "date": "06/2023",
        "id": "SS-23-251"
      },
    ];

    final filteredSeeds = filter == null
        ? allSeeds
        : allSeeds.where((seed) => seed['type'] == filter).toList();

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: filteredSeeds.length,
      itemBuilder: (context, index) {
        final seed = filteredSeeds[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: seed['type'] == 'In-Situ'
                  ? AppColors.lightGreen
                  : AppColors.buttonGreen.withOpacity(0.7),
              child: const Icon(Icons.eco, color: Colors.white, size: 20),
            ),
            title: Text(seed['name']!,
                style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text("Collecte: ${seed['date']} | Lot: ${seed['id']}"),
            trailing: const Icon(Icons.arrow_forward_ios,
                size: 16, color: AppColors.secondaryText),
            onTap: () {},
          ),
        );
      },
    );
  }
}
