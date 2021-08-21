import 'package:cuidapet/app/modules/home/home_controller.dart';
import 'package:cuidapet/app/repository/shared_prefs_repository.dart';
import 'package:cuidapet/app/shared/auth_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({this.title = "Home"});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeController> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Modular.get<AuthStore>().usuarioLogado?.email ?? ''),
      ),
      body: Column(
        children: <Widget>[
          TextButton(
            child: Text('Logout'),
            onPressed: () async {
              final prefs = await SharedPrefsRepository.instance;
              await prefs.clear();
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }
}
