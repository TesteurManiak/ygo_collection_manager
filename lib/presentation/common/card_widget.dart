import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../core/bloc/bloc_provider.dart';
import '../../core/consts/consts.dart';
import '../../core/consts/my_edge_insets.dart';
import '../../core/styles/colors.dart';
import '../../core/styles/text_styles.dart';
import '../../data/datasources/local/ygopro_local_datasource.dart';
import '../../domain/entities/card_edition_enum.dart';
import '../../domain/entities/ygo_card.dart';
import '../../service_locator.dart';
import '../blocs/cards_bloc.dart';
import '../blocs/expansion_collection_bloc.dart';
import 'cards_overlay.dart';

class CardWidget extends StatelessWidget {
  final int index;
  final List<YgoCard> cards;
  final void Function()? onLongPress;
  final String? setId;

  const CardWidget({
    Key? key,
    required this.cards,
    required this.index,
    this.onLongPress,
    this.setId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _cardsBloc = BlocProvider.of<CardsBloc>(context);
    return Stack(
      children: [
        Positioned.fill(
          child: Container(
            color: DynamicThemedColors.scaffoldBackground(context),
            padding: MyEdgeInsets.all2,
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
                                        topRight: Radius.circular(Consts.px6),
                                      ),
                                    ),
                                    padding: MyEdgeInsets.symH6V4,
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
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (_, __, ___) => CardsOverlay(
                      cards: cards,
                      initialIndex: index,
                      setId: setId,
                    ),
                    opaque: false,
                  ),
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
