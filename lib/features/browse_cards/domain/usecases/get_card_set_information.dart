import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/card_set_info.dart';
import '../../../../domain/repositories/ygopro_repository.dart';

class GetCardSetInformation
    implements UseCase<CardSetInfo, GetCardSetInformationParams> {
  final YgoProRepository repository;

  GetCardSetInformation(this.repository);

  @override
  Future<Either<Failure, CardSetInfo>> call(
    GetCardSetInformationParams params,
  ) =>
      repository.getCardSetInformation(params.setCode);
}

class GetCardSetInformationParams {
  final String setCode;

  GetCardSetInformationParams({required this.setCode});
}
