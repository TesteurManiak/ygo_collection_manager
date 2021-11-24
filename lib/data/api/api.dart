import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../core/error/exceptions.dart';

abstract class RemoteClient {
  Future<T> getUri<T>(Uri uri);
}

class DioClient implements RemoteClient {
  final  _dio = Dio();

  @override
  Future<T> getUri<T>(Uri uri) async {
    try {
      final response = await _dio.getUri<T>(uri);
      return response.data as T;
    } on DioError catch (e) {
      debugPrint(e.toString());
      throw ServerException(message: e.response?.statusMessage);
    }
  }
}
