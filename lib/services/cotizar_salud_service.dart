import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'auth_service.dart';
import '../models/preference_option.dart';
import '../models/salud_quote.dart';

class CotizarSaludService {
  Future<List<SaludQuote>> cotizar({
    required List<PreferenceOption> preferencias,
    required int edad,
    required String genero,
  }) async {
    final baseUrl = dotenv.env['API_BASE_URL'] ?? 'http://127.0.0.1:8000';
    final url = Uri.parse('$baseUrl/api/cotizar_salud_por_preferencias');
    final token = await AuthService().getToken();
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };

    final body = json.encode({
      'preferencias': [
        for (var i = 0; i < preferencias.length; i++)
          {
            'id': preferencias[i].id,
            'orden': '${i + 1}',
          },
      ],
      'parametros': {
        'edad': '$edad',
        'genero': genero,
      },
    });

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((e) => SaludQuote.fromJson(e)).toList();
    }
    throw Exception('Error al cotizar salud');
  }
}
