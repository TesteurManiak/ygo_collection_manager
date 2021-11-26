import 'package:flutter/material.dart';
import 'package:ygo_collection_manager/core/bloc/bloc.dart';
import 'package:ygo_collection_manager/core/bloc/bloc_provider.dart';

/// Return a `MaterialApp` nested inside a `BlocProvider` providing instances of
/// [blocs] accessible to the descendant [child] widget.
Widget createApp({required List<BlocBase> blocs, required Widget child}) {
  return BlocProvider(
    key: GlobalKey(),
    blocs: blocs,
    child: MaterialApp(home: child),
  );
}
