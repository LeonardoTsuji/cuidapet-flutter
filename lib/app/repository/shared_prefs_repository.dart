import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsRepository {
  static const _ACCESS_TOKEN = '/ACCESS_TOKEN/';
  static const _DEVICE_ID = '/DEVICE_ID/';

  static SharedPreferences? prefs;
  static SharedPrefsRepository? _instanceRepository;

  SharedPrefsRepository._();

  static Future<SharedPrefsRepository> get instance async {
    prefs ??= await SharedPreferences.getInstance();
    _instanceRepository ??= SharedPrefsRepository._();
    return _instanceRepository!;
  }

  Future<void> registerAccessToken(String token) async {
    await prefs?.setString(_ACCESS_TOKEN, token);
  }

  Future<void> registerDeviceId(String deviceId) async {
    await prefs?.setString(_DEVICE_ID, deviceId);
  }

  String? get accessToken => prefs?.getString(_ACCESS_TOKEN);

  String? get deviceId => prefs?.getString(_DEVICE_ID);
}
