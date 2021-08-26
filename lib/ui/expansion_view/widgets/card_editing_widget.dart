import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ygo_collection_manager/blocs/bloc_provider.dart';
import 'package:ygo_collection_manager/blocs/expansion_collection_bloc.dart';
import 'package:ygo_collection_manager/models/card_info_model.dart';
import 'package:ygo_collection_manager/styles/colors.dart';

class CardEditingWidget extends StatelessWidget {
  final int index;
  final List<CardInfoModel> cards;

  const CardEditingWidget({required this.index, required this.cards});

  @override
  Widget build(BuildContext context) {
    final expansionCollectionBloc =
        BlocProvider.of<ExpansionCollectionBloc>(context);
    final isSelected = index == expansionCollectionBloc.selectedCardIndex;

    return Opacity(
      opacity: isSelected ? 1 : 0.5,
      child: InkWell(
        onTap: () => isSelected
            ? expansionCollectionBloc.switchMode(
                cardIndex: index,
                cards: cards,
              )
            : expansionCollectionBloc.selectCard(index),
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
    );
  }
}
