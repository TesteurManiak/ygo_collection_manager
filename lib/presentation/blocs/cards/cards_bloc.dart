import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

import '../../../core/extensions/extensions.dart';
import '../../../domain/entities/card_owned.dart';
import '../../../domain/entities/ygo_card.dart';
import '../../../domain/entities/ygo_set.dart';
import '../../../domain/usecases/fetch_all_cards.dart';
import '../../../domain/usecases/fetch_owned_cards.dart';
import '../state.dart';

part 'cards_state.dart';

class CardsBloc extends Cubit<CardsState> {
  final FetchAllCards fetchCards;
  final FetchOwnedCards fetchOwnedCards;

  CardsBloc({
    required this.fetchCards,
    required this.fetchOwnedCards,
  }) : super(const CardsInitial());

  /// Used to keep a reference to the initial cards' data fetched.
  List<YgoCard> _cards = [];
  List<YgoCard> get cards => _cards;

  final _fullCollectionCompletionController =
      BehaviorSubject<double>.seeded(0.0);
  Stream<double> get onFullCollectionCompletionChanged =>
      _fullCollectionCompletionController.stream;
  double get fullCollectionCompletion =>
      _fullCollectionCompletionController.value;

  /// Return a list of [YgoCard] that are in the set of cards.
  /// Takes a [SetModel] as parameter.
  List<YgoCard>? getCardsInSet(YgoSet cardSet) {
    final cardsInSet = cards.compactMap<YgoCard>(
      (card) => card.cardSets != null &&
              card.cardSets!
                  .map<String>((e) => e.name)
                  .toSet()
                  .contains(cardSet.setName)
          ? card
          : null,
    );
    return cardsInSet.isEmpty ? null : cardsInSet;
  }

  @override
  Future<void> close() {
    _fullCollectionCompletionController.close();
    return super.close();
  }

  Future<void> fetchAllCards({required bool shouldReload}) async {
    emit(const CardsLoading());
    try {
      final newCards = await fetchCards(shouldReload: shouldReload);
      emit(CardsLoaded(cards: newCards));
      _cards = newCards;
      unawaited(updateCompletion(initialCards: newCards));
    } catch (e) {
      emit(CardsError(e.toString()));
    }
  }

  Future<void> updateCompletion({List<YgoCard>? initialCards}) async {
    final _cards = initialCards ?? cards;
    final _cardsList = _cards.compactMap((e) => e.cardSets != null ? e : null);
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
      emit(CardsFiltered(_cards));
    } else {
      final filteredResult = _cards
          .where((e) => e.name.toLowerCase().contains(search.toLowerCase()))
          .toList();
      emit(CardsFiltered(filteredResult));
    }
  }

  YgoCard findCardFromParam(String paramId) {
    return cards.firstWhere((e) => e.id == int.parse(paramId));
  }
}
