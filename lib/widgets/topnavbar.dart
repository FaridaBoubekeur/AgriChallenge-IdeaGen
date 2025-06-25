// lib/widgets/common_top_nav_bar.dart
import 'package:flutter/material.dart';
import '../screens/notification.dart'; // Add this import
import '../screens/signal_screen.dart'; // Add this import

/// A reusable top navigation bar with notification icon and report button
class CommonTopNavBar extends StatelessWidget implements PreferredSizeWidget {
  final String? buttonText;
  final VoidCallback? onButtonPressed;
  final VoidCallback? onNotificationPressed;
  final bool showNotificationDot;
  final Color? backgroundColor;
  final Color? buttonColor;

  const CommonTopNavBar({
    super.key,
    this.buttonText = 'Signaler',
    this.onButtonPressed,
    this.onNotificationPressed,
    this.showNotificationDot = true,
    this.backgroundColor,
    this.buttonColor,
  });

  @override
  Widget build(BuildContext context) {
    const primaryGreen = Color(0xFF3B8C5C);
    const backgroundGrey = Color(0xFFF3F5F7);

    return AppBar(
      backgroundColor: backgroundColor ?? backgroundGrey,
      elevation: 0,
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      leading: Padding(
        padding: const EdgeInsets.only(left: 20.0),
        child: Center(
          child: GestureDetector(
            onTap: onNotificationPressed ??
                () {
                  // Navigate to NotificationsPage
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NotificationsPage(),
                    ),
                  );
                },
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Icon(
                  Icons.notifications_none_outlined,
                  size: 30,
                  color: Colors.grey.shade700,
                ),
                if (showNotificationDot)
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      height: 10,
                      width: 10,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                        border: Border.all(
                          width: 1.5,
                          color: backgroundColor ?? backgroundGrey,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: Center(
            child: ElevatedButton(
              onPressed: onButtonPressed ??
                  () {
                    // Navigate to SignalPage
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SignalScreen(),
                      ),
                    );
                  },
              style: ElevatedButton.styleFrom(
                backgroundColor: buttonColor ?? primaryGreen,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
              ),
              child: Text(buttonText ?? 'Signaler'),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
