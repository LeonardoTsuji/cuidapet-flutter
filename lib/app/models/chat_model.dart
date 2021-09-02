import 'package:json_annotation/json_annotation.dart';

import 'package:cuidapet/app/models/fornecedor_model.dart';

part 'chat_model.g.dart';

@JsonSerializable()
class ChatModel {
  int id;
  int usuario;
  String nome;
  @JsonKey(name: 'nome_pet')
  String nomePet;
  FornecedorModel fornecedor;

  ChatModel({
    required this.id,
    required this.usuario,
    required this.nome,
    required this.nomePet,
    required this.fornecedor,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) =>
      _$ChatModelFromJson(json);
  Map<String, dynamic> toJson() => _$ChatModelToJson(this);
}
