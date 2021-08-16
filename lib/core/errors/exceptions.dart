class ServerException implements Exception {
  final String message;
  final int code;

  ServerException({required this.message, required this.code});
}

class CacheException implements Exception {}
