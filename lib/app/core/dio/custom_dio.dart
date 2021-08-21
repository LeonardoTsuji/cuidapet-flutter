import 'package:cuidapet/app/repository/shared_prefs_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class CustomDio {
  static CustomDio? _simpleInstance;
  static CustomDio? _authInstance;

  late Dio _dio;

  BaseOptions options = BaseOptions(
    baseUrl: dotenv.env['base_url'] ?? '',
    connectTimeout: int.parse(dotenv.env['dio_connectTimeout'] ?? '30000'),
    receiveTimeout: int.parse(dotenv.env['dioreceiveTimeout'] ?? '30000'),
  );

  CustomDio._() {
    _dio = Dio(options);
  }

  CustomDio._auth() {
    _dio = Dio(options);
    _dio.interceptors.add(AuthInterceptorWrapper());
  }

  static Dio get instance {
    _simpleInstance ??= CustomDio._();
    return _simpleInstance!._dio;
  }

  static Dio get authInstance {
    _authInstance ??= CustomDio._auth();
    return _authInstance!._dio;
  }
}

class AuthInterceptorWrapper extends InterceptorsWrapper {
  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final prefs = await SharedPrefsRepository.instance;

    options.headers['Authorization'] = prefs.accessToken;

    if (dotenv.env['profile'] == 'dev') {
      print('############## Request Log ##############');
      print('url ${options.uri}');
      print('method ${options.method}');
      print('data ${options.data}');
      print('headers ${options.headers}');
    }

    handler.next(options);
  }

  @override
  void onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) {
    if (dotenv.env['profile'] == 'dev') {
      print('############## Response Log ##############');
      print('data ${response.data}');
    }

    handler.next(response);
  }

  @override
  void onError(
    DioError err,
    ErrorInterceptorHandler handler,
  ) {
    print('error: ${err.response}');
  }
}
