import '../../core/entities/banlist.dart';
import '../../core/entities/format.dart';
import '../../core/entities/link_markers.dart';
import '../../core/entities/sort.dart';
import '../../models/db_version_model.dart';
import '../../models/set_model.dart';
import '../entities/archetype.dart';
import '../entities/card_set_info.dart';
import '../entities/ygo_card.dart';

abstract class YgoProRepository {
  /// Returns all of the current Yu-Gi-Oh! Card Set Names.
  Future<List<SetModel>> getAllSets();
  Future<List<Archetype>> getAllCardArchetypes();

  /// Fetch a filtered [List<YgoCard>] from the API.
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
  });

  /// Fetch a [List<YgoCard>] from the API.
  ///
  /// If a [ServerException] is thrown, the local data will be retried.
  Future<List<YgoCard>> getAllCards();

  /// Returns a [CardSetInfo] for the given [setCode] from the API.
  Future<CardSetInfo> getCardSetInformation(String setCode);

  Future<DBVersionModel> checkDatabaseVersion();

  /// Fetch a random [YgoCard] from the API.
  Future<YgoCard> getRandomCard();
}
