import 'package:cuidapet/app/modules/home/enderecos/detalhe/detalhe_controller.dart';
import 'package:cuidapet/app/modules/home/enderecos/detalhe/detalhe_page.dart';
import 'package:cuidapet/app/modules/home/enderecos/enderecos_controller.dart';
import 'package:cuidapet/app/modules/home/enderecos/enderecos_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class EnderecosModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => EnderecosController(i())),
    Bind.lazySingleton((i) => DetalheController(i())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => EnderecosPage()),
    ChildRoute('/detalhe',
        child: (_, args) => DetalhePage(
              enderecoModel: args.data,
            )),
  ];
}
