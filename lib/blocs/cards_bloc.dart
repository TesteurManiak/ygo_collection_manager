import 'dart:async';
import 'dart:isolate';

import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';
import 'package:ygo_collection_manager/api/api_repository.dart';
import 'package:ygo_collection_manager/blocs/bloc.dart';
import 'package:ygo_collection_manager/helper/hive_helper.dart';
import 'package:ygo_collection_manager/models/card_info_model.dart';
import 'package:ygo_collection_manager/models/card_owned_model.dart';
import 'package:ygo_collection_manager/models/set_model.dart';
import 'package:ygo_collection_manager/ui/common/cards_overlay.dart';
import 'package:ygo_collection_manager/extensions/extensions.dart';

class CardsBloc extends BlocBase {
  final _cardsController = BehaviorSubject<List<CardInfoModel>?>.seeded(null);
  Stream<List<CardInfoModel>?> get onCardsChanged => _cardsController.stream;
  List<CardInfoModel>? get cards => _cardsController.value;
  late final StreamSubscription<List<CardInfoModel>?> _cardsSubscription;

  final _fullCollectionCompletionController =
      BehaviorSubject<double>.seeded(0.0);
  Stream<double> get onFullCollectionCompletionChanged =>
      _fullCollectionCompletionController.stream;
  double get fullCollectionCompletion =>
      _fullCollectionCompletionController.value;

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
    return cards?.compactMap<CardInfoModel>(
      (card) => card.cardSets != null &&
              card.cardSets!
                  .map<String>((e) => e.name)
                  .toSet()
                  .contains(cardSet.setName)
          ? card
          : null,
    );
  }

  void _cardsListener(List<CardInfoModel>? _cards) =>
      updateCompletion(initialCards: _cards);

  @override
  void initState() {
    _cardsSubscription = _cardsController.listen(_cardsListener);
    loadFromDb();
  }

  @override
  void dispose() {
    _closeIsolate();

    _cardsSubscription.cancel();

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

  void updateCompletion({List<CardInfoModel>? initialCards}) {
    final _cards = initialCards ?? cards;
    if (_cards != null) {
      final _cardsList =
          _cards.compactMap((e) => e.cardSets != null ? e : null);
      final _differentCardsSet = <String>{};
      for (final card in _cardsList) {
        _differentCardsSet.addAll(card.cardSets!.map<String>((e) => e.code));
      }
      final _cardsOwned =
          HiveHelper.instance.cardsOwned.map<String>((e) => e.setCode).toSet();
      if (_differentCardsSet.isNotEmpty) {
        _fullCollectionCompletionController.sink
            .add(_cardsOwned.length / _differentCardsSet.length * 100);
      }
    }
  }

  int cardsOwnedInSet(SetModel cardSet) {
    return HiveHelper.instance.cardsOwned
        .compactMap<CardOwnedModel>((e) =>
            e.setCode.contains(cardSet.setCode) && e.setName == cardSet.setName
                ? e
                : null)
        .map<String>((e) => e.setCode)
        .toSet()
        .length;
  }
}
