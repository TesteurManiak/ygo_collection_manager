import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/archetype.dart';
import '../entities/card_set_info.dart';
import '../entities/db_version.dart';
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
    bool misc = false,
  });
  Future<Either<Failure, CardSetInfo>> getCardSetInformation(String setCode);
  Future<Either<Failure, DbVersion>> checkDatabaseVersion();
  Future<Either<Failure, YgoCard>> getRandomCard();
}
