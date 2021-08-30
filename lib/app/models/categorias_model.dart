import 'package:json_annotation/json_annotation.dart';

part 'categorias_model.g.dart';

@JsonSerializable()
class CategoriaModel {
  int id;
  String? nome;
  String? tipo;

  CategoriaModel({
    required this.id,
    this.nome,
    this.tipo,
  });

  factory CategoriaModel.fromJson(Map<String, dynamic> json) =>
      _$CategoriaModelFromJson(json);
  Map<String, dynamic> toJson() => _$CategoriaModelToJson(this);
}
