import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'providers/forensic_provider.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'screens/scan_screen.dart';
import 'screens/result_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  if (!kIsWeb && (Platform.isWindows || Platform.isLinux || Platform.isMacOS)) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }

  runApp(
    ChangeNotifierProvider(
      create: (_) => ForensicProvider(),
      child: const DeepfakeApp(),
    ),
  );
}

class DeepfakeApp extends StatelessWidget {
  const DeepfakeApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Deepfake Forensic App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: const Color(0xff0f172a), // Primary Dark Slate
        scaffoldBackgroundColor: const Color(0xfff8fafc), // Background Light
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xff0f766e), // Deep Teal
          primary: const Color(0xff0f172a),
          secondary: const Color(0xff0f766e),
        ),
        textTheme: GoogleFonts.interTextTheme(
          Theme.of(context).textTheme,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xff0f172a),
          foregroundColor: Colors.white,
          elevation: 0,
        ),
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginScreen(),
        '/home': (context) => const HomeScreen(),
        '/scan': (context) => const ScanScreen(),
        '/result': (context) => const ResultScreen(),
      },
    );
  }
}
