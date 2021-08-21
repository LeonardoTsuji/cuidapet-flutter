// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cadastro_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CadastroController on _CadastroControllerBase, Store {
  final _$mostraSenhaAtom = Atom(name: '_CadastroControllerBase.mostraSenha');

  @override
  bool get mostraSenha {
    _$mostraSenhaAtom.reportRead();
    return super.mostraSenha;
  }

  @override
  set mostraSenha(bool value) {
    _$mostraSenhaAtom.reportWrite(value, super.mostraSenha, () {
      super.mostraSenha = value;
    });
  }

  final _$mostraConfirmaSenhaAtom =
      Atom(name: '_CadastroControllerBase.mostraConfirmaSenha');

  @override
  bool get mostraConfirmaSenha {
    _$mostraConfirmaSenhaAtom.reportRead();
    return super.mostraConfirmaSenha;
  }

  @override
  set mostraConfirmaSenha(bool value) {
    _$mostraConfirmaSenhaAtom.reportWrite(value, super.mostraConfirmaSenha, () {
      super.mostraConfirmaSenha = value;
    });
  }

  final _$cadastrarUsuarioAsyncAction =
      AsyncAction('_CadastroControllerBase.cadastrarUsuario');

  @override
  Future<void> cadastrarUsuario() {
    return _$cadastrarUsuarioAsyncAction.run(() => super.cadastrarUsuario());
  }

  final _$_CadastroControllerBaseActionController =
      ActionController(name: '_CadastroControllerBase');

  @override
  void mostrarSenhaUsuario() {
    final _$actionInfo = _$_CadastroControllerBaseActionController.startAction(
        name: '_CadastroControllerBase.mostrarSenhaUsuario');
    try {
      return super.mostrarSenhaUsuario();
    } finally {
      _$_CadastroControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void mostrarConfirmaSenhaUsuario() {
    final _$actionInfo = _$_CadastroControllerBaseActionController.startAction(
        name: '_CadastroControllerBase.mostrarConfirmaSenhaUsuario');
    try {
      return super.mostrarConfirmaSenhaUsuario();
    } finally {
      _$_CadastroControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
mostraSenha: ${mostraSenha},
mostraConfirmaSenha: ${mostraConfirmaSenha}
    ''';
  }
}
