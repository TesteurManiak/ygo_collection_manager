import 'dart:async';
import 'dart:isolate';

import 'package:flutter/foundation.dart';

class IsolateWrapper {
  ReceivePort? _receivePort;
  StreamSubscription? _isolateSubscription;
  Isolate? _isolate;

  static void _isolateFunc<T>(List<Object> args) {
    final sendPort = args[0] as SendPort;
    final asyncMethod = args[1] as Future<T>;
    asyncMethod.then((result) => sendPort.send(result));
  }

  Future<void> spawn<T>(
    Future<T> Function() asyncMethod, {
    required String workerName,
    void Function(T data)? callback,
  }) async {
    if (kIsWeb) {
      await Future.microtask(() async {
        final result = await asyncMethod();
        callback?.call(result);
      });
    } else {
      _receivePort = ReceivePort();
      _isolate = await Isolate.spawn<List<Object>>(
        _isolateFunc,
        <Object>[
          _receivePort!.sendPort,
          asyncMethod,
        ],
      );
      _isolateSubscription = _receivePort!.listen((message) {
        callback?.call(message as T);
        _closeIsolate();
      });
    }
  }

  void kill() => _closeIsolate();

  void _closeIsolate() {
    _receivePort?.close();
    _isolate?.kill(priority: Isolate.immediate);
    _isolateSubscription?.cancel();
  }
}
