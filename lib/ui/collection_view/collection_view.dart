import 'package:flutter/material.dart';
import 'package:ygo_collection_manager/blocs/bloc_provider.dart';
import 'package:ygo_collection_manager/blocs/sets_bloc.dart';
import 'package:ygo_collection_manager/models/set_model.dart';
import 'package:ygo_collection_manager/styles/colors.dart';
import 'package:ygo_collection_manager/ui/collection_view/widgets/set_tile_widget.dart';

class CollectionView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _setsBloc = BlocProvider.of<SetsBloc>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Collection')),
      body: Container(
        decoration: BoxDecoration(
          color: DynamicThemedColors.scaffoldBackground(context),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
        ),
        child: StreamBuilder<List<SetModel>?>(
          stream: _setsBloc.onSetsChanged,
          builder: (_, snapshot) {
            if (snapshot.hasError) return Text(snapshot.error.toString());
            if (!snapshot.hasData) return const CircularProgressIndicator();
            return ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: snapshot.data!.length,
              separatorBuilder: (_, __) => const SizedBox(height: 16),
              itemBuilder: (_, index) => SetTileWidget(snapshot.data![index]),
            );
          },
        ),
      ),
    );
  }
}
