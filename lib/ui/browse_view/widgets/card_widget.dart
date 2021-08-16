import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ygo_collection_manager/models/card_info_model.dart';

class CardWidget extends StatelessWidget {
  final CardInfoModel card;

  const CardWidget(this.card);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: card.cardImages.first.imageUrlSmall,
      placeholder: (_, __) => const CircularProgressIndicator(),
    );
  }
}
