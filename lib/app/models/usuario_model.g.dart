// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'usuario_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UsuarioModel _$UsuarioModelFromJson(Map<String, dynamic> json) {
  return UsuarioModel(
    json['email'] as String,
    json['tipoCadastro'] as String,
    json['imgAvatar'] as String,
  );
}

Map<String, dynamic> _$UsuarioModelToJson(UsuarioModel instance) =>
    <String, dynamic>{
      'email': instance.email,
      'tipoCadastro': instance.tipoCadastro,
      'imgAvatar': instance.imgAvatar,
    };
