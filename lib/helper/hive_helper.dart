import 'package:hive_flutter/hive_flutter.dart';
import 'package:ygo_collection_manager/models/card_info_model.dart';
import 'package:ygo_collection_manager/models/db_version_model.dart';
import 'package:ygo_collection_manager/models/set_model.dart';
import 'package:ygo_collection_manager/utils/indexes.dart';

class HiveHelper {
  bool _isInitialized = false;

  HiveHelper._();

  static final instance = HiveHelper._();

  /// Initialize Hive instance and open its boxes.
  Future<void> initHive() async {
    if (!instance._isInitialized) {
      await Hive.initFlutter();

      // Register Adapters.
      Hive.registerAdapter(DBVersionModelAdapter());
      Hive.registerAdapter(CardImagesAdapter());
      Hive.registerAdapter(CardInfoModelAdapter());
      Hive.registerAdapter(SetModelAdapter());
      Hive.registerAdapter(CardModelSetAdapter());

      await Hive.openBox<DBVersionModel>(Indexes.tableDB);
      await Hive.openBox<CardInfoModel>(Indexes.tableCards);
      await Hive.openBox<SetModel>(Indexes.tableSets);
      instance._isInitialized = true;
    }
  }

  DBVersionModel? get databaseVersion {
    final box = Hive.box<DBVersionModel>(Indexes.tableDB);
    if (box.values.isEmpty) return null;
    return box.getAt(0);
  }

  Future<void> updateDatabaseVersion(DBVersionModel version) {
    final box = Hive.box<DBVersionModel>(Indexes.tableDB);
    if (databaseVersion == null) {
      return box.put(0, version);
    } else {
      return box.putAt(0, version);
    }
  }

  Iterable<CardInfoModel> get cards {
    final box = Hive.box<CardInfoModel>(Indexes.tableCards);
    return box.values;
  }

  Future<void> updateCards(List<CardInfoModel> cards) {
    final box = Hive.box<CardInfoModel>(Indexes.tableCards);
    final cardsMap = <int, CardInfoModel>{};
    for (final card in cards) {
      cardsMap[card.id] = card;
    }
    return box.putAll(cardsMap);
  }

  Iterable<SetModel> get sets {
    final box = Hive.box<SetModel>(Indexes.tableSets);
    return box.values;
  }

  Future<void> updateSets(List<SetModel> sets) {
    final box = Hive.box<SetModel>(Indexes.tableSets);
    final setsMap = <String, SetModel>{};
    for (final set in sets) {
      setsMap[set.setCode] = set;
    }
    return box.putAll(setsMap);
  }

  Future<void> dispose() => Hive.close();
}
