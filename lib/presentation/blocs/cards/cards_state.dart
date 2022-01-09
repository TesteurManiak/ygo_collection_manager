part of 'cards_bloc.dart';

enum CardsStatus { initial, loading, loaded, error }

abstract class CardsState extends BlocState<CardsStatus> {
  const CardsState();
}

class CardsInitial extends CardsState {
  @override
  final CardsStatus status;

  const CardsInitial() : status = CardsStatus.initial;
}

class CardsLoading extends CardsState {
  @override
  final CardsStatus status;

  const CardsLoading() : status = CardsStatus.loading;
}

class CardsLoaded extends CardsState {
  @override
  final CardsStatus status;

  final List<YgoCard> cards;
  final List<YgoCard> filteredCards;

  const CardsLoaded({
    required this.cards,
    List<YgoCard>? filteredCards,
  })  : status = CardsStatus.loaded,
        filteredCards = filteredCards ?? cards;

  @override
  List<Object?> get props => [status, cards, filteredCards];
}

class CardsError extends CardsState {
  @override
  final CardsStatus status;

  final String message;

  const CardsError(this.message) : status = CardsStatus.error;

  @override
  List<Object?> get props => [status, message];
}
