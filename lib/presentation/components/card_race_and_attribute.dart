import 'package:flutter/material.dart';

import '../../core/consts/consts.dart';
import 'card_detail_widget.dart';

class CardRaceAndAttribute extends StatelessWidget {
  final String race;
  final String? attribute;

  const CardRaceAndAttribute({
    Key? key,
    required this.race,
    required this.attribute,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _attribute = attribute;
    return Padding(
      padding: const EdgeInsets.only(bottom: Consts.px16),
      child: Row(
        children: [
          CardDetailWidget.assetImage(
            label: 'Race',
            value: race,
            asset: 'assets/race/$race.png',
          ),
          if (_attribute != null)
            Padding(
              padding: const EdgeInsets.only(top: Consts.px32),
              child: CardDetailWidget.assetImage(
                label: 'Attribute',
                value: _attribute,
                asset: 'assets/attribute/$_attribute.png',
              ),
            ),
        ],
      ),
    );
  }
}
