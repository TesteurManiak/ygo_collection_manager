import 'package:flutter/material.dart';

import '../../data/datasources/local/ygopro_local_datasource.dart';
import '../../domain/entities/card_price.dart';
import '../../domain/entities/ygo_card.dart';
import '../../service_locator.dart';
import '../styles/colors.dart';
import '../styles/text_styles.dart';
import '../card_view/card_view.dart';
import 'card_detail_widget.dart';
import 'no_glow_scroll_behavior.dart';

class CardBottomSheet extends StatefulWidget {
  final YgoCard card;
  final ScrollController controller;

  const CardBottomSheet({
    Key? key,
    required this.card,
    required this.controller,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CardBottomSheetState();
}

class _CardBottomSheetState extends State<CardBottomSheet> {
  late final _totalOwnedCard = ValueNotifier<int>(0);

  @override
  void initState() {
    super.initState();
    sl<YgoProLocalDataSource>()
        .getCopiesOfCardOwnedById(widget.card.id)
        .then((value) {
      _totalOwnedCard.value = value;
    });
  }

  @override
  void dispose() {
    _totalOwnedCard.dispose();
    super.dispose();
  }

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
          controller: widget.controller,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Image.asset(
                    'assets/type/${widget.card.type}.jpg',
                    height: 20,
                    errorBuilder: (_, __, ___) => const SizedBox(),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    widget.card.type,
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
                          text: widget.card.id.toString(),
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
                  Expanded(
                    child: Text(widget.card.name, style: TextStyles.font20),
                  ),
                  if (widget.card.level != null)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Image.asset(widget.card.levelAsset, height: 20),
                    ),
                  if (widget.card.level != null)
                    Text(
                      widget.card.level.toString(),
                      style: TextStyles.font20,
                    ),
                ],
              ),
              const SizedBox(height: 6),
              Text(widget.card.desc, style: TextStyles.grey14),
              const SizedBox(height: 28),
              Row(
                children: [
                  if (widget.card.atk != null)
                    CardDetailWidget(
                      label: 'Atk',
                      value: widget.card.atk.toString(),
                    ),
                  if (widget.card.def != null) const SizedBox(width: 32),
                  if (widget.card.def != null)
                    CardDetailWidget(
                      label: 'Def',
                      value: widget.card.def.toString(),
                    ),
                ],
              ),
              if (widget.card.atk != null || widget.card.def != null)
                const SizedBox(height: 16),
              Row(
                children: [
                  CardDetailWidget.assetImage(
                    label: 'Race',
                    value: widget.card.race,
                    asset: 'assets/race/${widget.card.race}.png',
                  ),
                  if (widget.card.attribute != null) const SizedBox(width: 32),
                  if (widget.card.attribute != null)
                    CardDetailWidget.assetImage(
                      label: 'Attribute',
                      value: widget.card.attribute!,
                      asset: 'assets/attribute/${widget.card.attribute!}.png',
                    ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  if (widget.card.archetype != null)
                    CardDetailWidget(
                      label: 'Archetype',
                      value: widget.card.archetype!,
                    ),
                  if (widget.card.archetype != null) const SizedBox(width: 32),
                  Expanded(
                    child: CardDetailWidget(
                      label: 'Formats',
                      value: widget.card.miscInfo
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
                  ValueListenableBuilder<int>(
                    valueListenable: _totalOwnedCard,
                    builder: (_, value, __) => Text('$value in Collection'),
                  ),
                  Expanded(child: Container()),
                  TextButton(
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () => Navigator.pushNamed(
                      context,
                      CardView.routeName,
                      arguments: [widget.card, _totalOwnedCard],
                    ),
                    child: const Text(
                      'VIEW',
                      style: TextStyle(color: MyColors.yellow),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 28),
              _PricesWidget(prices: widget.card.cardPrices),
            ],
          ),
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
