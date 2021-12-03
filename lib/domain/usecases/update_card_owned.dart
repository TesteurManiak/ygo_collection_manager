import '../entities/card_owned.dart';
import '../repository/ygopro_repository.dart';

class UpdateCardOwned {
  final YgoProRepository repository;

  UpdateCardOwned(this.repository);

  Future<void> call(CardOwned card) {
    return repository.updateCardOwned(card);
  }
}
