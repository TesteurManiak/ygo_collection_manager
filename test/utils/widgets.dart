import 'package:flutter/material.dart';
import 'package:ygo_collection_manager/presentation/constants/themes.dart';

/// Return a `MaterialApp` nested inside a `BlocProvider` providing instances of
/// [blocs] accessible to the descendant [child] widget.
Widget createApp({required Widget child, ThemeData? theme}) {
  return MaterialApp(
    theme: theme ?? MyThemes.light,
    debugShowCheckedModeBanner: false,
    home: child,
  );
}
