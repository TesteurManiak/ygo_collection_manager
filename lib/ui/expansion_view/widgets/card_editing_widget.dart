import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ygo_collection_manager/core/bloc/bloc_provider.dart';
import 'package:ygo_collection_manager/blocs/expansion_collection_bloc.dart';
import 'package:ygo_collection_manager/models/card_info_model.dart';
import 'package:ygo_collection_manager/styles/colors.dart';

class CardEditingWidget extends StatelessWidget {
  final int index;
  final List<CardInfoModel> cards;
  final AnimationController controller;

  const CardEditingWidget({
    Key? key,
    required this.index,
    required this.cards,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final expansionCollectionBloc =
        BlocProvider.of<ExpansionCollectionBloc>(context);
    final isSelected = index == expansionCollectionBloc.selectedCardIndex;

    return Opacity(
      opacity: isSelected ? 1 : 0.3,
      child: InkWell(
        onTap: () => isSelected
            ? expansionCollectionBloc.disableEditing(controller)
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
