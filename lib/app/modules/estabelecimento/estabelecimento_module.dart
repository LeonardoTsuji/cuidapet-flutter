import 'package:cuidapet/app/modules/estabelecimento/estabelecimento_page.dart';
import 'package:cuidapet/app/modules/estabelecimento/estabelecimento_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';

class EstabelecimentoModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => EstabelecimentoController(i())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/:id',
        child: (_, args) => EstabelecimentoPage(
              estabelecimentoId: int.parse(args.params['id']),
            )),
  ];
}
