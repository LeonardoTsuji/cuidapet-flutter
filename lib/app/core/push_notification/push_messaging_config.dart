import 'dart:convert';
import 'dart:io';

import 'package:cuidapet/app/models/chat_model.dart';
import 'package:cuidapet/app/modules/chat_lista/chat/chat_controller.dart';
import 'package:cuidapet/app/repository/shared_prefs_repository.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_modular/flutter_modular.dart';

class PushMessagingConfig {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> config() async {
    final initializationSettingsAndroid =
        AndroidInitializationSettings('ic_launcher');

    final initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    await _flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: _onSelectNotification);

    final androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'br.com.leonardotsuji.cuidapet',
      'cuidapet',
      'Cuidapet',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );

    final platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    if (Platform.isIOS) {
      _firebaseMessaging.requestPermission();
    }

    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      print('getInitialMessage data: ${message?.data}');
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("onMessage data: ${message.data}");

      final String payload = message.data['payload'];

      var showMessage = true;

      try {
        final payloadData = json.decode(payload);

        var chatController = Modular.get<ChatController>();

        if (chatController.chat?.id == payloadData['chat']['id']) {
          showMessage = false;
        }
      } on ModularError {
        showMessage = true;
      }

      if (showMessage) {
        _flutterLocalNotificationsPlugin.show(
          99,
          message.notification?.title,
          message.notification?.body,
          platformChannelSpecifics,
          payload: payload,
        );
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('onMessageOpenedApp data: ${message.data}');
    });

    String? deviceId = await _firebaseMessaging.getToken();
    final prefs = await SharedPrefsRepository.instance;
    prefs.registerDeviceId(deviceId ?? '');
  }

  Future _onSelectNotification(String? payload) async {
    var chatController;
    if (payload != null) {
      final data = json.decode(payload);

      if (data['type'] == 'CHAT_MESSAGE') {
        final model = ChatModel.fromJson(data['chat']);
        var abrirChat = true;

        try {
          chatController = Modular.get<ChatController>();

          if (chatController.chat.id == model.id) {
            abrirChat = false;
          }
        } on ModularError {}

        if (abrirChat) {
          await Modular.to.pushNamed('/chat-lista/chat', arguments: model);
        }
      } else if (data['type'] == 'AU') {
        Modular.to.pushNamed('meus-agendamentos');
      }
    }
  }
}
