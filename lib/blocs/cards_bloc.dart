import 'dart:async';
import 'dart:isolate';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:ygo_collection_manager/api/api_repository.dart';
import 'package:ygo_collection_manager/blocs/bloc.dart';
import 'package:ygo_collection_manager/extensions/extensions.dart';
import 'package:ygo_collection_manager/helper/hive_helper.dart';
import 'package:ygo_collection_manager/models/card_info_model.dart';
import 'package:ygo_collection_manager/models/card_owned_model.dart';
import 'package:ygo_collection_manager/models/set_model.dart';

class CardsBloc extends BlocBase {
  final _cardsController = BehaviorSubject<List<CardInfoModel>?>.seeded(null);
  Stream<List<CardInfoModel>?> get onCardsChanged => _cardsController.stream;
  List<CardInfoModel>? get cards => _cardsController.value;
  late final StreamSubscription<List<CardInfoModel>?> _cardsSubscription;

  final _filteredCardsController =
      BehaviorSubject<List<CardInfoModel>?>.seeded(null);
  Stream<List<CardInfoModel>?> get onFilteredCardsChanged =>
      _filteredCardsController.stream;

  final searchController = TextEditingController();

  final _fullCollectionCompletionController =
      BehaviorSubject<double>.seeded(0.0);
  Stream<double> get onFullCollectionCompletionChanged =>
      _fullCollectionCompletionController.stream;
  double get fullCollectionCompletion =>
      _fullCollectionCompletionController.value;

  late Isolate _isolate;
  late ReceivePort _receivePort;
  late StreamSubscription _isolateSubscription;

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

  void _cardsListener(List<CardInfoModel>? _cards) {
    updateCompletion(initialCards: _cards);
    _filteredCardsController.sink.add(_cards);
    searchController.clear();
  }

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
    _filteredCardsController.close();
    _fullCollectionCompletionController.close();
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
        .compactMap<CardOwnedModel>(
          (e) => e.setCode.contains(cardSet.setCode) &&
                  e.setName == cardSet.setName
              ? e
              : null,
        )
        .map<String>((e) => e.setCode)
        .toSet()
        .length;
  }

  void filter(String search) {
    if (search.isEmpty) {
      _filteredCardsController.sink.add(_cardsController.value);
    } else {
      _filteredCardsController.sink.add(
        _cardsController.value!
            .where((e) => e.name.toLowerCase().contains(search.toLowerCase()))
            .toList(),
      );
    }
  }
}
