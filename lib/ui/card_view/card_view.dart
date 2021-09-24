import 'package:flutter/material.dart';

import 'package:ygo_collection_manager/models/card_info_model.dart';
import 'package:ygo_collection_manager/styles/colors.dart';
import 'package:ygo_collection_manager/ui/card_view/widgets/set_rarity_widget.dart';

class CardView extends StatelessWidget {
  static const routeName = '/card-view-overlay';

  final CardInfoModel card;

  const CardView({Key? key, required this.card}) : super(key: key);

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
