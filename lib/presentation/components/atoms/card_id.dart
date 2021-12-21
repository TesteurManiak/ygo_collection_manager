import 'package:flutter/material.dart';

import '../../constants/text_styles.dart';

class CardId extends StatelessWidget {
  final int id;

  const CardId({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          const TextSpan(
            text: 'ID: ',
            style: TextStyles.grey14,
          ),
          TextSpan(
            text: id.toString(),
            style: DynamicTextStyles.cardId(context),
          ),
        ],
      ),
    );
  }
}
