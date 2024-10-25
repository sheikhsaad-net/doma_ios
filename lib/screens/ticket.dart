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
                    padding: const EdgeInsets.only(top: 80, left: 30),
                    child: const Text(
                      'I miei Ticket',
                      style: TextStyle(color: Colors.white, fontSize: 28),
                    ),
                  ),
                  SingleChildScrollView(
                    padding: const EdgeInsets.only(
                      top: 140,
                      left: 30,
                      right: 30,
                      bottom: 250,
                    ), // Adjust top padding
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context,
                                'code'); // Change the route if necessary
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset(
                                'assets/tour.png',
                              ),
                              const SizedBox(height: 10),
                              const Text(
                                'Tour completo - Italiano',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                            height: 20), // Space between two GestureDetectors
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context,
                                'code_en'); // Change the route if necessary
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset(
                                'assets/tour.png',
                              ),
                              const SizedBox(height: 10),
                              const Text(
                                'Complete Tour - English',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Background Container for the Icons
                  Positioned(
                    left: 0,
                    right: 0,
                    child: Container(
                      color: const Color(
                          0xFF262626), // Change this to your desired color
                      padding: const EdgeInsets.fromLTRB(
                          20, 20, 20, 10), // Adjust the top padding here
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Box Icon (Menu)
                          IconButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return Align(
                                    alignment: Alignment.topLeft,
                                    child: SlideTransition(
                                      position: Tween<Offset>(
                                        begin: const Offset(-1.0, 0.0),
                                        end: Offset.zero,
                                      ).animate(
                                        CurvedAnimation(
                                          parent: ModalRoute.of(context)!
                                              .animation!,
                                          curve: Curves.easeInOut,
                                        ),
                                      ),
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
                          // Profile Icon
                          IconButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return Align(
                                    alignment: Alignment.topRight,
                                    child: SlideTransition(
                                      position: Tween<Offset>(
                                        begin: const Offset(1.0, 0.0),
                                        end: Offset.zero,
                                      ).animate(
                                        CurvedAnimation(
                                          parent: ModalRoute.of(context)!
                                              .animation!,
                                          curve: Curves.easeInOut,
                                        ),
                                      ),
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
                        ],
                      ),
                    ),
                  ),
                  // Navigation Bar
                  const MyNavBar(),
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
