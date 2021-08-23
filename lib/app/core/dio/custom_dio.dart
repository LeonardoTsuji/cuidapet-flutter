import 'package:cuidapet/app/repository/secure_storage_repository.dart';
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
  Future onError(
    DioError err,
    ErrorInterceptorHandler handler,
  ) async {
    print('############## Response Error ##############');
    print('error: ${err.response}');

    if (err.response?.statusCode == 403 || err.response?.statusCode == 401) {
      await _refreshToken();
      print('############## Token atualizado ##############');
      final req = err.requestOptions;
      return CustomDio.authInstance.fetch(req);
    }
  }

  Future<void> _refreshToken() async {
    final prefs = await SharedPrefsRepository.instance;
    final security = SecureStorageRepository();

    try {
      final refreshToken = await security.refreshToken;
      final accessToken = prefs.accessToken;

      var result = await CustomDio.instance.put('/login/refresh', data: {
        'token': accessToken,
        'refresh_token': refreshToken,
      });

      await prefs.registerAccessToken(result.data['access_token']);
      await security.registerRefreshToken(result.data['refresh_token']);
    } catch (e) {
      print(e);
      prefs.clear();
    }
  }
}
