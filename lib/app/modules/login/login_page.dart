import 'package:cuidapet/app/core/rest_client/rest_client.dart';
import 'package:cuidapet/app/core/rest_client/rest_client_dio.dart';
import 'package:cuidapet/app/modules/login/login_store.dart';
import 'package:cuidapet/app/shared/components/facebook_button.dart';
import 'package:cuidapet/app/shared/theme_utils.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginPage extends StatefulWidget {
  const LoginPage();
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends ModularState<LoginPage, LoginStore> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeUtils.primaryColor,
      body: Container(
        child: Stack(
          children: <Widget>[
            Container(
              width: ScreenUtil().screenWidth,
              height: ScreenUtil().screenHeight < 700
                  ? 800
                  : ScreenUtil().screenHeight * 0.95,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('lib/assets/images/login_background.png'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: ScreenUtil().statusBarHeight + 30),
              width: double.infinity,
              child: Column(
                children: <Widget>[
                  Image.asset(
                    'lib/assets/images/logo.png',
                    width: ScreenUtil().setWidth(100),
                    fit: BoxFit.fill,
                  ),
                  _buildForm()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        child: Column(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Login',
                labelStyle: TextStyle(
                  fontSize: 15,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  gapPadding: 0,
                ),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Senha',
                labelStyle: TextStyle(
                  fontSize: 15,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  gapPadding: 0,
                ),
              ),
            ),
            Container(
              width: ScreenUtil().screenWidth,
              padding: EdgeInsets.all(8),
              child: ElevatedButton(
                  onPressed: () async {
                    // await FirebaseAuth.instance.createUserWithEmailAndPassword(
                    //     email: 'leonardohkt@gmail.com', password: '123456');
                    // FacebookLogin().logIn(['public_profile', 'email']);
                    // final LoginResult result =
                    // await FacebookAuth.instance.login();
                    // RestClientDio()
                    //     .get('https://viacep.com.br/ws/01001000/json/')
                    //     .then((value) => print(value.data));

                    FirebaseMessaging _firebaseMessaging =
                        FirebaseMessaging.instance;

                    _firebaseMessaging.requestPermission();
                    print(await _firebaseMessaging.getToken());
                  },
                  style: ElevatedButton.styleFrom(
                    primary: ThemeUtils.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  child: Text(
                    'Entrar',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Divider(
                      color: ThemeUtils.primaryColor,
                      thickness: 1,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'ou',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: ThemeUtils.primaryColor,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      color: ThemeUtils.primaryColor,
                      thickness: 1,
                    ),
                  ),
                ],
              ),
            ),
            FacebookButton(),
            TextButton(
              onPressed: () {},
              child: Text(
                'Cadastre-se',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
