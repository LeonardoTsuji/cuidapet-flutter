import 'package:cuidapet/app/core/database/connection.dart';
import 'package:cuidapet/app/shared/components/cuidapet_textformfield.dart';
import 'package:cuidapet/app/shared/components/facebook_button.dart';
import 'package:cuidapet/app/shared/components/validates.dart';
import 'package:cuidapet/app/shared/theme_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'login_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage();
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends ModularState<LoginPage, LoginController> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
        key: controller.formKey,
        child: Column(
          children: <Widget>[
            CuidapetTextFormField(
              controller: controller.loginController,
              keyboardType: TextInputType.emailAddress,
              label: 'Login',
              validator: (String? value) {
                if (value == null) {
                  return 'Login obrigatório';
                } else if (!Validate.emailValid(value)) {
                  return 'Login precisa ser um e-mail';
                }
                return null;
              },
            ),
            SizedBox(
              height: 16,
            ),
            Observer(builder: (_) {
              return CuidapetTextFormField(
                controller: controller.senhaController,
                obscureText: controller.mostraSenha,
                label: 'Senha',
                suffixIcon: IconButton(
                  icon: Icon(Icons.lock),
                  onPressed: () => controller.mostrarSenhaUsuario(),
                ),
                validator: (String? value) {
                  if (value == null) {
                    return 'Senha obrigatória';
                  } else if (value.length < 6) {
                    return 'Senha precisa ter pelo menos 6 caracteres';
                  }
                  return null;
                },
              );
            }),
            Container(
              width: ScreenUtil().screenWidth,
              padding: EdgeInsets.all(8),
              child: ElevatedButton(
                  onPressed: () => controller.login(),
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
            FacebookButton(onTap: () {
              controller.facebookLogin();
            }),
            TextButton(
              onPressed: () => Modular.to.pushNamed('/login/cadastro'),
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
