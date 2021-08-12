
class RestClientException implements Exception {
  final String? message;
  final int? statusCode;
  final dynamic error;

  RestClientException({
    this.message,
    this.statusCode,
    this.error,
  });
}
