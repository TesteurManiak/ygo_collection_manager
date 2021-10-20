import 'package:flutter/material.dart';

import 'bloc.dart';

class BlocProvider<T extends BlocBase> extends StatefulWidget {
  final Widget child;
  final List<T> blocs;

  static late GlobalKey _masterKey;

  BlocProvider({
    required Key key,
    required this.child,
    this.blocs = const [],
  }) : super(key: key) {
    _masterKey = key as GlobalKey;
  }

  @override
  _BlocProviderState createState() => _BlocProviderState();

  static T of<T extends BlocBase>(BuildContext context) {
    final _BlocProviderInherited provider = context
        .getElementForInheritedWidgetOfExactType<_BlocProviderInherited>()!
        .widget as _BlocProviderInherited;
    return provider.blocs.firstWhere((x) => x is T) as T;
  }

  static T master<T extends BlocBase>() =>
      (_masterKey.currentWidget! as BlocProvider)
          .blocs
          .firstWhere((x) => x is T) as T;
}

class _BlocProviderState extends State<BlocProvider> {
  @override
  void initState() {
    super.initState();
    for (final bloc in widget.blocs) {
      bloc.initState();
    }
  }

  @override
  void dispose() {
    for (final bloc in widget.blocs) {
      bloc.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _BlocProviderInherited(
      blocs: widget.blocs,
      child: widget.child,
    );
  }
}

class _BlocProviderInherited extends InheritedWidget {
  final List<BlocBase> blocs;

  const _BlocProviderInherited({
    Key? key,
    required Widget child,
    required this.blocs,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;
}
