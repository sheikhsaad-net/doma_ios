import 'package:doma_church_frontend/screens/ticket.dart';
import 'package:flutter/material.dart';
import 'package:doma_church_frontend/screens/welcome.dart';
import 'package:doma_church_frontend/screens/register.dart';
import 'package:doma_church_frontend/screens/login.dart';
import 'package:doma_church_frontend/screens/forgot_password.dart';
import 'package:doma_church_frontend/screens/home.dart';
import 'package:doma_church_frontend/screens/splash.dart';
import 'package:doma_church_frontend/screens/code.dart';
import 'package:doma_church_frontend/screens/info.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        'login': (context) => const MyLogin(),
        'register': (context) => const MyRegister(),
        'forgot-password': (context) => const MyForgotPassword(),
        'welcome': (context) => const MyWelcome(),
        'home': (context) => const MyHome(),
        'splash': (context) => const SplashScreen(),
        'ticket': (context) => const MyTicket(),
        'code': (context) => const MyCode(),
        'info': (context) => const MyInfo(),
      },
      initialRoute: 'splash', // Set the initial route to SplashScreen
    );
  }
}
