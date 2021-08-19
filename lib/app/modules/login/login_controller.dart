import 'package:cuidapet/app/core/exceptions/cuidapet_exceptions.dart';
import 'package:cuidapet/app/services/usuario_services.dart';
import 'package:cuidapet/app/shared/components/loading_indicator.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:get/get.dart';
import 'package:mobx/mobx.dart';

part 'login_controller.g.dart';

class LoginController = _LoginControllerBase with _$LoginController;

abstract class _LoginControllerBase with Store {
  final UsuarioService _usuarioService;

  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController loginController = TextEditingController();
  TextEditingController senhaController = TextEditingController();

  @observable
  bool mostraSenha = true;

  _LoginControllerBase(this._usuarioService);

  @action
  void mostrarSenhaUsuario() {
    mostraSenha = !mostraSenha;
  }

  @action
  Future<void> login() async {
    if (formKey.currentState == null) return;
    if (formKey.currentState!.validate()) {
      try {
        LoadingIndicator.show();
        await _usuarioService.login(false,
            email: loginController.text, password: senhaController.text);
        LoadingIndicator.hide();
        Modular.to.pushReplacementNamed('/');
      } on AcessoNegadoException catch (e) {
        LoadingIndicator.hide();
        print(e);
        Get.snackbar('Erro', 'Login e senha inválidos');
      } catch (e) {
        LoadingIndicator.hide();
        Get.snackbar('Erro', 'Erro ao realizar login');
      }
    }
  }

  @action
  Future<void> facebookLogin() async {
    try {
      LoadingIndicator.show();
      await _usuarioService.login(true);
      LoadingIndicator.hide();
      Modular.to.pushReplacementNamed('/');
    } on AcessoNegadoException catch (e) {
      print(e);
      LoadingIndicator.hide();
      Get.snackbar('Erro', 'Login e senha inválidos');
    } catch (e) {
      LoadingIndicator.hide();
      Get.snackbar('Erro', 'Erro ao realizar login');
    }
  }
}
