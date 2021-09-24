import 'package:flutter/material.dart';
import 'package:ygo_collection_manager/blocs/bloc_provider.dart';
import 'package:ygo_collection_manager/blocs/cards_bloc.dart';
import 'package:ygo_collection_manager/models/card_info_model.dart';

class CardViewOverlay extends StatelessWidget {
  final CardInfoModel card;

  const CardViewOverlay({Key? key, required this.card}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cardsBloc = BlocProvider.of<CardsBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(card.name),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: cardsBloc.closeCardView,
        ),
      ),
    );
  }
}
