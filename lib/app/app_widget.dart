import 'package:asuka/asuka.dart' as asuka;
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'core/theme.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cuidapet',
      theme: ThemeCuidaPet.theme(),
      builder: asuka.builder,
      navigatorObservers: [asuka.asukaHeroController],
    ).modular();
  }
}
