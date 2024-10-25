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
                  Positioned.fill(
                    child: Image.asset(
                      'assets/page-light.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  // Heading
                  Container(
                    padding: const EdgeInsets.only(top: 80, left: 30),
                    child: const Text(
                      'Tour Completo - Italiano',
                      style: TextStyle(color: Colors.white, fontSize: 28),
                    ),
                  ),
                  SingleChildScrollView(
                    padding: const EdgeInsets.only(
                      top: 130,
                      left: 30,
                      right: 30,
                      bottom: 250,
                    ), // Adjust top padding
                    child: Column(
                      // Wrap in Column for multiple children in the scroll view
                      children: [
                        Container(
                          color: Colors.white,
                          child: CarouselSlider(
                            options: CarouselOptions(
                              height: 480, // Adjust the height as needed
                              viewportFraction: 1,
                              enlargeCenterPage: true,
                              enableInfiniteScroll: false,
                            ),
                            items: [
                              _buildDeveloperSection(
                                context,
                                'Caravaggio Experience (IT)',
                                'assets/tour/caravaggio.png',
                                'Caravaggio',
                                'assets/tour/barcode.png',
                              ),
                              _buildDeveloperSection(
                                context,
                                'Experience 1 (IT)',
                                'assets/tour/001tour.png',
                                'Storia di Piazza S.Domenico',
                                'assets/tour/001barcode.png',
                              ),
                              _buildDeveloperSection(
                                context,
                                'Experience 2 (IT)',
                                'assets/tour/002tour.png',
                                'Contenuti Cappella Carafa',
                                'assets/tour/002barcode.png',
                              ),
                              _buildDeveloperSection(
                                context,
                                'Experience 3 (IT)',
                                'assets/tour/003tour.png',
                                'Contenuti Cappella Brancaccio',
                                'assets/tour/003barcode.png',
                              ),
                              _buildDeveloperSection(
                                context,
                                'Experience 4 (IT)',
                                'assets/tour/004tour.png',
                                'Esplorazione Ballatoio Sagrestia',
                                'assets/tour/004barcode.png',
                              ),
                              _buildDeveloperSection(
                                context,
                                'Experience 5 (IT)',
                                'assets/tour/005tour.png',
                                'Cripta',
                                'assets/tour/005barcode.png',
                              ),
                              _buildDeveloperSection(
                                context,
                                'Experience 6 (IT)',
                                'assets/tour/006tour.png',
                                'Antica Biblioteca',
                                'assets/tour/006barcode.png',
                              ),
                              _buildDeveloperSection(
                                context,
                                'Mute Experience',
                                'assets/tour/tour.png',
                                'Mute',
                                'assets/tour/mutebarcode.png',
                              ),
                              _buildDeveloperSection(
                                context,
                                'Stop Experience',
                                'assets/tour/tour.png',
                                'Stop',
                                'assets/tour/stopbarcode.png',
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    child: Container(
                      color: const Color(
                          0xFFd2bb84), // Change this to your desired color
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
