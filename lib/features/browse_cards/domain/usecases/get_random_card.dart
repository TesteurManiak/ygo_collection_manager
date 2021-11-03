import '../../../../core/usecases/usecase.dart';
import '../entities/ygo_card.dart';
import '../../../../domain/repositories/ygopro_repository.dart';

class GetRandomCard implements UseCase<YgoCard, NoParams> {
  final YgoProRepository repository;

  GetRandomCard(this.repository);

  @override
  Future<YgoCard> call(_) => repository.getRandomCard();
}
