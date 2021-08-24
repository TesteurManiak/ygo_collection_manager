import 'package:flutter/material.dart';
import 'package:ygo_collection_manager/models/card_info_model.dart';
import 'package:ygo_collection_manager/styles/colors.dart';

class CardBottomSheet extends StatelessWidget {
  final CardInfoModel card;
  final ScrollController controller;

  const CardBottomSheet(
    this.card,
    this.controller,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: DynamicThemedColors.scaffoldBackground(context),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(25),
        controller: controller,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(card.type),
                Text('ID: ${card.id}'),
              ],
            ),
            const SizedBox(height: 12),
            Text(card.name),
            const SizedBox(height: 6),
            Text(card.desc),
          ],
        ),
      ),
    );
  }
}
