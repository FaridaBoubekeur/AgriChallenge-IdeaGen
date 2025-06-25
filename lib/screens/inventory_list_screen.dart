// lib/screens/inventory_list_screen.dart
import 'package:flutter/material.dart';
import '../main.dart'; // For AppColors

class InventoryListScreen extends StatelessWidget {
  const InventoryListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Inventaire des Taxons"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildTaxonListItem(
            name: "Phoenix dactylifera",
            id: "JH-1856-001",
            origin: "Biskra, Algérie",
            introDate: "1856",
            status: Colors.green,
          ),
          _buildTaxonListItem(
            name: "Quercus ilex",
            id: "JH-1902-045",
            origin: "Monts de l'Atlas",
            introDate: "1902",
            status: Colors.green,
          ),
          _buildTaxonListItem(
            name: "Cycas revoluta",
            id: "JH-1899-112",
            origin: "Échange, Jardin de Kyoto",
            introDate: "1899",
            status: Colors.orange,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: AppColors.darkGreen,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildTaxonListItem({
    required String name,
    required String id,
    required String origin,
    required String introDate,
    required Color status,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      elevation: 2,
      shadowColor: AppColors.darkGreen.withOpacity(0.1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Container(
              width: 8,
              height: 60,
              decoration: BoxDecoration(
                color: status,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text(
                    "ID: $id | Provenance: $origin",
                    style: const TextStyle(
                        color: AppColors.secondaryText, fontSize: 13),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            Text(introDate,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: AppColors.lightGreen)),
          ],
        ),
      ),
    );
  }
}
