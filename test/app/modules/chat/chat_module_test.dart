import 'package:cuidapet/app/modules/chat_lista/chat_lista_module.dart';
import 'package:flutter_modular_test/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUpAll(() {
    initModule(ChatListaModule());
  });
}
