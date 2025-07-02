import 'package:http/http.dart' as http;

class VehicleInfoService {
  /// Obtiene información del vehículo consultando la web de Ecuador Legal.
  ///
  /// Se agregan algunas cabeceras para replicar la petición que realiza el
  /// aplicativo web original, ya que sin ellas el servidor puede responder de
  /// forma inesperada.
  Future<String> fetchVehicleInfo(String plate) async {
    final url = Uri.parse(
      'https://www.ecuadorlegalonline.com/modulo/sri/matriculacion/consultar-vehiculo-rubros.php?placa=$plate',
    );

    final response = await http.get(url, headers: {
      'Accept': '*/*',
      'Accept-Language': 'es-ES,es;q=0.9,en;q=0.8',
      'Accept-Encoding': 'gzip, deflate, br, zstd',
      'User-Agent':
          'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36',
      'X-Requested-With': 'XMLHttpRequest',
      'Referer':
          'https://www.ecuadorlegalonline.com/consultas/agencia-nacional-de-transito/consultar-a-quien-pertenece-un-vehiculo-por-placa-ant/',
    });

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Error al obtener información del vehículo');
    }
  }
}
