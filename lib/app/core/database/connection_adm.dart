import 'package:cuidapet/app/core/database/connection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ConnectionAdm extends WidgetsBindingObserver with Disposable {
  var conn = Connection();

  ConnectionAdm() {
    WidgetsBinding.instance?.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        break;
      case AppLifecycleState.inactive:
        conn.closeConnection();
        break;
      case AppLifecycleState.paused:
        conn.closeConnection();
        break;
      case AppLifecycleState.detached:
        conn.closeConnection();
        break;
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
  }
}
