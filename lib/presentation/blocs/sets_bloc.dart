import 'dart:async';

import 'package:rxdart/rxdart.dart';

import '../../domain/entities/ygo_set.dart';
import '../../domain/usecases/fetch_all_sets.dart';
import 'bloc.dart';

class SetsBloc implements BlocBase {
  final FetchAllSets fetchSets;

  SetsBloc({required this.fetchSets});

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
  void initState() {
    _setsControllerSubscription = _setsController.listen(_setsFilterListener);
  }

  @override
  void dispose() {
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
    } catch (e) {
      _setsController.addError(e);
    }
  }
}
