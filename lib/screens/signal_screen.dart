// lib/signal_screen.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Enum pour gérer le mode
enum SignalMode { initial, camera, scan }

class SignalScreen extends StatefulWidget {
  final SignalMode initialMode;
  const SignalScreen({Key? key, this.initialMode = SignalMode.initial})
      : super(key: key);

  @override
  _SignalScreenState createState() => _SignalScreenState();
}

class _SignalScreenState extends State<SignalScreen> {
  // État
  late SignalMode _currentMode;
  String? _selectedType;
  final List<String> _taskTypes = [
    'Risque',
    'Maladie',
    'Tâche à effectuer',
    'Autre',
  ];

  // Contrôleurs
  final _taskController = TextEditingController();
  final _commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _currentMode = widget.initialMode;
  }

  @override
  void dispose() {
    _taskController.dispose();
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: _buildCleanAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            _buildIconSelector(),
            const SizedBox(height: 40),
            _buildSectionTitle('Type'),
            const SizedBox(height: 8),
            _buildTypeDropdown(),
            const SizedBox(height: 24),
            _buildSectionTitle('Tâche à effectuer'),
            const SizedBox(height: 8),
            _buildTextField(
              controller: _taskController,
              hint: 'Décrivez la tâche…',
            ),
            const SizedBox(height: 24),
            _buildSectionTitle('Commentaire'),
            const SizedBox(height: 8),
            _buildTextField(
              controller: _commentController,
              hint: 'Ajoutez un commentaire…',
              maxLines: 4,
            ),
            const SizedBox(height: 40),
            _buildSubmitButton(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // -------------------- UI BUILDERS --------------------
  PreferredSizeWidget _buildCleanAppBar() => AppBar(
        backgroundColor: const Color(0xFFF8F9FA),
        elevation: 0,
        leading: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFF396148),
            borderRadius: BorderRadius.circular(12),
          ),
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new,
                color: Colors.white, size: 20),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        title: Text(
          'Signalement',
          style: GoogleFonts.inter(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF1F2937)),
        ),
        centerTitle: true,
      );

  Widget _buildIconSelector() {
    if (_currentMode == SignalMode.camera) {
      return Center(
          child: _buildIconChoice(Icons.camera_alt, 'Prendre photo',
              isSelected: true));
    } else if (_currentMode == SignalMode.scan) {
      return Center(
          child: _buildIconChoice(Icons.qr_code_scanner, 'Scanner code',
              isSelected: true));
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        GestureDetector(
          onTap: () => setState(() => _currentMode = SignalMode.camera),
          child: _buildIconChoice(Icons.camera_alt, 'Prendre photo'),
        ),
        GestureDetector(
          onTap: () => setState(() => _currentMode = SignalMode.scan),
          child: _buildIconChoice(Icons.qr_code_scanner, 'Scanner code'),
        ),
      ],
    );
  }

  Widget _buildIconChoice(IconData icon, String label,
          {bool isSelected = false}) =>
      Column(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: isSelected ? const Color(0xFF396148) : Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: isSelected
                      ? const Color(0xFF396148).withOpacity(0.2)
                      : Colors.black.withOpacity(0.05),
                  blurRadius: isSelected ? 12 : 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Icon(icon,
                size: 32,
                color: isSelected ? Colors.white : const Color(0xFF6B7280)),
          ),
          const SizedBox(height: 12),
          Text(label,
              style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF6B7280))),
        ],
      );

  Widget _buildSectionTitle(String title) => Text(title,
      style: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: const Color(0xFF1F2937)));

  Widget _buildTypeDropdown() => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 8,
                offset: const Offset(0, 2)),
          ],
        ),
        child: DropdownButtonFormField<String>(
          value: _selectedType,
          items: _taskTypes
              .map((type) => DropdownMenuItem(
                    value: type,
                    child: Text(type,
                        style: GoogleFonts.inter(
                            fontSize: 16, color: const Color(0xFF374151))),
                  ))
              .toList(),
          onChanged: (v) => setState(() => _selectedType = v),
          decoration: InputDecoration(
            hintText: 'Sélectionner un type',
            hintStyle:
                GoogleFonts.inter(fontSize: 16, color: const Color(0xFF9CA3AF)),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          ),
        ),
      );

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    int maxLines = 1,
  }) =>
      Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 8,
                offset: const Offset(0, 2)),
          ],
        ),
        child: TextField(
          controller: controller,
          maxLines: maxLines,
          style:
              GoogleFonts.inter(fontSize: 16, color: const Color(0xFF374151)),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle:
                GoogleFonts.inter(fontSize: 16, color: const Color(0xFF9CA3AF)),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide:
                    const BorderSide(color: Color(0xFF396148), width: 2)),
            contentPadding: const EdgeInsets.all(16),
          ),
        ),
      );

  Widget _buildSubmitButton() => SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            _submitForm();
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF396148),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              elevation: 2),
          child: Text('Envoyer',
              style:
                  GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600)),
        ),
      );

  // ----------------------- LOGIQUE -----------------------
  void _submitForm() {
    // Votre logique d'envoi
    print('Formulaire envoyé :');
    print('Mode: $_currentMode');
    print('Type: $_selectedType');
    print('Tâche: ${_taskController.text}');
    print('Commentaire: ${_commentController.text}');
  }
}
