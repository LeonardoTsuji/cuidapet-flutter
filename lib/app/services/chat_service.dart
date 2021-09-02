import 'package:cuidapet/app/models/chat_message_model.dart';
import 'package:cuidapet/app/models/chat_model.dart';
import 'package:cuidapet/app/repository/chat_repository.dart';

class ChatService {
  final ChatRepository _repository;

  ChatService(this._repository);

  Future<List<ChatModel>> buscarChatUsuario() {
    return _repository.buscarChatUsuario();
  }

  Stream<List<ChatMessageModel>> getMessages(ChatModel? chat) {
    return _repository.getMessages(chat);
  }

  void sendMessage(ChatModel model, String mensagem) {
    _repository.sendMessage(model, mensagem);
    _repository.notificarUsuario(model, mensagem);
  }
}
