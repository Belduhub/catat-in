import 'package:flutter/material.dart';
import 'controllers/auth_controller.dart';
import 'views/login_page.dart';
import 'views/dashboard_page.dart';

// Conditional import: use stub for web, io for native
import 'database_init_stub.dart'
    if (dart.library.io) 'database_init_io.dart';

void main() async {
  // Ensure Flutter is initialized first
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize database (implementation differs per platform)
  await initializeDatabase();
  
  runApp(const CatatinApp());
}

/// CatatinApp - Main application widget
class CatatinApp extends StatelessWidget {
  const CatatinApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'catat.in',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Inter',
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}

/// SplashScreen - Screen untuk cek session dan navigate ke page yang sesuai
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final AuthController _authController = AuthController();

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    // Delay untuk splash effect
    await Future.delayed(const Duration(seconds: 2));

    // Check jika user sudah login
    final isLoggedIn = await _authController.isLoggedIn();

    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              isLoggedIn ? const DashboardPage() : const LoginPage(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FF),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // App Icon
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: const Color(0xFF0061A4).withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.note_alt,
                size: 60,
                color: Color(0xFF0061A4),
              ),
            ),
            const SizedBox(height: 24),
            
            // App Name
            const Text(
              'catat.in',
              style: TextStyle(
                color: Color(0xFF0061A4),
                fontSize: 32,
                fontFamily: 'Hanken Grotesk',
                fontWeight: FontWeight.w700,
                letterSpacing: -0.64,
              ),
            ),
            const SizedBox(height: 8),
            
            // Tagline
            const Text(
              'Satu tempat untuk semua gagasan Anda',
              style: TextStyle(
                color: Color(0xFF404752),
                fontSize: 14,
                fontFamily: 'Inter',
              ),
            ),
            const SizedBox(height: 32),
            
            // Loading Indicator
            const CircularProgressIndicator(
              color: Color(0xFF0061A4),
            ),
          ],
        ),
      ),
    );
  }
}
