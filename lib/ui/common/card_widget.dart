import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../blocs/cards_bloc.dart';
import '../../blocs/expansion_collection_bloc.dart';
import '../../core/bloc/bloc_provider.dart';
import '../../core/entities/card_edition_enum.dart';
import '../../data/datasources/local/ygopro_local_datasource.dart';
import '../../domain/entities/ygo_card.dart';
import '../../service_locator.dart';
import '../../core/styles/colors.dart';
import '../../core/styles/text_styles.dart';
import 'cards_overlay.dart';

class CardWidget extends StatelessWidget {
  final int index;
  final List<YgoCard> cards;
  final void Function()? onLongPress;

  const CardWidget({
    Key? key,
    required this.cards,
    required this.index,
    this.onLongPress,
  }) : super(key: key);

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
                final localRepo = sl<YgoProLocalDataSource>();
                final expansionCollectionBloc =
                    BlocProvider.of<ExpansionCollectionBloc>(streamContext);

                return FutureBuilder<int>(
                  future: localRepo.getCopiesOfCardOwned(
                    cards[index].getDbKey(
                      expansionCollectionBloc.cardSet!,
                      CardEditionEnum.first,
                    ),
                  ),
                  builder: (_, firstEdSnapshot) {
                    if (firstEdSnapshot.hasData) {
                      final firstEdQty = firstEdSnapshot.data!;
                      return FutureBuilder<int>(
                        future: localRepo.getCopiesOfCardOwned(
                          cards[index].getDbKey(
                            expansionCollectionBloc.cardSet!,
                            CardEditionEnum.unlimited,
                          ),
                        ),
                        builder: (_, unlimitedSnapshot) {
                          if (unlimitedSnapshot.hasData) {
                            final unlimitedQty = unlimitedSnapshot.data!;
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
                                      vertical: 4,
                                      horizontal: 6,
                                    ),
                                    child: Text(
                                      '$quantity',
                                      style: TextStyles.black12b,
                                    ),
                                  )
                                : const SizedBox();
                          }
                          return Container();
                        },
                      );
                    }
                    return Container();
                  },
                );
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
