import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:doma_church_frontend/services/globals.dart';

class AuthServices {
  static Future<http.Response> register(
      String name, String email, String password) async {
    Map<String, String> data = {
      "name": name,
      "email": email,
      "password": password,
    };
    var body = json.encode(data);
    var url = Uri.parse('${baseURL}register'); // Updated endpoint
    http.Response response = await http.post(
      url,
      headers: headers,
      body: body,
    );
    // ignore: avoid_print
    print(response.body);
    return response;
  }

  Future<String?> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('${baseURL}login'),
        headers: headers,
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final token = responseData['token'];
        await saveToken(token);
        return null; // No error, login successful
      } else {
        final responseData = jsonDecode(response.body);
        final errorMessage = responseData['message'];
        return errorMessage; // Return error message
      }
    } catch (e) {
      return 'Credentials are incorrect'; // Catch any connection errors
    }
  }

  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
    prefs.setBool("isLoggedIn", true); // Set isLoggedIn flag to true
  }

  Future<void> logout() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      if (token != null) {
        final response = await http.post(
          Uri.parse('${baseURL}logout'),
          headers: {
            'Authorization': 'Bearer $token',
          },
        );

        // Remove token and isLoggedIn flag from SharedPreferences
        await prefs.remove('token');
        await prefs.setBool('isLoggedIn', false);

        // ignore: avoid_print
        if (response.statusCode == 200) {
          return;
        } else {
          throw 'Failed to logout';
        }
      } else {
        // ignore: avoid_print
        print('User is not logged in.');
        return;
      }
    } catch (e) {
      throw 'Error during logout: $e';
    }
  }
}
