import 'package:ygo_collection_manager/domain/entities/card_owned.dart';
import 'package:ygo_collection_manager/domain/repository/ygopro_repository.dart';

class UpdateCardOwned {
  final YgoProRepository repository;

  UpdateCardOwned(this.repository);

  Future<void> call(CardOwned card) {
    return repository.updateCardOwned(card);
  }
}
