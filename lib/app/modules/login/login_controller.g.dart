// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$LoginController on _LoginControllerBase, Store {
  final _$mostraSenhaAtom = Atom(name: '_LoginControllerBase.mostraSenha');

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

  final _$loginAsyncAction = AsyncAction('_LoginControllerBase.login');

  @override
  Future<void> login() {
    return _$loginAsyncAction.run(() => super.login());
  }

  final _$facebookLoginAsyncAction =
      AsyncAction('_LoginControllerBase.facebookLogin');

  @override
  Future<void> facebookLogin() {
    return _$facebookLoginAsyncAction.run(() => super.facebookLogin());
  }

  final _$_LoginControllerBaseActionController =
      ActionController(name: '_LoginControllerBase');

  @override
  void mostrarSenhaUsuario() {
    final _$actionInfo = _$_LoginControllerBaseActionController.startAction(
        name: '_LoginControllerBase.mostrarSenhaUsuario');
    try {
      return super.mostrarSenhaUsuario();
    } finally {
      _$_LoginControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
mostraSenha: ${mostraSenha}
    ''';
  }
}
