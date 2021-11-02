import 'package:hive_flutter/adapters.dart';

part 'card_set.g.dart';

@HiveType(typeId: 4)
class CardSet {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String code;

  @HiveField(2)
  final String rarity;

  @HiveField(3)
  final String rarityCode;

  @HiveField(4)
  final String price;

  CardSet({
    required this.name,
    required this.code,
    required this.rarity,
    required this.rarityCode,
    required this.price,
  });
}
