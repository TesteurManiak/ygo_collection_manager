import '../entities/ygo_card.dart';
import '../repository/ygopro_repository.dart';

/// Fetch all cards from the YGOPro API.
class FetchAllCards {
  final YgoProRepository repository;

  FetchAllCards(this.repository);

  Future<List<YgoCard>> call() async {
    final newCards = await repository.getAllCards();
    return newCards;
  }
}
