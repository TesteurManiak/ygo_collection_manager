import 'package:flutter/material.dart';
import 'package:ygo_collection_manager/models/card_info_model.dart';
import 'package:ygo_collection_manager/styles/colors.dart';
import 'package:ygo_collection_manager/styles/text_styles.dart';

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
        color: DynamicThemedColors.bottomSheetBackground(context),
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
                Text(
                  card.type,
                  style: const TextStyle(fontSize: 16),
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      const TextSpan(
                        text: 'ID: ',
                        style: TextStyles.grey14,
                      ),
                      TextSpan(
                        text: card.id.toString(),
                        style: TextStyles.white14,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                Expanded(child: Text(card.name, style: TextStyles.font20)),
                if (card.level != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Image.asset(card.levelAsset, height: 20),
                  ),
                if (card.level != null)
                  Text(card.level.toString(), style: TextStyles.font20),
              ],
            ),
            const SizedBox(height: 6),
            Text(card.desc, style: TextStyles.grey14),
          ],
        ),
      ),
    );
  }
}
