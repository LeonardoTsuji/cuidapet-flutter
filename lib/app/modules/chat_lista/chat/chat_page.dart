import 'package:cuidapet/app/models/chat_message_model.dart';
import 'package:cuidapet/app/models/chat_model.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:cuidapet/app/modules/chat_lista/chat/chat_controller.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  final String title;
  final ChatModel chat;

  const ChatPage({Key? key, this.title = 'ChatPage', required this.chat})
      : super(key: key);
  @override
  ChatPageState createState() => ChatPageState(chat);
}

class ChatPageState extends ModularState<ChatPage, ChatController> {
  final ChatModel model;

  ChatPageState(this.model);

  @override
  void initState() {
    super.initState();
    controller.getChat(model);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(child: Observer(
            builder: (_) {
              final List<ChatMessageModel>? msgs =
                  controller.messagesStream?.data;

              if (msgs == null) return SizedBox.shrink();

              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: msgs.length,
                  itemBuilder: (_, index) {
                    final msg = msgs[index];
                    if (msg.fornecedor != null) {
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(model.fornecedor.logo),
                        ),
                        title: Text(model.fornecedor.nome),
                        subtitle: Text(msg.mensagem),
                      );
                    }
                    return ListTile(
                      trailing: CircleAvatar(),
                      title: Text(
                        model.nome,
                        textAlign: TextAlign.end,
                      ),
                      subtitle: Text(
                        msg.mensagem,
                        textAlign: TextAlign.end,
                      ),
                    );
                  });
            },
          )),
          Container(
            margin: EdgeInsets.only(bottom: 12),
            padding: EdgeInsets.all(12),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextFormField(
                    controller: controller.mensagemController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(12),
                  child: CircleAvatar(
                    minRadius: 24,
                    child: IconButton(
                      onPressed: () => controller.sendMessage(),
                      icon: Icon(Icons.send),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
