import '../entities/ygo_card.dart';
import '../repository/ygopro_repository.dart';

/// Fetch all cards from the YGOPro API and sort them by name.
class FetchAllCards {
  final YgoProRepository repository;

  FetchAllCards(this.repository);

  Future<List<YgoCard>> call() async {
    final newCards = await repository.getAllCards();
    newCards.sort((a, b) => a.name.compareTo(b.name));
    return newCards;
  }
}
