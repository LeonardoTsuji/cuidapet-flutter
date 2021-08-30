import 'package:cuidapet/app/models/endereco_model.dart';
import 'package:cuidapet/app/repository/endereco_repository.dart';
import 'package:google_maps_webservice/places.dart';

class EnderecoService {
  final EnderecoRepository _repository;

  EnderecoService(this._repository);

  Future<bool> existeEnderecoCadastrado() async {
    var listaEnderecos = await _repository.buscarEndereco();
    return listaEnderecos.isNotEmpty;
  }

  Future<List<Prediction>> buscarEnderecosGooglePlaces(String endereco) async {
    return await _repository.buscarEnderecosGooglePlaces(endereco);
  }

  Future<void> salvarEndereco(EnderecoModel endereco) async {
    await _repository.salvarEndereco(endereco);
  }

  Future<List<EnderecoModel>> buscarEnderecosCadastrados() async {
    return await _repository.buscarEndereco();
  }

  Future<PlacesDetailsResponse> recuperarDetalhesEnderecoGooglePlaces(
      String placeId) async {
    return await _repository.recuperarDetalhesEnderecoGooglePlaces(placeId);
  }

  Future<void> limparEnderecosCadastrados() async {
    await _repository.limparEnderecosCadastrados();
  }
}
