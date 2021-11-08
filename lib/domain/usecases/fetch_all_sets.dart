import 'package:ygo_collection_manager/domain/entities/ygo_set.dart';
import 'package:ygo_collection_manager/domain/repository/ygopro_repository.dart';

/// Fetch all sets from the YgoPro API.
class FetchAllSets {
  final YgoProRepository repository;

  FetchAllSets(this.repository);

  Future<List<YgoSet>> call() async {
    final newSets = await repository.getAllSets();
    return newSets;
  }
}
