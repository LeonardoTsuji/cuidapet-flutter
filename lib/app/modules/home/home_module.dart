import 'package:cuidapet/app/modules/home/enderecos/enderecos_module.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'home_controller.dart';

import 'home_page.dart';

class HomeModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => HomeController(i())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, args) => HomePage()),
    ModuleRoute('/enderecos', module: EnderecosModule())
  ];
}
