import 'package:cuidapet/app/modules/agendamento/agendamento_page.dart';
import 'package:cuidapet/app/modules/agendamento/agendamento_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AgendamentoModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => AgendamentoController(i())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      '/',
      child: (_, args) => AgendamentoPage(
        estabelecimento: args.data['estabelecimentoId'],
        servicos: args.data['servicosSelecionados'],
      ),
    ),
  ];
}
