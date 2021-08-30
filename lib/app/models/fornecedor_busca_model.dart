import 'package:json_annotation/json_annotation.dart';

import 'package:cuidapet/app/models/categorias_model.dart';

part 'fornecedor_busca_model.g.dart';

@JsonSerializable()
class FornecedorBuscaModel {
  int id;
  String nome;
  String logo;
  double distancia;
  CategoriaModel categoria;

  FornecedorBuscaModel({
    required this.id,
    required this.nome,
    required this.logo,
    required this.distancia,
    required this.categoria,
  });

  factory FornecedorBuscaModel.fromJson(Map<String, dynamic> json) =>
      _$FornecedorBuscaModelFromJson(json);
  Map<String, dynamic> toJson() => _$FornecedorBuscaModelToJson(this);
}
