import 'package:cuidapet/app/modules/home/home_store.dart';
import 'package:cuidapet/app/repository/shared_prefs_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({this.title = "Home"});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeStore> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Column(
        children: <Widget>[
          TextButton(
            child: Text('Logout'),
            onPressed: () async => (await SharedPrefsRepository.instance),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.snackbar('Olá', 'Leonardo');
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
