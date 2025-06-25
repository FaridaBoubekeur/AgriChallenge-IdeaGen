import 'package:flutter/material.dart';
import 'multiplication.dart'; // To access AppColors

class ReceptionLotsScreen extends StatelessWidget {
  const ReceptionLotsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Réception des Lots',
            style: TextStyle(color: AppColors.primaryText)),
        backgroundColor: AppColors.background,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.primaryText),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20.0),
        children: [
          _buildLotItem(
            species: 'Quercus ilex',
            type: 'Graines',
            quantity: '500 unités',
            date: '15/05/2024',
            origin: 'Forêt de Bainem',
            iconColor: AppColors.primaryYellow,
          ),
          _buildLotItem(
            species: 'Rosa damascena',
            type: 'Boutures',
            quantity: '120 unités',
            date: '12/05/2024',
            origin: 'Roseraie du Jardin',
            iconColor: AppColors.primaryGreen,
          ),
          _buildLotItem(
            species: 'Phoenix dactylifera',
            type: 'Rejets',
            quantity: '25 unités',
            date: '10/05/2024',
            origin: 'Palmeraie de Biskra',
            iconColor: Colors.brown,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: const Text('Nouveau Lot'),
        icon: const Icon(Icons.add),
        backgroundColor: AppColors.buttonGreen,
      ),
    );
  }

  Widget _buildLotItem({
    required String species,
    required String type,
    required String quantity,
    required String date,
    required String origin,
    required Color iconColor,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 15),
      elevation: 2,
      shadowColor: Colors.black.withOpacity(0.1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: iconColor.withOpacity(0.15),
                  child: Icon(Icons.inventory_2_outlined,
                      color: iconColor, size: 22),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Text(
                    species,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryText,
                    ),
                  ),
                ),
                Text(
                  date,
                  style: const TextStyle(
                      color: AppColors.secondaryText, fontSize: 12),
                ),
              ],
            ),
            const Divider(height: 25),
            _buildInfoRow('Type:', type),
            const SizedBox(height: 8),
            _buildInfoRow('Quantité:', quantity),
            const SizedBox(height: 8),
            _buildInfoRow('Origine:', origin),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      children: [
        Text(label,
            style: const TextStyle(
                color: AppColors.secondaryText, fontWeight: FontWeight.w600)),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
                color: AppColors.primaryText, fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }
}
