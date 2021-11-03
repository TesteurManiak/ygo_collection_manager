import '../../../../core/usecases/usecase.dart';
import '../../../../domain/repository/ygopro_repository.dart';
import '../entities/ygo_card.dart';

class GetRandomCard implements UseCase<YgoCard, NoParams> {
  final YgoProRepository repository;

  GetRandomCard(this.repository);

  @override
  Future<YgoCard> call(_) => repository.getRandomCard();
}
