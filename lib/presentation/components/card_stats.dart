import 'package:flutter/material.dart';

import '../../core/consts/consts.dart';
import 'card_detail_widget.dart';

class CardStats extends StatelessWidget {
  final int? atk;
  final int? def;

  const CardStats({
    Key? key,
    required this.atk,
    required this.def,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: Consts.px16),
      child: Row(
        children: [
          if (atk != null)
            CardDetailWidget(
              label: 'Atk',
              value: atk.toString(),
            ),
          if (def != null) ...[
            const SizedBox(width: Consts.px32),
            CardDetailWidget(
              label: 'Def',
              value: def.toString(),
            ),
          ],
        ],
      ),
    );
  }
}
