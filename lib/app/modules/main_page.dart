import 'package:cuidapet/app/shared/auth_store.dart';
import 'package:cuidapet/app/shared/theme_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_core/firebase_core.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) async {
      final authStore = Modular.get<AuthStore>();
      final isLogged = await authStore.isLogged();
      if (isLogged) {
        await authStore.loadUsuario();
        Modular.to.pushReplacementNamed('/home');
      } else {
        Modular.to.pushReplacementNamed('/login');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Future<FirebaseApp> _initializeFirebase() async {
      FirebaseApp firebaseApp = await Firebase.initializeApp();
      return firebaseApp;
    }

    ThemeUtils.init(context);
    ScreenUtil.init(
        BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width,
            maxHeight: MediaQuery.of(context).size.height),
        orientation: Orientation.portrait);
    return FutureBuilder(
      future: _initializeFirebase(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Erro');
        }

        if (snapshot.connectionState == ConnectionState.done) {
          return Scaffold(
            body: Center(
              child: Container(
                child: Image.asset('lib/assets/images/logo.png'),
              ),
            ),
          );
        }

        return CircularProgressIndicator();
      },
    );
  }
}
