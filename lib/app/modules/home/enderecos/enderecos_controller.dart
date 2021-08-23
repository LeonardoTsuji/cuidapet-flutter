import 'package:cuidapet/app/services/endereco_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:mobx/mobx.dart';

part 'enderecos_controller.g.dart';

class EnderecosController = _EnderecosControllerBase with _$EnderecosController;

abstract class _EnderecosControllerBase with Store {
  final EnderecoService _enderecoService;
  TextEditingController enderecoTextController = TextEditingController();

  _EnderecosControllerBase(this._enderecoService);

  Future<List<Prediction>> buscarEnderecos(String endereco) {
    return _enderecoService.buscarEnderecosGooglePlaces(endereco);
  }
}
