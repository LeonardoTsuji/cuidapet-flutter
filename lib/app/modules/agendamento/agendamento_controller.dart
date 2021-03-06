import 'package:asuka/snackbars/asuka_snack_bar.dart';
import 'package:cuidapet/app/models/fornecedor_servico_model.dart';
import 'package:cuidapet/app/services/agendamento_servico.dart';
import 'package:cuidapet/app/shared/components/loading_indicator.dart';
import 'package:cuidapet/app/viewsModels/agendamento_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'agendamento_controller.g.dart';

class AgendamentoController = _AgendamentoControllerBase
    with _$AgendamentoController;

abstract class _AgendamentoControllerBase with Store {
  final AgendamentoService _agendamentoService;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController petController = TextEditingController();

  @observable
  DateTime dataSelecionada = DateTime.now();
  @observable
  TimeOfDay? horarioSelecionado = TimeOfDay.now();

  _AgendamentoControllerBase(this._agendamentoService);

  @action
  void alterarData(DateTime data) {
    dataSelecionada = data;
  }

  @action
  void alterarHorario(TimeOfDay? horario) {
    horarioSelecionado = horario;
  }

  @action
  Future<void> salvarAgendamento(
      int estabelecimento, List<FornecedorServicoModel> servicos) async {
    if (formKey.currentState!.validate()) {
      var viewModel = AgendamentoVm(
          fornecedor: estabelecimento,
          dataHora: DateTime(
              dataSelecionada.year,
              dataSelecionada.month,
              dataSelecionada.day,
              dataSelecionada.hour,
              dataSelecionada.minute,
              0),
          nomeReserva: nomeController.text,
          nomePet: petController.text,
          servicos: servicos);
      var loading;
      try {
        loading = LoadingIndicator.show();
        await _agendamentoService.salvarAgendamento(viewModel);
        LoadingIndicator.hide(loading);
        AsukaSnackbar.success(
            'Agendamento realizado com sucesso, aguarde a confirma????o!');
        Future.delayed(
            Duration(seconds: 3),
            () async => await Modular.to
                .pushNamedAndRemoveUntil('/', ModalRoute.withName('/')));
      } catch (e) {
        LoadingIndicator.hide(loading);
        AsukaSnackbar.warning("Erro ao realizar agendamento").show();
      }
    }
  }
}
