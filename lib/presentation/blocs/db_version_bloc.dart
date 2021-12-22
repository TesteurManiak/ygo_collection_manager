import 'dart:async';

import 'package:flutter/material.dart';

import '../../domain/usecases/should_reload_db.dart';
import 'bloc.dart';
import 'bloc_provider.dart';
import 'cards_bloc.dart';
import 'sets_bloc.dart';

class DBVersionBloc implements BlocBase {
  final ShouldReloadDb _shouldReloadDb;

  DBVersionBloc({required ShouldReloadDb shouldReloadDb})
      : _shouldReloadDb = shouldReloadDb;

  @override
  void initState() {}

  @override
  void dispose() {}

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
