import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import 'package:cuidapet/app/services/endereco_services.dart';

part 'home_controller.g.dart';

class HomeController = HomeControllerBase with _$HomeController;

abstract class HomeControllerBase with Store {
  EnderecoService _enderecoService;
  HomeControllerBase(
    this._enderecoService,
  );

  @action
  Future<void> initPage() async {
    await temEnderecoCadastrado();
  }

  Future<void> temEnderecoCadastrado() async {
    var temEndereco = await _enderecoService.existeEnderecoCadastrado();

    if (!temEndereco) {
      await Modular.to.pushNamed('/home/enderecos');
    }
  }
}
