import 'package:dartz/dartz.dart';

import '../../../../core/entities/banlist.dart';
import '../../../../core/entities/format.dart';
import '../../../../core/entities/link_markers.dart';
import '../../../../core/entities/sort.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/archetype.dart';
import '../../domain/entities/card_set_info.dart';
import '../../domain/entities/ygo_card.dart';
import '../../domain/entities/ygo_set.dart';
import '../../domain/repositories/ygopro_repository.dart';
import '../datasources/ygopro_local_data_source.dart';
import '../datasources/ygopro_remote_data_source.dart';

class YgoProRepositoryImpl implements YgoProRepository {
  final YgoProRemoteDataSource remoteDataSource;
  final YgoProLocalDataSource localDataSource;

  YgoProRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, void>> updateDatabase() async {
    try {
      final remoteDbVersion = await remoteDataSource.getDatabaseVersion();
      final localDbVersion = await localDataSource.getDatabaseVersion();

      if (remoteDbVersion != localDbVersion) {
        // TODO: optimize operations
        await localDataSource.updateDbVersion(remoteDbVersion);

        final remoteCards = await remoteDataSource.getAllCards();
        await localDataSource.updateCards(remoteCards);

        final remoteSets = await remoteDataSource.getAllSets();
        await localDataSource.updateSets(remoteSets);
      }
      return const Right(null);
    } on ServerException {
      return Left(ServerFailure());
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, List<Archetype>>> getAllCardArchetypes() {
    // TODO: implement getAllCardArchetypes
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<YgoSet>>> getAllSets() {
    // TODO: implement getAllSets
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<YgoCard>>> getCardInfo({
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
  }) {
    // TODO: implement getCardInfo
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, CardSetInfo>> getCardSetInformation(String setCode) {
    // TODO: implement getCardSetInformation
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, YgoCard>> getRandomCard() {
    // TODO: implement getRandomCard
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<YgoCard>>> getAllCards() {
    throw UnimplementedError();
  }
}
