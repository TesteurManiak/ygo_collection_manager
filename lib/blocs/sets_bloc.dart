import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:ygo_collection_manager/api/api_repository.dart';
import 'package:ygo_collection_manager/core/bloc/bloc.dart';
import 'package:ygo_collection_manager/core/isolate/isolate_wrapper.dart';
import 'package:ygo_collection_manager/helper/hive_helper.dart';
import 'package:ygo_collection_manager/models/set_model.dart';

class SetsBloc extends BlocBase {
  final _setsController = BehaviorSubject<List<SetModel>?>.seeded(null);
  Stream<List<SetModel>?> get onSetsChanged => _setsController.stream;

  final _filteredSetsController = BehaviorSubject<List<SetModel>?>.seeded(null);
  Stream<List<SetModel>?> get onFilteredSetsChanged =>
      _filteredSetsController.stream;

  final searchController = TextEditingController();

  late final StreamSubscription _setsControllerSubscription;

  void _setsFilterListener(List<SetModel>? value) {
    _filteredSetsController.sink.add(value);
    searchController.clear();
  }

  @override
  void dispose() {
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

  void loadFromDb() {
    final _sets = HiveHelper.instance.sets.toList()
      ..sort((a, b) => a.setName.compareTo(b.setName));
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

  Future<void> fetchAllSets() async {
    try {
      await IsolateWrapper().spawn<List<SetModel>>(
        () => apiRepository.getAllSets(),
        workerName: "ww.dart2.js",
        callback: (_sets) {
          _sets.sort((a, b) => a.setName.compareTo(b.setName));
          _setsController.sink.add(_sets);
          HiveHelper.instance.updateSets(_sets);
        },
      );
    } catch (e) {
      _setsController.addError(e);
    }
  }

  Future<void> refreshSets() => fetchAllSets();
}
