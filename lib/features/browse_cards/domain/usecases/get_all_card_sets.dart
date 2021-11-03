import '../../../../core/usecases/usecase.dart';
import '../entities/ygo_set.dart';
import '../../../../domain/repositories/ygopro_repository.dart';

class GetAllCardSets implements UseCase<List<YgoSet>, NoParams> {
  final YgoProRepository repository;

  GetAllCardSets(this.repository);

  @override
  Future<List<YgoSet>> call(_) => repository.getAllSets();
}
