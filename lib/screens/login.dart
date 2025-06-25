// --------------------------- login_page.dart ---------------------------
// Écran de connexion :
// 1. Bandeau image.
// 2. Validation e-mail / mot de passe avec un <Form>.
// 3. Redirection selon le domaine :
//    • @entretien.com    → HammaHomeScreen
//    • @multiplication.com → SophianeHomeScreen
//    • @collection.com   → DashboardScreen

import 'package:flutter/material.dart';
import 'entretien.dart'; // ← HammaHomeScreen
import 'multiplication.dart'; // ← SophianeHomeScreen
import 'collection.dart'; // ← DashboardScreen

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // ------------------- bandeau -------------------
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(100),
                  bottomRight: Radius.circular(100),
                ),
                child: SizedBox(
                  height: 200,
                  width: double.infinity,
                  child: Image.asset(
                    'assets/images/hamma.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 40),

              // ------------------- formulaire ----------------
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Titre
                      const Text(
                        'Connexion\nà votre compte',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF396148),
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: 40),

                      // ---------- E-mail ----------
                      _decoratedField(
                        child: TextFormField(
                          controller: _emailCtrl,
                          keyboardType: TextInputType.emailAddress,
                          decoration: _inputDeco(
                            hint: 'Adresse e-mail',
                            prefix: Icons.email_outlined,
                          ),
                          validator: (v) => v != null && v.contains('@')
                              ? null
                              : 'E-mail invalide',
                        ),
                      ),
                      const SizedBox(height: 16),

                      // ---------- Mot de passe ----------
                      _decoratedField(
                        child: TextFormField(
                          controller: _passwordCtrl,
                          obscureText: !_isPasswordVisible,
                          decoration: _inputDeco(
                            hint: 'Mot de passe',
                            prefix: Icons.lock_outline,
                            isPassword: true,
                          ),
                          validator: (v) => v != null && v.length >= 4
                              ? null
                              : 'Minimum 4 caractères',
                        ),
                      ),
                      const SizedBox(height: 16),

                      // ---------- Mot de passe oublié ----------
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Mot de passe oublié ? ',
                            style: TextStyle(
                              color: Color(0xFF718096),
                              fontSize: 14,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              // TODO : contacter les RH
                            },
                            child: const Text(
                              'Contacter les RH',
                              style: TextStyle(
                                color: Color(0xFF396148),
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),

                      // ---------- Bouton connexion ----------
                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
                          onPressed: _handleLogin,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF396148),
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            'Se connecter',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ----------------------- helpers UI -----------------------
  Widget _decoratedField({required Widget child}) => Container(
        decoration: BoxDecoration(
          color: const Color(0xFFF7FAFC),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFE2E8F0)),
        ),
        child: child,
      );

  InputDecoration _inputDeco({
    required String hint,
    required IconData prefix,
    bool isPassword = false,
  }) =>
      InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(
          color: Color(0xFF718096),
          fontSize: 16,
        ),
        prefixIcon: Icon(prefix, color: const Color(0xFF718096)),
        suffixIcon: isPassword
            ? IconButton(
                icon: Icon(
                  _isPasswordVisible
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  color: const Color(0xFF718096),
                ),
                onPressed: () =>
                    setState(() => _isPasswordVisible = !_isPasswordVisible),
              )
            : null,
        border: InputBorder.none,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      );

  // ----------------------- login logic ---------------------
  void _handleLogin() {
    if (!_formKey.currentState!.validate()) return;

    final email = _emailCtrl.text.trim().toLowerCase();
    late final Widget destination;

    if (email.endsWith('@entretien.com')) {
      destination = const HammaHomeScreen();
    } else if (email.endsWith('@multiplication.com')) {
      destination = const SophianeHomeScreen();
    } else if (email.endsWith('@collection.com')) {
      destination = const DashboardScreen();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Domaine d’e-mail non reconnu')),
      );
      return;
    }

    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => destination),
      (_) => false,
    );
  }

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }
}
