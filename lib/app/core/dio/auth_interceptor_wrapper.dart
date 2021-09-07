import 'package:asuka/snackbars/asuka_snack_bar.dart';
import 'package:connectivity/connectivity.dart';
import 'package:cuidapet/app/core/dio/custom_dio.dart';
import 'package:cuidapet/app/repository/secure_storage_repository.dart';
import 'package:cuidapet/app/repository/shared_prefs_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:synchronized/synchronized.dart' as syncronized;

class AuthInterceptorWrapper extends InterceptorsWrapper {
  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final prefs = await SharedPrefsRepository.instance;
    options.headers['Authorization'] = prefs.accessToken;

    if (dotenv.env['profile'] == 'dev') {
      print('############ Request Log ############');
      print('url ${options.uri}');
      print('method ${options.method}');
      print('data ${options.data}');
      print('headers ${options.headers}');
    }
  }

  @override
  void onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) {
    if (dotenv.env['profile'] == 'dev') {
      print('############ Response Log ############');
      print('response ${response.data}');
    }
  }

  @override
  void onError(
    DioError err,
    ErrorInterceptorHandler handler,
  ) async {
    print('############ On Error ############');
    print('error: ${err.response}');
  }
}
