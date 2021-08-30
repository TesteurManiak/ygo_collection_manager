import 'dart:async';

import 'package:flutter/animation.dart';
import 'package:rxdart/rxdart.dart';
import 'package:ygo_collection_manager/blocs/bloc.dart';
import 'package:ygo_collection_manager/blocs/bloc_provider.dart';
import 'package:ygo_collection_manager/blocs/cards_bloc.dart';
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

  final _firstEditionQtyController = BehaviorSubject<int>.seeded(0);
  Stream<int> get onFirstEditionQtyChanged => _firstEditionQtyController.stream;
  int get firstEditionQty => _firstEditionQtyController.value;
  late final StreamSubscription<int> _firstEditionQtySubscription;

  final _unlimitedQtyController = BehaviorSubject<int>.seeded(0);
  Stream<int> get onUnlimitedQtyChanged => _unlimitedQtyController.stream;
  int get unlimitedQty => _unlimitedQtyController.value;
  late final StreamSubscription<int> _unlimitedQtySubscription;

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
      _firstEditionQtyController.sink.add(
        HiveHelper.instance.getCopiesOfCardOwned(
          card.getDbKey(currentSet, CardEditionEnum.first),
        ),
      );
      _unlimitedQtyController.sink.add(
        HiveHelper.instance.getCopiesOfCardOwned(
          card.getDbKey(currentSet, CardEditionEnum.unlimited),
        ),
      );
    }
  }

  void _updateCompletionListener(_) =>
      BlocProvider.master<CardsBloc>().updateCompletion();

  @override
  void initState() {
    _selectedIndexSubscription =
        _selectedCardIndexController.listen(_cardIndexListener);
    _firstEditionQtySubscription =
        _firstEditionQtyController.listen(_updateCompletionListener);
    _unlimitedQtySubscription =
        _unlimitedQtyController.listen(_updateCompletionListener);
  }

  @override
  void dispose() {
    _selectedIndexSubscription.cancel();
    _firstEditionQtySubscription.cancel();
    _unlimitedQtySubscription.cancel();

    _editionStateController.close();
    _titleController.close();
    _selectedCardIndexController.close();
    _firstEditionQtyController.close();
    _unlimitedQtyController.close();
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
      final newQuantity =
          (edition == CardEditionEnum.first ? firstEditionQty : unlimitedQty) +
              1;
      HiveHelper.instance
          .updateCardOwned(
        CardOwnedModel(
          quantity: newQuantity,
          setCode: card.getCardSetsFromSet(currentSet)!.code,
          edition: edition,
          setName: currentSet.setName,
        ),
      )
          .then(
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
        HiveHelper.instance
            .updateCardOwned(
          CardOwnedModel(
            quantity: newQuantity,
            setCode: card.getCardSetsFromSet(currentSet)!.code,
            edition: edition,
            setName: currentSet.setName,
          ),
        )
            .then(
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