import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ygo_collection_manager/models/card_info_model.dart';
import 'package:ygo_collection_manager/styles/colors.dart';

class CardWidget extends StatelessWidget {
  final CardInfoModel card;

  const CardWidget(this.card);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: DynamicThemedColors.scaffoldBackground(context),
      padding: const EdgeInsets.all(2),
      child: CachedNetworkImage(
        imageUrl: card.cardImages.first.imageUrlSmall,
        placeholder: (_, __) => const CircularProgressIndicator(),
        fit: BoxFit.fitHeight,
      ),
    );
  }
}
