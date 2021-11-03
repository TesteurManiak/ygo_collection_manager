import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../domain/repositories/ygopro_repository.dart';

class UpdateDatabase implements UseCase<void, NoParams> {
  final YgoProRepository repository;

  UpdateDatabase(this.repository);

  @override
  Future<Either<Failure, void>> call(_) => repository.updateDatabase();
}
