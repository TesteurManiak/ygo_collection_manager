import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ygo_collection_manager/blocs/bloc_provider.dart';
import 'package:ygo_collection_manager/blocs/cards_bloc.dart';
import 'package:ygo_collection_manager/models/card_info_model.dart';
import 'package:ygo_collection_manager/styles/colors.dart';

class CardWidget extends StatefulWidget {
  final int index;
  final List<CardInfoModel> cards;

  const CardWidget({
    required this.cards,
    required this.index,
  });

  @override
  State<StatefulWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  late final _cardsBloc = BlocProvider.of<CardsBloc>(context);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _cardsBloc.openOverlay(
        initialIndex: widget.index,
        cards: widget.cards,
      ),
      child: Container(
        color: DynamicThemedColors.scaffoldBackground(context),
        padding: const EdgeInsets.all(2),
        child: CachedNetworkImage(
          imageUrl: widget.cards[widget.index].cardImages.first.imageUrlSmall,
          placeholder: (_, __) => Image.asset(
            'assets/back_high.jpg',
            fit: BoxFit.fill,
          ),
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
