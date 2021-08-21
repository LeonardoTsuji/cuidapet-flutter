import 'package:cuidapet/app/modules/login/cadastro/cadastro_page.dart';
import 'package:cuidapet/app/modules/login/cadastro/cadastro_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CadastroModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => CadastroController(i())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => CadastroPage()),
  ];
}
