import 'package:cuidapet/app/models/usuario_model.dart';
import 'package:flutter/material.dart';
import 'package:asuka/asuka.dart' as asuka;

class LoadingIndicator {
  static OverlayEntry show() {
    var entry = OverlayEntry(
      builder: (context) {
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    asuka.addOverlay(entry);

    return entry;
  }

  static void hide(OverlayEntry entry) {
    entry.remove();
  }
}
