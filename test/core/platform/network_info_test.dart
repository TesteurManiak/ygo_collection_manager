import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ygo_collection_manager/data/platform/network_info.dart';

import '../../utils/mocks.dart';

void main() {
  late MockConnectivity mockConnectivity;

  late NetworkInfoImpl networkInfo;

  setUp(() {
    mockConnectivity = MockConnectivity();
    networkInfo = NetworkInfoImpl(connectivity: mockConnectivity);
  });

  group('isConnected', () {
    test('should call checkConnectivity()', () async {
      // arrange
      when(mockConnectivity.checkConnectivity).thenAnswer(
        (_) async => ConnectivityResult.wifi,
      );

      // act
      await networkInfo.isConnected;

      // assert
      verify(mockConnectivity.checkConnectivity);
    });
  });

  test('should return false if ConnectivityResult.none is returned', () async {
    // arrange
    when(mockConnectivity.checkConnectivity).thenAnswer(
      (_) async => ConnectivityResult.none,
    );

    // act
    final result = await networkInfo.isConnected;

    // assert
    expect(result, false);
  });

  test(
    'should return false if ConnectivityResult.bluetooth is returned',
    () async {
      // arrange
      when(mockConnectivity.checkConnectivity).thenAnswer(
        (_) async => ConnectivityResult.bluetooth,
      );

      // act
      final result = await networkInfo.isConnected;

      // assert
      expect(result, false);
    },
  );

  test('should return true if ConnectivityResult.wifi is returned', () async {
    // arrange
    when(mockConnectivity.checkConnectivity).thenAnswer(
      (_) async => ConnectivityResult.wifi,
    );

    // act
    final result = await networkInfo.isConnected;

    // assert
    expect(result, true);
  });

  test('should return true if ConnectivityResult.mobile is returned', () async {
    // arrange
    when(mockConnectivity.checkConnectivity).thenAnswer(
      (_) async => ConnectivityResult.mobile,
    );

    // act
    final result = await networkInfo.isConnected;

    // assert
    expect(result, true);
  });

  test(
    'should return true if ConnectivityResult.ethernet is returned',
    () async {
      // arrange
      when(mockConnectivity.checkConnectivity).thenAnswer(
        (_) async => ConnectivityResult.ethernet,
      );

      // act
      final result = await networkInfo.isConnected;

      // assert
      expect(result, true);
    },
  );
}
