import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:ygo_collection_manager/data/api/ygopro_local_data_source.dart';

import '../core/bloc/bloc.dart';
import '../core/isolate/isolate_wrapper.dart';
import '../data/api/ygopro_remote_data_source.dart';
import '../domain/entities/ygo_set.dart';
import '../service_locator.dart';

class SetsBloc extends BlocBase {
  final _setsController = BehaviorSubject<List<YgoSet>?>.seeded(null);
  Stream<List<YgoSet>?> get onSetsChanged => _setsController.stream;

  final _filteredSetsController = BehaviorSubject<List<YgoSet>?>.seeded(null);
  Stream<List<YgoSet>?> get onFilteredSetsChanged =>
      _filteredSetsController.stream;

  final searchController = TextEditingController();

  late final StreamSubscription _setsControllerSubscription;

  void _setsFilterListener(List<YgoSet>? value) {
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

  Future<void> loadFromDb() async {
    final _sets = (await locator<YgoProLocalDataSource>().getSets());
    _sets.sort((a, b) => a.setName.compareTo(b.setName));
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
      final remoteRepo = locator<YgoProRemoteDataSource>();
      await IsolateWrapper().spawn<List<YgoSet>>(
        () => remoteRepo.getAllSets(),
        callback: (_sets) {
          _sets.sort((a, b) => a.setName.compareTo(b.setName));
          _setsController.sink.add(_sets);
          locator<YgoProLocalDataSource>().updateSets(_sets);
        },
      );
    } catch (e) {
      _setsController.addError(e);
    }
  }

  Future<void> refreshSets() => fetchAllSets();
}
