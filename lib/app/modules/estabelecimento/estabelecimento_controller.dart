import 'package:cuidapet/app/models/fornecedor_servico_model.dart';
import 'package:mobx/mobx.dart';

import 'package:cuidapet/app/models/fornecedor_model.dart';
import 'package:cuidapet/app/services/fornecedor_service.dart';

part 'estabelecimento_controller.g.dart';

class EstabelecimentoController = _EstabelecimentoControllerBase
    with _$EstabelecimentoController;

abstract class _EstabelecimentoControllerBase with Store {
  final FornecedorService _fornecedorService;

  @observable
  ObservableFuture<FornecedorModel>? fornecedorFuture;

  @observable
  ObservableFuture<List<FornecedorServicoModel>>? fornecedorServicoFuture;

  @observable
  ObservableList<FornecedorServicoModel> servicosSelecionados =
      <FornecedorServicoModel>[].asObservable();

  _EstabelecimentoControllerBase(
    this._fornecedorService,
  );

  @action
  void initPage(int id) {
    fornecedorFuture = ObservableFuture(_fornecedorService.buscarPorId(id));
    fornecedorServicoFuture =
        ObservableFuture(_fornecedorService.buscarServicosFornecedor(id));
  }

  @action
  void adicionarOuRemoverServico(FornecedorServicoModel servico) {
    if (servicosSelecionados.contains(servico)) {
      servicosSelecionados.remove(servico);
    } else {
      servicosSelecionados.add(servico);
    }
  }
}
