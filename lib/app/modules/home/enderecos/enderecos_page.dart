import 'package:cuidapet/app/modules/home/enderecos/enderecos_controller.dart';
import 'package:cuidapet/app/shared/theme_utils.dart';
import 'package:cuidapet/app/shared/components/autocomplete.dart';
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
  Widget build(BuildContext context) {
    return Scaffold(
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
                controller: controller.enderecoTextController,
                hintText: 'Insira um endereço',
                prefixIcon: Icon(
                  Icons.location_on,
                  color: Colors.black,
                ),
                onSuggestionSelected: (Prediction endereco) => controller
                    .enderecoTextController.text = endereco.description ?? '',
                suggestionsCallback: (endereco) =>
                    controller.buscarEnderecos(endereco),
                leading: Icon(Icons.location_on),
              ),
              SizedBox(
                height: 24,
              ),
              ListTile(
                onTap: () => Modular.to.pushNamed('/home/enderecos/detalhe'),
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
              ListView.builder(
                shrinkWrap: true,
                itemCount: 3,
                itemBuilder: (BuildContext context, int index) =>
                    _buildItemEndereco(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildItemEndereco() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.white,
          child: Icon(
            Icons.location_on,
            color: Colors.black,
          ),
        ),
        title: Text('Rua José'),
        subtitle: Text('Apto 506'),
      ),
    );
  }
}
