import 'package:cuidapet/app/core/push_notification/push_messaging_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'app/app_module.dart';
import 'app/app_widget.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  await loadEnv();
  PushMessagingConfig().config();

  runApp(ModularApp(module: AppModule(), child: AppWidget()));
}

Future<void> loadEnv() async {
  const isProduction = bool.fromEnvironment('dart.vm.product');
  await DotEnv().load(fileName: isProduction ? '.env' : '.env_dev');
}
