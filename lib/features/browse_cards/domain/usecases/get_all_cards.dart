import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/ygo_card.dart';
import '../repositories/ygopro_repository.dart';

/// This use case is used to get the all card details from the repository.
class GetAllCards implements UseCase<List<YgoCard>, NoParams> {
  final YgoProRepository repository;

  GetAllCards(this.repository);

  @override
  Future<Either<Failure, List<YgoCard>>> call(_) => repository.getAllCards();
}
