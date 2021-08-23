import 'package:cuidapet/app/modules/home/enderecos/detalhe/detalhe_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DetalhePage extends StatefulWidget {
  final String title;
  const DetalhePage({Key? key, this.title = 'DetalhePage'}) : super(key: key);
  @override
  DetalhePageState createState() => DetalhePageState();
}

class DetalhePageState extends ModularState<DetalhePage, DetalheController> {
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: _kGooglePlex,
              onMapCreated: (GoogleMapController controller) {
                // _controller.complete(controller);
              },
            ),
          ),
        ],
      ),
    );
  }
}
