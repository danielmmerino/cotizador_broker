import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../models/vehicle_info.dart';

class VehicleInfoService {
  /// Obtiene información del vehículo consultando el backend configurado.
  Future<VehicleInfo> fetchVehicleInfo(String plate) async {
    final baseUrl = dotenv.env['API_BASE_URL'] ?? 'http://127.0.0.1:8000';
    final url = Uri.parse('$baseUrl/api/vehicle-info/$plate');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return VehicleInfo.fromJson(data);
    }
    throw Exception('Error al obtener información del vehículo');
  }
}
