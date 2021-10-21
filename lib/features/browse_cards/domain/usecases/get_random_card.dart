import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/ygo_card.dart';
import '../repositories/ygopro_repository.dart';

class GetRandomCard implements UseCase<YgoCard, NoParams> {
  final YgoProRepository repository;

  GetRandomCard(this.repository);

  @override
  Future<Either<Failure, YgoCard>> call(_) => repository.getRandomCard();
}
