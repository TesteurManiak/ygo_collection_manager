import 'package:flutter/material.dart';
import 'package:ygo_collection_manager/core/bloc/bloc_provider.dart';
import 'package:ygo_collection_manager/blocs/cards_bloc.dart';
import 'package:ygo_collection_manager/models/set_model.dart';
import 'package:ygo_collection_manager/styles/colors.dart';
import 'package:ygo_collection_manager/ui/expansion_view/expansion_view.dart';

class SetTileWidget extends StatelessWidget {
  final SetModel cardSet;

  const SetTileWidget(this.cardSet, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cardsBloc = BlocProvider.of<CardsBloc>(context);
    final numOfCards =
        cardsBloc.getCardsInSet(cardSet)?.length ?? cardSet.numOfCards;
    final cardsOwned = cardsBloc.cardsOwnedInSet(cardSet);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            FocusScope.of(context).unfocus();
            Navigator.pushNamed<SetModel>(
              context,
              ExpansionView.routeName,
              arguments: cardSet,
            );
          },
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: DynamicThemedColors.cardSetBorder(context),
                width: 2,
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(cardSet.setName),
                      Text('$cardsOwned / $numOfCards'),
                    ],
                  ),
                ),
                Text(
                  '${(cardsOwned / numOfCards * 100).toStringAsFixed(0)}%',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
