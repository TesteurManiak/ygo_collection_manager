import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/consts/my_edge_insets.dart';
import '../../../domain/entities/ygo_card.dart';
import '../../blocs/expansion_collection/expansion_collection_bloc.dart';
import '../../constants/colors.dart';

class CardEditingWidget extends StatelessWidget {
  final int index;
  final List<YgoCard> cards;
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
          padding: MyEdgeInsets.all2,
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
