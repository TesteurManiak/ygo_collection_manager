import 'package:flutter/material.dart';
import 'package:ygo_collection_manager/blocs/bloc_provider.dart';
import 'package:ygo_collection_manager/blocs/sets_bloc.dart';
import 'package:ygo_collection_manager/models/set_model.dart';
import 'package:ygo_collection_manager/styles/colors.dart';
import 'package:ygo_collection_manager/ui/collection_view/widgets/set_tile_widget.dart';
import 'package:ygo_collection_manager/ui/collection_view/widgets/total_completion_widget.dart';
import 'package:ygo_collection_manager/ui/common/sliver_spacer.dart';
import 'package:ygo_collection_manager/ui/common/top_rounded_sliver.dart';

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
            TopRoundedSliver(),
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
                final data = snapshot.data;
                if (!snapshot.hasData || data == null) {
                  return const SliverToBoxAdapter(child: SizedBox());
                }
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => Container(
                      decoration: BoxDecoration(
                        color: DynamicThemedColors.scaffoldBackground(context),
                        border: Border.all(
                          color:
                              DynamicThemedColors.scaffoldBackground(context),
                        ),
                      ),
                      child: SetTileWidget(data[index]),
                    ),
                    childCount: data.length,
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
