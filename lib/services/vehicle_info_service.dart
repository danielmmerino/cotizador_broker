import 'package:http/http.dart' as http;

class VehicleInfoService {
  Future<String> fetchVehicleInfo(String plate) async {
    final url = Uri.parse(
        'https://www.ecuadorlegalonline.com/modulo/sri/matriculacion/consultar-vehiculo-rubros.php?placa=$plate');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Error al obtener información del vehículo');
    }
  }
}
