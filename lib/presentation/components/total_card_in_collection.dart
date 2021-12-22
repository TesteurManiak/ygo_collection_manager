import 'package:flutter/material.dart';

import '../../data/datasources/local/ygopro_local_datasource.dart';
import '../../service_locator.dart';

class TotalCardInCollection extends StatefulWidget {
  final int cardId;

  const TotalCardInCollection({Key? key, required this.cardId})
      : super(key: key);

  @override
  _TotalCardInCollectionState createState() => _TotalCardInCollectionState();
}

class _TotalCardInCollectionState extends State<TotalCardInCollection> {
  late final _totalOwnedCard = ValueNotifier<int>(0);

  @override
  void initState() {
    super.initState();
    sl<YgoProLocalDataSource>()
        .getCopiesOfCardOwnedById(widget.cardId)
        .then((value) {
      _totalOwnedCard.value = value;
    });
  }

  @override
  void dispose() {
    _totalOwnedCard.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: _totalOwnedCard,
      builder: (_, value, __) => Text('$value in Collection'),
    );
  }
}
