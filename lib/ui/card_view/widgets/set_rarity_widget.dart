import 'package:flutter/material.dart';

import '../../../domain/entities/card_set.dart';
import '../../../styles/colors.dart';
import '../../../styles/text_styles.dart';

class SetRarityWidget extends StatelessWidget {
  final CardSet cardSet;

  const SetRarityWidget({
    Key? key,
    required this.cardSet,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: add widget to change quantity
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
