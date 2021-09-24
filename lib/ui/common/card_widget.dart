import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ygo_collection_manager/blocs/bloc_provider.dart';
import 'package:ygo_collection_manager/blocs/cards_bloc.dart';
import 'package:ygo_collection_manager/blocs/expansion_collection_bloc.dart';
import 'package:ygo_collection_manager/helper/hive_helper.dart';
import 'package:ygo_collection_manager/models/card_edition_enum.dart';
import 'package:ygo_collection_manager/models/card_info_model.dart';
import 'package:ygo_collection_manager/styles/colors.dart';
import 'package:ygo_collection_manager/styles/text_styles.dart';
import 'package:ygo_collection_manager/ui/common/cards_overlay.dart';

class CardWidget extends StatelessWidget {
  final int index;
  final List<CardInfoModel> cards;
  final void Function()? onLongPress;

  const CardWidget({
    required this.cards,
    required this.index,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    final _cardsBloc = BlocProvider.of<CardsBloc>(context);
    return Stack(
      children: [
        Positioned.fill(
          child: Container(
            color: DynamicThemedColors.scaffoldBackground(context),
            padding: const EdgeInsets.all(2),
            child: CachedNetworkImage(
              imageUrl: cards[index].cardImages.first.imageUrlSmall,
              placeholder: (_, __) => Image.asset(
                'assets/back_high.jpg',
                fit: BoxFit.fill,
              ),
              fit: BoxFit.fill,
            ),
          ),
        ),
        if (onLongPress != null)
          Positioned(
            bottom: 2,
            left: 2,
            child: StreamBuilder<Object>(
              stream: _cardsBloc.onFullCollectionCompletionChanged,
              builder: (streamContext, __) {
                final expansionCollectionBloc =
                    BlocProvider.of<ExpansionCollectionBloc>(streamContext);
                final firstEdQty = HiveHelper.instance.getCopiesOfCardOwned(
                  cards[index].getDbKey(
                      expansionCollectionBloc.cardSet!, CardEditionEnum.first),
                );
                final unlimitedQty = HiveHelper.instance.getCopiesOfCardOwned(
                  cards[index].getDbKey(expansionCollectionBloc.cardSet!,
                      CardEditionEnum.unlimited),
                );
                final quantity = firstEdQty + unlimitedQty;
                return quantity > 0
                    ? Container(
                        decoration: const BoxDecoration(
                          color: MyColors.yellow2,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(6),
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(
                            vertical: 4, horizontal: 6),
                        child: Text('$quantity', style: TextStyles.black12b),
                      )
                    : const SizedBox();
              },
            ),
          ),
        Positioned.fill(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                FocusScope.of(context).unfocus();
                Navigator.pushNamed(
                  context,
                  CardsOverlay.routeName,
                  arguments: <Object>[cards, index],
                );
              },
              onLongPress: onLongPress,
            ),
          ),
        ),
      ],
    );
  }
}
