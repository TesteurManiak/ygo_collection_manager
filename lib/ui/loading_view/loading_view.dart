import 'package:flutter/material.dart';
import 'package:ygo_collection_manager/blocs/bloc_provider.dart';
import 'package:ygo_collection_manager/blocs/cards_bloc.dart';
import 'package:ygo_collection_manager/blocs/db_version_bloc.dart';
import 'package:ygo_collection_manager/blocs/sets_bloc.dart';
import 'package:ygo_collection_manager/ui/common/magic_circle_progress_indicator.dart';
import 'package:ygo_collection_manager/ui/root_view/root_view.dart';

class LoadingView extends StatefulWidget {
  static const routeName = '/';

  const LoadingView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoadingViewState();
}

class _LoadingViewState extends State<LoadingView> {
  late final _setsBloc = BlocProvider.of<SetsBloc>(context);
  late final _cardsBloc = BlocProvider.of<CardsBloc>(context);
  late final _dbVersionBloc = BlocProvider.of<DBVersionBloc>(context);

  Future<void> _loadAll() async {
    final shouldReload = await _dbVersionBloc.shouldReloadDatabase();
    if (shouldReload) {
      await Future.wait([
        _setsBloc.fetchAllSets(),
        _cardsBloc.fetchAllCards(),
      ]);
    }
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(_loadAll).then(
      (_) => Navigator.pushReplacementNamed(context, RootView.routeName),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: size.width / 2,
            maxHeight: size.width / 2,
          ),
          child: const MagicCircleProgressIndicator(),
        ),
      ),
    );
  }
}
