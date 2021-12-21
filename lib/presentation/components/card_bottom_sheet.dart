import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/consts/consts.dart';
import '../../core/consts/my_edge_insets.dart';
import '../../data/datasources/local/ygopro_local_datasource.dart';
import '../../domain/entities/card_price.dart';
import '../../domain/entities/ygo_card.dart';
import '../../service_locator.dart';
import '../card_view/card_view.dart';
import '../constants/colors.dart';
import 'atoms/card_description.dart';
import 'molecules/card_detail_widget.dart';
import 'no_glow_scroll_behavior.dart';
import 'organisms/card_name_and_level.dart';
import 'organisms/card_stats.dart';
import 'organisms/card_type_and_id.dart';

class CardBottomSheet extends StatefulWidget {
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
    final miscInfo = widget.card.miscInfo;
    final atk = widget.card.atk;
    final def = widget.card.def;

    return Container(
      decoration: BoxDecoration(
        color: DynamicThemedColors.bottomSheetBackground(context),
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(Consts.px20),
        ),
      ),
      child: ScrollConfiguration(
        behavior: const NoGlowScrollBehavior(),
        child: SingleChildScrollView(
          padding: MyEdgeInsets.all25,
          controller: widget.controller,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CardTypeAndId(type: widget.card.type, id: widget.card.id),
              const SizedBox(height: Consts.px14),
              CardNameAndLevel(
                name: widget.card.name,
                level: widget.card.level,
                levelAsset: widget.card.levelAsset,
              ),
              CardDescription(desc: widget.card.desc),
              if (atk != null || def != null) CardStats(atk: atk, def: def),
              Row(
                children: [
                  CardDetailWidget.assetImage(
                    label: 'Race',
                    value: widget.card.race,
                    asset: 'assets/race/${widget.card.race}.png',
                  ),
                  if (widget.card.attribute != null)
                    const SizedBox(
                      width: Consts.px32,
                    ),
                  if (widget.card.attribute != null)
                    CardDetailWidget.assetImage(
                      label: 'Attribute',
                      value: widget.card.attribute!,
                      asset: 'assets/attribute/${widget.card.attribute!}.png',
                    ),
                ],
              ),
              const SizedBox(height: Consts.px16),
              Row(
                children: [
                  if (widget.card.archetype != null)
                    CardDetailWidget(
                      label: 'Archetype',
                      value: widget.card.archetype!,
                    ),
                  if (widget.card.archetype != null)
                    const SizedBox(
                      width: Consts.px32,
                    ),
                  if (miscInfo != null)
                    Expanded(
                      child: CardDetailWidget(
                        label: 'Formats',
                        value: miscInfo
                            .map<List<String>>((e) => e.formats)
                            .reduce((a, b) => [...a, ...b])
                            .toSet()
                            .join(', '),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: Consts.px28),
              Row(
                children: [
                  ValueListenableBuilder<int>(
                    valueListenable: _totalOwnedCard,
                    builder: (_, value, __) => Text('$value in Collection'),
                  ),
                  const Spacer(),
                  TextButton(
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(Consts.px20),
                      ),
                    ),
                    onPressed: () {
                      final _setId = widget.setId;
                      context.goNamed(
                        _setId != null
                            ? CardView.routeName
                            : CardView.altRouteName,
                        params: CardView.routeParams(
                          card: widget.card,
                          setId: widget.setId,
                        ),
                      );
                    },
                    child: const Text(
                      'VIEW',
                      style: TextStyle(color: MyColors.yellow),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: Consts.px28),
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
