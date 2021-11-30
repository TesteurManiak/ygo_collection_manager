import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:ygo_collection_manager/core/error/exceptions.dart';
import 'package:ygo_collection_manager/data/api/api.dart';

void main() {
  final tResponseValid = <String, dynamic>{};

  final dio = Dio();

  DioAdapter(dio: dio)
    ..onGet(
      'test',
      (server) => server.reply(200, tResponseValid),
    )
    ..onGet(
      'error',
      (server) => server.reply(404, {}),
    );

  final remoteClient = DioClient(dio: dio);

  group('get', () {
    test('should return a valid response', () async {
      final response = await remoteClient.get('test');

      expect(response, tResponseValid);
    });

    test(
      'should throw a ServerException if response has a status code different than 200',
      () async {
        expect(
          () async => await remoteClient.get('error'),
          throwsA(isA<ServerException>()),
        );
      },
    );
  });
}
