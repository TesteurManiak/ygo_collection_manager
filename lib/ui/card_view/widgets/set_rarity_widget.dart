import 'package:flutter/material.dart';
import 'package:ygo_collection_manager/models/card_info_model.dart';
import 'package:ygo_collection_manager/styles/colors.dart';
import 'package:ygo_collection_manager/styles/text_styles.dart';

class SetRarityWidget extends StatelessWidget {
  final CardModelSet cardSet;

  const SetRarityWidget({
    Key? key,
    required this.cardSet,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO(maniak): add widget to change quantity
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(cardSet.name, style: const TextStyle(color: MyColors.yellow)),
        const SizedBox(height: 16),
        Text(
          cardSet.rarity,
          style: TextStyles.font18w500,
        ),
      ],
    );
  }
}
