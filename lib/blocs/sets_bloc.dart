import 'dart:async';
import 'dart:isolate';

import 'package:rxdart/rxdart.dart';
import 'package:ygo_collection_manager/api/api_repository.dart';
import 'package:ygo_collection_manager/blocs/bloc.dart';
import 'package:ygo_collection_manager/models/set_model.dart';

class SetsBloc extends BlocBase {
  final _setsController = BehaviorSubject<List<SetModel>?>.seeded(null);
  Stream<List<SetModel>?> get onSetsChanged => _setsController.stream;

  late Isolate _isolate;
  late ReceivePort _receivePort;
  late StreamSubscription _isolateSubscription;

  @override
  void dispose() {
    _closeIsolate();
    _setsController.close();
  }

  @override
  void initState() {}

  void _closeIsolate() {
    _receivePort.close();
    _isolate.kill(priority: Isolate.immediate);
    _isolateSubscription.cancel();
  }

  static void _fetchSets(List<Object> args) {
    final sendPort = args[0] as SendPort;
    apiRepository.getAllSets().then((value) => sendPort.send(value));
  }

  Future<void> fetchAllSets() async {
    try {
      _receivePort = ReceivePort();
      _isolate = await Isolate.spawn(_fetchSets, <Object>[
        _receivePort.sendPort,
      ]);
      _isolateSubscription = _receivePort.listen((message) {
        _setsController.sink.add(message as List<SetModel>);
        _closeIsolate();
      });
    } catch (e) {
      _setsController.addError(e);
    }
  }

  Future<void> refreshSets() => fetchAllSets();
}
