class SaludQuote {
  final String idProducto;
  final String orden;
  final String nombreProducto;
  final String nombreAseguradora;
  final String valor;
  final String urlImagenAseguradora;
  final String puntuacion;

  SaludQuote({
    required this.idProducto,
    required this.orden,
    required this.nombreProducto,
    required this.nombreAseguradora,
    required this.valor,
    required this.urlImagenAseguradora,
    required this.puntuacion,
  });

  factory SaludQuote.fromJson(Map<String, dynamic> json) {
    return SaludQuote(
      idProducto: json['idProducto'].toString(),
      orden: json['orden'].toString(),
      nombreProducto: json['nombrePorducto'] as String? ?? '',
      nombreAseguradora: json['nombreAseguradora'] as String? ?? '',
      valor: json['valor'].toString(),
      urlImagenAseguradora: json['urlImagenAseguradora'] as String? ?? '',
      puntuacion: json['puntuacion'].toString(),
    );
  }
}
