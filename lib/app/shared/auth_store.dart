import 'package:cuidapet/app/models/usuario_model.dart';
import 'package:cuidapet/app/repository/shared_prefs_repository.dart';
import 'package:mobx/mobx.dart';
part 'auth_store.g.dart';

class AuthStore = _AuthStoreBase with _$AuthStore;

abstract class _AuthStoreBase with Store {
  @observable
  UsuarioModel? usuarioLogado;

  @action
  Future<void> loadUsuario() async {
    final prefs = await SharedPrefsRepository.instance;
    usuarioLogado = prefs.dadosUsuario;
  }

  Future<bool> isLogged() async {
    final prefs = await SharedPrefsRepository.instance;
    final accessToken = prefs.accessToken;

    return accessToken != null;
  }
}
