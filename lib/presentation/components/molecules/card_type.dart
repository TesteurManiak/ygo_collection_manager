import 'package:flutter/material.dart';

import '../../../core/consts/consts.dart';
import '../../constants/text_styles.dart';
import '../atoms/card_type_asset.dart';

class CardType extends StatelessWidget {
  final String type;

  const CardType({Key? key, required this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CardTypeAsset(type: type),
        const SizedBox(width: Consts.px8),
        Text(type, style: TextStyles.font16),
      ],
    );
  }
}
