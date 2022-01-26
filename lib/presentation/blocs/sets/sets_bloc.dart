import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/ygo_set.dart';
import '../../../domain/usecases/fetch_all_sets.dart';
import '../state.dart';

part 'sets_state.dart';

class SetsBloc extends Cubit<SetsState> {
  final FetchAllSets fetchSets;

  SetsBloc({required this.fetchSets}) : super(const SetsInitial());

  /// Used to keep a reference to the initial sets' data fetched.
  List<YgoSet> _sets = [];
  List<YgoSet> get sets => _sets;

  void filter(String search) {
    if (search.isEmpty) {
      emit(SetsFiltered(_sets));
    } else {
      final filteredResults = _sets
          .where(
            (e) =>
                e.setName.contains(RegExp(search, caseSensitive: false)) ||
                e.setCode.contains(RegExp(search, caseSensitive: false)),
          )
          .toList();
      emit(SetsFiltered(filteredResults));
    }
  }

  Future<void> fetchAllSets({required bool shouldReload}) async {
    emit(const SetsLoading());
    try {
      final newSets = await fetchSets(shouldReload: shouldReload);
      emit(SetsLoaded(newSets));
      _sets = newSets;
    } catch (e) {
      emit(SetsError(e.toString()));
    }
  }

  YgoSet findSetFromCode(String setCode) {
    return sets.firstWhere((e) => e.setCode == setCode);
  }
}
