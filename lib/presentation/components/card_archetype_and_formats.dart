import 'package:flutter/material.dart';

import '../../core/consts/consts.dart';
import '../../domain/entities/card_misc_info.dart';
import 'card_detail_widget.dart';

class CardArchetypeAndFormats extends StatelessWidget {
  final String? archetype;
  final List<CardMiscInfo>? miscInfos;

  const CardArchetypeAndFormats({
    Key? key,
    required this.archetype,
    required this.miscInfos,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _archetype = archetype;
    final _miscInfos = miscInfos;
    return Padding(
      padding: const EdgeInsets.only(bottom: Consts.px28),
      child: Row(
        children: [
          if (_archetype != null)
            Padding(
              padding: const EdgeInsets.only(bottom: Consts.px32),
              child: CardDetailWidget(
                label: 'Archetype',
                value: _archetype,
              ),
            ),
          if (_miscInfos != null)
            Expanded(
              child: CardDetailWidget(
                label: 'Formats',
                value: _miscInfos
                    .map<List<String>>((e) => e.formats)
                    .reduce((a, b) => [...a, ...b])
                    .toSet()
                    .join(', '),
              ),
            ),
        ],
      ),
    );
  }
}
