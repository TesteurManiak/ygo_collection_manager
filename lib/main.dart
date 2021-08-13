import 'package:flutter/material.dart';
import 'package:ygo_collection_manager/blocs/bloc.dart';
import 'package:ygo_collection_manager/blocs/bloc_provider.dart';
import 'package:ygo_collection_manager/blocs/navigation_bloc.dart';
import 'package:ygo_collection_manager/blocs/sets_bloc.dart';
import 'package:ygo_collection_manager/ui/root_view/root_view.dart';

void main() {
  runApp(
    BlocProvider(
      key: GlobalKey(),
      blocs: <BlocBase>[
        NavigationBloc(),
        SetsBloc(),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: RootView(),
    );
  }
}
