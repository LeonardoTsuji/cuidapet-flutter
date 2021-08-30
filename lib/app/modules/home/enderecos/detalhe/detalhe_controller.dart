import 'package:asuka/snackbars/asuka_snack_bar.dart';
import 'package:cuidapet/app/models/endereco_model.dart';
import 'package:cuidapet/app/services/endereco_services.dart';
import 'package:cuidapet/app/shared/components/loading_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'detalhe_controller.g.dart';

class DetalheController = _DetalheControllerBase with _$DetalheController;

abstract class _DetalheControllerBase with Store {
  final EnderecoService _enderecoService;

  TextEditingController complementoTextController = TextEditingController();

  _DetalheControllerBase(this._enderecoService);

  Future<void> salvarEndereco(EnderecoModel model) async {
    var loading;
    try {
      loading = LoadingIndicator.show();
      model.complemento = complementoTextController.text;
      await _enderecoService.salvarEndereco(model);
      LoadingIndicator.hide(loading);
      Modular.to.pop();
    } catch (e) {
      LoadingIndicator.hide(loading);
      print(e);
      AsukaSnackbar.warning("Erro ao salvar endereço").show();
    }
  }
}
