import 'package:flutter/material.dart';

import '../../core/consts/consts.dart';
import '../../core/consts/my_edge_insets.dart';
import '../../domain/entities/card_price.dart';
import '../../domain/entities/ygo_card.dart';
import '../constants/colors.dart';
import 'card_archetype_and_formats.dart';
import 'card_description.dart';
import 'card_name_and_level.dart';
import 'card_race_and_attribute.dart';
import 'card_stats.dart';
import 'card_type_and_id.dart';
import 'card_view_button.dart';
import 'no_glow_single_child_scroll_view.dart';
import 'total_card_in_collection.dart';

class CardBottomSheet extends StatelessWidget {
  final YgoCard card;
  final ScrollController controller;
  final String? setId;

  const CardBottomSheet({
    Key? key,
    required this.card,
    required this.controller,
    this.setId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final atk = card.atk;
    final def = card.def;

    return Container(
      decoration: BoxDecoration(
        color: DynamicThemedColors.bottomSheetBackground(context),
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(Consts.px20),
        ),
      ),
      child: NoGlowSingleChildScrollView(
        padding: MyEdgeInsets.all25,
        controller: controller,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CardTypeAndId(type: card.type, id: card.id),
            const SizedBox(height: Consts.px14),
            CardNameAndLevel(
              name: card.name,
              level: card.level,
              levelAsset: card.levelAsset,
            ),
            CardDescription(desc: card.desc),
            if (atk != null || def != null) CardStats(atk: atk, def: def),
            CardRaceAndAttribute(
              race: card.race,
              attribute: card.attribute,
            ),
            CardArchetypeAndFormats(
              archetype: card.archetype,
              miscInfos: card.miscInfo,
            ),
            Row(
              children: [
                TotalCardInCollection(cardId: card.id),
                const Spacer(),
                CardViewButton(setId: setId, card: card),
              ],
            ),
            const SizedBox(height: Consts.px28),
            _PricesWidget(prices: card.cardPrices),
          ],
        ),
      ),
    );
  }
}

class _PricesWidget extends StatelessWidget {
  final List<CardPrice> prices;

  const _PricesWidget({required this.prices});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Consts.px12),
        border: Border.all(
          color: MyColors.yellow2,
          width: Consts.px3,
        ),
      ),
      child: Column(
        children: [
          _PriceLine(
            label: 'CARDMARKET',
            values: prices.map((e) => '${e.cardmarket}€').toList(),
          ),
          _PriceLine(
            label: 'TCGPLAYER',
            values: prices.map((e) => '\$${e.tcgplayer}').toList(),
          ),
          _PriceLine(
            label: 'EBAY',
            values: prices.map((e) => '\$${e.ebay}').toList(),
          ),
          _PriceLine(
            label: 'AMAZON',
            values: prices.map((e) => '\$${e.amazon}').toList(),
          ),
          _PriceLine(
            label: 'COOLSTUFFINC',
            values: prices.map((e) => '\$${e.coolstuffinc}').toList(),
            hasBorder: false,
          ),
        ],
      ),
    );
  }
}

class _PriceLine extends StatelessWidget {
  final String label;
  final List<String> values;
  final bool hasBorder;

  const _PriceLine({
    required this.label,
    required this.values,
    this.hasBorder = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: hasBorder
            ? const Border(
                bottom: BorderSide(color: MyColors.yellow2, width: Consts.px3),
              )
            : null,
      ),
      padding: MyEdgeInsets.symH10V12,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: MyColors.yellow2)),
          Text(values.first),
        ],
      ),
    );
  }
}
