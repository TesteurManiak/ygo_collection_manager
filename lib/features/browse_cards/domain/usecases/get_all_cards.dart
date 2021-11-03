import '../../../../core/usecases/usecase.dart';
import '../../../../domain/repository/ygopro_repository.dart';
import '../entities/ygo_card.dart';

/// This use case is used to get the all card details from the repository.
class GetAllCards implements UseCase<List<YgoCard>, NoParams> {
  final YgoProRepository repository;

  GetAllCards(this.repository);

  @override
  Future<List<YgoCard>> call(_) => repository.getAllCards();
}
