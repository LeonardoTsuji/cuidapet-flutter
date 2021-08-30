import 'package:cuidapet/app/core/dio/custom_dio.dart';
import 'package:cuidapet/app/models/fornecedor_busca_model.dart';
import 'package:cuidapet/app/models/fornecedor_model.dart';
import 'package:cuidapet/app/models/fornecedor_servico_model.dart';

class FornecedorRepository {
  Future<List<FornecedorBuscaModel>> buscarFornecedoresProximos(
      double lat, double long) {
    return CustomDio.authInstance.get('/fornecedores', queryParameters: {
      'lat': lat,
      'long': long,
    }).then((value) => value.data
        .map<FornecedorBuscaModel>((f) => FornecedorBuscaModel.fromJson(f))
        .toList());
  }

  Future<FornecedorModel> buscarPorId(int id) {
    return CustomDio.authInstance
        .get('/fornecedores/$id')
        .then((value) => FornecedorModel.fromJson(value.data));
  }

  Future<List<FornecedorServicoModel>> buscarServicosFornecedor(
      int fornecedor) {
    return CustomDio.authInstance
        .get('/fornecedores/servicos/$fornecedor')
        .then((value) => value.data
            .map<FornecedorServicoModel>(
                (f) => FornecedorServicoModel.fromJson(f))
            .toList());
  }
}
