import 'package:flutter/material.dart';
import 'dart:async'; // --- MODIFICATION ---: Import for Timer
import 'card.dart';

// The main QR code scanner demo page
class DemoScannerPage extends StatefulWidget {
  const DemoScannerPage({super.key});

  @override
  State<DemoScannerPage> createState() => _DemoScannerPageState();
}

class _DemoScannerPageState extends State<DemoScannerPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  // --- MODIFICATION ---: State to track if the scan is complete
  bool _isScanComplete = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    // --- MODIFICATION ---: Simulate a scan and navigate after a delay
    _simulateScan();
  }

  void _simulateScan() {
    // Wait for 4 seconds to simulate scanning time
    Future.delayed(const Duration(seconds: 4), () {
      // Important: Check if the widget is still mounted before interacting with it.
      if (!mounted) return;

      // Update the state to show the success UI
      setState(() {
        _isScanComplete = true;
        _animationController.stop();
      });

      // Wait a moment for the user to see the green success state
      Timer(const Duration(milliseconds: 600), () {
        if (!mounted) return;

        // Navigate to the result page, replacing the scanner page in the stack
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const PlantDetailScreen(),
          ),
        );
      });
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Defines the rectangle for the "scan window"
    final scanWindow = Rect.fromCenter(
      center: MediaQuery.of(context).size.center(const Offset(0, -50)),
      width: 260,
      height: 260,
    );

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Layer 1: The background image acting as a mock camera feed
          Image.asset(
            'assets/images/scan.png',
            fit: BoxFit.cover,
          ),

          // Layer 2: The dimming overlay with a cutout
          CustomPaint(
            painter: ScannerOverlayPainter(scanWindow),
          ),

          // Layer 3: Positioned UI elements (text, scanner box)
          Positioned.fill(
            child: Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Spacer to push content down from center
                  const SizedBox(height: 100),
                  // Instruction Text
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.camera_alt_outlined,
                          color: Colors.white70),
                      const SizedBox(width: 10),
                      Text(
                        // --- MODIFICATION ---: Change text based on scan state
                        _isScanComplete
                            ? 'Scan Complete!'
                            : 'Point your camera at the place',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.9),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Scanner Box Container
                  SizedBox(
                    width: scanWindow.width + 10,
                    height: scanWindow.height + 10,
                    child: Stack(
                      children: [
                        // The corner brackets, now aware of the scan state
                        // --- MODIFICATION ---: Pass the success state to the painter
                        CustomPaint(
                          painter:
                              ScannerBoxPainter(isSuccess: _isScanComplete),
                        ),
                        // The animated "laser" line
                        if (!_isScanComplete) // --- MODIFICATION ---: Hide laser on success
                          AnimatedBuilder(
                            animation: _animationController,
                            builder: (context, child) {
                              final animationValue = _animationController.value;
                              return Positioned(
                                top: scanWindow.height * animationValue,
                                left: 5,
                                right: 5,
                                child: Container(
                                  height: 2.0,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.7),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.white.withOpacity(0.3),
                                        blurRadius: 8.0,
                                        spreadRadius: 2.0,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                      ],
                    ),
                  ),
                  // Pushes bottom content down
                  const SizedBox(height: 280),
                ],
              ),
            ),
          ),

          // Layer 4: Back Button
          Positioned(
            top: 50,
            left: 20,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Custom Painter for the scanning area overlay (the dimmed part)
class ScannerOverlayPainter extends CustomPainter {
  final Rect scanWindow;

  ScannerOverlayPainter(this.scanWindow);

  @override
  void paint(Canvas canvas, Size size) {
    final backgroundPath = Path()..addRect(Rect.largest);
    final cutoutPath = Path()
      ..addRRect(
        RRect.fromRectAndCorners(
          scanWindow,
          topLeft: const Radius.circular(24),
          topRight: const Radius.circular(24),
          bottomLeft: const Radius.circular(24),
          bottomRight: const Radius.circular(24),
        ),
      );

    final backgroundPaint = Paint()..color = Colors.black.withOpacity(0.5);
    final cutout =
        Path.combine(PathOperation.difference, backgroundPath, cutoutPath);
    canvas.drawPath(cutout, backgroundPaint);
  }

  @override
  bool shouldRepaint(ScannerOverlayPainter oldDelegate) {
    return oldDelegate.scanWindow != scanWindow;
  }
}

// Custom Painter for the white corner brackets
class ScannerBoxPainter extends CustomPainter {
  // --- MODIFICATION ---: Add a property to check for success state
  final bool isSuccess;

  ScannerBoxPainter({this.isSuccess = false});

  @override
  void paint(Canvas canvas, Size size) {
    const double cornerLength = 32.0;
    const double strokeWidth = 5.0;
    const double borderRadius = 24.0;

    // --- MODIFICATION ---: Change color based on success state
    final paint = Paint()
      ..color = isSuccess ? Colors.green : Colors.white
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final path = Path()
      // Top-left
      ..moveTo(0, cornerLength)
      ..lineTo(0, borderRadius)
      ..quadraticBezierTo(0, 0, borderRadius, 0)
      ..lineTo(cornerLength, 0)
      // Top-right
      ..moveTo(size.width - cornerLength, 0)
      ..lineTo(size.width - borderRadius, 0)
      ..quadraticBezierTo(size.width, 0, size.width, borderRadius)
      ..lineTo(size.width, cornerLength)
      // Bottom-left
      ..moveTo(0, size.height - cornerLength)
      ..lineTo(0, size.height - borderRadius)
      ..quadraticBezierTo(0, size.height, borderRadius, size.height)
      ..lineTo(cornerLength, size.height)
      // Bottom-right
      ..moveTo(size.width - cornerLength, size.height)
      ..lineTo(size.width - borderRadius, size.height)
      ..quadraticBezierTo(
          size.width, size.height, size.width, size.height - borderRadius)
      ..lineTo(size.width, size.height - cornerLength);

    canvas.drawPath(path, paint);
  }

  @override
  // --- MODIFICATION ---: Repaint if the success state changes
  bool shouldRepaint(ScannerBoxPainter oldDelegate) {
    return oldDelegate.isSuccess != isSuccess;
  }
}
