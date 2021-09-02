// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ChatController on _ChatControllerBase, Store {
  final _$chatAtom = Atom(name: '_ChatControllerBase.chat');

  @override
  ChatModel? get chat {
    _$chatAtom.reportRead();
    return super.chat;
  }

  @override
  set chat(ChatModel? value) {
    _$chatAtom.reportWrite(value, super.chat, () {
      super.chat = value;
    });
  }

  final _$messagesStreamAtom = Atom(name: '_ChatControllerBase.messagesStream');

  @override
  ObservableStream<List<ChatMessageModel>>? get messagesStream {
    _$messagesStreamAtom.reportRead();
    return super.messagesStream;
  }

  @override
  set messagesStream(ObservableStream<List<ChatMessageModel>>? value) {
    _$messagesStreamAtom.reportWrite(value, super.messagesStream, () {
      super.messagesStream = value;
    });
  }

  @override
  String toString() {
    return '''
chat: ${chat},
messagesStream: ${messagesStream}
    ''';
  }
}
