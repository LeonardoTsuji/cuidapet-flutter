import 'package:cuidapet/app/models/agendamento_model.dart';
import 'package:cuidapet/app/repository/agendamento_repository.dart';
import 'package:cuidapet/app/viewsModels/agendamento_vm.dart';

class AgendamentoService {
  final AgendamentoRepository _repository;

  AgendamentoService(this._repository);

  Future<void> salvarAgendamento(AgendamentoVm agendamento) async {
    await _repository.salvarAgendamento(agendamento);
  }

  Future<List<AgendamentoModel>> buscarAgendamentos() {
    return _repository.buscarAgendamentos();
  }
}
