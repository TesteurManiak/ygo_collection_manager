import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ygo_collection_manager/presentation/constants/themes.dart';

/// Return a `MaterialApp` nested inside a `BlocProvider` providing instances of
/// [blocs] accessible to the descendant [child] widget.
Widget createApp({
  required List<BlocBase> blocs,
  required Widget child,
  ThemeData? theme,
}) {
  return MultiBlocProvider(
    key: GlobalKey(),
    providers:
        blocs.map<BlocProvider>((e) => BlocProvider(create: (_) => e)).toList(),
    child: MaterialApp(
      theme: theme ?? MyThemes.light,
      debugShowCheckedModeBanner: false,
      home: child,
    ),
  );
}
