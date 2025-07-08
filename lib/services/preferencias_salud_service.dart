import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'auth_service.dart';
import '../models/preference_option.dart';

class PreferenciasSaludService {
  Future<List<PreferenceOption>> fetchOptions() async {
    final baseUrl = dotenv.env['API_BASE_URL'] ?? 'http://127.0.0.1:8000';
    final url = Uri.parse('$baseUrl/api/opciones_preferencias_salud');
    final token = await AuthService().getToken();
    final headers = token != null
        ? {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
          }
        : {
            'Accept': 'application/json',
          };

    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data
          .map((e) => PreferenceOption.fromJson(e as Map<String, dynamic>))
          .toList();
    }
    throw Exception('Error al obtener opciones de preferencias de salud');
  }
}
