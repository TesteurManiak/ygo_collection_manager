import 'package:ygo_collection_manager/domain/repository/ygopro_repository.dart';

class ShouldReloadDb {
  final YgoProRepository repository;

  ShouldReloadDb(this.repository);

  Future<bool> call() {
    return repository.shouldReloadDb();
  }
}
