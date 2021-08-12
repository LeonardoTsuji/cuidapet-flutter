import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:get/get.dart';

import 'core/theme.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cuidapet',
      theme: ThemeCuidaPet.theme(),
      navigatorObservers: [GetObserver()],
    ).modular();
  }
}
