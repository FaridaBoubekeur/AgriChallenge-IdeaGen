import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../widgets/nav_bar.dart';
import '../widgets/topnavbar.dart';

class IrrigationScreen extends StatefulWidget {
  const IrrigationScreen({Key? key}) : super(key: key);

  @override
  _IrrigationScreenState createState() => _IrrigationScreenState();
}

class _IrrigationScreenState extends State<IrrigationScreen> {
  final MapController _mapController = MapController();

  // Tree locations with their irrigation urgency
  List<TreeLocation> trees = [
    TreeLocation(
      id: 'C11-001',
      name: 'Carroubier C11',
      position: LatLng(6.5244, 3.3792),
      isDone: true,
      urgency: IrrigationUrgency.low,
      lastWatered: '2 jours',
      moistureLevel: 75,
    ),
    TreeLocation(
      id: 'C11-002',
      name: 'Carroubier C11',
      position: LatLng(6.5250, 3.3800),
      isDone: true,
      urgency: IrrigationUrgency.medium,
      lastWatered: '4 jours',
      moistureLevel: 45,
    ),
    TreeLocation(
      id: 'C11-003',
      name: 'Carroubier C11',
      position: LatLng(6.5255, 3.3785),
      isDone: false,
      urgency: IrrigationUrgency.high,
      lastWatered: '7 jours',
      moistureLevel: 15,
    ),
    TreeLocation(
      id: 'C11-004',
      name: 'Carroubier C11',
      position: LatLng(6.5248, 3.3795),
      isDone: true,
      urgency: IrrigationUrgency.low,
      lastWatered: '1 jour',
      moistureLevel: 85,
    ),
    TreeLocation(
      id: 'C11-005',
      name: 'Palmier Royal',
      position: LatLng(6.5260, 3.3790),
      isDone: false,
      urgency: IrrigationUrgency.high,
      lastWatered: '6 jours',
      moistureLevel: 20,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: CommonTopNavBar(
        onNotificationPressed: () {
          print('Notifications tapped on Irrigation');
        },
        onButtonPressed: () {
          print('Signaler button tapped on Irrigation');
        },
      ),
      body: Column(
        children: [
          // Page Title
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Text(
              'Irrigation',
              style: TextStyle(
                color: Colors.black,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          // Interactive Map Section
          Container(
            height: 300,
            margin: EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: FlutterMap(
                mapController: _mapController,
                options: MapOptions(
                  center: LatLng(6.5244, 3.3792), // Lagos coordinates
                  zoom: 16.0,
                  interactiveFlags: InteractiveFlag.all,
                  onTap: (tapPosition, point) {
                    _showFullScreenMap();
                  },
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'com.example.irrigation_app',
                  ),
                  MarkerLayer(
                    markers: _buildMarkers(),
                  ),
                ],
              ),
            ),
          ),

          // Trees Section
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Arbres',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 16),
                  Expanded(
                    child: ListView.builder(
                      itemCount: trees.length,
                      itemBuilder: (context, index) {
                        return _buildTreeItem(trees[index]);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Submit Button - Small and positioned at right
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            alignment: Alignment.centerRight,
            child: SizedBox(
              width: 120,
              height: 40,
              child: ElevatedButton(
                onPressed: () {
                  _showSubmitDialog();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF396148),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 2,
                ),
                child: Text(
                  'Soumettre',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: const CommonGradientFab(),
      bottomNavigationBar: const CommonBottomNavBar(
        activeIndex: 2, // Set appropriate index for this page
      ),
    );
  }

  List<Marker> _buildMarkers() {
    return trees.map((tree) {
      Color markerColor = _getMarkerColor(tree.urgency);
      return Marker(
        point: tree.position,
        child: GestureDetector(
          onTap: () {
            _onMarkerTap(tree);
          },
          child: Container(
            child: Stack(
              children: [
                Icon(
                  Icons.eco,
                  color: markerColor,
                  size: 35,
                ),
                if (tree.urgency == IrrigationUrgency.high)
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 1),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      );
    }).toList();
  }

  Color _getMarkerColor(IrrigationUrgency urgency) {
    switch (urgency) {
      case IrrigationUrgency.low:
        return Color(0xFF4CAF50); // Green
      case IrrigationUrgency.medium:
        return Color(0xFFFF9800); // Orange
      case IrrigationUrgency.high:
        return Color(0xFFE53935); // Red
    }
  }

  void _onMarkerTap(TreeLocation tree) async {
    // Zoom to marker
    _mapController.move(tree.position, 18.0);

    // Wait a moment for zoom animation
    await Future.delayed(Duration(milliseconds: 500));

    // Show detailed popup
    _showEnhancedTreeDetails(tree);
  }

  Widget _buildTreeItem(TreeLocation tree) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Tree Icon
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Color(0xFF396148).withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(
              Icons.park,
              color: Color(0xFF396148),
              size: 24,
            ),
          ),
          SizedBox(width: 16),

          // Tree Info
          Expanded(
            child: Text(
              tree.name,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ),

          // Status Badge
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: _getMarkerColor(tree.urgency),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Text(
              tree.isDone ? 'Terminé' : _getUrgencyText(tree.urgency),
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getUrgencyText(IrrigationUrgency urgency) {
    switch (urgency) {
      case IrrigationUrgency.low:
        return 'Faible';
      case IrrigationUrgency.medium:
        return 'Moyen';
      case IrrigationUrgency.high:
        return 'Urgent';
    }
  }

  void _showFullScreenMap() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.close, color: Colors.black),
              onPressed: () => Navigator.pop(context),
            ),
            title: Text(
              'Carte complète',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
            ),
          ),
          body: FlutterMap(
            options: MapOptions(
              center: LatLng(6.5244, 3.3792),
              zoom: 15.0,
              interactiveFlags: InteractiveFlag.all,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.irrigation_app',
              ),
              MarkerLayer(
                markers: _buildMarkers(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showEnhancedTreeDetails(TreeLocation tree) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Tree Icon and Name
                Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: _getMarkerColor(tree.urgency).withOpacity(0.2),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Icon(
                        Icons.eco,
                        color: _getMarkerColor(tree.urgency),
                        size: 30,
                      ),
                    ),
                    SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            tree.name,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            tree.id,
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 20),

                // Irrigation Details
                Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      _buildDetailRow('Urgence', _getUrgencyText(tree.urgency),
                          _getMarkerColor(tree.urgency)),
                      SizedBox(height: 10),
                      _buildDetailRow('Dernier arrosage', tree.lastWatered,
                          Colors.grey[700]!),
                      SizedBox(height: 10),
                      _buildDetailRow(
                          'Humidité', '${tree.moistureLevel}%', Colors.blue),
                      SizedBox(height: 15),

                      // Moisture Level Bar
                      Container(
                        width: double.infinity,
                        height: 8,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: FractionallySizedBox(
                          widthFactor: tree.moistureLevel / 100,
                          alignment: Alignment.centerLeft,
                          child: Container(
                            decoration: BoxDecoration(
                              color: tree.moistureLevel > 60
                                  ? Colors.green
                                  : tree.moistureLevel > 30
                                      ? Colors.orange
                                      : Colors.red,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 20),

                // Action Buttons
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          'Fermer',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          _markAsWatered(tree);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF396148),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          'Arroser',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDetailRow(String label, String value, Color valueColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: valueColor,
          ),
        ),
      ],
    );
  }

  void _markAsWatered(TreeLocation tree) {
    setState(() {
      tree.isDone = true;
      tree.urgency = IrrigationUrgency.low;
      tree.lastWatered = 'Maintenant';
      tree.moistureLevel = 95;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${tree.name} marqué comme arrosé!'),
        backgroundColor: Color(0xFF396148),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  void _showSubmitDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text('Confirmer la soumission'),
          content: Text(
              'Êtes-vous sûr de vouloir soumettre le rapport d\'irrigation?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Annuler'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                _showSuccessSnackBar();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF396148),
              ),
              child: Text('Soumettre', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  void _showSuccessSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Rapport soumis avec succès!'),
        backgroundColor: Color(0xFF396148),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}

enum IrrigationUrgency {
  low,
  medium,
  high,
}

class TreeLocation {
  final String id;
  final String name;
  final LatLng position;
  bool isDone;
  IrrigationUrgency urgency;
  String lastWatered;
  int moistureLevel;

  TreeLocation({
    required this.id,
    required this.name,
    required this.position,
    required this.isDone,
    required this.urgency,
    required this.lastWatered,
    required this.moistureLevel,
  });
}
