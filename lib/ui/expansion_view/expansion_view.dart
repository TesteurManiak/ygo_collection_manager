import 'package:flutter/material.dart';
import 'package:ygo_collection_manager/blocs/bloc_provider.dart';
import 'package:ygo_collection_manager/blocs/cards_bloc.dart';
import 'package:ygo_collection_manager/models/set_model.dart';
import 'package:ygo_collection_manager/styles/colors.dart';
import 'package:ygo_collection_manager/ui/common/card_widget.dart';

const _crossAxisCount = 3;

class ExpansionView extends StatefulWidget {
  static const routeName = '/expansion';

  final SetModel cardSet;

  const ExpansionView(this.cardSet);

  @override
  State<StatefulWidget> createState() => _ExpansionViewState();
}

class _ExpansionViewState extends State<ExpansionView> {
  late final CardsBloc _cardsBloc = BlocProvider.of<CardsBloc>(context);
  late final _cards = _cardsBloc.cards!
      .where(
        (e) =>
            e.cardset != null &&
            e.cardset!
                .map<String>((e) => e.name)
                .toSet()
                .contains(widget.cardSet.setName),
      )
      .toList();

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

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.cardSet.setName),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: DynamicThemedColors.scaffoldBackground(context),
          borderRadius: BorderRadius.circular(20),
        ),
        child: GridView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: _cards.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: _crossAxisCount,
            childAspectRatio: itemWidth / itemHeight,
          ),
          itemBuilder: (_, index) => CardWidget(cards: _cards, index: index),
        ),
      ),
    );
  }
}
