import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/bloc/bloc_provider.dart';
import '../blocs/db_version_bloc.dart';
import '../common/magic_circle_progress_indicator.dart';
import '../root_view/root_view.dart';
import 'loading_state.dart';

class LoadingView extends StatefulWidget {
  final LoadingState state;

  const LoadingView({Key? key, required this.state}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoadingViewState();
}

class _LoadingViewState extends State<LoadingView> {
  late final _dbVersionBloc = BlocProvider.of<DBVersionBloc>(context);

  @override
  void initState() {
    super.initState();
    Future.microtask(_dbVersionBloc.updateDatabase).then(
      (_) {
        widget.state.finishedLoading();
        context.goNamed(RootView.routeName);
      },
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
