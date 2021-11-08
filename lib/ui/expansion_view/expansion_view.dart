import 'package:animated_scaffold/animated_scaffold.dart';
import 'package:flutter/material.dart';

import '../../blocs/cards_bloc.dart';
import '../../blocs/expansion_collection_bloc.dart';
import '../../core/bloc/bloc_provider.dart';
import '../../domain/entities/ygo_card.dart';
import '../../domain/entities/ygo_set.dart';
import '../styles/colors.dart';
import '../common/card_widget.dart';
import 'widgets/card_editing_widget.dart';
import 'widgets/cards_grid.dart';
import 'widgets/collection_app_bar_bottom.dart';

class ExpansionView extends StatefulWidget {
  static const routeName = '/expansion';

  final YgoSet cardSet;

  const ExpansionView(this.cardSet, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ExpansionViewState();
}

class _ExpansionViewState extends State<ExpansionView>
    with SingleTickerProviderStateMixin {
  late final _expansionCollectionBloc =
      BlocProvider.of<ExpansionCollectionBloc>(context)
        ..initializeSet(widget.cardSet);
  late final CardsBloc _cardsBloc = BlocProvider.of<CardsBloc>(context);
  late final _cards = _cardsBloc.getCardsInSet(widget.cardSet)!;

  late final _animationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 400),
  );
  late final Animation<double> _animation = CurvedAnimation(
    parent: _animationController,
    curve: Curves.easeIn,
  );

  Future<bool> _onWillPop() async {
    if (_expansionCollectionBloc.isEditing) {
      _expansionCollectionBloc.disableEditing(_animationController);
      return false;
    }
    return true;
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: AnimatedAppBarScaffold(
        animation: _animation,
        appBar: ExpandingAppBarBottom(
          bottomExpandedHeight: 80,
          bottomHeight: 18,
          title: StreamBuilder<String?>(
            stream: _expansionCollectionBloc.onTitleChanged,
            builder: (_, snapshot) {
              final data = snapshot.data;
              String title = widget.cardSet.setName;
              if (snapshot.hasData && data != null) title = data;
              return Text(title);
            },
          ),
          bottomBuilder: (value) => PreferredSize(
            preferredSize: Size.fromHeight(value),
            child: CollectionAppBarBottom(
              animationDuration: _animationController.duration,
              currentSet: widget.cardSet,
            ),
          ),
        ),
        body: Container(
          margin: const EdgeInsets.only(top: 16),
          decoration: BoxDecoration(
            color: DynamicThemedColors.scaffoldBackground(context),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: StreamBuilder<bool>(
            stream: _expansionCollectionBloc.onEditionStateChanged,
            initialData: _expansionCollectionBloc.isEditing,
            builder: (_, snapshot) {
              final isEditing = snapshot.data!;
              return _CollectionLayout(
                cards: _cards,
                isEditing: isEditing,
                controller: _animationController,
              );
            },
          ),
        ),
      ),
    );
  }
}

class _CollectionLayout extends StatefulWidget {
  final List<YgoCard> cards;
  final bool isEditing;
  final AnimationController controller;

  const _CollectionLayout({
    required this.cards,
    required this.isEditing,
    required this.controller,
  });

  @override
  State<StatefulWidget> createState() => _CollectionLayoutState();
}

class _CollectionLayoutState extends State<_CollectionLayout> {
  late final _expansionCollectionBloc =
      BlocProvider.of<ExpansionCollectionBloc>(context);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
      stream: _expansionCollectionBloc.onSelectedCardIndexChanged,
      builder: (_, __) {
        return CardsGrid(
          cards: widget.cards,
          cardBuilder: (_, index) => !widget.isEditing
              ? CardWidget(
                  cards: widget.cards,
                  index: index,
                  onLongPress: () => _expansionCollectionBloc.enableEditing(
                    cardIndex: index,
                    controller: widget.controller,
                    cards: widget.cards,
                  ),
                )
              : CardEditingWidget(
                  index: index,
                  cards: widget.cards,
                  controller: widget.controller,
                ),
        );
      },
    );
  }
}
