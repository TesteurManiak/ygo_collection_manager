import 'package:flutter/material.dart';

import '../../blocs/cards_bloc.dart';
import '../../core/bloc/bloc_provider.dart';
import '../../domain/entities/ygo_card.dart';
import '../../styles/colors.dart';
import '../common/card_widget.dart';
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

  void _showFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => const AlertDialog(
        title: Text('Sort by'),
      ),
    );
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
        behavior: NoGlowScrollBehavior(),
        child: CustomScrollView(
          slivers: [
            const SliverAppBar(
              title: Text('Browse'),
              centerTitle: true,
            ),
            const TopRoundedSliver(),
            SliverAppBar(
              toolbarHeight: kToolbarHeight + 4,
              backgroundColor: DynamicThemedColors.scaffoldBackground(context),
              pinned: true,
              title: TextField(
                controller: _cardsBloc.searchController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.sort),
                    onPressed: () => _showFilterDialog(context),
                  ),
                  hintText: 'Search for cards...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(36),
                    borderSide: const BorderSide(width: 2),
                  ),
                ),
                onChanged: _cardsBloc.filter,
              ),
            ),
            const SliverSpacer(height: 16),
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
