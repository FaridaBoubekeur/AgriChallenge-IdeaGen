import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

// Make sure to import the new files you created
import '../widgets/nav_bar.dart';
import '../widgets/topnavbar.dart';

// Import the task-specific screens
import 'irrigation.dart';

// Data model for a gardening task (no changes)
class GarderningTask {
  final String iconPath;
  final String title;
  final Widget targetScreen;

  GarderningTask({
    required this.iconPath,
    required this.title,
    required this.targetScreen,
  });
}

// --- THE UPDATED HOME SCREEN ---
class HammaHomeScreen extends StatelessWidget {
  const HammaHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<GarderningTask> tasks = [
      GarderningTask(
        iconPath: 'assets/icons/irrigation.png',
        title: 'Irrigation',
        targetScreen: IrrigationScreen(),
      ),
      GarderningTask(
        iconPath: 'assets/icons/floraison.png',
        title: 'Floraison',
        targetScreen: IrrigationScreen(),
      ),
      GarderningTask(
        iconPath: 'assets/icons/elagage.png',
        title: 'Élagage',
        targetScreen: IrrigationScreen(),
      ),
      GarderningTask(
        iconPath: 'assets/icons/arrosage.png',
        title: 'Arrosage',
        targetScreen: IrrigationScreen(),
      ),
      GarderningTask(
        iconPath: 'assets/icons/paillage.png',
        title: 'Paillage',
        targetScreen: IrrigationScreen(),
      ),
      GarderningTask(
        iconPath: 'assets/icons/plantation.png',
        title: 'Plantation',
        targetScreen: IrrigationScreen(),
      ),
    ];

    const primaryGreen = Color(0xFF3B8C5C);
    const backgroundGrey = Color(0xFFF3F5F7);
    const darkText = Color(0xFF1E293B);

    return Scaffold(
      backgroundColor: backgroundGrey,
      appBar: CommonTopNavBar(),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  Text('Bonjour Ahmed,',
                      style: GoogleFonts.lato(
                          fontSize: 18, color: Colors.grey.shade600)),
                  Text('Tâches',
                      style: GoogleFonts.playfairDisplay(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: darkText)),
                ],
              ),
            ),
          ),
          _buildAnimatedTaskGrid(context, tasks),
        ],
      ),

      // --- WIDGETS ARE NOW REUSABLE ---
      floatingActionButton: const CommonGradientFab(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: const CommonBottomNavBar(
        activeIndex: 0, // Set the active index for this page
      ),
    );
  }

  // --- WIDGET BUILDERS for the Home Screen specific content ---

  Widget _buildAnimatedTaskGrid(
      BuildContext context, List<GarderningTask> tasks) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
      sliver: AnimationLimiter(
        child: SliverGrid(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1.0,
          ),
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final task = tasks[index];
              return AnimationConfiguration.staggeredGrid(
                position: index,
                columnCount: 2,
                duration: const Duration(milliseconds: 475),
                child: SlideAnimation(
                  verticalOffset: 50.0,
                  child: FadeInAnimation(
                    child: _buildTaskCard(context, task),
                  ),
                ),
              );
            },
            childCount: tasks.length,
          ),
        ),
      ),
    );
  }

  Widget _buildTaskCard(BuildContext context, GarderningTask task) {
    return InkWell(
      onTap: () {
        // Navigate to the specific screen for this task
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => task.targetScreen),
        );
      },
      borderRadius: BorderRadius.circular(24),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.08),
              spreadRadius: 4,
              blurRadius: 10,
              offset: const Offset(0, 5),
            )
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(task.iconPath, width: 60, height: 60),
            const SizedBox(height: 16),
            Text(
              task.title,
              textAlign: TextAlign.center,
              style: GoogleFonts.lato(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: const Color(0xFF1E293B),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
