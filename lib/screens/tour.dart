import 'package:flutter/material.dart';
import 'package:doma_church_frontend/widget/nav.dart';
import 'package:doma_church_frontend/widget/profile.dart';
import 'package:doma_church_frontend/widget/menu.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class MyTour extends StatelessWidget {
  const MyTour({super.key});

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
                  Container(
                    padding: const EdgeInsets.only(top: 80, left: 30),
                    child: const Text(
                      'Acquista Ticket',
                      style: TextStyle(color: Colors.white, fontSize: 28),
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

                  // Buttons
                  Positioned(
                    top: 140,
                    left: 30,
                    right: 30, // Occupy the full width
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () async {
                              const url =
                                  'https://domasandomenicomaggiore.okticket.it/it/ticket/home/index/67/completo';

                              launchUrl(Uri.parse(url),
                                  mode: LaunchMode.inAppWebView);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFF2D2D2E),
                                borderRadius: BorderRadius.circular(0),
                              ),
                              width: 225,
                              padding: const EdgeInsets.only(
                                  top: 25, bottom: 25, left: 20),
                              child: const Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Tour Completo',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(0),
                            ),
                            width: 100,
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 18),
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '€11.00',
                                  style: TextStyle(
                                      color: Color(0xffd2bb84), fontSize: 20),
                                ),
                                Text(
                                  'Ridotto',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 10),
                                ),
                                Text(
                                  '€8.00',
                                  style: TextStyle(
                                      color: Color(0xFF333333), fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Positioned(
                    top: 225,
                    left: 30,
                    right: 30, // Occupy the full width
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () async {
                              const url =
                                  'https://domasandomenicomaggiore.okticket.it/it/ticket/home/index/13/standard';

                              launchUrl(Uri.parse(url),
                                  mode: LaunchMode.inAppWebView);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFF2D2D2E),
                                borderRadius: BorderRadius.circular(0),
                              ),
                              width: 225,
                              padding: const EdgeInsets.only(
                                  top: 25, bottom: 25, left: 20),
                              child: const Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Tour Standard',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(0),
                            ),
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 18),
                            width: 100,
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '€8.00',
                                  style: TextStyle(
                                      color: Color(0xffd2bb84), fontSize: 20),
                                ),
                                Text(
                                  'Ridotto',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 10),
                                ),
                                Text(
                                  '€6.00',
                                  style: TextStyle(
                                      color: Color(0xFF333333), fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 310,
                    left: 30,
                    right: 30, // Occupy the full width
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () async {
                              const url =
                                  'https://domasandomenicomaggiore.okticket.it/it/ticket/home/index/65/cella-di-san-tommaso-daquino';

                              launchUrl(Uri.parse(url),
                                  mode: LaunchMode.inAppWebView);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFF2D2D2E),
                                borderRadius: BorderRadius.circular(0),
                              ),
                              width: 225,
                              padding: const EdgeInsets.only(
                                  top: 25, bottom: 25, left: 20),
                              child: const Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Cella di San Tommaso',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(0),
                            ),
                            width: 100,
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 18),
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '€6.00',
                                  style: TextStyle(
                                      color: Color(0xffd2bb84), fontSize: 20),
                                ),
                                Text(
                                  'Ridotto',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 10),
                                ),
                                Text(
                                  '€5.00',
                                  style: TextStyle(
                                      color: Color(0xFF333333), fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 395,
                    left: 30,
                    right: 30, // Occupy the full width
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () async {
                              const url =
                                  'https://domasandomenicomaggiore.okticket.it/it/ticket/home/index/66/cripta-dei-carafa-di-roccella';

                              launchUrl(Uri.parse(url),
                                  mode: LaunchMode.inAppWebView);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFF2D2D2E),
                                borderRadius: BorderRadius.circular(0),
                              ),
                              width: 225,
                              padding: const EdgeInsets.only(
                                  top: 25, bottom: 25, left: 20),
                              child: const Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Cripta dei Carafa',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(0),
                            ),
                            width: 100,
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 18),
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '€6.00',
                                  style: TextStyle(
                                      color: Color(0xffd2bb84), fontSize: 20),
                                ),
                                Text(
                                  'Ridotto',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 10),
                                ),
                                Text(
                                  '€5.00',
                                  style: TextStyle(
                                      color: Color(0xFF333333), fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 480,
                    left: 30,
                    right: 30, // Occupy the full width
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () async {
                              const url =
                                  'https://domasandomenicomaggiore.okticket.it/it/ticket/home/index/293/sagrestia-e-sala-del-tesoro';

                              launchUrl(Uri.parse(url),
                                  mode: LaunchMode.inAppWebView);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFF2D2D2E),
                                borderRadius: BorderRadius.circular(0),
                              ),
                              width: 225,
                              padding: const EdgeInsets.only(
                                  top: 25, bottom: 25, left: 20),
                              child: const Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Sagrestia e Tesoro',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(0),
                            ),
                            width: 100,
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 18),
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '€6.00',
                                  style: TextStyle(
                                      color: Color(0xffd2bb84), fontSize: 20),
                                ),
                                Text(
                                  'Ridotto',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 10),
                                ),
                                Text(
                                  '€5.00',
                                  style: TextStyle(
                                      color: Color(0xFF333333), fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 565,
                    left: 30,
                    right: 30, // Occupy the full width
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () async {
                              const url =
                                  'https://domasandomenicomaggiore.okticket.it/it/ticket/home/index/25/gruppi-e-scuole';

                              launchUrl(Uri.parse(url),
                                  mode: LaunchMode.inAppWebView);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFF2D2D2E),
                                borderRadius: BorderRadius.circular(0),
                              ),
                              width: 225,
                              padding: const EdgeInsets.only(
                                  top: 25, bottom: 25, left: 20),
                              child: const Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Gruppi e scuole',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(0),
                            ),
                            width: 100,
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 18),
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '€6.00',
                                  style: TextStyle(
                                      color: Color(0xffd2bb84), fontSize: 20),
                                ),
                                Text(
                                  'Ridotto',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 10),
                                ),
                                Text(
                                  '€5.00',
                                  style: TextStyle(
                                      color: Color(0xFF333333), fontSize: 16),
                                ),
                              ],
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
