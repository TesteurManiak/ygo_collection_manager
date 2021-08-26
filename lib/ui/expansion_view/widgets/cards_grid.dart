import 'package:flutter/material.dart';
import 'package:ygo_collection_manager/models/card_info_model.dart';

const _defaultCrossAxisCount = 3;

typedef CardBuilder = Widget Function(BuildContext, int);

class CardsGrid extends StatelessWidget {
  final List<CardInfoModel> cards;
  final int crossAxisCount;
  final CardBuilder cardBuilder;

  const CardsGrid({
    required this.cards,
    this.crossAxisCount = _defaultCrossAxisCount,
    required this.cardBuilder,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final itemWidth = size.width / crossAxisCount;
    final itemHeight = itemWidth * 1.47;

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: cards.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        childAspectRatio: itemWidth / itemHeight,
      ),
      itemBuilder: cardBuilder,
    );
  }
}
