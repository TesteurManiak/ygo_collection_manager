import 'package:flutter/material.dart';

import '../styles/text_styles.dart';

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
          height: 20,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyles.grey14),
        const SizedBox(height: 4),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (leading != null)
              Padding(
                padding: const EdgeInsets.only(right: 4),
                child: leading,
              ),
            Flexible(child: Text(value, maxLines: 2)),
          ],
        ),
      ],
    );
  }
}
