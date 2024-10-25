import 'package:flutter/material.dart';
import 'package:doma_church_frontend/widget/nav.dart';
import 'package:doma_church_frontend/widget/profile.dart';
import 'package:doma_church_frontend/widget/menu.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:photo_view/photo_view.dart';

class MyInfo extends StatelessWidget {
  const MyInfo({super.key});

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
                  // Heading
                  Container(
                    padding: const EdgeInsets.only(top: 80, left: 30),
                    child: const Text(
                      'Cappelle del DOMA',
                      style: TextStyle(color: Colors.white, fontSize: 28),
                    ),
                  ),
                  // Description
                  Container(
                    padding:
                        const EdgeInsets.only(top: 130, left: 30, right: 30),
                    child: const Text(
                      'Ogni cappella custodisce un frammento di storia.Scegli una cappella e scopri le opere in essa custodite.',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                  // Scrollable Buttons
                  SingleChildScrollView(
                    padding: const EdgeInsets.only(
                      top: 230,
                      left: 30,
                      right: 30,
                      bottom: 250,
                    ), // Adjust top padding
                    child: Container(
                      color: const Color(
                          0xFFd2bb84), // Set your desired background color here
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: List.generate(20, (index) {
                          // Define button names and image paths
                          final buttonNames = [
                            'ABSIDE',
                            'ALTARE DEI RICCIO',
                            'AMBIENTI DELL\'ANTICA CHIESA DI SAN MICHELE ARCANGELO A MORFISA',
                            'CAPPELLA DI ZÌ ANDREA',
                            'CAPPELLA BRANCACCIO',
                            'CAPPELLA DEL CROCEFISSO DEI CAPECE',
                            'CAPPELLA DELLA MADONNA DELLA NEVE',
                            'CAPPELLA DELLA NATIVITÀ',
                            'CAPPELLA DI SANTO STEFANO',
                            'CAPPELLA DI SAN BARTOLOMEO',
                            'CAPPELLA DI SAN CARLO BORROMEO',
                            'CAPPELLA DI SAN DOMENICO SORIANO',
                            'CAPPELLA DI SAN GIOVANNI BATTISTA',
                            'CAPPELLA DI SAN GIOVANNI EVANGELISTA',
                            'CAPPELLA DI SAN GIUSEPPE',
                            'CAPPELLA DI SAN NICOLA',
                            'CAPPELLA DI SANTA CATERINA DA SIENA',
                            'CAPPELLA DI SANTA CATERINA D\'ALESSANDRIA',
                            'CAPPELLA DI SANTA MARIA MADDALENA',
                            'CAPPELLA SAN MARTINO',
                          ];

                          final imagePaths = [
                            'assets/information/abside.png',
                            'assets/information/altare_dei_riccio.png',
                            'assets/information/ambienti_dell_antica_chiesa_di_san_michele_arcangelo_a_morfisa.png',
                            'assets/information/cappella_di_zi_andrea.png',
                            'assets/information/cappella_brancaccio.png',
                            'assets/information/cappella_del_crocefisso_dei_capece.png',
                            'assets/information/cappella_della_madonna_della_neve.png',
                            'assets/information/cappella_della_nativita.png',
                            'assets/information/cappella_di_santo_stefano.png',
                            'assets/information/cappella_di_san_bartolomeo.png',
                            'assets/information/cappella_di_san_carlo_borromeo.png',
                            'assets/information/cappella_di_san_domenico_soriano.png',
                            'assets/information/cappella_di_san_giovanni_battista.png',
                            'assets/information/cappella_di_san_giovanni_evangelista.png',
                            'assets/information/cappella_di_san_giuseppe.png',
                            'assets/information/cappella_di_san_nicola.png',
                            'assets/information/cappella_di_santa_caterina_da_siena.png',
                            'assets/information/cappella_di_santa_caterina_dalessandria.png',
                            'assets/information/cappella_di_santa_maria_maddalena.png',
                            'assets/information/cappella_san_martino.png',
                          ];

                          return Container(
                            margin: const EdgeInsets.only(
                                bottom: 10), // Margin between buttons
                            child: ElevatedButton(
                              onPressed: () => _showImageDialog(
                                context,
                                imagePaths[index],
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color.fromARGB(255, 39,
                                    39, 39), // Black background for buttons
                                minimumSize: const Size.fromHeight(
                                    50), // Full width and height
                                shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.zero, // 0 border radius
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Text(
                                      buttonNames[index], // Button label
                                      style: const TextStyle(
                                          color: Colors.white), // White text
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                  ),
                  // Background Container for the Icons
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

  Future<bool> checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    return isLoggedIn;
  }

  // Function to show image with zoom functionality
  void _showImageDialog(BuildContext context, String imagePath) {
    showDialog(
      context: context,
      barrierDismissible:
          true, // Allow dismissing the dialog by tapping outside
      builder: (context) {
        return Dialog(
          backgroundColor:
              Colors.transparent, // Make dialog background transparent
          child: Stack(
            children: [
              Container(
                padding: EdgeInsets
                    .zero, // Remove padding if you want the image to fill the dialog
                child: PhotoView(
                  imageProvider: AssetImage(imagePath),
                  backgroundDecoration: const BoxDecoration(
                    color:
                        Colors.transparent, // Ensure background is transparent
                  ),
                  minScale: PhotoViewComputedScale.contained * 0.8,
                  maxScale: PhotoViewComputedScale.covered * 2,
                  loadingBuilder: (context, event) => Center(
                    child: CircularProgressIndicator(
                      value: event == null
                          ? 0
                          : event.cumulativeBytesLoaded /
                              event.expectedTotalBytes!,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 0, // Adjust this value to position the button as needed
                right: 0, // Adjust this value to position the button as needed
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color(
                        0xFF272727), // Set your desired background color here
                    shape: BoxShape
                        .circle, // Optional: makes the background circular
                  ),
                  child: IconButton(
                    icon: const Icon(
                      Icons.close,
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the dialog
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
