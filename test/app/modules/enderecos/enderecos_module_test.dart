import 'package:cuidapet/app/modules/home/enderecos/enderecos_module.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular_test/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUpAll(() {
    initModule(EnderecosModule());
  });
}
