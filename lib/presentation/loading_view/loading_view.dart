import 'package:flutter/material.dart';

import '../blocs/bloc_provider.dart';
import '../blocs/db_version_bloc.dart';
import '../components/magic_circle_progress_indicator.dart';
import 'loading_state_info.dart';

class LoadingView extends StatefulWidget {
  static const routeName = 'loading';
  static const routePath = '/';

  final LoadingStateInfo state;

  const LoadingView({Key? key, required this.state}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoadingViewState();
}

class _LoadingViewState extends State<LoadingView> {
  late final _dbVersionBloc = BlocProvider.of<DBVersionBloc>(context);

  @override
  void initState() {
    super.initState();
    final hasLoaded = widget.state.hasLoaded;
    if (!hasLoaded) {
      _dbVersionBloc.updateDatabase(context).then(
            (_) => widget.state.finishedLoading(),
          );
    }
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
