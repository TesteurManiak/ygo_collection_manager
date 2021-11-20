import 'dart:async';
import 'dart:isolate';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import '../../core/bloc/bloc.dart';
import '../../domain/entities/ygo_set.dart';
import '../../domain/repository/ygopro_repository.dart';
import '../../domain/usecases/fetch_all_sets.dart';
import '../../domain/usecases/update_sets.dart';
import '../../service_locator.dart';

class SetsBloc implements BlocBase {
  final FetchAllSets fetchSets;
  final UpdateSets updateSets;
  final YgoProRepository repository;

  SetsBloc({
    required this.fetchSets,
    required this.updateSets,
    required this.repository,
  });

  final _setsController = BehaviorSubject<List<YgoSet>?>.seeded(null);
  Stream<List<YgoSet>?> get onSetsChanged => _setsController.stream;
  late final StreamSubscription _setsControllerSubscription;

  final _filteredSetsController = BehaviorSubject<List<YgoSet>?>.seeded(null);
  Stream<List<YgoSet>?> get onFilteredSetsChanged =>
      _filteredSetsController.stream;

  final searchController = TextEditingController();

  ReceivePort? _receivePort;
  Isolate? _isolate;
  StreamSubscription? _isolateSubscription;

  void _setsFilterListener(List<YgoSet>? value) {
    _filteredSetsController.sink.add(value);
    searchController.clear();
  }

  @override
  void initState() {
    _setsControllerSubscription = _setsController.listen(_setsFilterListener);
    loadFromDb();
  }

  @override
  void dispose() {
    _closeIsolate();

    searchController.dispose();
    _setsControllerSubscription.cancel();

    _setsController.close();
    _filteredSetsController.close();
  }

  void _closeIsolate() {
    _receivePort?.close();
    _isolate?.kill(priority: Isolate.immediate);
    _isolateSubscription?.cancel();
  }

  Future<void> loadFromDb() async {
    final _sets = (await repository.getLocalSets());
    _setsController.sink.add(_sets);
  }

  void filter(String search) {
    if (search.isEmpty) {
      _filteredSetsController.sink.add(_setsController.value);
    } else {
      _filteredSetsController.sink.add(
        _setsController.value!
            .where(
              (e) =>
                  e.setName.toLowerCase().contains(search.toLowerCase()) ||
                  e.setCode.toLowerCase().contains(search.toLowerCase()),
            )
            .toList(),
      );
    }
  }

  static void _fetchSets(List<Object> args) {
    final sendPort = args[0] as SendPort;
    setupLocator();
    sl<FetchAllSets>().call().then((value) => sendPort.send(value));
  }

  Future<void> fetchAllSets() async {
    try {
      if (kIsWeb) {
      } else {
        _receivePort = ReceivePort();
        _isolate = await Isolate.spawn(
          _fetchSets,
          [_receivePort!.sendPort],
        );
        _isolateSubscription = _receivePort!.listen((message) {
          final _sets = message as List<YgoSet>;
          _setsController.sink.add(_sets);
          updateSets(_sets);
          _closeIsolate();
        });
      }
    } catch (e) {
      _setsController.addError(e);
    }
  }
}
