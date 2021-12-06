import 'package:flutter/material.dart';

import '../../core/bloc/bloc_provider.dart';
import '../../core/consts/consts.dart';
import '../../domain/entities/ygo_card.dart';
import '../blocs/cards_bloc.dart';
import '../common/card_widget.dart';
import '../common/filter_sliver_app_bar.dart';
import '../common/no_glow_scroll_behavior.dart';
import '../common/sliver_spacer.dart';
import '../common/top_rounded_sliver.dart';

class BrowseView extends StatefulWidget {
  const BrowseView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _BrowseViewState();
}

class _BrowseViewState extends State<BrowseView>
    with AutomaticKeepAliveClientMixin {
  late final _cardsBloc = BlocProvider.of<CardsBloc>(context);

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final size = MediaQuery.of(context).size;
    final _crossAxisCount = size.width < size.height ? 3 : 6;
    final itemWidth = size.width / _crossAxisCount;
    final itemHeight = itemWidth * 1.47;

    return Scaffold(
      body: ScrollConfiguration(
        behavior: const NoGlowScrollBehavior(),
        child: CustomScrollView(
          slivers: [
            const SliverAppBar(
              title: Text('Browse'),
              centerTitle: true,
            ),
            const TopRoundedSliver(),
            FilterSliverAppBar(
              hintText: 'Search for cards...',
              controller: _cardsBloc.searchController,
              onChanged: _cardsBloc.filter,
            ),
            const SliverSpacer(height: Consts.px16),
            StreamBuilder<List<YgoCard>?>(
              stream: _cardsBloc.onFilteredCardsChanged,
              builder: (_, snapshot) {
                final data = snapshot.data;
                if (!snapshot.hasData || data == null) {
                  return const SliverToBoxAdapter(child: SizedBox());
                }
                return SliverGrid(
                  delegate: SliverChildBuilderDelegate(
                    (_, index) => CardWidget(
                      cards: data,
                      index: index,
                    ),
                    childCount: data.length,
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
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
