import '../repository/ygopro_repository.dart';

class ShouldReloadDb {
  final YgoProRepository repository;

  ShouldReloadDb(this.repository);

  Future<bool> call() {
    return repository.shouldReloadDb();
  }
}
