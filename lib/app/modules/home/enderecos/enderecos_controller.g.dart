// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'enderecos_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$EnderecosController on _EnderecosControllerBase, Store {
  final _$enderecosFutureAtom =
      Atom(name: '_EnderecosControllerBase.enderecosFuture');

  @override
  ObservableFuture<List<EnderecoModel>>? get enderecosFuture {
    _$enderecosFutureAtom.reportRead();
    return super.enderecosFuture;
  }

  @override
  set enderecosFuture(ObservableFuture<List<EnderecoModel>>? value) {
    _$enderecosFutureAtom.reportWrite(value, super.enderecosFuture, () {
      super.enderecosFuture = value;
    });
  }

  final _$enviarDetalheAsyncAction =
      AsyncAction('_EnderecosControllerBase.enviarDetalhe');

  @override
  Future<void> enviarDetalhe(Prediction prediction) {
    return _$enviarDetalheAsyncAction
        .run(() => super.enviarDetalhe(prediction));
  }

  final _$selecionarEnderecoAsyncAction =
      AsyncAction('_EnderecosControllerBase.selecionarEndereco');

  @override
  Future<void> selecionarEndereco(EnderecoModel? model) {
    return _$selecionarEnderecoAsyncAction
        .run(() => super.selecionarEndereco(model));
  }

  final _$_EnderecosControllerBaseActionController =
      ActionController(name: '_EnderecosControllerBase');

  @override
  void _verificaEdicaoEndereco(EnderecoModel? enderecoEdicao) {
    final _$actionInfo = _$_EnderecosControllerBaseActionController.startAction(
        name: '_EnderecosControllerBase._verificaEdicaoEndereco');
    try {
      return super._verificaEdicaoEndereco(enderecoEdicao);
    } finally {
      _$_EnderecosControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
enderecosFuture: ${enderecosFuture}
    ''';
  }
}
