import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import '../../core/bloc/bloc.dart';
import '../../core/extensions/extensions.dart';
import '../../core/isolate/isolate_wrapper.dart';
import '../../data/datasources/local/ygopro_local_datasource.dart';
import '../../data/datasources/remote/ygopro_remote_data_source.dart';
import '../../data/models/request/get_card_info_request.dart';
import '../../domain/entities/card_owned.dart';
import '../../domain/entities/ygo_card.dart';
import '../../domain/entities/ygo_set.dart';
import '../../service_locator.dart';

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
    _cardsSubscription.cancel();

    _cardsController.close();
    _filteredCardsController.close();
    _fullCollectionCompletionController.close();
  }

  Future<void> loadFromDb() async {
    final cards = await sl<YgoProLocalDataSource>().getCards();
    cards.sort((a, b) => a.name.compareTo(b.name));
    _cardsController.sink.add(cards);
  }

  Future<void> fetchAllCards() async {
    final remoteRepo = sl<YgoProRemoteDataSource>();
    await IsolateWrapper().spawn<List<YgoCard>>(
      () => remoteRepo.getCardInfo(GetCardInfoRequest(misc: true)),
      callback: (newCards) {
        newCards.sort((a, b) => a.name.compareTo(b.name));
        _cardsController.sink.add(newCards);
        sl<YgoProLocalDataSource>().updateCards(newCards);
      },
    );
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
      final _cardsOwned = (await sl<YgoProLocalDataSource>().getCardsOwned())
          .map<String>((e) => e.setCode)
          .toSet();
      if (_differentCardsSet.isNotEmpty) {
        _fullCollectionCompletionController.sink
            .add(_cardsOwned.length / _differentCardsSet.length * 100);
      }
    }
  }

  Future<int> cardsOwnedInSet(YgoSet cardSet) async {
    return (await sl<YgoProLocalDataSource>().getCardsOwned())
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
