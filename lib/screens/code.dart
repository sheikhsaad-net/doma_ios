import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:doma_church_frontend/widget/nav.dart';
import 'package:doma_church_frontend/widget/profile.dart';
import 'package:doma_church_frontend/widget/menu.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyCode extends StatelessWidget {
  const MyCode({super.key});

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
                      'assets/page-light.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 110, left: 30),
                    child: Text(
                      'Tour Completo',
                      style: TextStyle(color: Colors.white, fontSize: 28),
                    ),
                  ),
                  // Slider with Developers Section
                  Positioned(
                    top: 180, // Adjust the top position as needed
                    left: 30,
                    right: 30,
                    child: Container(
                      color: Colors.white,
                      child: CarouselSlider(
                        options: CarouselOptions(
                          height: 480, // Adjust the height as needed
                          viewportFraction: 1,
                          enlargeCenterPage: false,
                          enableInfiniteScroll: false,
                        ),
                        items: [
                          _buildDeveloperSection(
                            context,
                            'Caravaggio Experience',
                            'assets/tour.png',
                            'Caravaggio',
                            'assets/barcode.png',
                          ),
                          _buildDeveloperSection(
                            context,
                            'Experience 1',
                            'assets/001tour.png',
                            'Storia di Piazza S.Domenico',
                            'assets/001barcode.png',
                          ),
                          _buildDeveloperSection(
                            context,
                            'Experience 2',
                            'assets/002tour.png',
                            'Contenuti Cappella Carafa',
                            'assets/002barcode.png',
                          ),
                          _buildDeveloperSection(
                            context,
                            'Experience 3',
                            'assets/003tour.png',
                            'Contenuti Cappella Brancaccio',
                            'assets/003barcode.png',
                          ),
                          _buildDeveloperSection(
                            context,
                            'Experience 4',
                            'assets/004tour.png',
                            'Esplorazione Ballatoio Sagrestia',
                            'assets/004barcode.png',
                          ),
                          _buildDeveloperSection(
                            context,
                            'Experience 5',
                            'assets/005tour.png',
                            'Cripta',
                            'assets/005barcode.png',
                          ),
                          _buildDeveloperSection(
                            context,
                            'Experience 6',
                            'assets/006tour.png',
                            'Antica Biblioteca',
                            'assets/006barcode.png',
                          ),
                          _buildDeveloperSection(
                            context,
                            'Stop Experience',
                            'assets/tour.png',
                            'Stop',
                            'assets/stopbarcode.png',
                          ),
                        ],
                      ),
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
                                  curve: Curves.easeInOut,
                                )),
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
                                  curve: Curves.easeInOut,
                                )),
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

  Widget _buildDeveloperSection(
    BuildContext context,
    String heading,
    String imagePath,
    String subheading,
    String codePath,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, // Align items to the left
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, top: 10),
          child: Text(
            heading,
            style: const TextStyle(
              color: Color(0xFF222222),
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Expanded(
          child: Image.asset(
            imagePath,
            fit: BoxFit.cover, // Ensure the image covers the entire width
          ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.only(left: 20, top: 10),
          child: Text(
            subheading,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 22,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Expanded(
          child: Image.asset(
            codePath,
            fit: BoxFit.cover, // Ensure the image covers the entire width
          ),
        ),
        const SizedBox(height: 15),
      ],
    );
  }

  Future<bool> checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    return isLoggedIn;
  }
}
