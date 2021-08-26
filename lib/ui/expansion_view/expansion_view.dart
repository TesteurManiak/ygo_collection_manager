import 'package:flutter/material.dart';
import 'package:ygo_collection_manager/blocs/bloc_provider.dart';
import 'package:ygo_collection_manager/blocs/cards_bloc.dart';
import 'package:ygo_collection_manager/blocs/expansion_collection_bloc.dart';
import 'package:ygo_collection_manager/models/set_model.dart';
import 'package:ygo_collection_manager/styles/colors.dart';
import 'package:ygo_collection_manager/ui/common/card_widget.dart';
import 'package:ygo_collection_manager/ui/common/no_glow_scroll_behavior.dart';
import 'package:ygo_collection_manager/ui/common/total_completion_widget.dart';

const _crossAxisCount = 3;

class ExpansionView extends StatefulWidget {
  static const routeName = '/expansion';

  final SetModel cardSet;

  const ExpansionView(this.cardSet);

  @override
  State<StatefulWidget> createState() => _ExpansionViewState();
}

class _ExpansionViewState extends State<ExpansionView>
    with TickerProviderStateMixin {
  late final _expansionCollectionBloc =
      BlocProvider.of<ExpansionCollectionBloc>(context);
  late final CardsBloc _cardsBloc = BlocProvider.of<CardsBloc>(context);
  late final _cards = _cardsBloc.getCardsInSet(widget.cardSet);

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
    final size = MediaQuery.of(context).size;
    final itemWidth = size.width / _crossAxisCount;
    final itemHeight = itemWidth * 1.47;

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
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _cards.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: _crossAxisCount,
                childAspectRatio: itemWidth / itemHeight,
              ),
              itemBuilder: (_, index) => CardWidget(
                cards: _cards,
                index: index,
                enableLongPress: true,
                tickerProvider: this,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
