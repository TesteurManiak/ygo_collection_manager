import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app.dart';
import 'data/datasources/local/ygopro_local_datasource.dart';
import 'presentation/blocs/cards/cards_bloc.dart';
import 'presentation/blocs/db_version/db_version_bloc.dart';
import 'presentation/blocs/expansion_collection/expansion_collection_bloc.dart';
import 'presentation/blocs/sets/sets_bloc.dart';
import 'service_locator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  setupLocator();
  await sl<YgoProLocalDataSource>().initDb();

  final cardsBloc = CardsBloc(fetchCards: sl(), fetchOwnedCards: sl());

  runApp(
    MultiBlocProvider(
      key: GlobalKey(),
      providers: [
        BlocProvider(create: (_) => SetsBloc(fetchSets: sl())),
        BlocProvider(create: (_) => cardsBloc),
        BlocProvider(
          create: (_) => ExpansionCollectionBloc(
            getCopiesOfCardOwned: sl(),
            updateCardOwned: sl(),
            cardsBloc: cardsBloc,
          ),
        ),
        BlocProvider(
          create: (_) => DBVersionBloc(shouldReloadDb: sl()),
        ),
      ],
      child: const MyApp(),
    ),
  );
}
