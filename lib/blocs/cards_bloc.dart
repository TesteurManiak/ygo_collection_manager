import 'dart:async';
import 'dart:isolate';

import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';
import 'package:ygo_collection_manager/api/api_repository.dart';
import 'package:ygo_collection_manager/blocs/bloc.dart';
import 'package:ygo_collection_manager/helper/hive_helper.dart';
import 'package:ygo_collection_manager/models/card_info_model.dart';
import 'package:ygo_collection_manager/models/set_model.dart';
import 'package:ygo_collection_manager/ui/common/cards_overlay.dart';

class CardsBloc extends BlocBase {
  final _cardsController = BehaviorSubject<List<CardInfoModel>?>.seeded(null);
  Stream<List<CardInfoModel>?> get onCardsChanged => _cardsController.stream;
  List<CardInfoModel>? get cards => _cardsController.value;

  late Isolate _isolate;
  late ReceivePort _receivePort;
  late StreamSubscription _isolateSubscription;

  late OverlayState? _overlayState;
  late OverlayEntry _overlayEntry;
  bool _isOverlayOpen = false;
  bool get isOverlayOpen => _isOverlayOpen;

  late AnimationController _overlayAnimationController;
  AnimationController get overlayAnimationController =>
      _overlayAnimationController;

  late Animation<double> _overlayAnimation;
  Animation<double> get overlayAnimation => _overlayAnimation;

  /// Return a list of [CardInfoModel] that are in the set of cards.
  /// Takes a [SetModel] as parameter.
  List<CardInfoModel>? getCardsInSet(SetModel cardSet) {
    return cards
        ?.where((e) =>
            e.cardSets != null &&
            e.cardSets!
                .map<String>((e) => e.name)
                .toSet()
                .contains(cardSet.setName))
        .toList();
  }

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
    apiRepository.getCardInfo(misc: true).then((value) => sendPort.send(value));
  }

  void loadFromDb() {
    final cards = HiveHelper.instance.cards.toList()
      ..sort((a, b) => a.name.compareTo(b.name));
    _cardsController.sink.add(cards);
  }

  Future<void> fetchAllCards() async {
    _receivePort = ReceivePort();
    _isolate = await Isolate.spawn(_fetchCards, <Object>[
      _receivePort.sendPort,
    ]);
    _isolateSubscription = _receivePort.listen((message) {
      final newCards = message as List<CardInfoModel>
        ..sort((a, b) => a.name.compareTo(b.name));
      _cardsController.sink.add(newCards);
      HiveHelper.instance.updateCards(newCards);
      _closeIsolate();
    });
  }

  void initOverlayState(BuildContext context) =>
      _overlayState = Overlay.of(context);

  void openOverlay({
    int initialIndex = 0,
    required List<CardInfoModel> cards,
    required TickerProvider tickerProvider,
  }) {
    if (_overlayState != null) {
      _overlayAnimationController = AnimationController(
        vsync: tickerProvider,
        duration: const Duration(milliseconds: 500),
        value: 1.0,
      );
      _overlayAnimation = CurvedAnimation(
        parent: _overlayAnimationController,
        curve: Curves.easeIn,
      );
      _overlayEntry = OverlayEntry(
        builder: (_) => Align(
          child: CardsOverlay(
            initialIndex: initialIndex,
            cards: cards,
          ),
        ),
      );
      _overlayState?.insert(_overlayEntry);
      _isOverlayOpen = true;
    }
  }

  void closeOverlay() {
    _overlayAnimationController.reverse().then((_) {
      _overlayEntry.remove();
      _isOverlayOpen = false;
    });
  }
}
