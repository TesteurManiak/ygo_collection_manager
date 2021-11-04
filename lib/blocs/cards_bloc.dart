import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import '../api/api_repository.dart';
import '../core/bloc/bloc.dart';
import '../core/isolate/isolate_wrapper.dart';
import '../data/models/request/get_card_info_request.dart';
import '../domain/entities/ygo_card.dart';
import '../extensions/extensions.dart';
import '../helper/hive_helper.dart';
import '../models/card_owned_model.dart';
import '../models/set_model.dart';

class CardsBloc extends BlocBase {
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
  List<YgoCard>? getCardsInSet(SetModel cardSet) {
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
    _cardsSubscription.cancel();

    _cardsController.close();
    _filteredCardsController.close();
    _fullCollectionCompletionController.close();
  }

  void loadFromDb() {
    final cards = HiveHelper.instance.cards.toList()
      ..sort((a, b) => a.name.compareTo(b.name));
    _cardsController.sink.add(cards);
  }

  Future<void> fetchAllCards() async {
    await IsolateWrapper().spawn<List<YgoCard>>(
      () => apiRepository.getCardInfo(GetCardInfoRequest(misc: true)),
      callback: (newCards) {
        newCards.sort((a, b) => a.name.compareTo(b.name));
        _cardsController.sink.add(newCards);
        HiveHelper.instance.updateCards(newCards);
      },
    );
  }

  void updateCompletion({List<YgoCard>? initialCards}) {
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
