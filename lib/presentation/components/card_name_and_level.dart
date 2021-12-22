import 'package:flutter/material.dart';

import '../constants/text_styles.dart';
import 'card_level.dart';

class CardNameAndLevel extends StatelessWidget {
  final String name;
  final int? level;
  final String levelAsset;

  const CardNameAndLevel({
    Key? key,
    required this.name,
    required this.level,
    required this.levelAsset,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _level = level;
    return Row(
      children: [
        Expanded(
          child: Text(name, style: TextStyles.font20),
        ),
        if (_level != null) CardLevel(level: _level, levelAsset: levelAsset),
      ],
    );
  }
}
