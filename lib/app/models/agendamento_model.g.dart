// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'agendamento_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AgendamentoModel _$AgendamentoModelFromJson(Map<String, dynamic> json) {
  return AgendamentoModel(
    id: json['id'] as int,
    nome: json['nome'] as String,
    nomePet: json['nomePet'] as String,
    status: json['status'] as String,
    dataAgendamento: DateTime.parse(json['dataAgendamento'] as String),
    fornecedor:
        FornecedorModel.fromJson(json['fornecedor'] as Map<String, dynamic>),
    servicos: (json['servicos'] as List<dynamic>)
        .map((e) => FornecedorServicoModel.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$AgendamentoModelToJson(AgendamentoModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nome': instance.nome,
      'nomePet': instance.nomePet,
      'status': instance.status,
      'dataAgendamento': instance.dataAgendamento.toIso8601String(),
      'fornecedor': instance.fornecedor,
      'servicos': instance.servicos,
    };
