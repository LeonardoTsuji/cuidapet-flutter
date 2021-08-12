import 'dart:io';

import 'package:cuidapet/app/repository/shared_prefs_repository.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class PushMessagingConfig {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> config() async {
    if (Platform.isIOS) {
      _firebaseMessaging.requestPermission();
    }
    String? deviceId = await _firebaseMessaging.getToken();
    final prefs = await SharedPrefsRepository.instance;
    prefs.registerDeviceId(deviceId ?? '');
  }
}
