import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:doma_church_frontend/services/auth_services.dart';

class MyProfile extends StatelessWidget {
  const MyProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: checkLoginStatus(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasData && snapshot.data == true) {
          return _buildProfile(context);
        } else {
          // Handle error or not logged in
          return const SizedBox(); // Return an empty SizedBox
        }
      },
    );
  }

  Widget _buildProfile(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
          top: 50, left: 35), // Add padding for better visibility
      color: const Color(0xFFD2BB84),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 20),
          _buildMenuItem(Icons.calendar_month_outlined, 'I miei ticket', () {
            // Handle onTap for Home
          }),
          const SizedBox(height: 20),
          _buildMenuItem(Icons.account_box_outlined, 'Account', () {
            // Handle onTap for Settings
          }),
          const SizedBox(height: 20),
          _buildMenuItem(Icons.info_outline, 'Info', () {
            // Handle onTap for Settings
          }),
          const SizedBox(height: 350),
          _buildMenuItem(Icons.settings, 'Impostazioni', () {
            // Handle onTap for Settings
          }),
          const SizedBox(height: 20),
          _buildMenuItem(Icons.password_outlined, 'Cambio Password', () {
            // Handle onTap for Settings
          }),
          const SizedBox(height: 20),
          _buildMenuItem(Icons.logout_outlined, 'Logout', () async {
            await _logout(context);
          }),
          // Add more menu items here
        ],
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.white, // Set icon color to white
          ),
          const SizedBox(width: 8.0), // Space between icon and text
          Text(
            title,
            style: const TextStyle(
                fontSize: 16,
                color: Color.fromARGB(255, 255, 255, 255),
                decoration: TextDecoration.none),
          ),
        ],
      ),
    );
  }

  Future<bool> checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    return isLoggedIn;
  }

  Future<void> _logout(BuildContext context) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
      if (isLoggedIn) {
        await AuthServices().logout();
        // ignore: use_build_context_synchronously
        Navigator.pushReplacementNamed(context, 'welcome');
      } else {
        // ignore: avoid_print
        print('User is not logged in. Logout failed.');
      }
    } catch (e) {
      // ignore: avoid_print
      print('Error during logout: $e');
    }
  }
}
