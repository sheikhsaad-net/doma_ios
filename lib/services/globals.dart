import 'package:flutter/material.dart';

const String baseURL = "https://doma.immensive.it/api/"; // emulator localhost
const Map<String, String> headers = {"Content-Type": "application/json"};

errorSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: const Color.fromARGB(255, 0, 0, 0),
    content: Text(text),
    duration: const Duration(seconds: 1),
  ));
}
