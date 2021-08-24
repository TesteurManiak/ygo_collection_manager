import 'dart:async';
import 'dart:isolate';

import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';
import 'package:ygo_collection_manager/api/api_repository.dart';
import 'package:ygo_collection_manager/blocs/bloc.dart';
import 'package:ygo_collection_manager/helper/hive_helper.dart';
import 'package:ygo_collection_manager/models/card_info_model.dart';
import 'package:ygo_collection_manager/ui/browse_view/widgets/cards_overlay.dart';

class CardsBloc extends BlocBase {
  final _cardsController = BehaviorSubject<List<CardInfoModel>?>.seeded(null);
  Stream<List<CardInfoModel>?> get onCardsChanged => _cardsController.stream;
  List<CardInfoModel>? get cards => _cardsController.value;

  late Isolate _isolate;
  late ReceivePort _receivePort;
  late StreamSubscription _isolateSubscription;

  late final OverlayState? _overlayState;
  late OverlayEntry _overlayEntry;
  bool _isOverlayOpen = false;
  bool get isOverlayOpen => _isOverlayOpen;

  @override
  void initState() {}

  @override
  void dispose() {
    _closeIsolate();
    _cardsController.close();
    _overlayState?.dispose();
  }

  void _closeIsolate() {
    _receivePort.close();
    _isolate.kill(priority: Isolate.immediate);
    _isolateSubscription.cancel();
  }

  static void _fetchCards(List<Object> args) {
    final sendPort = args[0] as SendPort;
    apiRepository.getCardInfo().then((value) => sendPort.send(value));
  }

  void loadFromDb() {
    final cards = HiveHelper.instance.cards;
    _cardsController.sink.add(cards.toList());
  }

  Future<void> fetchAllCards() async {
    _receivePort = ReceivePort();
    _isolate = await Isolate.spawn(_fetchCards, <Object>[
      _receivePort.sendPort,
    ]);
    _isolateSubscription = _receivePort.listen((message) {
      _cardsController.sink.add(message as List<CardInfoModel>);
      HiveHelper.instance.updateCards(message);
      _closeIsolate();
    });
  }

  void initOverlayState(BuildContext context) =>
      _overlayState = Overlay.of(context);

  void openOverlay({int initialIndex = 0}) {
    if (_overlayState != null) {
      _overlayEntry = OverlayEntry(
        builder: (_) => Align(
          child: CardsOverlay(
            initialIndex: initialIndex,
          ),
        ),
      );
      _overlayState?.insert(_overlayEntry);
      _isOverlayOpen = true;
    }
  }

  void closeOverlay() {
    _overlayEntry.remove();
    _isOverlayOpen = false;
  }
}
