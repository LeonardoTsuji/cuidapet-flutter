import 'package:cuidapet/app/shared/theme_utils.dart';
import 'package:flutter/material.dart';

class ConnectionError extends StatelessWidget {
  const ConnectionError({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(24),
        child: Material(
            borderRadius: BorderRadius.circular(24),
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.all(24),
                    child: Image.asset('lib/assets/images/no_network.png'),
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  Text(
                    'Algo deu errado',
                    style: TextStyle(fontSize: 22),
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  Text(
                    'Por favor verifique sua conexão',
                    style: TextStyle(fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'Tentar novamente',
                        style: TextStyle(
                          fontSize: 18,
                          color: ThemeUtils.primaryColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
