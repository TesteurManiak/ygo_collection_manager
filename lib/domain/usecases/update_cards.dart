import '../entities/ygo_card.dart';
import '../repository/ygopro_repository.dart';

class UpdateCards {
  final YgoProRepository repository;

  UpdateCards(this.repository);

  Future<void> call(List<YgoCard> cards) async {
    await repository.updateCards(cards);
  }
}
