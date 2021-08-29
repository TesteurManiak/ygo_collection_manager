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

  CardInfoModel? _currentCard;
  CardInfoModel? get currentCard => _currentCard;

  void _cardIndexListener(int index) {
    if (_currentCard != null) {
      _titleController.sink.add(_currentCard!.name);
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

  void enableEditing({
    required AnimationController controller,
    required int cardIndex,
    required CardInfoModel card,
  }) {
    if (!isEditing) {
      _currentCard = card;
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

  void selectCard(int index, CardInfoModel card) {
    _currentCard = card;
    _selectedCardIndexController.sink.add(index);
  }
}
