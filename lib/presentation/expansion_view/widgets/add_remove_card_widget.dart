import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/consts/my_edge_insets.dart';
import '../../../domain/entities/card_edition_enum.dart';
import '../../../domain/entities/ygo_set.dart';
import '../../blocs/expansion_collection/expansion_collection_bloc.dart';

class AddRemoveCardWidget extends StatelessWidget {
  final YgoSet currentSet;

  const AddRemoveCardWidget(this.currentSet, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final expansionCollectionBloc =
        BlocProvider.of<ExpansionCollectionBloc>(context);
    return Padding(
      padding: MyEdgeInsets.symH16,
      child: Column(
        children: [
          _EditionLine(
            edition: CardEditionEnum.first,
            currentSet: currentSet,
            onQuantityChanged: expansionCollectionBloc.onFirstEditionQtyChanged,
          ),
          _EditionLine(
            edition: CardEditionEnum.unlimited,
            currentSet: currentSet,
            onQuantityChanged: expansionCollectionBloc.onUnlimitedQtyChanged,
          ),
        ],
      ),
    );
  }
}

class _EditionLine extends StatefulWidget {
  final CardEditionEnum edition;
  final YgoSet currentSet;
  final Stream<int> onQuantityChanged;

  const _EditionLine({
    required this.edition,
    required this.currentSet,
    required this.onQuantityChanged,
  });

  @override
  State<StatefulWidget> createState() => _EditionLineState();
}

class _EditionLineState extends State<_EditionLine> {
  late final _expansionCollectionBloc =
      BlocProvider.of<ExpansionCollectionBloc>(context);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
      stream: _expansionCollectionBloc.onSelectedCardIndexChanged,
      initialData: _expansionCollectionBloc.selectedCardIndex,
      builder: (_, snapshot) {
        return Row(
          children: [
            Text(widget.edition.string),
            const Spacer(),
            IconButton(
              onPressed: () =>
                  _expansionCollectionBloc.removeCard(widget.edition),
              icon: const Icon(Icons.remove),
            ),
            StreamBuilder<int>(
              stream: widget.onQuantityChanged,
              initialData: 0,
              builder: (_, snapshot) {
                return Text('${snapshot.data!}');
              },
            ),
            IconButton(
              onPressed: () => _expansionCollectionBloc.addCard(widget.edition),
              icon: const Icon(Icons.add),
            ),
          ],
        );
      },
    );
  }
}
