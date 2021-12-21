import 'package:flutter/material.dart';

import 'card_id.dart';
import 'card_type.dart';

class CardTypeAndId extends StatelessWidget {
  final String type;
  final int id;

  const CardTypeAndId({
    Key? key,
    required this.type,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CardType(type: type),
        const Spacer(),
        CardId(id: id),
      ],
    );
  }
}
