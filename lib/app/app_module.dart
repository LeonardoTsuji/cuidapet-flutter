import 'package:cuidapet/app/core/connection/connection_error.dart';
import 'package:cuidapet/app/core/database/connection_adm.dart';
import 'package:cuidapet/app/modules/agendamento/agendamento_module.dart';
import 'package:cuidapet/app/modules/chat_lista/chat_lista_module.dart';
import 'package:cuidapet/app/modules/estabelecimento/estabelecimento_module.dart';
import 'package:cuidapet/app/modules/home/home_module.dart';
import 'package:cuidapet/app/modules/main_page.dart';
import 'package:cuidapet/app/modules/meus_agendamentos/meus_agendamentos_module.dart';
import 'package:cuidapet/app/repository/agendamento_repository.dart';
import 'package:cuidapet/app/repository/endereco_repository.dart';
import 'package:cuidapet/app/repository/fornecedor_repository.dart';
import 'package:cuidapet/app/repository/usuario_repository.dart';
import 'package:cuidapet/app/services/agendamento_servico.dart';
import 'package:cuidapet/app/services/endereco_services.dart';
import 'package:cuidapet/app/services/fornecedor_service.dart';
import 'package:cuidapet/app/services/usuario_services.dart';
import 'package:cuidapet/app/shared/auth_store.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'modules/login/login_module.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind(
      (i) => ConnectionAdm(),
      isLazy: false,
    ),
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
      (i) => EnderecoRepository(),
    ),
    Bind(
      (i) => EnderecoService(i()),
    ),
    Bind(
      (i) => FornecedorRepository(),
    ),
    Bind(
      (i) => FornecedorService(i()),
    ),
    Bind(
      (i) => AgendamentoRepository(),
    ),
    Bind(
      (i) => AgendamentoService(i()),
    ),
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
    ModuleRoute(
      '/estabelecimento',
      module: EstabelecimentoModule(),
    ),
    ModuleRoute(
      '/agendamento',
      module: AgendamentoModule(),
    ),
    ModuleRoute(
      '/meus-agendamentos',
      module: MeusAgendamentosModule(),
    ),
    ModuleRoute(
      '/chat-lista',
      module: ChatListaModule(),
    ),
    ChildRoute(
      '/connection-error',
      child: (context, args) => ConnectionError(),
    )
  ];
}
