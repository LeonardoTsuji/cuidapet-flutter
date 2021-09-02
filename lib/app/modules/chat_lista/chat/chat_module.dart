import 'package:cuidapet/app/modules/chat_lista/chat/chat_controller.dart';
import 'package:cuidapet/app/modules/chat_lista/chat/chat_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ChatModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => ChatController(i())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/:id', child: (_, args) => ChatPage(chat: args.data)),
  ];
}
