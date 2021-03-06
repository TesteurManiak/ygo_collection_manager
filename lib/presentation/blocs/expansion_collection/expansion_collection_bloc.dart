import 'dart:async';

import 'package:flutter/animation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

import '../../../domain/entities/card_edition_enum.dart';
import '../../../domain/entities/card_owned.dart';
import '../../../domain/entities/ygo_card.dart';
import '../../../domain/entities/ygo_set.dart';
import '../../../domain/usecases/get_copies_of_card_owned.dart';
import '../../../domain/usecases/update_card_owned.dart';
import '../cards/cards_bloc.dart';
import '../state.dart';

part 'expansion_collection_state.dart';

class ExpansionCollectionBloc extends Cubit<ExpansionCollectionState> {
  final GetCopiesOfCardOwned getCopiesOfCardOwned;
  final UpdateCardOwned updateCardOwned;
  final CardsBloc cardsBloc;

  ExpansionCollectionBloc({
    required this.getCopiesOfCardOwned,
    required this.updateCardOwned,
    required this.cardsBloc,
  }) : super(const ExpansionCollectionInitial()) {
    _selectedIndexSubscription =
        _selectedCardIndexController.listen(_cardIndexListener);

    _firstEditionQtySubscription =
        _firstEditionQtyController.listen(_updateCompletionListener);
    _unlimitedQtySubscription =
        _unlimitedQtyController.listen(_updateCompletionListener);
  }

  final _editionStateController = BehaviorSubject<bool>.seeded(false);
  Stream<bool> get onEditionStateChanged => _editionStateController.stream;
  bool get isEditing => _editionStateController.value;

  final _titleController = BehaviorSubject<String?>.seeded(null);
  Stream<String?> get onTitleChanged => _titleController.stream;
  String? get title => _titleController.value;

  final _selectedCardIndexController = BehaviorSubject<int>.seeded(0);
  Stream<int> get onSelectedCardIndexChanged =>
      _selectedCardIndexController.stream;
  int get selectedCardIndex => _selectedCardIndexController.value;
  late final StreamSubscription<int> _selectedIndexSubscription;

  final _firstEditionQtyController = BehaviorSubject<int>.seeded(0);
  Stream<int> get onFirstEditionQtyChanged => _firstEditionQtyController.stream;
  int get firstEditionQty => _firstEditionQtyController.value;
  late final StreamSubscription<int> _firstEditionQtySubscription;

  final _unlimitedQtyController = BehaviorSubject<int>.seeded(0);
  Stream<int> get onUnlimitedQtyChanged => _unlimitedQtyController.stream;
  int get unlimitedQty => _unlimitedQtyController.value;
  late final StreamSubscription<int> _unlimitedQtySubscription;

  final _cardSetController = BehaviorSubject<YgoSet?>.seeded(null);
  Stream<YgoSet?> get onCardSetChanged => _cardSetController.stream;
  YgoSet? get cardSet => _cardSetController.value;

  List<YgoCard>? _cards;

  void _cardIndexListener(int index) {
    final currentCards = _cards;
    final currentSet = cardSet;
    if (currentCards != null && currentSet != null) {
      final card = currentCards[index];
      _titleController.sink.add(card.name);

      getCopiesOfCardOwned(
        card.getDbKey(currentSet, CardEditionEnum.first),
      ).then((value) {
        _firstEditionQtyController.sink.add(value);
      });

      getCopiesOfCardOwned(
        card.getDbKey(currentSet, CardEditionEnum.unlimited),
      ).then((value) {
        _unlimitedQtyController.sink.add(value);
      });
    }
  }

  void _updateCompletionListener(_) => cardsBloc.updateCompletion();

  @override
  Future<void> close() {
    _selectedIndexSubscription.cancel();
    _firstEditionQtySubscription.cancel();
    _unlimitedQtySubscription.cancel();

    _editionStateController.close();
    _titleController.close();
    _selectedCardIndexController.close();
    _firstEditionQtyController.close();
    _unlimitedQtyController.close();
    _cardSetController.close();
    return super.close();
  }

  void initializeSet(YgoSet set) {
    _cardSetController.sink.add(set);
  }

  void enableEditing({
    required AnimationController controller,
    required int cardIndex,
    required List<YgoCard> cards,
  }) {
    if (!isEditing) {
      _cards = cards;
      _selectedCardIndexController.sink.add(cardIndex);
      _editionStateController.sink.add(true);
      controller.forward();
    }
  }

  void disableEditing(AnimationController controller) {
    if (isEditing) {
      _titleController.sink.add(null);
      _editionStateController.sink.add(false);
      controller.reverse();
    }
  }

  void selectCard(int index) {
    _selectedCardIndexController.sink.add(index);
  }

  void addCard(CardEditionEnum edition) {
    final currentCards = _cards;
    final currentSet = cardSet;
    if (currentCards != null && currentSet != null) {
      final card = currentCards[selectedCardIndex];
      final newQuantity =
          (edition == CardEditionEnum.first ? firstEditionQty : unlimitedQty) +
              1;
      Future.microtask(
        () => updateCardOwned(
          CardOwned(
            quantity: newQuantity,
            setCode: card.getCardSetsFromSet(currentSet)!.code,
            edition: edition,
            setName: currentSet.setName,
            id: card.id,
          ),
        ),
      ).then(
        (_) {
          edition == CardEditionEnum.first
              ? _firstEditionQtyController.sink.add(newQuantity)
              : _unlimitedQtyController.sink.add(newQuantity);
        },
      );
    }
  }

  void removeCard(CardEditionEnum edition) {
    final currentQty =
        edition == CardEditionEnum.first ? firstEditionQty : unlimitedQty;
    if (currentQty > 0) {
      final currentCards = _cards;
      final currentSet = cardSet;
      if (currentCards != null && currentSet != null) {
        final card = currentCards[selectedCardIndex];
        final newQuantity = currentQty - 1;
        Future.microtask(
          () => updateCardOwned(
            CardOwned(
              quantity: newQuantity,
              setCode: card.getCardSetsFromSet(currentSet)!.code,
              edition: edition,
              setName: currentSet.setName,
              id: card.id,
            ),
          ),
        ).then(
          (_) {
            edition == CardEditionEnum.first
                ? _firstEditionQtyController.sink.add(newQuantity)
                : _unlimitedQtyController.sink.add(newQuantity);
          },
        );
      }
    }
  }
}
