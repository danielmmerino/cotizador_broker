class VehicleInfo {
  final Vehiculo? vehiculo;

  VehicleInfo({this.vehiculo});

  factory VehicleInfo.fromJson(Map<String, dynamic> json) {
    return VehicleInfo(
      vehiculo:
          json['vehiculo'] != null ? Vehiculo.fromJson(json['vehiculo']) : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'vehiculo': vehiculo?.toJson(),
      };
}

class Vehiculo {
  final int? codigoVehiculo;
  final String? numeroPlaca;
  final String? descripcionMarca;
  final String? descripcionModelo;
  final int? anioAuto;
  final String? descripcionPais;
  final List<OpcionComercial>? opcionesComerciales;

  Vehiculo({
    this.codigoVehiculo,
    this.numeroPlaca,
    this.descripcionMarca,
    this.descripcionModelo,
    this.anioAuto,
    this.descripcionPais,
    this.opcionesComerciales,
  });

  factory Vehiculo.fromJson(Map<String, dynamic> json) {
    return Vehiculo(
      codigoVehiculo: json['codigoVehiculo'] as int?,
      numeroPlaca: json['numeroPlaca'] as String?,
      descripcionMarca: json['descripcionMarca'] as String?,
      descripcionModelo: json['descripcionModelo'] as String?,
      anioAuto: json['anioAuto'] as int?,
      descripcionPais: json['descripcionPais'] as String?,
      opcionesComerciales: json['opcionesComerciales'] != null
          ? (json['opcionesComerciales'] as List)
              .map((e) => OpcionComercial.fromJson(e))
              .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'codigoVehiculo': codigoVehiculo,
        'numeroPlaca': numeroPlaca,
        'descripcionMarca': descripcionMarca,
        'descripcionModelo': descripcionModelo,
        'anioAuto': anioAuto,
        'descripcionPais': descripcionPais,
        'opcionesComerciales':
            opcionesComerciales?.map((e) => e.toJson()).toList(),
      };
}

class OpcionComercial {
  final String? marca;
  final String? modelo;
  final String? anio;
  final String? precioComercial;

  OpcionComercial({this.marca, this.modelo, this.anio, this.precioComercial});

  factory OpcionComercial.fromJson(Map<String, dynamic> json) {
    return OpcionComercial(
      marca: json['marca'] as String?,
      modelo: json['modelo'] as String?,
      anio: json['anio'] as String?,
      precioComercial: json['precioComercial'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'marca': marca,
        'modelo': modelo,
        'anio': anio,
        'precioComercial': precioComercial,
      };
}
