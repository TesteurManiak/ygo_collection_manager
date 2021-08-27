import 'dart:async';

import 'package:flutter/animation.dart';
import 'package:rxdart/rxdart.dart';
import 'package:ygo_collection_manager/blocs/bloc.dart';
import 'package:ygo_collection_manager/blocs/bloc_provider.dart';
import 'package:ygo_collection_manager/blocs/cards_bloc.dart';
import 'package:ygo_collection_manager/models/card_info_model.dart';
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

  final _cardSetController = BehaviorSubject<SetModel>();
  Stream<SetModel> get onCardSetChanged => _cardSetController.stream;
  SetModel get currentCardSet => _cardSetController.value;
  late final StreamSubscription<SetModel> _cardSetSubscription;

  List<CardInfoModel>? _cards;
  CardInfoModel? get currentCard => _cards?.elementAt(selectedCardIndex);

  void _cardIndexListener(int index) {
    final currentCards = _cards;
    if (currentCards != null) {
      _titleController.sink.add(currentCards[index].name);
    }
  }

  void _cardSetListener(SetModel set) {
    _cards = BlocProvider.master<CardsBloc>().getCardsInSet(set);
  }

  @override
  void initState() {
    _selectedIndexSubscription =
        _selectedCardIndexController.listen(_cardIndexListener);
    _cardSetSubscription = _cardSetController.listen(_cardSetListener);
  }

  @override
  void dispose() {
    _selectedIndexSubscription.cancel();
    _cardSetSubscription.cancel();

    _editionStateController.close();
    _titleController.close();
    _selectedCardIndexController.close();
    _cardSetController.close();
  }

  void setCardsetInUse(SetModel cardSet) =>
      _cardSetController.sink.add(cardSet);

  void switchMode({
    required int cardIndex,
    required AnimationController controller,
  }) =>
      isEditing
          ? disableEditing(controller)
          : enableEditing(
              cardIndex: cardIndex,
              controller: controller,
            );

  void enableEditing({
    required AnimationController controller,
    required int cardIndex,
  }) {
    if (!isEditing) {
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

  void selectCard(int index) => _selectedCardIndexController.sink.add(index);
}
