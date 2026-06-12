import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff8fafc), // Background Light
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Security Icon
                const Icon(
                  Icons.shield_outlined,
                  size: 96,
                  color: Color(0xff0f172a), // Primary Dark Slate
                ),
                const SizedBox(height: 16),
                
                // App Title
                Text(
                  "Deepfake Forensic",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xff0f172a),
                  ),
                ),
                const SizedBox(height: 8),
                
                // App Subtitle
                Text(
                  "Sistem Verifikasi Citra Wajah & AI Consultant",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: const Color(0xff64748b), // Muted Text
                  ),
                ),
                const SizedBox(height: 40),
                
                // Email field
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  style: GoogleFonts.inter(fontSize: 14),
                  decoration: InputDecoration(
                    labelText: "Email Pengguna",
                    labelStyle: GoogleFonts.inter(color: const Color(0xff64748b)),
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: const Icon(Icons.email_outlined, color: Color(0xff64748b)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(color: Color(0xffe2e8f0)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(color: Color(0xffe2e8f0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(color: Color(0xff0f766e), width: 1.5),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Masukkan email Anda";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                
                // Password field
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  style: GoogleFonts.inter(fontSize: 14),
                  decoration: InputDecoration(
                    labelText: "Kata Sandi",
                    labelStyle: GoogleFonts.inter(color: const Color(0xff64748b)),
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: const Icon(Icons.lock_outline, color: Color(0xff64748b)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(color: Color(0xffe2e8f0)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(color: Color(0xffe2e8f0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(color: Color(0xff0f766e), width: 1.5),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Masukkan kata sandi Anda";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 32),
                
                // Login button
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      if (_emailController.text.trim() == 'admin@forensic.id' && 
                          _passwordController.text == 'admin123') {
                        Navigator.pushReplacementNamed(context, '/home');
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Email atau Kata Sandi salah! Gunakan: admin@forensic.id / admin123',
                              style: GoogleFonts.inter(),
                            ),
                            backgroundColor: Colors.redAccent,
                          ),
                        );
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff0f766e), // Deep Teal
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    "Masuk ke Sistem Keamanan",
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  "Demo Akun: admin@forensic.id | Sandi: admin123",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    color: const Color(0xff94a3b8),
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
