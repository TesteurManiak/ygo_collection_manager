import 'package:flutter/material.dart';
import 'package:ygo_collection_manager/blocs/bloc_provider.dart';
import 'package:ygo_collection_manager/blocs/sets_bloc.dart';
import 'package:ygo_collection_manager/models/set_model.dart';
import 'package:ygo_collection_manager/styles/colors.dart';
import 'package:ygo_collection_manager/ui/collection_view/widgets/set_tile_widget.dart';
import 'package:ygo_collection_manager/ui/collection_view/widgets/total_completion_widget.dart';
import 'package:ygo_collection_manager/ui/common/sliver_spacer.dart';

class CollectionView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CollectionViewState();
}

class _CollectionViewState extends State<CollectionView>
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
    final _setsBloc = BlocProvider.of<SetsBloc>(context);
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _setsBloc.refreshSets,
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: const Text('Collection'),
              centerTitle: true,
              bottom: TotalCompletionWidget(),
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
                  hintText: 'Filter expansions',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(36),
                    borderSide: const BorderSide(width: 2),
                  ),
                ),
              ),
            ),
            const SliverSpacer(height: 16),
            StreamBuilder<List<SetModel>?>(
              stream: _setsBloc.onSetsChanged,
              builder: (context, snapshot) {
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => Container(
                      decoration: BoxDecoration(
                        color: DynamicThemedColors.scaffoldBackground(context),
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(1),
                        ),
                      ),
                      child: SetTileWidget(snapshot.data![index]),
                    ),
                    childCount: snapshot.data?.length ?? 0,
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
