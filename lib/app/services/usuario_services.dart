import 'package:cuidapet/app/repository/secure_storage_repository.dart';
import 'package:cuidapet/app/repository/shared_prefs_repository.dart';
import 'package:cuidapet/app/repository/usuario_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

class UsuarioService {
  final UsuarioRepository _usuarioRepository;

  UsuarioService(this._usuarioRepository);

  Future<void> login(String email,
      {String? password, bool facebookLogin = false, String? avatar}) async {
    try {
      final acessTokenModel = await _usuarioRepository.login(email,
          password: password, facebookLogin: facebookLogin, avatar: avatar);
      final prefs = await SharedPrefsRepository.instance;

      if (!facebookLogin) {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: email, password: password != null ? password : '');
        prefs.registerAccessToken(acessTokenModel.accessToken ?? '');
      } else {}

      var confirmModel = await _usuarioRepository.confirmLogin();
      prefs.registerAccessToken(confirmModel.accessToken);
      SecureStorageRepository().registerRefreshToken(confirmModel.accessToken);
    } on PlatformException catch (e) {
      print('Erro ao fazer login no Firebase $e');
      rethrow;
    } catch (e) {
      print('Erro ao fazer login $e');
      rethrow;
    }
  }
}
