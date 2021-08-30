import 'package:cuidapet/app/core/database/connection.dart';
import 'package:cuidapet/app/models/endereco_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_maps_webservice/places.dart';

class EnderecoRepository {
  Future<List<EnderecoModel>> buscarEndereco() async {
    final conn = await Connection().instance;
    var result = await conn.rawQuery('SELECT * FROM endereco');
    return result.map((e) => EnderecoModel.fromMap(e)).toList();
  }

  Future<void> salvarEndereco(EnderecoModel model) async {
    final conn = await Connection().instance;
    await conn.rawInsert('INSERT INTO endereco VALUES(?, ?, ?, ?, ?)', [
      null,
      model.endereco,
      model.latitude,
      model.longitude,
      model.complemento,
    ]);
  }

  Future<void> limparEnderecosCadastrados() async {
    final conn = await Connection().instance;
    conn.rawDelete('DELETE FROM endereco');
  }

  Future<List<Prediction>> buscarEnderecosGooglePlaces(String endereco) async {
    final places = GoogleMapsPlaces(apiKey: dotenv.env['google_api_key']);
    var response = await places.autocomplete(
      endereco,
      language: 'pt',
    );

    return response.predictions;
  }

  Future<PlacesDetailsResponse> recuperarDetalhesEnderecoGooglePlaces(
      String placeId) async {
    final places = GoogleMapsPlaces(apiKey: dotenv.env['google_api_key']);
    var response = await places.getDetailsByPlaceId(placeId);

    return response;
  }
}
