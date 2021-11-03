import '../../core/entities/banlist.dart';
import '../../core/entities/format.dart';
import '../../core/entities/link_markers.dart';
import '../../core/entities/sort.dart';
import '../../core/network/network_info.dart';
import '../../features/browse_cards/domain/entities/archetype.dart';
import '../../features/browse_cards/domain/entities/card_set_info.dart';
import '../../features/browse_cards/domain/entities/ygo_card.dart';
import '../../features/browse_cards/domain/entities/ygo_set.dart';
import '../../domain/repositories/ygopro_repository.dart';
import '../../features/browse_cards/data/datasources/ygopro_local_data_source.dart';
import '../../features/browse_cards/data/datasources/ygopro_remote_data_source.dart';

class YgoProRepositoryImpl implements YgoProRepository {
  final YgoProRemoteDataSource remoteDataSource;
  final YgoProLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  YgoProRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<void> updateDatabase() async {
    final isConnected = await networkInfo.isConnected;
    if (isConnected) {
      final remoteDbVersion = await remoteDataSource.getDatabaseVersion();
      final localDbVersion = await localDataSource.getDatabaseVersion();

      if (remoteDbVersion != localDbVersion) {
        // TODO: optimize operations with an isolate
        await localDataSource.updateDbVersion(remoteDbVersion);

        final remoteCards = await remoteDataSource.getAllCards();
        await localDataSource.updateCards(remoteCards);

        final remoteSets = await remoteDataSource.getAllSets();
        await localDataSource.updateSets(remoteSets);
      }
    }
  }

  @override
  Future<List<Archetype>> getAllCardArchetypes() async {
    final archetypes = await remoteDataSource.getAllCardArchetypes();
    return archetypes;
  }

  @override
  Future<List<YgoSet>> getAllSets() async {
    final isConnected = await networkInfo.isConnected;
    if (isConnected) {
      final remoteSets = await remoteDataSource.getAllSets();
      return remoteSets;
    } else {
      final localSets = await localDataSource.getSets();
      return localSets;
    }
  }

  @override
  Future<List<YgoCard>> getCardInfo({
    List<String>? names,
    String? fname,
    List<int>? ids,
    List<String>? types,
    int? atk,
    int? def,
    int? level,
    List<String>? races,
    List<String>? attributes,
    int? link,
    List<LinkMarkers>? linkMarkers,
    int? scale,
    String? cardSet,
    String? archetype,
    Banlist? banlist,
    Sort? sort,
    Format? format,
    bool misc = false,
    bool? staple,
    DateTime? startDate,
    DateTime? endDate,
    DateTime? dateRegion,
  }) async {
    final remoteCards = await remoteDataSource.getCardInfo(
      names: names,
      fname: fname,
      ids: ids,
      types: types,
      atk: atk,
      def: def,
      level: level,
      races: races,
      attributes: attributes,
      link: link,
      linkMarkers: linkMarkers,
      scale: scale,
      cardSet: cardSet,
      archetype: archetype,
      banlist: banlist,
      sort: sort,
      format: format,
      misc: misc,
      staple: staple,
      startDate: startDate,
      endDate: endDate,
      dateRegion: dateRegion,
    );
    return remoteCards;
  }

  @override
  Future<CardSetInfo> getCardSetInformation(
    String setCode,
  ) async {
    final cardSetInfo = await remoteDataSource.getCardSetInformation(setCode);
    return cardSetInfo;
  }

  @override
  Future<YgoCard> getRandomCard() async {
    final remoteCard = await remoteDataSource.getRandomCard();
    return remoteCard;
  }

  @override
  Future<List<YgoCard>> getAllCards() async {
    final isConnected = await networkInfo.isConnected;
    if (isConnected) {
      final remoteCards = await remoteDataSource.getAllCards();
      return remoteCards;
    } else {
      final localCards = await localDataSource.getCards();
      return localCards;
    }
  }
}
