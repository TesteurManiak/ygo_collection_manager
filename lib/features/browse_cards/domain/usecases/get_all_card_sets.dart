import '../../../../core/usecases/usecase.dart';
import '../../../../domain/repository/ygopro_repository.dart';
import '../entities/ygo_set.dart';

class GetAllCardSets implements UseCase<List<YgoSet>, NoParams> {
  final YgoProRepository repository;

  GetAllCardSets(this.repository);

  @override
  Future<List<YgoSet>> call(_) => repository.getAllSets();
}
