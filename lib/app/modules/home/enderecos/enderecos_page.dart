import 'package:asuka/snackbars/asuka_snack_bar.dart';
import 'package:cuidapet/app/models/endereco_model.dart';
import 'package:cuidapet/app/modules/home/enderecos/enderecos_controller.dart';
import 'package:cuidapet/app/shared/theme_utils.dart';
import 'package:cuidapet/app/shared/components/autocomplete.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_webservice/places.dart';

class EnderecosPage extends StatefulWidget {
  final String title;
  const EnderecosPage({Key? key, this.title = 'EnderecosPage'})
      : super(key: key);
  @override
  EnderecosPageState createState() => EnderecosPageState();
}

class EnderecosPageState
    extends ModularState<EnderecosPage, EnderecosController> {
  final EnderecosController store = Modular.get();

  @override
  void initState() {
    super.initState();
    controller.buscarEnderecosCadastrados();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        var enderecoSelecionado = await controller.enderecoFoiSelecionado();

        if (enderecoSelecionado)
          return true;
        else {
          AsukaSnackbar.warning("Por favor, selecione um endereço").show();
          return false;
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(12),
            child: Column(
              children: <Widget>[
                Text(
                  'Adicione ou escolha um endereço',
                  style: ThemeUtils.theme?.textTheme.headline5?.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                CustomAutocomplete(
                  focusNode: controller.enderecoFocusNode,
                  controller: controller.enderecoTextController,
                  hintText: 'Insira um endereço',
                  prefixIcon: Icon(
                    Icons.location_on,
                    color: Colors.black,
                  ),
                  onSuggestionSelected: (Prediction endereco) {
                    controller.enderecoTextController.text =
                        endereco.description ?? '';
                    controller.enviarDetalhe(endereco);
                  },
                  suggestionsCallback: (endereco) =>
                      controller.buscarEnderecos(endereco),
                  leading: Icon(Icons.location_on),
                ),
                SizedBox(
                  height: 24,
                ),
                ListTile(
                  onTap: () => controller.localizacaoAtual(),
                  leading: CircleAvatar(
                    child: Icon(
                      Icons.near_me,
                      color: Colors.white,
                    ),
                    radius: 32,
                    backgroundColor: Colors.red,
                  ),
                  title: Text('Localização atual'),
                  trailing: Icon(Icons.arrow_forward_ios),
                ),
                SizedBox(
                  height: 12,
                ),
                Observer(builder: (_) {
                  return FutureBuilder<List<EnderecoModel>>(
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.none:
                          return Container();
                        case ConnectionState.waiting:
                        case ConnectionState.active:
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        case ConnectionState.done:
                          if (snapshot.hasData) {
                            var data = snapshot.data;
                            return ListView.builder(
                              shrinkWrap: true,
                              itemCount: data?.length,
                              itemBuilder: (BuildContext context, int index) =>
                                  _buildItemEndereco(data?[index]),
                            );
                          } else {
                            return Center(
                              child: Text('Nenhum endereço cadastrado'),
                            );
                          }
                        default:
                          return Container();
                      }
                    },
                    future: controller.enderecosFuture,
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildItemEndereco(EnderecoModel? model) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        onTap: () => controller.selecionarEndereco(model),
        leading: CircleAvatar(
          backgroundColor: Colors.white,
          child: Icon(
            Icons.location_on,
            color: Colors.black,
          ),
        ),
        title: Text(model?.endereco ?? ''),
        subtitle: Text(model?.complemento ?? ''),
      ),
    );
  }
}
