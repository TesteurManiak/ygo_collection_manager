import 'package:flutter/material.dart';
import 'package:ygo_collection_manager/blocs/bloc_provider.dart';
import 'package:ygo_collection_manager/blocs/cards_bloc.dart';
import 'package:ygo_collection_manager/models/card_info_model.dart';
import 'package:ygo_collection_manager/styles/colors.dart';
import 'package:ygo_collection_manager/ui/common/card_widget.dart';
import 'package:ygo_collection_manager/ui/common/no_glow_scroll_behavior.dart';
import 'package:ygo_collection_manager/ui/common/sliver_spacer.dart';
import 'package:ygo_collection_manager/ui/common/top_rounded_sliver.dart';

class BrowseView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BrowseViewState();
}

class _BrowseViewState extends State<BrowseView>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  late final _cardsBloc = BlocProvider.of<CardsBloc>(context);

  void _showFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => const AlertDialog(
        title: Text('Sort by'),
      ),
    );
  }

  Future<bool> _onWillPop() async {
    if (_cardsBloc.isOverlayOpen) {
      _cardsBloc.closeOverlay();
      return false;
    }
    return true;
  }

  @override
  void initState() {
    super.initState();
    _cardsBloc.initOverlayState(context);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final size = MediaQuery.of(context).size;
    final _crossAxisCount = size.width < size.height ? 3 : 6;
    final itemWidth = size.width / _crossAxisCount;
    final itemHeight = itemWidth * 1.47;

    final _cardsBloc = BlocProvider.of<CardsBloc>(context);
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
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
                backgroundColor:
                    DynamicThemedColors.scaffoldBackground(context),
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
              StreamBuilder<List<CardInfoModel>?>(
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
                          tickerProvider: this,
                        ),
                        childCount: data.length,
                      ),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: _crossAxisCount,
                        childAspectRatio: itemWidth / itemHeight,
                      ),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
