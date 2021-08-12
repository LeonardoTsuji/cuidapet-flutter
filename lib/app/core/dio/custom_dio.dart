import 'package:cuidapet/app/repository/shared_prefs_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class CustomDio {
  static CustomDio? _simpleInstance;
  static CustomDio? _authInstance;

  late Dio _dio;

  BaseOptions options = BaseOptions(
    baseUrl: DotEnv().env['base_url'] ?? '',
    connectTimeout: 30000,
    // connectTimeout: int.parse(DotEnv().env['dio_connectTimeout']),
    receiveTimeout: 30000,
    // receiveTimeout: int.parse(DotEnv().env['dioreceiveTimeout']),
  );

  CustomDio._() {
    _dio = Dio(options);
  }

  CustomDio._auth() {
    _dio = Dio(options);
    // _dio.interceptors.add(AuthInterceptorWrapper());
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

// class AuthInterceptorWrapper extends InterceptorsWrapper {
//   @override
//   Future onRequest(RequestOptions options) async {
//     final prefs = await SharedPrefsRepository.instance;

//     // options.headers['Authorization'] = prefs!.accessToken;

//     if (DotEnv().env['profile'] == 'dev') {
//       print('############## Request Log ##############');
//       print('url ${options.uri}');
//       print('method ${options.method}');
//       print('data ${options.data}');
//       print('headers ${options.headers}');
//     }
//   }

//   @override
//   Future onResponse(Response response) async {
//     if (DotEnv().env['profile'] == 'dev') {
//       print('############## Response Log ##############');
//       print('data ${response.data}');
//     }
//   }

//   @override
//   Future onError(DioError err) async {
//     print('error: ${err.response}');
//   }
// }
