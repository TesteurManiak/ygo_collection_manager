import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/consts/consts.dart';
import '../../domain/entities/ygo_set.dart';
import '../blocs/cards/cards_bloc.dart';
import '../blocs/sets/sets_bloc.dart';
import '../components/filter_sliver_app_bar.dart';
import '../components/magic_circle_progress_indicator.dart';
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
            BlocBuilder<CardsBloc, CardsState>(
              bloc: _cardsBloc,
              builder: (_, cardsBlocState) {
                switch (cardsBlocState.status) {
                  case CardsStatus.initial:
                  case CardsStatus.loading:
                    return const SliverToBoxAdapter(
                      child: MagicCircleProgressIndicator(size: 48),
                    );
                  case CardsStatus.loaded:
                  case CardsStatus.filtered:
                    break;
                  case CardsStatus.error:
                    final _state = cardsBlocState as CardsError;
                    return SliverToBoxAdapter(child: Text(_state.message));
                }
                return BlocBuilder<SetsBloc, SetsState>(
                  bloc: _setsBloc,
                  builder: (_, state) {
                    final List<YgoSet> sets;
                    switch (state.status) {
                      case SetsStatus.initial:
                      case SetsStatus.loading:
                        return const SliverToBoxAdapter(
                          child: MagicCircleProgressIndicator(size: 48),
                        );
                      case SetsStatus.loaded:
                        final _state = state as SetsLoaded;
                        sets = _state.sets;
                        break;
                      case SetsStatus.filtered:
                        final _state = state as SetsFiltered;
                        sets = _state.sets;
                        break;
                      case SetsStatus.error:
                        final _state = state as SetsError;
                        return SliverToBoxAdapter(child: Text(_state.message));
                    }
                    return StreamBuilder<double>(
                      stream: _cardsBloc.onFullCollectionCompletionChanged,
                      builder: (_, __) {
                        return SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) => DecoratedBox(
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
                              child: SetTileWidget(sets[index]),
                            ),
                            childCount: sets.length,
                          ),
                        );
                      },
                    );
                  },
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
