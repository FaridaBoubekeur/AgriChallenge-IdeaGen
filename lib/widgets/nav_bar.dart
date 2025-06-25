import 'package:flutter/material.dart';

// TODO: Update these imports to point to YOUR actual page files
import '../screens/entretien.dart';
import '../screens/chatbot.dart';
import '../screens/scaner.dart';
import '../screens/gallery.dart'; // Add this import for gallery page

// --- Reusable Color Constants for the Nav Bar ---
const Color _activeColor = Color(0xFF3B8C5C);
const Color _inactiveColor = Color(0xFF6B7280);
const Color _primaryGradientColor = Color(0xFF3B8C5C);
const Color _secondaryGradientColor = Color(0xFF53A877);

/// A reusable, gradient-styled Floating Action Button for scanning.
class CommonGradientFab extends StatelessWidget {
  const CommonGradientFab({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: const LinearGradient(
          colors: [_primaryGradientColor, _secondaryGradientColor],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: _primaryGradientColor.withOpacity(0.4),
            blurRadius: 10,
            offset: const Offset(0, 5),
          )
        ],
      ),
      child: FloatingActionButton(
        onPressed: () {
          // --- NAVIGATION LOGIC for SCANNER ---
          Navigator.push(
            context,
            // You requested DemoScannerPage for the scanner
            MaterialPageRoute(builder: (context) => const DemoScannerPage()),
          );
        },
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: const Icon(Icons.qr_code_scanner_rounded,
            size: 30, color: Colors.white),
      ),
    );
  }
}

/// The common bottom app bar for the application.
class CommonBottomNavBar extends StatelessWidget {
  final int activeIndex;

  const CommonBottomNavBar({
    super.key,
    required this.activeIndex,
  });

  @override
  Widget build(BuildContext context) {
    final List<IconData> icons = [
      Icons.home_outlined,
      Icons.smart_toy_outlined, // Chatbot icon at index 1
      Icons.photo_library_outlined, // Gallery icon at index 2
      Icons.person_outline,
    ];

    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 10.0,
      elevation: 20.0,
      shadowColor: Colors.black.withOpacity(0.1),
      color: Colors.white,
      child: SizedBox(
        height: 65,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(context: context, icon: icons[0], index: 0),
            _buildNavItem(context: context, icon: icons[1], index: 1),
            const SizedBox(width: 48), // The space for the notch
            _buildNavItem(context: context, icon: icons[2], index: 2),
            _buildNavItem(context: context, icon: icons[3], index: 3),
          ],
        ),
      ),
    );
  }

  /// Helper widget to build each navigation item with navigation logic.
  Widget _buildNavItem({
    required BuildContext context,
    required IconData icon,
    required int index,
  }) {
    return IconButton(
      icon: Icon(
        icon,
        color: activeIndex == index ? _activeColor : _inactiveColor,
        size: 28,
      ),
      onPressed: () {
        // Only navigate if the tapped item is not the currently active one
        if (activeIndex != index) {
          Widget page;
          switch (index) {
            case 0:
              // Home clicked
              page = const HammaHomeScreen();
              break;
            case 1:
              // Chatbot clicked
              page = const FloraBotScreen();
              break;
            case 2:
              // Gallery clicked (Map icon changed to Gallery)
              page = const GalleryScreen();
              break;
            case 3:
              // Profile clicked
              // page = const ProfilePage();
              // For now, just return since ProfilePage might not exist yet
              return;
            default:
              return; // Failsafe, should not be reached
          }

          // Use pushReplacement for a standard tab navigation feel.
          // This replaces the current screen in the stack instead of adding to it.
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) => page,
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                // Using a fade transition for a smoother look between tabs
                return FadeTransition(opacity: animation, child: child);
              },
              transitionDuration: const Duration(milliseconds: 200),
            ),
          );
        }
      },
    );
  }
}
