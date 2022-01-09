part of 'cards_bloc.dart';

enum CardsStatus { initial, loading, loaded, filtered, error }

abstract class CardsState extends BlocState<CardsStatus> {
  const CardsState();
}

class CardsInitial extends CardsState {
  @override
  final status = CardsStatus.initial;

  const CardsInitial();
}

class CardsLoading extends CardsState {
  @override
  final status = CardsStatus.loading;

  const CardsLoading();
}

class CardsLoaded extends CardsState {
  @override
  final status = CardsStatus.loaded;

  final List<YgoCard> cards;

  const CardsLoaded({required this.cards});

  @override
  List<Object?> get props => [status, cards];
}

class CardsFiltered extends CardsState {
  @override
  final status = CardsStatus.filtered;

  final List<YgoCard> cards;
  final List<YgoCard> filteredCards;

  const CardsFiltered({required this.cards, List<YgoCard>? filteredCards})
      : filteredCards = filteredCards ?? cards;

  @override
  List<Object?> get props => [status, cards, filteredCards];
}

class CardsError extends CardsState {
  @override
  final status = CardsStatus.error;

  final String message;

  const CardsError(this.message);

  @override
  List<Object?> get props => [status, message];
}
