// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meus_agendamentos_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$MeusAgendamentosController on _MeusAgendamentosControllerBase, Store {
  final _$agendamentosFutureAtom =
      Atom(name: '_MeusAgendamentosControllerBase.agendamentosFuture');

  @override
  ObservableFuture<List<AgendamentoModel>>? get agendamentosFuture {
    _$agendamentosFutureAtom.reportRead();
    return super.agendamentosFuture;
  }

  @override
  set agendamentosFuture(ObservableFuture<List<AgendamentoModel>>? value) {
    _$agendamentosFutureAtom.reportWrite(value, super.agendamentosFuture, () {
      super.agendamentosFuture = value;
    });
  }

  final _$_MeusAgendamentosControllerBaseActionController =
      ActionController(name: '_MeusAgendamentosControllerBase');

  @override
  void buscarAgendamentos() {
    final _$actionInfo =
        _$_MeusAgendamentosControllerBaseActionController.startAction(
            name: '_MeusAgendamentosControllerBase.buscarAgendamentos');
    try {
      return super.buscarAgendamentos();
    } finally {
      _$_MeusAgendamentosControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
agendamentosFuture: ${agendamentosFuture}
    ''';
  }
}
