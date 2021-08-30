import 'package:cuidapet/app/models/fornecedor_servico_model.dart';

class AgendamentoVm {
  int fornecedor;
  DateTime dataHora;
  String nomeReserva;
  String nomePet;
  List<FornecedorServicoModel> servicos;

  AgendamentoVm({
    required this.fornecedor,
    required this.dataHora,
    required this.nomeReserva,
    required this.nomePet,
    required this.servicos,
  });
}
