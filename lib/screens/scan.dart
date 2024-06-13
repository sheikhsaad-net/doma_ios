import 'dart:typed_data';

import 'package:doma_church_frontend/screens/splash.dart';
import 'package:flutter/material.dart';
import 'package:doma_church_frontend/widget/nav.dart';
import 'package:doma_church_frontend/widget/profile.dart';
import 'package:doma_church_frontend/widget/menu.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:url_launcher/url_launcher.dart';

class MyScan extends StatelessWidget {
  const MyScan({super.key});

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
                      'Scan barcode',
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
                  Positioned(
                    top: 200, // Adjust this value for desired placement
                    left: 30,
                    right: 30,
                    bottom: 300,
                    child: MobileScanner(
                      controller: MobileScannerController(
                        detectionSpeed: DetectionSpeed.noDuplicates,
                      ),
                      onDetect: (capture) {
                        final List<Barcode> barcodes = capture.barcodes;
                        // ignore: unused_local_variable
                        final Uint8List? image = capture.image;
                        for (final barcode in barcodes) {
                          debugPrint('Barcode found! ${barcode.rawValue}');
                          final url = barcode.rawValue;
                          // Navigate to splash screen
                          Navigator.of(context)
                              .pushReplacement(MaterialPageRoute(
                            builder: (context) =>
                                const SplashScreen(), // Replace SplashScreen with your actual splash screen widget
                          ));
                          // Wait for a short duration, then launch the URL
                          Future.delayed(const Duration(seconds: 1), () {
                            launchUrl(Uri.parse(url!),
                                mode: LaunchMode.platformDefault);
                          });
                        }
                      },
                    ),
                  ),
                  const Positioned(
                    bottom: 250,
                    left: 30, // Adjust this value for desired placement
                    child: Text(
                      'Scan any barcode for audio...',
                      style: TextStyle(color: Colors.white, fontSize: 22),
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
