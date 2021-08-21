import 'package:asuka/snackbars/asuka_snack_bar.dart';
import 'package:cuidapet/app/core/exceptions/cuidapet_exceptions.dart';
import 'package:cuidapet/app/services/usuario_services.dart';
import 'package:cuidapet/app/shared/components/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
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
      var loading;
      try {
        loading = LoadingIndicator.show();
        await _usuarioService.login(false,
            email: loginController.text, password: senhaController.text);
        LoadingIndicator.hide(loading);
        Modular.to.pushReplacementNamed('/');
      } on AcessoNegadoException catch (e) {
        LoadingIndicator.hide(loading);
        print(e);
        AsukaSnackbar.warning("Login e senha inválidos").show();
      } catch (e) {
        LoadingIndicator.hide(loading);
        AsukaSnackbar.warning("Erro ao realizar login").show();
      }
    }
  }

  @action
  Future<void> facebookLogin() async {
    var loading;
    try {
      loading = LoadingIndicator.show();
      await _usuarioService.login(true);
      LoadingIndicator.hide(loading);
      Modular.to.pushReplacementNamed('/');
    } on AcessoNegadoException catch (e) {
      print(e);
      LoadingIndicator.hide(loading);
      AsukaSnackbar.warning("Login e senha inválidos").show();
    } catch (e) {
      LoadingIndicator.hide(loading);
      AsukaSnackbar.warning("Erro ao realizar login").show();
    }
  }
}
