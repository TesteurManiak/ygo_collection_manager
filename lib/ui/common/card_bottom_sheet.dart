import 'package:flutter/material.dart';
import 'package:ygo_collection_manager/models/card_info_model.dart';
import 'package:ygo_collection_manager/styles/colors.dart';
import 'package:ygo_collection_manager/styles/text_styles.dart';
import 'package:ygo_collection_manager/ui/common/card_detail_widget.dart';
import 'package:ygo_collection_manager/ui/common/no_glow_scroll_behavior.dart';

class CardBottomSheet extends StatelessWidget {
  final CardInfoModel card;
  final ScrollController controller;

  const CardBottomSheet({required this.card, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: DynamicThemedColors.bottomSheetBackground(context),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: ScrollConfiguration(
        behavior: NoGlowScrollBehavior(),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(25),
          controller: controller,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Image.asset(
                    'assets/type/${card.type}.jpg',
                    height: 20,
                    errorBuilder: (_, __, ___) => const SizedBox(),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    card.type,
                    style: const TextStyle(fontSize: 16),
                  ),
                  Expanded(child: Container()),
                  RichText(
                    text: TextSpan(
                      children: [
                        const TextSpan(
                          text: 'ID: ',
                          style: TextStyles.grey14,
                        ),
                        TextSpan(
                          text: card.id.toString(),
                          style: DynamicTextStyles.cardId(context),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  Expanded(child: Text(card.name, style: TextStyles.font20)),
                  if (card.level != null)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Image.asset(card.levelAsset, height: 20),
                    ),
                  if (card.level != null)
                    Text(card.level.toString(), style: TextStyles.font20),
                ],
              ),
              const SizedBox(height: 6),
              Text(card.desc, style: TextStyles.grey14),
              const SizedBox(height: 28),
              Row(
                children: [
                  if (card.atk != null)
                    CardDetailWidget(
                      label: 'Atk',
                      value: card.atk.toString(),
                    ),
                  if (card.def != null) const SizedBox(width: 32),
                  if (card.def != null)
                    CardDetailWidget(
                      label: 'Def',
                      value: card.def.toString(),
                    ),
                ],
              ),
              if (card.atk != null || card.def != null)
                const SizedBox(height: 16),
              Row(
                children: [
                  CardDetailWidget.assetImage(
                    label: 'Race',
                    value: card.race,
                    asset: 'assets/race/${card.race}.png',
                  ),
                  if (card.attribute != null) const SizedBox(width: 32),
                  if (card.attribute != null)
                    CardDetailWidget.assetImage(
                      label: 'Attribute',
                      value: card.attribute!,
                      asset: 'assets/attribute/${card.attribute!}.png',
                    ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  if (card.archetype != null)
                    CardDetailWidget(
                      label: 'Archetype',
                      value: card.archetype!,
                    ),
                  if (card.archetype != null) const SizedBox(width: 32),
                  Expanded(
                    child: CardDetailWidget(
                      label: 'Formats',
                      value: card.miscInfo
                          .map<List<String>>((e) => e.formats)
                          .reduce((a, b) => [...a, ...b])
                          .toSet()
                          .join(', '),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 28),
              Row(
                children: [
                  const Text('0 in Collection'),
                  Expanded(child: Container()),
                  TextButton(
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () {},
                    child: const Text(
                      'VIEW',
                      style: TextStyle(color: MyColors.yellow),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 28),
              _PricesWidget(prices: card.cardPrices),
            ],
          ),
        ),
      ),
    );
  }
}

class _PricesWidget extends StatelessWidget {
  final List<CardPriceModel> prices;

  const _PricesWidget({required this.prices});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: MyColors.yellow2,
          width: 3,
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
                bottom: BorderSide(color: MyColors.yellow2, width: 3),
              )
            : null,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
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
