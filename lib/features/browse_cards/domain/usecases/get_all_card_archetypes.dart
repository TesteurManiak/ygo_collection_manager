import '../../../../core/usecases/usecase.dart';
import '../entities/archetype.dart';
import '../../../../domain/repositories/ygopro_repository.dart';

class GetAllCardArchetypes implements UseCase<List<Archetype>, NoParams> {
  final YgoProRepository repository;

  GetAllCardArchetypes(this.repository);

  @override
  Future<List<Archetype>> call(_) => repository.getAllCardArchetypes();
}
