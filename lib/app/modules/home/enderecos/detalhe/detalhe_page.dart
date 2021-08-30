import 'package:cuidapet/app/models/endereco_model.dart';
import 'package:cuidapet/app/modules/home/enderecos/detalhe/detalhe_controller.dart';
import 'package:cuidapet/app/shared/theme_utils.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DetalhePage extends StatefulWidget {
  final EnderecoModel enderecoModel;

  final String title;
  const DetalhePage(
      {Key? key, this.title = 'DetalhePage', required this.enderecoModel})
      : super(key: key);
  @override
  DetalhePageState createState() => DetalhePageState();
}

class DetalhePageState extends ModularState<DetalhePage, DetalheController> {
  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
    );

    var model = widget.enderecoModel;

    final CameraPosition _kGooglePlex = CameraPosition(
      target: LatLng(model.latitude ?? 0, model.longitude ?? 0),
      zoom: 14.4746,
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar,
      body: SingleChildScrollView(
        child: Container(
          width: ScreenUtil.defaultSize.width,
          height: ScreenUtil.defaultSize.height -
              (ScreenUtil().statusBarHeight +
                  ScreenUtil().bottomBarHeight +
                  appBar.preferredSize.height),
          padding: EdgeInsets.symmetric(horizontal: 12),
          margin: EdgeInsets.only(bottom: 18),
          child: Column(
            children: <Widget>[
              Center(
                child: Text(
                  'Confirme seu endereço ${model.endereco}',
                  style: ThemeUtils.theme?.textTheme.headline5?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 18,
              ),
              Expanded(
                child: GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition: _kGooglePlex,
                  markers: {
                    Marker(
                      markerId: MarkerId(model.id?.toString() ?? ''),
                      position:
                          LatLng(model.latitude ?? 0, model.longitude ?? 0),
                      infoWindow: InfoWindow(title: model.endereco),
                    ),
                  },
                  myLocationButtonEnabled: false,
                ),
              ),
              TextFormField(
                initialValue: model.endereco,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'Endereço',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () => Modular.to.pop(model),
                  ),
                ),
              ),
              SizedBox(
                height: 18,
              ),
              TextFormField(
                controller: controller.complementoTextController,
                decoration: InputDecoration(labelText: 'Complemento'),
              ),
              SizedBox(
                height: 18,
              ),
              Container(
                width: ScreenUtil.defaultSize.width * .9,
                height: 48,
                child: ElevatedButton(
                  onPressed: () => controller.salvarEndereco(model),
                  child: Text(
                    'Salvar',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    shape: StadiumBorder(),
                    primary: ThemeUtils.primaryColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
