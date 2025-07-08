class PreferenceOption {
  final String id;
  final String descripcion;

  PreferenceOption({required this.id, required this.descripcion});

  factory PreferenceOption.fromJson(Map<String, dynamic> json) {
    return PreferenceOption(
      id: json['id'].toString(),
      descripcion: json['descripcion'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'descripcion': descripcion,
      };
}
