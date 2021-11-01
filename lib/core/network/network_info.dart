import 'package:connectivity_plus/connectivity_plus.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  final _connectivityInstance = Connectivity();

  @override
  Future<bool> get isConnected async {
    final connectivityResult = await _connectivityInstance.checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }
}
