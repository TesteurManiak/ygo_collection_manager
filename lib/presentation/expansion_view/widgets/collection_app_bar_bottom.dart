import 'package:async/async.dart' show StreamGroup;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/consts/durations.dart';
import '../../../domain/entities/ygo_set.dart';
import '../../blocs/cards/cards_bloc.dart';
import '../../blocs/expansion_collection/expansion_collection_bloc.dart';
import '../../components/total_completion_widget.dart';
import 'add_remove_card_widget.dart';

class CollectionAppBarBottom extends StatefulWidget {
  final Duration? animationDuration;
  final YgoSet currentSet;

  const CollectionAppBarBottom({
    Key? key,
    this.animationDuration,
    required this.currentSet,
  }) : super(key: key);

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
      widget.animationDuration ?? Durations.ms200;

  @override
  Widget build(BuildContext context) {
    final cardsBloc = BlocProvider.of<CardsBloc>(context);
    return StreamBuilder(
      stream: _onChanges,
      builder: (_, __) {
        return AnimatedCrossFade(
          firstChild: FutureBuilder<int>(
            future: cardsBloc.cardsOwnedInSet(widget.currentSet),
            builder: (_, snapshot) {
              return TotalCompletionWidget(
                getTotalCompletion: () {
                  final numOfCards =
                      cardsBloc.getCardsInSet(widget.currentSet)?.length ??
                          widget.currentSet.numOfCards;
                  final cardsOwned = snapshot.hasData ? snapshot.data! : 0;
                  return cardsOwned / numOfCards * 100;
                },
              );
            },
          ),
          secondChild: AddRemoveCardWidget(widget.currentSet),
          crossFadeState: _expansionCollectionBloc.isEditing
              ? CrossFadeState.showSecond
              : CrossFadeState.showFirst,
          duration: _animationDuration,
        );
      },
    );
  }
}
