// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomeController on HomeControllerBase, Store {
  final _$enderecoSelecionadoAtom =
      Atom(name: 'HomeControllerBase.enderecoSelecionado');

  @override
  EnderecoModel? get enderecoSelecionado {
    _$enderecoSelecionadoAtom.reportRead();
    return super.enderecoSelecionado;
  }

  @override
  set enderecoSelecionado(EnderecoModel? value) {
    _$enderecoSelecionadoAtom.reportWrite(value, super.enderecoSelecionado, () {
      super.enderecoSelecionado = value;
    });
  }

  final _$categoriasFutureAtom =
      Atom(name: 'HomeControllerBase.categoriasFuture');

  @override
  ObservableFuture<List<CategoriaModel>>? get categoriasFuture {
    _$categoriasFutureAtom.reportRead();
    return super.categoriasFuture;
  }

  @override
  set categoriasFuture(ObservableFuture<List<CategoriaModel>>? value) {
    _$categoriasFutureAtom.reportWrite(value, super.categoriasFuture, () {
      super.categoriasFuture = value;
    });
  }

  final _$fornecedoresFutureAtom =
      Atom(name: 'HomeControllerBase.fornecedoresFuture');

  @override
  ObservableFuture<List<FornecedorBuscaModel>>? get fornecedoresFuture {
    _$fornecedoresFutureAtom.reportRead();
    return super.fornecedoresFuture;
  }

  @override
  set fornecedoresFuture(ObservableFuture<List<FornecedorBuscaModel>>? value) {
    _$fornecedoresFutureAtom.reportWrite(value, super.fornecedoresFuture, () {
      super.fornecedoresFuture = value;
    });
  }

  final _$fornecedoresOriginaisAtom =
      Atom(name: 'HomeControllerBase.fornecedoresOriginais');

  @override
  List<FornecedorBuscaModel>? get fornecedoresOriginais {
    _$fornecedoresOriginaisAtom.reportRead();
    return super.fornecedoresOriginais;
  }

  @override
  set fornecedoresOriginais(List<FornecedorBuscaModel>? value) {
    _$fornecedoresOriginaisAtom.reportWrite(value, super.fornecedoresOriginais,
        () {
      super.fornecedoresOriginais = value;
    });
  }

  final _$paginaSelecionadaAtom =
      Atom(name: 'HomeControllerBase.paginaSelecionada');

  @override
  int get paginaSelecionada {
    _$paginaSelecionadaAtom.reportRead();
    return super.paginaSelecionada;
  }

  @override
  set paginaSelecionada(int value) {
    _$paginaSelecionadaAtom.reportWrite(value, super.paginaSelecionada, () {
      super.paginaSelecionada = value;
    });
  }

  final _$categoriaSelecionadaAtom =
      Atom(name: 'HomeControllerBase.categoriaSelecionada');

  @override
  int? get categoriaSelecionada {
    _$categoriaSelecionadaAtom.reportRead();
    return super.categoriaSelecionada;
  }

  @override
  set categoriaSelecionada(int? value) {
    _$categoriaSelecionadaAtom.reportWrite(value, super.categoriaSelecionada,
        () {
      super.categoriaSelecionada = value;
    });
  }

  final _$initPageAsyncAction = AsyncAction('HomeControllerBase.initPage');

  @override
  Future<void> initPage() {
    return _$initPageAsyncAction.run(() => super.initPage());
  }

  final _$temEnderecoCadastradoAsyncAction =
      AsyncAction('HomeControllerBase.temEnderecoCadastrado');

  @override
  Future<void> temEnderecoCadastrado() {
    return _$temEnderecoCadastradoAsyncAction
        .run(() => super.temEnderecoCadastrado());
  }

  final _$recuperarEnderecoSelecionadoAsyncAction =
      AsyncAction('HomeControllerBase.recuperarEnderecoSelecionado');

  @override
  Future<void> recuperarEnderecoSelecionado() {
    return _$recuperarEnderecoSelecionadoAsyncAction
        .run(() => super.recuperarEnderecoSelecionado());
  }

  final _$buscarFornecedoresAsyncAction =
      AsyncAction('HomeControllerBase.buscarFornecedores');

  @override
  Future<void> buscarFornecedores() {
    return _$buscarFornecedoresAsyncAction
        .run(() => super.buscarFornecedores());
  }

  final _$HomeControllerBaseActionController =
      ActionController(name: 'HomeControllerBase');

  @override
  void alterarPaginaSelecionada(int pagina) {
    final _$actionInfo = _$HomeControllerBaseActionController.startAction(
        name: 'HomeControllerBase.alterarPaginaSelecionada');
    try {
      return super.alterarPaginaSelecionada(pagina);
    } finally {
      _$HomeControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void buscarCategorias() {
    final _$actionInfo = _$HomeControllerBaseActionController.startAction(
        name: 'HomeControllerBase.buscarCategorias');
    try {
      return super.buscarCategorias();
    } finally {
      _$HomeControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void filtrarPorCategoria(int id) {
    final _$actionInfo = _$HomeControllerBaseActionController.startAction(
        name: 'HomeControllerBase.filtrarPorCategoria');
    try {
      return super.filtrarPorCategoria(id);
    } finally {
      _$HomeControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void filtrarFornecedoresPorNome() {
    final _$actionInfo = _$HomeControllerBaseActionController.startAction(
        name: 'HomeControllerBase.filtrarFornecedoresPorNome');
    try {
      return super.filtrarFornecedoresPorNome();
    } finally {
      _$HomeControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void _filtrarFornecedores() {
    final _$actionInfo = _$HomeControllerBaseActionController.startAction(
        name: 'HomeControllerBase._filtrarFornecedores');
    try {
      return super._filtrarFornecedores();
    } finally {
      _$HomeControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
enderecoSelecionado: ${enderecoSelecionado},
categoriasFuture: ${categoriasFuture},
fornecedoresFuture: ${fornecedoresFuture},
fornecedoresOriginais: ${fornecedoresOriginais},
paginaSelecionada: ${paginaSelecionada},
categoriaSelecionada: ${categoriaSelecionada}
    ''';
  }
}
