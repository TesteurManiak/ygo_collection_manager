import 'package:flutter/material.dart';
import 'package:ygo_collection_manager/blocs/bloc_provider.dart';
import 'package:ygo_collection_manager/blocs/expansion_collection_bloc.dart';

class AddRemoveCardWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: const [
          _EditionLine(label: '1st Edition'),
          _EditionLine(label: 'Unlimited'),
        ],
      ),
    );
  }
}

class _EditionLine extends StatefulWidget {
  final String label;
  final int initialQuantity;

  const _EditionLine({required this.label, this.initialQuantity = 0});

  @override
  State<StatefulWidget> createState() => _EditionLineState();
}

class _EditionLineState extends State<_EditionLine> {
  late final _expansionCollectionBloc =
      BlocProvider.of<ExpansionCollectionBloc>(context);

  late int _quantity = widget.initialQuantity;

  void _addCard() => setState(() => _quantity++);

  void _removeCard() {
    if (_quantity > 0) setState(() => _quantity--);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
        stream: _expansionCollectionBloc.onSelectedCardIndexChanged,
        initialData: _expansionCollectionBloc.selectedCardIndex,
        builder: (_, snapshot) {
          final currentCard = _expansionCollectionBloc.selectedCard;
          _quantity = 0;
          return Row(
            children: [
              Text(widget.label),
              Expanded(child: Container()),
              IconButton(
                  onPressed: _removeCard, icon: const Icon(Icons.remove)),
              Text('$_quantity'),
              IconButton(onPressed: _addCard, icon: const Icon(Icons.add)),
            ],
          );
        });
  }
}
