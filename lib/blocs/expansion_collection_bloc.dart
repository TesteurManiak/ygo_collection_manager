import 'dart:async';

import 'package:flutter/animation.dart';
import 'package:rxdart/rxdart.dart';
import 'package:ygo_collection_manager/blocs/bloc.dart';
import 'package:ygo_collection_manager/models/card_info_model.dart';

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

  List<CardInfoModel>? _cards;

  void _cardIndexListener(int index) {
    final currentCards = _cards;
    if (currentCards != null) {
      _titleController.sink.add(currentCards[index].name);
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
  }

  void switchMode({
    required int cardIndex,
    required List<CardInfoModel> cards,
    required AnimationController controller,
  }) =>
      isEditing
          ? disableEditing(controller)
          : enableEditing(
              cardIndex: cardIndex,
              cards: cards,
              controller: controller,
            );

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

  void selectCard(int index) => _selectedCardIndexController.sink.add(index);
}
