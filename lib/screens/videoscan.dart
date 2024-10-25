import 'package:flutter/material.dart';
import 'package:doma_church_frontend/widget/nav.dart';
import 'package:doma_church_frontend/widget/profile.dart';
import 'package:doma_church_frontend/widget/menu.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class VideoScan extends StatelessWidget {
  const VideoScan({super.key});

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
                  // Box Icon
                  Positioned(
                    top: 20,
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
                                  begin: const Offset(-1.0, 0.0),
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
                    top: 20,
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
                  Container(
                    padding: const EdgeInsets.only(top: 80, left: 30),
                    child: const Text(
                      'Scegli Cappella',
                      style: TextStyle(color: Colors.white, fontSize: 28),
                    ),
                  ),
                  // New Row with Images and Text
                  Positioned(
                    top: 150,
                    left: 30,
                    right: 30,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () async {
                              const url =
                                  'https://doma.immensive.it/public/audio/cappella-brancaccio/'; // Replace with your URL
                              launchUrl(
                                Uri.parse(url),
                                mode: LaunchMode
                                    .inAppWebView, // Opens the URL in the external browser
                              );
                            },
                            child: Container(
                              margin: const EdgeInsets.only(right: 20),
                              child: Column(
                                children: [
                                  Image.asset(
                                    'assets/cappella_brancaccio.png', // Path to your image
                                    width: 250,
                                    height: 250,
                                  ),
                                  const Text(
                                    'Cappella Brancaccio',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () async {
                              const url =
                                  'https://doma.immensive.it/public/audio/cappella-carafa/'; // Replace with your URL
                              launchUrl(
                                Uri.parse(url),
                                mode: LaunchMode
                                    .inAppWebView, // Opens the URL in the external browser
                              );
                            },
                            child: Column(
                              children: [
                                Image.asset(
                                  'assets/cappella_g_bruno.png', // Path to your image
                                  width: 250,
                                  height: 250,
                                ),
                                const Text(
                                  'Cappella Carafa',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 480, // Adjust the position based on your layout
                    left: 30,
                    right: 30,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, 'scan');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color(0xFFd2bb84), // Background color
                        padding: const EdgeInsets.symmetric(
                            vertical: 15), // Button height
                      ),
                      child: const Text(
                        'Vai alla cappella', // Change this to your desired text
                        style:
                            TextStyle(color: Color(0xFFFFFFFF)), // Text color
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
