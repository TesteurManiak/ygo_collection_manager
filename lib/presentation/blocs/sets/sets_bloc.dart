import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

import '../../../domain/entities/ygo_set.dart';
import '../../../domain/usecases/fetch_all_sets.dart';
import '../state.dart';

part 'sets_state.dart';

class SetsBloc extends Cubit {
  final FetchAllSets fetchSets;

  SetsBloc({required this.fetchSets}) : super(const SetsInitial()) {
    _setsControllerSubscription = _setsController.listen(_setsFilterListener);
  }

  final _setsController = BehaviorSubject<List<YgoSet>?>.seeded(null);
  Stream<List<YgoSet>?> get onSetsChanged => _setsController.stream;
  List<YgoSet> get sets => _setsController.value ?? [];
  late final StreamSubscription _setsControllerSubscription;

  final _filteredSetsController = BehaviorSubject<List<YgoSet>?>.seeded(null);
  Stream<List<YgoSet>?> get onFilteredSetsChanged =>
      _filteredSetsController.stream;

  void _setsFilterListener(List<YgoSet>? value) =>
      _filteredSetsController.sink.add(value);

  @override
  Future<void> close() {
    _setsControllerSubscription.cancel();

    _setsController.close();
    _filteredSetsController.close();
    return super.close();
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
    } catch (e) {
      _setsController.addError(e);
    }
  }

  YgoSet findSetFromCode(String setCode) {
    return sets.firstWhere((e) => e.setCode == setCode);
  }
}
