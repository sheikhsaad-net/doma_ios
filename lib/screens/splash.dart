import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Updated delay to 1500 milliseconds
    Future.delayed(const Duration(milliseconds: 1500), () {
      checkLoginStatus();
    });
  }

  Future<void> checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    if (isLoggedIn) {
      // If logged in, navigate to home
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushReplacementNamed('home');
    } else {
      // If not logged in, navigate to welcome
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushReplacementNamed('welcome');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffd2bb84),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/logo.png', width: 120),
          ],
        ),
      ),
    );
  }
}
