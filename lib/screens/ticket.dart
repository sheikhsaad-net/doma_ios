import 'package:flutter/material.dart';
import 'package:doma_church_frontend/widget/nav.dart';
import 'package:doma_church_frontend/widget/profile.dart';
import 'package:doma_church_frontend/widget/menu.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyTicket extends StatelessWidget {
  const MyTicket({super.key});

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
        } else if (snapshot.hasData) {
          bool isLoggedIn = snapshot.data!;
          if (isLoggedIn) {
            return Scaffold(
              body: Stack(
                children: [
                  // Background Image
                  Positioned.fill(
                    child: Image.asset(
                      'assets/page-dark.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 110, left: 30),
                    child: const Text(
                      'I miei Ticket',
                      style: TextStyle(color: Colors.white, fontSize: 28),
                    ),
                  ),
                  // Box Icon
                  Positioned(
                    top: 50,
                    left: 20,
                    child: IconButton(
                      onPressed: () {
                        // Show profile modal with slide-in animation
                        showDialog(
                          context: context,
                          builder: (context) {
                            return Align(
                              alignment: Alignment.topLeft,
                              child: SlideTransition(
                                position: Tween<Offset>(
                                  begin: const Offset(-1.0,
                                      0.0), // Changed offset to start from left
                                  end: Offset.zero,
                                ).animate(CurvedAnimation(
                                    parent: ModalRoute.of(context)!.animation!,
                                    curve: Curves.easeInOut)),
                                child: const FractionallySizedBox(
                                  widthFactor: 0.7,
                                  heightFactor: 1,
                                  child: MyMenu(),
                                ),
                              ),
                            );
                          },
                        );
                      },
                      icon: const Icon(
                        Icons.grid_view_sharp,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ),
                  // Profile Icon
                  Positioned(
                    top: 50,
                    right: 20,
                    child: IconButton(
                      onPressed: () {
                        // Show profile modal with slide-in animation
                        showDialog(
                          context: context,
                          builder: (context) {
                            return Align(
                              alignment: Alignment.topRight,
                              child: SlideTransition(
                                position: Tween<Offset>(
                                  begin: const Offset(1.0, 0.0),
                                  end: Offset.zero,
                                ).animate(CurvedAnimation(
                                    parent: ModalRoute.of(context)!.animation!,
                                    curve: Curves.easeInOut)),
                                child: const FractionallySizedBox(
                                  widthFactor: 0.7,
                                  heightFactor: 2,
                                  child: MyProfile(),
                                ),
                              ),
                            );
                          },
                        );
                      },
                      icon: const Icon(
                        Icons.account_circle_outlined,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ),
                  // Navigation Bar
                  const MyNavBar(),
                  Positioned(
                    top: 180,
                    left: 32,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, 'code');
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(
                            'assets/tour.png',
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'Tour Completo',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const Scaffold(
              body: Center(
                child: Text('Please login to access the home.'),
              ),
            );
          }
        } else {
          return const Scaffold(
            body: Center(
              child: Text('Error retrieving login status'),
            ),
          );
        }
      },
    );
  }

  Future<bool> checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    return isLoggedIn;
  }
}
