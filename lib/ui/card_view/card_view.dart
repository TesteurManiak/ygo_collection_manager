import 'package:flutter/material.dart';

import '../../features/browse_cards/domain/entities/ygo_card.dart';
import '../../styles/colors.dart';
import 'widgets/set_rarity_widget.dart';

class CardView extends StatelessWidget {
  static const routeName = '/card-view-overlay';

  final YgoCard card;
  final ValueNotifier<int> totalOwnedCard;

  const CardView({
    Key? key,
    required this.card,
    required this.totalOwnedCard,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sets = card.cardSets;
    return Scaffold(
      appBar: AppBar(
        title: Text(card.name),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: DynamicThemedColors.scaffoldBackground(context),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: ListView.separated(
          padding: const EdgeInsets.all(16),
          itemBuilder: (_, index) => SetRarityWidget(cardSet: sets![index]),
          itemCount: sets?.length ?? 0,
          separatorBuilder: (_, __) => const Divider(),
        ),
      ),
    );
  }
}
