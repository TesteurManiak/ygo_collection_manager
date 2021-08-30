import 'dart:async';
import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:ygo_collection_manager/api/api_repository.dart';
import 'package:ygo_collection_manager/blocs/bloc.dart';
import 'package:ygo_collection_manager/helper/hive_helper.dart';
import 'package:ygo_collection_manager/models/set_model.dart';

class SetsBloc extends BlocBase {
  final _setsController = BehaviorSubject<List<SetModel>?>.seeded(null);
  Stream<List<SetModel>?> get onSetsChanged => _setsController.stream;

  final _filteredSetsController = BehaviorSubject<List<SetModel>?>.seeded(null);
  Stream<List<SetModel>?> get onFilteredSetsChanged =>
      _filteredSetsController.stream;

  final searchController = TextEditingController();

  late Isolate _isolate;
  late ReceivePort _receivePort;
  late StreamSubscription _isolateSubscription;

  late final StreamSubscription _setsControllerSubscription;

  void _setsFilterListener(List<SetModel>? value) {
    _filteredSetsController.sink.add(value);
    searchController.clear();
  }

  @override
  void dispose() {
    _closeIsolate();

    searchController.dispose();
    _setsControllerSubscription.cancel();

    _setsController.close();
    _filteredSetsController.close();
  }

  @override
  void initState() {
    _setsControllerSubscription = _setsController.listen(_setsFilterListener);

    loadFromDb();
  }

  void _closeIsolate() {
    _receivePort.close();
    _isolate.kill(priority: Isolate.immediate);
    _isolateSubscription.cancel();
  }

  static void _fetchSets(List<Object> args) {
    final sendPort = args[0] as SendPort;
    apiRepository.getAllSets().then((value) => sendPort.send(value));
  }

  void loadFromDb() {
    final _sets = HiveHelper.instance.sets.toList()
      ..sort((a, b) => a.setName.compareTo(b.setName));
    _setsController.sink.add(_sets);
  }

  void filter(String search) {
    if (search.isEmpty) {
      _filteredSetsController.sink.add(_setsController.value);
    } else {
      _filteredSetsController.sink.add(_setsController.value!
          .where((e) =>
              e.setName.toLowerCase().contains(search.toLowerCase()) ||
              e.setCode.toLowerCase().contains(search.toLowerCase()))
          .toList());
    }
  }

  Future<void> fetchAllSets() async {
    try {
      _receivePort = ReceivePort();
      _isolate = await Isolate.spawn(_fetchSets, <Object>[
        _receivePort.sendPort,
      ]);
      _isolateSubscription = _receivePort.listen((message) {
        final _sets = message as List<SetModel>
          ..sort((a, b) => a.setName.compareTo(b.setName));
        _setsController.sink.add(_sets);
        HiveHelper.instance.updateSets(_sets);
        _closeIsolate();
      });
    } catch (e) {
      _setsController.addError(e);
    }
  }

  Future<void> refreshSets() => fetchAllSets();
}
