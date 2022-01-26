class ServerException implements Exception {
  final String? message;

  const ServerException({this.message});
}

class CacheException implements Exception {
  final String? message;

  const CacheException({this.message});
}

class MissingRouteParamException implements Exception {
  final String message;

  const MissingRouteParamException(this.message);
}
