import '../../domain/entities/card_owned.dart';
import '../../domain/entities/card_set_info.dart';
import '../../domain/entities/db_version.dart';
import '../../domain/entities/ygo_card.dart';
import '../../domain/entities/ygo_set.dart';
import '../../domain/repository/ygopro_repository.dart';
import '../datasources/local/ygopro_local_datasource.dart';
import '../datasources/remote/ygopro_remote_data_source.dart';
import '../models/request/get_card_info_request.dart';

class YgoProRepositoryImpl implements YgoProRepository {
  final YgoProRemoteDataSource remoteDataSource;
  final YgoProLocalDataSource localDataSource;

  YgoProRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<List<YgoSet>> getAllSets() async {
    final remoteSets = await remoteDataSource.getAllSets();
    return remoteSets;
  }

  @override
  Future<CardSetInfo> getCardSetInformation(String setCode) =>
      remoteDataSource.getCardSetInformation(setCode);

  @override
  Future<YgoCard> getRandomCard() => remoteDataSource.getRandomCard();

  @override
  Future<List<YgoCard>> getAllCards() =>
      remoteDataSource.getCardInfo(GetCardInfoRequest(misc: true));

  @override
  Future<DbVersion> checkDatabaseVersion() =>
      remoteDataSource.checkDatabaseVersion();

  @override
  Future<List<CardOwned>> getOwnedCards() => localDataSource.getCardsOwned();

  @override
  Future<List<YgoCard>> getLocalCards() async {
    final cards = await localDataSource.getCards();
    cards.sort((a, b) => a.name.compareTo(b.name));
    return cards;
  }

  @override
  Future<void> updateCards(List<YgoCard> cards) =>
      localDataSource.updateCards(cards);

  @override
  Future<bool> shouldReloadDb() async {
    final savedDbVersion = await localDataSource.getDatabaseVersion();
    final fetchedDbVersion = await remoteDataSource.checkDatabaseVersion();

    final shouldReload = savedDbVersion == null ||
        savedDbVersion.version != fetchedDbVersion.version;
    if (shouldReload) {
      await localDataSource.updateDbVersion(fetchedDbVersion);
    }
    return shouldReload;
  }

  @override
  Future<int> getCopiesOfCardOwned(String key) =>
      localDataSource.getCopiesOfCardOwned(key);

  @override
  Future<void> updateCardOwned(CardOwned card) =>
      localDataSource.updateCardOwned(card);

  @override
  Future<List<YgoSet>> getLocalSets() => localDataSource.getSets();

  @override
  Future<void> updateSets(List<YgoSet> sets) =>
      localDataSource.updateSets(sets);
}
