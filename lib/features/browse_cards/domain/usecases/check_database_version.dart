import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/db_version.dart';
import '../repositories/ygopro_repository.dart';

class CheckDatabaseVersion implements UseCase<DbVersion, NoParams> {
  final YgoProRepository repository;

  CheckDatabaseVersion(this.repository);

  @override
  Future<Either<Failure, DbVersion>> call(_) =>
      repository.checkDatabaseVersion();
}
