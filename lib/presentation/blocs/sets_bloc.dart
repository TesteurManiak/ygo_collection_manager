import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import '../../core/bloc/bloc.dart';
import '../../domain/entities/ygo_set.dart';
import '../../domain/repository/ygopro_repository.dart';
import '../../domain/usecases/fetch_all_sets.dart';
import '../../domain/usecases/update_sets.dart';

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

  void _setsFilterListener(List<YgoSet>? value) {
    _filteredSetsController.sink.add(value);
    searchController.clear();
  }

  @override
  void initState() {
    _setsControllerSubscription = _setsController.listen(_setsFilterListener);
  }

  @override
  void dispose() {
    searchController.dispose();
    _setsControllerSubscription.cancel();

    _setsController.close();
    _filteredSetsController.close();
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

  Future<void> fetchAllSets({required bool shouldReload}) async {
    try {
      final _sets = await fetchSets(shouldReload: shouldReload);
      _setsController.sink.add(_sets);
      await updateSets(_sets);
    } catch (e) {
      _setsController.addError(e);
    }
  }
}
