import 'package:cuidapet/app/repository/agendamento_repository.dart';
import 'package:cuidapet/app/viewsModels/agendamento_vm.dart';

class AgendamentoService {
  final AgendamentoRepository _repository;

  AgendamentoService(this._repository);

  Future<void> salvarAgendamento(AgendamentoVm agendamento) async {
    await _repository.salvarAgendamento(agendamento);
  }
}
