import '../../../../core/usecases/usecase.dart';
import '../../../../domain/repository/ygopro_repository.dart';
import '../entities/card_set_info.dart';

class GetCardSetInformation
    implements UseCase<CardSetInfo, GetCardSetInformationParams> {
  final YgoProRepository repository;

  GetCardSetInformation(this.repository);

  @override
  Future<CardSetInfo> call(GetCardSetInformationParams params) =>
      repository.getCardSetInformation(params.setCode);
}

class GetCardSetInformationParams {
  final String setCode;

  GetCardSetInformationParams({required this.setCode});
}
