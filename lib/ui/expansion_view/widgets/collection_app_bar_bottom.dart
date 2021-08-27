import 'package:flutter/material.dart';
import 'package:ygo_collection_manager/blocs/bloc_provider.dart';
import 'package:ygo_collection_manager/blocs/expansion_collection_bloc.dart';
import 'package:async/async.dart' show StreamGroup;
import 'package:ygo_collection_manager/ui/common/total_completion_widget.dart';
import 'package:ygo_collection_manager/ui/expansion_view/widgets/add_remove_card_widget.dart';

class CollectionAppBarBottom extends StatefulWidget {
  final Duration? animationDuration;

  const CollectionAppBarBottom({this.animationDuration});

  @override
  State<StatefulWidget> createState() => _CollectionAppBarBottomState();
}

class _CollectionAppBarBottomState extends State<CollectionAppBarBottom> {
  late final ExpansionCollectionBloc _expansionCollectionBloc =
      BlocProvider.of<ExpansionCollectionBloc>(context);

  late final _onChanges = StreamGroup.merge([
    _expansionCollectionBloc.onEditionStateChanged,
    _expansionCollectionBloc.onSelectedCardIndexChanged,
  ]);

  late final Duration _animationDuration =
      widget.animationDuration ?? const Duration(milliseconds: 200);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _onChanges,
      builder: (_, __) {
        return AnimatedCrossFade(
          firstChild: const TotalCompletionWidget(0.0),
          secondChild: AddRemoveCardWidget(),
          crossFadeState: _expansionCollectionBloc.isEditing
              ? CrossFadeState.showSecond
              : CrossFadeState.showFirst,
          duration: _animationDuration,
        );
      },
    );
  }
}
