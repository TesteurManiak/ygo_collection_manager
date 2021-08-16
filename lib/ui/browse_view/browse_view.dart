import 'package:flutter/material.dart';
import 'package:ygo_collection_manager/blocs/bloc_provider.dart';
import 'package:ygo_collection_manager/blocs/cards_bloc.dart';
import 'package:ygo_collection_manager/models/card_info_model.dart';
import 'package:ygo_collection_manager/styles/colors.dart';
import 'package:ygo_collection_manager/ui/browse_view/widgets/card_widget.dart';
import 'package:ygo_collection_manager/ui/common/sliver_spacer.dart';

class BrowseView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BrowseViewState();
}

class _BrowseViewState extends State<BrowseView>
    with AutomaticKeepAliveClientMixin {
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
    final _cardsBloc = BlocProvider.of<CardsBloc>(context);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            title: Text('Browse'),
            centerTitle: true,
          ),
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.only(top: 16),
              color: Theme.of(context).appBarTheme.backgroundColor,
              height: 20,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(
                    height: 20,
                    decoration: BoxDecoration(
                      color: DynamicThemedColors.scaffoldBackground(context),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverAppBar(
            toolbarHeight: kToolbarHeight + 4,
            backgroundColor: DynamicThemedColors.scaffoldBackground(context),
            pinned: true,
            title: TextField(
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
            ),
          ),
          const SliverSpacer(height: 16),
          StreamBuilder<List<CardInfoModel>?>(
              stream: _cardsBloc.onCardsChanged,
              builder: (_, snapshot) {
                return SliverGrid(
                  delegate: SliverChildBuilderDelegate(
                    (_, index) => CardWidget(snapshot.data![index]),
                    childCount: snapshot.data?.length ?? 0,
                  ),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                  ),
                );
              }),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
