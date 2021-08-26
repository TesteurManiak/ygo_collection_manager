import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ygo_collection_manager/blocs/bloc_provider.dart';
import 'package:ygo_collection_manager/blocs/cards_bloc.dart';
import 'package:ygo_collection_manager/blocs/expansion_collection_bloc.dart';
import 'package:ygo_collection_manager/models/card_info_model.dart';
import 'package:ygo_collection_manager/styles/colors.dart';

class CardWidget extends StatelessWidget {
  final int index;
  final List<CardInfoModel> cards;
  final bool enableLongPress;

  const CardWidget({
    required this.cards,
    required this.index,
    this.enableLongPress = false,
  });

  @override
  Widget build(BuildContext context) {
    final _cardsBloc = BlocProvider.of<CardsBloc>(context);
    final _expansionCollectionBloc =
        BlocProvider.of<ExpansionCollectionBloc>(context);
    return Stack(
      children: [
        Positioned.fill(
          child: Container(
            color: DynamicThemedColors.scaffoldBackground(context),
            padding: const EdgeInsets.all(2),
            child: CachedNetworkImage(
              imageUrl: cards[index].cardImages.first.imageUrlSmall,
              placeholder: (_, __) => Image.asset(
                'assets/back_high.jpg',
                fit: BoxFit.fill,
              ),
              fit: BoxFit.fill,
            ),
          ),
        ),
        Positioned.fill(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => _cardsBloc.openOverlay(
                initialIndex: index,
                cards: cards,
              ),
              onLongPress:
                  enableLongPress ? _expansionCollectionBloc.switchMode : null,
            ),
          ),
        ),
      ],
    );
  }
}
