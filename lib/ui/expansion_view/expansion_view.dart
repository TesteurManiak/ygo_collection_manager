import 'package:flutter/material.dart';
import 'package:ygo_collection_manager/blocs/bloc_provider.dart';
import 'package:ygo_collection_manager/blocs/cards_bloc.dart';
import 'package:ygo_collection_manager/blocs/expansion_collection_bloc.dart';
import 'package:ygo_collection_manager/models/card_info_model.dart';
import 'package:ygo_collection_manager/models/set_model.dart';
import 'package:ygo_collection_manager/styles/colors.dart';
import 'package:ygo_collection_manager/ui/common/card_widget.dart';
import 'package:ygo_collection_manager/ui/common/no_glow_scroll_behavior.dart';
import 'package:ygo_collection_manager/ui/common/total_completion_widget.dart';
import 'package:ygo_collection_manager/ui/expansion_view/widgets/card_editing_widget.dart';
import 'package:ygo_collection_manager/ui/expansion_view/widgets/cards_grid.dart';

class ExpansionView extends StatefulWidget {
  static const routeName = '/expansion';

  final SetModel cardSet;

  const ExpansionView(this.cardSet);

  @override
  State<StatefulWidget> createState() => _ExpansionViewState();
}

class _ExpansionViewState extends State<ExpansionView> {
  late final _expansionCollectionBloc =
      BlocProvider.of<ExpansionCollectionBloc>(context);
  late final CardsBloc _cardsBloc = BlocProvider.of<CardsBloc>(context);
  late final _cards = _cardsBloc.getCardsInSet(widget.cardSet)!;

  Future<bool> _onWillPop() async {
    if (_cardsBloc.isOverlayOpen) {
      _cardsBloc.closeOverlay();
      return false;
    }
    return true;
  }

  @override
  void initState() {
    super.initState();
    _cardsBloc.initOverlayState(context);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: StreamBuilder<String?>(
            stream: _expansionCollectionBloc.onTitleChanged,
            builder: (_, snapshot) {
              final data = snapshot.data;
              String title = widget.cardSet.setName;
              if (snapshot.hasData && data != null) title = data;
              return Text(title);
            },
          ),
          bottom: const TotalCompletionWidget(0.0),
        ),
        body: Container(
          margin: const EdgeInsets.only(top: 16),
          decoration: BoxDecoration(
            color: DynamicThemedColors.scaffoldBackground(context),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: ScrollConfiguration(
            behavior: NoGlowScrollBehavior(),
            child: StreamBuilder<bool>(
              stream: _expansionCollectionBloc.onEditionStateChanged,
              initialData: _expansionCollectionBloc.isEditing,
              builder: (context, snapshot) {
                final isEditing = snapshot.data!;
                return _CollectionLayout(cards: _cards, isEditing: isEditing);
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _CollectionLayout extends StatefulWidget {
  final List<CardInfoModel> cards;
  final bool isEditing;

  const _CollectionLayout({
    required this.cards,
    required this.isEditing,
  });

  @override
  State<StatefulWidget> createState() => _CollectionLayoutState();
}

class _CollectionLayoutState extends State<_CollectionLayout>
    with TickerProviderStateMixin {
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
                    enableLongPress: true,
                    tickerProvider: this,
                  )
                : CardEditingWidget(
                    index: index,
                    cards: widget.cards,
                  ),
          );
        });
  }
}
