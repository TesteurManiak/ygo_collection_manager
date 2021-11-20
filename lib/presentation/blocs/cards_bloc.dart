import 'dart:async';
import 'dart:isolate';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import '../../core/bloc/bloc.dart';
import '../../core/extensions/extensions.dart';
import '../../domain/entities/card_owned.dart';
import '../../domain/entities/ygo_card.dart';
import '../../domain/entities/ygo_set.dart';
import '../../domain/usecases/fetch_all_cards.dart';
import '../../domain/usecases/fetch_local_cards.dart';
import '../../domain/usecases/fetch_owned_cards.dart';
import '../../domain/usecases/update_cards.dart';
import '../../service_locator.dart';

class CardsBloc implements BlocBase {
  final FetchAllCards fetchCards;
  final FetchLocalCards fetchLocalCards;
  final FetchOwnedCards fetchOwnedCards;
  final UpdateCards updateCards;

  CardsBloc({
    required this.fetchCards,
    required this.fetchLocalCards,
    required this.fetchOwnedCards,
    required this.updateCards,
  });

  final _cardsController = BehaviorSubject<List<YgoCard>?>.seeded(null);
  Stream<List<YgoCard>?> get onCardsChanged => _cardsController.stream;
  List<YgoCard>? get cards => _cardsController.value;
  late final StreamSubscription<List<YgoCard>?> _cardsSubscription;

  final _filteredCardsController = BehaviorSubject<List<YgoCard>?>.seeded(null);
  Stream<List<YgoCard>?> get onFilteredCardsChanged =>
      _filteredCardsController.stream;

  final searchController = TextEditingController();

  final _fullCollectionCompletionController =
      BehaviorSubject<double>.seeded(0.0);
  Stream<double> get onFullCollectionCompletionChanged =>
      _fullCollectionCompletionController.stream;
  double get fullCollectionCompletion =>
      _fullCollectionCompletionController.value;

  ReceivePort? _receivePort;
  Isolate? _isolate;
  StreamSubscription? _isolateSubscription;

  /// Return a list of [YgoCard] that are in the set of cards.
  /// Takes a [SetModel] as parameter.
  List<YgoCard>? getCardsInSet(YgoSet cardSet) {
    return cards?.compactMap<YgoCard>(
      (card) => card.cardSets != null &&
              card.cardSets!
                  .map<String>((e) => e.name)
                  .toSet()
                  .contains(cardSet.setName)
          ? card
          : null,
    );
  }

  void _cardsListener(List<YgoCard>? _cards) {
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
    _receivePort?.close();
    _isolate?.kill(priority: Isolate.immediate);
    _isolateSubscription?.cancel();
  }

  Future<void> loadFromDb() async {
    final cards = await fetchLocalCards();
    _cardsController.sink.add(cards);
  }

  static void _fetchCards(List<Object> args) {
    final sendPort = args[0] as SendPort;
    setupLocator();
    sl<FetchAllCards>().call().then((value) => sendPort.send(value));
  }

  Future<void> fetchAllCards() async {
    if (kIsWeb) {
      final newCards = await fetchCards();
      _cardsController.sink.add(newCards);
      await updateCards(newCards);
    } else {
      _receivePort = ReceivePort();
      _isolate = await Isolate.spawn(_fetchCards, <Object>[
        _receivePort!.sendPort,
      ]);
      _isolateSubscription = _receivePort!.listen((message) {
        final newCards = message as List<YgoCard>;
        _cardsController.sink.add(newCards);
        updateCards(newCards);
        _closeIsolate();
      });
    }
  }

  Future<void> updateCompletion({List<YgoCard>? initialCards}) async {
    final _cards = initialCards ?? cards;
    if (_cards != null) {
      final _cardsList =
          _cards.compactMap((e) => e.cardSets != null ? e : null);
      final _differentCardsSet = <String>{};
      for (final card in _cardsList) {
        _differentCardsSet.addAll(card.cardSets!.map<String>((e) => e.code));
      }
      final _cardsOwned =
          (await fetchOwnedCards()).map<String>((e) => e.setCode).toSet();
      if (_differentCardsSet.isNotEmpty) {
        _fullCollectionCompletionController.sink
            .add(_cardsOwned.length / _differentCardsSet.length * 100);
      }
    }
  }

  Future<int> cardsOwnedInSet(YgoSet cardSet) async {
    return (await fetchOwnedCards())
        .compactMap<CardOwned>(
          (e) => e.setCode.contains(cardSet.setCode) &&
                  e.setName == cardSet.setName
              ? e
              : null,
        )
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
