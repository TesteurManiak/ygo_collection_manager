import '../../../../core/usecases/usecase.dart';
import '../../../../domain/repositories/ygopro_repository.dart';

class UpdateDatabase implements UseCase<void, NoParams> {
  final YgoProRepository repository;

  UpdateDatabase(this.repository);

  @override
  Future<void> call(_) => repository.updateDatabase();
}
