class ServerException implements Exception {}

class CacheException implements Exception {
  final String? message;

  CacheException({this.message});
}
