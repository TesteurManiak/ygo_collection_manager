import 'package:flutter/material.dart';

import '../../../core/consts/consts.dart';
import '../../../core/consts/my_edge_insets.dart';
import '../../constants/text_styles.dart';

class CardDetailWidget extends StatelessWidget {
  final String label;
  final String value;
  final Widget? leading;

  const CardDetailWidget({
    Key? key,
    required this.label,
    required this.value,
    this.leading,
  }) : super(key: key);

  factory CardDetailWidget.assetImage({
    required String label,
    required String value,
    required String asset,
  }) =>
      CardDetailWidget(
        label: label,
        value: value,
        leading: Image.asset(
          asset,
          errorBuilder: (_, error, ___) => const SizedBox(),
          height: Consts.px20,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyles.grey14),
        const SizedBox(height: Consts.px4),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (leading != null)
              Padding(
                padding: MyEdgeInsets.onlyR4,
                child: leading,
              ),
            Flexible(child: Text(value, maxLines: 2)),
          ],
        ),
      ],
    );
  }
}
