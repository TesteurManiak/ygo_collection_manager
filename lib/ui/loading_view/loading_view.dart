import 'package:flutter/material.dart';
import 'package:ygo_collection_manager/blocs/bloc_provider.dart';
import 'package:ygo_collection_manager/blocs/cards_bloc.dart';
import 'package:ygo_collection_manager/blocs/sets_bloc.dart';
import 'package:ygo_collection_manager/ui/root_view/root_view.dart';

class LoadingView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoadingViewState();
}

class _LoadingViewState extends State<LoadingView> {
  late final _setsBloc = BlocProvider.of<SetsBloc>(context);
  late final _cardsBloc = BlocProvider.of<CardsBloc>(context);

  @override
  void initState() {
    super.initState();
    Future.wait([
      _setsBloc.fetchAllSets(),
      _cardsBloc.fetchAllCards(),
    ]).then((_) => Navigator.pushReplacementNamed(context, RootView.routeName));
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
