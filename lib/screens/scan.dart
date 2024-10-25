import 'package:flutter/material.dart';
import 'package:doma_church_frontend/widget/nav.dart';
import 'package:doma_church_frontend/widget/profile.dart';
import 'package:doma_church_frontend/widget/menu.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:qr_bar_code_scanner_dialog/qr_bar_code_scanner_dialog.dart';
import 'package:url_launcher/url_launcher.dart';

class MyScan extends StatefulWidget {
  const MyScan({super.key});

  @override
  State<MyScan> createState() => _MyScanState();
}

class _MyScanState extends State<MyScan> {
  final _qrBarCodeScannerDialogPlugin = QrBarCodeScannerDialog();
  String? scannedCode;
  bool _isProcessing = false;

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
                      'assets/page-dark.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  // Container(
                  //   padding: const EdgeInsets.only(top: 110, left: 30),
                  //   child: const Text(
                  //     'Scan QR Code',
                  //     style: TextStyle(color: Colors.white, fontSize: 28),
                  //   ),
                  // ),
                  Positioned(
                    top: 20,
                    left: 20,
                    child: IconButton(
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
                  Positioned(
                    top: 20,
                    right: 20,
                    child: IconButton(
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
                    top: 200,
                    left: 30,
                    right: 30,
                    bottom: 300,
                    child: Center(
                      child: ElevatedButton(
                        onPressed: () {
                          if (!_isProcessing) {
                            _qrBarCodeScannerDialogPlugin.getScannedQrBarCode(
                              context: context,
                              onCode: (code) {
                                setState(() {
                                  // Extract URL by removing "code scanned: " part if it exists
                                  if (code!.startsWith("Code scanned = ")) {
                                    scannedCode = code.replaceFirst(
                                        "Code scanned = ", "");
                                  } else {
                                    scannedCode =
                                        code; // If the format is different
                                  }
                                  _isProcessing = false;
                                });

                                // Check if the scanned code is a valid URL
                                if (scannedCode != null &&
                                    Uri.tryParse(scannedCode!)?.hasScheme ==
                                        true) {
                                  // Directly open the URL without printing
                                  launchUrl(Uri.parse(scannedCode!),
                                      mode: LaunchMode.inAppWebView);
                                } else {
                                  // Show the SnackBar with just the URL

                                  launchUrl(
                                    Uri.parse(scannedCode!),
                                    mode: LaunchMode
                                        .inAppWebView, // Opens the URL in the external browser
                                  );

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          scannedCode!), // Display only the URL
                                    ),
                                  );
                                }
                              },
                            );
                            _isProcessing =
                                true; // Set processing to true while scanning
                          }
                        },
                        child: const Text('Scansiona il codice QR'),
                      ),
                    ),
                  ),
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
