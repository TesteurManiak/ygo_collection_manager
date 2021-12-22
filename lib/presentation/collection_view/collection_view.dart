import 'package:flutter/material.dart';

import '../../core/consts/consts.dart';
import '../../domain/entities/ygo_card.dart';
import '../../domain/entities/ygo_set.dart';
import '../blocs/bloc_provider.dart';
import '../blocs/cards_bloc.dart';
import '../blocs/sets_bloc.dart';
import '../components/filter_sliver_app_bar.dart';
import '../components/no_glow_custom_scroll_view.dart';
import '../components/sliver_spacer.dart';
import '../components/top_rounded_sliver.dart';
import '../components/total_completion_widget.dart';
import '../constants/colors.dart';
import 'widgets/set_tile_widget.dart';

class CollectionView extends StatefulWidget {
  const CollectionView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CollectionViewState();
}

class _CollectionViewState extends State<CollectionView>
    with AutomaticKeepAliveClientMixin {
  final _searchController = TextEditingController();

  late final _setsBloc = BlocProvider.of<SetsBloc>(context);
  late final _cardsBloc = BlocProvider.of<CardsBloc>(context);

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () => _setsBloc.fetchSets(shouldReload: true),
        child: NoGlowCustomScrollView(
          slivers: [
            const SliverAppBar(
              title: Text('Collection'),
              centerTitle: true,
              bottom: TotalCompletionBottomWidget(),
            ),
            const TopRoundedSliver(),
            FilterSliverAppBar(
              hintText: 'Filter expansions',
              onChanged: _setsBloc.filter,
              controller: _searchController,
            ),
            const SliverSpacer(height: Consts.px16),
            StreamBuilder<List<YgoCard>?>(
              stream: _cardsBloc.onCardsChanged,
              builder: (_, __) => StreamBuilder<List<YgoSet>?>(
                stream: _setsBloc.onFilteredSetsChanged,
                builder: (_, snapshot) {
                  final data = snapshot.data;
                  if (!snapshot.hasData || data == null) {
                    return const SliverToBoxAdapter(child: SizedBox());
                  }
                  return StreamBuilder<double>(
                    stream: _cardsBloc.onFullCollectionCompletionChanged,
                    builder: (_, __) {
                      return SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) => Container(
                            decoration: BoxDecoration(
                              color: DynamicThemedColors.scaffoldBackground(
                                context,
                              ),
                              border: Border.all(
                                color: DynamicThemedColors.scaffoldBackground(
                                  context,
                                ),
                              ),
                            ),
                            child: SetTileWidget(data[index]),
                          ),
                          childCount: data.length,
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
