import 'package:cuidapet/app/models/endereco_model.dart';
import 'package:cuidapet/app/repository/shared_prefs_repository.dart';
import 'package:cuidapet/app/services/endereco_services.dart';
import 'package:cuidapet/app/shared/components/loading_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:mobx/mobx.dart';

part 'enderecos_controller.g.dart';

class EnderecosController = _EnderecosControllerBase with _$EnderecosController;

abstract class _EnderecosControllerBase with Store {
  FocusNode enderecoFocusNode = FocusNode();

  final EnderecoService _enderecoService;
  TextEditingController enderecoTextController = TextEditingController();

  _EnderecosControllerBase(this._enderecoService);

  @observable
  ObservableFuture<List<EnderecoModel>>? enderecosFuture;

  Future<List<Prediction>> buscarEnderecos(String endereco) {
    return _enderecoService.buscarEnderecosGooglePlaces(endereco);
  }

  @action
  Future<void> enviarDetalhe(Prediction prediction) async {
    var resultado = await _enderecoService
        .recuperarDetalhesEnderecoGooglePlaces(prediction.placeId ?? '');
    var detalhe = resultado.result;
    var enderecoModel = EnderecoModel(
      endereco: detalhe.formattedAddress,
      latitude: detalhe.geometry?.location.lat,
      longitude: detalhe.geometry?.location.lng,
    );
    var enderecoEdicao = await Modular.to.pushNamed('/home/enderecos/detalhe',
        arguments: enderecoModel) as EnderecoModel?;
    _verificaEdicaoEndereco(enderecoEdicao);
  }

  Future<void> localizacaoAtual() async {
    bool serviceEnabled;
    LocationPermission permission;
    var loading;

    loading = LoadingIndicator.show();

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    var position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    var place = placemarks[0];
    var endereco = '${place.thoroughfare} ${place.subThoroughfare}';
    var enderecoModel = EnderecoModel(
      endereco: endereco,
      latitude: position.latitude,
      longitude: position.longitude,
    );
    LoadingIndicator.hide(loading);
    var enderecoEdicao = await Modular.to.pushNamed('/home/enderecos/detalhe',
        arguments: enderecoModel) as EnderecoModel?;
    _verificaEdicaoEndereco(enderecoEdicao);
  }

  void buscarEnderecosCadastrados() {
    enderecosFuture =
        ObservableFuture(_enderecoService.buscarEnderecosCadastrados());
  }

  @action
  void _verificaEdicaoEndereco(EnderecoModel? enderecoEdicao) {
    if (enderecoEdicao?.endereco == null) {
      buscarEnderecosCadastrados();
      enderecoTextController.text = '';
    } else {
      enderecoTextController.text = enderecoEdicao?.endereco ?? "";
      enderecoFocusNode.requestFocus();
    }
  }

  @action
  Future<void> selecionarEndereco(EnderecoModel? model) async {
    var prefs = await SharedPrefsRepository.instance;
    await prefs.registrarEnderecoSelecionado(model);
    Modular.to.pop();
  }

  Future<bool> enderecoFoiSelecionado() async {
    var prefs = await SharedPrefsRepository.instance;
    return prefs.enderecoSelecionado != null;
  }
}
