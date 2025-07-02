class VehicleInfo {
  final Vehiculo? vehiculo;
  final dynamic rubros;

  VehicleInfo({this.vehiculo, this.rubros});

  factory VehicleInfo.fromJson(Map<String, dynamic> json) {
    return VehicleInfo(
      vehiculo:
          json['vehiculo'] != null ? Vehiculo.fromJson(json['vehiculo']) : null,
      rubros: json['rubros'],
    );
  }

  Map<String, dynamic> toJson() => {
        'vehiculo': vehiculo?.toJson(),
        'rubros': rubros,
      };
}

class Vehiculo {
  final int? codigoVehiculo;
  final String? numeroPlaca;
  final String? numeroCamvCpn;
  final String? colorVehiculo1;
  final String? colorVehiculo2;
  final dynamic cilindraje;
  final String? nombreClase;
  final String? descripcionMarca;
  final String? descripcionModelo;
  final int? anioAuto;
  final String? descripcionPais;
  final String? mensajeMotivoAuto;
  final bool? aplicaCuota;
  final String? fechaUltimaMatricula;
  final String? fechaCaducidadMatricula;
  final String? fechaCompraRegistro;
  final String? fechaRevision;
  final String? descripcionCanton;
  final String? descripcionServicio;
  final int? ultimoAnioPagado;
  final String? prohibidoEnajenar;
  final String? observacion;
  final String? estadoExoneracion;

  Vehiculo({
    this.codigoVehiculo,
    this.numeroPlaca,
    this.numeroCamvCpn,
    this.colorVehiculo1,
    this.colorVehiculo2,
    this.cilindraje,
    this.nombreClase,
    this.descripcionMarca,
    this.descripcionModelo,
    this.anioAuto,
    this.descripcionPais,
    this.mensajeMotivoAuto,
    this.aplicaCuota,
    this.fechaUltimaMatricula,
    this.fechaCaducidadMatricula,
    this.fechaCompraRegistro,
    this.fechaRevision,
    this.descripcionCanton,
    this.descripcionServicio,
    this.ultimoAnioPagado,
    this.prohibidoEnajenar,
    this.observacion,
    this.estadoExoneracion,
  });

  factory Vehiculo.fromJson(Map<String, dynamic> json) {
    return Vehiculo(
      codigoVehiculo: json['codigoVehiculo'] as int?,
      numeroPlaca: json['numeroPlaca'] as String?,
      numeroCamvCpn: json['numeroCamvCpn'] as String?,
      colorVehiculo1: json['colorVehiculo1'] as String?,
      colorVehiculo2: json['colorVehiculo2'] as String?,
      cilindraje: json['cilindraje'],
      nombreClase: json['nombreClase'] as String?,
      descripcionMarca: json['descripcionMarca'] as String?,
      descripcionModelo: json['descripcionModelo'] as String?,
      anioAuto: json['anioAuto'] as int?,
      descripcionPais: json['descripcionPais'] as String?,
      mensajeMotivoAuto: json['mensajeMotivoAuto'] as String?,
      aplicaCuota: json['aplicaCuota'] as bool?,
      fechaUltimaMatricula: json['fechaUltimaMatricula'] as String?,
      fechaCaducidadMatricula: json['fechaCaducidadMatricula'] as String?,
      fechaCompraRegistro: json['fechaCompraRegistro'] as String?,
      fechaRevision: json['fechaRevision'] as String?,
      descripcionCanton: json['descripcionCanton'] as String?,
      descripcionServicio: json['descripcionServicio'] as String?,
      ultimoAnioPagado: json['ultimoAnioPagado'] as int?,
      prohibidoEnajenar: json['prohibidoEnajenar'] as String?,
      observacion: json['observacion'] as String?,
      estadoExoneracion: json['estadoExoneracion'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'codigoVehiculo': codigoVehiculo,
        'numeroPlaca': numeroPlaca,
        'numeroCamvCpn': numeroCamvCpn,
        'colorVehiculo1': colorVehiculo1,
        'colorVehiculo2': colorVehiculo2,
        'cilindraje': cilindraje,
        'nombreClase': nombreClase,
        'descripcionMarca': descripcionMarca,
        'descripcionModelo': descripcionModelo,
        'anioAuto': anioAuto,
        'descripcionPais': descripcionPais,
        'mensajeMotivoAuto': mensajeMotivoAuto,
        'aplicaCuota': aplicaCuota,
        'fechaUltimaMatricula': fechaUltimaMatricula,
        'fechaCaducidadMatricula': fechaCaducidadMatricula,
        'fechaCompraRegistro': fechaCompraRegistro,
        'fechaRevision': fechaRevision,
        'descripcionCanton': descripcionCanton,
        'descripcionServicio': descripcionServicio,
        'ultimoAnioPagado': ultimoAnioPagado,
        'prohibidoEnajenar': prohibidoEnajenar,
        'observacion': observacion,
        'estadoExoneracion': estadoExoneracion,
      };
}
