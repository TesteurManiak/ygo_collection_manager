import '../entities/card_owned.dart';
import '../repository/ygopro_repository.dart';

class FetchOwnedCards {
  final YgoProRepository repository;

  FetchOwnedCards(this.repository);

  Future<List<CardOwned>> call() {
    return repository.getOwnedCards();
  }
}
