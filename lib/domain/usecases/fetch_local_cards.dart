import '../entities/ygo_card.dart';
import '../repository/ygopro_repository.dart';

class FetchLocalCards {
  final YgoProRepository repository;

  FetchLocalCards(this.repository);

  Future<List<YgoCard>> call() {
    return repository.getLocalCards();
  }
}
