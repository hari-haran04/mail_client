import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mail_client/utils/shared_prefs.dart';

class AuthService {
  final String signUpUrl = 'http://192.168.174.209:8080/api/v1/auth/register';
  final String signInUrl = 'http://192.168.174.209:8080/api/v1/auth/authenticate';

  Future<bool> signUp(String firstName, String lastName, String email, String password) async {
    final response = await http.post(
      Uri.parse(signUpUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'password': password,
      }),
    );
    if (response.statusCode == 200) {
      String token = json.decode(response.body)['token'];
      await SharedPrefs.saveToken(token);  // Save token in SharedPreferences
      return true;
    }
    return false;
  }

  Future<bool> signIn(String email, String password) async {
    final response = await http.post(
      Uri.parse(signInUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'email': email, 'password': password}),
    );
    if (response.statusCode == 200) {
      String token = json.decode(response.body)['token'];
      await SharedPrefs.saveToken(token);  // Save token in SharedPreferences
      return true;
    }
    return false;
  }


}
