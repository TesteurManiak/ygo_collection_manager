import 'package:flutter/material.dart';
import 'package:ygo_collection_manager/blocs/bloc_provider.dart';
import 'package:ygo_collection_manager/blocs/expansion_collection_bloc.dart';
import 'package:ygo_collection_manager/models/card_edition_enum.dart';
import 'package:ygo_collection_manager/models/set_model.dart';

class AddRemoveCardWidget extends StatelessWidget {
  final SetModel currentSet;

  const AddRemoveCardWidget(this.currentSet);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          _EditionLine(
            edition: CardEditionEnum.first,
            currentSet: currentSet,
          ),
          _EditionLine(
            edition: CardEditionEnum.unlimited,
            currentSet: currentSet,
          ),
        ],
      ),
    );
  }
}

class _EditionLine extends StatefulWidget {
  final CardEditionEnum edition;
  final SetModel currentSet;

  const _EditionLine({required this.edition, required this.currentSet});

  @override
  State<StatefulWidget> createState() => _EditionLineState();
}

class _EditionLineState extends State<_EditionLine> {
  late final _expansionCollectionBloc =
      BlocProvider.of<ExpansionCollectionBloc>(context);

  void _removeCard() {
    // if (_quantity > 0) setState(() => _quantity--);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
        stream: _expansionCollectionBloc.onSelectedCardIndexChanged,
        initialData: _expansionCollectionBloc.selectedCardIndex,
        builder: (_, snapshot) {
          return Row(
            children: [
              Text(widget.edition.string),
              Expanded(child: Container()),
              IconButton(
                  onPressed: _removeCard, icon: const Icon(Icons.remove)),
              StreamBuilder<int>(
                stream: _expansionCollectionBloc.onCardQuantityChanged,
                initialData: _expansionCollectionBloc.cardQuantity,
                builder: (_, snapshot) {
                  return Text('${snapshot.data!}');
                },
              ),
              IconButton(
                onPressed: () =>
                    _expansionCollectionBloc.addCard(widget.edition),
                icon: const Icon(Icons.add),
              ),
            ],
          );
        });
  }
}
