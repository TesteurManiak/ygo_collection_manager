import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../core/consts/my_edge_insets.dart';
import '../../domain/entities/ygo_card.dart';
import '../../router.dart';
import '../blocs/cards/cards_bloc.dart';
import '../components/rounded_scaffold_box.dart';
import 'widgets/set_rarity_widget.dart';

class CardView extends StatelessWidget {
  static const routeName = 'details';
  static const altRouteName = 'alt-details';

  static Map<String, String> routeParams({
    required YgoCard card,
    required String? setId,
  }) =>
      {
        if (setId != null) RouteParams.setCode: setId,
        RouteParams.cardId: '${card.id}',
      };

  final String cardId;

  const CardView({Key? key, required this.cardId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final card = BlocProvider.of<CardsBloc>(context).findCardFromParam(cardId);
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
      body: RoundedScaffoldBox(
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
