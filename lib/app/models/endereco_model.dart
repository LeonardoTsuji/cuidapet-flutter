import 'dart:convert';

class EnderecoModel {
  int? id;
  String? endereco;
  double? latitude;
  double? longitude;
  String? complemento;

  EnderecoModel({
    this.id,
    this.endereco,
    this.latitude,
    this.longitude,
    this.complemento,
  });

  EnderecoModel.fromMap(Map<String, dynamic>? map) {
    if (map != null) {
      id = map['id'].runtimeType == int ? map['id'] as int : null;
      endereco = map['endereco'].runtimeType == String
          ? map['endereco'] as String
          : null;
      latitude = map['latitude'].runtimeType == String ||
              map['latitude'].runtimeType == double
          ? (map['latitude'].runtimeType == String
              ? double.parse(map['latitude'])
              : map['latitude'] as double)
          : null;
      longitude = map['longitude'].runtimeType == String ||
              map['longitude'].runtimeType == double
          ? (map['longitude'].runtimeType == String
              ? double.parse(map['longitude'])
              : map['longitude'] as double)
          : null;
      complemento = map['complemento'].runtimeType == String
          ? map['complemento'] as String
          : null;
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'endereco': endereco,
      'latitude': latitude,
      'longitude': longitude,
      'complemento': complemento,
    };
  }

  String toJson() => json.encode(toMap());

  factory EnderecoModel.fromJson(String source) =>
      EnderecoModel.fromMap(json.decode(source));
}
