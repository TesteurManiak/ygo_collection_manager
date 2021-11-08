import 'package:ygo_collection_manager/domain/entities/ygo_set.dart';
import 'package:ygo_collection_manager/domain/repository/ygopro_repository.dart';

class FetchAllSets {
  final YgoProRepository repository;

  FetchAllSets(this.repository);

  Future<List<YgoSet>> call() async {
    final newSets = await repository.getAllSets();
    newSets.sort((a, b) => a.setName.compareTo(b.setName));
    return newSets;
  }
}
