import 'package:cuidapet/app/core/rest_client/rest_client_dio.dart';
import 'package:cuidapet/app/modules/home/home_module.dart';
import 'package:cuidapet/app/modules/main_page.dart';
import 'package:cuidapet/app/repository/usuario_repository.dart';
import 'package:cuidapet/app/services/usuario_services.dart';
import 'package:cuidapet/app/shared/auth_store.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'modules/login/login_module.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind(
      (i) => AuthStore(),
    ),
    Bind(
      (i) => UsuarioRepository(),
    ),
    Bind(
      (i) => UsuarioService(i()),
    ),
    Bind(
      (i) => RestClientDio(),
    )
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (context, args) => MainPage(),
    ),
    ModuleRoute(
      '/login',
      module: LoginModule(),
    ),
    ModuleRoute(
      '/home',
      module: HomeModule(),
    ),
  ];
}
