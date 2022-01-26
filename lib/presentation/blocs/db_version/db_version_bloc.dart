import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/should_reload_db.dart';
import '../cards/cards_bloc.dart';
import '../sets/sets_bloc.dart';
import '../state.dart';

part 'db_version_state.dart';

class DBVersionBloc extends Cubit<DbVersionState> {
  final ShouldReloadDb _shouldReloadDb;

  DBVersionBloc({required ShouldReloadDb shouldReloadDb})
      : _shouldReloadDb = shouldReloadDb,
        super(const DbVersionInitial());

  Future<void> updateDatabase(BuildContext context) async {
    final shouldReload = await _shouldReloadDb();
    unawaited(
      Future.microtask(() {
        BlocProvider.of<SetsBloc>(context)
            .fetchAllSets(shouldReload: shouldReload);
        BlocProvider.of<CardsBloc>(context)
            .fetchAllCards(shouldReload: shouldReload);
      }),
    );
  }
}
