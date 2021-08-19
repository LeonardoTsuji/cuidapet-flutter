import 'package:dio/dio.dart';

class AcessoNegadoException extends DioError {
  String mensagem;

  AcessoNegadoException(this.mensagem, DioError exception)
      : super(
            requestOptions: exception.requestOptions,
            response: exception.response,
            type: exception.type,
            error: exception.error);

  @override
  String toString() =>
      'AcessoNegadoException(mensagem: $mensagem), exception: ${super.error}';
}
