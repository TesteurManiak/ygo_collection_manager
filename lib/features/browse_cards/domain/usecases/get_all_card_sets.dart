import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/ygo_set.dart';
import '../repositories/ygopro_repository.dart';

class GetAllCardSets implements UseCase<List<YgoSet>, NoParams> {
  final YgoProRepository repository;

  GetAllCardSets(this.repository);

  @override
  Future<Either<Failure, List<YgoSet>>> call(_) => repository.getAllSets();
}
