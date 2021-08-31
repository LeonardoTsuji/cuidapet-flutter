import 'dart:io';

import 'package:asuka/snackbars/asuka_snack_bar.dart';
import 'package:cuidapet/app/repository/shared_prefs_repository.dart';
import 'package:cuidapet/app/services/usuario_services.dart';
import 'package:cuidapet/app/shared/auth_store.dart';
import 'package:cuidapet/app/shared/components/loading_indicator.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class HomeDrawer extends Drawer {
  HomeDrawer()
      : super(
          child: Container(
              margin: EdgeInsets.only(top: ScreenUtil().statusBarHeight),
              child: Observer(
                builder: (_) {
                  var user = Modular.get<AuthStore>().usuarioLogado;
                  return Column(
                    children: <Widget>[
                      Container(
                        height: 200,
                        child: Stack(
                          children: <Widget>[
                            Align(
                              alignment: Alignment.topCenter,
                              child: CircleAvatar(
                                radius: 100,
                                backgroundImage: user?.imgAvatar != null
                                    ? NetworkImage(user!.imgAvatar)
                                    : null,
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                padding: EdgeInsets.all(12),
                                child: TextButton(
                                  onPressed: () => _alterarImagemPerfil(),
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.white60),
                                  ),
                                  child: Text(
                                    'Alterar imagem',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      TextButton(
                        onPressed: () {},
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.white60),
                        ),
                        child: Text(
                          'Email',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      ListView(
                        shrinkWrap: true,
                        children: <Widget>[
                          ListTile(
                            leading: Icon(Icons.receipt),
                            title: Text('Meus agendamentos'),
                          ),
                          ListTile(
                            leading: Icon(Icons.chat),
                            title: Text('Chats'),
                          ),
                          ListTile(
                            onTap: () async {
                              final prefs =
                                  await SharedPrefsRepository.instance;
                              prefs.clear();
                            },
                            leading: Icon(Icons.exit_to_app),
                            title: Text('Sair'),
                          ),
                        ],
                      ),
                      Container(),
                    ],
                  );
                },
              )),
        );

  static Future<void> _alterarImagemPerfil() async {
    var loading;
    loading = LoadingIndicator.show();

    var image = await ImagePicker().pickImage(source: ImageSource.camera);
    var reference = FirebaseStorage.instance
        .ref()
        .child('/perfil/${DateTime.now().millisecondsSinceEpoch.toString()}');

    try {
      var uploadTask = reference.putFile(File(image!.path));
      var downloadUrl = (await uploadTask);

      var url = await downloadUrl.ref.getDownloadURL();

      var novoUsuario =
          await Modular.get<UsuarioService>().atualizarImagemPerfil(url);
      final prefs = await SharedPrefsRepository.instance;

      await prefs.registerDadosUsuario(novoUsuario);
      await Modular.get<AuthStore>().loadUsuario();

      LoadingIndicator.hide(loading);
    } on FirebaseException catch (e) {
      print(e);
      LoadingIndicator.hide(loading);
      AsukaSnackbar.warning("Erro ao trocar imagem de perfil").show();
    }
  }
}
