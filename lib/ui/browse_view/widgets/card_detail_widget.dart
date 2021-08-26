import 'package:flutter/material.dart';
import 'package:ygo_collection_manager/styles/text_styles.dart';

class CardDetailWidget extends StatelessWidget {
  final String label;
  final String value;
  final Widget? leading;

  const CardDetailWidget({
    required this.label,
    required this.value,
    this.leading,
  });

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
            if (leading != null) leading!,
            Flexible(child: Text(value, maxLines: 2)),
          ],
        ),
      ],
    );
  }
}
