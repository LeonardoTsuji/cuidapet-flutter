import 'package:cuidapet/app/modules/login/cadastro/cadastro_controller.dart';
import 'package:cuidapet/app/shared/theme_utils.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CadastroPage extends StatefulWidget {
  final String title;
  const CadastroPage({Key? key, this.title = 'CadastroPage'}) : super(key: key);
  @override
  CadastroPageState createState() => CadastroPageState();
}

class CadastroPageState extends ModularState<CadastroPage, CadastroController> {
  final CadastroController store = Modular.get();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text('Cadastrar usuário'),
      ),
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
            TextFormField(
              controller: controller.loginController,
              keyboardType: TextInputType.emailAddress,
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
              validator: (String? value) {
                if (value == null) {
                  return 'Login obrigatório';
                }
                return null;
              },
            ),
            SizedBox(
              height: 16,
            ),
            Observer(builder: (_) {
              return TextFormField(
                controller: controller.senhaController,
                obscureText: controller.mostraSenha,
                decoration: InputDecoration(
                  labelText: 'Senha',
                  labelStyle: TextStyle(
                    fontSize: 15,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    gapPadding: 0,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.lock),
                    onPressed: () => controller.mostrarSenhaUsuario(),
                  ),
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
            SizedBox(
              height: 20,
            ),
            Observer(builder: (_) {
              return TextFormField(
                controller: controller.senhaConfirmaController,
                obscureText: controller.mostraConfirmaSenha,
                decoration: InputDecoration(
                  labelText: 'Confirmar senha',
                  labelStyle: TextStyle(
                    fontSize: 15,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    gapPadding: 0,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.lock),
                    onPressed: () => controller.mostrarConfirmaSenhaUsuario(),
                  ),
                ),
                validator: (String? value) {
                  if (value == null) {
                    return 'Confirma senha obrigatória';
                  } else if (value.length < 6) {
                    return 'Confirmar senha precisa ter pelo menos 6 caracteres';
                  } else if (value != controller.senhaController.text) {
                    return 'Senha e confirma senha não são iguais';
                  }
                  return null;
                },
              );
            }),
            Container(
              width: ScreenUtil().screenWidth,
              padding: EdgeInsets.all(8),
              child: ElevatedButton(
                  onPressed: () => controller.cadastrarUsuario(),
                  style: ElevatedButton.styleFrom(
                    primary: ThemeUtils.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  child: Text(
                    'Cadastrar',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
