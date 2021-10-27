import 'package:dartz/dartz.dart';

import '../../../../core/entities/banlist.dart';
import '../../../../core/entities/format.dart';
import '../../../../core/entities/link_markers.dart';
import '../../../../core/entities/sort.dart';
import '../../../../core/error/failures.dart';
import '../entities/archetype.dart';
import '../entities/card_set_info.dart';
import '../entities/ygo_card.dart';
import '../entities/ygo_set.dart';

abstract class YgoProRepository {
  Future<Either<Failure, List<YgoSet>>> getAllSets();
  Future<Either<Failure, List<Archetype>>> getAllCardArchetypes();
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
  Future<Either<Failure, List<YgoCard>>> getAllCards();
  Future<Either<Failure, CardSetInfo>> getCardSetInformation(String setCode);

  /// Compare database version on the device with the one on the server. If the
  /// versions are different, the database will be updated.
  Future<Either<Failure, void>> updateDatabase();
  Future<Either<Failure, YgoCard>> getRandomCard();
}
