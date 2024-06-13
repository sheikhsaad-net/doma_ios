import 'package:flutter/material.dart';

class MyWelcome extends StatefulWidget {
  const MyWelcome({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyWelcomeState createState() => _MyWelcomeState();
}

class _MyWelcomeState extends State<MyWelcome> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/welcome.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Container(
            margin: const EdgeInsets.only(bottom: 35),
            padding: const EdgeInsets.symmetric(horizontal: 35),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 60),
                  alignment: Alignment.centerLeft,
                  child: Image.asset('assets/logo.png', width: 120),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, 'login');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xffd2bb84),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0),
                          ),
                        ),
                        child: const SizedBox(
                          width: double.infinity,
                          child: Text(
                            'Login',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, 'register');
                        },
                        child: const Text(
                          'Registration',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Color(0xFFEEEEEE),
                            fontSize: 18,
                          ),
                        ),
                      ),
                      const Text(
                        'Entra come ospite',
                        style:
                            TextStyle(color: Color(0xFFEEEEEE), fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
