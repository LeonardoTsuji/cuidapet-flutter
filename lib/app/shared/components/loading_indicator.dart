import 'package:cuidapet/app/models/usuario_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoadingIndicator {
  static void show() {
    Get.dialog(
      Container(
        child: CircularProgressIndicator(),
      ),
    );
  }

  static void hide() {
    Get.back();
  }
}
