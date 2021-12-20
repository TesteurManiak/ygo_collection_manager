import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/consts/consts.dart';
import '../../core/consts/my_edge_insets.dart';
import '../../core/styles/colors.dart';
import '../../domain/entities/ygo_card.dart';
import '../expansion_view/expansion_view.dart';
import 'widgets/set_rarity_widget.dart';

class CardView extends StatelessWidget {
  static const routeName = 'details';
  static const altRouteName = 'alt-details';

  static const routeParam = 'cardId';

  static const routePath = '$routeName/:$routeParam';
  static const altRoutePath = '$altRouteName/:$routeParam';

  static Map<String, String> routeParams({
    required YgoCard card,
    required String? setId,
  }) =>
      {
        if (setId != null) ExpansionView.routeParam: setId,
        routeParam: '${card.id}',
      };

  final YgoCard card;

  const CardView({Key? key, required this.card}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sets = card.cardSets;
    return Scaffold(
      appBar: AppBar(
        title: Text(card.name),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: context.pop,
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: DynamicThemedColors.scaffoldBackground(context),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(Consts.px20),
            topRight: Radius.circular(Consts.px20),
          ),
        ),
        child: ListView.separated(
          padding: MyEdgeInsets.all16,
          itemBuilder: (_, index) => SetRarityWidget(cardSet: sets![index]),
          itemCount: sets?.length ?? 0,
          separatorBuilder: (_, __) => const Divider(),
        ),
      ),
    );
  }
}
