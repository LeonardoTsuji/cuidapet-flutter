import 'package:cuidapet/app/modules/meus_agendamentos/meus_agendamentos_controller.dart';
import 'package:cuidapet/app/modules/meus_agendamentos/meus_agendamentos_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class MeusAgendamentosModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => MeusAgendamentosController(i())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => MeusAgendamentosPage()),
  ];
}
