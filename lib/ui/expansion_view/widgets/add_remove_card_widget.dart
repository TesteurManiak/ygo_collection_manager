import 'package:flutter/material.dart';
import 'package:ygo_collection_manager/blocs/bloc_provider.dart';
import 'package:ygo_collection_manager/blocs/expansion_collection_bloc.dart';
import 'package:ygo_collection_manager/helper/hive_helper.dart';
import 'package:ygo_collection_manager/models/card_edition_enum.dart';
import 'package:ygo_collection_manager/models/card_owned_model.dart';

class AddRemoveCardWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: const [
          _EditionLine(edition: CardEditionEnum.first),
          _EditionLine(edition: CardEditionEnum.unlimited),
        ],
      ),
    );
  }
}

class _EditionLine extends StatefulWidget {
  final CardEditionEnum edition;

  const _EditionLine({required this.edition});

  @override
  State<StatefulWidget> createState() => _EditionLineState();
}

class _EditionLineState extends State<_EditionLine> {
  late final _expansionCollectionBloc =
      BlocProvider.of<ExpansionCollectionBloc>(context);

  String get _cardOwnedKey =>
      '${_expansionCollectionBloc.currentCard!.getCardSetsFromSet(_expansionCollectionBloc.currentCardSet)?.code}-${widget.edition.string}';

  late int _quantity = _expansionCollectionBloc.currentCard != null
      ? HiveHelper.instance.getCopiesOfCardOwned(_cardOwnedKey)
      : 0;

  void _addCard() {
    HiveHelper.instance
        .updateCardOwned(
      CardOwnedModel(
        quantity: _quantity + 1,
        code: _expansionCollectionBloc.currentCard!
            .getCardSetsFromSet(_expansionCollectionBloc.currentCardSet)!
            .code,
        edition: widget.edition,
      ),
    )
        .then((_) {
      if (mounted) {
        setState(
          () => _quantity =
              HiveHelper.instance.getCopiesOfCardOwned(_cardOwnedKey),
        );
      }
    });
  }

  void _removeCard() {
    if (_quantity > 0) setState(() => _quantity--);
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
              Text('$_quantity'),
              IconButton(onPressed: _addCard, icon: const Icon(Icons.add)),
            ],
          );
        });
  }
}
