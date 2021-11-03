import '../../../../core/usecases/usecase.dart';
import '../../../../domain/repository/ygopro_repository.dart';
import '../entities/archetype.dart';

class GetAllCardArchetypes implements UseCase<List<Archetype>, NoParams> {
  final YgoProRepository repository;

  GetAllCardArchetypes(this.repository);

  @override
  Future<List<Archetype>> call(_) => repository.getAllCardArchetypes();
}
