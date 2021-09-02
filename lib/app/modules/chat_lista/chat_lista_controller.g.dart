// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_lista_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ChatListaController on _ChatListaControllerBase, Store {
  final _$chatFutureAtom = Atom(name: '_ChatListaControllerBase.chatFuture');

  @override
  ObservableFuture<List<ChatModel>>? get chatFuture {
    _$chatFutureAtom.reportRead();
    return super.chatFuture;
  }

  @override
  set chatFuture(ObservableFuture<List<ChatModel>>? value) {
    _$chatFutureAtom.reportWrite(value, super.chatFuture, () {
      super.chatFuture = value;
    });
  }

  final _$_ChatListaControllerBaseActionController =
      ActionController(name: '_ChatListaControllerBase');

  @override
  void findChats() {
    final _$actionInfo = _$_ChatListaControllerBaseActionController.startAction(
        name: '_ChatListaControllerBase.findChats');
    try {
      return super.findChats();
    } finally {
      _$_ChatListaControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
chatFuture: ${chatFuture}
    ''';
  }
}
