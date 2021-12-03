import '../entities/ygo_set.dart';
import '../repository/ygopro_repository.dart';

/// Fetch all sets from the YgoPro API.
class FetchAllSets {
  final YgoProRepository repository;

  FetchAllSets(this.repository);

  Future<List<YgoSet>> call({required bool shouldReload}) async {
    final newSets = await repository.getAllSets(shouldReload: shouldReload);
    return newSets;
  }
}
