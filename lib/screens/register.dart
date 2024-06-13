import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:doma_church_frontend/services/auth_services.dart';
import 'package:doma_church_frontend/services/globals.dart';

class MyRegister extends StatefulWidget {
  const MyRegister({super.key});

  @override
  State<MyRegister> createState() => _MyRegisterState();
}

class _MyRegisterState extends State<MyRegister> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/login.png'), // Change image path as needed
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: const IconThemeData(
              color: Colors.white), // Set the color of back arrow to white
        ),
        backgroundColor: Colors.transparent,
        body: Stack(
          alignment: Alignment.topCenter,
          children: [
            Container(
              padding: const EdgeInsets.only(top: 80),
              child: const Text(
                'Registration',
                style: TextStyle(color: Colors.white, fontSize: 28),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.3,
                  right: 35,
                  left: 35,
                ),
                child: Column(
                  children: [
                    TextField(
                      controller: _nameController,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFFCCCCCC),
                          ), // Bottom line color
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.white), // Bottom line color
                        ),
                        fillColor: Colors.transparent,
                        hintText: 'Name',
                        hintStyle: TextStyle(
                          color: Color(0xFFCCCCCC),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: _emailController,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFFCCCCCC),
                          ), // Bottom line color
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.white), // Bottom line color
                        ),
                        fillColor: Colors.transparent,
                        hintText: 'Email',
                        hintStyle: TextStyle(
                          color: Color(0xFFCCCCCC),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: _passwordController,
                      obscureText: true,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFFCCCCCC),
                          ), // Bottom line color
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.white), // Bottom line color
                        ),
                        fillColor: Colors.transparent,
                        hintText: 'Password',
                        hintStyle: TextStyle(
                          color: Color(0xFFCCCCCC),
                        ),
                      ),
                    ),
                    const SizedBox(height: 50),
                    ElevatedButton(
                      onPressed: () {
                        _register();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xffd2bb84),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const SizedBox(
                        width: double.infinity,
                        child: Text(
                          'Register',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, 'login');
                      },
                      child: const Text(
                        'Login',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Color(0xFFCCCCCC),
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _register() async {
    String name = _nameController.text.trim();
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    if (name.isNotEmpty && email.isNotEmpty && password.isNotEmpty) {
      try {
        var response = await AuthServices.register(name, email, password);
        if (response.statusCode == 200) {
          // Registration successful
          var jsonResponse = json.decode(response.body);
          // ignore: unused_local_variable
          var user = jsonResponse['user'];
          String message = jsonResponse['message'];

          // Show success message
          // ignore: use_build_context_synchronously
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: const Color(0xffd2bb84),
              content: Text(message),
            ),
          );

          // Navigate to welcome screen
          // ignore: use_build_context_synchronously
          Navigator.pushReplacementNamed(context, 'login');
        } else {
          // Registration failed
          var jsonResponse = json.decode(response.body);
          String errorMessage = jsonResponse['message'];

          // Show error message
          // ignore: use_build_context_synchronously
          errorSnackBar(context, errorMessage);
        }
      } catch (e) {
        // Handle other errors
        // ignore: avoid_print
        print(e.toString());
        // ignore: use_build_context_synchronously
        errorSnackBar(context, "An error occurred");
      }
    } else {
      errorSnackBar(context, "Please fill in all fields");
    }
  }
}
