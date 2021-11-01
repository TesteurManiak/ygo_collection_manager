import 'package:dartz/dartz.dart';

import '../../../../core/entities/banlist.dart';
import '../../../../core/entities/format.dart';
import '../../../../core/entities/link_markers.dart';
import '../../../../core/entities/sort.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/success/success.dart';
import '../entities/archetype.dart';
import '../entities/card_set_info.dart';
import '../entities/ygo_card.dart';
import '../entities/ygo_set.dart';

abstract class YgoProRepository {
  /// Returns all of the current Yu-Gi-Oh! Card Set Names.
  Future<Either<Failure, List<YgoSet>>> getAllSets();
  Future<Either<Failure, List<Archetype>>> getAllCardArchetypes();

  /// Fetch a filtered [List<YgoCard>] from the API.
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
  });

  /// Fetch a [List<YgoCard>] from the API.
  ///
  /// If a [ServerException] is thrown, the local data will be retried.
  Future<Either<Failure, List<YgoCard>>> getAllCards();

  /// Returns a [CardSetInfo] for the given [setCode] from the API.
  Future<Either<Failure, CardSetInfo>> getCardSetInformation(String setCode);

  /// Compare database version on the device with the one on the server. If the
  /// versions are different, the database will be updated.
  Future<Either<Failure, Success>> updateDatabase();

  /// Fetch a random [YgoCard] from the API.
  Future<Either<Failure, YgoCard>> getRandomCard();
}
