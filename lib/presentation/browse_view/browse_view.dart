import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/consts/consts.dart';
import '../../domain/entities/ygo_card.dart';
import '../blocs/cards/cards_bloc.dart';
import '../components/card_widget.dart';
import '../components/filter_sliver_app_bar.dart';
import '../components/magic_circle_progress_indicator.dart';
import '../components/no_glow_custom_scroll_view.dart';
import '../components/sliver_spacer.dart';
import '../components/top_rounded_sliver.dart';

class BrowseView extends StatefulWidget {
  const BrowseView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _BrowseViewState();
}

class _BrowseViewState extends State<BrowseView>
    with AutomaticKeepAliveClientMixin {
  final _searchController = TextEditingController();

  late final _cardsBloc = BlocProvider.of<CardsBloc>(context);

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final size = MediaQuery.of(context).size;
    final _crossAxisCount = size.width < size.height ? 3 : 6;
    final itemWidth = size.width / _crossAxisCount;
    final itemHeight = itemWidth * 1.47;

    return Scaffold(
      body: NoGlowCustomScrollView(
        slivers: [
          const SliverAppBar(
            title: Text('Browse'),
            centerTitle: true,
          ),
          const TopRoundedSliver(),
          FilterSliverAppBar(
            hintText: 'Search for cards...',
            controller: _searchController,
            onChanged: _cardsBloc.filter,
          ),
          const SliverSpacer(height: Consts.px16),
          BlocBuilder<CardsBloc, CardsState>(
            bloc: _cardsBloc,
            builder: (_, state) {
              final List<YgoCard> cards;
              switch (state.status) {
                case CardsStatus.initial:
                case CardsStatus.loading:
                  return const SliverToBoxAdapter(
                    child: MagicCircleProgressIndicator(size: 48),
                  );
                case CardsStatus.loaded:
                  final _state = state as CardsLoaded;
                  cards = _state.cards;
                  break;
                case CardsStatus.filtered:
                  final _state = state as CardsFiltered;
                  cards = _state.cards;
                  break;
                case CardsStatus.error:
                  final _state = state as CardsError;
                  return SliverToBoxAdapter(child: Text(_state.message));
              }
              return SliverGrid(
                delegate: SliverChildBuilderDelegate(
                  (_, index) => CardWidget(cards: cards, index: index),
                  childCount: cards.length,
                ),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: _crossAxisCount,
                  childAspectRatio: itemWidth / itemHeight,
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
