import 'package:cuidapet/app/core/dio/custom_dio.dart';
import 'package:cuidapet/app/models/chat_message_model.dart';
import 'package:cuidapet/app/models/chat_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatRepository {
  final FirebaseFirestore _firebaseStorage = FirebaseFirestore.instance;
  Future<List<ChatModel>> buscarChatUsuario() {
    return CustomDio.authInstance.get('/chats/usuario').then((value) =>
        value.data.map<ChatModel>((chat) => ChatModel.fromJson(chat)).toList());
  }

  Stream<List<ChatMessageModel>> getMessages(ChatModel? chat) {
    return _firebaseStorage
        .collection('chat')
        .doc(chat?.id.toString())
        .collection('messages')
        .orderBy('data_mensagem', descending: false)
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs.map((m) {
        return ChatMessageModel(
            usuario: m.data()['usuario'],
            fornecedor: m.data()['fornecedor'],
            mensagem: m.data()['mensagem']);
      }).toList();
    });
  }

  void sendMessage(ChatModel model, String mensagem) {
    final data = <String, dynamic>{
      'mensagem': mensagem,
      'data_mensagem': DateTime.now(),
      'usuario': model.usuario,
    };

    _firebaseStorage
        .collection('chat')
        .doc(model.id.toString())
        .collection('messages')
        .add(data);
  }

  void notificarUsuario(ChatModel model, String mensagem) {
    CustomDio.authInstance.post('/chats/notificar', data: {
      'chat': model.id,
      'mensagem': mensagem,
      'para': 'F',
    });
  }
}
