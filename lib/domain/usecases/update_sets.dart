import '../entities/ygo_set.dart';
import '../repository/ygopro_repository.dart';

class UpdateSets {
  final YgoProRepository repository;

  UpdateSets(this.repository);

  Future<void> call(List<YgoSet> sets) async {
    return repository.updateSets(sets);
  }
}
