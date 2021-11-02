import 'package:flutter/material.dart';

import '../../../features/browse_cards/domain/entities/ygo_card.dart';
import '../../common/no_glow_scroll_behavior.dart';

const _kDefaultCrossAxisCount = 3;

typedef CardBuilder = Widget Function(BuildContext, int);

class CardsGrid extends StatelessWidget {
  final List<YgoCard> cards;
  final int crossAxisCount;
  final CardBuilder cardBuilder;

  const CardsGrid({
    Key? key,
    required this.cards,
    this.crossAxisCount = _kDefaultCrossAxisCount,
    required this.cardBuilder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final itemWidth = size.width / crossAxisCount;
    final itemHeight = itemWidth * 1.47;

    return ScrollConfiguration(
      behavior: NoGlowScrollBehavior(),
      child: GridView.builder(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(16),
        itemCount: cards.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          childAspectRatio: itemWidth / itemHeight,
        ),
        itemBuilder: cardBuilder,
      ),
    );
  }
}
