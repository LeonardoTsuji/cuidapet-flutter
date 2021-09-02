import 'package:cuidapet/app/models/agendamento_model.dart';
import 'package:cuidapet/app/services/agendamento_servico.dart';
import 'package:mobx/mobx.dart';

part 'meus_agendamentos_controller.g.dart';

class MeusAgendamentosController = _MeusAgendamentosControllerBase
    with _$MeusAgendamentosController;

abstract class _MeusAgendamentosControllerBase with Store {
  final AgendamentoService _agendamentoService;

  _MeusAgendamentosControllerBase(this._agendamentoService);

  @observable
  ObservableFuture<List<AgendamentoModel>>? agendamentosFuture;

  @action
  void buscarAgendamentos() {
    agendamentosFuture =
        ObservableFuture(_agendamentoService.buscarAgendamentos());
  }
}
