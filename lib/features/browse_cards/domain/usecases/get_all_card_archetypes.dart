import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/archetype.dart';
import '../../../../domain/repositories/ygopro_repository.dart';

class GetAllCardArchetypes implements UseCase<List<Archetype>, NoParams> {
  final YgoProRepository repository;

  GetAllCardArchetypes(this.repository);

  @override
  Future<Either<Failure, List<Archetype>>> call(_) =>
      repository.getAllCardArchetypes();
}
