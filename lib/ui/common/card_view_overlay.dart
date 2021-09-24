import 'package:flutter/material.dart';

import 'package:ygo_collection_manager/models/card_info_model.dart';

class CardViewOverlay extends StatelessWidget {
  static const routeName = '/card-view-overlay';

  final CardInfoModel card;

  const CardViewOverlay({Key? key, required this.card}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(card.name),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
      ),
    );
  }
}
