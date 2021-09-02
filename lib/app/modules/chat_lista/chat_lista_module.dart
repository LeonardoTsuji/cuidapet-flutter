import 'package:cuidapet/app/modules/chat_lista/chat/chat_module.dart';
import 'package:cuidapet/app/modules/chat_lista/chat_lista_controller.dart';
import 'package:cuidapet/app/modules/chat_lista/chat_lista_page.dart';
import 'package:cuidapet/app/repository/chat_repository.dart';
import 'package:cuidapet/app/services/chat_service.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ChatListaModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => ChatListaController(i())),
    Bind.lazySingleton((i) => ChatRepository()),
    Bind.lazySingleton((i) => ChatService(i())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => ChatListaPage()),
    ModuleRoute('/chat', module: ChatModule()),
  ];
}
