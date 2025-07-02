import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  /// Realiza login usando la secret key configurada.
  /// Devuelve el token obtenido y lo almacena en local storage.
  Future<String> login() async {
    final baseUrl = dotenv.env['API_BASE_URL'] ?? 'http://127.0.0.1:8000';
    final secretKey = dotenv.env['SECRET_KEY'];
    if (secretKey == null || secretKey.isEmpty) {
      throw Exception('Secret key not configured');
    }

    final url = Uri.parse('$baseUrl/api/login');
    final response = await http.post(url, body: {'secret_key': secretKey});

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final token = data['token'];
      if (token is String) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('auth_token', token);
        return token;
      }
    }
    throw Exception('Error al realizar login');
  }

  /// Obtiene el token almacenado, si existe.
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }
}
