import 'package:flutter/material.dart';

import '../../core/consts/consts.dart';
import '../../domain/entities/ygo_card.dart';
import '../blocs/bloc_provider.dart';
import '../blocs/cards_bloc.dart';
import '../components/card_widget.dart';
import '../components/filter_sliver_app_bar.dart';
import '../components/no_glow_scroll_behavior.dart';
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
              controller: _searchController,
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
