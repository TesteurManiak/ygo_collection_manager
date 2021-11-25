import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../core/error/exceptions.dart';

abstract class RemoteClient {
  Future get(String uri);
}

class DioClient implements RemoteClient {
  final _dio = Dio();

  @override
  Future get(String uri) async {
    try {
      final response = await _dio.get(uri);
      return response.data;
    } on DioError catch (e) {
      debugPrint(e.toString());
      throw ServerException(message: e.response?.statusMessage);
    }
  }
}
