import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import '../../core/bloc/bloc.dart';
import '../../core/extensions/extensions.dart';
import '../../domain/entities/card_owned.dart';
import '../../domain/entities/ygo_card.dart';
import '../../domain/entities/ygo_set.dart';
import '../../domain/usecases/fetch_all_cards.dart';
import '../../domain/usecases/fetch_owned_cards.dart';

class CardsBloc implements BlocBase {
  final FetchAllCards fetchCards;
  final FetchOwnedCards fetchOwnedCards;

  CardsBloc({
    required this.fetchCards,
    required this.fetchOwnedCards,
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
  }

  @override
  void dispose() {
    _cardsSubscription.cancel();

    _cardsController.close();
    _filteredCardsController.close();
    _fullCollectionCompletionController.close();
  }

  Future<void> fetchAllCards({required bool shouldReload}) async {
    final newCards = await fetchCards(shouldReload: shouldReload);
    _cardsController.sink.add(newCards);
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
