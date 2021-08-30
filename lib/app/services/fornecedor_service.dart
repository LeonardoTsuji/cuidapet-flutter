import 'package:cuidapet/app/models/endereco_model.dart';
import 'package:cuidapet/app/models/fornecedor_busca_model.dart';
import 'package:cuidapet/app/models/fornecedor_model.dart';
import 'package:cuidapet/app/models/fornecedor_servico_model.dart';
import 'package:cuidapet/app/repository/fornecedor_repository.dart';

class FornecedorService {
  final FornecedorRepository _repository;

  FornecedorService(this._repository);

  Future<List<FornecedorBuscaModel>> buscarFornecedoresProximos(
      EnderecoModel? enderecoModel) {
    return _repository.buscarFornecedoresProximos(
        enderecoModel?.latitude ?? 0, enderecoModel?.longitude ?? 0);
  }

  Future<FornecedorModel> buscarPorId(int id) {
    return _repository.buscarPorId(id);
  }

  Future<List<FornecedorServicoModel>> buscarServicosFornecedor(
      int fornecedor) {
    return _repository.buscarServicosFornecedor(fornecedor);
  }
}
