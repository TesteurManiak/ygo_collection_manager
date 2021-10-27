import '../../../../core/entities/banlist.dart';
import '../../../../core/entities/format.dart';
import '../../../../core/entities/link_markers.dart';
import '../../../../core/entities/sort.dart';
import '../models/archetype_model.dart';
import '../models/card_set_info_model.dart';
import '../models/db_version_model.dart';
import '../models/ygo_card_model.dart';
import '../models/ygo_set_model.dart';

abstract class YgoProRemoteDataSource {
  /// Calls the https://db.ygoprodeck.com/api/v7/cardsets.php endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<List<YgoSetModel>> getAllSets();

  /// Calls the https://db.ygoprodeck.com/api/v7/archetypes.php endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<List<ArchetypeModel>> getAllCardArchetypes();

  /// Calls the https://db.ygoprodeck.com/api/v7/cardinfo.php endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<List<YgoCardModel>> getCardInfo({
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

  /// Calls the https://db.ygoprodeck.com/api/v7/cardinfo.php endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<List<YgoCardModel>> getAllCards() => getCardInfo(misc: true);

  /// Calls the
  /// https://db.ygoprodeck.com/api/v7/cardsetsinfo.php?setcode={setCode}
  /// endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<CardSetInfoModel> getCardSetInformation(String setCode);

  /// Calls the https://db.ygoprodeck.com/api/v7/checkDBVer.php endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<DbVersionModel> getDatabaseVersion();

  /// Calls the https://db.ygoprodeck.com/api/v7/randomcard.php endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<YgoCardModel> getRandomCard();
}
