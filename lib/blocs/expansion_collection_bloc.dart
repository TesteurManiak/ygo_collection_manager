import 'dart:async';

import 'package:flutter/animation.dart';
import 'package:rxdart/rxdart.dart';
import 'package:ygo_collection_manager/blocs/bloc.dart';
import 'package:ygo_collection_manager/helper/hive_helper.dart';
import 'package:ygo_collection_manager/models/card_edition_enum.dart';
import 'package:ygo_collection_manager/models/card_info_model.dart';
import 'package:ygo_collection_manager/models/card_owned_model.dart';
import 'package:ygo_collection_manager/models/set_model.dart';

class ExpansionCollectionBloc extends BlocBase {
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

  final _cardQuantityController = BehaviorSubject<int>.seeded(0);
  Stream<int> get onCardQuantityChanged => _cardQuantityController.stream;
  int get cardQuantity => _cardQuantityController.value;

  final _cardSetController = BehaviorSubject<SetModel?>.seeded(null);
  Stream<SetModel?> get onCardSetChanged => _cardSetController.stream;
  SetModel? get cardSet => _cardSetController.value;

  List<CardInfoModel>? _cards;

  void _cardIndexListener(int index) {
    final currentCards = _cards;
    final currentSet = cardSet;
    if (currentCards != null && currentSet != null) {
      final card = currentCards[index];
      _titleController.sink.add(card.name);
      _cardQuantityController.sink.add(
        HiveHelper.instance.getCopiesOfCardOwned(
          card.getDbKey(currentSet, CardEditionEnum.first),
        ),
      );
    }
  }

  @override
  void initState() {
    _selectedIndexSubscription =
        _selectedCardIndexController.listen(_cardIndexListener);
  }

  @override
  void dispose() {
    _selectedIndexSubscription.cancel();

    _editionStateController.close();
    _titleController.close();
    _selectedCardIndexController.close();
    _cardQuantityController.close();
    _cardSetController.close();
  }

  void initializeSet(SetModel set) {
    _cardSetController.sink.add(set);
  }

  void enableEditing({
    required AnimationController controller,
    required int cardIndex,
    required List<CardInfoModel> cards,
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
      final newQuantity = cardQuantity + 1;
      HiveHelper.instance
          .updateCardOwned(
            CardOwnedModel(
              quantity: newQuantity,
              code: card.getCardSetsFromSet(currentSet)!.code,
              edition: edition,
            ),
          )
          .then((_) => _cardQuantityController.sink.add(newQuantity));
    }
  }

  void removeCard(CardEditionEnum edition) {
    if (cardQuantity > 0) {}
  }
}
