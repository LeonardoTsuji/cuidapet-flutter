import 'dart:convert';

import 'package:cuidapet/app/models/usuario_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsRepository {
  static const _ACCESS_TOKEN = '/ACCESS_TOKEN/';
  static const _DEVICE_ID = '/DEVICE_ID/';
  static const _DADOS_USUARIO = '/_DADOS_USUARIO/';

  static SharedPreferences? prefs;
  static SharedPrefsRepository? _instanceRepository;

  SharedPrefsRepository._();

  static Future<SharedPrefsRepository> get instance async {
    prefs ??= await SharedPreferences.getInstance();
    _instanceRepository ??= SharedPrefsRepository._();
    return _instanceRepository!;
  }

  Future<void> registerAccessToken(String token) async {
    await prefs?.setString(_ACCESS_TOKEN, token);
  }

  Future<void> registerDeviceId(String deviceId) async {
    await prefs?.setString(_DEVICE_ID, deviceId);
  }

  Future<void> clear() async {
    await prefs?.clear();
    await Modular.to.pushNamedAndRemoveUntil('/', ModalRoute.withName('/'));
  }

  Future<void> registerDadosUsuario(UsuarioModel usuario) async {
    await prefs?.setString(_DADOS_USUARIO, jsonEncode(usuario));
  }

  String? get accessToken => prefs?.getString(_ACCESS_TOKEN);

  String? get deviceId => prefs?.getString(_DEVICE_ID);

  UsuarioModel? get dadosUsuario {
    if (prefs?.containsKey(_DADOS_USUARIO) ?? false) {
      return UsuarioModel.fromJson(
          jsonDecode(prefs?.getString(_DADOS_USUARIO) ?? ''));
    }

    return null;
  }
}
