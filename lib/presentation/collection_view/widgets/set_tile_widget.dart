import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/bloc/bloc_provider.dart';
import '../../../core/consts/consts.dart';
import '../../../core/consts/my_edge_insets.dart';
import '../../../core/styles/colors.dart';
import '../../../domain/entities/ygo_set.dart';
import '../../blocs/cards_bloc.dart';
import '../../expansion_view/expansion_view.dart';

class SetTileWidget extends StatelessWidget {
  final YgoSet cardSet;

  const SetTileWidget(this.cardSet, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cardsBloc = BlocProvider.of<CardsBloc>(context);
    final numOfCards =
        cardsBloc.getCardsInSet(cardSet)?.length ?? cardSet.numOfCards;
    final cardsOwned = cardsBloc.cardsOwnedInSet(cardSet);
    return Padding(
      padding: MyEdgeInsets.symH16V8,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(Consts.px16),
          onTap: () {
            FocusScope.of(context).unfocus();
            context.goNamed(
              ExpansionView.routeName,
              params: ExpansionView.routeParams(cardSet),
            );
          },
          child: Container(
            padding: MyEdgeInsets.all16,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Consts.px16),
              border: Border.all(
                color: DynamicThemedColors.cardSetBorder(context),
                width: 2,
              ),
            ),
            child: FutureBuilder<int>(
              future: cardsOwned,
              builder: (_, snapshot) {
                final _cardsOwned = snapshot.hasData ? snapshot.data! : 0;
                final percentage = (_cardsOwned / numOfCards * 100);
                return Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(cardSet.setName),
                          Text('$_cardsOwned / $numOfCards'),
                        ],
                      ),
                    ),
                    Text(
                      '${percentage.toStringAsFixed(0)}%',
                      style: TextStyle(
                        color: DynamicThemedColors.cardSetBorder(context),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
