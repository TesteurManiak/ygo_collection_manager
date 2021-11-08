import 'package:hive_flutter/hive_flutter.dart';

import '../../../../core/entities/card_edition_enum.dart';
import '../../../../core/extensions/extensions.dart';
import '../../../../domain/entities/card_banlist_info.dart';
import '../../../../domain/entities/card_images.dart';
import '../../../../domain/entities/card_misc_info.dart';
import '../../../../domain/entities/card_owned.dart';
import '../../../../domain/entities/card_price.dart';
import '../../../../domain/entities/card_set.dart';
import '../../../../domain/entities/db_version.dart';
import '../../../../domain/entities/ygo_card.dart';
import '../../../../domain/entities/ygo_set.dart';
import '../ygopro_local_datasource.dart';

class YgoProLocalDataSourceHive implements YgoProLocalDataSource {
  static const tableDB = 'ygopro_database';
  static const tableCards = 'cards';
  static const tableSets = 'sets';
  static const tableCardsOwned = 'cards_owned';

  late final Box<YgoCard> _cardsBox;
  late final Box<YgoSet> _setsBox;
  late final Box<DbVersion> _dbVersionBox;
  late final Box<CardOwned> _cardsOwnedBox;

  @override
  Future<void> initDb() async {
    await Hive.initFlutter();

    // Register Adapters.
    Hive.registerAdapter(DbVersionAdapter());

    Hive.registerAdapter(YgoCardAdapter());
    Hive.registerAdapter(CardImagesAdapter());
    Hive.registerAdapter(CardSetAdapter());
    Hive.registerAdapter(CardPriceAdapter());
    Hive.registerAdapter(CardBanlistInfoAdapter());
    Hive.registerAdapter(CardMiscInfoAdapter());

    Hive.registerAdapter(YgoSetAdapter());
    // Hive.registerAdapter(CardOwnedModelAdapter());
    Hive.registerAdapter(CardEditionEnumAdapter());

    _cardsBox = await Hive.openBox<YgoCard>(tableCards);
    _setsBox = await Hive.openBox<YgoSet>(tableSets);
    _dbVersionBox = await Hive.openBox<DbVersion>(tableDB);
    _cardsOwnedBox = await Hive.openBox<CardOwned>(tableCardsOwned);
  }

  @override
  Future<List<YgoCard>> getCards() {
    return Future.value(_cardsBox.values.toList());
  }

  @override
  Future<DbVersion?> getDatabaseVersion() {
    if (_dbVersionBox.isEmpty) return Future.value(null);
    return Future.value(_dbVersionBox.values.first);
  }

  @override
  Future<List<YgoSet>> getSets() {
    return Future.value(_setsBox.values.toList());
  }

  @override
  Future<void> updateCards(List<YgoCard> cards) {
    final cardsMap = <int, YgoCard>{};
    for (final card in cards) {
      cardsMap[card.id] = card;
    }
    return _cardsBox.putAll(cardsMap);
  }

  @override
  Future<void> updateDbVersion(DbVersion dbVersion) async {
    final _currentVersion = await getDatabaseVersion();
    if (_currentVersion == null) {
      return _dbVersionBox.put(0, dbVersion);
    } else {
      return _dbVersionBox.putAt(0, dbVersion);
    }
  }

  @override
  Future<void> updateSets(List<YgoSet> sets) {
    final setsMap = <String, YgoSet>{};
    for (final set in sets) {
      setsMap[set.setName] = set;
    }
    return _setsBox.putAll(setsMap);
  }

  @override
  Future<List<CardOwned>> getCardsOwned() {
    return Future.value(
      _cardsOwnedBox.values
          .toList()
          .compactMap<CardOwned>((e) => e.quantity > 0 ? e : null),
    );
  }

  @override
  Future<int> getCopiesOfCardOwned(String key) {
    return Future.value(_cardsOwnedBox.get(key)?.quantity ?? 0);
  }

  @override
  Future<int> getCopiesOfCardOwnedById(int id) async {
    int _quantity = 0;
    final cardsOwned = await getCardsOwned();
    final _cards = cardsOwned.where((card) => card.id == id);
    for (final card in _cards) {
      _quantity += card.quantity;
    }
    return _quantity;
  }

  @override
  Future<void> updateCardOwned(CardOwned card) {
    final keyIndex = _cardsOwnedBox.keys.toList().indexOf(card.key);
    if (keyIndex != -1) return _cardsOwnedBox.putAt(keyIndex, card);
    return _cardsOwnedBox.put(card.key, card);
  }

  @override
  Future<void> removeCard(CardOwned card) {
    return _cardsOwnedBox.delete(card.key);
  }

  @override
  Future<void> closeDb() {
    return Hive.close();
  }
}
