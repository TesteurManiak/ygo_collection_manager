import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/consts/consts.dart';
import '../../core/consts/durations.dart';
import '../../core/consts/my_edge_insets.dart';
import '../../domain/entities/ygo_card.dart';
import '../../domain/entities/ygo_set.dart';
import '../../router.dart';
import '../blocs/cards/cards_bloc.dart';
import '../blocs/expansion_collection/expansion_collection_bloc.dart';
import '../blocs/sets/sets_bloc.dart';
import '../common/animated_scaffold/animated_app_bar.dart';
import '../common/animated_scaffold/animated_scaffold.dart';
import '../components/card_widget.dart';
import '../constants/colors.dart';
import 'widgets/card_editing_widget.dart';
import 'widgets/cards_grid.dart';
import 'widgets/collection_app_bar_bottom.dart';

class ExpansionView extends StatefulWidget {
  static Map<String, String> routeParams(YgoSet ygoSet) => {
        AppRouteParams.setCode: ygoSet.setCode,
      };

  final String setCode;

  const ExpansionView({Key? key, required this.setCode}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ExpansionViewState();
}

class _ExpansionViewState extends State<ExpansionView>
    with SingleTickerProviderStateMixin {
  late final cardSet =
      BlocProvider.of<SetsBloc>(context).findSetFromCode(widget.setCode);
  late final _expansionCollectionBloc =
      BlocProvider.of<ExpansionCollectionBloc>(context)..initializeSet(cardSet);
  late final CardsBloc _cardsBloc = BlocProvider.of<CardsBloc>(context);
  late final _cards = _cardsBloc.getCardsInSet(cardSet)!;

  late final _animationController = AnimationController(
    vsync: this,
    duration: Durations.ms400,
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
      child: AnimatedScaffold(
        animation: _animation,
        appBarBuilder: (listenable) => ExpandingAppBarBottom(
          bottomExpandedHeight: Consts.px80,
          bottomHeight: Consts.px18,
          title: StreamBuilder<String?>(
            stream: _expansionCollectionBloc.onTitleChanged,
            builder: (_, snapshot) {
              final data = snapshot.data;
              String title = cardSet.setName;
              if (snapshot.hasData && data != null) title = data;
              return Text(title);
            },
          ),
          bottomBuilder: (value) => PreferredSize(
            preferredSize: Size.fromHeight(value),
            child: CollectionAppBarBottom(
              animationDuration: _animationController.duration,
              currentSet: cardSet,
            ),
          ),
          animation: listenable as Animation<double>,
        ),
        body: Container(
          margin: MyEdgeInsets.onlyT16,
          decoration: BoxDecoration(
            color: DynamicThemedColors.scaffoldBackground(context),
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(Consts.px20),
            ),
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
                setId: cardSet.setCode,
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
  final String setId;

  const _CollectionLayout({
    required this.cards,
    required this.isEditing,
    required this.controller,
    required this.setId,
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
      builder: (context, __) {
        final size = MediaQuery.of(context).size;
        final crossAxisCount = size.width < size.height ? 3 : 6;
        return CardsGrid(
          crossAxisCount: crossAxisCount,
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
                  setId: widget.setId,
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
