import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyMenu extends StatelessWidget {
  const MyMenu({super.key});

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
          top: 50, left: 25), // Add padding for better visibility
      color: const Color(0xFFD2BB84),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 20),
          _buildMenuItem(Icons.calendar_month_outlined, 'Prenota', () {
            // Handle onTap for Home
          }),
          const SizedBox(height: 20),
          _buildMenuItem(Icons.integration_instructions_outlined, 'Regole', () {
            // Handle onTap for Settings
          }),
          const SizedBox(height: 20),
          _buildMenuItem(Icons.language_outlined, 'Lingua', () {
            // Handle onTap for Settings
          }),
          const SizedBox(height: 350),
          _buildMenuItem(Icons.contact_support, 'Contattaci', () {
            // Handle onTap for Settings
          }),
          const SizedBox(height: 20),
          _buildMenuItem(Icons.notes_outlined, 'Termini e condiioni', () {
            // Handle onTap for Settings
          }),
          const SizedBox(height: 20),
          _buildMenuItem(Icons.privacy_tip_outlined, 'Privacy Policy', () {
            // Handle onTap for Settings
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
}
