import 'package:dartz/dartz.dart';

import '../../../../core/entities/banlist.dart';
import '../../../../core/entities/format.dart';
import '../../../../core/entities/link_markers.dart';
import '../../../../core/entities/sort.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/success/success.dart';
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
  final NetworkInfo networkInfo;

  YgoProRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, Success>> updateDatabase() async {
    try {
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
      return const Right(Success());
    } on ServerException {
      return Left(ServerFailure());
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, List<Archetype>>> getAllCardArchetypes() async {
    try {
      final archetypes = await remoteDataSource.getAllCardArchetypes();
      return Right(archetypes);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<YgoSet>>> getAllSets() async {
    try {
      final isConnected = await networkInfo.isConnected;
      if (isConnected) {
        final remoteSets = await remoteDataSource.getAllSets();
        return Right(remoteSets);
      } else {
        final localSets = await localDataSource.getSets();
        return Right(localSets);
      }
    } on ServerException {
      return Left(ServerFailure());
    } on CacheException {
      return Left(CacheFailure());
    }
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
  }) async {
    try {
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
      return Right(remoteCards);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, CardSetInfo>> getCardSetInformation(
    String setCode,
  ) async {
    try {
      final cardSetInfo = await remoteDataSource.getCardSetInformation(setCode);
      return Right(cardSetInfo);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, YgoCard>> getRandomCard() async {
    try {
      final remoteCard = await remoteDataSource.getRandomCard();
      return Right(remoteCard);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<YgoCard>>> getAllCards() async {
    try {
      final isConnected = await networkInfo.isConnected;
      if (isConnected) {
        final remoteCards = await remoteDataSource.getAllCards();
        return Right(remoteCards);
      } else {
        final localCards = await localDataSource.getCards();
        return Right(localCards);
      }
    } on ServerException {
      return Left(ServerFailure());
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
