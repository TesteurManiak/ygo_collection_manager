import 'package:flutter/material.dart';

import '../constants/text_styles.dart';
import 'card_level_asset.dart';

class CardLevel extends StatelessWidget {
  final int level;
  final String levelAsset;

  const CardLevel({
    Key? key,
    required this.level,
    required this.levelAsset,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CardLevelAsset(asset: levelAsset),
        Text(
          level.toString(),
          style: TextStyles.font20,
        ),
      ],
    );
  }
}
