import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:ygo_collection_manager/core/platform/network_info.dart';

import 'network_info_test.mocks.dart';

@GenerateMocks([Connectivity])
void main() {
  final mockConnectivity = MockConnectivity();

  final networkInfo = NetworkInfoImpl(connectivity: mockConnectivity);

  group('isConnected', () {
    test('should call checkConnectivity()', () async {
      // arrange
      when(mockConnectivity.checkConnectivity()).thenAnswer(
        (_) async => ConnectivityResult.wifi,
      );

      // act
      await networkInfo.isConnected;

      // assert
      verify(mockConnectivity.checkConnectivity());
    });
  });

  test('should return false if ConnectivityResult.none is returned', () async {
    // arrange
    when(mockConnectivity.checkConnectivity()).thenAnswer(
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
      when(mockConnectivity.checkConnectivity()).thenAnswer(
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
    when(mockConnectivity.checkConnectivity()).thenAnswer(
      (_) async => ConnectivityResult.wifi,
    );

    // act
    final result = await networkInfo.isConnected;

    // assert
    expect(result, true);
  });
}
