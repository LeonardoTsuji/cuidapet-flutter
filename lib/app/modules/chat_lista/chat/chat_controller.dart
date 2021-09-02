import 'package:cuidapet/app/models/chat_message_model.dart';
import 'package:cuidapet/app/models/chat_model.dart';
import 'package:cuidapet/app/services/chat_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

part 'chat_controller.g.dart';

class ChatController = _ChatControllerBase with _$ChatController;

abstract class _ChatControllerBase with Store {
  final ChatService _chatService;
  TextEditingController mensagemController = TextEditingController();

  _ChatControllerBase(this._chatService);

  @observable
  ChatModel? chat;

  @observable
  ObservableStream<List<ChatMessageModel>>? messagesStream;

  @action
  void getChat(ChatModel model) {
    chat = model;

    final msgs = _chatService.getMessages(chat);
    messagesStream = msgs.asObservable();
  }

  @action
  void sendMessage() {
    if (mensagemController.text.isNotEmpty) {
      _chatService.sendMessage(chat!, mensagemController.text);
      mensagemController.text = '';
    }
  }
}
