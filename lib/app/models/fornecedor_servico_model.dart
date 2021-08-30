import 'package:json_annotation/json_annotation.dart';

part 'fornecedor_servico_model.g.dart';

@JsonSerializable()
class FornecedorServicoModel {
  int id;
  String nome;
  double valor;

  FornecedorServicoModel({
    required this.id,
    required this.nome,
    required this.valor,
  });

  factory FornecedorServicoModel.fromJson(Map<String, dynamic> json) =>
      _$FornecedorServicoModelFromJson(json);
  Map<String, dynamic> toJson() => _$FornecedorServicoModelToJson(this);
}
