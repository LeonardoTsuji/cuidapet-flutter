import 'package:asuka/snackbars/asuka_snack_bar.dart';
import 'package:cuidapet/app/services/usuario_services.dart';
import 'package:cuidapet/app/shared/components/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'cadastro_controller.g.dart';

class CadastroController = _CadastroControllerBase with _$CadastroController;

abstract class _CadastroControllerBase with Store {
  final UsuarioService _usuarioService;

  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController loginController = TextEditingController();
  TextEditingController senhaController = TextEditingController();
  TextEditingController senhaConfirmaController = TextEditingController();

  @observable
  bool mostraSenha = true;

  @observable
  bool mostraConfirmaSenha = true;

  _CadastroControllerBase(this._usuarioService);

  @action
  void mostrarSenhaUsuario() {
    mostraSenha = !mostraSenha;
  }

  @action
  void mostrarConfirmaSenhaUsuario() {
    mostraConfirmaSenha = !mostraConfirmaSenha;
  }

  @action
  Future<void> cadastrarUsuario() async {
    if (formKey.currentState!.validate()) {
      var loading;

      try {
        loading = LoadingIndicator.show();
        await _usuarioService.cadastrarUsuario(
            loginController.text, senhaController.text);
        LoadingIndicator.hide(loading);
        Modular.to.pop();
      } catch (e) {
        LoadingIndicator.hide(loading);
        print(e);
        AsukaSnackbar.warning("Erro ao cadastrar usuário").show();
      }
    }
  }
}
