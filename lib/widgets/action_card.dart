// lib/widgets/action_card.dart
import 'package:flutter/material.dart';
import '../main.dart'; // For AppColors

class ActionCard extends StatelessWidget {
  final String iconAsset;
  final String label;
  final VoidCallback onTap;

  const ActionCard({
    super.key,
    required this.iconAsset,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.cardBg,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.08),
                spreadRadius: 1,
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                iconAsset,
                height: 60,
                // A fallback in case the image fails to load
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.image_not_supported_outlined,
                      size: 60, color: AppColors.secondaryText);
                },
              ),
              const SizedBox(height: 15),
              Text(
                label,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.secondaryText,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
