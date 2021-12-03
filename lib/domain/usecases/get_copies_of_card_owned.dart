import '../repository/ygopro_repository.dart';

class GetCopiesOfCardOwned {
  final YgoProRepository repository;

  GetCopiesOfCardOwned(this.repository);

  Future<int> call(String cardId) {
    return repository.getCopiesOfCardOwned(cardId);
  }
}
